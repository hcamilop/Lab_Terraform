# Red privada exclusiva para este ambiente (dev o qa)
resource "docker_network" "network" {
  name = "${var.env_name}-network"
}

# --- Base de datos ---

resource "docker_volume" "db_data" {
  name = "db-data-${var.env_name}"
}

resource "docker_image" "postgres" {
  name = "postgres:16-alpine"
}

resource "docker_container" "db" {
  name  = "bd-${var.env_name}"
  image = docker_image.postgres.image_id

  env = [
    "POSTGRES_USER=${var.postgres_user}",
    "POSTGRES_PASSWORD=${var.postgres_password}",
    "POSTGRES_DB=${var.postgres_db}",
  ]

  ports {
    internal = 5432
    external = var.db_port
  }

  networks_advanced {
    name    = docker_network.network.name
    aliases = ["bd-${var.env_name}"]
  }

  volumes {
    volume_name    = docker_volume.db_data.name
    container_path = "/var/lib/postgresql/data"
  }
}

# --- Backend (Node.js) ---

resource "docker_image" "backend" {
  name = "api-${var.env_name}:latest"

  build {
    context = "${var.apps_path}/backend"
  }
}

resource "docker_container" "backend" {
  name  = "api-${var.env_name}"
  image = docker_image.backend.image_id

  env = [
    "MESSAGE=${var.message}",
    "ENV_NAME=${var.env_name}",
    "PORT=3000",
    "DB_HOST=bd-${var.env_name}",
    "DB_PORT=5432",
    "DB_USER=${var.postgres_user}",
    "DB_PASSWORD=${var.postgres_password}",
    "DB_NAME=${var.postgres_db}",
  ]

  ports {
    internal = 3000
    external = var.api_port
  }

  networks_advanced {
    name    = docker_network.network.name
    aliases = ["api-${var.env_name}"]
  }

  depends_on = [docker_container.db]
}

# --- Frontend (Nginx) ---

resource "docker_image" "nginx" {
  name = "nginx:alpine"
}

resource "docker_container" "frontend" {
  name  = "web-${var.env_name}"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = var.web_port
  }

  networks_advanced {
    name = docker_network.network.name
  }

  upload {
    file = "/usr/share/nginx/html/index.html"
    content = templatefile("${var.apps_path}/frontend/index.html.tpl", {
      env_name = upper(var.env_name)
    })
  }

  upload {
    file = "/etc/nginx/conf.d/default.conf"
    content = templatefile("${var.apps_path}/frontend/nginx.conf.tpl", {
      api_host = "api-${var.env_name}"
    })
  }

  depends_on = [docker_container.backend]
}