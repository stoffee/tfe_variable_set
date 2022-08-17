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

resource "tfe_workspace" "test" {
  name         = "my-workspace-name"
  organization = "cdunlap"
}

resource "tfe_variable_set" "test" {
  name          = "Test Varset"
  description   = "Some description."
  organization  = "cdunlap"
}

resource "tfe_workspace_variable_set" "test" {
  workspace_id    = tfe_workspace.test.id
  variable_set_id = tfe_variable_set.test.id
}

resource "tfe_variable" "test-a" {
  key             = "seperate_variable"
  value           = "my_value_name"
  category        = "terraform"
  description     = "a useful description"
  variable_set_id = tfe_variable_set.test.id
}

resource "tfe_variable" "test-b" {
  key             = "another_variable"
  value           = "my_value_name"
  category        = "env"
  description     = "an environment variable"
  variable_set_id = tfe_variable_set.test.id
}