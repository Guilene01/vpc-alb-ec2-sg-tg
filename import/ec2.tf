
resource "aws_instance" "web" {
  ami                                  = "ami-0c614dee691cbbf37"
  associate_public_ip_address          = true
  availability_zone                    = "us-east-1b"
  instance_type                        = "t2.micro"
  key_name                             = "window"
  security_groups                      = ["launch-wizard-3"]
  source_dest_check                    = true
  subnet_id                            = "subnet-0ca177aa0c477484d"
  tags = {
    Name = "terraform-server"
  }
}