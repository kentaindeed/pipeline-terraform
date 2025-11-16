variable "env" {
  type        = string
  description = "Environment"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "ap-northeast-1"
}

variable "github_owner" {
  type        = string
  description = "GitHub owner"
}

variable "github_repo" {
  type        = string
  description = "GitHub repository"
}
