locals {
  vpc_id = lookup(lookup(module.vpc, "main", null), "vpc_id", null)
  tags   = {
    business_unit = "ecommerce"
    business_type = "retails"
    project       = "roboshop"
    costcenter    = 200
    env           = var.env

  }
}