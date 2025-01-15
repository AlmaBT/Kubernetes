resource "aws_instance" "docker_server" {
  ami = data.aws_ami.most_recent_amazon_linux_ami.id
  instance_type = "t2.medium"
  key_name = "Kuberenetes-keypair"
  associate_public_ip_address = true
  user_data = file("entry_script.sh")
  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }
  tags = {
    Name = "Minikube"
  }
}
data "aws_ami" "most_recent_amazon_linux_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}