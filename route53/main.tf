### Begin: Defaults
# Specify a zone for a domain
resource "aws_route53_zone" "viacash_ru" {
  name = "viacash.ru"
}

# NS records are automatically created by Route 53, so we don't need to define them explicitly
### End: Defaults

### Begin: CAA configuration
resource "aws_route53_record" "viacash_ru_caa1" {
  zone_id = aws_route53_zone.viacash_ru.zone_id
  name    = "@"
  type    = "CAA"
  ttl     = 3600
  records = ["0 issue \"digicert.com\""]
}

resource "aws_route53_record" "viacash_ru_caa2" {
  zone_id = aws_route53_zone.viacash_ru.zone_id
  name    = "@"
  type    = "CAA"
  ttl     = 3600
  records = ["0 issue \"comodo.com\""]
}

resource "aws_route53_record" "viacash_ru_caa3" {
  zone_id = aws_route53_zone.viacash_ru.zone_id
  name    = "@"
  type    = "CAA"
  ttl     = 3600
  records = ["0 issue \"letsencrypt.org\""]
}

resource "aws_route53_record" "viacash_ru_caa4" {
  zone_id = aws_route53_zone.viacash_ru.zone_id
  name    = "@"
  type    = "CAA"
  ttl     = 3600
  records = ["0 issue \"globalsign.com\""]
}

resource "aws_route53_record" "viacash_ru_caa5" {
  zone_id = aws_route53_zone.viacash_ru.zone_id
  name    = "@"
  type    = "CAA"
  ttl     = 3600
  records = ["0 issue \"sectigo.com\""]
}
### End: CAA configuration

### Begin: Custom Entries

# Handle Mail/SPF record
# Disallows sending mails on behalf of viacash.ru
resource "aws_route53_record" "viacash_ru_spf" {
  zone_id = aws_route53_zone.viacash_ru.zone_id
  name    = "@"
  type    = "TXT"
  ttl     = 3600
  records = ["v=spf1 -all"]
}

# DMARC TXT record
resource "aws_route53_record" "viacash_ru_dmarc" {
  zone_id = aws_route53_zone.viacash_ru.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DMARC1; p=reject; ruf=mailto:admin@viafintech.com; fo=1"]
}
### End: Custom Entries
