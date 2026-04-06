# 1. Habilitar las APIs necesarias para Firebase
resource "google_project_service" "firebase" {
  project = var.project_id
  service = "firebase.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "hosting" {
  project = var.project_id
  service = "firebasehosting.googleapis.com"
  disable_on_destroy = false
}

# 2. Inicializar el proyecto de Firebase dentro del proyecto de GCP
resource "google_firebase_project" "default" {
  provider = google-beta
  project  = var.project_id
  depends_on = [google_project_service.firebase]
}

# 3. Crear el sitio de Hosting para el Dashboard de Angular
resource "google_firebase_hosting_site" "dashboard" {
  provider = google-beta
  project  = var.project_id
  site_id  = "exq-admin-dashboard" # ID único de tu sitio
  app_id   = "" # Se puede vincular a una Web App de Firebase si se desea
  
  depends_on = [google_firebase_project.default]
}