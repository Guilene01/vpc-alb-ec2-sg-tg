output "dns-lb" {
  value = aws_lb.my-lb.dns_name
}
output "db-endpoint" {
  value = aws_db_instance.wp-db.endpoint
}
output "ssh-command" {
  value = "ssh -i ${local_file.key1.filename} ec2-user@${aws_instance.wp-server.public_ip}"
}
output "wp-url" {
  value = "http//${aws_instance.wp-server.public_ip}"
}