module "vpc" {
  source = "git::https://github.com/bdevops99b/tf-module-vpc.git"
  for_each = var.vpc
  cidr_block  = each.value["cidr_block"]
  subnets = each.value["subnets"]
  tags = local.tags
  env = var.env
}
output "vpc" {
  value = module.vpc
}

