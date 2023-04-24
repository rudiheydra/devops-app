terraform {
  backend "gcs" {
    bucket = "devops-app-384609-terraform"
    prefix = "/state/devops-app"
  }
}