# Output
output "codebuild_role_arn" {
  value       = aws_iam_role.codebuild.arn
  description = "CodeBuild IAM Role ARN"
}

output "codebuild_role_name" {
  value       = aws_iam_role.codebuild.name
  description = "CodeBuild IAM Role Name"
}