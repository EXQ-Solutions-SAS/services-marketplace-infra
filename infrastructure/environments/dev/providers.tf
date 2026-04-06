# /infrastructure/environments/dev/providers.tf

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  # Esto demuestra que sabes que el estado debe ser remoto y seguro
  backend "gcs" {
    bucket = "my-portfolio-tf-state"
    prefix = "terraform/state/dev"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}