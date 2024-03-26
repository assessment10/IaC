terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.4.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-lw"
    key            = "terraform/state/file"
    region         = "ap-southeast-1"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
