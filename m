From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/3] ARM: dts: omap4-droid4: Add CPCAP PMIC battery charger configuration
Date: Thu, 16 Mar 2017 21:10:11 -0700
Message-ID: <20170317041012.26800-3-tony@atomide.com>
References: <20170317041012.26800-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170317041012.26800-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add CPCAP PMIC battery charger configuration.

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
--- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
@@ -26,6 +26,25 @@
 			#io-channel-cells = <1>;
 		};
 
+		cpcap_charger: charger {
+			compatible = "motorola,mapphone-cpcap-charger";
+			interrupts-extended = <
+				&cpcap 13 0 &cpcap 12 0 &cpcap 29 0 &cpcap 28 0
+				&cpcap 22 0 &cpcap 20 0 &cpcap 19 0 &cpcap 54 0
+			>;
+			interrupt-names =
+				"chrg_det", "rvrs_chrg", "chrg_se1b", "se0conn",
+				"rvrs_mode", "chrgcurr1", "vbusvld", "battdetb";
+			mode-gpios = <&gpio3 29 GPIO_ACTIVE_LOW
+				      &gpio3 23 GPIO_ACTIVE_LOW>;
+			io-channels = <&cpcap_adc 0 &cpcap_adc 1
+				       &cpcap_adc 2 &cpcap_adc 5
+				       &cpcap_adc 6>;
+			io-channel-names = "battdetb", "battp",
+					   "vbus", "chg_isense",
+					   "batti";
+		};
+
 		cpcap_regulator: regulator {
 			compatible = "motorola,mapphone-cpcap-regulator";
 
-- 
2.11.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
