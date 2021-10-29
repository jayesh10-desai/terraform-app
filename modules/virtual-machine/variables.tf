variable "vm-config" {
  type = object({
      name = string
      size = string
      username = string
  })
}

variable "resource-group" {}

variable "location" {}

variable "subnet-id" {}
