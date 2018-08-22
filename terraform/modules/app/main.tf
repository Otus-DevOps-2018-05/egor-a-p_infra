resource "google_compute_instance" "app" {
  name = "reddit-app"

  machine_type = "${var.machine_type}"

  zone = "${var.zone}"

  tags = [
    "app",
  ]

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}

locals {
  app_external_ip = "${google_compute_instance.app.network_interface.0.access_config.0.assigned_nat_ip}"
}

resource "null_resource" "app_deploy" {
  count = "${var.enable_app_deploy == "true" ? 1 : 0}"

  triggers {
    app_instance_id = "${google_compute_instance.app.id}"
  }

  connection {
    host        = "${local.app_external_ip}"
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "file" {
    content     = "${data.template_file.puma.rendered}"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }
}

data "template_file" "puma" {
  template = "${file("${path.module}/files/puma.service")}"

  vars {
    db_address = "${var.db_address}"
  }
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}
