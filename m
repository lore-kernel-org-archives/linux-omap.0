From: Mathieu Malaterre <malat-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: [PATCH] arm: dts: Remove leading 0x and 0s from bindings notation
Date: Thu, 14 Dec 2017 17:53:48 +0100
Message-ID: <20171214165350.27850-1-malat@debian.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mathieu Malaterre <malat-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Jesper Nilsson <jesper.nilsson-VrBV9hrLPhE@public.gmane.org>, Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>, Niklas Cassel <niklas.cassel-VrBV9hrLPhE@public.gmane.org>, Nicolas Ferre <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Jon Mason <jonmason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Improve the DTS files by removing all the leading "0x" and zeros to fix the
following dtc warnings:

Warning (unit_address_format): Node /XXX unit name should not have leading "0x"

and

Warning (unit_address_format): Node /XXX unit name should not have leading 0s

Converted using the following command:

find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -E -i -e "s/@0x([0-9a-fA-F\.]+)\s?\{/@\L\1 \{/g" -e "s/@0+([0-9a-fA-F\.]+)\s?\{/@\L\1 \{/g" {} +

For simplicity, two sed expressions were used to solve each warnings separately.

To make the regex expression more robust a few other issues were resolved,
namely setting unit-address to lower case, and adding a whitespace before the
the opening curly brace:

https://elinux.org/Device_Tree_Linux#Linux_conventions

This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")

Reported-by: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Suggested-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Mathieu Malaterre <malat-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
---
 arch/arm/boot/dts/am3517.dtsi                 |  4 +--
 arch/arm/boot/dts/arm-realview-eb.dtsi        | 18 +++++++-------
 arch/arm/boot/dts/arm-realview-pb1176.dts     | 18 +++++++-------
 arch/arm/boot/dts/arm-realview-pb11mp.dts     | 18 +++++++-------
 arch/arm/boot/dts/arm-realview-pbx.dtsi       | 18 +++++++-------
 arch/arm/boot/dts/artpec6.dtsi                |  2 +-
 arch/arm/boot/dts/at91sam9261.dtsi            |  2 +-
 arch/arm/boot/dts/at91sam9261ek.dts           |  2 +-
 arch/arm/boot/dts/at91sam9263.dtsi            |  2 +-
 arch/arm/boot/dts/at91sam9263ek.dts           |  2 +-
 arch/arm/boot/dts/at91sam9g25ek.dts           |  2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi            |  2 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts        |  2 +-
 arch/arm/boot/dts/atlas7.dtsi                 | 12 ++++-----
 arch/arm/boot/dts/bcm11351.dtsi               |  2 +-
 arch/arm/boot/dts/bcm21664.dtsi               |  2 +-
 arch/arm/boot/dts/bcm283x.dtsi                |  2 +-
 arch/arm/boot/dts/da850-lcdk.dts              |  4 +--
 arch/arm/boot/dts/dm8148-evm.dts              |  8 +++---
 arch/arm/boot/dts/dm8168-evm.dts              |  8 +++---
 arch/arm/boot/dts/dra62x-j5eco-evm.dts        |  8 +++---
 arch/arm/boot/dts/exynos5420.dtsi             | 36 +++++++++++++--------------
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi |  2 +-
 arch/arm/boot/dts/imx7d.dtsi                  |  2 +-
 arch/arm/boot/dts/keystone-k2e-netcp.dtsi     |  2 +-
 arch/arm/boot/dts/keystone-k2hk-netcp.dtsi    |  2 +-
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi     |  2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi           |  8 +++---
 arch/arm/boot/dts/omap3-evm-37xx.dts          |  8 +++---
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi       |  8 +++---
 arch/arm/boot/dts/s3c2416.dtsi                |  2 +-
 arch/arm/boot/dts/sama5d3xmb.dtsi             |  2 +-
 arch/arm/boot/dts/sama5d3xmb_cmp.dtsi         |  2 +-
 arch/arm/boot/dts/socfpga.dtsi                |  2 +-
 arch/arm/boot/dts/spear300.dtsi               |  2 +-
 arch/arm/boot/dts/spear310.dtsi               |  2 +-
 arch/arm/boot/dts/spear320.dtsi               |  2 +-
 arch/arm/boot/dts/versatile-ab.dts            | 16 ++++++------
 arch/arm/boot/dts/zx296702.dtsi               | 20 +++++++--------
 39 files changed, 129 insertions(+), 129 deletions(-)

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index 00da3f2c4072..76994165fb3a 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -26,7 +26,7 @@
 			interrupt-names = "mc";
 		};
 
-		davinci_emac: ethernet@0x5c000000 {
+		davinci_emac: ethernet@5c000000 {
 			compatible = "ti,am3517-emac";
 			ti,hwmods = "davinci_emac";
 			status = "disabled";
@@ -41,7 +41,7 @@
 			local-mac-address = [ 00 00 00 00 00 00 ];
 		};
 
-		davinci_mdio: ethernet@0x5c030000 {
+		davinci_mdio: ethernet@5c030000 {
 			compatible = "ti,davinci_mdio";
 			ti,hwmods = "davinci_mdio";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/arm-realview-eb.dtsi b/arch/arm/boot/dts/arm-realview-eb.dtsi
index e2e9599596e2..f92fb6debc13 100644
--- a/arch/arm/boot/dts/arm-realview-eb.dtsi
+++ b/arch/arm/boot/dts/arm-realview-eb.dtsi
@@ -154,7 +154,7 @@
 			compatible = "arm,realview-eb-syscon", "syscon", "simple-mfd";
 			reg = <0x10000000 0x1000>;
 
-			led@08.0 {
+			led@8.0 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x01>;
@@ -162,7 +162,7 @@
 				linux,default-trigger = "heartbeat";
 				default-state = "on";
 			};
-			led@08.1 {
+			led@8.1 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x02>;
@@ -170,7 +170,7 @@
 				linux,default-trigger = "mmc0";
 				default-state = "off";
 			};
-			led@08.2 {
+			led@8.2 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x04>;
@@ -178,42 +178,42 @@
 				linux,default-trigger = "cpu0";
 				default-state = "off";
 			};
-			led@08.3 {
+			led@8.3 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x08>;
 				label = "versatile:3";
 				default-state = "off";
 			};
-			led@08.4 {
+			led@8.4 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x10>;
 				label = "versatile:4";
 				default-state = "off";
 			};
-			led@08.5 {
+			led@8.5 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x20>;
 				label = "versatile:5";
 				default-state = "off";
 			};
-			led@08.6 {
+			led@8.6 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x40>;
 				label = "versatile:6";
 				default-state = "off";
 			};
-			led@08.7 {
+			led@8.7 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x80>;
 				label = "versatile:7";
 				default-state = "off";
 			};
-			oscclk0: osc0@0c {
+			oscclk0: osc0@c {
 				compatible = "arm,syscon-icst307";
 				#clock-cells = <0>;
 				lock-offset = <0x20>;
diff --git a/arch/arm/boot/dts/arm-realview-pb1176.dts b/arch/arm/boot/dts/arm-realview-pb1176.dts
index c789564f2803..c918949d7c21 100644
--- a/arch/arm/boot/dts/arm-realview-pb1176.dts
+++ b/arch/arm/boot/dts/arm-realview-pb1176.dts
@@ -172,7 +172,7 @@
 			compatible = "arm,realview-pb1176-syscon", "syscon", "simple-mfd";
 			reg = <0x10000000 0x1000>;
 
-			led@08.0 {
+			led@8.0 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x01>;
@@ -180,7 +180,7 @@
 				linux,default-trigger = "heartbeat";
 				default-state = "on";
 			};
-			led@08.1 {
+			led@8.1 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x02>;
@@ -188,7 +188,7 @@
 				linux,default-trigger = "mmc0";
 				default-state = "off";
 			};
-			led@08.2 {
+			led@8.2 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x04>;
@@ -196,42 +196,42 @@
 				linux,default-trigger = "cpu0";
 				default-state = "off";
 			};
-			led@08.3 {
+			led@8.3 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x08>;
 				label = "versatile:3";
 				default-state = "off";
 			};
-			led@08.4 {
+			led@8.4 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x10>;
 				label = "versatile:4";
 				default-state = "off";
 			};
-			led@08.5 {
+			led@8.5 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x20>;
 				label = "versatile:5";
 				default-state = "off";
 			};
-			led@08.6 {
+			led@8.6 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x40>;
 				label = "versatile:6";
 				default-state = "off";
 			};
-			led@08.7 {
+			led@8.7 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x80>;
 				label = "versatile:7";
 				default-state = "off";
 			};
-			oscclk0: osc0@0c {
+			oscclk0: osc0@c {
 				compatible = "arm,syscon-icst307";
 				#clock-cells = <0>;
 				lock-offset = <0x20>;
diff --git a/arch/arm/boot/dts/arm-realview-pb11mp.dts b/arch/arm/boot/dts/arm-realview-pb11mp.dts
index 3944765ac4b0..12c3fb69038a 100644
--- a/arch/arm/boot/dts/arm-realview-pb11mp.dts
+++ b/arch/arm/boot/dts/arm-realview-pb11mp.dts
@@ -253,7 +253,7 @@
 			compatible = "arm,realview-pb11mp-syscon", "syscon", "simple-mfd";
 			reg = <0x10000000 0x1000>;
 
-			led@08.0 {
+			led@8.0 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x01>;
@@ -261,7 +261,7 @@
 				linux,default-trigger = "heartbeat";
 				default-state = "on";
 			};
-			led@08.1 {
+			led@8.1 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x02>;
@@ -269,7 +269,7 @@
 				linux,default-trigger = "mmc0";
 				default-state = "off";
 			};
-			led@08.2 {
+			led@8.2 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x04>;
@@ -277,7 +277,7 @@
 				linux,default-trigger = "cpu0";
 				default-state = "off";
 			};
-			led@08.3 {
+			led@8.3 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x08>;
@@ -285,7 +285,7 @@
 				linux,default-trigger = "cpu1";
 				default-state = "off";
 			};
-			led@08.4 {
+			led@8.4 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x10>;
@@ -293,7 +293,7 @@
 				linux,default-trigger = "cpu2";
 				default-state = "off";
 			};
-			led@08.5 {
+			led@8.5 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x20>;
@@ -301,14 +301,14 @@
 				linux,default-trigger = "cpu3";
 				default-state = "off";
 			};
-			led@08.6 {
+			led@8.6 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x40>;
 				label = "versatile:6";
 				default-state = "off";
 			};
-			led@08.7 {
+			led@8.7 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x80>;
@@ -316,7 +316,7 @@
 				default-state = "off";
 			};
 
-			oscclk0: osc0@0c {
+			oscclk0: osc0@c {
 				compatible = "arm,syscon-icst307";
 				#clock-cells = <0>;
 				lock-offset = <0x20>;
diff --git a/arch/arm/boot/dts/arm-realview-pbx.dtsi b/arch/arm/boot/dts/arm-realview-pbx.dtsi
index aeb49c4bd773..ae080739229e 100644
--- a/arch/arm/boot/dts/arm-realview-pbx.dtsi
+++ b/arch/arm/boot/dts/arm-realview-pbx.dtsi
@@ -169,7 +169,7 @@
 			compatible = "arm,realview-pbx-syscon", "syscon", "simple-mfd";
 			reg = <0x10000000 0x1000>;
 
-			led@08.0 {
+			led@8.0 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x01>;
@@ -177,7 +177,7 @@
 				linux,default-trigger = "heartbeat";
 				default-state = "on";
 			};
-			led@08.1 {
+			led@8.1 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x02>;
@@ -185,7 +185,7 @@
 				linux,default-trigger = "mmc0";
 				default-state = "off";
 			};
-			led@08.2 {
+			led@8.2 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x04>;
@@ -193,42 +193,42 @@
 				linux,default-trigger = "cpu0";
 				default-state = "off";
 			};
-			led@08.3 {
+			led@8.3 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x08>;
 				label = "versatile:3";
 				default-state = "off";
 			};
-			led@08.4 {
+			led@8.4 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x10>;
 				label = "versatile:4";
 				default-state = "off";
 			};
-			led@08.5 {
+			led@8.5 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x20>;
 				label = "versatile:5";
 				default-state = "off";
 			};
-			led@08.6 {
+			led@8.6 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x40>;
 				label = "versatile:6";
 				default-state = "off";
 			};
-			led@08.7 {
+			led@8.7 {
 				compatible = "register-bit-led";
 				offset = <0x08>;
 				mask = <0x80>;
 				label = "versatile:7";
 				default-state = "off";
 			};
-			oscclk0: osc0@0c {
+			oscclk0: osc0@c {
 				compatible = "arm,syscon-icst307";
 				#clock-cells = <0>;
 				lock-offset = <0x20>;
diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
index 2ed11773048d..71e0e75e986b 100644
--- a/arch/arm/boot/dts/artpec6.dtsi
+++ b/arch/arm/boot/dts/artpec6.dtsi
@@ -98,7 +98,7 @@
 		clock-frequency = <125000000>;
 	};
 
-	clkctrl: clkctrl@0xf8000000 {
+	clkctrl: clkctrl@f8000000 {
 		#clock-cells = <1>;
 		compatible = "axis,artpec6-clkctrl";
 		reg = <0xf8000000 0x48>;
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 66876019101d..eb186245fb4c 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -80,7 +80,7 @@
 			status = "disabled";
 		};
 
-		fb0: fb@0x00600000 {
+		fb0: fb@600000 {
 			compatible = "atmel,at91sam9261-lcdc";
 			reg = <0x00600000 0x1000>;
 			interrupts = <21 IRQ_TYPE_LEVEL_HIGH 3>;
diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index 960d6940ebf6..9733db3f739b 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -36,7 +36,7 @@
 			status = "okay";
 		};
 
-		fb0: fb@0x00600000 {
+		fb0: fb@600000 {
 			display = <&display0>;
 			atmel,power-control-gpio = <&pioA 12 GPIO_ACTIVE_LOW>;
 			status = "okay";
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index e54f14d36b6f..a26f7ada429d 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -999,7 +999,7 @@
 			};
 		};
 
-		fb0: fb@0x00700000 {
+		fb0: fb@700000 {
 			compatible = "atmel,at91sam9263-lcdc";
 			reg = <0x00700000 0x1000>;
 			interrupts = <26 IRQ_TYPE_LEVEL_HIGH 3>;
diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 5a2e1af793f5..f095b5d4d410 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -95,7 +95,7 @@
 			};
 		};
 
-		fb0: fb@0x00700000 {
+		fb0: fb@700000 {
 			display = <&display0>;
 			status = "okay";
 
diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index 91a71774472e..31fecc2cdaf9 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -25,7 +25,7 @@
 			};
 
 			i2c0: i2c@f8010000 {
-				ov2640: camera@0x30 {
+				ov2640: camera@30 {
 					compatible = "ovti,ov2640";
 					reg = <0x30>;
 					pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 2b127ca7aaa0..98348ebd6488 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -1302,7 +1302,7 @@
 			};
 		};
 
-		fb0: fb@0x00500000 {
+		fb0: fb@500000 {
 			compatible = "atmel,at91sam9g45-lcdc";
 			reg = <0x00500000 0x1000>;
 			interrupts = <23 IRQ_TYPE_LEVEL_HIGH 3>;
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index e922552a04cb..d793451ee04c 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -220,7 +220,7 @@
 			};
 		};
 
-		fb0: fb@0x00500000 {
+		fb0: fb@500000 {
 			display = <&display0>;
 			status = "okay";
 
diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index 83449b33de6b..920d22882f21 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -1170,7 +1170,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x13240000 0x13240000 0x00010000>;
-			pmipc@0x13240000 {
+			pmipc@13240000 {
 				compatible = "sirf,atlas7-pmipc";
 				reg = <0x13240000 0x00010000>;
 			};
@@ -1265,7 +1265,7 @@
 				#dma-cells = <1>;
 			};
 
-			gnssmfw@0x18100000 {
+			gnssmfw@18100000 {
 				compatible = "sirf,nocfw-gnssm";
 				reg = <0x18100000 0x3000>;
 			};
@@ -1374,7 +1374,7 @@
 				<0x13010000 0x13010000 0x1400>,
 				<0x13010800 0x13010800 0x100>,
 				<0x13011000 0x13011000 0x100>;
-			gpum@0x13000000 {
+			gpum@13000000 {
 				compatible = "sirf,nocfw-gpum";
 				reg = <0x13000000 0x3000>;
 			};
@@ -1396,7 +1396,7 @@
 				#dma-cells = <1>;
 				#dma-channels = <1>;
 			};
-			sdr@0x13010000 {
+			sdr@13010000 {
 				compatible = "sirf,atlas7-sdr";
 				reg = <0x13010000 0x1400>;
 				interrupts = <0 7 0>,
@@ -1780,7 +1780,7 @@
 				interrupts = <0 105 0>;
 			};
 
-			memory-controller@0x10800000 {
+			memory-controller@10800000 {
 				compatible = "sirf,atlas7-memc";
 				reg = <0x10800000 0x2000>;
 			};
@@ -1896,7 +1896,7 @@
 				#size-cells = <0>;
 			};
 
-			retain@0x188D0000 {
+			retain@188d0000 {
 				compatible = "sirf,atlas7-retain";
 				reg = <0x188D0000 0x1000>;
 			};
diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 18045c38bcf1..db7cded1b7ad 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -55,7 +55,7 @@
 		      <0x3ff00100 0x100>;
 	};
 
-	smc@0x3404c000 {
+	smc@3404c000 {
 		compatible = "brcm,bcm11351-smc", "brcm,kona-smc";
 		reg = <0x3404c000 0x400>; /* 1 KiB in SRAM */
 	};
diff --git a/arch/arm/boot/dts/bcm21664.dtsi b/arch/arm/boot/dts/bcm21664.dtsi
index 6dde95f21cef..266f2611dc22 100644
--- a/arch/arm/boot/dts/bcm21664.dtsi
+++ b/arch/arm/boot/dts/bcm21664.dtsi
@@ -55,7 +55,7 @@
 		      <0x3ff00100 0x100>;
 	};
 
-	smc@0x3404e000 {
+	smc@3404e000 {
 		compatible = "brcm,bcm21664-smc", "brcm,kona-smc";
 		reg = <0x3404e000 0x400>; /* 1 KiB in SRAM */
 	};
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index dcde93c85c2d..2ee4f04ea9d4 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -464,7 +464,7 @@
 			status = "disabled";
 		};
 
-		aux: aux@0x7e215000 {
+		aux: aux@7e215000 {
 			compatible = "brcm,bcm2835-aux";
 			#clock-cells = <1>;
 			reg = <0x7e215000 0x8>;
diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index eed89e659143..a1f4d6d5a569 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -293,12 +293,12 @@
 					label = "u-boot env";
 					reg = <0 0x020000>;
 				};
-				partition@0x020000 {
+				partition@20000 {
 					/* The LCDK defaults to booting from this partition */
 					label = "u-boot";
 					reg = <0x020000 0x080000>;
 				};
-				partition@0x0a0000 {
+				partition@a0000 {
 					label = "free space";
 					reg = <0x0a0000 0>;
 				};
diff --git a/arch/arm/boot/dts/dm8148-evm.dts b/arch/arm/boot/dts/dm8148-evm.dts
index d6657b3bae84..7747a5b9657f 100644
--- a/arch/arm/boot/dts/dm8148-evm.dts
+++ b/arch/arm/boot/dts/dm8148-evm.dts
@@ -74,19 +74,19 @@
 			label = "X-Loader";
 			reg = <0 0x80000>;
 		};
-		partition@0x80000 {
+		partition@80000 {
 			label = "U-Boot";
 			reg = <0x80000 0x1c0000>;
 		};
-		partition@0x1c0000 {
+		partition@1c0000 {
 			label = "Environment";
 			reg = <0x240000 0x40000>;
 		};
-		partition@0x280000 {
+		partition@280000 {
 			label = "Kernel";
 			reg = <0x280000 0x500000>;
 		};
-		partition@0x780000 {
+		partition@780000 {
 			label = "Filesystem";
 			reg = <0x780000 0xf880000>;
 		};
diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
index c72a2132aa82..85dd3c703dff 100644
--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -158,19 +158,19 @@
 			label = "X-Loader";
 			reg = <0 0x80000>;
 		};
-		partition@0x80000 {
+		partition@80000 {
 			label = "U-Boot";
 			reg = <0x80000 0x1c0000>;
 		};
-		partition@0x1c0000 {
+		partition@1c0000 {
 			label = "Environment";
 			reg = <0x240000 0x40000>;
 		};
-		partition@0x280000 {
+		partition@280000 {
 			label = "Kernel";
 			reg = <0x280000 0x500000>;
 		};
-		partition@0x780000 {
+		partition@780000 {
 			label = "Filesystem";
 			reg = <0x780000 0xf880000>;
 		};
diff --git a/arch/arm/boot/dts/dra62x-j5eco-evm.dts b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
index 155eb32ee213..fee0547f7302 100644
--- a/arch/arm/boot/dts/dra62x-j5eco-evm.dts
+++ b/arch/arm/boot/dts/dra62x-j5eco-evm.dts
@@ -74,19 +74,19 @@
 			label = "X-Loader";
 			reg = <0 0x80000>;
 		};
-		partition@0x80000 {
+		partition@80000 {
 			label = "U-Boot";
 			reg = <0x80000 0x1c0000>;
 		};
-		partition@0x1c0000 {
+		partition@1c0000 {
 			label = "Environment";
 			reg = <0x240000 0x40000>;
 		};
-		partition@0x280000 {
+		partition@280000 {
 			label = "Kernel";
 			reg = <0x280000 0x500000>;
 		};
-		partition@0x780000 {
+		partition@780000 {
 			label = "Filesystem";
 			reg = <0x780000 0xf880000>;
 		};
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 8aa2cc7aa125..05ddbcf4413b 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -752,7 +752,7 @@
 			#include "exynos5420-tmu-sensor-conf.dtsi"
 		};
 
-		sysmmu_g2dr: sysmmu@0x10A60000 {
+		sysmmu_g2dr: sysmmu@10a60000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x10A60000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -762,7 +762,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_g2dw: sysmmu@0x10A70000 {
+		sysmmu_g2dw: sysmmu@10a70000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x10A70000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -772,7 +772,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_tv: sysmmu@0x14650000 {
+		sysmmu_tv: sysmmu@14650000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x14650000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -783,7 +783,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_gscl0: sysmmu@0x13E80000 {
+		sysmmu_gscl0: sysmmu@13e80000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x13E80000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -794,7 +794,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_gscl1: sysmmu@0x13E90000 {
+		sysmmu_gscl1: sysmmu@13e90000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x13E90000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -805,7 +805,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_scaler0r: sysmmu@0x12880000 {
+		sysmmu_scaler0r: sysmmu@12880000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x12880000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -815,7 +815,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_scaler1r: sysmmu@0x12890000 {
+		sysmmu_scaler1r: sysmmu@12890000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x12890000 0x1000>;
 			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
@@ -824,7 +824,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_scaler2r: sysmmu@0x128A0000 {
+		sysmmu_scaler2r: sysmmu@128a0000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x128A0000 0x1000>;
 			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
@@ -833,7 +833,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_scaler0w: sysmmu@0x128C0000 {
+		sysmmu_scaler0w: sysmmu@128c0000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x128C0000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -843,7 +843,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_scaler1w: sysmmu@0x128D0000 {
+		sysmmu_scaler1w: sysmmu@128d0000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x128D0000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -853,7 +853,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_scaler2w: sysmmu@0x128E0000 {
+		sysmmu_scaler2w: sysmmu@128e0000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x128E0000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -863,7 +863,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_rotator: sysmmu@0x11D40000 {
+		sysmmu_rotator: sysmmu@11d40000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x11D40000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -873,7 +873,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_jpeg0: sysmmu@0x11F10000 {
+		sysmmu_jpeg0: sysmmu@11f10000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x11F10000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -883,7 +883,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_jpeg1: sysmmu@0x11F20000 {
+		sysmmu_jpeg1: sysmmu@11f20000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x11F20000 0x1000>;
 			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
@@ -892,7 +892,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_mfc_l: sysmmu@0x11200000 {
+		sysmmu_mfc_l: sysmmu@11200000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x11200000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -903,7 +903,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_mfc_r: sysmmu@0x11210000 {
+		sysmmu_mfc_r: sysmmu@11210000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x11210000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -914,7 +914,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_fimd1_0: sysmmu@0x14640000 {
+		sysmmu_fimd1_0: sysmmu@14640000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x14640000 0x1000>;
 			interrupt-parent = <&combiner>;
@@ -925,7 +925,7 @@
 			#iommu-cells = <0>;
 		};
 
-		sysmmu_fimd1_1: sysmmu@0x14680000 {
+		sysmmu_fimd1_1: sysmmu@14680000 {
 			compatible = "samsung,exynos-sysmmu";
 			reg = <0x14680000 0x1000>;
 			interrupt-parent = <&combiner>;
diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index a5b8d0f0877e..353428fe10c4 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -26,7 +26,7 @@
 		stdout-path = "serial2:115200n8";
 	};
 
-	firmware@02073000 {
+	firmware@2073000 {
 		compatible = "samsung,secure-firmware";
 		reg = <0x02073000 0x1000>;
 	};
diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 4d308d17f040..369d5a166b3e 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -129,7 +129,7 @@
 		status = "disabled";
 	};
 
-	pcie: pcie@0x33800000 {
+	pcie: pcie@33800000 {
 		compatible = "fsl,imx7d-pcie", "snps,dw-pcie";
 		reg = <0x33800000 0x4000>,
 		      <0x4ff00000 0x80000>;
diff --git a/arch/arm/boot/dts/keystone-k2e-netcp.dtsi b/arch/arm/boot/dts/keystone-k2e-netcp.dtsi
index ba828cb59587..940b64935bde 100644
--- a/arch/arm/boot/dts/keystone-k2e-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e-netcp.dtsi
@@ -98,7 +98,7 @@ qmss: qmss@2a40000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
-		pdsp0@0x2a10000 {
+		pdsp0@2a10000 {
 			reg = <0x2a10000 0x1000    /*iram */
 			       0x2a0f000 0x100     /*reg*/
 			       0x2a0c000 0x3c8	   /*intd */
diff --git a/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi b/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi
index a5ac845464bf..ed7287a274a0 100644
--- a/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2hk-netcp.dtsi
@@ -115,7 +115,7 @@ qmss: qmss@2a40000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
-		pdsp0@0x2a10000 {
+		pdsp0@2a10000 {
 			reg = <0x2a10000 0x1000    /*iram */
 			       0x2a0f000 0x100     /*reg*/
 			       0x2a0c000 0x3c8	   /*intd */
diff --git a/arch/arm/boot/dts/keystone-k2l-netcp.dtsi b/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
index 66f615a74118..b6af5f78e498 100644
--- a/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l-netcp.dtsi
@@ -97,7 +97,7 @@ qmss: qmss@2a40000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
-		pdsp0@0x2a10000 {
+		pdsp0@2a10000 {
 			reg = <0x2a10000 0x1000    /*iram */
 			       0x2a0f000 0x100     /*reg*/
 			       0x2a0c000 0x3c8	   /*intd */
diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index ab6003fe5a43..9dcb18d22cde 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -306,19 +306,19 @@
 			label = "xloader";
 			reg = <0 0x80000>;
 		};
-		partition@0x80000 {
+		partition@80000 {
 			label = "uboot";
 			reg = <0x80000 0x1e0000>;
 		};
-		partition@0x260000 {
+		partition@260000 {
 			label = "uboot environment";
 			reg = <0x260000 0x40000>;
 		};
-		partition@0x2a0000 {
+		partition@2a0000 {
 			label = "linux";
 			reg = <0x2a0000 0x400000>;
 		};
-		partition@0x6a0000 {
+		partition@6a0000 {
 			label = "rootfs";
 			reg = <0x6a0000 0x1f880000>;
 		};
diff --git a/arch/arm/boot/dts/omap3-evm-37xx.dts b/arch/arm/boot/dts/omap3-evm-37xx.dts
index 5a4ba0aea447..a14303b09ae2 100644
--- a/arch/arm/boot/dts/omap3-evm-37xx.dts
+++ b/arch/arm/boot/dts/omap3-evm-37xx.dts
@@ -90,19 +90,19 @@
 			label = "X-Loader";
 			reg = <0 0x80000>;
 		};
-		partition@0x80000 {
+		partition@80000 {
 			label = "U-Boot";
 			reg = <0x80000 0x1c0000>;
 		};
-		partition@0x1c0000 {
+		partition@1c0000 {
 			label = "Environment";
 			reg = <0x240000 0x40000>;
 		};
-		partition@0x280000 {
+		partition@280000 {
 			label = "Kernel";
 			reg = <0x280000 0x500000>;
 		};
-		partition@0x780000 {
+		partition@780000 {
 			label = "Filesystem";
 			reg = <0x780000 0x1f880000>;
 		};
diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index 7ada1e93e166..cf7a2a72348d 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -405,22 +405,22 @@
 			reg = <0 0x80000>;
 		};
 
-		partition@0x80000 {
+		partition@80000 {
 			label = "u-boot";
 			reg = <0x80000 0x1e0000>;
 		};
 
-		partition@0x260000 {
+		partition@260000 {
 			label = "u-boot-environment";
 			reg = <0x260000 0x20000>;
 		};
 
-		partition@0x280000 {
+		partition@280000 {
 			label = "kernel";
 			reg = <0x280000 0x500000>;
 		};
 
-		partition@0x780000 {
+		partition@780000 {
 			label = "filesystem";
 			reg = <0x780000 0xf880000>;
 		};
diff --git a/arch/arm/boot/dts/s3c2416.dtsi b/arch/arm/boot/dts/s3c2416.dtsi
index 80f007550324..66840f02a618 100644
--- a/arch/arm/boot/dts/s3c2416.dtsi
+++ b/arch/arm/boot/dts/s3c2416.dtsi
@@ -33,7 +33,7 @@
 		compatible = "samsung,s3c2416-irq";
 	};
 
-	clocks: clock-controller@0x4c000000 {
+	clocks: clock-controller@4c000000 {
 		compatible = "samsung,s3c2416-clock";
 		reg = <0x4c000000 0x40>;
 		#clock-cells = <1>;
diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index 7f55050dd405..ef0f2d049e15 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -53,7 +53,7 @@
 			};
 
 			i2c1: i2c@f0018000 {
-				ov2640: camera@0x30 {
+				ov2640: camera@30 {
 					compatible = "ovti,ov2640";
 					reg = <0x30>;
 					pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi b/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi
index 83e3d3e08fd4..97e171db5970 100644
--- a/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb_cmp.dtsi
@@ -88,7 +88,7 @@
 			};
 
 			i2c1: i2c@f0018000 {
-				ov2640: camera@0x30 {
+				ov2640: camera@30 {
 					compatible = "ovti,ov2640";
 					reg = <0x30>;
 					pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 7e24dc8e82d4..36f87eb389b1 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -724,7 +724,7 @@
 			arm,prefetch-offset = <7>;
 		};
 
-		l3regs@0xff800000 {
+		l3regs@ff800000 {
 			compatible = "altr,l3regs", "syscon";
 			reg = <0xff800000 0x1000>;
 		};
diff --git a/arch/arm/boot/dts/spear300.dtsi b/arch/arm/boot/dts/spear300.dtsi
index f4e92e599729..266fefa67223 100644
--- a/arch/arm/boot/dts/spear300.dtsi
+++ b/arch/arm/boot/dts/spear300.dtsi
@@ -52,7 +52,7 @@
 			status = "disabled";
 		};
 
-		shirq: interrupt-controller@0x50000000 {
+		shirq: interrupt-controller@50000000 {
 			compatible = "st,spear300-shirq";
 			reg = <0x50000000 0x1000>;
 			interrupts = <28>;
diff --git a/arch/arm/boot/dts/spear310.dtsi b/arch/arm/boot/dts/spear310.dtsi
index da210b454753..f995ecf09acf 100644
--- a/arch/arm/boot/dts/spear310.dtsi
+++ b/arch/arm/boot/dts/spear310.dtsi
@@ -40,7 +40,7 @@
 			status = "disabled";
 		};
 
-		shirq: interrupt-controller@0xb4000000 {
+		shirq: interrupt-controller@b4000000 {
 			compatible = "st,spear310-shirq";
 			reg = <0xb4000000 0x1000>;
 			interrupts = <28 29 30 1>;
diff --git a/arch/arm/boot/dts/spear320.dtsi b/arch/arm/boot/dts/spear320.dtsi
index 22be6e5edaac..2a062a3ee139 100644
--- a/arch/arm/boot/dts/spear320.dtsi
+++ b/arch/arm/boot/dts/spear320.dtsi
@@ -55,7 +55,7 @@
 			status = "disabled";
 		};
 
-		shirq: interrupt-controller@0xb3000000 {
+		shirq: interrupt-controller@b3000000 {
 			compatible = "st,spear320-shirq";
 			reg = <0xb3000000 0x1000>;
 			interrupts = <30 28 29 1>;
diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 4a51612996bc..8b0ad47e7b1f 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -34,7 +34,7 @@
 		compatible = "arm,core-module-versatile", "syscon", "simple-mfd";
 		reg = <0x10000000 0x200>;
 
-		led@08.0 {
+		led@8.0 {
 			compatible = "register-bit-led";
 			offset = <0x08>;
 			mask = <0x01>;
@@ -42,7 +42,7 @@
 			linux,default-trigger = "heartbeat";
 			default-state = "on";
 		};
-		led@08.1 {
+		led@8.1 {
 			compatible = "register-bit-led";
 			offset = <0x08>;
 			mask = <0x02>;
@@ -50,7 +50,7 @@
 			linux,default-trigger = "mmc0";
 			default-state = "off";
 		};
-		led@08.2 {
+		led@8.2 {
 			compatible = "register-bit-led";
 			offset = <0x08>;
 			mask = <0x04>;
@@ -58,35 +58,35 @@
 			linux,default-trigger = "cpu0";
 			default-state = "off";
 		};
-		led@08.3 {
+		led@8.3 {
 			compatible = "register-bit-led";
 			offset = <0x08>;
 			mask = <0x08>;
 			label = "versatile:3";
 			default-state = "off";
 		};
-		led@08.4 {
+		led@8.4 {
 			compatible = "register-bit-led";
 			offset = <0x08>;
 			mask = <0x10>;
 			label = "versatile:4";
 			default-state = "off";
 		};
-		led@08.5 {
+		led@8.5 {
 			compatible = "register-bit-led";
 			offset = <0x08>;
 			mask = <0x20>;
 			label = "versatile:5";
 			default-state = "off";
 		};
-		led@08.6 {
+		led@8.6 {
 			compatible = "register-bit-led";
 			offset = <0x08>;
 			mask = <0x40>;
 			label = "versatile:6";
 			default-state = "off";
 		};
-		led@08.7 {
+		led@8.7 {
 			compatible = "register-bit-led";
 			offset = <0x08>;
 			mask = <0x80>;
diff --git a/arch/arm/boot/dts/zx296702.dtsi b/arch/arm/boot/dts/zx296702.dtsi
index 8a74efdb6360..240e7a23d81f 100644
--- a/arch/arm/boot/dts/zx296702.dtsi
+++ b/arch/arm/boot/dts/zx296702.dtsi
@@ -56,7 +56,7 @@
 			clocks = <&topclk ZX296702_A9_PERIPHCLK>;
 		};
 
-		l2cc: l2-cache-controller@0x00c00000 {
+		l2cc: l2-cache-controller@c00000 {
 			compatible = "arm,pl310-cache";
 			reg = <0x00c00000 0x1000>;
 			cache-unified;
@@ -67,30 +67,30 @@
 			arm,double-linefill-incr = <0>;
 		};
 
-		pcu: pcu@0xa0008000 {
+		pcu: pcu@a0008000 {
 			compatible = "zte,zx296702-pcu";
 			reg = <0xa0008000 0x1000>;
 		};
 
-		topclk: topclk@0x09800000 {
+		topclk: topclk@9800000 {
 			compatible = "zte,zx296702-topcrm-clk";
 			reg = <0x09800000 0x1000>;
 			#clock-cells = <1>;
 		};
 
-		lsp1clk: lsp1clk@0x09400000 {
+		lsp1clk: lsp1clk@9400000 {
 			compatible = "zte,zx296702-lsp1crpm-clk";
 			reg = <0x09400000 0x1000>;
 			#clock-cells = <1>;
 		};
 
-		lsp0clk: lsp0clk@0x0b000000 {
+		lsp0clk: lsp0clk@b000000 {
 			compatible = "zte,zx296702-lsp0crpm-clk";
 			reg = <0x0b000000 0x1000>;
 			#clock-cells = <1>;
 		};
 
-		uart0: serial@0x09405000 {
+		uart0: serial@9405000 {
 			compatible = "zte,zx296702-uart";
 			reg = <0x09405000 0x1000>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
@@ -98,7 +98,7 @@
 			status = "disabled";
 		};
 
-		uart1: serial@0x09406000 {
+		uart1: serial@9406000 {
 			compatible = "zte,zx296702-uart";
 			reg = <0x09406000 0x1000>;
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
@@ -106,7 +106,7 @@
 			status = "disabled";
 		};
 
-		mmc0: mmc@0x09408000 {
+		mmc0: mmc@9408000 {
 			compatible = "snps,dw-mshc";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -119,7 +119,7 @@
 			status = "disabled";
 		};
 
-		mmc1: mmc@0x0b003000 {
+		mmc1: mmc@b003000 {
 			compatible = "snps,dw-mshc";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -132,7 +132,7 @@
 			status = "disabled";
 		};
 
-		sysctrl: sysctrl@0xa0007000 {
+		sysctrl: sysctrl@a0007000 {
 			compatible = "zte,sysctrl", "syscon";
 			reg = <0xa0007000 0x1000>;
 		};
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
