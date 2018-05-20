# define kubernetes provider

provider "kubernetes" {
  host                   = "${var.host}"
  username               = "${var.username}"
  password               = "${var.password}"
  cluster_ca_certificate = "${var.cluster_ca_certificate}"
  client_certificate     = "${var.client_certificate}"
  client_key             = "${var.client_key}"
}

# Create pod

resource "kubernetes_pod" "this" {

    metadata {
        name = "${var.name}"
        labels {
            App = "${var.name}"
        }
    }

    spec {
        container {
            image = "${var.os_image}"
            name  = "${var.name}"

            port {
                container_port = 80
            }


            resources {
                limits {
                    cpu    = "0.5"
                    memory = "512Mi"
                }
                requests {
                    cpu    = "250m"
                    memory = "50Mi"
                }
            }
        }
    }
}

resource "kubernetes_replication_controller" "this" {
  
    metadata {
        name = "${var.name}"
        labels {
            App = "${var.name}"
        }
    }

    spec {
        replicas = "${var.container_numbers}"
        selector {
            App = "${var.name}"
        }
        template {
        container {
            image = "${var.os_image}"
            name  = "${var.name}"

            port {
                container_port = 80
            }


            resources {
            limits {
                cpu    = "0.5"
                memory = "512Mi"
            }
            requests {
                cpu    = "250m"
                memory = "50Mi"
            }
            }
        }
        }
    }
}

resource "kubernetes_service" "this" {
    metadata {
        name = "${var.name}"
    }
    spec {
        selector {
            App = "${kubernetes_replication_controller.this.metadata.0.labels.App}"
        }
        port {
            name        = "web"
            port        = 80
            target_port = 80
        }

        type = "LoadBalancer"
    }
}