output "frontend_url" {
  description = "URL para acceder al frontend"
  value       = "http://localhost:${var.web_port}"
}

output "backend_url" {
  description = "URL para acceder al backend"
  value       = "http://localhost:${var.api_port}"
}