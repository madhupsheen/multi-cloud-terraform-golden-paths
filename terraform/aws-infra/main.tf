# ---------------------------------------------------------
# HUB VPC - Shared Services & Centralized Governance
# ---------------------------------------------------------
resource "aws_vpc" "hub" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.environment_name}-hub"
    Tier = "Shared-Services"
  }
}

resource "aws_subnet" "shared_services" {
  vpc_id            = aws_vpc.hub.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.region}a"
  tags = {
    Name = "${var.environment_name}-shared-subnet"
  }
}

# ---------------------------------------------------------
# SPOKE VPCS - Environment Isolation (Dev & Prod)
# ---------------------------------------------------------
resource "aws_vpc" "dev" {
  cidr_block = "10.1.0.0/16"
  tags       = { Name = "${var.environment_name}-dev-spoke" }
}

resource "aws_vpc" "prod" {
  cidr_block = "10.2.0.0/16"
  tags       = { Name = "${var.environment_name}-prod-spoke" }
}

# ---------------------------------------------------------
# SECURITY & SECRETS - "Security-by-Design" Implementation
# ---------------------------------------------------------

# Generic Secrets Management for SaaS Workloads
resource "aws_secretsmanager_secret" "app_secrets" {
  name        = "${var.environment_name}/app/production-credentials"
  description = "Maintained via Terraform - Secure Path-to-Production"
}

# IAM Role for Platform Engineering Automation
resource "aws_iam_role" "platform_admin" {
  name = "${var.environment_name}-admin-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "://amazonaws.com" }
    }]
  })
}
