resource "aws_s3_bucket" "remote_s3" {
  bucket = "gurleen-terraform-bucket"

  tags = {
    Name        = "gurleen-terraform-bucket"
  }
}
