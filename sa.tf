resource "google_service_account" "prod-sa" {
  project      = local.project_svc1
  account_id   = "prod-cluster"
  display_name = "Prod Cluster GKE Service Account"
}

resource "google_service_account" "dev-sa" {
  project      = local.project_svc2
  account_id   = "dev-cluster"
  display_name = "Dev Cluster GKE Service Account"
}