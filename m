From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] ARM: dts: omap4-droid4: Configure CPCAP battery driver
Date: Mon, 12 Jun 2017 00:21:38 -0700
Message-ID: <20170612072138.30203-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Configure CPCAP battery driver.

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
--- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
@@ -26,6 +26,22 @@
 			#io-channel-cells = <1>;
 		};
 
+		cpcap_battery: battery {
+			compatible = "motorola,cpcap-battery";
+			interrupts-extended = <
+				&cpcap 6 0 &cpcap 5 0 &cpcap 3 0
+				&cpcap 20 0 &cpcap 54 0
+			>;
+			interrupt-names =
+				"eol", "lowbph", "lowbpl",
+				"chrgcurr1", "battdetb";
+			io-channels = <&cpcap_adc 0 &cpcap_adc 1
+				       &cpcap_adc 5 &cpcap_adc 6>;
+			io-channel-names = "battdetb", "battp",
+					   "chg_isense", "batti";
+			power-supplies = <&cpcap_charger>;
+		};
+
 		cpcap_charger: charger {
 			compatible = "motorola,mapphone-cpcap-charger";
 			interrupts-extended = <
-- 
2.13.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
