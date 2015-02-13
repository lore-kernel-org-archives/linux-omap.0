From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 26/33] ARM: dts: am4372: add syscon support to control module node
Date: Fri, 13 Feb 2015 18:12:45 +0200
Message-ID: <1423843973-6050-24-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54319 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753776AbbBMQOd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 11:14:33 -0500
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Control module will be converted to use syscon, thus add compatible
string for this. Also, remove the existing duplicate syscon entries
at the same time, and change the users of these to use the real
control module syscon.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index b62a1cd..4bf029e 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -57,11 +57,6 @@
 		cache-level = <2>;
 	};
 
-	am43xx_control_module: control_module@4a002000 {
-		compatible = "syscon";
-		reg = <0x44e10000 0x7f4>;
-	};
-
 	am43xx_pinmux: pinmux@44e10800 {
 		compatible = "ti,am437-padconf", "pinctrl-single";
 		reg = <0x44e10800 0x31c>;
@@ -98,7 +93,7 @@
 		};
 
 		scrm: scrm@44e10000 {
-			compatible = "ti,am4-scrm";
+			compatible = "ti,am4-scrm", "syscon";
 			reg = <0x44e10000 0x2000>;
 
 			scrm_clocks: clocks {
@@ -933,7 +928,7 @@
 			clocks = <&dcan0_fck>;
 			clock-names = "fck";
 			reg = <0x481cc000 0x2000>;
-			syscon-raminit = <&am43xx_control_module 0x644 0>;
+			syscon-raminit = <&scrm 0x644 0>;
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
@@ -944,7 +939,7 @@
 			clocks = <&dcan1_fck>;
 			clock-names = "fck";
 			reg = <0x481d0000 0x2000>;
-			syscon-raminit = <&am43xx_control_module 0x644 1>;
+			syscon-raminit = <&scrm 0x644 1>;
 			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
-- 
1.7.9.5

