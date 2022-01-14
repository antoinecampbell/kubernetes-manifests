provider "google-beta" {
  project = var.project_id
}
provider "google" {
  project = var.project_id
}

variable "environment" {}
variable "project_id" {}
variable "region" {}
