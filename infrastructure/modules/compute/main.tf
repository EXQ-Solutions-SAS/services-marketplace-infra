# 1. Serverless VPC Access Connector
# Este es el "puente" para que Cloud Run entre a la VPC privada
resource "google_vpc_access_connector" "connector" {
  name          = "run-vpc-connector"
  region        = var.region
  ip_cidr_range = "10.8.0.0/28"
  network       = "main-vpc" # Debe coincidir con el nombre en networking
}

# 2. Servicio de Cloud Run (NestJS API)
resource "google_cloud_run_v2_service" "api" {
  name     = "exq-nestjs-api"
  location = var.region
  ingress  = "INGRESS_TRAFFIC_ALL" # Permite tráfico desde internet

  template {
    vpc_access {
      connector = google_vpc_access_connector.connector.id
      egress    = "ALL_TRAFFIC"
    }

    containers {
      image = var.image_url
      
      ports {
        container_port = 3000
      }

      # Inyección de variables de entorno (
      env {
        name  = "DATABASE_URL"
        value = "postgresql://${var.db_user}:${var.db_password_secret_id}@${var.db_host}:5432/${var.db_name}?schema=public"
      }
      
      env {
        name  = "NODE_ENV"
        value = "production"
      }

      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
    }
  }

  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }
}

# 3. Hacer el servicio público (IAM)
# Esto permite que cualquier persona en internet llegue al API
resource "google_cloud_run_v2_service_iam_member" "public_access" {
  name     = google_cloud_run_v2_service.api.name
  location = google_cloud_run_v2_service.api.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}