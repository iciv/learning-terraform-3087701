### Begin: Defaults
# Specify a zone for a domain
resource "aws_route53_zone" "viafintech_com" {
  name = "viafintech.com"
}

# NS records are automatically created by AWS Route 53, so no need to define them.
### End: Defaults

### Begin: Combined CAA configuration
resource "aws_route53_record" "viafintech_com_caa_combined" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
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

# Handle A-record for <domain>.<tld>
resource "aws_route53_record" "viafintech_com_domainwide_a" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = ""
  type    = "A"
  ttl     = 3600
  records = ["94.130.121.74"]
}

# Handle A-record for api.<domain>.<tld>
resource "aws_route53_record" "viafintech_com_api_a" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = "api"
  type    = "A"
  ttl     = 3600
  records = ["46.231.176.214"]
}

# Handle A-record for api-sandbox.<domain>.<tld>
resource "aws_route53_record" "viafintech_com_apisandbox_a" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = "api-sandbox"
  type    = "A"
  ttl     = 3600
  records = ["46.231.176.215"]
}

# Handle AAAA-record for <domain>.<tld>
resource "aws_route53_record" "viafintech_com_domainwide_aaaa" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = ""
  type    = "AAAA"
  ttl     = 3600
  records = ["2a01:4f8:10a:2cd8::74"]
}

# Handle CNAME-record for autodiscover.<domain>.<tld>
resource "aws_route53_record" "viafintech_com_autodiscover_cname" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = "autodiscover"
  type    = "CNAME"
  ttl     = 3600
  records = ["autodiscover.outlook.com."]
}

# Handle MX-record for <domain>.<tld>
resource "aws_route53_record" "viafintech_com_mx1" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = ""
  type    = "MX"
  ttl     = 3600
  records = ["0 viafintech-com.mail.protection.outlook.com."]
}

# Handle Mail/SPF record
resource "aws_route53_record" "viafintech_com_spf" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 3600
  records = [
    "v=spf1 a mx include:spf.protection.outlook.com include:_spf.viafintech.com include:spf.mandrillapp.com include:spf.mailjet.com include:_spf.salesforce.com -all"
  ]
}

# DMARC TXT record
resource "aws_route53_record" "viafintech_com_dmarc" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DMARC1; p=reject; ruf=mailto:admin@viafintech.com; fo=1"]
}

# Google Site Verification
resource "aws_route53_record" "viafintech_com_google_siteverification" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 3600
  records = ["google-site-verification=fVi_Aw06nFcMZGt4-cDzZa0Bc6yXlrEP41j5n6Eza-I"]
}

### End: Custom Entries
