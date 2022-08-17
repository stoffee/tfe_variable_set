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

#data "tfe_organization" "foo" {
#  name = "cdunlap"
#}

#output "org" {
#  description = "Org Name"
#  value       = data.tfe_organization.foo.name
#}

#output "email" {
#  description = "Org Email"
#  value       = data.tfe_organization.foo.email
#}

#resource "tfe_variable_set" "test" {
#  name         = "Test Varset"
#  description  = "Some description."
#  organization = data.tfe_organization.foo.name
#}

data "tfe_workspace" "test" {
  name         = "tfe_variable_set"
  organization = tfe_organization.test.name
}
resource "tfe_workspace_variable_set" "test" {
  workspace_id    = "tfe_variable_set"
  variable_set_id = tfe_variable_set.test.id
}
resource "tfe_variable_set" "test" {
  name          = "Test Varset"
  description   = "Some description."
  organization  = "cdunlap"
}
resource "tfe_variable" "test-a" {
  key             = "seperate_variable"
  value           = "my_value_name"
  category        = "terraform"
  description     = "a useful description"
  variable_set_id = tfe_variable_set.test.id
}