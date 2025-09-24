provider "aws" {
    region = "eu-central-1"
    default_tags {
        tags = {
            Environment = "prod"
            deployment       = "terraform"
            Project     = "https://github.com/joe-demetrios/base-infra"
            }
    }
}