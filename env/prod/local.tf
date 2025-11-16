locals {
  common_variables = {
    region  = "ap-northeast-1"
    profile = "default"
  }

  common_tags = {
    Environment = "prod"
    Project     = "pipeline"
    Owner       = "kentaindeed"
    CreatedBy   = "terraform"
    CreatedAt   = "2025-01-01"
  }

  availability_zones = [
    "ap-northeast-1a",
    "ap-northeast-1d",
    "ap-northeast-1c"
  ]

}