terraform {
  backend "gcs" {
    bucket = "devops-app-384609-terraform-state"
    prefix = "/state/storybooks"
  }
}