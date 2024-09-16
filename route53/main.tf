### Begin: Defaults
# Specify a zone for a domain
resource "aws_route53_zone" "barzahlen_ch" {
  name = "barzahlen.ch"
}

### End: Defaults

### Begin: Combined CAA configuration
resource "aws_route53_record" "barzahlen_ch_caa_combined" {
  zone_id = aws_route53_zone.barzahlen_ch.zone_id
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
# Handle A-record for controlcenter.<domain>.<tld>
resource "aws_route53_record" "barzahlen_ch_controlcenter_a" {
  zone_id = aws_route53_zone.barzahlen_ch.zone_id
  name    = "controlcenter"
  type    = "A"
  ttl     = 3600
  records = ["80.82.206.134"]
}

# Handle CNAME-record for autodiscover.<domain>.<tld>
resource "aws_route53_record" "barzahlen_ch_autodiscover_cname" {
  zone_id = aws_route53_zone.barzahlen_ch.zone_id
  name    = "autodiscover"
  type    = "CNAME"
  ttl     = 3600
  records = ["autodiscover.outlook.com."]
}

# Handle CNAME-record for selector1._domainkey.<domain>.<tld>
resource "aws_route53_record" "barzahlen_ch_selector1dkey_cname" {
  zone_id = aws_route53_zone.barzahlen_ch.zone_id
  name    = "selector1._domainkey"
  type    = "CNAME"
  ttl     = 3600
  records = ["selector1-barzahlen-ch._domainkey.skrill.onmicrosoft.com."]
}

# Handle CNAME-record for selector2._domainkey.<domain>.<tld>
resource "aws_route53_record" "barzahlen_ch_selector2dkey_cname" {
  zone_id = aws_route53_zone.barzahlen_ch.zone_id
  name    = "selector2._domainkey"
  type    = "CNAME"
  ttl     = 3600
  records = ["selector2-barzahlen-ch._domainkey.skrill.onmicrosoft.com."]
}

# Handle MX-record for <domain>.<tld>
resource "aws_route53_record" "barzahlen_ch_mx1" {
  zone_id = aws_route53_zone.barzahlen_ch.zone_id
  name    = ""
  type    = "MX"
  ttl     = 3600
  records = ["0 paysafe-com.mail.protection.outlook.com."]
}

# Combined TXT record for SPF and Paysafe verification
resource "aws_route53_record" "barzahlen_ch_txt_combined" {
  zone_id = aws_route53_zone.barzahlen_ch.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 3600
  records = [
    "v=spf1 mx include:spf.protection.outlook.com ip4:5.45.109.84 ip4:37.200.98.157 ip4:46.231.176.212 ip4:46.231.176.222 ip6:2a03:4000:6:20f6::1 -all",  # SPF record
    "MS=ms40277327"  # Paysafe verification
  ]
}

# DMARC TXT record (report-only)
resource "aws_route53_record" "barzahlen_ch_dmarc" {
  zone_id = aws_route53_zone.barzahlen_ch.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DMARC1; p=reject; ruf=mailto:admin@viafintech.com; fo=1"]
}
### End: Custom Entries
