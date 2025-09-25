# module "test" {
#     source = "./modules/iam_role"
#     name = "test"
#     repo_name = "base-infra"
#     custom_policy = <<EOF
#     {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "TaggingPermissions",
#             "Effect": "Allow",
#             "Action": [
#                 "tag:TagResources",
#                 "tag:UntagResources",
#                 "tag:GetResources",
#                 "tag:GetTagKeys",
#                 "tag:GetTagValues"
#             ],
#             "Resource": "*"
#         }
#     ]
# }
# EOF
    
# }