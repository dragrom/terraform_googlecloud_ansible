resource "google_container_cluster" "kubernetes" {
    name = "${var.name}"
    zone = "${var.region}"
    initial_node_count = "${var.initial_node_count}"

    master_auth {
      username = "${var.cluster_username}"
      password = "${var.cluster_password}"
    }

    network    = "${var.network}"
    subnetwork = "${var.subnetwork}"

    node_config {
      machine_type = "f1-micro"
      oauth_scopes = [
        "https://www.googleapis.com/auth/compute",
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring"
      ]
    }
}