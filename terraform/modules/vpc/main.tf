resource "google_compute_firewall" "firewall_ssh" {
  name = "default-allow-ssh"

  network = "default"

  allow {
    protocol = "tcp"

    ports = [
      "22",
    ]
  }

  source_ranges = "${var.source_ranges}"

  target_tags = [
    "app",
    "db",
  ]
}

resource "google_compute_firewall" "firewall_puma" {
  name = "allow-puma-default"

  network = "default"

  allow {
    protocol = "tcp"

    ports = [
      "9292",
    ]
  }

  source_ranges = [
    "0.0.0.0/0",
  ]

  target_tags = [
    "app",
  ]
}

resource "google_compute_firewall" "firewall_mongo" {
  name = "allow-mongo-default"

  network = "default"

  allow {
    protocol = "tcp"

    ports = [
      "27017",
    ]
  }

  target_tags = [
    "db",
  ]

  source_ranges = [
    "0.0.0.0/0",
  ]
}
