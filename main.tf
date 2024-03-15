provider "google" {
    project = "learning-terraform-220783"
    region = "asia-southeast2"
    zone = "asia-southeast2-c"
}

resource  "google_compute_instance" "my_instance" {
    name = "agoda-instance-1"
    machine_type = "e2-micro"
    zone = "asia-southeast2-c"
    allow_stopping_for_update = true
    
    boot_disk {
      initialize_params {
        image = "debian-cloud/debian-11"
      }
    }

    network_interface {
      network = google_compute_network.terraform_network.self_link
      subnetwork = google_compute_subnetwork.terraform_subnet.self_link
      access_config {
   
      }
    }
}

resource "google_compute_network" "terraform_network" {
  name = "terraform-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "terraform_subnet" {
  name = "terraform-subnetwork"
  ip_cidr_range = "10.185.0.0/16"
  region = "asia-southeast2"
  network = google_compute_network.terraform_network.id
}