# Terraform State管理用のS3バケットとDynamoDBテーブル
# 注意: このファイルは最初に一度だけ適用し、その後backend.tfを有効化する

terraform {
  backend "s3" {
    bucket         = "prod-tfstate-pipeline-bucket"
    key            = "prod/terraform.tfstate"
    region         = "ap-northeast-1"
    encrypt        = true
    
    # オプション: プロファイルを指定する場合
    # profile = "default"
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "prod-tfstate-pipeline-bucket"
  
  tags = {
    Name        = "Terraform State Bucket"
    Environment = "prod"
    ManagedBy   = "Terraform"
  }
}

# バージョニング有効化
resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

# 暗号化設定
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# パブリックアクセスブロック
resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "s3_bucket_name" {
  value       = aws_s3_bucket.terraform_state.bucket
  description = "Terraform state S3 bucket name"
}

