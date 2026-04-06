# /infrastructure/environments/dev/main.tf

module "networking" {
  source     = "../../modules/networking"
  project_id = var.project_id
  region     = var.region
}

module "database" {
  source      = "../../modules/database"
  project_id  = var.project_id
  region      = var.region
  network_id  = module.networking.vpc_id # <--- Conexión entre módulos
  db_password = var.db_password
}

module "backend_api" {
  source     = "../../modules/compute"
  project_id = var.project_id
  image_url  = var.backend_image
  db_host    = module.database.private_ip
}

module "frontend_hosting" {
  source     = "../../modules/firebase"
  project_id = var.project_id
}