variable "secrets" {
  type = list(object({
    name            = string
    visibility      = string
    plaintext_value = string
    repositories    = list(string)
  }))
  description = "Organization secrets."
  default     = []
}
