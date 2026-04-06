variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "The GCP Region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP Zone"
  type        = string
  default     = "us-central1-a"
}

variable "db_password" {
  description = "Password for the Cloud SQL instance"
  type        = string
  sensitive   = true
}

variable "backend_image" {
  description = "Docker image URL for Cloud Run"
  type        = string
}