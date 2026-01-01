data "aws_vpc" "default" {
  default = true
}


resource "aws_subnet" "default_subnet" {
  vpc_id                  = data.aws_vpc.default.id
  cidr_block              = "172.31.100.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "default-subnet"
  }
}


resource "aws_instance" "example" {
  ami           = "ami-00ca570c1b6d79f36"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.default_subnet.id
  key_name      = "asia"

  tags = {
    Name = "test"
  }
}



resource "null_resource" "add" {

  depends_on = [aws_instance.example]

  connection {
    type        = "ssh"
    host        = aws_instance.example.public_ip
    user        = "ec2-user"
    private_key = file("test")
  }

  provisioner "local-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install docker -y",
      "sudo service docker start",
      "sudo usermod -aG docker ec2-user",

      # Docker Compose add
      "sudo curl -L https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose"
    ]
  }

  triggers = {
    always_run = timestamp()
  }
}
