variable "message" {
  description = "Mensaje que retorna el backend"
  type        = string
  default     = "Hola desde Terraform"
}

variable "postgres_user" {
  description = "Usuario de PostgreSQL"
  type        = string
  default     = "postgres"
}

variable "postgres_password" {
  description = "Contraseña de PostgreSQL"
  type        = string
  sensitive   = true
}