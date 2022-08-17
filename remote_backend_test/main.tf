terraform {
  cloud {
    organization = "cdunlap"
    workspaces {
      name = "tfe_variable_set"
    }
  }
}

terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.36.0"
    }
  }
}

data "tfe_organization" "foo" {
  name = "cdunlap"
}

output "org" {
  description = "Org Name"
  value       = data.tfe_organization.foo.name
}

output "email" {
  description = "Org Email"
  value       = data.tfe_organization.foo.email
}

#resource "tfe_variable_set" "test" {
#  name         = "Test Varset"
#  description  = "Some description."
#  organization = data.tfe_organization.foo.name
#}
resource "tfe_variable_set" "test" {
  name          = "Test Varset"
  description   = "Some description."
  organization  = "cdunlap"
}