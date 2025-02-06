terraform {
  backend "s3" {
    bucket = "my-ds-test"
    key    = "backend/ToDo-App.tfstate"
    region = "us-west-2"
    #dynamodb_table = "dynamoDB-terra"
  }
}