terraform {
  backend "gcs" {
    bucket = "pratik-s3-testing-bucket"
    prefix = "mv-prod-observer/production/us-east4/gke-cluster/"
  }
}

