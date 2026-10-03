locals {
  apps_path = abspath("${path.root}/apps")
}

module "dev" {
  source = "./modules/stack"

  env_name  = "dev"
  web_port  = 4001
  api_port  = 4002
  db_port   = 4003

  message           = var.message
  postgres_user     = var.postgres_user
  postgres_password = var.postgres_password
  postgres_db       = "dev_db"

  apps_path = local.apps_path
}

module "qa" {
  source = "./modules/stack"

  env_name  = "qa"
  web_port  = 5001
  api_port  = 5002
  db_port   = 5003

  message           = var.message
  postgres_user     = var.postgres_user
  postgres_password = var.postgres_password
  postgres_db       = "qa_db"

  apps_path = local.apps_path
}