variable google_credentials {
    description = "Google account file will be provides privat"
    default     = "/mnt/d/account.json"
}

variable vpc_name {
    default = "project"
}

variable subnet_cidr {
    default = "10.10.0.0/24"
}

variable cluster_username {
    default = "my_user"
}

variable cluster_password {
    default = "mypasswordforcluster"
}