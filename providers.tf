
terraform {
  required_version = "~> 1.0"
  required_providers {
    # kubectl = {
    #   source  = "gavinbunney/kubectl"
    #   version = ">= 1.14.0"
    # }
    helm = {
       source  = "hashicorp/helm"
       version = ">= 2.13.0"
     }
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
  region = "sa-east-1"
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--profile", "labs", "--cluster-name", module.eks.cluster_name]
      command     = "aws"
    }
  }
}