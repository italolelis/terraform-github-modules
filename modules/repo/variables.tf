variable "name" {
  type        = string
  description = "The name of the repository."
}

variable "description" {
  type        = string
  description = "A description of the repository."
}

variable "homepage_url" {
  type        = string
  description = "URL of a page describing the project."
  default     = ""
}

variable "visibility" {
  type        = string
  description = "(Optional) Can be public or private. If your organization is associated with an enterprise account using GitHub Enterprise Cloud or GitHub Enterprise Server 2.20+, visibility can also be internal. The visibility parameter overrides the private parameter."
}

variable "has_issues" {
  type        = bool
  default     = false
  description = "Set to true to enable the GitHub Issues features on the repository."
}

variable "has_projects" {
  type        = bool
  default     = false
  description = "Set to true to enable the GitHub Projects features on the repository. Per the GitHub documentation when in an organization that has disabled repository projects it will default to false and will otherwise default to true. If you specify true when it has been disabled it will return an error."
}

variable "has_wiki" {
  type        = bool
  default     = false
  description = "Set to true to enable the GitHub Wiki features on the repository."
}

variable "is_template" {
  type        = bool
  default     = false
  description = "Set to true to tell GitHub that this is a template repository."
}

variable "allow_merge_commit" {
  type        = bool
  default     = true
  description = "Set to false to disable merge commits on the repository."
}

variable "allow_squash_merge" {
  type        = bool
  default     = true
  description = "Set to false to disable squash merges on the repository."
}

variable "allow_rebase_merge" {
  type        = bool
  default     = true
  description = "Set to false to disable rebase merges on the repository."
}

variable "delete_branch_on_merge" {
  type        = bool
  default     = false
  description = "Automatically delete head branch after a pull request is merged. Defaults to false."
}

variable "auto_init" {
  type        = bool
  default     = false
  description = "Set to true to produce an initial commit in the repository."
}

variable "gitignore_template" {
  type        = string
  description = "Use the name of the template without the extension. For example, 'Go'."
  default     = ""
}

variable "license_template" {
  type        = string
  description = "Use the name of the template without the extension. For example, 'mit' or 'mpl-2.0'."
  default     = ""
}

variable "default_branch" {
  type        = string
  description = "The name of the default branch of the repository."
  default     = "master"
}

variable "archived" {
  type        = bool
  default     = false
  description = "Specifies if the repository should be archived. Defaults to false. NOTE Currently, the API does not support unarchiving."
}

variable "topics" {
  type        = list(string)
  description = "The list of topics of the repository."
  default     = []
}

variable "template" {
  type = object({
    owner      = string
    repository = string
  })
  description = "Use a template repository to create this resource."
  default = {
    owner      = ""
    repository = ""
  }
}

variable "labels" {
  type        = map(string)
  description = "Map of issues label names and colors."
  default     = {}
}

variable "teams" {
  type        = map(string)
  description = "Map of team IDs and permissions."
  default     = {}
}

variable "collaborators" {
  type        = map(string)
  description = "Map of collaborator usernames and permissions."
  default     = {}
}

variable "secrets" {
  type        = map(string)
  description = "The repository secrets"
  default     = {}
}

variable "branch_protection" {
  type = map(object({
    enforce_admins    = bool
    push_restrictions = list(string)
    required_status_checks = object({
      strict   = bool
      contexts = list(string)
    })
    required_pull_request_reviews = object({
      dismiss_stale_reviews      = bool
      require_code_owner_reviews = bool
      dismissal_restrictions     = list(string)
    })
  }))
  description = "Branches to enforce PR reviews."
  default     = {}
}

variable "archive_on_destroy" {
  type        = bool
  description = "(Optional) Set to true to archive the repository instead of deleting on destroy."
  default     = false
}

variable "vulnerability_alerts" {
  type        = bool
  description = "(Optional) - Set to true to enable security alerts for vulnerable dependencies. Enabling requires alerts to be enabled on the owner level. (Note for importing: GitHub enables the alerts on public repos but disables them on private repos by default.) See GitHub Documentation for details."
  default     = false
}
