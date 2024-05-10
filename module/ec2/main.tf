resource "aws_instance" "my-ec2" {
    subnet_id = var.public-subnet-myvpc-2
    instance_type = "t2.micro"
    ami = var.ami
    vpc_security_group_ids = [aws_security_group.myvpc-sg.id]
    associate_public_ip_address = true
    key_name = "Nat-sing"
    root_block_device {
      volume_size = 8
      volume_type = "gp2"
      delete_on_termination = true
      encrypted = false
    }

    tags = {
      Name = "${var.project-name}-my-ec2-public"
    }
    

}
resource "aws_instance" "hg-ec2" {
    instance_type = "t2.micro"
    subnet_id = var.public-subnet-hgvpc-2
    ami = var.ami
    vpc_security_group_ids = [aws_security_group.hgvpc-sg.id]
    key_name = "Nat-sing"
    associate_public_ip_address = true
    root_block_device {
      volume_size = 8
      volume_type = "gp2"
      delete_on_termination = true
      encrypted = false
    }
    tags = {
      Name = "${var.project-name}-hg-ec2-public"
    }
}
resource "aws_security_group" "myvpc-sg" {
  vpc_id = var.cidr-my-vpc
  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.project-name}-my-sg"
  }
}
resource "aws_security_group" "hgvpc-sg" {
    vpc_id = var.cidr-hg-vpc
  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.project-name}-hg-sg"
  }
}