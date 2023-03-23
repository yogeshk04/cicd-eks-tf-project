terraform {
  backend "s3" {
    bucket = "arsreportbucket"
    region = "eu-central-1"
    key = "jenkins-server/terraform.tfstate"
  }
}