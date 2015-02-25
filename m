From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 33/35] ARM: dts: omap5: add system control module node
Date: Wed, 25 Feb 2015 21:04:43 +0200
Message-ID: <1424891085-10392-34-git-send-email-t-kristo@ti.com>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37522 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753493AbbBYTFt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2015 14:05:49 -0500
In-Reply-To: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Add node for system control module, and move all the existing system
control IO space users under this new node as its children. A new node
for scm_conf area is also added.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/arm/omap/ctrl.txt          |    1 +
 arch/arm/boot/dts/omap5.dtsi                       |   76 +++++++++++++-------
 2 files changed, 51 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/ctrl.txt b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
index 88b12b5..3574d67 100644
--- a/Documentation/devicetree/bindings/arm/omap/ctrl.txt
+++ b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
@@ -20,6 +20,7 @@ Required properties:
 		"ti,omap2-scrm"
 		"ti,omap3-scrm"
 		"ti,omap4-ctrl"
+		"ti,omap5-ctrl"
 - reg:		Contains Control Module register address range
 		(base address and length)
 
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index b321fdf..3fe0c8a 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -182,38 +182,62 @@
 			};
 		};
 
+		scm: scm@4a002000 {
+			compatible = "ti,omap5-ctrl", "simple-bus";
+			reg = <0x4a002000 0x800>,
+			      <0x4a002800 0x800>,
+			      <0x4ae0c000 0x800>,
+			      <0x4ae0c800 0x800>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges = <0 0 0x4a002000 0x800>,
+				 <1 0 0x4a002800 0x800>,
+				 <2 0 0x4ae0c000 0x800>,
+				 <3 0 0x4ae0c800 0x800>;
+
+			scm_conf: tisyscon@0,0 {
+				compatible = "syscon";
+				reg = <0 0x0 0x800>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+			};
+
+			omap5_pmx_core: pinmux@1,40 {
+				compatible = "ti,omap5-padconf",
+					     "pinctrl-single";
+				reg = <1 0x40 0x01b6>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				pinctrl-single,register-width = <16>;
+				pinctrl-single,function-mask = <0x7fff>;
+			};
+
+			omap5_pmx_wkup: pinmux@3,40 {
+				compatible = "ti,omap5-padconf",
+					     "pinctrl-single";
+				reg = <3 0x40 0x0038>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				pinctrl-single,register-width = <16>;
+				pinctrl-single,function-mask = <0x7fff>;
+			};
+
+			omap5_padconf_global: omap5_padconf_global@1,5a0 {
+				compatible = "syscon";
+				reg = <1 0x5a0 0xec>;
+			};
+		};
+
 		counter32k: counter@4ae04000 {
 			compatible = "ti,omap-counter32k";
 			reg = <0x4ae04000 0x40>;
 			ti,hwmods = "counter_32k";
 		};
 
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
-
-		omap5_padconf_global: tisyscon@4a002da0 {
-			compatible = "syscon";
-			reg = <0x4A002da0 0xec>;
-		};
-
 		pbias_regulator: pbias_regulator {
 			compatible = "ti,pbias-omap";
 			reg = <0x60 0x4>;
-- 
1.7.9.5

