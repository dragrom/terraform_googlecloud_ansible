resource "aws_iam_user" "this" {
    name = "${var.name}"
    path = "${var.path}"
}

resource "aws_iam_group" "this" {
    name = "${var.security_group}"
    path = "${var.path}"
}

resource "aws_iam_group_membership" "this" {
    name = "${var.group_membership}"
    users = [
        "${aws_iam_user.this.name}",
    ]
    group = "${aws_iam_group.this.name}"
}

resource "aws_iam_group_policy" "this" {
    name = "${var.group_policy}"
    group = "${aws_iam_group.this.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

