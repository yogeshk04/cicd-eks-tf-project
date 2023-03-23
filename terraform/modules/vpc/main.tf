resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  tags       = var.tags
}

resource "aws_subnet" "public" {
  for_each = { for i in range(length(var.public_subnet_cidr_blocks)) : i => var.public_subnet_cidr_blocks[i] }

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value
  availability_zone = var.avail_zones[each.key]
  tags = {
    Name = "TF-Community-${var.infra_env}-public_subnet-1"
  }
}

resource "aws_subnet" "private" {
  for_each = { for i in range(length(var.private_subnet_cidr_blocks)) : i => var.private_subnet_cidr_blocks[i] }

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value
  availability_zone = var.avail_zones[each.key]
  tags = {
    Name = "TF-Community-${var.infra_env}-private_subnet-1"
  }
}

# Internet Gateway (IGW)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "TF-Community-${var.infra_env}-igw"
  }
}

# NAT Gateway (NGW)
resource "aws_eip" "nat" {
  vpc = true
  tags = {
    Name = "TF-Community-${var.infra_env}-nat"
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.private.id
  tags = {
    Name = "TF-Community-${var.infra_env}-ngw"
  }
}

# Route Tables and Routes

# Pubic Route table subnet with IGW
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "TF-Community-${var.infra_env}-pubic-rt"
  }
}

# Private Route Table subnet with NGW
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "TF-Community-${var.infra_env}-private-rt"
  }
}

# Public route
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Private route
resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.ngw.id
}

# Public route to public route table for public subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route.public.id
}

# Private route to private route table for private subnet
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route.private.id
}

resource "aws_default_route_table" "main-rtb" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "TF-Community-${var.infra_env}-main-rtb"
  }
}

resource "aws_default_security_group" "default-sg" {
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "TF-Community-${var.infra_env}-default-sg"
  }
}
