From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/3] Configure CPCAP PMIC ADC, charger and OTG for droid 4
Date: Thu, 16 Mar 2017 21:10:09 -0700
Message-ID: <20170317041012.26800-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi all,

These patches configure ADC, battery charger and USB OTG for
droid 4.

To test, you'll need current Linux next and the following sets
of patches:

- [PATCH v2] genirq: Add support for nested shared IRQs
- [PATCH 0/4] Regmap IRQ fix and related changes CPCAP
- [PATCH] iio: adc: cpcap: Add minimal support for CPCAP PMIC ADC
- [PATCH] power: supply: cpcap-charger: Add minimal CPCAP PMIC battery charger
- [PATCH] phy: cpcap-usb: Add CPCAP PMIC USB support

Regards,

Tony

Tony Lindgren (3):
  ARM: dts: omap4-droid4: Add CPCAP PMIC ADC configuration
  ARM: dts: omap4-droid4: Add CPCAP PMIC battery charger configuration
  ARM: dts: omap4-droid4: Add CPCAP PMIC OTG PHY configuration

 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

-- 
2.11.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
