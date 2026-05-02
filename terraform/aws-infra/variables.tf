variable "region" {
  description = "The AWS region to deploy the platform foundations"
  type        = string
  default     = "ap-southeast-2" 
}

variable "environment_name" {
  description = "The name of the environment or organization"
  type        = string
  default     = "platform-foundation"
}

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}
