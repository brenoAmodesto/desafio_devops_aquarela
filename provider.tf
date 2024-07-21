
terraform {
  required_version = "~> 1.0"
  required_providers {
    # kubectl = {
    #   source  = "gavinbunney/kubectl"
    #   version = ">= 1.14.0"
    # }
    # helm = {
    #   source  = "hashicorp/helm"
    #   version = ">= 2.6.0"
    # }
    aws = {
      source  = "hashicorp/aws"
      version = "5.59.0"
    }
  }

  backend "s3" {
    bucket = "lab-bucket-br"
    key    = "terraform.tfstate"
    region = "us-east-1"
    #encrypt        = true
    ##dynamodb_table = "terraform-state-lock"  # 
  }

}


provider "aws" {
  region = var.aws_region

}