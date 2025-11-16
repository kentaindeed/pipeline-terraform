
# s3 artifact（先に定義）
module "artifacts" {
    source = "../../modules/artifacts"
    env = var.env
    aws_region = var.aws_region
}

# codebuild（artifactsの出力を使用）
module "codebuild" {
    source = "../../modules/codebuild"
    env = var.env
    github_owner = var.github_owner
    github_repo = var.github_repo
    artifact_bucket = module.artifacts.codebuild-artifact
    artifact_bucket_arn = module.artifacts.codebuild-artifact-arn
}

