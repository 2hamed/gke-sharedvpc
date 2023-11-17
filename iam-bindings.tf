resource "google_project_iam_binding" "svc-project-networkUser" {
  project = local.host_project
  role    = "roles/compute.networkUser"

  members = [
    "serviceAccount:${local.host_project_number}@cloudservices.gserviceaccount.com",
    "serviceAccount:service-${local.host_project_number}@container-engine-robot.iam.gserviceaccount.com",

    "serviceAccount:${local.project_svc1_number}@cloudservices.gserviceaccount.com",
    "serviceAccount:service-${local.project_svc1_number}@container-engine-robot.iam.gserviceaccount.com",

    "serviceAccount:${local.project_svc2_number}@cloudservices.gserviceaccount.com",
    "serviceAccount:service-${local.project_svc2_number}@container-engine-robot.iam.gserviceaccount.com",
  ]
}
#roles/container.serviceAgent
resource "google_project_iam_binding" "host-project-gke-sa" {
  project = local.host_project
  role    = "roles/container.serviceAgent"

  members = [
    "serviceAccount:${local.project_svc1_number}@cloudservices.gserviceaccount.com",
    "serviceAccount:service-${local.project_svc1_number}@container-engine-robot.iam.gserviceaccount.com",

    "serviceAccount:${local.project_svc2_number}@cloudservices.gserviceaccount.com",
    "serviceAccount:service-${local.project_svc2_number}@container-engine-robot.iam.gserviceaccount.com",

    "serviceAccount:${local.host_project_number}@cloudservices.gserviceaccount.com",
    "serviceAccount:service-${local.host_project_number}@container-engine-robot.iam.gserviceaccount.com",
  ]
}

resource "google_project_iam_binding" "svc-project-hostServiceAgentUser" {
  project = local.host_project
  role    = "roles/container.hostServiceAgentUser"

  members = [
    "serviceAccount:service-${local.project_svc1_number}@container-engine-robot.iam.gserviceaccount.com",
    "serviceAccount:service-${local.project_svc2_number}@container-engine-robot.iam.gserviceaccount.com",
  ]
}

resource "google_project_iam_binding" "svc-gke-security-agent" {
  project = local.host_project
  role    = "projects/${google_project_iam_custom_role.host-project-role.project}/roles/${google_project_iam_custom_role.host-project-role.role_id}"


  members = [
    "serviceAccount:service-${local.project_svc1_number}@container-engine-robot.iam.gserviceaccount.com",
    "serviceAccount:service-${local.project_svc2_number}@container-engine-robot.iam.gserviceaccount.com",
  ]
}