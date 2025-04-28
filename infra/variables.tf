variable "account" {
  description = "AWS account"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "bucket" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "ecr_repo_name" {
  description = "Name of the ECR repository"
  type        = string
}