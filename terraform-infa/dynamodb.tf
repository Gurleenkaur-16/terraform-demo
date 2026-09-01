resource "aws_dynamodb_table" "dynamodb_table" {
  name         = "gurleen-terraform-dynamodb-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "gurleen-terraform-dynamodb-table"
  }
}
