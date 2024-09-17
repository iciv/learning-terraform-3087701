### Begin: Defaults
# Specify a zone for a domain
resource "aws_route53_zone" "viacash_com" {
  name = "viacash.com"
}

# NS records are automatically created by AWS Route 53, so no need to define them.
### End: Defaults

### Begin: Combined CAA configuration
resource "aws_route53_record" "viacash_com_caa_combined" {
  zone_id = aws_route53_zone.viacash_com.zone_id
  name    = ""
  type    = "CAA"
  ttl     = 3600
  records = [
    "0 issue \"digicert.com\"",
    "0 issue \"comodo.com\"",
    "0 issue \"letsencrypt.org\"",
    "0 issue \"globalsign.com\"",
    "0 issue \"sectigo.com\"",
    "0 issue \"amazon.com\""
  ]
}
### End: Combined CAA configuration

### Begin: Custom Entries

# Handle A-record for the root domain
resource "aws_route53_record" "viacash_com_domainwide_a" {
  zone_id = aws_route53_zone.viacash_com.zone_id
  name    = ""
  type    = "A"
  ttl     = 3600
  records = ["94.130.121.74"]
}

# Handle A-record for controlcenter
resource "aws_route53_record" "viacash_com_controlcenter_a" {
  zone_id = aws_route53_zone.viacash_com.zone_id
  name    = "controlcenter"
  type    = "A"
  ttl     = 3600
  records = ["80.82.206.134"]
}

# Handle A-record for customers
resource "aws_route53_record" "viacash_com_customers_a" {
  zone_id = aws_route53_zone.viacash_com.zone_id
  name    = "customers"
  type    = "A"
  ttl     = 3600
  records = ["80.82.206.130"]
}

# Handle A-record for customers-sandbox
resource "aws_route53_record" "viacash_com_customers_sandbox_a" {
  zone_id = aws_route53_zone.viacash_com.zone_id
  name    = "customers-sandbox"
  type    = "A"
  ttl     = 3600
  records = ["80.82.206.132"]
}

# Handle AAAA-record for the root domain
resource "aws_route53_record" "viacash_com_domainwide_aaaa" {
  zone_id = aws_route53_zone.viacash_com.zone_id
  name    = ""
  type    = "AAAA"
  ttl     = 3600
  records = ["2a01:4f8:10a:2cd8::74"]
}

# Handle CNAME-record for autodiscover
resource "aws_route53_record" "viacash_com_autodiscover_cname" {
  zone_id = aws_route53_zone.viacash_com.zone_id
  name    = "autodiscover"
  type    = "CNAME"
  ttl     = 3600
  records = ["autodiscover.outlook.com"]
}

# Handle CNAME-record for selector1._domainkey
resource "aws_route53_record" "viacash_com_selector1dkey_cname" {
  zone_id = aws_route53_zone.viacash_com.zone_id
  name    = "selector1._domainkey"
  type    = "CNAME"
  ttl     = 3600
  records = ["selector1-viacash-com._domainkey.skrill.onmicrosoft.com"]
}

# Handle CNAME-record for selector2._domainkey
resource "aws_route53_record" "viacash_com_selector2dkey_cname" {
  zone_id = aws_route53_zone.viacash_com.zone_id
  name    = "selector2._domainkey"
  type    = "CNAME"
  ttl     = 3600
  records = ["selector2-viacash-com._domainkey.skrill.onmicrosoft.com"]
}

# Handle CNAME-record for cdn
resource "aws_route53_record" "viacash_com_cdn_cname" {
  zone_id = aws_route53_zone.viacash_com.zone_id
  name    = "cdn"
  type    = "CNAME"
  ttl     = 3600
  records = ["viacashcdn-4bb3.kxcdn.com"]
}

# Handle CNAME-record for www
resource "aws_route53_record" "viacash_com_www_cname" {
  zone_id = aws_route53_zone.viacash_com.zone_id
  name    = "www"
  type    = "CNAME"
  ttl     = 3600
  records = ["d38kw21wqboq8q.cloudfront.net"]
}

# Handle CNAME-record for AWS marketing validation
resource "aws_route53_record" "viacash_com_aws_cname_validation" {
  zone_id = aws_route53_zone.viacash_com.zone_id
  name    = "_2397affbbf4ce64a15a76ba9d39c8ad6"
  type    = "CNAME"
  ttl     = 3600
  records = ["_163c4d2eee80085cdfb784592df0f927.mhbtsbpdnt.acm-validations.aws"]
}

# Handle CNAME-record for www AWS marketing validation
resource "aws_route53_record" "viacash_com_www_aws_cname_validation" {
  zone_id = aws_route53_zone.viacash_com.zone_id
  name    = "_7fd343ecf1e79c869a7e8fefa7a6e28b.www"
  type    = "CNAME"
  ttl     = 3600
  records = ["_d903cdbdf73e05a8809c9335a364059b.mhbtsbpdnt.acm-validations.aws"]
}

# Handle MX-record for the root domain
resource "aws_route53_record" "viacash_com_mx1" {
  zone_id = aws_route53_zone.viacash_com.zone_id
  name    = ""
  type    = "MX"
  ttl     = 3600
  records = ["0 paysafe-com.mail.protection.outlook.com"]
}

# Combined TXT records for SPF, Google Site Verification, and Paysafe Verification
resource "aws_route53_record" "viacash_com_txt_combined" {
  zone_id = aws_route53_zone.viacash_com.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 3600
  records = [
    "v=spf1 a mx include:spf.protection.outlook.com -all",
    "google-site-verification=uNE3x98J65aaMwakH3VgwDqYadXOtNFrQoZadmMQhWU",
    "MS=ms69069745"
  ]
}

# DMARC TXT record (report-only)
resource "aws_route53_record" "viacash_com_dmarc" {
  zone_id = aws_route53_zone.viacash_com.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DMARC1; p=reject; ruf=mailto:admin@viafintech.com; fo=1"]
}

### End: Custom Entries
