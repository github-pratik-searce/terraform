terraform {
  backend "gcs" {
    bucket = "pratik-s3-testing-bucket"
    prefix = "mv-stg-applications-hub-01/staging/us-east4/networking/"
  }
}
