resource "github_actions_organization_secret" "this" {
  count = length(var.secrets)

  secret_name             = var.secrets[count.index].name
  visibility              = var.secrets[count.index].visibility
  plaintext_value         = var.secrets[count.index].plaintext_value
  selected_repository_ids = var.secrets[count.index].repositories
}
