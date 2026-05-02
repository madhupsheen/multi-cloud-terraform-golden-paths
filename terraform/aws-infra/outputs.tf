output "vpc_ids" {
  description = "IDs of the generated VPCs"
  value = {
    hub  = aws_vpc.hub.id
    dev  = aws_vpc.dev.id
    prod = aws_vpc.prod.id
  }
}

output "secrets_manager_arn" {
  description = "The ARN of the Secrets Manager entry for platform credentials"
  value       = aws_secretsmanager_secret.app_secrets.arn
}

output "platform_role_name" {
  description = "The name of the IAM role created for platform management"
  value       = aws_iam_role.platform_admin.name
}
