# codebuild source artifact

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


resource "aws_s3_bucket" "codebuild_artifact" {
  bucket = "${local.name_prefix}-bucket"
  acl    = "private"

}