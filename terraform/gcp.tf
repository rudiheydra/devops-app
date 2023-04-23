terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.59.0"
    }
    # mongodbatlas = {
    #   source  = "mongodb/mongodbatlas"
    #   version = ">= 0.6"
    # }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 2.0"
    }
  }
}
provider "google" {
  
  project         = var.google_project_id
  region          = var.google_region
  zone            = var.google_zone
  credentials     = file("devops-app-key.json")
  
}

# IP ADDRESS
resource "google_compute_address" "ip_address" {
  name = "devops-app-ip-${terraform.workspace}"
}

# NETWORK
data "google_compute_network" "default" {
  name = "default"
}

# FIREWALL RULE
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-${terraform.workspace}"
  network = data.google_compute_network.default.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["allow-http-${terraform.workspace}"]
}

# OS IMAGE
data "google_compute_image" "cos_image" {
  family = "cos-105-lts"
  project = "cos-cloud"
}

# COMPUTE ENGINE INSTANCE
resource "google_compute_instance" "instance" {
  name         = "${var.app_name}-vm-${terraform.workspace}"
  machine_type = var.google_machine_type
  zone         = var.google_zone

  tags = google_compute_firewall.allow_http.target_tags

  boot_disk {
    initialize_params {
      image = data.google_compute_image.cos_image.self_link
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
      nat_ip = google_compute_address.ip_address.address
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    scopes = ["storage-ro"]
  }
}
