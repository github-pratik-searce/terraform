terraform {
  backend "gcs" {
    bucket = "pratik-s3-testing-bucket"
    prefix = "mv-stg-applications-hub-01/staging/asia-south1/gke-cluster/"
  }
}

