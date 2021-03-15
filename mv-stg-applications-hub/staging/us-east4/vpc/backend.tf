terraform {
  backend "gcs" {
    bucket = "pratik-s3-testing-bucket"
    prefix = "mv-stg-applications-hub/staging/us-east4/networking/"
  }
}
