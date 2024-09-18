### Begin: Defaults
# Specify a zone for a domain
resource "aws_route53_zone" "viafintech_com" {
  name = "viafintech.com"
}

# Note: AWS Route 53 automatically creates NS records for the zone,
# so we don't need to specify them explicitly.

### End: Defaults

### Begin: CAA configuration
resource "aws_route53_record" "viafintech_com_caa" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = ""
  type    = "CAA"
  ttl     = 86400
  records = [
    "0 issue \"digicert.com\"",
    "0 issue \"comodo.com\"",
    "0 issue \"letsencrypt.org\"",
    "0 issue \"globalsign.com\"",
    "0 issue \"sectigo.com\"",
    "0 issue \"amazon.com\""
  ]
}
### End: CAA configuration

### Custom Entries

## Begin: Custom Entries
# Handle A-records for various subdomains
resource "aws_route53_record" "viafintech_com_a_records" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  for_each = {
    ""                    = "94.130.121.74"
    "api"                 = "46.231.176.214"
    "api-sandbox"         = "46.231.176.215"
    "api-client"          = "80.82.206.133"
    "api-passkit"         = "80.82.206.136"
    "api-passkit-sandbox" = "80.82.206.136"
    "api-retail"          = "46.231.176.217"
    "api-retail-sandbox"  = "46.231.176.216"
    "api-utility"       = "46.231.176.218"
    "api-utility-newcert" = "46.231.176.219"
    "app" = "80.82.206.137"
    "asgard" = "88.198.59.172"
    "cavm" = "49.12.187.118"
    "docs" = "159.69.116.223"
    "stores" = "80.82.206.131"
    "thor" = "88.198.59.172"
    "transfer" = "46.231.176.221"
  }
  name    = each.key
  type    = "A"
  ttl     = 3600
  records = [each.value]
}

# Define a map for the AAAA records
resource "aws_route53_record" "viafintech_com_aaaa_records" {
  zone_id = aws_route53_zone.viafintech_com.zone_id

  for_each = {
    ""      = "2a01:4f8:10a:2cd8::74"
    "asgard" = "2a01:4f8:222:784:6969::1"
    "cavm"  = "2a01:4f8:c012:f7f1::1"
    "docs"  = "2a01:4f8:c012:aec3::1"
    "thor"  = "2a01:4f8:222:784::7468:254"
  }

  name    = each.key
  type    = "AAAA"
  ttl     = 3600
  records = [each.value]
}

# Handle CNAME-record for autodiscover.<domain>.<tld>
resource "aws_route53_record" "viafintech_com_cname_records" {
  zone_id = aws_route53_zone.viafintech_com.zone_id

  for_each = {
    "autodiscover"                        = "autodiscover.outlook.com."
    "selector1._domainkey"                = "selector1-viafintech-com._domainkey.skrill.onmicrosoft.com."
    "selector2._domainkey"                = "selector2-viafintech-com._domainkey.skrill.onmicrosoft.com."
    "cdn"                                 = "viafintech-4bb3.kxcdn.com."
    "helpdesk"                            = "barzahlen.zammad.com."
    "ldap"                                = "thor"
    "wsdl"                                = "vfsoap-4bb3.kxcdn.com."
    "www"                                 = "dkinrlus7agur.cloudfront.net."
    "www.app"                             = "app"
    "mailtracking"                        = "mandrillapp.com."
    "bnc3"                                = "bnc3.mailjet.com."
    "k2._domainkey"                       = "dkim2.mcsv.net."
    "k3._domainkey"                       = "dkim3.mcsv.net."
    "mte1._domainkey"                     = "dkim1.mandrillapp.com."
    "mte2._domainkey"                     = "dkim2.mandrillapp.com."
    "_e34b416eb07936323962d436b3cc1ee9"   = "_e3698f5b18c45fca990e3e47c3207dc7.mhbtsbpdnt.acm-validations.aws."
    "_92d8b9c6e3b0f4dd3e00226a64cf397b.www" = "_45484436cf957a4918dfd374b023fc90.mhbtsbpdnt.acm-validations.aws."
  }

  name    = each.key
  type    = "CNAME"
  ttl     = 3600
  records = [each.value]
}

# MX Record
resource "aws_route53_record" "viafintech_com_mx" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = ""
  type    = "MX"
  ttl     = 3600
  records = ["0 viafintech-com.mail.protection.outlook.com."]
}

# Combined TXT Record for viafintech.com
resource "aws_route53_record" "viafintech_com_txt_records" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 3600
  records = [
    # SPF Record
    "v=spf1 a mx include:spf.protection.outlook.com include:_spf.viafintech.com include:spf.mandrillapp.com include:spf.mailjet.com include:_spf.salesforce.com -all",

    # Google Site Verification
    "google-site-verification=fVi_Aw06nFcMZGt4-cDzZa0Bc6yXlrEP41j5n6Eza-I",

    # Paysafe Verification
    "MS=ms20420367"
  ]
}

# SPF Record 2 (Netblocks Collector)
resource "aws_route53_record" "viafintech_com_spf2" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = "_spf"
  type    = "TXT"
  ttl     = 3600
  records = ["v=spf1 include:_netblocks.viafintech.com include:_netblocks2.viafintech.com -all"]
}

# SPF Record 3 (Netblocks IPv4)
resource "aws_route53_record" "viafintech_com_spf3" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = "_netblocks"
  type    = "TXT"
  ttl     = 3600
  records = ["v=spf1 ip4:46.231.176.208/28 ip4:80.82.206.128/26 ip4:88.99.148.153 ip4:94.130.121.72/29 ip4:217.111.25.32/29 -all"]
}

# SPF Record 4 (Netblocks IPv6)
resource "aws_route53_record" "viafintech_com_spf4" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = "_netblocks2"
  type    = "TXT"
  ttl     = 3600
  records = ["v=spf1 ip6:2a00:cd0:1025::/48 ip6:2a01:4f8:10a:2cd8::/64 ip6:2001:920:1a21:2900::/56 -all"]
}

# DMARC Record
resource "aws_route53_record" "viafintech_com_dmarc" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DMARC1; p=reject; ruf=mailto:admin@viafintech.com; fo=1"]
}

# DMARC Record for Other Domains
resource "aws_route53_record" "viafintech_com_dmarc_others" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = "*._report._dmarc"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DMARC1"]
}

# Mailjet Verification
resource "aws_route53_record" "viafintech_com_mailjet_verification" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = "mailjet._6323429f"
  type    = "TXT"
  ttl     = 3600
  records = ["6323429f5b5f674fb4391252496cd2af"]
}

# DKIM for Mailjet
resource "aws_route53_record" "viafintech_com_mailjet_dkim" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = "mailjet._domainkey"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCdPO28UO2uUVUXvGEI/XfmS92UqmbiXTcUX+ZzT0cpeKNi6kAiAfgIi+Y3faPlcJCzii83pQJWVyvCihlxqo9YVyyWBVsP5ycHC3CNmt/eLuBv/AAnONwUrEiVwbdSO1Ty0DQJXlc85TpiaknXr41MzkNDAlabX97ZHMWJzFf2rwIDAQAB"]
}

# DKIM for Hetzner (Split long string)
resource "aws_route53_record" "viafintech_com_hetzner_dkim" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = "default2205._domainkey"
  type    = "TXT"
  ttl     = 3600
  records = [
    "v=DKIM1;p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAzluwhgUUAN+pWCtRDry5u5u02lULd0UX/M0tli3LG4+0BN7TTaZU5VJH58HIofGYM0bqKSjP5sUiRI+5g59774maQg7hSinhp9kCVRgCGU0nOLaK1uLrRjCnavTOcyU6369AfPHj/Ip9AwuP3WiUSzeHUHr3ZRUSsvkX710y3352AhBnV+JxnH4BA1z",
    "+YkNF9nfBrTMTon1OnPRDo8a0OknMuVem15Kg/s4Rm4bMBfio+16Al1qplM+mXeJW36ExZgr+C2nrERzmKEMPWhD5WBqq8ipXm9L830w6AWkExW/2/G0bIdieZ0FUU1OEafLZz5y3+UTED+cTtcwdsIIJ6wIDAQAB"
  ]
}

# DKIM for Mandrill (Split long string)
resource "aws_route53_record" "viafintech_com_mandrill_dkim" {
  zone_id = aws_route53_zone.viafintech_com.zone_id
  name    = "mandrill._domainkey"
  type    = "TXT"
  ttl     = 3600
  records = [
    "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCrLHiExVd55zd/IQ/J/mRwSRMAocV/hMB3jXwaHH36d9NaVynQFYV8NaWi69c1veUtRzGt7yAioXqLj7Z4TeEUoOLgrKsn8YnckGs9i3B3tVFB+Ch/4mPhXWiNfNdynHWBcPcbJ8kjEQ2U8y78dHZj1YeRXXVvWob2OaKynO8/lQIDAQAB;"
  ]
}