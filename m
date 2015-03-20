From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 33/35] ARM: dts: omap5: add minimal l4 bus layout with control module support
Date: Fri, 20 Mar 2015 20:44:44 +0200
Message-ID: <1426877086-17131-34-git-send-email-t-kristo@ti.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56936 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbbCTSqm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2015 14:46:42 -0400
In-Reply-To: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, sakari.ailus@iki.fi
Cc: linux-arm-kernel@lists.infradead.org

This patch creates the l4_cfg and l4_wkup interconnects for OMAP5, and
moves some of the generic peripherals under it. System control module
support is added to the device tree also, and the existing SCM related
functionality is moved under it.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/arm/omap/ctrl.txt          |    2 +
 Documentation/devicetree/bindings/arm/omap/l4.txt  |    2 +
 arch/arm/boot/dts/omap5.dtsi                       |  182 ++++++++++++--------
 3 files changed, 116 insertions(+), 70 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/ctrl.txt b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
index 2675881..acb68ed 100644
--- a/Documentation/devicetree/bindings/arm/omap/ctrl.txt
+++ b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
@@ -21,6 +21,8 @@ Required properties:
 		"ti,omap3-scm"
 		"ti,omap4-scm-core"
 		"ti,omap4-scm-padconf-core"
+		"ti,omap5-scm-core"
+		"ti,omap5-scm-padconf-core"
 - reg:		Contains Control Module register address range
 		(base address and length)
 
diff --git a/Documentation/devicetree/bindings/arm/omap/l4.txt b/Documentation/devicetree/bindings/arm/omap/l4.txt
index de18cfa..2fe4211 100644
--- a/Documentation/devicetree/bindings/arm/omap/l4.txt
+++ b/Documentation/devicetree/bindings/arm/omap/l4.txt
@@ -8,6 +8,8 @@ Required properties:
 	       Should be "ti,omap3-l4-core" for OMAP3 family l4 core bus
 	       Should be "ti,omap4-l4-cfg" for OMAP4 family l4 cfg bus
 	       Should be "ti,omap4-l4-wkup" for OMAP4 family l4 wkup bus
+	       Should be "ti,omap5-l4-cfg" for OMAP5 family l4 cfg bus
+	       Should be "ti,omap5-l4-wkup" for OMAP5 family l4 wkup bus
 	       Should be "ti,am3-l4-wkup" for AM33xx family l4 wkup bus
 	       Should be "ti,am4-l4-wkup" for AM43xx family l4 wkup bus
 - ranges : contains the IO map range for the bus
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index b321fdf..326a429 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -129,99 +129,141 @@
 		interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 
-		prm: prm@4ae06000 {
-			compatible = "ti,omap5-prm";
-			reg = <0x4ae06000 0x3000>;
-			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		l4_cfg: l4@4a000000 {
+			compatible = "ti,omap5-l4-cfg", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x4a000000 0x22a000>;
 
-			prm_clocks: clocks {
+			scm_core: scm@2000 {
+				compatible = "ti,omap5-scm-core", "simple-bus";
+				reg = <0x2000 0x1000>;
 				#address-cells = <1>;
-				#size-cells = <0>;
+				#size-cells = <1>;
+				ranges = <0 0x2000 0x800>;
+
+				scm_conf: scm_conf@0 {
+					compatible = "syscon";
+					reg = <0x0 0x800>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+				};
 			};
 
-			prm_clockdomains: clockdomains {
+			scm_padconf_core: scm@2800 {
+				compatible = "ti,omap5-scm-padconf-core",
+					     "simple-bus";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x2800 0x800>;
+
+				omap5_pmx_core: pinmux@40 {
+					compatible = "ti,omap5-padconf",
+						     "pinctrl-single";
+					reg = <0x40 0x01b6>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#interrupt-cells = <1>;
+					interrupt-controller;
+					pinctrl-single,register-width = <16>;
+					pinctrl-single,function-mask = <0x7fff>;
+				};
+
+				omap5_padconf_global: omap5_padconf_global@5a0 {
+					compatible = "syscon";
+					reg = <0x5a0 0xec>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					pbias_regulator: pbias_regulator {
+						compatible = "ti,pbias-omap";
+						reg = <0x60 0x4>;
+						syscon = <&omap5_padconf_global>;
+						pbias_mmc_reg: pbias_mmc_omap5 {
+							regulator-name = "pbias_mmc_omap5";
+							regulator-min-microvolt = <1800000>;
+							regulator-max-microvolt = <3000000>;
+						};
+					};
+				};
 			};
-		};
 
-		cm_core_aon: cm_core_aon@4a004000 {
-			compatible = "ti,omap5-cm-core-aon";
-			reg = <0x4a004000 0x2000>;
+			cm_core_aon: cm_core_aon@4000 {
+				compatible = "ti,omap5-cm-core-aon";
+				reg = <0x4000 0x2000>;
 
-			cm_core_aon_clocks: clocks {
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
+				cm_core_aon_clocks: clocks {
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
 
-			cm_core_aon_clockdomains: clockdomains {
+				cm_core_aon_clockdomains: clockdomains {
+				};
 			};
-		};
 
-		scrm: scrm@4ae0a000 {
-			compatible = "ti,omap5-scrm";
-			reg = <0x4ae0a000 0x2000>;
+			cm_core: cm_core@8000 {
+				compatible = "ti,omap5-cm-core";
+				reg = <0x8000 0x3000>;
 
-			scrm_clocks: clocks {
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
+				cm_core_clocks: clocks {
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
 
-			scrm_clockdomains: clockdomains {
+				cm_core_clockdomains: clockdomains {
+				};
 			};
 		};
 
-		cm_core: cm_core@4a008000 {
-			compatible = "ti,omap5-cm-core";
-			reg = <0x4a008000 0x3000>;
+		l4_wkup: l4@4ae00000 {
+			compatible = "ti,omap5-l4-wkup", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x4ae00000 0x2b000>;
 
-			cm_core_clocks: clocks {
-				#address-cells = <1>;
-				#size-cells = <0>;
+			counter32k: counter@4000 {
+				compatible = "ti,omap-counter32k";
+				reg = <0x4000 0x40>;
+				ti,hwmods = "counter_32k";
 			};
 
-			cm_core_clockdomains: clockdomains {
+			prm: prm@6000 {
+				compatible = "ti,omap5-prm";
+				reg = <0x6000 0x3000>;
+				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+
+				prm_clocks: clocks {
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				prm_clockdomains: clockdomains {
+				};
 			};
-		};
 
-		counter32k: counter@4ae04000 {
-			compatible = "ti,omap-counter32k";
-			reg = <0x4ae04000 0x40>;
-			ti,hwmods = "counter_32k";
-		};
+			scrm: scrm@a000 {
+				compatible = "ti,omap5-scrm";
+				reg = <0xa000 0x2000>;
 
-		omap5_pmx_core: pinmux@4a002840 {
-			compatible = "ti,omap5-padconf", "pinctrl-single";
-			reg = <0x4a002840 0x01b6>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0x7fff>;
-		};
-		omap5_pmx_wkup: pinmux@4ae0c840 {
-			compatible = "ti,omap5-padconf", "pinctrl-single";
-			reg = <0x4ae0c840 0x0038>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0x7fff>;
-		};
+				scrm_clocks: clocks {
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
 
-		omap5_padconf_global: tisyscon@4a002da0 {
-			compatible = "syscon";
-			reg = <0x4A002da0 0xec>;
-		};
+				scrm_clockdomains: clockdomains {
+				};
+			};
 
-		pbias_regulator: pbias_regulator {
-			compatible = "ti,pbias-omap";
-			reg = <0x60 0x4>;
-			syscon = <&omap5_padconf_global>;
-			pbias_mmc_reg: pbias_mmc_omap5 {
-				regulator-name = "pbias_mmc_omap5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3000000>;
+			omap5_pmx_wkup: pinmux@c840 {
+				compatible = "ti,omap5-padconf",
+					     "pinctrl-single";
+				reg = <0xc840 0x0038>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				pinctrl-single,register-width = <16>;
+				pinctrl-single,function-mask = <0x7fff>;
 			};
 		};
 
-- 
1.7.9.5

