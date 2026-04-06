module "networking" {
  source     = "../../modules/networking"
  project_id = var.project_id
  region     = var.region
}

module "database" {
  source      = "../../modules/database"
  project_id  = var.project_id
  region      = var.region
  network_id  = module.networking.vpc_id
  db_password = var.db_password
  db_name     = var.db_name
  db_user     = var.db_user
}

module "backend_api" {
  source                = "../../modules/compute"
  project_id            = var.project_id
  region                = var.region
  image_url             = var.backend_image
  db_host               = module.database.db_private_ip
  db_password_secret_id = var.db_password
  # ESTAS TAMBIÉN FALTAN AQUÍ:
  db_name               = var.db_name
  db_user               = var.db_user
}

module "frontend_hosting" {
  source     = "../../modules/firebase"
  project_id = var.project_id
}