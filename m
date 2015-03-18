From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 27/35] ARM: dts: am33xx: merge control module features under scrm node
Date: Wed, 18 Mar 2015 16:44:12 +0200
Message-ID: <1426689860-17537-28-git-send-email-t-kristo@ti.com>
References: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56528 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755184AbbCROpe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2015 10:45:34 -0400
In-Reply-To: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This patch moves all the control module related features under scrm
node. scm_conf area is changed to use syscon, and also the clocks
are moved under scm_conf area.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   48 ++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index acd3705..b30e238 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -83,20 +83,6 @@
 		};
 	};
 
-	am33xx_control_module: control_module@4a002000 {
-		compatible = "syscon";
-		reg = <0x44e10000 0x7fc>;
-	};
-
-	am33xx_pinmux: pinmux@44e10800 {
-		compatible = "pinctrl-single";
-		reg = <0x44e10800 0x0238>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		pinctrl-single,register-width = <32>;
-		pinctrl-single,function-mask = <0x7f>;
-	};
-
 	/*
 	 * XXX: Use a flat representation of the AM33XX interconnect.
 	 * The real AM33XX interconnect network is quite complex. Since
@@ -125,21 +111,35 @@
 		};
 
 		scrm: scrm@44e10000 {
-			compatible = "ti,am3-scrm";
+			compatible = "ti,am3-scrm", "simple-bus";
 			reg = <0x44e10000 0x2000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x44e10000 0x2000>;
 
-			scrm_clocks: clocks {
+			am33xx_pinmux: pinmux@800 {
+				compatible = "pinctrl-single";
+				reg = <0x800 0x238>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				pinctrl-single,register-width = <32>;
+				pinctrl-single,function-mask = <0x7f>;
 			};
 
-			scrm_clockdomains: clockdomains {
+			scm_conf: scm_conf@0 {
+				compatible = "syscon";
+				reg = <0x0 0x7fc>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				scrm_clocks: clocks {
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
 			};
-		};
 
-		cm: syscon@44e10000 {
-			compatible = "ti,am33xx-controlmodule", "syscon";
-			reg = <0x44e10000 0x800>;
+			scrm_clockdomains: clockdomains {
+			};
 		};
 
 		intc: interrupt-controller@48200000 {
@@ -350,7 +350,7 @@
 			reg = <0x481cc000 0x2000>;
 			clocks = <&dcan0_fck>;
 			clock-names = "fck";
-			syscon-raminit = <&am33xx_control_module 0x644 0>;
+			syscon-raminit = <&scm_conf 0x644 0>;
 			interrupts = <52>;
 			status = "disabled";
 		};
@@ -361,7 +361,7 @@
 			reg = <0x481d0000 0x2000>;
 			clocks = <&dcan1_fck>;
 			clock-names = "fck";
-			syscon-raminit = <&am33xx_control_module 0x644 1>;
+			syscon-raminit = <&scm_conf 0x644 1>;
 			interrupts = <55>;
 			status = "disabled";
 		};
@@ -720,7 +720,7 @@
 			 */
 			interrupts = <40 41 42 43>;
 			ranges;
-			syscon = <&cm>;
+			syscon = <&scm_conf>;
 			status = "disabled";
 
 			davinci_mdio: mdio@4a101000 {
-- 
1.7.9.5

