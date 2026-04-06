variable "project_id"  { type = string }
variable "region"      { type = string }
variable "network_id"  { type = string } # Viene del módulo de networking
variable "db_name" {
    type = string
}
variable "db_user" {
    type = string
}
variable "db_password" { 
    type = string
    sensitive = true 
}
