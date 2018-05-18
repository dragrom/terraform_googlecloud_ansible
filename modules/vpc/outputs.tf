output "vpc_id" {
    description = "Return VPC ID"
    value       = "${aws_vpc.this.id}"
}