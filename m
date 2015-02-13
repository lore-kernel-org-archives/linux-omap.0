From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 32/33] ARM: dts: dra7: fix control module core instance nodes
Date: Fri, 13 Feb 2015 18:12:51 +0200
Message-ID: <1423843973-6050-30-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46939 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753835AbbBMQOo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 11:14:44 -0500
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

The old names for these nodes were misleading, and also the address spaces
for these didn't match the hardware. Fixed by renaming the nodes and
fixing the memory maps to reflect actual hardware implementation. Existing
users for the syscons updated accordingly. Support for the new dra7
control module compatible strings is going to be added in a separate patch.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/arm/omap/ctrl.txt          |    2 ++
 arch/arm/boot/dts/dra7.dtsi                        |   20 ++++++++++----------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/omap/ctrl.txt b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
index 99f81ea..18274a7 100644
--- a/Documentation/devicetree/bindings/arm/omap/ctrl.txt
+++ b/Documentation/devicetree/bindings/arm/omap/ctrl.txt
@@ -19,6 +19,8 @@ Required properties:
 		"ti,omap4-ctrl-pad-core"
 		"ti,omap5-ctrl-gen-core"
 		"ti,omap5-ctrl-pad-core"
+		"ti,dra7-ctrl-gen-core"
+		"ti,dra7-ctrl-pad-core"
 - reg:		Contains Control Module register address range
 		(base address and length)
 
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 22771bc..6798fec 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -209,20 +209,20 @@
 			ti,hwmods = "counter_32k";
 		};
 
-		dra7_ctrl_core: ctrl_core@4a002000 {
-			compatible = "syscon";
-			reg = <0x4a002000 0x6d0>;
+		ctrl_gen_core: ctrl_gen_core@4a002000 {
+			compatible = "ti,dra7-ctrl-gen-core", "syscon";
+			reg = <0x4a002000 0x1400>;
 		};
 
-		dra7_ctrl_general: tisyscon@4a002e00 {
-			compatible = "syscon";
-			reg = <0x4a002e00 0x7c>;
+		ctrl_pad_core: ctrl_pad_core@4a003400 {
+			compatible = "ti,dra7-ctrl-pad-core", "syscon";
+			reg = <0x4a003400 0xc00>;
 		};
 
 		pbias_regulator: pbias_regulator {
 			compatible = "ti,pbias-omap";
-			reg = <0 0x4>;
-			syscon = <&dra7_ctrl_general>;
+			reg = <0xe00 0x4>;
+			syscon = <&ctrl_gen_core>;
 			pbias_mmc_reg: pbias_mmc_omap5 {
 				regulator-name = "pbias_mmc_omap5";
 				regulator-min-microvolt = <1800000>;
@@ -1406,7 +1406,7 @@
 			compatible = "ti,dra7-d_can";
 			ti,hwmods = "dcan1";
 			reg = <0x4ae3c000 0x2000>;
-			syscon-raminit = <&dra7_ctrl_core 0x558 0>;
+			syscon-raminit = <&ctrl_gen_core 0x558 0>;
 			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&dcan1_sys_clk_mux>;
 			status = "disabled";
@@ -1416,7 +1416,7 @@
 			compatible = "ti,dra7-d_can";
 			ti,hwmods = "dcan2";
 			reg = <0x48480000 0x2000>;
-			syscon-raminit = <&dra7_ctrl_core 0x558 1>;
+			syscon-raminit = <&ctrl_gen_core 0x558 1>;
 			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&sys_clkin1>;
 			status = "disabled";
-- 
1.7.9.5

