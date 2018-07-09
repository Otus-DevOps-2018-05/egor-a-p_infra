resource "google_compute_instance" "db" {
  name = "reddit-db"

  machine_type = "${var.machine_type}"

  zone = "${var.zone}"

  tags = [
    "reddit-db",
  ]

  boot_disk {
    initialize_params {
      image = "${var.db_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

locals {
  db_external_ip = "${google_compute_instance.db.network_interface.0.access_config.0.assigned_nat_ip}"
}

resource "null_resource" "db_deploy" {
  count = "${var.enable_app_deploy == "true" ? 1 : 0}"

  triggers {
    app_instance_id = "${google_compute_instance.db.id}"
  }

  connection {
    host        = "${local.db_external_ip}"
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/config.sh"
  }
}
