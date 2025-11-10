

# codebuild 
module "codebuild" {
    source = "../../modules/codebuild"
    env = var.env
}

