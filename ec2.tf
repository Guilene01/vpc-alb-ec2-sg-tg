# create private ec2 instance
resource "aws_instance" "web1" {
  ami             = "ami-045269a1f5c90a6a0"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.private1.id
  security_groups = [aws_security_group.sg2.id]
  user_data       = file("code.sh")
  tags = {
    Name = "webserver-1"
  }

}
resource "aws_instance" "web2" {
  ami             = "ami-045269a1f5c90a6a0"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.private2.id
  security_groups = [aws_security_group.sg2.id]
  user_data       = file("code.sh")
  tags = {
    Name = "webserver-2"
  }

}
resource "aws_instance" "wp-server" {
  ami                         = "ami-045269a1f5c90a6a0"
  instance_type               = "t2.micro"
  key_name                    = "wpkey"
  vpc_security_group_ids      = [aws_security_group.sg3.id]
  subnet_id                   = aws_subnet.public1.id
  user_data                   = file("install.sh")
  associate_public_ip_address = true
  tags = {
    Name = "wp-server"
  }

}