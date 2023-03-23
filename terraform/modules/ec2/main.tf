data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

/*
resource "random_shuffle" "subnets" {
  input        = var.subnets
  result_count = 1
}
*/

resource "aws_instance" "jenkins-server" {
  ami           = data.aws_ami.latest-amazon-linux-image.id
  instance_type = var.instance_type

  root_block_device {
    volume_size = var.instance_root_device_size
    volume_type = "gp3"
  }

  key_name                    = var.key_name
  subnet_id                   = var.public_subnet
  vpc_security_group_ids      = var.security_group
  availability_zone           = var.avail_zone
  associate_public_ip_address = true
  user_data                   = file("../modules/ec2/jenkins-server-script.sh")
  tags = {
    Name = "${var.infra_env}-server"
  }
}
