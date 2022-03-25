variable "region" {
  default     = "us-east-2"
  description = "AWS region"
}

provider "aws" {
  region = var.region
}

terraform {
    backend "s3"{
        bucket ="remotebackenddemobucket"
        key = "myfiles/terraform.tfstate"
        region= "us-east-2"
    }
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = "my-eks-11"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  name                 = "myvpc"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

}
