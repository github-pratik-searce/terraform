terraform {
  backend "gcs" {
    bucket = "pratik-s3-testing-bucket"
    prefix = "gcp-project/staging/asia-south1/gke-cluster/"
  }
}

