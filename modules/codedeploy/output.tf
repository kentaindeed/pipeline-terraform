output "codedeploy_app_name" {
    description = "CodeDeploy Application Name"
    value = aws_codedeploy_app.blue_green_app.name
}