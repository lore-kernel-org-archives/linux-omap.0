From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 30/35] ARM: dts: omap4: add system control module node
Date: Wed, 18 Mar 2015 16:44:15 +0200
Message-ID: <1426689860-17537-31-git-send-email-t-kristo@ti.com>
References: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52485 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964822AbbCROpk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2015 10:45:40 -0400
In-Reply-To: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Add node for system control module, and move all the existing system
control IO space users under this new node as its children. A new node
for scm_conf area is also added. DT documentation is also updated by
this patch to reflect the existence of system control module nodes,
separately of PRCM module.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/arm/omap/ctrl.txt          |   77 +++++++++++++++++++
 .../devicetree/bindings/arm/omap/prcm.txt          |    7 --
 arch/arm/boot/dts/omap4.dtsi                       |   81 +++++++++++++-------
 3 files changed, 132 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/ctrl.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/ctrl.txt b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
new file mode 100644
index 0000000..8f2b481
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
@@ -0,0 +1,77 @@
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
+		"ti,am3-scrm"
+		"ti,am4-scrm"
+		"ti,dm814-scrm"
+		"ti,dm816-scrm"
+		"ti,omap2-scrm"
+		"ti,omap3-scrm"
+		"ti,omap3-scrm-wkup"
+		"ti,omap4-ctrl"
+		"ti,omap4-ctrl-wkup"
+- reg:		Contains Control Module register address range
+		(base address and length)
+
+Optional properties:
+- clocks:	clocks for this module
+- clockdomains:	clockdomains for this module
+
+Examples:
+
+scrm: scrm@48002000 {
+	compatible = "ti,omap3-scrm", "simple-bus";
+	reg = <0x48002000 0x2000>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges = <0 0x48002000 0x2000>;
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
+		scrm_clocks: clocks {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+	};
+
+	scrm_clockdomains: clockdomains {
+	};
+}
+
+&scrm_clocks {
+	mcbsp5_mux_fck: mcbsp5_mux_fck {
+		#clock-cells = <0>;
+		compatible = "ti,composite-mux-clock";
+		clocks = <&core_96m_fck>, <&mcbsp_clks>;
+		ti,bit-shift = <4>;
+		reg = <0x02d8>;
+	};
+};
diff --git a/Documentation/devicetree/bindings/arm/omap/prcm.txt b/Documentation/devicetree/bindings/arm/omap/prcm.txt
index 98ab498..3eb6d7a 100644
--- a/Documentation/devicetree/bindings/arm/omap/prcm.txt
+++ b/Documentation/devicetree/bindings/arm/omap/prcm.txt
@@ -10,15 +10,10 @@ documentation about the individual clock/clockdomain nodes.
 Required properties:
 - compatible:	Must be one of:
 		"ti,am3-prcm"
-		"ti,am3-scrm"
 		"ti,am4-prcm"
-		"ti,am4-scrm"
 		"ti,omap2-prcm"
-		"ti,omap2-scrm"
 		"ti,omap3-prm"
 		"ti,omap3-cm"
-		"ti,omap3-scrm"
-		"ti,omap3-scrm-wkup"
 		"ti,omap4-cm1"
 		"ti,omap4-prm"
 		"ti,omap4-cm2"
@@ -31,9 +26,7 @@ Required properties:
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
index 074147c..dec7f57 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -167,36 +167,65 @@
 			};
 		};
 
-		counter32k: counter@4a304000 {
-			compatible = "ti,omap-counter32k";
-			reg = <0x4a304000 0x20>;
-			ti,hwmods = "counter_32k";
-		};
+		scm: scm@4a002000 {
+			compatible = "ti,omap4-ctrl", "simple-bus";
+			reg = <0x4a002000 0x1000>,
+			      <0x4a100000 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges = <0 0 0x4a002000 0x1000>,
+				 <1 0 0x4a100000 0x1000>;
 
-		omap4_pmx_core: pinmux@4a100040 {
-			compatible = "ti,omap4-padconf", "pinctrl-single";
-			reg = <0x4a100040 0x0196>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0x7fff>;
+			scm_conf: scm_conf@0,0 {
+				compatible = "syscon";
+				reg = <0 0x0 0x800>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+			};
+
+			omap4_pmx_core: pinmux@1,40 {
+				compatible = "ti,omap4-padconf",
+					     "pinctrl-single";
+				reg = <1 0x40 0x0196>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				pinctrl-single,register-width = <16>;
+				pinctrl-single,function-mask = <0x7fff>;
+			};
+
+			omap4_padconf_global: omap4_padconf_global@1,5a0 {
+				compatible = "syscon";
+				reg = <1 0x5a0 0x170>;
+			};
 		};
-		omap4_pmx_wkup: pinmux@4a31e040 {
-			compatible = "ti,omap4-padconf", "pinctrl-single";
-			reg = <0x4a31e040 0x0038>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0x7fff>;
+
+		scm_wkup: scm_wkup@4a30a000 {
+			compatible = "ti,omap4-ctrl-wkup", "simple-bus";
+			reg = <0x4a30a000 0x1000>, <0x4a31e000 0x1000>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges = <0 0 0x4a30a000 0x1000>,
+				 <1 0 0x4a31e000 0x1000>;
+
+			omap4_pmx_wkup: pinmux@1,40 {
+				compatible = "ti,omap4-padconf",
+					     "pinctrl-single";
+				reg = <1 0x40 0x0038>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				pinctrl-single,register-width = <16>;
+				pinctrl-single,function-mask = <0x7fff>;
+			};
 		};
 
-		omap4_padconf_global: tisyscon@4a1005a0 {
-			compatible = "syscon";
-			reg = <0x4a1005a0 0x170>;
+		counter32k: counter@4a304000 {
+			compatible = "ti,omap-counter32k";
+			reg = <0x4a304000 0x20>;
+			ti,hwmods = "counter_32k";
 		};
 
 		pbias_regulator: pbias_regulator {
-- 
1.7.9.5

