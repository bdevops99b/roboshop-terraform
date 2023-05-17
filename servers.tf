module "database-servers" {
  for_each =  var.database_servers
  source = "./module"
  component_name =  each.value["name"]
  env            =  var.env
  instance_type  =  each.value["instance_type"]
  password       =  lookup(each.value, "password", "null")
  provisioner    = true
  app_type = "db"
}

module "app-servers" {
  for_each =  var.app_servers
  depends_on = [module.database-servers]
  source = "./module"
  component_name =  each.value["name"]
  env            =  var.env
  instance_type  =  each.value["instance_type"]
  password       =  lookup(each.value, "password", "null")
  provisioner    = true
  app_type = "app"
}
