From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 29/34] ARM: dts: omap4: add minimal l4 bus layout with control module support
Date: Tue, 31 Mar 2015 22:14:22 +0300
Message-ID: <1427829267-32077-30-git-send-email-t-kristo@ti.com>
References: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46881 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752822AbbCaTP0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Mar 2015 15:15:26 -0400
In-Reply-To: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This patch creates the l4_cfg and l4_wkup interconnects for OMAP4, and
moves some of the generic peripherals under it. System control module
support is added to the device tree also, and the existing SCM related
functionality is moved under it.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reported-by: Tony Lindgren <tony@atomide.com>
---
 .../devicetree/bindings/arm/omap/ctrl.txt          |   76 ++++++++
 Documentation/devicetree/bindings/arm/omap/l4.txt  |    2 +
 .../devicetree/bindings/arm/omap/prcm.txt          |    6 -
 arch/arm/boot/dts/omap4.dtsi                       |  200 ++++++++++++--------
 4 files changed, 199 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/ctrl.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/ctrl.txt b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
new file mode 100644
index 0000000..2675881
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
@@ -0,0 +1,76 @@
+OMAP Control Module bindings
+
+Control Module contains miscellaneous features under it based on SoC type.
+Pincontrol is one common feature, and it has a specialized support
+described in [1]. Typically some clock nodes are also under control module.
+Syscon is used to share register level access to drivers external to
+control module driver itself.
+
+See [2] for documentation about clock/clockdomain nodes.
+
+[1] Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
+[2] Documentation/devicetree/bindings/clock/ti/*
+
+Required properties:
+- compatible:	Must be one of:
+		"ti,am3-scm"
+		"ti,am4-scm"
+		"ti,dm814-scrm"
+		"ti,dm816-scrm"
+		"ti,omap2-scm"
+		"ti,omap3-scm"
+		"ti,omap4-scm-core"
+		"ti,omap4-scm-padconf-core"
+- reg:		Contains Control Module register address range
+		(base address and length)
+
+Optional properties:
+- clocks:	clocks for this module
+- clockdomains:	clockdomains for this module
+
+Examples:
+
+scm: scm@2000 {
+	compatible = "ti,omap3-scm", "simple-bus";
+	reg = <0x2000 0x2000>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0 0x2000 0x2000>;
+
+	omap3_pmx_core: pinmux@30 {
+		compatible = "ti,omap3-padconf",
+			     "pinctrl-single";
+		reg = <0x30 0x230>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#interrupt-cells = <1>;
+		interrupt-controller;
+		pinctrl-single,register-width = <16>;
+		pinctrl-single,function-mask = <0xff1f>;
+	};
+
+	scm_conf: scm_conf@270 {
+		compatible = "syscon";
+		reg = <0x270 0x330>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		scm_clocks: clocks {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	scm_clockdomains: clockdomains {
+	};
+}
+
+&scm_clocks {
+	mcbsp5_mux_fck: mcbsp5_mux_fck {
+		#clock-cells = <0>;
+		compatible = "ti,composite-mux-clock";
+		clocks = <&core_96m_fck>, <&mcbsp_clks>;
+		ti,bit-shift = <4>;
+		reg = <0x02d8>;
+	};
+};
diff --git a/Documentation/devicetree/bindings/arm/omap/l4.txt b/Documentation/devicetree/bindings/arm/omap/l4.txt
index 941b914..de18cfa 100644
--- a/Documentation/devicetree/bindings/arm/omap/l4.txt
+++ b/Documentation/devicetree/bindings/arm/omap/l4.txt
@@ -6,6 +6,8 @@ Required properties:
 - compatible : Should be "ti,omap2-l4" for OMAP2 family l4 core bus
 	       Should be "ti,omap2-l4-wkup" for OMAP2 family l4 wkup bus
 	       Should be "ti,omap3-l4-core" for OMAP3 family l4 core bus
+	       Should be "ti,omap4-l4-cfg" for OMAP4 family l4 cfg bus
+	       Should be "ti,omap4-l4-wkup" for OMAP4 family l4 wkup bus
 	       Should be "ti,am3-l4-wkup" for AM33xx family l4 wkup bus
 	       Should be "ti,am4-l4-wkup" for AM43xx family l4 wkup bus
 - ranges : contains the IO map range for the bus
diff --git a/Documentation/devicetree/bindings/arm/omap/prcm.txt b/Documentation/devicetree/bindings/arm/omap/prcm.txt
index 8af4f32..3eb6d7a 100644
--- a/Documentation/devicetree/bindings/arm/omap/prcm.txt
+++ b/Documentation/devicetree/bindings/arm/omap/prcm.txt
@@ -10,14 +10,10 @@ documentation about the individual clock/clockdomain nodes.
 Required properties:
 - compatible:	Must be one of:
 		"ti,am3-prcm"
-		"ti,am3-scm"
 		"ti,am4-prcm"
-		"ti,am4-scm"
 		"ti,omap2-prcm"
-		"ti,omap2-scm"
 		"ti,omap3-prm"
 		"ti,omap3-cm"
-		"ti,omap3-scm"
 		"ti,omap4-cm1"
 		"ti,omap4-prm"
 		"ti,omap4-cm2"
@@ -30,9 +26,7 @@ Required properties:
 		"ti,dra7-cm-core-aon"
 		"ti,dra7-cm-core"
 		"ti,dm814-prcm"
-		"ti,dm814-scrm"
 		"ti,dm816-prcm"
-		"ti,dm816-scrm"
 - reg:		Contains PRCM module register address range
 		(base address and length)
 - clocks:	clocks for this module
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 074147c..546681a 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -114,99 +114,141 @@
 		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 
-		cm1: cm1@4a004000 {
-			compatible = "ti,omap4-cm1";
-			reg = <0x4a004000 0x2000>;
-
-			cm1_clocks: clocks {
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
+		l4_cfg: l4@4a000000 {
+			compatible = "ti,omap4-l4-cfg", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x4a000000 0x1000000>;
 
-			cm1_clockdomains: clockdomains {
-			};
-		};
+			cm1: cm1@4000 {
+				compatible = "ti,omap4-cm1";
+				reg = <0x4000 0x2000>;
 
-		prm: prm@4a306000 {
-			compatible = "ti,omap4-prm";
-			reg = <0x4a306000 0x3000>;
-			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+				cm1_clocks: clocks {
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
 
-			prm_clocks: clocks {
-				#address-cells = <1>;
-				#size-cells = <0>;
+				cm1_clockdomains: clockdomains {
+				};
 			};
 
-			prm_clockdomains: clockdomains {
-			};
-		};
+			cm2: cm2@8000 {
+				compatible = "ti,omap4-cm2";
+				reg = <0x8000 0x3000>;
 
-		cm2: cm2@4a008000 {
-			compatible = "ti,omap4-cm2";
-			reg = <0x4a008000 0x3000>;
+				cm2_clocks: clocks {
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
 
-			cm2_clocks: clocks {
-				#address-cells = <1>;
-				#size-cells = <0>;
+				cm2_clockdomains: clockdomains {
+				};
 			};
 
-			cm2_clockdomains: clockdomains {
+			omap4_scm_core: scm@2000 {
+				compatible = "ti,omap4-scm-core", "simple-bus";
+				reg = <0x2000 0x1000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x2000 0x1000>;
+
+				scm_conf: scm_conf@0 {
+					compatible = "syscon";
+					reg = <0x0 0x800>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+				};
 			};
-		};
-
-		scrm: scrm@4a30a000 {
-			compatible = "ti,omap4-scrm";
-			reg = <0x4a30a000 0x2000>;
 
-			scrm_clocks: clocks {
+			omap4_padconf_core: scm@100000 {
+				compatible = "ti,omap4-scm-padconf-core",
+					     "simple-bus";
 				#address-cells = <1>;
-				#size-cells = <0>;
+				#size-cells = <1>;
+				ranges = <0 0x100000 0x1000>;
+
+				omap4_pmx_core: pinmux@40 {
+					compatible = "ti,omap4-padconf",
+						     "pinctrl-single";
+					reg = <0x40 0x0196>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#interrupt-cells = <1>;
+					interrupt-controller;
+					pinctrl-single,register-width = <16>;
+					pinctrl-single,function-mask = <0x7fff>;
+				};
+
+				omap4_padconf_global: omap4_padconf_global@5a0 {
+					compatible = "syscon";
+					reg = <0x5a0 0x170>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					pbias_regulator: pbias_regulator {
+						compatible = "ti,pbias-omap";
+						reg = <0x60 0x4>;
+						syscon = <&omap4_padconf_global>;
+						pbias_mmc_reg: pbias_mmc_omap4 {
+							regulator-name = "pbias_mmc_omap4";
+							regulator-min-microvolt = <1800000>;
+							regulator-max-microvolt = <3000000>;
+						};
+					};
+				};
 			};
 
-			scrm_clockdomains: clockdomains {
-			};
-		};
-
-		counter32k: counter@4a304000 {
-			compatible = "ti,omap-counter32k";
-			reg = <0x4a304000 0x20>;
-			ti,hwmods = "counter_32k";
-		};
-
-		omap4_pmx_core: pinmux@4a100040 {
-			compatible = "ti,omap4-padconf", "pinctrl-single";
-			reg = <0x4a100040 0x0196>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0x7fff>;
-		};
-		omap4_pmx_wkup: pinmux@4a31e040 {
-			compatible = "ti,omap4-padconf", "pinctrl-single";
-			reg = <0x4a31e040 0x0038>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0x7fff>;
-		};
-
-		omap4_padconf_global: tisyscon@4a1005a0 {
-			compatible = "syscon";
-			reg = <0x4a1005a0 0x170>;
-		};
-
-		pbias_regulator: pbias_regulator {
-			compatible = "ti,pbias-omap";
-			reg = <0x60 0x4>;
-			syscon = <&omap4_padconf_global>;
-			pbias_mmc_reg: pbias_mmc_omap4 {
-				regulator-name = "pbias_mmc_omap4";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3000000>;
+			l4_wkup: l4@300000 {
+				compatible = "ti,omap4-l4-wkup", "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x300000 0x40000>;
+
+				counter32k: counter@4000 {
+					compatible = "ti,omap-counter32k";
+					reg = <0x4000 0x20>;
+					ti,hwmods = "counter_32k";
+				};
+
+				prm: prm@6000 {
+					compatible = "ti,omap4-prm";
+					reg = <0x6000 0x3000>;
+					interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+
+					prm_clocks: clocks {
+						#address-cells = <1>;
+						#size-cells = <0>;
+					};
+
+					prm_clockdomains: clockdomains {
+					};
+				};
+
+				scrm: scrm@a000 {
+					compatible = "ti,omap4-scrm";
+					reg = <0xa000 0x2000>;
+
+					scrm_clocks: clocks {
+						#address-cells = <1>;
+						#size-cells = <0>;
+					};
+
+					scrm_clockdomains: clockdomains {
+					};
+				};
+
+				omap4_pmx_wkup: pinmux@1e040 {
+					compatible = "ti,omap4-padconf",
+						     "pinctrl-single";
+					reg = <0x1e040 0x0038>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#interrupt-cells = <1>;
+					interrupt-controller;
+					pinctrl-single,register-width = <16>;
+					pinctrl-single,function-mask = <0x7fff>;
+				};
 			};
 		};
 
-- 
1.7.9.5

