# Laboratorio 

### 1. Clonar el repositorio

```bash
git clone https://github.com/hcamilop/Lab_Terraform.git
cd Lab_Terraform
```

### 2. Configurar variables

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edita `terraform.tfvars` con tus propios valores (nombre y contraseña de
PostgreSQL). Este archivo nunca se sube al repositorio (ver `.gitignore`).

### 3. Inicializar Terraform

```bash
terraform init
```

Descarga el provider `kreuzwerker/docker` y prepara los módulos.

### 4. Revisar el plan 

```bash
terraform plan
```

Muestra qué recursos se van a crear sin ejecutar nada todavía.

### 5. Desplegar

```bash
terraform apply
```
### 6. Acceder a los ambientes

| Ambiente | Frontend | Backend |
|----------|----------|---------|
| DEV | http://localhost:4001 | http://localhost:4002 |
| QA | http://localhost:5001 | http://localhost:5002 |

### 7. Destruir la infraestructura

```bash
terraform destroy
```

## Tipos de redes en Docker

- **bridge**: driver por defecto, usado en este proyecto. Crea una red virtual
  privada en el host; los contenedores conectados se comunican entre sí por
  nombre/alias.
- **host**: el contenedor usa la red del host directamente, sin aislamiento.
- **none**: desactiva la red del contenedor.
- **overlay**: conecta contenedores entre distintos hosts/nodos (Docker Swarm).
- **macvlan**: asigna una IP/MAC propia al contenedor dentro de la red física.
- **ipvlan**: similar a macvlan, pero comparte la MAC y se diferencia por IP.

## Tipos de volúmenes en Docker

- **Named volumes**: administrados por Docker, usados aquí para persistir los
  datos de PostgreSQL (`db-data-dev`, `db-data-qa`).
- **Bind mounts**: montan una ruta específica del host. No se usan en este
  proyecto (se prefirió el bloque `upload` de Terraform para inyectar archivos).
- **tmpfs mounts**: almacenan datos solo en RAM, se pierden al detener el contenedor.
- **Anonymous volumes**: como un volumen nombrado, pero sin nombre asignado
  explícitamente.

## Conventional Commits

Ejemplos usados en el historial de este repositorio:

```
feat: agregar backend Node.js con conexión a PostgreSQL
feat: agregar plantillas de frontend Nginx (HTML + proxy a backend)
feat: agregar módulo Terraform para stack frontend-backend-bd
feat: agregar configuración raíz de Terraform (módulos dev y qa)
fix: declarar provider kreuzwerker/docker en