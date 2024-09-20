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

# Handle A-record for <domain>.<tld>
resource "aws_route53_record" "barzahlen_de_domainwide_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = ""
  type    = "A"
  ttl     = 3600
  records = ["94.130.121.74"]
}

# Handle A-record for controlcenter.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_controlcenter_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "controlcenter"
  type    = "A"
  ttl     = 3600
  records = ["80.82.206.134"]
}

# Handle A-record for api.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_api_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "api"
  type    = "A"
  ttl     = 3600
  records = ["46.231.176.214"]
}

# Handle A-record for api-banking.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_api_banking_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "api-banking"
  type    = "A"
  ttl     = 3600
  records = ["46.231.176.218"]
}

# Handle A-record for api-client.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_api_client_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "api-client"
  type    = "A"
  ttl     = 3600
  records = ["80.82.206.133"]
}

# Handle A-record for api-collection.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_api_collection_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "api-collection"
  type    = "A"
  ttl     = 3600
  records = ["46.231.176.218"]
}

# Handle A-record for api-offline.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_api_offline_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "api-offline"
  type    = "A"
  ttl     = 3600
  records = ["46.231.176.217"]
}

# Handle A-record for api-offline-sandbox.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_api_offline_sandbox_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "api-offline-sandbox"
  type    = "A"
  ttl     = 3600
  records = ["46.231.176.216"]
}

# Handle A-record for api-sandbox.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_api_sandbox_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "api-sandbox"
  type    = "A"
  ttl     = 3600
  records = ["46.231.176.215"]
}

# Handle A-record for api-utility.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_api_utility_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "api-utility"
  type    = "A"
  ttl     = 3600
  records = ["46.231.176.218"]
}

# Handle A-record for api-utility-newcert.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_api_utility_newcert_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "api-utility-newcert"
  type    = "A"
  ttl     = 3600
  records = ["46.231.176.219"]
}

# Handle A-record for customers.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_customers_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "customers"
  type    = "A"
  ttl     = 3600
  records = ["80.82.206.130"]
}

# Handle A-record for customers-sandbox.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_customers_sandbox_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "customers-sandbox"
  type    = "A"
  ttl     = 3600
  records = ["80.82.206.132"]
}

# Handle A-record for docs.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_docs_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "docs"
  type    = "A"
  ttl     = 3600
  records = ["159.69.116.223"]
}

# Handle A-record for link.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_link_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "link"
  type    = "A"
  ttl     = 3600
  records = ["109.234.127.65"]
}

# Handle A-record for mail3.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_mail3_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "mail3"
  type    = "A"
  ttl     = 3600
  records = ["46.231.176.222"]
}

# Handle A-record for partner.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_partner_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "partner"
  type    = "A"
  ttl     = 3600
  records = ["80.82.206.134"]
}

# Handle A-record for payment.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_payment_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "payment"
  type    = "A"
  ttl     = 3600
  records = ["46.231.176.214"]
}

# Handle A-record for payment-sandbox.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_payment_sandbox_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "payment-sandbox"
  type    = "A"
  ttl     = 3600
  records = ["46.231.176.215"]
}

# Handle A-record for stores.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_stores_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "stores"
  type    = "A"
  ttl     = 3600
  records = ["80.82.206.131"]
}

# Handle A-record for transfer.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_transfer_a" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "transfer"
  type    = "A"
  ttl     = 3600
  records = ["46.231.176.221"]
}

# Handle AAAA-record for <domain>.<tld>
resource "aws_route53_record" "barzahlen_de_domainwide_aaaa" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = ""
  type    = "AAAA"
  ttl     = 3600
  records = ["2a01:4f8:10a:2cd8::74"]
}

# Handle AAAA-record for docs.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_docs_aaaa" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "docs"
  type    = "AAAA"
  ttl     = 3600
  records = ["2a01:4f8:c012:aec3::1"]
}

# Handle CNAME-record for cdn.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_cname_cname" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "cdn"
  type    = "CNAME"
  ttl     = 3600
  records = ["bzcdn-4bb3.kxcdn.com."]
}

# Handle CNAME-record for l.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_l_cname" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "l"
  type    = "CNAME"
  ttl     = 3600
  records = ["mandrillapp.com."]
}

# Handle CNAME-record for www.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_www_cname" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "www"
  type    = "CNAME"
  ttl     = 3600
  records = ["d38kw21wqboq8q.cloudfront.net."]
}

# Handle CNAME-record for autodiscover.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_autodiscover_cname" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "autodiscover"
  type    = "CNAME"
  ttl     = 3600
  records = ["autodiscover.outlook.com."]
}

# Handle CNAME-record for selector1._domainkey.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_selector1dkey_cname" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "selector1._domainkey"
  type    = "CNAME"
  ttl     = 3600
  records = ["selector1-barzahlen-de._domainkey.skrill.onmicrosoft.com."]
}

# Handle CNAME-record for selector2._domainkey.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_selector2dkey_cname" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "selector2._domainkey"
  type    = "CNAME"
  ttl     = 3600
  records = ["selector2-barzahlen-de._domainkey.skrill.onmicrosoft.com."]
}

# Handle CNAME-record for mte1._domainkey.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_mte1dkey_cname" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "mte1._domainkey"
  type    = "CNAME"
  ttl     = 3600
  records = ["dkim1.mandrillapp.com."]
}

# Handle CNAME-record for mte2._domainkey.<domain>.<tld>
resource "aws_route53_record" "barzahlen_de_mte2dkey_cname" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "mte2._domainkey"
  type    = "CNAME"
  ttl     = 3600
  records = ["dkim2.mandrillapp.com."]
}

# Handle CNAME-record for domain validation in AWS marketing account 849668658165
resource "aws_route53_record" "barzahlen_de_aws_cname_validation" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "_0a324b422cb11a35b2a18a0e8b487eaf"
  type    = "CNAME"
  ttl     = 3600
  records = ["_0adbc735f1b2b74a1cc9da136df61dc5.mhbtsbpdnt.acm-validations.aws."]
}

# Handle CNAME-record for www domain validation in AWS marketing account 849668658165
resource "aws_route53_record" "barzahlen_de_www_aws_cname_validation" {
  zone_id = aws_route53_zone.barzahlen_de.zone_id
  name    = "_0b1f3c112f42919d910c0e1bc1779c75.www"
  type    = "CNAME"
  ttl     = 3600
  records = ["_b0e581ca5fb8633d817e0d8a1ee3c9e8.mhbtsbpdnt.acm-validations.aws."]
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
