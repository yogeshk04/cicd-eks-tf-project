infra_env = "dev"

tags = {
  Name        = "TF-community-${var.infra_env}-ngw"
  Project     = "TF-community"
  Environment = var.infra_env
  VPC         = aws_vpc.vpc.id
  ManagedBy   = "terraform"
  Role        = "private"
}

vpc_cidr_block      = "10.0.0.0/16"
public_subnet_cidr  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidr = ["10.0.3.0/24", "10.0.4.0/24"]
avail_zones         = ["eu-central-1a", "eu-central-1b"]
instance_type       = "t2.micro"


vpc_security_group_ids = [module.vpc.aws_default_security_group.id]


