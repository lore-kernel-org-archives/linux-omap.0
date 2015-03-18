From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 34/35] ARM: dts: dra7: add system control module node
Date: Wed, 18 Mar 2015 16:44:19 +0200
Message-ID: <1426689860-17537-35-git-send-email-t-kristo@ti.com>
References: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43919 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964797AbbCROpm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2015 10:45:42 -0400
In-Reply-To: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Add node for system control module, and move all the existing system
control IO space users under this new node as its children. A new node
for scm_conf area is also added.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/arm/omap/ctrl.txt          |    2 +
 arch/arm/boot/dts/dra7.dtsi                        |   73 +++++++++++++-------
 2 files changed, 50 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/ctrl.txt b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
index e132026..16915c2 100644
--- a/Documentation/devicetree/bindings/arm/omap/ctrl.txt
+++ b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
@@ -24,6 +24,8 @@ Required properties:
 		"ti,omap4-ctrl-wkup"
 		"ti,omap5-ctrl"
 		"ti,omap5-ctrl-wkup"
+		"ti,dra7-ctrl"
+		"ti,dra7-ctrl-wkup"
 - reg:		Contains Control Module register address range
 		(base address and length)
 
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 5827fed..f294ad5 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -203,26 +203,60 @@
 			};
 		};
 
-		counter32k: counter@4ae04000 {
-			compatible = "ti,omap-counter32k";
-			reg = <0x4ae04000 0x40>;
-			ti,hwmods = "counter_32k";
+		scm: scm@4a002000 {
+			compatible = "ti,dra7-ctrl", "simple-bus";
+			reg = <0x4a002000 0x1400>,
+			      <0x4a003400 0x600>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges = <0 0 0x4a002000 0x1400>,
+				 <1 0 0x4a003400 0x600>;
+
+			scm_conf: scm_conf@0,0 {
+				compatible = "syscon";
+				reg = <0 0x0 0x1400>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+			};
+
+			dra7_pmx_core: pinmux@1,0 {
+				compatible = "ti,dra7-padconf",
+					     "pinctrl-single";
+				reg = <1 0x0 0x0464>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				pinctrl-single,register-width = <32>;
+				pinctrl-single,function-mask = <0x3fffffff>;
+			};
 		};
 
-		dra7_ctrl_core: ctrl_core@4a002000 {
-			compatible = "syscon";
-			reg = <0x4a002000 0x6d0>;
+		scm_wkup: scm_wkup@4ae0c000 {
+			compatible = "ti,dra7-ctrl-wkup", "simple-bus";
+			reg = <0x4ae0c000 0x600>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x4ae0c000 0x600>;
+
+			scm_wkup_conf: scm_wkup_conf@0 {
+				compatible = "syscon";
+				reg = <0x0 0x600>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+			};
 		};
 
-		dra7_ctrl_general: tisyscon@4a002e00 {
-			compatible = "syscon";
-			reg = <0x4a002e00 0x7c>;
+		counter32k: counter@4ae04000 {
+			compatible = "ti,omap-counter32k";
+			reg = <0x4ae04000 0x40>;
+			ti,hwmods = "counter_32k";
 		};
 
 		pbias_regulator: pbias_regulator {
 			compatible = "ti,pbias-omap";
-			reg = <0 0x4>;
-			syscon = <&dra7_ctrl_general>;
+			reg = <0xe00 0x4>;
+			syscon = <&scm_conf>;
 			pbias_mmc_reg: pbias_mmc_omap5 {
 				regulator-name = "pbias_mmc_omap5";
 				regulator-min-microvolt = <1800000>;
@@ -230,17 +264,6 @@
 			};
 		};
 
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
@@ -1410,7 +1433,7 @@
 			compatible = "ti,dra7-d_can";
 			ti,hwmods = "dcan1";
 			reg = <0x4ae3c000 0x2000>;
-			syscon-raminit = <&dra7_ctrl_core 0x558 0>;
+			syscon-raminit = <&scm_conf 0x558 0>;
 			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dcan1_sys_clk_mux>;
 			status = "disabled";
@@ -1420,7 +1443,7 @@
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

