# HUB VPC (Shared Services & Security)
resource "aws_vpc" "hub" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags                 = { Name = "arlo-vpc-hub" }
}

resource "aws_subnet" "shared_services" {
  vpc_id            = aws_vpc.hub.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.region}a"
  tags              = { Name = "arlo-subnet-shared" }
}

# DEV & PROD SPOKE VPCS
resource "aws_vpc" "dev" {
  cidr_block = "10.1.0.0/16"
  tags       = { Name = "arlo-vpc-dev" }
}

resource "aws_vpc" "prod" {
  cidr_block = "10.2.0.0/16"
  tags       = { Name = "arlo-vpc-prod" }
}

# SECURITY-BY-DESIGN (Arlo JD Highlight)
resource "aws_secretsmanager_secret" "db_creds" {
  name        = "prod/platform/db-credentials"
  description = "Managed via Terraform - Path to Production"
}

resource "aws_iam_role" "platform_engineer" {
  name = "ArloPlatformEngineeringRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "://amazonaws.com" }
    }]
  })
}
