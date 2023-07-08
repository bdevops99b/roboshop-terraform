env = "dev"
monitor_cidr = ["172.31.80.236/32"]
bastion_cidr = ["1172.31.86.195/32"]
default_vpc_id = "vpc-0031a3556931f8c23"
default_vpc_cidr = "172.31.0.0/16"
default_vpc_rtid = "rtb-0b759e2fd83da83c7"
domain_name      = "panda4u.online"
domain_id        = "Z07261131TWTABGF77UVC"
kms_arn = "arn:aws:kms:us-east-1:193400300103:key/4577942f-9fbc-4247-84f6-e31cdf26ac63"
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
    name              = "frontend"
    instance_type     = "t3.small"
    subnet_name       = "web"
    allow_app_cidr    = "public"
    desired_capacity  = 1
    max_size          = 10
    min_size          = 1
    app_port          = 80
    listener_priority = 1
    lb_type           = "public"
    dns_name          = "dev"
    parameters        = []
  }
  catalogue = {
    name              = "catalogue"
    instance_type     = "t3.small"
    subnet_name       = "app"
    allow_app_cidr    = "app"
    desired_capacity  = 1
    max_size          = 10
    min_size          = 1
    app_port          = 8080
    listener_priority = 1
    lb_type           = "private"
    parameters        = ["docdb"]
  }
  user = {
    name              = "user"
    instance_type     = "t3.small"
    subnet_name       = "app"
    allow_app_cidr    = "app"
    desired_capacity  = 1
    max_size          = 10
    min_size          = 1
    app_port          = 8080
    listener_priority = 2
    lb_type           = "private"
    parameters        = ["docdb"]
  }
  cart = {
    name              = "cart"
    instance_type     = "t3.small"
    subnet_name       = "app"
    allow_app_cidr    = "app"
    desired_capacity  = 1
    max_size          = 10
    min_size          = 1
    app_port          = 8080
    listener_priority = 3
    lb_type           = "private"
    parameters        = []
  }
  shipping = {
    name              = "shipping"
    instance_type     = "t3.small"
    subnet_name       = "app"
    allow_app_cidr    = "app"
    desired_capacity  = 1
    max_size          = 10
    min_size          = 1
    app_port          = 8080
    listener_priority = 4
    lb_type           = "private"
    parameters        = ["rds"]
  }
  payment = {
    name              = "payment"
    instance_type     = "t3.small"
    subnet_name       = "app"
    allow_app_cidr    = "app"
    desired_capacity  = 1
    max_size          = 10
    min_size          = 1
    app_port          = 8080
    listener_priority = 5
    lb_type           = "private"
    parameters        = []
  }
}
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

elasticache = {
  main = {
    subnet_name             = "db"
    allow_db_cidr           = "app"
    engine_version          = "6.x"
    replicas_per_node_group = 1
    num_node_groups         = 1
    node_type               = "cache.t3.micro"
  }
}
rabbitmq = {
  main = {
    subnet_name   = "db"
    allow_db_cidr = "app"
    instance_type = "t3.small"
  }
}

alb = {
  public = {
    name           = "public"
    subnet_name    = "public"
    allow_alb_cidr = null
    internal       = false
  }
  private = {
    name           = "private"
    subnet_name    = "app"
    allow_alb_cidr = "web"
    internal       = true
  }
}

