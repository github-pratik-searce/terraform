terraform {
  backend "gcs" {
    bucket = "pratik-s3-testing-bucket"
    prefix = "mv-prod-applications-hub-01/production/us-east4/networking/"
  }
}
