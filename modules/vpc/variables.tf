variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default     = "10.0.0.0/24"
}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default     = "eu-west-1"
}

variable "vpc_tag" {
    description = "AWS VPC tag"
}

variable "availability_zone" {
    description = "AWS availability zone for VPC subnets"
}