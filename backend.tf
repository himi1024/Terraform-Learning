terraform {
    backend "s3" {
        bucket = "himi-s3-tf-backend"
        key = "himi/terraform.tfstate"
        region = "us-east-1"
        dynamodb_table = "terraform_lock"
    }
}