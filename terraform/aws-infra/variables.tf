variable "region" {
  default = "ap-southeast-2" # Sydney
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
