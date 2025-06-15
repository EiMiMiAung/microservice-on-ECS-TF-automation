terraform {
  backend "remote" {

    organization = "heartwork-jp"

    workspaces {
      name = "product-page-service"
    }
  }
}