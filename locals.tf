locals {
  host_project = "pj-vpc-host"
  project_svc1 = "pj-vpc-svc1"
  project_svc2 = "pj-vpc-svc2"

  host_project_number = "12345676543"
  project_svc1_number = "56464352454"
  project_svc2_number = "42342343432"

  region       = "europe-west1"

  sharec_vpc_link = "projects/pj-sbx-vpc-host/global/networks/vpc-shared-primary"

  # IP ranges
  svc1_gke_subnet              = "10.1.0.0/20"
  svc1_pod_range               = "10.1.16.0/20"
  svc1_service_range           = "10.1.32.0/20"
  svc1_pod_secondary_range     = "10.1.48.0/20"
  svc1_service_secondary_range = "10.1.64.0/20"

  svc2_gke_subnet              = "10.2.0.0/20"
  svc2_pod_range               = "10.2.16.0/20"
  svc2_service_range           = "10.2.32.0/20"
  svc2_pod_secondary_range     = "10.2.48.0/20"
  svc2_service_secondary_range = "10.2.64.0/20"

}
