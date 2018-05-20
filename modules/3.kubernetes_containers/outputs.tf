output "lb_ip" {
  value = "${kubernetes_service.this.load_balancer_ingress.0.ip}"
}

output "host_name" {
  value = "${kubernetes_replication_controller.this.spec.0.template.0.hostname}"
}
