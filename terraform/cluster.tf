variable "cluster_location" {}
variable "compute_engine_service_account_id" {}

data "google_service_account" "compute_engine" {
  account_id = var.compute_engine_service_account_id
}

data "google_project" "project" {
  project_id = var.project_id
}

resource "google_container_cluster" "primary" {
  provider = google-beta
  name = "cluster-${var.environment}"
  location = var.cluster_location

  ip_allocation_policy {
    cluster_ipv4_cidr_block = "10.12.0.0/14"
    services_ipv4_cidr_block = "10.9.224.0/20"
  }
  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes = true
    master_ipv4_cidr_block = "172.16.0.0/28"
  }
  cluster_autoscaling {
    enabled = true
    autoscaling_profile = "OPTIMIZE_UTILIZATION"
    resource_limits {
      resource_type = "cpu"
      minimum = 2
      maximum = 6
    }
    resource_limits {
      resource_type = "memory"
      minimum = 4
      maximum = 12
    }
  }
  initial_node_count = 1
  remove_default_node_pool = true
  enable_shielded_nodes = true

  addons_config {
    config_connector_config {
      enabled = false
    }
  }
  workload_identity_config {
    identity_namespace = "${data.google_project.project.project_id}.svc.id.goog"
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name = "default-node-pool-${var.environment}"
  location = var.cluster_location
  cluster = google_container_cluster.primary.name
  initial_node_count = 1
  autoscaling {
    min_node_count = 0
    max_node_count = 3
  }

  node_config {
    preemptible = true
    machine_type = "e2-medium"
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = data.google_service_account.compute_engine.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    shielded_instance_config {
      enable_secure_boot = true
      enable_integrity_monitoring = false
    }
  }
}
