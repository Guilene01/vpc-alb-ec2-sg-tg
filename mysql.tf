resource "aws_db_subnet_group" "main" {
  name       = "wp-sub"
  subnet_ids = [aws_subnet.private1.id, aws_subnet.private2.id]
}
resource "aws_db_instance" "wp-db" {
  identifier             = "wordpress-db"
  allocated_storage      = 20
  db_name                = "wordpress"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  username               = "admin"
  password               = "school123"
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name
  publicly_accessible    = false
  multi_az               = false

}

