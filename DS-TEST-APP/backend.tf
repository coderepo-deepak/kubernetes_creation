terraform {
  backend "s3" {
    bucket = "deepaks-test"
    key    = "backend/ToDo-App.tfstate"
    region = "us-west-2"
    #dynamodb_table = "dynamoDB-terra"
  }
}