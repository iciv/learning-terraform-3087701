division          = "Barcode"
region            = "us-west-2"
env               = "prod"
BudgetedIn        = "AWSMigrationBudget"
ResourceType      = "Infra_Network"
ResourceUsage     = "AlwaysOn_Permanent"
UsageType         = "SingleBU_Infra"
AWSConfigCoverage = "Yes"

r53_zones = [
  {
    # Create the Route 53 zone for barzahlen.at
    zone_name = "barzahlen.at",
    name      = "barzahlen.at-public",
    comment   = "this_is_config_of_domain_barzahlen_at_tf",
    tags      = { name = "barzahlen.at" },
    vpc       = [],

    records = [
      # CAA Records
      {
        name        = ""
        description = "barzahlen_at_caa"
        type        = "CAA"
        ttl         = 86400
        records = [
          "0 issue \"digicert.com\"",
          "0 issue \"comodo.com\"",
          "0 issue \"letsencrypt.org\"",
          "0 issue \"globalsign.com\"",
          "0 issue \"sectigo.com\""
        ]
      },

      # A record for controlcenter
      {
        name        = "controlcenter"
        description = "barzahlen_at_controlcenter_a"
        type        = "A"
        ttl         = 3600
        records     = ["80.82.206.134"]
      },

      # CNAME record for autodiscover
      {
        name        = "autodiscover"
        description = "barzahlen_at_autodiscover_cname"
        type        = "CNAME"
        ttl         = 3600
        records     = ["autodiscover.outlook.com"]
      },

      # CNAME record for selector1._domainkey
      {
        name        = "selector1._domainkey"
        description = "barzahlen_at_selector1dkey_cname"
        type        = "CNAME"
        ttl         = 3600
        records     = ["selector1-barzahlen-at._domainkey.skrill.onmicrosoft.com"]
      },

      # CNAME record for selector2._domainkey
      {
        name        = "selector2._domainkey"
        description = "barzahlen_at_selector2dkey_cname"
        type        = "CNAME"
        ttl         = 3600
        records     = ["selector2-barzahlen-at._domainkey.skrill.onmicrosoft.com"]
      },

      # Combined TXT records for the root domain
      {
        name        = ""
        description = "barzahlen_at_txt"
        type        = "TXT"
        ttl         = 3600
        records = [
          "v=spf1 mx include:spf.protection.outlook.com ip4:5.45.109.84 ip4:37.200.98.157 ip4:46.231.176.212 ip4:46.231.176.222 ip6:2a03:4000:6:20f6::1 -all",
          "qnyahgpqws3avvd5kcmwo6pbch9tv5yl",
          "MS=ms63620310"
        ]
      },

      # DMARC TXT record
      {
        name        = "_dmarc"
        description = "barzahlen_at_dmarc"
        type        = "TXT"
        ttl         = 3600
        records     = ["v=DMARC1; p=reject; ruf=mailto:admin@viafintech.com; fo=1"]
      }
    ]
  },

  {
    # Specify a zone for barzahlen.ch
    zone_name = "barzahlen.ch",
    name      = "barzahlen.ch-public",
    comment   = "this_is_config_of_domain_barzahlen_ch_tf",
    tags      = { name = "barzahlen.ch" },
    vpc       = [],

    records = [
      # Combined CAA configuration
      {
        name        = ""
        description = "barzahlen_ch_caa"
        type        = "CAA"
        ttl         = 3600
        records = [
          "0 issue \"digicert.com\"",
          "0 issue \"comodo.com\"",
          "0 issue \"letsencrypt.org\"",
          "0 issue \"globalsign.com\"",
          "0 issue \"sectigo.com\""
        ]
      },

      # A-record for controlcenter.barzahlen.ch
      {
        name        = "controlcenter"
        description = "barzahlen_ch_controlcenter_a"
        type        = "A"
        ttl         = 3600
        records     = ["80.82.206.134"]
      },

      # CNAME-record for autodiscover.barzahlen.ch
      {
        name        = "autodiscover"
        description = "barzahlen_ch_autodiscover_cname"
        type        = "CNAME"
        ttl         = 3600
        records     = ["autodiscover.outlook.com."]
      },

      # CNAME-record for selector1._domainkey.barzahlen.ch
      {
        name        = "selector1._domainkey"
        description = "barzahlen_ch_selector1dkey_cname"
        type        = "CNAME"
        ttl         = 3600
        records     = ["selector1-barzahlen-ch._domainkey.skrill.onmicrosoft.com."]
      },

      # CNAME-record for selector2._domainkey.barzahlen.ch
      {
        name        = "selector2._domainkey"
        description = "barzahlen_ch_selector2dkey_cname"
        type        = "CNAME"
        ttl         = 3600
        records     = ["selector2-barzahlen-ch._domainkey.skrill.onmicrosoft.com."]
      },

      # MX-record for barzahlen.ch
      {
        name        = ""
        description = "barzahlen_ch_mx"
        type        = "MX"
        ttl         = 3600
        records     = ["0 paysafe-com.mail.protection.outlook.com."]
      },

      # Combined TXT record for SPF and Paysafe verification
      {
        name        = ""
        description = "barzahlen_ch_txt_combined"
        type        = "TXT"
        ttl         = 3600
        records = [
          "v=spf1 mx include:spf.protection.outlook.com ip4:5.45.109.84 ip4:37.200.98.157 ip4:46.231.176.212 ip4:46.231.176.222 ip6:2a03:4000:6:20f6::1 -all", # SPF record
          "MS=ms40277327"                                                                                                                                      # Paysafe verification
        ]
      },

      # DMARC TXT record (report-only)
      {
        name        = "_dmarc"
        description = "barzahlen_ch_dmarc"
        type        = "TXT"
        ttl         = 3600
        records     = ["v=DMARC1; p=reject; ruf=mailto:admin@viafintech.com; fo=1"]
      }
    ]
  }
]
