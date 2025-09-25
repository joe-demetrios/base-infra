variable "name" {
    description = "name of the role"
    type = string
}

variable "description" {
    description = "description for role"
    type = string
    default = "Pretty cool description should have been added here... silly me"
}

variable "create" {
  description = "trigger for creating"
  type        = bool
  default     = true
}

variable "repo_name" {
    description = "name of repository to allow role to be assumed by github actions"
    type = string
}

variable "branches" {
    description = "list of branches to allow actions to run on, default is all branches (*)"
    type = list(string)
    default = [ "*" ]
}

variable "managed_policies" {
    description = "list of managed policies"
    type = list(string)
    default = []
}

variable "custom_policy" {
    description = "custom policy attachment for role"
    type = any
    default = null
}
