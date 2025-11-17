# Pipeline Terraform

AWS CI/CDパイプラインを構築するためのTerraformプロジェクト

## 構成

```
├── modules/           # 再利用可能なTerraformモジュール
│   ├── artifacts/     # S3アーティファクトストア
│   ├── codebuild/     # CodeBuildプロジェクト
│   ├── codedeploy/    # CodeDeployアプリケーション
│   ├── iam/          # IAMロール・ポリシー
│   └── pipeline/     # CodePipelineメイン
└── env/              # 環境別設定
    └── prod/         # 本番環境
```

## 使用方法

### 初期化
```bash
cd env/prod
terraform init
```

### デプロイ
```bash
terraform plan
terraform apply
```

### 削除
```bash
terraform destroy
```
