terraform {
backend "s3" {
bucket = "test-bucket-2026"
key = "terraform/terraform.tfstate"
region = "us-east-2"
}
}
