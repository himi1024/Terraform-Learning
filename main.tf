provider "aws" {
    region = "us-east-1"
}

module "ec2_instance" {
    source = "./module/ec2_instance"

}

resource "aws_s3_bucket" "s3_bucket" {
    bucket = "himi-s3-tf-backend"
    
}