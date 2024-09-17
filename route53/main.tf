### Begin: Defaults
# Specify a zone for a domain
resource "aws_route53_zone" "cps_io" {
  name = "cps.io"
}

# NS records are automatically created by AWS Route 53, so no need to define them.
### End: Defaults

### Begin: Combined CAA configuration
resource "aws_route53_record" "cps_io_caa_combined" {
  zone_id = aws_route53_zone.cps_io.zone_id
  name    = ""
  type    = "CAA"
  ttl     = 3600
  records = [
    "0 issue \"digicert.com\"",
    "0 issue \"comodo.com\"",
    "0 issue \"letsencrypt.org\"",
    "0 issue \"globalsign.com\"",
    "0 issue \"sectigo.com\""
  ]
}
### End: Combined CAA configuration

### Begin: Custom Entries

# Handle A-records
resource "aws_route53_record" "cps_io_a_records" {
  zone_id = aws_route53_zone.cps_io.zone_id
  for_each = {
    "emailsignature"    = "94.130.121.74"
    "fornax"            = "167.235.0.80"
    "gems"              = "94.130.121.74"
    "gw"                = "94.130.121.77"
    "hermes"            = "94.130.121.74"
    "hqgw"              = "217.111.25.34"
    "incoming"          = "80.82.206.135"
    "servicedesk"       = "94.130.121.78"
    "spectral"          = "88.198.59.182"
    "tas"               = "80.82.206.138"
    "tass"              = "80.82.206.138"
    "xbox"              = "88.99.148.153"
    "xbox-services"     = "94.130.121.74"
  }
  name    = each.key
  type    = "A"
  ttl     = 3600
  records = [each.value]
}

# Handle AAAA-records
resource "aws_route53_record" "cps_io_aaaa_records" {
  zone_id = aws_route53_zone.cps_io.zone_id
  for_each = {
    "emailsignature"    = "2a01:4f8:10a:2cd8::74"
    "fornax"            = "2a01:4f8:262:1046::2"
    "gems"              = "2a01:4f8:10a:2cd8::74"
    "hermes"            = "2a01:4f8:10a:2cd8::74"
    "servicedesk"       = "2a01:4f8:10a:2cd8::78"
    "xbox"              = "2a01:4f8:10a:2cd8::2"
    "xbox-services"     = "2a01:4f8:10a:2cd8::74"
  }
  name    = each.key
  type    = "AAAA"
  ttl     = 3600
  records = [each.value]
}

# Handle CNAME records
resource "aws_route53_record" "cps_io_cname_records" {
  zone_id = aws_route53_zone.cps_io.zone_id
  for_each = {
    "docs.tech"         = "docs-tech-cps-io-paysafe-consumer-viafintech-doc-1e5b486dfa5301.pages.gitlab.paysafe.cloud."
    "assets"            = "viafintech.snipe-it.io."
    "autodiscover"      = "autodiscover.outlook.com."
    "selector1._domainkey" = "selector1-cps-io._domainkey.skrill.onmicrosoft.com."
    "selector2._domainkey" = "selector2-cps-io._domainkey.skrill.onmicrosoft.com."
  }
  name    = each.key
  type    = "CNAME"
  ttl     = 3600
  records = [each.value]
}

# Handle MX-record
resource "aws_route53_record" "cps_io_mx1" {
  zone_id = aws_route53_zone.cps_io.zone_id
  name    = ""
  type    = "MX"
  ttl     = 3600
  records = ["0 paysafe-com.mail.protection.outlook.com."]
}

# Combined TXT records for SPF, DMARC, DNSWL, and Paysafe Verification
resource "aws_route53_record" "cps_io_txt_combined" {
  zone_id = aws_route53_zone.cps_io.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 3600
  records = [
    "v=spf1 mx include:spf.protection.outlook.com ip4:5.45.109.84 ip4:37.200.98.157 ip4:46.231.176.212 ip4:46.231.176.222 ip4:94.130.121.72/29 ip6:2a01:4f8:10a:2cd8::/64 ip6:2a03:4000:6:20f6::1 ip6:2a00:1158:3::c7 -all",  # SPF
    "v=DMARC1; p=reject; ruf=mailto:admin@viafintech.com; fo=1",  # DMARC
    "cpy90m1nbqtjthf0f3ce3s40pyhbbitn",  # DNSWL
    "MS=ms30858004"  # Paysafe Verification
  ]
}