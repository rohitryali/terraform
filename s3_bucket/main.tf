provider "aws" {
region = "us-east-2"
}

resource "aws_s3_bucket" "my_s3" {
bucket = "test-bucket-2026"
}

resource "aws_s3_bucket_versioning" "versioning" {
bucket = aws_s3_bucket.my_s3.id

versioning_configuration {
status = "Enabled" 
}
}

