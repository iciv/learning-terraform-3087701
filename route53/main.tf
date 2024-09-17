### Begin: Defaults
# Specify a zone for a domain
resource "aws_route53_zone" "cashpaymentsolutions_com" {
  name = "cashpaymentsolutions.com"
}

# NS records are automatically created by AWS Route 53, so no need to define them.
### End: Defaults

### Begin: Combined CAA configuration
resource "aws_route53_record" "cashpaymentsolutions_com_caa_combined" {
  zone_id = aws_route53_zone.cashpaymentsolutions_com.zone_id
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
resource "aws_route53_record" "cashpaymentsolutions_com_controlcenter_a" {
  zone_id = aws_route53_zone.cashpaymentsolutions_com.zone_id
  name    = "controlcenter"
  type    = "A"
  ttl     = 3600
  records = ["80.82.206.137"]
}

# Handle CNAME-record for autodiscover.<domain>.<tld>
resource "aws_route53_record" "cashpaymentsolutions_com_autodiscover_cname" {
  zone_id = aws_route53_zone.cashpaymentsolutions_com.zone_id
  name    = "autodiscover"
  type    = "CNAME"
  ttl     = 3600
  records = ["autodiscover.outlook.com."]
}

# Handle CNAME-record for selector1._domainkey.<domain>.<tld>
resource "aws_route53_record" "cashpaymentsolutions_com_selector1dkey_cname" {
  zone_id = aws_route53_zone.cashpaymentsolutions_com.zone_id
  name    = "selector1._domainkey"
  type    = "CNAME"
  ttl     = 3600
  records = ["selector1-cashpaymentsolutions-com._domainkey.skrill.onmicrosoft.com."]
}

# Handle CNAME-record for selector2._domainkey.<domain>.<tld>
resource "aws_route53_record" "cashpaymentsolutions_com_selector2dkey_cname" {
  zone_id = aws_route53_zone.cashpaymentsolutions_com.zone_id
  name    = "selector2._domainkey"
  type    = "CNAME"
  ttl     = 3600
  records = ["selector2-cashpaymentsolutions-com._domainkey.skrill.onmicrosoft.com."]
}

# Handle MX-record for <domain>.<tld>
resource "aws_route53_record" "cashpaymentsolutions_com_mx1" {
  zone_id = aws_route53_zone.cashpaymentsolutions_com.zone_id
  name    = ""
  type    = "MX"
  ttl     = 3600
  records = ["0 paysafe-com.mail.protection.outlook.com."]
}

# Combined TXT record for SPF and Paysafe verification
resource "aws_route53_record" "cashpaymentsolutions_com_txt_combined" {
  zone_id = aws_route53_zone.cashpaymentsolutions_com.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 3600
  records = [
    "v=spf1 mx include:spf.protection.outlook.com include:spf.mandrillapp.com ip4:5.135.57.43 ip4:91.250.114.50 ip4:37.200.98.157 ip4:46.231.176.212 ip4:46.231.176.222 -all",  # SPF record
    "MS=ms27487226"  # Paysafe verification
  ]
}

# DMARC TXT record
resource "aws_route53_record" "cashpaymentsolutions_com_dmarc" {
  zone_id = aws_route53_zone.cashpaymentsolutions_com.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DMARC1; p=reject; ruf=mailto:admin@viafintech.com; fo=1"]
}

# DNSWL Record
resource "aws_route53_record" "cashpaymentsolutions_com_dnswl" {
  zone_id = aws_route53_zone.cashpaymentsolutions_com.zone_id
  name    = "_token._dnswl"
  type    = "TXT"
  ttl     = 3600
  records = ["sndfc228ost0trq8q7k2gcuzd8vv2sft"]
}
### End: Custom Entries
