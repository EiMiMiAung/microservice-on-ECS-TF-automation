terraform {
  backend "remote" {

    organization = "heartwork-jp"

    workspaces {
      name = "reviews-service"
    }
  }
}