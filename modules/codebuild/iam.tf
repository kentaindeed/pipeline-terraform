# CodeBuild用のIAMロール
resource "aws_iam_role" "codebuild" {
  name = "${local.name_prefix}-codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${local.name_prefix}-codebuild-role"
  }
}

# CloudWatch Logs権限
resource "aws_iam_role_policy" "codebuild_logs" {
  role = aws_iam_role.codebuild.name
  name = "codebuild-logs-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = [
          "arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/${local.name_prefix}*"
        ]
      }
    ]
  })
}

# S3アクセス権限（アーティファクト用）
resource "aws_iam_role_policy" "codebuild_s3" {
  role = aws_iam_role.codebuild.name
  name = "codebuild-s3-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject"
        ]
        Resource = [
          "${var.artifact_bucket_arn}/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = [
          var.artifact_bucket_arn
        ]
      }
    ]
  })
}

# # ECRアクセス権限（Dockerイメージをpushする場合）
# resource "aws_iam_role_policy" "codebuild_ecr" {
#   role = aws_iam_role.codebuild.name
#   name = "codebuild-ecr-policy"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Action = [
#           "ecr:GetAuthorizationToken"
#         ]
#         Resource = "*"
#       },
#       {
#         Effect = "Allow"
#         Action = [
#           "ecr:BatchCheckLayerAvailability",
#           "ecr:GetDownloadUrlForLayer",
#           "ecr:BatchGetImage",
#           "ecr:PutImage",
#           "ecr:InitiateLayerUpload",
#           "ecr:UploadLayerPart",
#           "ecr:CompleteLayerUpload"
#         ]
#         # Resource = var.ecr_repository_arn
#       }
#     ]
#   })
# }

# CodeBuild レポート権限（テストレポートを使う場合）
resource "aws_iam_role_policy" "codebuild_reports" {
  role = aws_iam_role.codebuild.name
  name = "codebuild-reports-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "codebuild:CreateReportGroup",
          "codebuild:CreateReport",
          "codebuild:UpdateReport",
          "codebuild:BatchPutTestCases",
          "codebuild:BatchPutCodeCoverages"
        ]
        Resource = [
          "arn:aws:codebuild:${var.aws_region}:${data.aws_caller_identity.current.account_id}:report-group/${local.name_prefix}*"
        ]
      }
    ]
  })
}

# 現在のAWSアカウント情報を取得
data "aws_caller_identity" "current" {}


