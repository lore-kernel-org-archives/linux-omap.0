From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 10/17] ARM: dts: Add missing wdt3 node for omap4
Date: Wed, 30 Aug 2017 08:19:46 -0700
Message-ID: <20170830151953.30856-11-tony@atomide.com>
References: <20170830151953.30856-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170830151953.30856-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On omap4 we're missing the wdt3 node with it's related "ti,hwmods"
property that the SoC interconnect code needs.

Note that this will only show up as a bug with "doesn't have
mpu register target base" boot errors when the legacy platform
data is removed.

Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap4.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -697,6 +697,14 @@
 			ti,hwmods = "wd_timer2";
 		};
 
+		wdt3: wdt@40130000 {
+			compatible = "ti,omap4-wdt", "ti,omap3-wdt";
+			reg = <0x40130000 0x80>, /* MPU private access */
+			      <0x49030000 0x80>; /* L3 Interconnect */
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "wd_timer3";
+		};
+
 		mcpdm: mcpdm@40132000 {
 			compatible = "ti,omap4-mcpdm";
 			reg = <0x40132000 0x7f>, /* MPU private access */
-- 
2.14.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
