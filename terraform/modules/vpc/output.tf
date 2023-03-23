output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "public_subnet" {
  value = aws_subnet.public.id
}

output "private_subnet" {
  value = aws_subnet.private.id
}

output "aws_default_security_group" {
  value = aws_default_security_group.default-sg.id
}
