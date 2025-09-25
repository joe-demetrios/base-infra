data "aws_iam_openid_connect_provider" "github_actions" {
    count = var.create ? 1 : 0
    url = "token.actions.githubusercontent.com"
}

data "aws_iam_policy_document" "this_trust_policy" {
    count = var.create ? 1 : 0
    statement {
        effect = "Allow"
        actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
        type = "Federated"
        identifiers = [data.aws_iam_openid_connect_provider.github_actions.arn]
    }
    condition {
        test = "StringEquals"
        variable = "token.actions.githubusercontent.com:aud"
        values = [ "sts.amazonaws.com" ]
        }
    condition {
        test = "StringLike"
        variable = "token.actions.githubusercontent.com:sub"
        values = [ for branch in var.branches : branch == "*" ? "repo:joe-demetrios/${var.repo_name}:ref:*" : "repo:joe-demetrios/${var.repo_name}:ref:refs/heads/${branch}" ]
        }   
    }

}

resource "aws_iam_role" "this"{
    count = var.create ? 1 : 0
    name = var.name
    assume_role_policy = data.aws_iam_policy_document.trust_policy[0].json
    description = var.description
}

resource "aws_iam_role_policy_attachment" "this_managed"{
    for_each = toset(var.managed_policies)
    role = aws_iam_role.this[0].name
    policy_arn = "arn:aws:iam::aws:policy/${each.value}"
}

resource "aws_iam_policy" "this_policy" {
    count = (var.custom_policy != null && var.create ==1) ? 1 :0 

    name        = "${var.name}_custom_policy"
    path        = "/"
    description = "custom policy for ${var.name}"

    # Terraform's "jsonencode" function converts a
    # Terraform expression result to valid JSON syntax.
    policy = jsonencode(var.custom_policy)
}

resource "aws_iam_role_policy_attachment" "this_custom" {
    count = (var.custom_policy != null && var.create == 1 ) ? 1 :0 
    role = aws_iam_role.this[0].name
    policy_arn = aws_iam_policy.this_policy[0].arn
}


