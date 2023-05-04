terraform {
  backend "s3" {
    bucket = "breddy99"
    key    = "roboshop/dev/terraform.tfstate"
    region = "us-east-1"
  }
}
