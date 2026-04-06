# /infrastructure/environments/dev/main.tf

module "networking" {
  source     = "../../modules/networking"
  project_id = var.project_id
  region     = var.region
}

module "database" {
  source          = "../../modules/database"
  network_id      = module.networking.vpc_id
  db_password     = var.db_password # Se pasa vía variable secreta
  instance_tier   = "db-f1-micro"   # Demuestras que cuidas el presupuesto
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