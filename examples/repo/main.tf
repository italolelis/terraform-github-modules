provider "github" {
  token        = var.github_token
  organization = var.github_organization
}

##
## Simple repository creation
##
module "my-simple-repo" {
  source = "../../modules/repo"

  name       = "my-private-repo"
  visibility = "private"
}

##
## Complete repository creation
##
data "github_team" "example" {
  slug = "example"
}

data "github_user" "foo" {
  username = "foo"
}


module "my-private-repo" {
  source = "../../modules/repo"

  name                   = "my-private-repo"
  description            = "A cool repository description"
  visibility             = "private"
  delete_branch_on_merge = true
  vulnerability_alerts   = true
  topics                 = ["any", "cool", "topic"]
  teams                  = { (data.github_team.example.id) = "push" }
  collaborators          = { (data.github_user.foo.username) = "push" }

  labels = {
    "type: bug"          = "d73a4a"
    "type: docs"         = "0f727f"
    "type: feature"      = "a2eeef"
    "type: maintenance"  = "a5f7da"
    "type: dependencies" = "0366d6"
  }

  branch_protection = {
    master = {
      enforce_admins    = true
      push_restrictions = []
      required_status_checks = {
        strict   = true
        contexts = []
      }
      required_pull_request_reviews = {
        dismiss_stale_reviews      = true
        require_code_owner_reviews = true
        dismissal_restrictions     = []
      }
    }
  }
}

##
## Repo creation from a template repo
##
module "my-repo-from-template" {
  source = "../../modules/repo"

  name                   = "my-repo-from-template"
  description            = "A cool repository description"
  visibility             = "private"
  delete_branch_on_merge = true
  vulnerability_alerts   = true
  topics                 = ["any", "cool", "topic"]
  teams                  = { (data.github_team.example.id) = "push" }
  template = {
    owner      = "my-org"
    repository = "go-service-template"
  }
}
