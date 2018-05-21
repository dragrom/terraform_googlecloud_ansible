provider "google" {
    credentials = "${var.google_credentials}"
    project     = "metal-vehicle-204607"
}

# Create a network attached to VPC

module "1_networks" {
  source        = "../modules/1.networks"
  name          = "${var.vpc_name}"
  subnet_cidr   = "${var.subnet_cidr}"
  subnet_region = "europe-west1"
}

module "2_kubernetes_cluster" {
  source             = "../modules/2.kubernetes_cluster"
  name               = "my-kubernetes-cluster"
  region             = "europe-west1-b"
  initial_node_count = 3
  network            = "${var.vpc_name}-vpc"
  subnetwork         = "${var.vpc_name}-subnet"
  cluster_username   = "${var.cluster_username}"
  cluster_password   = "${var.cluster_password}"
}

module "3_kubernetes_containers" {
  source            = "../modules/3.kubernetes_containers"

  host              = "https://${module.2_kubernetes_cluster.endpoint}"
  username = "${var.cluster_username}"
  password = "${var.cluster_password}"
  cluster_ca_certificate = "${module.2_kubernetes_cluster.cluster_ca_certificate}"
  client_certificate     = "${module.2_kubernetes_cluster.client_certificate}"
  client_key             = "${module.2_kubernetes_cluster.client_key}"

  name              = "my-project-containers"
  container_numbers = 2
  os_image          = "nginx:1.7.8"
}