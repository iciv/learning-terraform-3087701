# Specify a zone for a domain
resource "aws_route53_zone" "viacash_cz" {
  name = "viacash.cz"
}

# Combine CAA records for viacash.cz
resource "aws_route53_record" "viacash_cz_caa_combined" {
  zone_id = aws_route53_zone.viacash_cz.zone_id
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

# Combine TXT records for viacash.cz
resource "aws_route53_record" "viacash_cz_txt_combined" {
  zone_id = aws_route53_zone.viacash_cz.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 3600
  records = [
    "v=spf1 -all",
    "v=DMARC1; p=reject; ruf=mailto:admin@viafintech.com; fo=1"
  ]
}
