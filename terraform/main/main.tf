module "vpc" {
  source = "../modules/vpc"
}

module "ec2" {
  source        = "../modules/ec2"
  public_subnet = module.vpc.public_subnet
  depends_on = [
    module.vpc
  ]
}
