terraform {
  backend "s3" {
    bucket = "terraform-state-EBS-Deployment-Project"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

module "IAM" {
    source = "./IAM"
}

module "s3" {
    source = "./s3"
}

module "VPC" {
    source = "./VPC"
}

module "ebs" {
    source = "./EBS"
    s3_bucket = module.s3.s3_bucket
    s3_key = module.s3.s3_key
    instance_profile = module.IAM.instance_profile
    vpc_id = module.VPC.vpc_id
    subnet_id = module.VPC.subnet_id
}