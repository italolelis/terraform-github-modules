resource "github_repository" "this" {
  name                   = var.name
  visibility             = var.visibility
  description            = var.description
  homepage_url           = var.homepage_url
  has_wiki               = var.has_wiki
  has_downloads          = false # This is a deprecated functionality in github. For this reason we set it to false by default.
  has_projects           = var.has_projects
  has_issues             = var.has_issues
  allow_merge_commit     = var.allow_merge_commit
  allow_squash_merge     = var.allow_squash_merge
  allow_rebase_merge     = var.allow_rebase_merge
  gitignore_template     = var.gitignore_template
  license_template       = var.license_template
  auto_init              = var.auto_init
  archived               = var.archived
  topics                 = var.topics
  delete_branch_on_merge = var.delete_branch_on_merge
  is_template            = var.is_template
  archive_on_destroy     = var.archive_on_destroy
  vulnerability_alerts   = var.vulnerability_alerts

  dynamic "template" {
    for_each = var.template.owner != "" ? [1] : []

    content {
      owner      = var.template.owner
      repository = var.template.repository
    }
  }
}

# Create all labels for the repository
resource "github_issue_label" "all" {
  for_each = var.labels

  repository = github_repository.this.name
  name       = each.key
  color      = each.value
}

# Associate any team to the repository
resource "github_team_repository" "all" {
  for_each = var.teams

  repository = github_repository.this.name
  team_id    = each.key
  permission = each.value
}

# Add a collaborator to a repository
resource "github_repository_collaborator" "all" {
  for_each = var.collaborators

  repository = github_repository.this.name
  username   = each.key
  permission = each.value
}

## Add branch protection rules
resource "github_branch_protection" "merge-protection" {
  for_each = var.branch_protection

  repository_id     = github_repository.this.name
  pattern           = each.key
  enforce_admins    = each.value.enforce_admins
  push_restrictions = each.value.push_restrictions

  dynamic "required_status_checks" {
    for_each = each.value.required_status_checks == null ? [] : [each.value.required_status_checks]

    content {
      strict   = required_status_checks.value.strict
      contexts = required_status_checks.value.contexts
    }
  }

  dynamic "required_pull_request_reviews" {
    for_each = each.value.required_pull_request_reviews == null ? [] : [each.value.required_pull_request_reviews]

    content {
      dismiss_stale_reviews      = required_pull_request_reviews.value.dismiss_stale_reviews
      dismissal_restrictions     = required_pull_request_reviews.value.dismissal_restrictions
      require_code_owner_reviews = required_pull_request_reviews.value.require_code_owner_reviews
    }
  }
}

## Set secrets to the repository
resource "github_actions_secret" "secret" {
  for_each = var.secrets

  repository      = github_repository.this.name
  secret_name     = each.key
  plaintext_value = each.value
}
