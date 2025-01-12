output "s3_bucket" {
    value = aws_s3_bucket.archived_app.id
}

output "s3_key" {
    value = aws_s3_object.nextjs_app_archived.id
}