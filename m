From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 26/34] ARM: dts: am33xx: add minimal l4 bus layout with control module support
Date: Tue, 31 Mar 2015 22:14:19 +0300
Message-ID: <1427829267-32077-27-git-send-email-t-kristo@ti.com>
References: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56462 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795AbbCaTPQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Mar 2015 15:15:16 -0400
In-Reply-To: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This patch creates an l4_wkup interconnect for AM33xx, and moves some of
the generic peripherals under it. System control module nodes are moved
under this new interconnect also, and the SCM clock layout is changed
to use the renamed SCM node as the clock provider.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 Documentation/devicetree/bindings/arm/omap/l4.txt  |    1 +
 .../devicetree/bindings/arm/omap/prcm.txt          |    2 +-
 arch/arm/boot/dts/am33xx-clocks.dtsi               |    2 +-
 arch/arm/boot/dts/am33xx.dtsi                      |   87 +++++++++++---------
 arch/arm/mach-omap2/control.c                      |    2 +-
 5 files changed, 51 insertions(+), 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/l4.txt b/Documentation/devicetree/bindings/arm/omap/l4.txt
index 6402022..d333f0a 100644
--- a/Documentation/devicetree/bindings/arm/omap/l4.txt
+++ b/Documentation/devicetree/bindings/arm/omap/l4.txt
@@ -6,6 +6,7 @@ Required properties:
 - compatible : Should be "ti,omap2-l4" for OMAP2 family l4 core bus
 	       Should be "ti,omap2-l4-wkup" for OMAP2 family l4 wkup bus
 	       Should be "ti,omap3-l4-core" for OMAP3 family l4 core bus
+	       Should be "ti,am3-l4-wkup" for AM33xx family l4 wkup bus
 - ranges : contains the IO map range for the bus
 
 Examples:
diff --git a/Documentation/devicetree/bindings/arm/omap/prcm.txt b/Documentation/devicetree/bindings/arm/omap/prcm.txt
index ef5a74b..c8e2027 100644
--- a/Documentation/devicetree/bindings/arm/omap/prcm.txt
+++ b/Documentation/devicetree/bindings/arm/omap/prcm.txt
@@ -10,7 +10,7 @@ documentation about the individual clock/clockdomain nodes.
 Required properties:
 - compatible:	Must be one of:
 		"ti,am3-prcm"
-		"ti,am3-scrm"
+		"ti,am3-scm"
 		"ti,am4-prcm"
 		"ti,am4-scrm"
 		"ti,omap2-prcm"
diff --git a/arch/arm/boot/dts/am33xx-clocks.dtsi b/arch/arm/boot/dts/am33xx-clocks.dtsi
index 712edce..236c78a 100644
--- a/arch/arm/boot/dts/am33xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am33xx-clocks.dtsi
@@ -7,7 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-&scrm_clocks {
+&scm_clocks {
 	sys_clkin_ck: sys_clkin_ck {
 		#clock-cells = <0>;
 		compatible = "ti,mux-clock";
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index acd3705..21fcc44 100644
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
@@ -111,37 +97,58 @@
 		ranges;
 		ti,hwmods = "l3_main";
 
-		prcm: prcm@44e00000 {
-			compatible = "ti,am3-prcm";
-			reg = <0x44e00000 0x4000>;
-
-			prcm_clocks: clocks {
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
+		l4_wkup: l4_wkup@44c00000 {
+			compatible = "ti,am3-l4-wkup", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x44c00000 0x280000>;
 
-			prcm_clockdomains: clockdomains {
-			};
-		};
+			prcm: prcm@200000 {
+				compatible = "ti,am3-prcm";
+				reg = <0x200000 0x4000>;
 
-		scrm: scrm@44e10000 {
-			compatible = "ti,am3-scrm";
-			reg = <0x44e10000 0x2000>;
+				prcm_clocks: clocks {
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
 
-			scrm_clocks: clocks {
-				#address-cells = <1>;
-				#size-cells = <0>;
+				prcm_clockdomains: clockdomains {
+				};
 			};
 
-			scrm_clockdomains: clockdomains {
+			scm: scm@210000 {
+				compatible = "ti,am3-scm", "simple-bus";
+				reg = <0x210000 0x2000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x210000 0x2000>;
+
+				am33xx_pinmux: pinmux@800 {
+					compatible = "pinctrl-single";
+					reg = <0x800 0x238>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					pinctrl-single,register-width = <32>;
+					pinctrl-single,function-mask = <0x7f>;
+				};
+
+				scm_conf: scm_conf@0 {
+					compatible = "syscon";
+					reg = <0x0 0x800>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					scm_clocks: clocks {
+						#address-cells = <1>;
+						#size-cells = <0>;
+					};
+				};
+
+				scm_clockdomains: clockdomains {
+				};
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
@@ -350,7 +357,7 @@
 			reg = <0x481cc000 0x2000>;
 			clocks = <&dcan0_fck>;
 			clock-names = "fck";
-			syscon-raminit = <&am33xx_control_module 0x644 0>;
+			syscon-raminit = <&scm_conf 0x644 0>;
 			interrupts = <52>;
 			status = "disabled";
 		};
@@ -361,7 +368,7 @@
 			reg = <0x481d0000 0x2000>;
 			clocks = <&dcan1_fck>;
 			clock-names = "fck";
-			syscon-raminit = <&am33xx_control_module 0x644 1>;
+			syscon-raminit = <&scm_conf 0x644 1>;
 			interrupts = <55>;
 			status = "disabled";
 		};
@@ -720,7 +727,7 @@
 			 */
 			interrupts = <40 41 42 43>;
 			ranges;
-			syscon = <&cm>;
+			syscon = <&scm_conf>;
 			status = "disabled";
 
 			davinci_mdio: mdio@4a101000 {
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 30f5aff..477e2c8 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -667,7 +667,7 @@ static const struct control_init_data omap2_ctrl_data = {
 };
 
 static const struct of_device_id omap_scrm_dt_match_table[] = {
-	{ .compatible = "ti,am3-scrm", .data = &ctrl_data },
+	{ .compatible = "ti,am3-scm", .data = &ctrl_data },
 	{ .compatible = "ti,am4-scrm", .data = &ctrl_data },
 	{ .compatible = "ti,omap2-scm", .data = &omap2_ctrl_data },
 	{ .compatible = "ti,omap3-scm", .data = &omap2_ctrl_data },
-- 
1.7.9.5

