output "vpc" {
  value = lookup(lookup(module.vpc, "main", null), "subnets", null)
}