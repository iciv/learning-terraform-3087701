### Begin: Defaults
# Specify a zone for a domain
resource "aws_route53_zone" "barzahlen_de" {
  name = "barzahlen.de"
}

# NS records are automatically created by AWS Route 53, so no need to define them.
### End: Defaults

### Begin: Combined CAA configuration
resource "aws_route53_record" "barzahlen_de_caa_combined" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
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

# Handle A-records for various subdomains
resource "aws_route53_record" "barzahlen_de_a_records" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  for_each = {
    ""                    = "94.130.121.74"
    "controlcenter"       = "80.82.206.134"
    "api"                 = "46.231.176.214"
    "api-banking"         = "46.231.176.218"
    "api-client"          = "80.82.206.133"
    "api-collection"      = "46.231.176.218"
    "api-offline"         = "46.231.176.217"
    "api-offline-sandbox" = "46.231.176.216"
    "api-sandbox"         = "46.231.176.215"
    "api-utility"         = "46.231.176.218"
    "api-utility-newcert" = "46.231.176.219"
    "customers"           = "80.82.206.130"
    "customers-sandbox"   = "80.82.206.132"
    "docs"                = "159.69.116.223"
    "link"                = "109.234.127.65"
    "mail3"               = "46.231.176.222"
    "partner"             = "80.82.206.134"
    "payment"             = "46.231.176.214"
    "payment-sandbox"     = "46.231.176.215"
    "stores"              = "80.82.206.131"
    "transfer"            = "46.231.176.221"
  }
  name    = each.key
  type    = "A"
  ttl     = 3600
  records = [each.value]
}

# Handle AAAA-records for various subdomains
resource "aws_route53_record" "barzahlen_de_aaaa_records" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  for_each = {
    ""     = "2a01:4f8:10a:2cd8::74"
    "docs" = "2a01:4f8:c012:aec3::1"
  }
  name    = each.key
  type    = "AAAA"
  ttl     = 3600
  records = [each.value]
}

# Handle CNAME-records for various subdomains
resource "aws_route53_record" "barzahlen_de_cname_records" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  for_each = {
    "cdn"                                   = "bzcdn-4bb3.kxcdn.com."
    "l"                                     = "mandrillapp.com."
    "www"                                   = "d38kw21wqboq8q.cloudfront.net."
    "autodiscover"                          = "autodiscover.outlook.com."
    "selector1._domainkey"                  = "selector1-barzahlen-de._domainkey.skrill.onmicrosoft.com."
    "selector2._domainkey"                  = "selector2-barzahlen-de._domainkey.skrill.onmicrosoft.com."
    "mte1._domainkey"                       = "dkim1.mandrillapp.com."
    "mte2._domainkey"                       = "dkim2.mandrillapp.com."
    "_0a324b422cb11a35b2a18a0e8b487eaf"     = "_0adbc735f1b2b74a1cc9da136df61dc5.mhbtsbpdnt.acm-validations.aws."
    "_0b1f3c112f42919d910c0e1bc1779c75.www" = "_b0e581ca5fb8633d817e0d8a1ee3c9e8.mhbtsbpdnt.acm-validations.aws."
  }
  name    = each.key
  type    = "CNAME"
  ttl     = 3600
  records = [each.value]
}

# Handle MX-record for <domain>.<tld>
resource "aws_route53_record" "barzahlen_de_mx1" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = ""
  type    = "MX"
  ttl     = 3600
  records = ["0 paysafe-com.mail.protection.outlook.com."]
}

# Combined TXT record for SPF, Paysafe, DNSWL
resource "aws_route53_record" "barzahlen_de_txt_combined" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 3600
  records = [
    "v=spf1 a mx include:spf.protection.outlook.com include:spf.mandrillapp.com include:spf.mailjet.com include:_spf.salesforce.com include:_spf.barzahlen.de -all", # SPF record
    "MS=ms47824538",                                                                                                                                                 # Paysafe verification
    "gabjjmzakl6b7kzz4qaax6fhbqvfiziy"                                                                                                                               # DNSWL record
  ]
}

# Handle SPF netblocks collector
resource "aws_route53_record" "barzahlen_de_spf2" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "_spf"
  type    = "TXT"
  ttl     = 3600
  records = ["v=spf1 include:_netblocks.barzahlen.de include:_netblocks2.barzahlen.de -all"]
}

# Handle SPF netblocks
resource "aws_route53_record" "barzahlen_de_spf3" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "_netblocks"
  type    = "TXT"
  ttl     = 3600
  records = ["v=spf1 ip4:46.231.176.208/28 ip4:80.82.206.128/26 ip4:88.99.148.153 ip4:94.130.121.72/29 -all"]
}

# Handle SPF netblocks2
resource "aws_route53_record" "barzahlen_de_spf4" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "_netblocks2"
  type    = "TXT"
  ttl     = 3600
  records = ["v=spf1 ip6:2a00:cd0:1025::/48 ip6:2a01:4f8:10a:2cd8::/64 ip6:2001:920:1a21:2900::/56 -all"]
}

# Mailjet DKIM
resource "aws_route53_record" "barzahlen_de_mailjet_dkim" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "mailjet._domainkey"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDQRSrzyv74A0nF5+WcBZPI52pNOq1JUdjsi1Sow6PH6itqNwKJ/QSlUPsvBS/12bZPR7hBkcVWa7Wqi6WlC+yXKf2RJ+VPtcOdTvdheRazUZF7QaaxHUlZ7XPSpfMvpOYY7vvT8N2JMsJTfjDuV0x9Z2qKVwkpcmtXGHfFmHYHuQIDAQAB;"]
}

# Mandrill DKIM
resource "aws_route53_record" "barzahlen_de_mandrill_dkim" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "mandrill._domainkey"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCrLHiExVd55zd/IQ/J/mRwSRMAocV/hMB3jXwaHH36d9NaVynQFYV8NaWi69c1veUtRzGt7yAioXqLj7Z4TeEUoOLgrKsn8YnckGs9i3B3tVFB+Ch/4mPhXWiNfNdynHWBcPcbJ8kjEQ2U8y78dHZj1YeRXXVvWob2OaKynO8/lQIDAQAB;"]
}

# DMARC TXT record (report-only)
resource "aws_route53_record" "barzahlen_de_dmarc" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DMARC1; p=reject; ruf=mailto:admin@viafintech.com; fo=1"]
}

### End: Custom Entries
