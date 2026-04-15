terraform {
backend "s3" {
bucket = "test-bucket-2026"
key = "terraform/state.tfstate"
region = "us-east-2"
}
}
