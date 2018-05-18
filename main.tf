provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "eu-west-1"
}

# create IAM user, groups and policies
module "iam_user" {
  source                  = "modules/iam_user"
  name                    = "admin-user"
  security_group          = "admin-users1"
  password_reset_required = false
}

# Create VPC and one Public Subnet

module "vpc" {
    source             = "modules/vpc"
    vpc_cidr           = "10.1.0.0/16"
    public_subnet_cidr = "10.1.1.0/24"
    vpc_tag            = "Project_VPC"
    availability_zone  = "eu-west-1a"
}

# Create a security group for web server

module "security_group" {
    source = "modules/security_group"
    name   = "WebSG"
    vpc_id = "${module.vpc.vpc_id}"
}