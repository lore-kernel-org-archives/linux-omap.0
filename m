From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH] ARM: dts: AM4372: Add node for dma-controller
Date: Tue, 3 Sep 2013 16:29:26 +0530
Message-ID: <1378205966-3683-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43287 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932539Ab3ICK7z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 3 Sep 2013 06:59:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, afzal@ti.com, rnayak@ti.com, r.sricharan@ti.com, devicetree@vger.kernel.org, joelf@ti.com, lokeshvutla@ti.com

Adds AM4372 EDMA support to the am4372.dtsi as documented in
Documentation/devicetree/bindings/dma/ti-edma.txt

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index ddc1df7..bfc556c 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -41,6 +41,20 @@
 		#size-cells = <1>;
 		ranges;
 
+		edma: dma-controller@49000000 {
+			compatible = "ti,edma3";
+			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
+			reg =	<0x49000000 0x10000>,
+				<0x44e10f90 0x10>;
+			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			dma-channels = <64>;
+			ti,edma-regions = <4>;
+			ti,edma-slots = <256>;
+		};
+
 		uart0: serial@44e09000 {
 			compatible = "ti,am4372-uart","ti,omap2-uart";
 			reg = <0x44e09000 0x2000>;
-- 
1.7.9.5

