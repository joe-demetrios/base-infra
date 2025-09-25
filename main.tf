module "" {
    source = "./modules/iam_role"
    name = "test"
    repo_name = "base-infra"
    managed_policies = ["AlexaForBusinessFullAccess"]
}