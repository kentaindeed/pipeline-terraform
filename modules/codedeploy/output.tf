output "deploy-application" {
    description = "CodeDeploy Application Name"
    value = aws_codedeploy_app.blue_green_app.name
}