provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "db" {
  source            = "../modules/db"
  public_key_path   = "${var.public_key_path}"
  zone              = "${var.zone}"
  db_disk_image     = "${var.db_disk_image}"
  private_key_path  = "${var.private_key_path}"
  enable_app_deploy = "${var.enable_app_deploy}"
}

module "app" {
  source            = "../modules/app"
  public_key_path   = "${var.public_key_path}"
  zone              = "${var.zone}"
  app_disk_image    = "${var.app_disk_image}"
  private_key_path  = "${var.private_key_path}"
  db_address        = "${module.db.db_external_ip}"
  enable_app_deploy = "${var.enable_app_deploy}"
}

module "vpc" {
  source = "../modules/vpc"

  source_ranges = [
    "0.0.0.0/0",
  ]
}
