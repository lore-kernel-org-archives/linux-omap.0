From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 25/33] ARM: dts: am33xx: add syscon support to scrm node
Date: Fri, 13 Feb 2015 18:12:44 +0200
Message-ID: <1423843973-6050-23-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44919 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753776AbbBMQOa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 11:14:30 -0500
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Control module will be converted to use syscon, thus add compatible
string for this. Also, remove the existing duplicate syscon entries
at the same time, and change the users of these to use the real
control module syscon.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index acd3705..71df403e 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -83,11 +83,6 @@
 		};
 	};
 
-	am33xx_control_module: control_module@4a002000 {
-		compatible = "syscon";
-		reg = <0x44e10000 0x7fc>;
-	};
-
 	am33xx_pinmux: pinmux@44e10800 {
 		compatible = "pinctrl-single";
 		reg = <0x44e10800 0x0238>;
@@ -125,8 +120,8 @@
 		};
 
 		scrm: scrm@44e10000 {
-			compatible = "ti,am3-scrm";
-			reg = <0x44e10000 0x2000>;
+			compatible = "ti,am3-scrm", "syscon";
+			reg = <0x44e10000 0x7fc>;
 
 			scrm_clocks: clocks {
 				#address-cells = <1>;
@@ -137,11 +132,6 @@
 			};
 		};
 
-		cm: syscon@44e10000 {
-			compatible = "ti,am33xx-controlmodule", "syscon";
-			reg = <0x44e10000 0x800>;
-		};
-
 		intc: interrupt-controller@48200000 {
 			compatible = "ti,am33xx-intc";
 			interrupt-controller;
@@ -350,7 +340,7 @@
 			reg = <0x481cc000 0x2000>;
 			clocks = <&dcan0_fck>;
 			clock-names = "fck";
-			syscon-raminit = <&am33xx_control_module 0x644 0>;
+			syscon-raminit = <&scrm 0x644 0>;
 			interrupts = <52>;
 			status = "disabled";
 		};
@@ -361,7 +351,7 @@
 			reg = <0x481d0000 0x2000>;
 			clocks = <&dcan1_fck>;
 			clock-names = "fck";
-			syscon-raminit = <&am33xx_control_module 0x644 1>;
+			syscon-raminit = <&scrm 0x644 1>;
 			interrupts = <55>;
 			status = "disabled";
 		};
@@ -720,7 +710,7 @@
 			 */
 			interrupts = <40 41 42 43>;
 			ranges;
-			syscon = <&cm>;
+			syscon = <&scrm>;
 			status = "disabled";
 
 			davinci_mdio: mdio@4a101000 {
-- 
1.7.9.5

