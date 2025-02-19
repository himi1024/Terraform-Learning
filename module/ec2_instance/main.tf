resource "aws_instance" "aws-example" {
    ami           = var.ami_id_value
    instance_type = var.instance_type_value
    subnet_id = var.subnet_id_value
    key_name = "aws_login"
    provider = "aws.us-east-1"
}

resource "aws_instance" "aws-example2" {
    ami           = var.ami_id_value
    instance_type = var.instance_type_value
    subnet_id = var.subnet_id_value
    key_name = "aws_login"
    provider = "aws.us-west-2"
}

resource "aws_dynamodb_table" "terraform_lock" {
    name = "terraform-lock"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
      name = "LockID"
      type = "S"
    }
}