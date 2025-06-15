terraform {
  backend "remote" {

    organization = "heartwork-jp"

    workspaces {
      name = "ratings-service"
    }
  }
}