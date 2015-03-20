From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 26/35] ARM: dts: omap3: add minimal l4 bus layout with control module support
Date: Fri, 20 Mar 2015 20:44:37 +0200
Message-ID: <1426877086-17131-27-git-send-email-t-kristo@ti.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39513 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783AbbCTSqZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Mar 2015 14:46:25 -0400
In-Reply-To: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, sakari.ailus@iki.fi
Cc: linux-arm-kernel@lists.infradead.org

This patch creates an l4_core interconnect for OMAP3, and moves some
of the generic peripherals under it. System control module nodes are
moved under this new interconnect also, and the SCM clock layout
is changed to use the renamed SCM node as the clock provider.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reported-by: Tony Lindgren <tony@atomide.com>
---
 Documentation/devicetree/bindings/arm/omap/l4.txt  |    1 +
 .../devicetree/bindings/arm/omap/prcm.txt          |    2 +-
 arch/arm/boot/dts/am3517.dtsi                      |    2 +-
 arch/arm/boot/dts/am35xx-clocks.dtsi               |    2 +-
 arch/arm/boot/dts/omap3.dtsi                       |   96 +++++++++++---------
 arch/arm/boot/dts/omap3xxx-clocks.dtsi             |   13 +--
 arch/arm/mach-omap2/control.c                      |    2 +-
 7 files changed, 67 insertions(+), 51 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/l4.txt b/Documentation/devicetree/bindings/arm/omap/l4.txt
index 57569cc8..6402022 100644
--- a/Documentation/devicetree/bindings/arm/omap/l4.txt
+++ b/Documentation/devicetree/bindings/arm/omap/l4.txt
@@ -5,6 +5,7 @@ These bindings describe the OMAP SoCs L4 interconnect bus.
 Required properties:
 - compatible : Should be "ti,omap2-l4" for OMAP2 family l4 core bus
 	       Should be "ti,omap2-l4-wkup" for OMAP2 family l4 wkup bus
+	       Should be "ti,omap3-l4-core" for OMAP3 family l4 core bus
 - ranges : contains the IO map range for the bus
 
 Examples:
diff --git a/Documentation/devicetree/bindings/arm/omap/prcm.txt b/Documentation/devicetree/bindings/arm/omap/prcm.txt
index cce8365..ef5a74b 100644
--- a/Documentation/devicetree/bindings/arm/omap/prcm.txt
+++ b/Documentation/devicetree/bindings/arm/omap/prcm.txt
@@ -17,7 +17,7 @@ Required properties:
 		"ti,omap2-scm"
 		"ti,omap3-prm"
 		"ti,omap3-cm"
-		"ti,omap3-scrm"
+		"ti,omap3-scm"
 		"ti,omap4-cm1"
 		"ti,omap4-prm"
 		"ti,omap4-cm2"
diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index c90724b..f164dce 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -31,7 +31,7 @@
 			status = "disabled";
 			reg = <0x5c000000 0x30000>;
 			interrupts = <67 68 69 70>;
-			syscon = <&omap3_scm_general>;
+			syscon = <&scm_conf>;
 			ti,davinci-ctrl-reg-offset = <0x10000>;
 			ti,davinci-ctrl-mod-reg-offset = <0>;
 			ti,davinci-ctrl-ram-offset = <0x20000>;
diff --git a/arch/arm/boot/dts/am35xx-clocks.dtsi b/arch/arm/boot/dts/am35xx-clocks.dtsi
index df489d3..518b8fd 100644
--- a/arch/arm/boot/dts/am35xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am35xx-clocks.dtsi
@@ -7,7 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-&scrm_clocks {
+&scm_clocks {
 	emac_ick: emac_ick {
 		#clock-cells = <0>;
 		compatible = "ti,am35xx-gate-clock";
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 01b7111..0020a7a8 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -87,6 +87,60 @@
 		ranges;
 		ti,hwmods = "l3_main";
 
+		l4_core: l4@48000000 {
+			compatible = "ti,omap3-l4-core", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x48000000 0x1000000>;
+
+			scm: scm@2000 {
+				compatible = "ti,omap3-scm", "simple-bus";
+				reg = <0x2000 0x2000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x2000 0x2000>;
+
+				omap3_pmx_core: pinmux@30 {
+					compatible = "ti,omap3-padconf",
+						     "pinctrl-single";
+					reg = <0x30 0x230>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#interrupt-cells = <1>;
+					interrupt-controller;
+					pinctrl-single,register-width = <16>;
+					pinctrl-single,function-mask = <0xff1f>;
+				};
+
+				scm_conf: scm_conf@270 {
+					compatible = "syscon";
+					reg = <0x270 0x330>;
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
+
+				omap3_pmx_wkup: pinmux@a00 {
+					compatible = "ti,omap3-padconf",
+						     "pinctrl-single";
+					reg = <0xa00 0x5c>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#interrupt-cells = <1>;
+					interrupt-controller;
+					pinctrl-single,register-width = <16>;
+					pinctrl-single,function-mask = <0xff1f>;
+				};
+			};
+		};
+
 		aes: aes@480c5000 {
 			compatible = "ti,omap3-aes";
 			ti,hwmods = "aes";
@@ -121,19 +175,6 @@
 			};
 		};
 
-		scrm: scrm@48002000 {
-			compatible = "ti,omap3-scrm";
-			reg = <0x48002000 0x2000>;
-
-			scrm_clocks: clocks {
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
-
-			scrm_clockdomains: clockdomains {
-			};
-		};
-
 		counter32k: counter@48320000 {
 			compatible = "ti,omap-counter32k";
 			reg = <0x48320000 0x20>;
@@ -159,37 +200,10 @@
 			#dma-requests = <96>;
 		};
 
-		omap3_pmx_core: pinmux@48002030 {
-			compatible = "ti,omap3-padconf", "pinctrl-single";
-			reg = <0x48002030 0x0238>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0xff1f>;
-		};
-
-		omap3_pmx_wkup: pinmux@48002a00 {
-			compatible = "ti,omap3-padconf", "pinctrl-single";
-			reg = <0x48002a00 0x5c>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0xff1f>;
-		};
-
-		omap3_scm_general: tisyscon@48002270 {
-			compatible = "syscon";
-			reg = <0x48002270 0x2f0>;
-		};
-
 		pbias_regulator: pbias_regulator {
 			compatible = "ti,pbias-omap";
 			reg = <0x2b0 0x4>;
-			syscon = <&omap3_scm_general>;
+			syscon = <&scm_conf>;
 			pbias_mmc_reg: pbias_mmc_omap2430 {
 				regulator-name = "pbias_mmc_omap2430";
 				regulator-min-microvolt = <1800000>;
diff --git a/arch/arm/boot/dts/omap3xxx-clocks.dtsi b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
index 5c37500..bbba5bd 100644
--- a/arch/arm/boot/dts/omap3xxx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
@@ -79,13 +79,14 @@
 		clock-div = <1>;
 	};
 };
-&scrm_clocks {
+
+&scm_clocks {
 	mcbsp5_mux_fck: mcbsp5_mux_fck {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&core_96m_fck>, <&mcbsp_clks>;
 		ti,bit-shift = <4>;
-		reg = <0x02d8>;
+		reg = <0x68>;
 	};
 
 	mcbsp5_fck: mcbsp5_fck {
@@ -99,7 +100,7 @@
 		compatible = "ti,composite-mux-clock";
 		clocks = <&core_96m_fck>, <&mcbsp_clks>;
 		ti,bit-shift = <2>;
-		reg = <0x0274>;
+		reg = <0x04>;
 	};
 
 	mcbsp1_fck: mcbsp1_fck {
@@ -113,7 +114,7 @@
 		compatible = "ti,composite-mux-clock";
 		clocks = <&per_96m_fck>, <&mcbsp_clks>;
 		ti,bit-shift = <6>;
-		reg = <0x0274>;
+		reg = <0x04>;
 	};
 
 	mcbsp2_fck: mcbsp2_fck {
@@ -126,7 +127,7 @@
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&per_96m_fck>, <&mcbsp_clks>;
-		reg = <0x02d8>;
+		reg = <0x68>;
 	};
 
 	mcbsp3_fck: mcbsp3_fck {
@@ -140,7 +141,7 @@
 		compatible = "ti,composite-mux-clock";
 		clocks = <&per_96m_fck>, <&mcbsp_clks>;
 		ti,bit-shift = <2>;
-		reg = <0x02d8>;
+		reg = <0x68>;
 	};
 
 	mcbsp4_fck: mcbsp4_fck {
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index d125c4e..4fc6a70 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -670,7 +670,7 @@ static const struct of_device_id omap_scrm_dt_match_table[] = {
 	{ .compatible = "ti,am3-scrm", .data = &ctrl_data },
 	{ .compatible = "ti,am4-scrm", .data = &ctrl_data },
 	{ .compatible = "ti,omap2-scm", .data = &omap2_ctrl_data },
-	{ .compatible = "ti,omap3-scrm", .data = &ctrl_data },
+	{ .compatible = "ti,omap3-scm", .data = &omap2_ctrl_data },
 	{ .compatible = "ti,dm816-scrm", .data = &ctrl_data },
 	{ }
 };
-- 
1.7.9.5

