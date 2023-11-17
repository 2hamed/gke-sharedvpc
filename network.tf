
# # Create a VPC network
# resource "google_compute_network" "vpc_network" {
#   name                    = "prod-network"
#   auto_create_subnetworks = false

# }
resource "google_compute_subnetwork" "subnet1" {
  name          = "eu-we1-sub1"
  ip_cidr_range = "10.0.0.0/24"
  network       = local.sharec_vpc_link
  region        = local.region
  project       = local.host_project
}

# Create a subnet
resource "google_compute_subnetwork" "gke_subnet_prod" {
  name          = "svc1-gke-subnet"
  ip_cidr_range = local.svc1_gke_subnet
  network       = local.sharec_vpc_link
  region        = local.region
  project       = local.host_project
  secondary_ip_range {
    range_name    = "gke-subnet-prod-secondary"
    ip_cidr_range = local.svc1_pod_secondary_range
  }

  secondary_ip_range {
    range_name    = "gke-subnet-prod-secondary-services"
    ip_cidr_range = local.svc1_service_secondary_range
  }
}

resource "google_compute_subnetwork" "gke_subnet_dev" {
  name          = "svc2-gke-subnet"
  ip_cidr_range = local.svc2_gke_subnet
  network       = local.sharec_vpc_link
  region        = local.region
  project       = local.host_project
  secondary_ip_range {
    range_name    = "gke-subnet-dev-secondary"
    ip_cidr_range = local.svc2_pod_secondary_range
  }
  secondary_ip_range {
    range_name    = "gke-subnet-dev-secondary-services"
    ip_cidr_range = local.svc2_service_secondary_range
  }
}

# Create a firewall rule to allow incoming traffic
resource "google_compute_firewall" "firewall" {
  project = local.host_project
  name    = "gke-firewall"
  network = local.sharec_vpc_link

  allow {
    protocol = "tcp"
    ports    = ["6443", "30000-32767"]
  }

  source_ranges = ["0.0.0.0/0"]

}

resource "google_compute_firewall" "allow-ingress-from-iap" {
  project = local.host_project
  name    = "allow-ingress-from-iap"
  network = local.sharec_vpc_link

  allow {
    protocol = "tcp"
    ports    = ["22", "3389"]
  }

  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["sebastion"]
}

resource "google_compute_firewall" "allow-internal-ssh" {
  project = local.host_project
  name    = "allow-internal-ssh"
  network = local.sharec_vpc_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["10.0.0.0/8"]
}


module "cloud-nat" {
  source  = "terraform-google-modules/cloud-nat/google"
  version = "5.0.0"

  project_id = local.host_project
  region     = local.region

  router        = "prod-router"
  create_router = true
  network       = local.sharec_vpc_link
}
