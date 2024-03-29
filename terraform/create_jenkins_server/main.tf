provider "aws" {
    region = "ap-south-1"
}

variable "cidr" {
    default = "10.0.20.0/22"
}

resource "aws_key_pair" "example" {
    key_name = "example.pem"
    public_key = file("~/.ssh/id_rsa.pub") #public key path
}
resource "aws_vpc" "myvpc" {
    cidr_block = var.cidr
}
resource "aws_subnet" "sub1" {
    vpc_id = aws_vpc.sub1.id
    cidr_block = "10.0.20.0/24"
    avaialblity_zone = "ap-south-1a"
    map_public_ip_on_launch = true
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.sub1.id
}
resource "aws_route_table" "tb1" {
    vpc_id = aws_vpc.sub1.id

    route {
        cidr_block = "0.0.0.0/0"
        internet_gateway = aws_internet_gateway.igw.id

    }
}
resource "route_table_association" "rtb1" {
    subnet_id = aws_subnet.sub1.id
    route_table_id = aws_route_table.tb1.id
}
resource "aws_security_group" "sg1" {
    vpc_id = aws_vpc.myvpc.id
    name = "web"
    ingress {
        description = "ssh from vpc"
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_block = "0.0.0.0/0"
    }
        ingress {
        description = "http from vpc"
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_block = "0.0.0.0/0"
        }
       egress {
        description = "egress"
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_block = "0.0.0.0/0"
    }
}
resource "aws_instance" "jenkins_server" {
    ami = " "
    instance_type = "t2.micro"
    key_name = aws_key_pair.example.key_name
    security_group_ids = [aws_security_group.sg1.id]
    subnet_id = aws_subnet.sub1.id

    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file(/.ssh/id_rsa)
        host_public_ip = self.public_ip
    }
    provisioner "file" {
        source = ./jenkins_insta_ubuntu.sh
        destination = /home/ubuntu
    }
    provisioner "remote_exec" {
        inline = [
            "sudo chmod 777 /home/ubuntu/jenkins_insta_ubuntu.sh && bash /home/ubuntu/jenkins_insta_ubuntu.sh"
        ]
    }
}