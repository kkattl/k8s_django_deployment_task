terraform {
  required_version = ">= 1.2.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket = "kkattl-k8s-terraform-state-bucket"
    key    = "k8s_django_deployment_task/terraform.tfstate"
    region = var.region
  }
}

provider "aws" {
  region = var.region
}
