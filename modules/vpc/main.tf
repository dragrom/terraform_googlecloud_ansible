resource "aws_vpc" "this" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "${var.vpc_tag}"
    }
}

resource "aws_internet_gateway" "this" {
    vpc_id = "${aws_vpc.this.id}"
}

# Define public subnet

resource "aws_subnet" "this" {
    vpc_id            = "${aws_vpc.this.id}"
    cidr_block        = "${var.public_subnet_cidr}"
    availability_zone = "${var.availability_zone}"
    tags {
        Name = "Public Subnet"
    }
}

# Route table for Public Subnet

resource "aws_route_table" "this" {
    vpc_id = "${aws_vpc.this.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.this.id}"
    }
    tags {
        Name = "Public Subnet"
    }
}

resource "aws_route_table_association" "eu-west-1a-public" {
    subnet_id      = "${aws_subnet.this.id}"
    route_table_id = "${aws_route_table.this.id}"
}
