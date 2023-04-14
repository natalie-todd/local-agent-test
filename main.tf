terraform {
  cloud {
    workspaces {
      name = "agent-test"
    }
    organization = "ntodd"
    hostname = "app.staging.terraform.io"
  }

  required_providers {
    null = {
      source = "hashicorp/null"
      version = "3.1.1"
    }
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

variable "username" {
  type = string
  default = "last_name"
}

resource "null_resource" "random" {
  triggers = {
    username = var.username
  }
}

resource "random_pet" "always_new" {
  keepers = {
    uuid = uuid()
  }
  length = 6
}

output "username" {
  value = "Username is ${var.username}"
}

output "random" {
  #  all resources that are invoked as variables have an accessible id attribute
  value = "Changed to ${null_resource.random.id}"
}

output "pet" {
  value = { name_of_pet : random_pet.always_new.id }
}

output "pet_length" {
  value = "Length is ${random_pet.always_new.length}"
}
