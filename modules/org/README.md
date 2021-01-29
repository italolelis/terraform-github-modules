# Irg module

A terraform module to create a managed GitHub organizations. Available through the Terraform registry.

## Usage example

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.9 |
| github | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| github | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| secrets | Organization secrets. | <pre>list(object({<br>    name            = string<br>    visibility      = string<br>    plaintext_value = string<br>    repositories    = list(string)<br>  }))</pre> | `[]` | no |

## Outputs

No output.
