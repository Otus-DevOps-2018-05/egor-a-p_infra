terraform {
  backend "gcs" {
    bucket = "storage-bucket-infra-prod"
    prefix  = "terraform/tfstate"
  }
}
