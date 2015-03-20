From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 25/35] ARM: dts: omap24xx: add minimal l4 bus layout with control module support
Date: Fri, 20 Mar 2015 20:44:36 +0200
Message-ID: <1426877086-17131-26-git-send-email-t-kristo@ti.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56927 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbbCTSqZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2015 14:46:25 -0400
In-Reply-To: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, sakari.ailus@iki.fi
Cc: linux-arm-kernel@lists.infradead.org

This patch creates an l4 / l4-wkup interconnects for omap2420 / omap2430
SoCs, and moves some of the generic peripherals under it. System control
module nodes are moved under this new interconnect also, and the SCM
clock layout is changed to use the new SCM node as the clock provider.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 Documentation/devicetree/bindings/arm/omap/l4.txt  |   17 ++++
 .../devicetree/bindings/arm/omap/prcm.txt          |    2 +-
 arch/arm/boot/dts/omap2420.dtsi                    |   80 +++++++++------
 arch/arm/boot/dts/omap2430-clocks.dtsi             |    8 +-
 arch/arm/boot/dts/omap2430.dtsi                    |  107 +++++++++++---------
 arch/arm/boot/dts/omap24xx-clocks.dtsi             |    6 +-
 arch/arm/mach-omap2/control.c                      |    7 +-
 7 files changed, 140 insertions(+), 87 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/l4.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/l4.txt b/Documentation/devicetree/bindings/arm/omap/l4.txt
new file mode 100644
index 0000000..57569cc8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/l4.txt
@@ -0,0 +1,17 @@
+L4 interconnect bindings
+
+These bindings describe the OMAP SoCs L4 interconnect bus.
+
+Required properties:
+- compatible : Should be "ti,omap2-l4" for OMAP2 family l4 core bus
+	       Should be "ti,omap2-l4-wkup" for OMAP2 family l4 wkup bus
+- ranges : contains the IO map range for the bus
+
+Examples:
+
+l4: l4@48000000 {
+	compatible "ti,omap2-l4", "simple-bus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0 0x48000000 0x100000>;
+};
diff --git a/Documentation/devicetree/bindings/arm/omap/prcm.txt b/Documentation/devicetree/bindings/arm/omap/prcm.txt
index 68f96f8..cce8365 100644
--- a/Documentation/devicetree/bindings/arm/omap/prcm.txt
+++ b/Documentation/devicetree/bindings/arm/omap/prcm.txt
@@ -14,7 +14,7 @@ Required properties:
 		"ti,am4-prcm"
 		"ti,am4-scrm"
 		"ti,omap2-prcm"
-		"ti,omap2-scrm"
+		"ti,omap2-scm"
 		"ti,omap3-prm"
 		"ti,omap3-cm"
 		"ti,omap3-scrm"
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index e2b2e93..5b9a376 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -14,47 +14,65 @@
 	compatible = "ti,omap2420", "ti,omap2";
 
 	ocp {
-		prcm: prcm@48008000 {
-			compatible = "ti,omap2-prcm";
-			reg = <0x48008000 0x1000>;
+		l4: l4@48000000 {
+			compatible = "ti,omap2-l4", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x48000000 0x100000>;
 
-			prcm_clocks: clocks {
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
+			prcm: prcm@8000 {
+				compatible = "ti,omap2-prcm";
+				reg = <0x8000 0x1000>;
 
-			prcm_clockdomains: clockdomains {
-			};
-		};
+				prcm_clocks: clocks {
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
 
-		scrm: scrm@48000000 {
-			compatible = "ti,omap2-scrm";
-			reg = <0x48000000 0x1000>;
+				prcm_clockdomains: clockdomains {
+				};
+			};
 
-			scrm_clocks: clocks {
+			scm: scm@0 {
+				compatible = "ti,omap2-scm", "simple-bus";
+				reg = <0x0 0x1000>;
 				#address-cells = <1>;
-				#size-cells = <0>;
+				#size-cells = <1>;
+				ranges = <0 0x0 0x1000>;
+
+				omap2420_pmx: pinmux@30 {
+					compatible = "ti,omap2420-padconf",
+						     "pinctrl-single";
+					reg = <0x30 0x0113>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					pinctrl-single,register-width = <8>;
+					pinctrl-single,function-mask = <0x3f>;
+				};
+
+				scm_conf: scm_conf@270 {
+					compatible = "syscon";
+					reg = <0x270 0x100>;
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
 
-			scrm_clockdomains: clockdomains {
+			counter32k: counter@4000 {
+				compatible = "ti,omap-counter32k";
+				reg = <0x4000 0x20>;
+				ti,hwmods = "counter_32k";
 			};
 		};
 
-		counter32k: counter@48004000 {
-			compatible = "ti,omap-counter32k";
-			reg = <0x48004000 0x20>;
-			ti,hwmods = "counter_32k";
-		};
-
-		omap2420_pmx: pinmux@48000030 {
-			compatible = "ti,omap2420-padconf", "pinctrl-single";
-			reg = <0x48000030 0x0113>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-single,register-width = <8>;
-			pinctrl-single,function-mask = <0x3f>;
-		};
-
 		gpio1: gpio@48018000 {
 			compatible = "ti,omap2-gpio";
 			reg = <0x48018000 0x200>;
diff --git a/arch/arm/boot/dts/omap2430-clocks.dtsi b/arch/arm/boot/dts/omap2430-clocks.dtsi
index 805f75d..93fed68 100644
--- a/arch/arm/boot/dts/omap2430-clocks.dtsi
+++ b/arch/arm/boot/dts/omap2430-clocks.dtsi
@@ -8,12 +8,12 @@
  * published by the Free Software Foundation.
  */
 
-&scrm_clocks {
+&scm_clocks {
 	mcbsp3_mux_fck: mcbsp3_mux_fck {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_96m_ck>, <&mcbsp_clks>;
-		reg = <0x02e8>;
+		reg = <0x78>;
 	};
 
 	mcbsp3_fck: mcbsp3_fck {
@@ -27,7 +27,7 @@
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_96m_ck>, <&mcbsp_clks>;
 		ti,bit-shift = <2>;
-		reg = <0x02e8>;
+		reg = <0x78>;
 	};
 
 	mcbsp4_fck: mcbsp4_fck {
@@ -41,7 +41,7 @@
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_96m_ck>, <&mcbsp_clks>;
 		ti,bit-shift = <4>;
-		reg = <0x02e8>;
+		reg = <0x78>;
 	};
 
 	mcbsp5_fck: mcbsp5_fck {
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 0dc8de2..11a7963 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -14,60 +14,73 @@
 	compatible = "ti,omap2430", "ti,omap2";
 
 	ocp {
-		prcm: prcm@49006000 {
-			compatible = "ti,omap2-prcm";
-			reg = <0x49006000 0x1000>;
+		l4_wkup: l4_wkup@49000000 {
+			compatible = "ti,omap2-l4-wkup", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x49000000 0x31000>;
 
-			prcm_clocks: clocks {
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
+			prcm: prcm@6000 {
+				compatible = "ti,omap2-prcm";
+				reg = <0x6000 0x1000>;
 
-			prcm_clockdomains: clockdomains {
-			};
-		};
-
-		scrm: scrm@49002000 {
-			compatible = "ti,omap2-scrm";
-			reg = <0x49002000 0x1000>;
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
+			scm: scm@2000 {
+				compatible = "ti,omap2-scm", "simple-bus";
+				reg = <0x2000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x2000 0x1000>;
+
+				omap2430_pmx: pinmux@30 {
+					compatible = "ti,omap2430-padconf",
+						     "pinctrl-single";
+					reg = <0x30 0x0154>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					pinctrl-single,register-width = <8>;
+					pinctrl-single,function-mask = <0x3f>;
+				};
+
+				scm_conf: scm_conf@270 {
+					compatible = "syscon";
+					reg = <0x270 0x240>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					scm_clocks: clocks {
+						#address-cells = <1>;
+						#size-cells = <0>;
+					};
+
+					pbias_regulator: pbias_regulator {
+						compatible = "ti,pbias-omap";
+						reg = <0x230 0x4>;
+						syscon = <&scm_conf>;
+						pbias_mmc_reg: pbias_mmc_omap2430 {
+							regulator-name = "pbias_mmc_omap2430";
+							regulator-min-microvolt = <1800000>;
+							regulator-max-microvolt = <3000000>;
+						};
+					};
+				};
+
+				scm_clockdomains: clockdomains {
+				};
 			};
-		};
-
-		counter32k: counter@49020000 {
-			compatible = "ti,omap-counter32k";
-			reg = <0x49020000 0x20>;
-			ti,hwmods = "counter_32k";
-		};
-
-		omap2430_pmx: pinmux@49002030 {
-			compatible = "ti,omap2430-padconf", "pinctrl-single";
-			reg = <0x49002030 0x0154>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			pinctrl-single,register-width = <8>;
-			pinctrl-single,function-mask = <0x3f>;
-		};
-
-		omap2_scm_general: tisyscon@49002270 {
-			compatible = "syscon";
-			reg = <0x49002270 0x240>;
-		};
 
-		pbias_regulator: pbias_regulator {
-			compatible = "ti,pbias-omap";
-			reg = <0x230 0x4>;
-			syscon = <&omap2_scm_general>;
-			pbias_mmc_reg: pbias_mmc_omap2430 {
-				regulator-name = "pbias_mmc_omap2430";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3000000>;
+			counter32k: counter@20000 {
+				compatible = "ti,omap-counter32k";
+				reg = <0x20000 0x20>;
+				ti,hwmods = "counter_32k";
 			};
 		};
 
diff --git a/arch/arm/boot/dts/omap24xx-clocks.dtsi b/arch/arm/boot/dts/omap24xx-clocks.dtsi
index a1365ca..63965b8 100644
--- a/arch/arm/boot/dts/omap24xx-clocks.dtsi
+++ b/arch/arm/boot/dts/omap24xx-clocks.dtsi
@@ -7,13 +7,13 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-&scrm_clocks {
+&scm_clocks {
 	mcbsp1_mux_fck: mcbsp1_mux_fck {
 		#clock-cells = <0>;
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_96m_ck>, <&mcbsp_clks>;
 		ti,bit-shift = <2>;
-		reg = <0x0274>;
+		reg = <0x4>;
 	};
 
 	mcbsp1_fck: mcbsp1_fck {
@@ -27,7 +27,7 @@
 		compatible = "ti,composite-mux-clock";
 		clocks = <&func_96m_ck>, <&mcbsp_clks>;
 		ti,bit-shift = <6>;
-		reg = <0x0274>;
+		reg = <0x4>;
 	};
 
 	mcbsp2_fck: mcbsp2_fck {
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 65a4211..d125c4e 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -661,10 +661,15 @@ static struct control_init_data ctrl_data = {
 	.index = TI_CLKM_CTRL,
 };
 
+static const struct control_init_data omap2_ctrl_data = {
+	.index = TI_CLKM_CTRL,
+	.offset = -OMAP2_CONTROL_GENERAL,
+};
+
 static const struct of_device_id omap_scrm_dt_match_table[] = {
 	{ .compatible = "ti,am3-scrm", .data = &ctrl_data },
 	{ .compatible = "ti,am4-scrm", .data = &ctrl_data },
-	{ .compatible = "ti,omap2-scrm", .data = &ctrl_data },
+	{ .compatible = "ti,omap2-scm", .data = &omap2_ctrl_data },
 	{ .compatible = "ti,omap3-scrm", .data = &ctrl_data },
 	{ .compatible = "ti,dm816-scrm", .data = &ctrl_data },
 	{ }
-- 
1.7.9.5

