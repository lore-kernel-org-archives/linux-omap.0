From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 33/34] ARM: dts: dra7: add minimal l4 bus layout with control module support
Date: Tue, 31 Mar 2015 22:14:26 +0300
Message-ID: <1427829267-32077-34-git-send-email-t-kristo@ti.com>
References: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32859 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752849AbbCaTPd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Mar 2015 15:15:33 -0400
In-Reply-To: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This patch creates the l4_cfg and l4_wkup interconnects for DRA7, and
moves some of the generic peripherals under it. System control module
support is added to the device tree also, and the existing SCM related
functionality is moved under it.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/arm/omap/ctrl.txt          |    1 +
 Documentation/devicetree/bindings/arm/omap/l4.txt  |    2 +
 arch/arm/boot/dts/dra7.dtsi                        |  166 +++++++++++---------
 3 files changed, 96 insertions(+), 73 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/ctrl.txt b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
index acb68ed..3a4e590 100644
--- a/Documentation/devicetree/bindings/arm/omap/ctrl.txt
+++ b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
@@ -23,6 +23,7 @@ Required properties:
 		"ti,omap4-scm-padconf-core"
 		"ti,omap5-scm-core"
 		"ti,omap5-scm-padconf-core"
+		"ti,dra7-scm-core"
 - reg:		Contains Control Module register address range
 		(base address and length)
 
diff --git a/Documentation/devicetree/bindings/arm/omap/l4.txt b/Documentation/devicetree/bindings/arm/omap/l4.txt
index 2fe4211..b4f8a16 100644
--- a/Documentation/devicetree/bindings/arm/omap/l4.txt
+++ b/Documentation/devicetree/bindings/arm/omap/l4.txt
@@ -10,6 +10,8 @@ Required properties:
 	       Should be "ti,omap4-l4-wkup" for OMAP4 family l4 wkup bus
 	       Should be "ti,omap5-l4-cfg" for OMAP5 family l4 cfg bus
 	       Should be "ti,omap5-l4-wkup" for OMAP5 family l4 wkup bus
+	       Should be "ti,dra7-l4-cfg" for DRA7 family l4 cfg bus
+	       Should be "ti,dra7-l4-wkup" for DRA7 family l4 wkup bus
 	       Should be "ti,am3-l4-wkup" for AM33xx family l4 wkup bus
 	       Should be "ti,am4-l4-wkup" for AM43xx family l4 wkup bus
 - ranges : contains the IO map range for the bus
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 5827fed..8e50ca3 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -94,17 +94,101 @@
 		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI DIRECT_IRQ(10) IRQ_TYPE_LEVEL_HIGH>;
 
-		prm: prm@4ae06000 {
-			compatible = "ti,dra7-prm";
-			reg = <0x4ae06000 0x3000>;
-			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+		l4_cfg: l4@4a000000 {
+			compatible = "ti,dra7-l4-cfg", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x4a000000 0x22c000>;
 
-			prm_clocks: clocks {
+			scm: scm@2000 {
+				compatible = "ti,dra7-scm-core", "simple-bus";
+				reg = <0x2000 0x2000>;
 				#address-cells = <1>;
-				#size-cells = <0>;
+				#size-cells = <1>;
+				ranges = <0 0x2000 0x2000>;
+
+				scm_conf: scm_conf@0 {
+					compatible = "syscon";
+					reg = <0x0 0x1400>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+
+					pbias_regulator: pbias_regulator {
+						compatible = "ti,pbias-omap";
+						reg = <0xe00 0x4>;
+						syscon = <&scm_conf>;
+						pbias_mmc_reg: pbias_mmc_omap5 {
+							regulator-name = "pbias_mmc_omap5";
+							regulator-min-microvolt = <1800000>;
+							regulator-max-microvolt = <3000000>;
+						};
+					};
+				};
+
+				dra7_pmx_core: pinmux@1400 {
+					compatible = "ti,dra7-padconf",
+						     "pinctrl-single";
+					reg = <0x1400 0x0464>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					#interrupt-cells = <1>;
+					interrupt-controller;
+					pinctrl-single,register-width = <32>;
+					pinctrl-single,function-mask = <0x3fffffff>;
+				};
+			};
+
+			cm_core_aon: cm_core_aon@5000 {
+				compatible = "ti,dra7-cm-core-aon";
+				reg = <0x5000 0x2000>;
+
+				cm_core_aon_clocks: clocks {
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				cm_core_aon_clockdomains: clockdomains {
+				};
+			};
+
+			cm_core: cm_core@8000 {
+				compatible = "ti,dra7-cm-core";
+				reg = <0x8000 0x3000>;
+
+				cm_core_clocks: clocks {
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				cm_core_clockdomains: clockdomains {
+				};
 			};
+		};
 
-			prm_clockdomains: clockdomains {
+		l4_wkup: l4@4ae00000 {
+			compatible = "ti,dra7-l4-wkup", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x4ae00000 0x3f000>;
+
+			counter32k: counter@4000 {
+				compatible = "ti,omap-counter32k";
+				reg = <0x4000 0x40>;
+				ti,hwmods = "counter_32k";
+			};
+
+			prm: prm@6000 {
+				compatible = "ti,dra7-prm";
+				reg = <0x6000 0x3000>;
+				interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+
+				prm_clocks: clocks {
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				prm_clockdomains: clockdomains {
+				};
 			};
 		};
 
@@ -177,70 +261,6 @@
 			};
 		};
 
-		cm_core_aon: cm_core_aon@4a005000 {
-			compatible = "ti,dra7-cm-core-aon";
-			reg = <0x4a005000 0x2000>;
-
-			cm_core_aon_clocks: clocks {
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
-
-			cm_core_aon_clockdomains: clockdomains {
-			};
-		};
-
-		cm_core: cm_core@4a008000 {
-			compatible = "ti,dra7-cm-core";
-			reg = <0x4a008000 0x3000>;
-
-			cm_core_clocks: clocks {
-				#address-cells = <1>;
-				#size-cells = <0>;
-			};
-
-			cm_core_clockdomains: clockdomains {
-			};
-		};
-
-		counter32k: counter@4ae04000 {
-			compatible = "ti,omap-counter32k";
-			reg = <0x4ae04000 0x40>;
-			ti,hwmods = "counter_32k";
-		};
-
-		dra7_ctrl_core: ctrl_core@4a002000 {
-			compatible = "syscon";
-			reg = <0x4a002000 0x6d0>;
-		};
-
-		dra7_ctrl_general: tisyscon@4a002e00 {
-			compatible = "syscon";
-			reg = <0x4a002e00 0x7c>;
-		};
-
-		pbias_regulator: pbias_regulator {
-			compatible = "ti,pbias-omap";
-			reg = <0 0x4>;
-			syscon = <&dra7_ctrl_general>;
-			pbias_mmc_reg: pbias_mmc_omap5 {
-				regulator-name = "pbias_mmc_omap5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3000000>;
-			};
-		};
-
-		dra7_pmx_core: pinmux@4a003400 {
-			compatible = "ti,dra7-padconf", "pinctrl-single";
-			reg = <0x4a003400 0x0464>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			pinctrl-single,register-width = <32>;
-			pinctrl-single,function-mask = <0x3fffffff>;
-		};
-
 		sdma: dma-controller@4a056000 {
 			compatible = "ti,omap4430-sdma";
 			reg = <0x4a056000 0x1000>;
@@ -1410,7 +1430,7 @@
 			compatible = "ti,dra7-d_can";
 			ti,hwmods = "dcan1";
 			reg = <0x4ae3c000 0x2000>;
-			syscon-raminit = <&dra7_ctrl_core 0x558 0>;
+			syscon-raminit = <&scm_conf 0x558 0>;
 			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dcan1_sys_clk_mux>;
 			status = "disabled";
@@ -1420,7 +1440,7 @@
 			compatible = "ti,dra7-d_can";
 			ti,hwmods = "dcan2";
 			reg = <0x48480000 0x2000>;
-			syscon-raminit = <&dra7_ctrl_core 0x558 1>;
+			syscon-raminit = <&scm_conf 0x558 1>;
 			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&sys_clkin1>;
 			status = "disabled";
-- 
1.7.9.5

