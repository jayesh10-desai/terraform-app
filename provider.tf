terraform {
  backend "remote" {
    organization = "jkspractise"

    workspaces {
      name = "test-space"
    }
  }
}

provider "azurerm" {
	features {}
}
