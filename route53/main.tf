### Begin: Defaults
# Specify a zone for a domain
resource "aws_route53_zone" "viafintech_de" {
  name = "viafintech.de"
}

# CAA configuration
resource "aws_route53_record" "viafintech_de_caa" {
  zone_id = aws_route53_zone.viafintech_de.zone_id
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

# Custom Entries

# SPF record
resource "aws_route53_record" "viafintech_de_spf" {
  zone_id = aws_route53_zone.viafintech_de.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 3600
  records = [
    "v=spf1 -all"
  ]
}

# DMARC TXT record
resource "aws_route53_record" "viafintech_de_dmarc" {
  zone_id = aws_route53_zone.viafintech_de.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = 3600
  records = [
    "v=DMARC1; p=reject; ruf=mailto:admin@viafintech.com; fo=1"
  ]
}
# End: Custom Entries