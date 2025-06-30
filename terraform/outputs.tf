output "db_endpoint" {
  description = "JDBC/psql endpoint for the database"
  value       = aws_db_instance.postgres.address
}

output "db_port" {
  description = "Port of the database"
  value       = aws_db_instance.postgres.port
}

output "db_username" {
  description = "Username for the DB"
  value       = aws_db_instance.postgres.username
}

output "db_password" {
  description = "Generated DB password (handle securely!)"
  value       = random_password.db.result
  sensitive   = true
}