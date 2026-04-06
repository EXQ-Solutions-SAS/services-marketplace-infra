# 1. Reservar IPs privadas para servicios de Google (Peering)
resource "google_compute_global_address" "private_ip_address" {
  name          = "google-managed-services-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.network_id
}

# 2. Establecer la conexión de Peering
resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

# 3. Instancia de Cloud SQL (PostgreSQL 15)
resource "google_sql_database_instance" "postgres" {
  name             = "exq-postgres-instance"
  database_version = "POSTGRES_15" # Match con  docker-compose
  region           = var.region
  
  # Esperar a que el peering esté listo
  depends_on = [google_service_networking_connection.private_vpc_connection]

  settings {
    tier = "db-f1-micro" # Económico 
    
    ip_configuration {
      ipv4_enabled    = false # Senior move: Sin IP pública
      private_network = var.network_id
    }

    # Flags para optimizar/habilitar extensiones si fuera necesario
    database_flags {
      name  = "cloudsql.enable_pgaudit"
      value = "on"
    }
  }
}

# 4. Creación de la Base de Datos
resource "google_sql_database" "database" {
  name     = var.db_name # El DB_NAME de tu .env
  instance = google_sql_database_instance.postgres.name
}

# 5. Usuario de la Base de Datos
resource "google_sql_user" "users" {
  name     = var.db_user # El DB_USER de tu .env
  instance = google_sql_database_instance.postgres.name
  password = var.db_password
}