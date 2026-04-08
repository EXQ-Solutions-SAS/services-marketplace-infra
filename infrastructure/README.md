# **☁️ Services Marketplace \- Infrastructure as Code (IaC)**

Este repositorio contiene la definición completa de la infraestructura para el ecosistema **Services Marketplace**. Utilizando un enfoque de **Infraestructura como Código (IaC)**, garantizamos entornos replicables, seguros y escalables en **Google Cloud Platform (GCP)**.

---

## **🗺️ Arquitectura de Red y Recursos**

La infraestructura está diseñada bajo el principio de **Privacidad por Defecto**, utilizando una arquitectura de VPC para aislar los recursos críticos.

### **Recursos Gestionados:**

* **Compute:** [Google Cloud Run](https://cloud.google.com/run) para el despliegue de microservicios (NestJS) de forma Serverless.  
* **Database:** [Cloud SQL (PostgreSQL)](https://cloud.google.com/sql) con backups automáticos y acceso restringido.  
* **Networking:** \* **VPC Custom:** Subredes aisladas para tráfico interno.  
  * **Cloud DNS:** Gestión de dominios y certificados SSL.  
* **Storage:** [Cloud Storage (GCS)](https://cloud.google.com/storage) para el almacenamiento de imágenes de servicios y perfiles.
* **Hosting:** [Firebase Hosting](https://firebase.google.com/docs/hosting) para  la entrega de contenido estático del panel de control de administrador.

---

## **🛠️ Estructura del Proyecto**

Plaintext

```
├── main.tf            # Definición principal de recursos
├── variables.tf       # Parámetros configurables (Region, Project ID, etc.)
├── outputs.tf         # Valores exportados (Endpoints, DB IPs)
├── modules/           # Módulos reutilizables (VPC, SQL, Cloud Run)
└── terraform.tfvars   # Variables específicas de entorno (No se sube al repo)
```

---

## **⚙️ CI/CD para Infraestructura**

Este repositorio utiliza **GitHub Actions** para validar cambios en la nube de forma segura:

1. **Terraform Format:** Verifica que el estilo del código sea correcto.  
2. **Terraform Validate:** Comprueba la sintaxis de las definiciones.  
3. **Terraform Plan:** Genera una vista previa de los cambios (Speculative Plan) antes de aplicarlos.  
4. **Security Scan:** (Opcional) Análisis de vulnerabilidades en la configuración de red.

---

## **🚀 Despliegue de Infraestructura**

1. **Configurar GCP:** Asegúrate de tener una Service Account con los permisos necesarios y exportar las credenciales.  
2. **Inicializar:**  
   Bash

```
terraform init
```

3. **Planificar:**

```
terraform plan -out=main.tfplan
```

4. **Aplicar:**

```
terraform apply "main.tfplan"
```

## 📄 Evidencia de Planificación (Terraform Plan)

Para garantizar la integridad de los cambios, cada ejecución genera un plan de ejecución detallado. A continuación, se muestra un extracto de la salida del comando `terraform plan` para este ecosistema:

<details>
<summary>📂 Hacer clic para ver la salida del Plan (Ejemplo)</summary>

```text

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.backend_api.google_cloud_run_v2_service.api will be created
  + resource "google_cloud_run_v2_service" "api" {
      + conditions              = (known after apply)
      + create_time             = (known after apply)
      + creator                 = (known after apply)
      + delete_time             = (known after apply)
      + effective_annotations   = (known after apply)
      + effective_labels        = (known after apply)
      + etag                    = (known after apply)
      + expire_time             = (known after apply)
      + generation              = (known after apply)
      + id                      = (known after apply)
      + ingress                 = "INGRESS_TRAFFIC_ALL"
      + last_modifier           = (known after apply)
      + latest_created_revision = (known after apply)
      + latest_ready_revision   = (known after apply)
      + launch_stage            = (known after apply)
      + location                = "us-central1"
      + name                    = "exq-nestjs-api"
      + observed_generation     = (known after apply)
      + project                 = "exq-solutions-dev"
      + reconciling             = (known after apply)
      + terminal_condition      = (known after apply)
      + terraform_labels        = (known after apply)
      + traffic_statuses        = (known after apply)
      + uid                     = (known after apply)
      + update_time             = (known after apply)
      + uri                     = (known after apply)

      + template {
          + max_instance_request_concurrency = (known after apply)
          + service_account                  = (known after apply)
          + timeout                          = (known after apply)

          + containers {
              + image = "gcr.io/exq-solutions-dev/exq-nestjs-api:latest"

              + env {
                  + name  = "DATABASE_URL"
                  + value = (sensitive value)
                }
              + env {
                  + name  = "NODE_ENV"
                  + value = "production"
                }

              + ports {
                  + container_port = 3000
                  + name           = (known after apply)
                }

              + resources {
                  + limits = {
                      + "cpu"    = "1"
                      + "memory" = "512Mi"
                    }
                }
            }

          + vpc_access {
              + connector = (known after apply)
              + egress    = "ALL_TRAFFIC"
            }
        }

      + traffic {
          + percent = 100
          + type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
        }
    }

  # module.backend_api.google_cloud_run_v2_service_iam_member.public_access will be created
  + resource "google_cloud_run_v2_service_iam_member" "public_access" {
      + etag     = (known after apply)
      + id       = (known after apply)
      + location = "us-central1"
      + member   = "allUsers"
      + name     = "exq-nestjs-api"
      + project  = (known after apply)
      + role     = "roles/run.invoker"
    }

  # module.backend_api.google_vpc_access_connector.connector will be created
  + resource "google_vpc_access_connector" "connector" {
      + connected_projects = (known after apply)
      + id                 = (known after apply)
      + ip_cidr_range      = "10.8.0.0/28"
      + machine_type       = "e2-micro"
      + max_instances      = (known after apply)
      + max_throughput     = 300
      + min_instances      = (known after apply)
      + min_throughput     = 200
      + name               = "run-vpc-connector"
      + network            = "main-vpc"
      + project            = "exq-solutions-dev"
      + region             = "us-central1"
      + self_link          = (known after apply)
      + state              = (known after apply)
    }

  # module.database.google_compute_global_address.private_ip_address will be created
  + resource "google_compute_global_address" "private_ip_address" {
      + address            = (known after apply)
      + address_type       = "INTERNAL"
      + creation_timestamp = (known after apply)
      + effective_labels   = (known after apply)
      + id                 = (known after apply)
      + label_fingerprint  = (known after apply)
      + name               = "google-managed-services-range"
      + network            = (known after apply)
      + prefix_length      = 16
      + project            = "exq-solutions-dev"
      + purpose            = "VPC_PEERING"
      + self_link          = (known after apply)
      + terraform_labels   = (known after apply)
    }

  # module.database.google_service_networking_connection.private_vpc_connection will be created
  + resource "google_service_networking_connection" "private_vpc_connection" {
      + id                      = (known after apply)
      + network                 = (known after apply)
      + peering                 = (known after apply)
      + reserved_peering_ranges = [
          + "google-managed-services-range",
        ]
      + service                 = "servicenetworking.googleapis.com"
    }

  # module.database.google_sql_database.database will be created
  + resource "google_sql_database" "database" {
      + charset         = (known after apply)
      + collation       = (known after apply)
      + deletion_policy = "DELETE"
      + id              = (known after apply)
      + instance        = "exq-postgres-instance"
      + name            = "exq_database"
      + project         = "exq-solutions-dev"
      + self_link       = (known after apply)
    }

  # module.database.google_sql_database_instance.postgres will be created
  + resource "google_sql_database_instance" "postgres" {
      + available_maintenance_versions = (known after apply)
      + connection_name                = (known after apply)
      + database_version               = "POSTGRES_15"
      + deletion_protection            = true
      + dns_name                       = (known after apply)
      + encryption_key_name            = (known after apply)
      + first_ip_address               = (known after apply)
      + id                             = (known after apply)
      + instance_type                  = (known after apply)
      + ip_address                     = (known after apply)
      + maintenance_version            = (known after apply)
      + master_instance_name           = (known after apply)
      + name                           = "exq-postgres-instance"
      + private_ip_address             = (known after apply)
      + project                        = "exq-solutions-dev"
      + psc_service_attachment_link    = (known after apply)
      + public_ip_address              = (known after apply)
      + region                         = "us-central1"
      + self_link                      = (known after apply)
      + server_ca_cert                 = (sensitive value)
      + service_account_email_address  = (known after apply)

      + settings {
          + activation_policy     = "ALWAYS"
          + availability_type     = "ZONAL"
          + connector_enforcement = (known after apply)
          + disk_autoresize       = true
          + disk_autoresize_limit = 0
          + disk_size             = (known after apply)
          + disk_type             = "PD_SSD"
          + edition               = "ENTERPRISE"
          + pricing_plan          = "PER_USE"
          + tier                  = "db-f1-micro"
          + user_labels           = (known after apply)
          + version               = (known after apply)

          + database_flags {
              + name  = "cloudsql.enable_pgaudit"
              + value = "on"
            }

          + ip_configuration {
              + ipv4_enabled    = false
              + private_network = (known after apply)
              + server_ca_mode  = (known after apply)
              + ssl_mode        = (known after apply)
            }
        }
    }

  # module.database.google_sql_user.users will be created
  + resource "google_sql_user" "users" {
      + host                    = (known after apply)
      + id                      = (known after apply)
      + instance                = "exq-postgres-instance"
      + name                    = "exq_admin"
      + password                = (sensitive value)
      + project                 = "exq-solutions-dev"
      + sql_server_user_details = (known after apply)
    }

  # module.frontend_hosting.google_firebase_hosting_site.dashboard will be created
  + resource "google_firebase_hosting_site" "dashboard" {
      + default_url = (known after apply)
      + id          = (known after apply)
      + name        = (known after apply)
      + project     = "exq-solutions-dev"
      + site_id     = "exq-admin-dashboard"
      + type        = (known after apply)
    }

  # module.frontend_hosting.google_firebase_project.default will be created
  + resource "google_firebase_project" "default" {
      + display_name   = (known after apply)
      + id             = (known after apply)
      + project        = "exq-solutions-dev"
      + project_number = (known after apply)
    }

  # module.frontend_hosting.google_project_service.firebase will be created
  + resource "google_project_service" "firebase" {
      + disable_on_destroy = false
      + id                 = (known after apply)
      + project            = "exq-solutions-dev"
      + service            = "firebase.googleapis.com"
    }

  # module.frontend_hosting.google_project_service.hosting will be created
  + resource "google_project_service" "hosting" {
      + disable_on_destroy = false
      + id                 = (known after apply)
      + project            = "exq-solutions-dev"
      + service            = "firebasehosting.googleapis.com"
    }

  # module.networking.google_compute_network.main will be created
  + resource "google_compute_network" "main" {
      + auto_create_subnetworks                   = false
      + delete_default_routes_on_create           = false
      + gateway_ipv4                              = (known after apply)
      + id                                        = (known after apply)
      + internal_ipv6_range                       = (known after apply)
      + mtu                                       = (known after apply)
      + name                                      = "main-vpc"
      + network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
      + numeric_id                                = (known after apply)
      + project                                   = "exq-solutions-dev"
      + routing_mode                              = (known after apply)
      + self_link                                 = (known after apply)
    }

  # module.networking.google_compute_router.router will be created
  + resource "google_compute_router" "router" {
      + creation_timestamp = (known after apply)
      + id                 = (known after apply)
      + name               = "main-router"
      + network            = (known after apply)
      + project            = "exq-solutions-dev"
      + region             = "us-central1"
      + self_link          = (known after apply)
    }

  # module.networking.google_compute_router_nat.nat will be created
  + resource "google_compute_router_nat" "nat" {
      + auto_network_tier                   = (known after apply)
      + enable_dynamic_port_allocation      = (known after apply)
      + enable_endpoint_independent_mapping = (known after apply)
      + endpoint_types                      = (known after apply)
      + icmp_idle_timeout_sec               = 30
      + id                                  = (known after apply)
      + min_ports_per_vm                    = (known after apply)
      + name                                = "main-nat"
      + nat_ip_allocate_option              = "AUTO_ONLY"
      + project                             = "exq-solutions-dev"
      + region                              = "us-central1"
      + router                              = "main-router"
      + source_subnetwork_ip_ranges_to_nat  = "ALL_SUBNETWORKS_ALL_IP_RANGES"
      + tcp_established_idle_timeout_sec    = 1200
      + tcp_time_wait_timeout_sec           = 120
      + tcp_transitory_idle_timeout_sec     = 30
      + udp_idle_timeout_sec                = 30
    }

  # module.networking.google_compute_subnetwork.private will be created
  + resource "google_compute_subnetwork" "private" {
      + creation_timestamp         = (known after apply)
      + external_ipv6_prefix       = (known after apply)
      + fingerprint                = (known after apply)
      + gateway_address            = (known after apply)
      + id                         = (known after apply)
      + internal_ipv6_prefix       = (known after apply)
      + ip_cidr_range              = "10.0.1.0/24"
      + ipv6_cidr_range            = (known after apply)
      + name                       = "private-subnet"
      + network                    = (known after apply)
      + private_ip_google_access   = true
      + private_ipv6_google_access = (known after apply)
      + project                    = "exq-solutions-dev"
      + purpose                    = (known after apply)
      + region                     = "us-central1"
      + secondary_ip_range         = (known after apply)
      + self_link                  = (known after apply)
      + stack_type                 = (known after apply)
    }

Plan: 16 to add, 0 to change, 0 to destroy.

─────────────────────────────────────────────────────────────────────────────
```
</details>

---

---

## **🔒 Seguridad y Buenas Prácticas**

* **State Management:** El archivo de estado (`terraform.tfstate`) se almacena de forma remota en un bucket de GCS con bloqueo (locking) para evitar colisiones entre despliegues.  
* **Secrets Management:** Ninguna credencial está hardcodeada; se utilizan variables de entorno y **GCP Secret Manager**.  
* **Least Privilege:** Los recursos se crean con los permisos mínimos necesarios para su funcionamiento.

