resource "aws_route53_zone" "main" {
  name="demetrios.cloud"
}

data "aws_cloudfront_distribution" "demetrios_cloud_cdn" {
  id = "E1QJD98VBB125S"
}

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "demetrios.cloud"
  type    = "A"
  alias {
    name = data.aws_cloudfront_distribution.demetrios_cloud_cdn.domain_name
    zone_id = data.aws_cloudfront_distribution.demetrios_cloud_cdn.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "bucket" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "bucket.demetrios.cloud"
  type    = "CNAME"
  records = [ "demetrios.cloud" ]
  ttl = 300
}

resource "aws_route53_record" "manor" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "*.manor.demetrios.cloud"
  type    = "CNAME"
  records = [ "manor-drive.bigscale-company.ts.net" ]
  ttl = 300
}

resource "aws_route53_record" "apps" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "apps.demetrios.cloud"
  type    = "AAAA"
  records = [ "2a01:4f8:1c1e:7b8f::1" ]
  ttl = 300
}

resource "aws_route53_record" "wildcard_apps" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "*.apps.demetrios.cloud"
  type    = "AAAA"
  records = [ "2a01:4f8:1c1e:7b8f::1" ]
  ttl = 300
}


