From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 04/11] ARM: DTS: dra7: Use eDMA and add DAT port address for McASP3
Date: Thu, 25 Feb 2016 16:50:20 +0200
Message-ID: <1456411827-23962-5-git-send-email-peter.ujfalusi@ti.com>
References: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, robh+dt@kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Misael Lopez Cruz <misael.lopez@ti.com>

McASP3 does not support constant addressing mode on the DAT
port, so increment transfers must be used instead.  This
restriction is also applicable for McASP1 and McASP2.

This DMA addressing constraint poses a major problem for sDMA
where constant addressing mode is used on the peripheral side.
Unfortunately, using increment transfers in sDMA comes with
important side effects.

The addressing mode used in eDMA is INC, so the silicon limitation
described above has no impact and the McASP3 DAT port can be
safely added by switching to eDMA instead of sDMA.

Signed-off-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index d2d2568b5695..258e6712a76b 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1467,12 +1467,13 @@
 		mcasp3: mcasp@48468000 {
 			compatible = "ti,dra7-mcasp-audio";
 			ti,hwmods = "mcasp3";
-			reg = <0x48468000 0x2000>;
-			reg-names = "mpu";
+			reg = <0x48468000 0x2000>,
+			      <0x46000000 0x1000>;
+			reg-names = "mpu","dat";
 			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "tx", "rx";
-			dmas = <&sdma_xbar 133>, <&sdma_xbar 132>;
+			dmas = <&edma_xbar 133 1>, <&edma_xbar 132 1>;
 			dma-names = "tx", "rx";
 			clocks = <&mcasp3_aux_gfclk_mux>, <&mcasp3_ahclkx_mux>;
 			clock-names = "fck", "ahclkx";
-- 
2.7.1
