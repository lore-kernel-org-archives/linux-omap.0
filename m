From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 29/35] ARM: dts: am4372: merge control module features under scrm node
Date: Wed, 25 Feb 2015 21:04:39 +0200
Message-ID: <1424891085-10392-30-git-send-email-t-kristo@ti.com>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49529 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753585AbbBYTFh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2015 14:05:37 -0500
In-Reply-To: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

This patch moves all the control module related features under scrm
node. scm_conf area is provided to support syscon, and also the clocks
are moved under scm_conf area.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi |   48 +++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 1943fc3..f41b82a 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -57,22 +57,6 @@
 		cache-level = <2>;
 	};
 
-	am43xx_control_module: control_module@4a002000 {
-		compatible = "syscon";
-		reg = <0x44e10000 0x7f4>;
-	};
-
-	am43xx_pinmux: pinmux@44e10800 {
-		compatible = "ti,am437-padconf", "pinctrl-single";
-		reg = <0x44e10800 0x31c>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		#interrupt-cells = <1>;
-		interrupt-controller;
-		pinctrl-single,register-width = <32>;
-		pinctrl-single,function-mask = <0xffffffff>;
-	};
-
 	ocp {
 		compatible = "ti,am4372-l3-noc", "simple-bus";
 		#address-cells = <1>;
@@ -98,12 +82,34 @@
 		};
 
 		scrm: scrm@44e10000 {
-			compatible = "ti,am4-scrm";
-			reg = <0x44e10000 0x2000>;
+			compatible = "ti,am4-scrm", "simple-bus";
+			reg = <0x44e10000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0x44e10000 0x1000>;
 
-			scrm_clocks: clocks {
+			am43xx_pinmux: pinmux@800 {
+				compatible = "ti,am437-padconf",
+					     "pinctrl-single";
+				reg = <0x800 0x31c>;
 				#address-cells = <1>;
 				#size-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				pinctrl-single,register-width = <32>;
+				pinctrl-single,function-mask = <0xffffffff>;
+			};
+
+			scm_conf: tisyscon@0 {
+				compatible = "syscon";
+				reg = <0x0 0x7fc>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				scrm_clocks: clocks {
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
 			};
 
 			scrm_clockdomains: clockdomains {
@@ -933,7 +939,7 @@
 			clocks = <&dcan0_fck>;
 			clock-names = "fck";
 			reg = <0x481cc000 0x2000>;
-			syscon-raminit = <&am43xx_control_module 0x644 0>;
+			syscon-raminit = <&scm_conf 0x644 0>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
@@ -944,7 +950,7 @@
 			clocks = <&dcan1_fck>;
 			clock-names = "fck";
 			reg = <0x481d0000 0x2000>;
-			syscon-raminit = <&am43xx_control_module 0x644 1>;
+			syscon-raminit = <&scm_conf 0x644 1>;
 			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
-- 
1.7.9.5

