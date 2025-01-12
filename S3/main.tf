resource "aws_s3_bucket" "archived_app" {
  bucket = "archived-app"

  tags = {
    Name = "archived-app"
    Project = "EBSDeploymentProject"
  }
}

resource "aws_s3_object" "nextjs_app_archived" {
  bucket       = aws_s3_bucket.archived_app.id
  key          = "beanstalk/app.zip" # Path inside the bucket
  source       = "./app.zip" # Local file to upload
}
