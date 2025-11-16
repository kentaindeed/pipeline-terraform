variable "env" {
  type        = string
  description = "Environment"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "ap-northeast-1"
}

variable "artifact_bucket" {
  type        = string
  description = "S3 bucket name for artifacts"
}

variable "artifact_bucket_arn" {
  type        = string
  description = "S3 bucket ARN for artifacts"
}

variable "github_owner" {
  type        = string
  description = "GitHub owner"
}
variable "github_repo" {
  type        = string
  description = "GitHub repository"
}
