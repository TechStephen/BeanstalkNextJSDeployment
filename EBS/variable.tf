variable "s3_bucket" {
    description = "The name of the S3 bucket to store the archived app"
    type = string
}

variable "s3_key" {
    description = "The key of the S3 object to store the archived app"
    type = string
}

variable "instance_profile" {
    description = "The instance profile to attach to the EBS instances"
    type = string
}

variable "vpc_id" {
    description = "The VPC ID to deploy the EBS instances"
    type = string
}

variable "subnet_id" {
    description = "The Subnet ID to deploy the EBS instances"
    type = string
}