/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  cluster_type = "gke-us-east4-applications-hub-01"
}


data "google_client_config" "default" {}

provider "kubernetes" {
  load_config_file       = false
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

data "google_compute_subnetwork" "subnetwork" {
  name    = var.subnetwork
  project = var.project_id
  region  = var.region
}

module "service_account" {
  source = "./../iam"

}

module "gke" {
  source                    = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                = var.project_id
  version                   = "14.0.1"
  name                      = "${local.cluster_type}-cluster${var.cluster_name_suffix}"
  regional                  = true
  region                    = var.region
  network                   = var.network
  subnetwork                = var.subnetwork
  ip_range_pods             = var.ip_range_pods
  ip_range_services         = var.ip_range_services
  create_service_account    = false
  service_account           = service_account.email
  enable_private_endpoint   = true
  enable_private_nodes      = true
  master_ipv4_cidr_block    = "10.140.18.0/28"
  default_max_pods_per_node = 50
  remove_default_node_pool  = true
  depends_on                = [module.service_account]

  node_pools = [
    {
      name              = "platform-normal-1"
      min_count         = 1
      max_count         = 2
      local_ssd_count   = 0
      machine_type      = "e2-small"
      disk_size_gb      = 100
      disk_type         = "pd-standard"
      image_type        = "COS"
      auto_repair       = true
      auto_upgrade      = true
      service_account   = service_account.email
      preemptible       = true
      max_pods_per_node = 3
    }

  ]

  master_authorized_networks = [
    {
      cidr_block   = var.subnet_cidr
      display_name = "VPC"
    },

    {
      cidr_block   = "35.235.240.0/20"
      display_name = "IAP-range"
    },

    {
      cidr_block   = "34.87.13.161/32"
      display_name = "Cloud-shell-range"
    },
  ]

}
