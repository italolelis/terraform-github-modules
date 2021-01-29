output "name" {
  value       = github_repository.this.name
  description = "The name of the repository."
}

output "repo_id" {
  value       = github_repository.this.repo_id
  description = "The repository ID."
}

output "full_name" {
  value = github_repository.this.full_name

  description = "A string of the form `orgname/reponame`."
}

output "html_url" {
  value = github_repository.this.html_url

  description = "URL to the repository on the web."
}

output "ssh_clone_url" {
  value = github_repository.this.ssh_clone_url

  description = "URL that can be provided to `git clone` to clone the repository via SSH."
}

output "http_clone_url" {
  value = github_repository.this.http_clone_url

  description = "URL that can be provided to `git clone` to clone the repository via HTTPS."
}

output "git_clone_url" {
  value = github_repository.this.git_clone_url

  description = "URL that can be provided to `git clone` to clone the repository anonymously via the git protocol."
}

output "svn_url" {
  value = github_repository.this.svn_url

  description = "URL that can be provided to svn checkout to check out the repository via GitHub's Subversion protocol emulation."
}
