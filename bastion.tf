resource "google_service_account" "sebastion" {
  account_id   = "sebastion"
  display_name = "Custom SA for VM Instance"
  project = local.host_project
}

resource "google_compute_instance" "sebastion" {
  name         = "sebastion"
  machine_type = "n2-standard-4"
  zone         = "europe-west1-b"

  project = local.host_project

  tags    = ["sebastion"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network    = local.sharec_vpc_link
    subnetwork = google_compute_subnetwork.subnet1.self_link
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.sebastion.email
    scopes = ["cloud-platform"]
  }
}
