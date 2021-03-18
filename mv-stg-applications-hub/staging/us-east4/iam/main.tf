resource "google_service_account" "service_account" {
  account_id   = var.account_id
  display_name = "Service Account"
  project      = var.project
}

