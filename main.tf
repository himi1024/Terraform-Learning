provider "aws" {
    region = "us-east-1"
}

variable"cidr" {
    default = "10.0.0.0/16"
}

resource "aws_key_pair" "key-1" {
    key_name = "terra-form-himi"
    public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_vpc" "myvpc" {
    cidr_block = var.cidr
}

resource "aws_subnet" "subnet-1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw-1" {
    vpc_id = aws_vpc.myvpc_id
}

resource "aws_route_table" "RT" {
    vpc_id = aws_vpc.myvpc_id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw-1.id
    }
}

resource "aws_route_table_association" "rta-1" {
    subnet_id = aws_subnet.subnet-1.id
    route_table_id = aws_route_table.RT.id
}

resource "aws_security_group" "webSG" {
    name = "web"
    vpc_id = aws_vpc.myvpc.id

    ingress {
        description = "HTTP from VPC"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp" #All protocol
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "web-sg"
    }
}

resource "aws_instance" "server" {
    ami = var.ami_id_value
    instance_type = var.instance_type_value
    key_name = aws_key_pair.key-1
    vpc_security_group_ids = [aws_security_group.webSG.id]
    subnet_id = aws_subnet.subnet-1.id

    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("~/.ssh/id_rsa")
        host = self.public_ip
    }

    provisioner "file" {
        source = "app.py"
        destination = "/home/ubuntu/app.py" # Replace with the path on the remote instance   
    }

    provisioner "remote-exec" {
        inline = [
            "echo 'Hello from remote instance'",
            "sudo apt update -y",
            "sudo apt-get install -y python3-pip",
            "cd /home/ubuntu",
            "sudo pip3 install flask",
            "sudo python3 app.py &"
        ]
    }
}
/*module "ec2_instance" {
    source = "./module/ec2_instance"

}

resource "aws_s3_bucket" "s3_bucket" {
    bucket = "himi-s3-tf-backend"
    
}
*/