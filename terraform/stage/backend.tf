terraform {
  backend "gcs" {
    bucket = "storage-bucket-infra-stage"
    prefix = "terraform/tfstate"
  }
}
