terraform {
  backend "gcs" {
    bucket = "pratik-s3-testing-bucket"
    prefix = "mv-stg-applications-hub/staging/asia-south1/gke-cluster/"
  }
}

