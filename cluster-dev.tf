# Create a GKE cluster
resource "google_container_cluster" "dev" {
  project    = local.project_svc2
  name       = "dev-cluster"
  location   = local.region
  network    = local.sharec_vpc_link
  subnetwork = google_compute_subnetwork.gke_subnet_dev.self_link

  remove_default_node_pool = true
  initial_node_count       = 1

  default_max_pods_per_node = 64

  deletion_protection = false

  workload_identity_config {
    workload_pool = "${local.project_svc2}.svc.id.goog"
  }
  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes    = true

    master_ipv4_cidr_block = "172.16.1.0/28"
  }

  ip_allocation_policy {
    # cluster_ipv4_cidr_block       = local.svc2_pod_range
    # services_ipv4_cidr_block      = local.svc2_service_range
    cluster_secondary_range_name  = google_compute_subnetwork.gke_subnet_dev.secondary_ip_range[0].range_name
    services_secondary_range_name = google_compute_subnetwork.gke_subnet_dev.secondary_ip_range[1].range_name
    # services_secondary_range_name = google_compute_subnetwork.gke_subnet_dev_secondary.name
  }

  master_authorized_networks_config {
    gcp_public_cidrs_access_enabled = false
    cidr_blocks {
      cidr_block   = "10.0.0.0/8"
      display_name = "prod-network gke subnet"
    }
  }


  node_config {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.dev-sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    preemptible = true
  }
}

resource "google_container_node_pool" "dev_primary_app_nodes" {
  name     = "primary-app-nodes"
  location = local.region
  cluster  = google_container_cluster.dev.name
  project  = local.project_svc2

  autoscaling {
    min_node_count = 0
    max_node_count = 30
  }

  node_config {
    preemptible  = true
    machine_type = "n2-standard-4"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.dev-sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
