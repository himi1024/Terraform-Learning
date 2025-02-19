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
