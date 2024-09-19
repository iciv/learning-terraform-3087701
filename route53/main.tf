# Create the Route 53 zone
resource "aws_route53_zone" "barzahlen_at" {
  name = "barzahlen.at"
}

# CAA Records
resource "aws_route53_record" "barzahlen_at_caa" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = ""
  type    = "CAA"
  ttl     = 86400

  records = [
    "0 issue \"digicert.com\"",
    "0 issue \"comodo.com\"",
    "0 issue \"letsencrypt.org\"",
    "0 issue \"globalsign.com\"",
    "0 issue \"sectigo.com\""
  ]
}

# A record for controlcenter
resource "aws_route53_record" "barzahlen_at_controlcenter_a" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "controlcenter"
  type    = "A"
  ttl     = 3600
  records = ["80.82.206.134"]
}

# CNAME record for autodiscover
resource "aws_route53_record" "barzahlen_at_autodiscover_cname" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "autodiscover"
  type    = "CNAME"
  ttl     = 3600
  records = ["autodiscover.outlook.com"]
}

# CNAME record for selector1._domainkey
resource "aws_route53_record" "barzahlen_at_selector1dkey_cname" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "selector1._domainkey"
  type    = "CNAME"
  ttl     = 3600
  records = ["selector1-barzahlen-at._domainkey.skrill.onmicrosoft.com"]
}

# CNAME record for selector2._domainkey
resource "aws_route53_record" "barzahlen_at_selector2dkey_cname" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "selector2._domainkey"
  type    = "CNAME"
  ttl     = 3600
  records = ["selector2-barzahlen-at._domainkey.skrill.onmicrosoft.com"]
}

# MX record
resource "aws_route53_record" "barzahlen_at_mx" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = ""
  type    = "MX"
  ttl     = 3600
  records = ["0 paysafe-com.mail.protection.outlook.com"]
}

# Combined TXT records for the root domain
resource "aws_route53_record" "barzahlen_at_txt" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 3600
  records = [
    "v=spf1 mx include:spf.protection.outlook.com ip4:5.45.109.84 ip4:37.200.98.157 ip4:46.231.176.212 ip4:46.231.176.222 ip6:2a03:4000:6:20f6::1 -all",
    "qnyahgpqws3avvd5kcmwo6pbch9tv5yl",
    "MS=ms63620310"
  ]
}

# DMARC record (remains unchanged)
resource "aws_route53_record" "barzahlen_at_dmarc" {
  zone_id = aws_route53_zone.barzahlen_at.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = 3600
  records = ["v=DMARC1; p=reject; ruf=mailto:admin@viafintech.com; fo=1"]
}
