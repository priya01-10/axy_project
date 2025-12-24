module "vpc" {
  source = "./vpc"

  vpc_cidr             = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  
}

module "rds" {
  source = "./rds"

  name = "axy"
  vpc_id              = module.vpc.vpc_id
  private_subnet_ids  = module.vpc.private_subnet_ids

  db_name  = "appdb"
  username = "appuser"
}

