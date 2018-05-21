output "lb_ip" {
  value = "${module.3_kubernetes_containers.lb_ip}"
}

output "host_name" {
  value = "${module.3_kubernetes_containers.host_name}"
}

output "endpoint" {
    value = "${module.2_kubernetes_cluster.endpoint}"
}