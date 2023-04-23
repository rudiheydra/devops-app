### GENERAL
variable "app_name" {
  type = string
}
variable "domain" {
  type = string
}

### GCP
variable "google_machine_type" {
    type = string
}
variable "credentials_file" {
  type    = string
  default = "$PWD/storybooks-terraform-devops-key.json"
}
variable "google_project_id" {
  type    = string
  default = "my-project-id"
}
variable "image_name" {
  type    = string
  default = "my-image-name"
}
variable "tag" {
  type    = string
  default = "latest"
}
# variable "google_client_id" {
#   type = string
# }
# variable "google_oauth_client_secret" {
#   type = string
# }
variable "google_zone" {
  type = string
}
variable "google_region" {
  type = string
}

### ATLAS
# variable "atlas_project_id" {
#   type = string
# }
# variable "atlas_user_password" {
#   type = string
# }
# variable "mongodbatlas_public_key" {
#     type = string
# }
# variable "mongodbatlas_private_key" {
#     type = string
# }

### CLOUDFLARE
variable "cloudflare_api_token" {
    type = string
}

