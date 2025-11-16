# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codedeploy_app

locals {
  common_variables = {
    region = "ap-northeast-1"
    profile = "default"
  }

  common_tags = {
    Environment = "dev"
    Project = "pipeline-system"
    Owner = "kentaindeed"
    CreatedBy = "terraform"
    CreatedAt = "2025-01-01"
  }

  availability_zones = [
    "ap-northeast-1a", 
    "ap-northeast-1d", 
    "ap-northeast-1c"
]
    # 名前のプレフィックスを定義
    name_prefix = "${var.env}-${local.common_tags.Project}"
}

# application
resource "aws_codedeploy_app" "blue_green_app" {
  compute_platform = "ECS"
  name             = "${local.name_prefix}-deploy-app"
}

# config
resource "aws_codedeploy_deployment_config" "config" {
  deployment_config_name = "${local.name_prefix}-deploy-config"

  minimum_healthy_hosts {
    type  = "HOST_COUNT"
    value = 1
  }
}


