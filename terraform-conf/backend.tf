terraform {
    backend "local" {}
}

provider "aws" {
    profile = "chetan"
}