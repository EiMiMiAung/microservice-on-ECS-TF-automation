terraform {
  backend "remote" {

    organization = "heartwork-jp"

    workspaces {
      name = "details-service"
    }
  }
}