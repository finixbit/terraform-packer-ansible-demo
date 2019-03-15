
provider "aws" {
}

resource "aws_instance" "app" {
  instance_type          = "t2.micro" 
  vpc_security_group_ids = ["${aws_security_group.allow_http.id}", "${aws_security_group.allow_ssh.id}"]
  ami                    = "${var.ami}"
}

resource "aws_security_group" "allow_http" { 
  name = "allow_http" 
  ingress {
    from_port = "${var.server_port}"
    to_port = "${var.server_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
}

resource "aws_security_group" "allow_ssh" { 
  name = "allow_ssh" 
  ingress {
    from_port = "${var.ssh_port}"
    to_port = "${var.ssh_port}"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 
}