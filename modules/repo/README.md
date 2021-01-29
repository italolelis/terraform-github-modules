# terraform-github-repo

A terraform module to create a managed GitHub repositories. Available through the Terraform registry.

## Usage example

A full example can be found at [examples/] directory.

```terraform
module "my-new-repo" {
  source = "./modules/repo"

  name               = "my-new-repo"
  description        = "A description for a new repo"
  topics             = ["go", "fun"]
  gitignore_template = "Go"
  auto_init          = true
  is_template        = false
  teams              = { (github_team.my-team.id) = "push" }
  template           = {
    owner      = "my-org"
    repository = "my-template-repo"
  }
}
```

## Conditional Creation

Sometimes you need to have a way to create repository resources conditionally, but Terraform does not allow to use `count` inside `module` block, so the solution is to specify an argument `create_repo`.

```terraform
# This cluster will not be created
module "my-new-repo" {
  source = "terraform-github-modules/repo"

  create_repo = true
  # ... omitted
}
```

## Importing tool

Most of the time you already have a GitHub organization and a lot of repositories. In these cases you have 2 options: The first one, use the module with _Conditional Creation_ where the repo creation would be set to false. The second one use our importing tool!!

To import your repositories to a state file all you need to do is:

```sh
module-importer github all --github-token=XXXXX --org=my-org
```

This will import all you repositories into your Terraform state file. It will also create 2 files `private-repos.tf` and `public-repos.tf` to make it easier for you to manage.

To know what else you can do with the tool check out the help command.

```sh
module-importer help
```

## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/italolelis/terraform-github-repo/issues/new) section.

Full contributing [guidelines are covered here](.github/CONTRIBUTING.md).

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.9 |
| github | >= 2.6.1 |

## Providers

| Name | Version |
|------|---------|
| github | >= 2.6.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow\_merge\_commit | Set to false to disable merge commits on the repository. | `bool` | `true` | no |
| allow\_rebase\_merge | Set to false to disable rebase merges on the repository. | `bool` | `true` | no |
| allow\_squash\_merge | Set to false to disable squash merges on the repository. | `bool` | `true` | no |
| archived | Specifies if the repository should be archived. Defaults to false. NOTE Currently, the API does not support unarchiving. | `bool` | `false` | no |
| auto\_init | Set to true to produce an initial commit in the repository. | `bool` | `false` | no |
| branch\_protection | Branches to enforce PR reviews. | <pre>map(object({<br>    enforce_admins = bool<br>    required_status_checks = object({<br>      strict   = bool<br>      contexts = list(string)<br>    })<br>    required_pull_request_reviews = object({<br>      dismiss_stale_reviews      = bool<br>      dismissal_users            = list(string)<br>      dismissal_teams            = list(string)<br>      require_code_owner_reviews = bool<br>    })<br>    restrictions = object({<br>      users            = list(string)<br>      teams            = list(string)<br>    })<br>  }))</pre> | `{}` | no |
| collaborators | Map of collaborator usernames and permissions. | `map(string)` | `{}` | no |
| default\_branch | The name of the default branch of the repository. | `string` | `""` | no |
| delete\_branch\_on\_merge | Automatically delete head branch after a pull request is merged. Defaults to false. | `bool` | `false` | no |
| description | A description of the repository. | `string` | n/a | yes |
| gitignore\_template | Use the name of the template without the extension. For example, 'Go'. | `string` | `""` | no |
| has\_issues | Set to true to enable the GitHub Issues features on the repository. | `bool` | `false` | no |
| has\_projects | Set to true to enable the GitHub Projects features on the repository. Per the GitHub documentation when in an organization that has disabled repository projects it will default to false and will otherwise default to true. If you specify true when it has been disabled it will return an error. | `bool` | `false` | no |
| has\_wiki | Set to true to enable the GitHub Wiki features on the repository. | `bool` | `false` | no |
| homepage\_url | URL of a page describing the project. | `string` | `""` | no |
| is\_template | Set to true to tell GitHub that this is a template repository. | `bool` | `false` | no |
| labels | Map of issues label names and colors. | `map(string)` | `{}` | no |
| license\_template | Use the name of the template without the extension. For example, 'mit' or 'mpl-2.0'. | `string` | `""` | no |
| name | The name of the repository. | `string` | n/a | yes |
| private | Set to true to create a private repository. Repositories are created as public (e.g. open source) by default. | `bool` | `false` | no |
| secrets | The repository secrets | `map(string)` | `{}` | no |
| teams | Map of team IDs and permissions. | `map(string)` | `{}` | no |
| template | Use a template repository to create this resource. | <pre>object({<br>    owner      = string<br>    repository = string<br>  })</pre> | <pre>{<br>  "owner": "",<br>  "repository": ""<br>}</pre> | no |
| topics | The list of topics of the repository. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| full\_name | A string of the form `orgname/reponame`. |
| git\_clone\_url | URL that can be provided to `git clone` to clone the repository anonymously via the git protocol. |
| html\_url | URL to the repository on the web. |
| http\_clone\_url | URL that can be provided to `git clone` to clone the repository via HTTPS. |
| name | The name of the repository. |
| ssh\_clone\_url | URL that can be provided to `git clone` to clone the repository via SSH. |
| svn\_url | URL that can be provided to svn checkout to check out the repository via GitHub's Subversion protocol emulation. |
