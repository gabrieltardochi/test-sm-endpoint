terraform {
  backend "s3" {
    bucket = "test-sm-endpoint-tf-247599465422"
    key    = "infra"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.67.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      ManagedBy = "terraform",
      Project   = "test-sm-endpoint"
    }
  }
}