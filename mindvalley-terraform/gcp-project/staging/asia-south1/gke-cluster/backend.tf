terraform {
  backend "gcs" {
    bucket = "gke-cluster.tf"
    prefix = "gcp-project/staging/asia-south1/gke-cluster/"
  }
}

