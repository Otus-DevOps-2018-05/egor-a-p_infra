variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "reddit-app-base"
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

variable db_address {
  description = "Mongo address"
}

variable machine_type {
  description = "Type of google instance"
  default     = "g1-small"
}

variable enable_app_deploy {
  description = "Deploy reddit application"
}
