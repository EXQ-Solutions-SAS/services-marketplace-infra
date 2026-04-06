# 1. La Red VPC
resource "google_compute_network" "main" {
  name                    = "main-vpc"
  auto_create_subnetworks = false # Senior move: Control total de subredes
}

# 2. Subred Privada
resource "google_compute_subnetwork" "private" {
  name          = "private-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.main.id
  
  # Habilita el acceso privado a servicios de Google (Necesario para Cloud SQL)
  private_ip_google_access = true
}

# 3. Cloud Router (Requerido para el NAT)
resource "google_compute_router" "router" {
  name    = "main-router"
  region  = var.region
  network = google_compute_network.main.id
}

# 4. Cloud NAT
# Esto permite que los recursos en la subred privada salgan a internet
# sin tener una IP pública que los exponga a ataques externos.
resource "google_compute_router_nat" "nat" {
  name                               = "main-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}