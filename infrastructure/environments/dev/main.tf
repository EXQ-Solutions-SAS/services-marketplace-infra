# /infrastructure/environments/dev/main.tf

module "networking" {
  source     = "../../../modules/networking"
  project_id = var.project_id
  region     = var.region
}

module "database" {
  source      = "../../../modules/database"
  project_id  = var.project_id
  region      = var.region
  network_id  = module.networking.vpc_id # <--- Conexión entre módulos
  db_password = var.db_password
}

module "backend_api" {
  source                = "../../../modules/compute"
  project_id            = var.project_id
  region                = var.region
  image_url             = var.backend_image
  db_host               = module.database.db_private_ip # Viene del output de DB
  db_password_secret_id = var.db_password             # O mejor, el secret version
}

module "frontend_hosting" {
  source     = "../../../modules/firebase"
  project_id = var.project_id
}