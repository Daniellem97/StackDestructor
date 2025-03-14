resource "aws_s3_bucket" "example" {
  bucket = "example-spacelift-bucket"
  acl    = "private"
}
