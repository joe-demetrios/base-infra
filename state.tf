terraform {
  backend "s3" {
    bucket         = "demetrios-cloud-terraform"
    key            = "terraform/base-infra.tfstate"
    region         = "eu-central-1"
    use_lockfile   = true
  }
}