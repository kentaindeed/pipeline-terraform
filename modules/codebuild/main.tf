# codebuild
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project

locals {
  common_variables = {
    region = "ap-northeast-1"
    profile = "default"
  }

  common_tags = {
    Environment = "prod"
    Project = "pipeline"
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

data "aws_codestarconnections_connection" "github" {
  name = "kentaindeed-github-connect"
}


resource "aws_codebuild_project" "codebuild" {
  
    name = "${local.name_prefix}-codebuild" 
    service_role = aws_iam_role.codebuild.arn

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:4.0"
    type         = "LINUX_CONTAINER"
    privileged_mode = true
  }

  source {
    type            = "GITHUB"
    location = "https://github.com/${var.github_owner}/${var.github_repo}.git"
    git_clone_depth = 1
    # プライベートリポジトリの場合は認証が必要
    # auth {
    #   type = "CODECONNECTIONS"
    #   resource = data.aws_codestarconnections_connection.github.arn
    # }
  }

  source_version = "main"

  tags = {
    Project = local.common_tags.Project
  }
}