provider "github" {
  token        = var.github_token
  organization = var.github_organization
}

module "my_org" {
  source = "./modules/org"

  secrets = [
    {
      name            = "MY_COOL_ORG_SECRET"
      plaintext_value = var.ny_org_secret
      visibility      = "private"
      repositories    = []
    }
  ]
}
