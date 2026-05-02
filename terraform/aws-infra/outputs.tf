# VPC IDs - Essential for peering and networking checks
output "hub_vpc_id" {
  description = "The ID of the Hub VPC"
  value       = aws_vpc.hub.id
}

output "dev_vpc_id" {
  description = "The ID of the Dev Spoke VPC"
  value       = aws_vpc.dev.id
}

output "prod_vpc_id" {
  description = "The ID of the Prod Spoke VPC"
  value       = aws_vpc.prod.id
}

# Security & Secrets - Shows you care about the "Path to Production"
output "secrets_manager_arn" {
  description = "The ARN of the Secrets Manager secret for the platform"
  value       = aws_secretsmanager_secret.db_creds.arn
}

output "platform_role_arn" {
  description = "The IAM Role ARN for the Platform Engineering team"
  value       = aws_iam_role.platform_engineer.arn
}

# Region Info
output "aws_region" {
  description = "The deployment region"
  value       = var.region
}
