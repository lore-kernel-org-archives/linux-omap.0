From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 33/35] ARM: dts: omap5: add system control module node
Date: Wed, 18 Mar 2015 16:44:18 +0200
Message-ID: <1426689860-17537-34-git-send-email-t-kristo@ti.com>
References: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43917 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964823AbbCROpl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Mar 2015 10:45:41 -0400
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
 arch/arm/boot/dts/omap5.dtsi                       |   82 +++++++++++++-------
 2 files changed, 58 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/ctrl.txt b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
index 8f2b481..e132026 100644
--- a/Documentation/devicetree/bindings/arm/omap/ctrl.txt
+++ b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
@@ -22,6 +22,8 @@ Required properties:
 		"ti,omap3-scrm-wkup"
 		"ti,omap4-ctrl"
 		"ti,omap4-ctrl-wkup"
+		"ti,omap5-ctrl"
+		"ti,omap5-ctrl-wkup"
 - reg:		Contains Control Module register address range
 		(base address and length)
 
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index b321fdf..ad665bb 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -182,36 +182,66 @@
 			};
 		};
 
-		counter32k: counter@4ae04000 {
-			compatible = "ti,omap-counter32k";
-			reg = <0x4ae04000 0x40>;
-			ti,hwmods = "counter_32k";
-		};
+		scm: scm@4a002000 {
+			compatible = "ti,omap5-ctrl", "simple-bus";
+			reg = <0x4a002000 0x800>,
+			      <0x4a002800 0x800>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges = <0 0 0x4a002000 0x800>,
+				 <1 0 0x4a002800 0x800>;
 
-		omap5_pmx_core: pinmux@4a002840 {
-			compatible = "ti,omap5-padconf", "pinctrl-single";
-			reg = <0x4a002840 0x01b6>;
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
+			omap5_padconf_global: omap5_padconf_global@1,5a0 {
+				compatible = "syscon";
+				reg = <1 0x5a0 0xec>;
+			};
 		};
-		omap5_pmx_wkup: pinmux@4ae0c840 {
-			compatible = "ti,omap5-padconf", "pinctrl-single";
-			reg = <0x4ae0c840 0x0038>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0x7fff>;
+
+		scm_wkup: scm_wkup@4ae0c000 {
+			compatible = "ti,omap5-ctrl-wkup", "simple-bus";
+			reg = <0x4ae0c000 0x800>,
+			      <0x4ae0c800 0x800>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges = <0 0 0x4ae0c000 0x800>,
+				 <1 0 0x4ae0c800 0x800>;
+
+			omap5_pmx_wkup: pinmux@1,40 {
+				compatible = "ti,omap5-padconf",
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
 
-		omap5_padconf_global: tisyscon@4a002da0 {
-			compatible = "syscon";
-			reg = <0x4A002da0 0xec>;
+		counter32k: counter@4ae04000 {
+			compatible = "ti,omap-counter32k";
+			reg = <0x4ae04000 0x40>;
+			ti,hwmods = "counter_32k";
 		};
 
 		pbias_regulator: pbias_regulator {
-- 
1.7.9.5

