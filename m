From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 02/12] ARM: dts: DRA7: Add DCAN nodes
Date: Tue, 9 Sep 2014 17:55:24 +0300
Message-ID: <1410274534-22826-3-git-send-email-rogerq@ti.com>
References: <1410274534-22826-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58401 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932447AbaIIO4G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2014 10:56:06 -0400
In-Reply-To: <1410274534-22826-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, mugunthanvnm@ti.com, george.cherian@ti.com, balbi@ti.com, nsekhar@ti.comnm@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-can@vger.kernel.org, Roger Quadros <rogerq@ti.com>

The SoC supports 2 DCAN nodes. Add them.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 370009e..09d5739 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -34,6 +34,8 @@
 		serial3 = &uart4;
 		serial4 = &uart5;
 		serial5 = &uart6;
+		d_can0 = &dcan1;
+		d_can1 = &dcan2;
 	};
 
 	timer {
@@ -1267,6 +1269,34 @@
 			ti,irqs-skip = <10 133 139 140>;
 			ti,irqs-safe-map = <0>;
 		};
+
+		dcan1: can@481cc000 {
+			compatible = "bosch,d_can";
+			ti,hwmods = "dcan1";
+			reg = <0x4ae3c000 0x2000>,
+			      <0x558 0x4>; /* index to RAMINIT reg within syscon */
+			ti,raminit-syscon = <&dra7_ctrl_core>;
+			ti,raminit-start-bit = <3>;
+			ti,raminit-done-bit = <1>;
+			ti,raminit-pulse;
+			interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&dcan1_sys_clk_mux>;
+			status = "disabled";
+		};
+
+		dcan2: can@481d0000 {
+			compatible = "bosch,d_can";
+			ti,hwmods = "dcan2";
+			reg = <0x48480000 0x2000>,
+			      <0x558 0x4>; /* index to RAMINIT reg within syscon */
+			ti,raminit-syscon = <&dra7_ctrl_core>;
+			ti,raminit-start-bit = <5>;
+			ti,raminit-done-bit = <2>;
+			ti,raminit-pulse;
+			interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sys_clkin1>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.8.3.2

