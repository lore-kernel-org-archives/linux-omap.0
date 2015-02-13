From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 30/33] ARM: dts: omap4: add nodes for control module core instances
Date: Fri, 13 Feb 2015 18:12:49 +0200
Message-ID: <1423843973-6050-28-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43406 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753831AbbBMQOo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Feb 2015 11:14:44 -0500
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Add support for control module core generic and padconf memory spaces.
These nodes add syscon support for shared access, and the duplicate
omap4_padconf_global node is removed with the same patch. Kernel support
for the new compatible strings is going to be added in a separate patch.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/arm/omap/ctrl.txt          |   55 ++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |   19 ++++---
 2 files changed, 67 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/ctrl.txt

diff --git a/Documentation/devicetree/bindings/arm/omap/ctrl.txt b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
new file mode 100644
index 0000000..02fb500
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
@@ -0,0 +1,55 @@
+OMAP Control Module bindings
+
+Control Module contains miscellaneous features under it based on SoC type.
+Pincontrol is one common feature, and typically some clock nodes are also
+under control module. Syscon is used to share register level access to
+drivers external to control module driver itself.
+
+See [1] for documentation about clock/clockdomain nodes.
+
+[1] Documentation/devicetree/bindings/clock/ti/*
+
+Required properties:
+- compatible:	Must be one of:
+		"ti,am3-scrm"
+		"ti,am4-scrm"
+		"ti,omap2-scrm"
+		"ti,omap3-scrm"
+		"ti,omap4-ctrl-gen-core"
+		"ti,omap4-ctrl-pad-core"
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
+	compatible = "ti,omap3-scrm", "syscon";
+	reg = <0x48002000 0x1000>;
+
+	scrm_clocks: clocks {
+		#address-cells = <1>;
+		#size-cells = <0>;
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
+
+ctrl_gen_core: ctrl_gen_core@4a002000 {
+	compatible = "ti,omap4-ctrl-gen-core", "syscon";
+	reg = <0x4a002000 0x1000>;
+};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 074147c..19087e5 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -167,6 +167,16 @@
 			};
 		};
 
+		ctrl_gen_core: ctrl_gen_core@0x4a002000 {
+			compatible = "ti,omap4-ctrl-gen-core", "syscon";
+			reg = <0x4a002000 0x1000>;
+		};
+
+		ctrl_pad_core: ctrl_pad_core@0x4a100000 {
+			compatible = "ti,omap4-ctrl-pad-core", "syscon";
+			reg = <0x4a100000 0x1000>;
+		};
+
 		counter32k: counter@4a304000 {
 			compatible = "ti,omap-counter32k";
 			reg = <0x4a304000 0x20>;
@@ -194,15 +204,10 @@
 			pinctrl-single,function-mask = <0x7fff>;
 		};
 
-		omap4_padconf_global: tisyscon@4a1005a0 {
-			compatible = "syscon";
-			reg = <0x4a1005a0 0x170>;
-		};
-
 		pbias_regulator: pbias_regulator {
 			compatible = "ti,pbias-omap";
-			reg = <0x60 0x4>;
-			syscon = <&omap4_padconf_global>;
+			reg = <0x600 0x4>;
+			syscon = <&ctrl_pad_core>;
 			pbias_mmc_reg: pbias_mmc_omap4 {
 				regulator-name = "pbias_mmc_omap4";
 				regulator-min-microvolt = <1800000>;
-- 
1.7.9.5

