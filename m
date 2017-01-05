From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] ARM: dts: Fix compatible for ti81xx uarts for 8250
Date: Thu,  5 Jan 2017 11:17:30 -0800
Message-ID: <20170105191730.29158-1-tony@atomide.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

When using 8250_omap driver, we need to specify the right
compatible value for the UART to work on dm814x and dm816x.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/dm814x.dtsi | 6 +++---
 arch/arm/boot/dts/dm816x.dtsi | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -252,7 +252,7 @@
 			};
 
 			uart1: uart@20000 {
-				compatible = "ti,omap3-uart";
+				compatible = "ti,am3352-uart", "ti,omap3-uart";
 				ti,hwmods = "uart1";
 				reg = <0x20000 0x2000>;
 				clock-frequency = <48000000>;
@@ -262,7 +262,7 @@
 			};
 
 			uart2: uart@22000 {
-				compatible = "ti,omap3-uart";
+				compatible = "ti,am3352-uart", "ti,omap3-uart";
 				ti,hwmods = "uart2";
 				reg = <0x22000 0x2000>;
 				clock-frequency = <48000000>;
@@ -272,7 +272,7 @@
 			};
 
 			uart3: uart@24000 {
-				compatible = "ti,omap3-uart";
+				compatible = "ti,am3352-uart", "ti,omap3-uart";
 				ti,hwmods = "uart3";
 				reg = <0x24000 0x2000>;
 				clock-frequency = <48000000>;
diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -373,7 +373,7 @@
 		};
 
 		uart1: uart@48020000 {
-			compatible = "ti,omap3-uart";
+			compatible = "ti,am3352-uart", "ti,omap3-uart";
 			ti,hwmods = "uart1";
 			reg = <0x48020000 0x2000>;
 			clock-frequency = <48000000>;
@@ -383,7 +383,7 @@
 		};
 
 		uart2: uart@48022000 {
-			compatible = "ti,omap3-uart";
+			compatible = "ti,am3352-uart", "ti,omap3-uart";
 			ti,hwmods = "uart2";
 			reg = <0x48022000 0x2000>;
 			clock-frequency = <48000000>;
@@ -393,7 +393,7 @@
 		};
 
 		uart3: uart@48024000 {
-			compatible = "ti,omap3-uart";
+			compatible = "ti,am3352-uart", "ti,omap3-uart";
 			ti,hwmods = "uart3";
 			reg = <0x48024000 0x2000>;
 			clock-frequency = <48000000>;
-- 
2.11.0
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
