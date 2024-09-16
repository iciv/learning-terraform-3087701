### Begin: Defaults
# Specify a zone for a domain
resource "aws_route53_zone" "barzahlen_at" {
  name = "barzahlen.at"
}

# Specify nameserver records
resource "aws_route53_record" "barzahlen_at_ns1" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "@"
  type    = "NS"
  ttl     = 86400
  records = ["ns-2048.awsdns-64.com.", "ns-2049.awsdns-65.net.", "ns-2050.awsdns-66.org.", "ns-2051.awsdns-67.co.uk."]
}
### End: Defaults

### Begin: CAA configuration
resource "aws_route53_record" "barzahlen_at_caa1" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "@"
  type    = "CAA"
  ttl     = 3600
  records = ["0 issue \"digicert.com\""]
}

resource "aws_route53_record" "barzahlen_at_caa2" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "@"
  type    = "CAA"
  ttl     = 3600
  records = ["0 issue \"comodo.com\""]
}

resource "aws_route53_record" "barzahlen_at_caa3" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "@"
  type    = "CAA"
  ttl     = 3600
  records = ["0 issue \"letsencrypt.org\""]
}

resource "aws_route53_record" "barzahlen_at_caa4" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "@"
  type    = "CAA"
  ttl     = 3600
  records = ["0 issue \"globalsign.com\""]
}

resource "aws_route53_record" "barzahlen_at_caa5" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "@"
  type    = "CAA"
  ttl     = 3600
  records = ["0 issue \"sectigo.com\""]
}
### End: CAA configuration

### Begin: Custom Entries
# Handle A-record for controlcenter.<domain>.<tld>
resource "aws_route53_record" "barzahlen_at_controlcenter_a" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "controlcenter"
  type    = "A"
  ttl     = 3600
  records = ["80.82.206.134"]
}

# Handle CNAME-record for autodiscover.<domain>.<tld>
resource "aws_route53_record" "barzahlen_at_autodiscover_cname" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "autodiscover"
  type    = "CNAME"
  ttl     = 3600
  records = ["autodiscover.outlook.com."]
}

# Handle CNAME-record for selector1._domainkey.<domain>.<tld>
resource "aws_route53_record" "barzahlen_at_selector1dkey_cname" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "selector1._domainkey"
  type    = "CNAME"
  ttl     = 3600
  records = ["selector1-barzahlen-at._domainkey.skrill.onmicrosoft.com."]
}

# Handle CNAME-record for selector2._domainkey.<domain>.<tld>
resource "aws_route53_record" "barzahlen_at_selector2dkey_cname" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "selector2._domainkey"
  type    = "CNAME"
  ttl     = 3600
  records = ["selector2-barzahlen-at._domainkey.skrill.onmicrosoft.com."]
}

# Handle MX-record for <domain>.<tld>
resource "aws_route53_record" "barzahlen_at_mx1" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "@"
  type    = "MX"
  ttl     = 3600
  records = ["0 paysafe-com.mail.protection.outlook.com."]
}

# Handle Mail/SPF record
resource "aws_route53_record" "barzahlen_at_spf" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "@"
  type    = "TXT"
  ttl     = 3600
  records = ["v=spf1 mx include:spf.protection.outlook.com ip4:5.45.109.84 ip4:37.200.98.157 ip4:46.231.176.212 ip4:46.231.176.222 ip6:2a03:4000:6:20f6::1 -all"]
}

# DMARC TXT record (report-only)
resource "aws_route53_record" "barzahlen_at_dmarc" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DMARC1; p=reject; ruf=mailto:admin@viafintech.com; fo=1"]
}

# DNSWL record
resource "aws_route53_record" "barzahlen_at_dnswl" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "@"
  type    = "TXT"
  ttl     = 3600
  records = ["qnyahgpqws3avvd5kcmwo6pbch9tv5yl"]
}

# DNS TXT Verification
resource "aws_route53_record" "barzahlen_at_paysafe" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "@"
  type    = "TXT"
  ttl     = 3600
  records = ["MS=ms63620310"]
}
