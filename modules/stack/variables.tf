variable "env_name" {
  description = "Nombre del ambiente (dev, qa, etc.)"
  type        = string
}

variable "web_port" {
  description = "Puerto de host para el frontend (Nginx)"
  type        = number
}

variable "api_port" {
  description = "Puerto de host para el backend (Node)"
  type        = number
}

variable "db_port" {
  description = "Puerto de host para PostgreSQL"
  type        = number
}

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

variable "postgres_db" {
  description = "Nombre de la base de datos"
  type        = string
}

variable "apps_path" {
  description = "Ruta absoluta a la carpeta apps/ en la raíz del proyecto"
  type        = string
}