# Define the provider for GCP
provider "google" {
  project = local.host_project
  region  = local.region
}

terraform {
  backend "gcs" {
    bucket = "pj-sharedvpc-tfstate"
    prefix = "pj-vpc-svc1/prod-cluster"
  }
}
