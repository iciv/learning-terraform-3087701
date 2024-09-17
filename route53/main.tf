### Begin: Defaults
# Specify a zone for a domain
resource "aws_route53_zone" "viacash_ch" {
  name = "viacash.ch"
}

# NS records are automatically created by AWS Route 53, so no need to define them.
### End: Defaults

### Begin: Combined CAA configuration
resource "aws_route53_record" "viacash_ch_caa_combined" {
  zone_id = aws_route53_zone.viacash_ch.zone_id
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

# Handle Mail/SPF record
# Disallows sending mails on behalf of viacash.ch
resource "aws_route53_record" "viacash_ch_spf" {
  zone_id = aws_route53_zone.viacash_ch.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 3600
  records = ["v=spf1 -all"]
}

# DMARC TXT record
resource "aws_route53_record" "viacash_ch_dmarc" {
  zone_id = aws_route53_zone.viacash_ch.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DMARC1; p=reject; ruf=mailto:admin@viafintech.com; fo=1"]
}
### End: Custom Entries
