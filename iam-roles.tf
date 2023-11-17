resource "google_project_iam_custom_role" "host-project-role" {
  role_id     = "custom.sharedVPCSecurityAgent"
  title       = "GKE Security Agent"
  description = ""
  permissions = [
    "compute.networks.updatePolicy",
    "compute.firewalls.list",
    "compute.firewalls.get",
    "compute.firewalls.create",
    "compute.firewalls.update",
    "compute.firewalls.delete",
  ]
}
