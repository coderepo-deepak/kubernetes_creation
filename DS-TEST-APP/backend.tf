terraform {
  backend "s3" {
    bucket = "ds-test-app-tf-bucket"
    key    = "backend/ToDo-App.tfstate"
    region = "us-east-1"
    #dynamodb_table = "dynamoDB-terra"
  }
}