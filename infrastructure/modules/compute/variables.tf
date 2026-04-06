variable "project_id" { type = string }
variable "region"     { type = string }
variable "image_url"  { type = string } # URL de Artifact Registry
variable "db_host"    { type = string } # IP privada de Cloud SQL
variable "db_name"    { 
    type = string
}
variable "db_user"    { 
    type = string
}
variable "db_password_secret_id" { type = string } # ID del secreto en Secret Manager