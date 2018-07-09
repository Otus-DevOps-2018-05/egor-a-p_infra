variable db_disk_image {
  description = "Disk image for reddit db"
  default = "reddit-db-base"
}

variable zone {
  description = "Zone"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for provisioners connection"
}

variable machine_type {
  description = "Type of google instance"
  default = "g1-small"
}

variable enable_app_deploy {
  description = "Deploy reddit application"
}
