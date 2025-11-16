output "codebuild-artifact" {
    value = aws_s3_bucket.codebuild_artifact.bucket
}


output "codebuild-artifact-arn" {
    value = aws_s3_bucket.codebuild_artifact.arn
}
