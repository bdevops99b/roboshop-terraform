env = "dev"
bastion_cidr = ["172.31.5.46/32"]
default_vpc_id = "vpc-08830dc8e86b4da62"
default_vpc_cidr = "172.31.0.0/16"
default_vpc_rtid = "rtb-0b205a0c9eceb19c4"
kms_arn = "arn:aws:kms:us-east-1:808521593429:key/0e9d2058-45b4-40b9-8eb3-677118252e17"
vpc = {
  main = {
    cidr_block = "10.0.0.0/16"
    subnets = {
      public = {
        name = "public"
        cidr_block = ["10.0.0.0/24", "10.0.1.0/24"]
        azs = ["us-east-1a", "us-east-1b"]
      }
      web = {
        name = "web"
        cidr_block = ["10.0.2.0/24", "10.0.3.0/24"]
        azs = ["us-east-1a", "us-east-1b"]
      }
      app = {
        name = "app"
        cidr_block = ["10.0.4.0/24", "10.0.5.0/24"]
        azs = ["us-east-1a", "us-east-1b"]
      }
      db = {
        name = "db"
        cidr_block = ["10.0.6.0/24", "10.0.7.0/24"]
        azs = ["us-east-1a", "us-east-1b"]
      }
    }

  }
}

app = {
  frontend = {
    name = "frontend"
    instance_type = "t3.micro"
    subnet_name = "web"
    allow_app_cidr = "public"
    desired_capacity   = 2
    max_size           = 10
    min_size           = 2

  }
  catalogue = {
    name = "catalogue"
    instance_type = "t3.small"
    subnet_name = "app"
    allow_app_cidr = "web"
    desired_capacity   = 2
    max_size           = 10
    min_size           = 2
  }
#  user = {
#    name = "user"
#    instance_type = "t3.small"
#    subnet_name = "app"
#    desired_capacity   = 2
#    max_size           = 10
#    min_size           = 2
#  }
#  cart = {
#    name = "catalogue"
#    instance_type = "t3.small"
#    subnet_name = "app"
#    desired_capacity   = 2
#    max_size           = 10
#    min_size           = 2
#  }
#  shipping = {
#    name = "catalogue"
#    instance_type = "t3.small"
#    subnet_name = "app"
#    desired_capacity   = 2
#    max_size           = 10
#    min_size           = 2
#  }
#  payment = {
#    name = "catalogue"
#    instance_type = "t3.small"
#    subnet_name = "app"
#    desired_capacity   = 2
#    max_size           = 10
#    min_size           = 2
#  }

}
#variable "tags" {}
#variable "subnets" {}
#variable "env" {}
#variable "name" {
#  default = "docdb"
#}
#variable "vpc_id" {}
#variable "allow_app_cidr" {}
#variable "engine_version" {}
#variable "kms_arn" {}
#variable "port_no" {
#  default = 27017
#}

docdb = {
  main = {
    subnet_name    = "db"
    allow_db_cidr  = "app"
    engine_version = "4.0.0"
    instance_count = 1
    instance_class = "db.t3.medium"
  }
}

rds = {
  main = {
    subnet_name    = "db"
    allow_db_cidr  = "app"
    engine_version = "5.7.mysql_aurora.2.11.2"
    instance_count = 1
    instance_class = "db.t3.small"
  }
}