terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0"
    }
  }
}

provider "aws" {
    alias = "us-east-1"
    region = "us-east-1"  
}

provider "aws" {
    alias = "us-west-2"
    region = "us-west-2"  
}
