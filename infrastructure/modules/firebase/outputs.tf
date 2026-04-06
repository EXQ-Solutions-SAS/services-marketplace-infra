output "hosting_site_id" {
  value = google_firebase_hosting_site.dashboard.site_id
}

output "hosting_default_url" {
  value = "https://${google_firebase_hosting_site.dashboard.site_id}.web.app"
}