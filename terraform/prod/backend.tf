terraform {
  backend "gcs" {
    bucket = "storage-bucket-infra-terraform"
    prefix = "terraform/tfstate/prod"
  }
}
