From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 10/10] ARM: DTS: dra7: Add nodes for McASP1/2/4/5/6/7/8
Date: Mon, 7 Mar 2016 17:17:37 +0200
Message-ID: <1457363857-20797-11-git-send-email-peter.ujfalusi@ti.com>
References: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457363857-20797-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, robh+dt@kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add nodes to represent all McASP ports in the dra7 family.
For system consistency use the eDMA for audio operations. sDMA would be
fine for 4/5/6/7/8 since their DAT port is not through L3 interconnect.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 114 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 4c192ea8ae29..bb3c94aecdeb 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1466,6 +1466,40 @@
 			status = "disabled";
 		};
 
+		mcasp1: mcasp@48460000 {
+			compatible = "ti,dra7-mcasp-audio";
+			ti,hwmods = "mcasp1";
+			reg = <0x48460000 0x2000>,
+			      <0x45800000 0x1000>;
+			reg-names = "mpu","dat";
+			interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tx", "rx";
+			dmas = <&edma_xbar 129 1>, <&edma_xbar 128 1>;
+			dma-names = "tx", "rx";
+			clocks = <&mcasp1_aux_gfclk_mux>, <&mcasp1_ahclkx_mux>,
+				 <&mcasp1_ahclkr_mux>;
+			clock-names = "fck", "ahclkx", "ahclkr";
+			status = "disabled";
+		};
+
+		mcasp2: mcasp@48464000 {
+			compatible = "ti,dra7-mcasp-audio";
+			ti,hwmods = "mcasp2";
+			reg = <0x48464000 0x2000>,
+			      <0x45c00000 0x1000>;
+			reg-names = "mpu","dat";
+			interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tx", "rx";
+			dmas = <&edma_xbar 131 1>, <&edma_xbar 130 1>;
+			dma-names = "tx", "rx";
+			clocks = <&mcasp2_aux_gfclk_mux>, <&mcasp2_ahclkx_mux>,
+				 <&mcasp2_ahclkr_mux>;
+			clock-names = "fck", "ahclkx", "ahclkr";
+			status = "disabled";
+		};
+
 		mcasp3: mcasp@48468000 {
 			compatible = "ti,dra7-mcasp-audio";
 			ti,hwmods = "mcasp3";
@@ -1482,6 +1516,86 @@
 			status = "disabled";
 		};
 
+		mcasp4: mcasp@4846c000 {
+			compatible = "ti,dra7-mcasp-audio";
+			ti,hwmods = "mcasp4";
+			reg = <0x4846c000 0x2000>,
+			      <0x48436000 0x1000>;
+			reg-names = "mpu","dat";
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tx", "rx";
+			dmas = <&edma_xbar 135 1>, <&edma_xbar 134 1>;
+			dma-names = "tx", "rx";
+			clocks = <&mcasp4_aux_gfclk_mux>, <&mcasp4_ahclkx_mux>;
+			clock-names = "fck", "ahclkx";
+			status = "disabled";
+		};
+
+		mcasp5: mcasp@48470000 {
+			compatible = "ti,dra7-mcasp-audio";
+			ti,hwmods = "mcasp5";
+			reg = <0x48470000 0x2000>,
+			      <0x4843a000 0x1000>;
+			reg-names = "mpu","dat";
+			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tx", "rx";
+			dmas = <&edma_xbar 137 1>, <&edma_xbar 136 1>;
+			dma-names = "tx", "rx";
+			clocks = <&mcasp5_aux_gfclk_mux>, <&mcasp5_ahclkx_mux>;
+			clock-names = "fck", "ahclkx";
+			status = "disabled";
+		};
+
+		mcasp6: mcasp@48474000 {
+			compatible = "ti,dra7-mcasp-audio";
+			ti,hwmods = "mcasp6";
+			reg = <0x48474000 0x2000>,
+			      <0x4844c000 0x1000>;
+			reg-names = "mpu","dat";
+			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tx", "rx";
+			dmas = <&edma_xbar 139 1>, <&edma_xbar 138 1>;
+			dma-names = "tx", "rx";
+			clocks = <&mcasp6_aux_gfclk_mux>, <&mcasp6_ahclkx_mux>;
+			clock-names = "fck", "ahclkx";
+			status = "disabled";
+		};
+
+		mcasp7: mcasp@48478000 {
+			compatible = "ti,dra7-mcasp-audio";
+			ti,hwmods = "mcasp7";
+			reg = <0x48478000 0x2000>,
+			      <0x48450000 0x1000>;
+			reg-names = "mpu","dat";
+			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tx", "rx";
+			dmas = <&edma_xbar 141 1>, <&edma_xbar 140 1>;
+			dma-names = "tx", "rx";
+			clocks = <&mcasp7_aux_gfclk_mux>, <&mcasp7_ahclkx_mux>;
+			clock-names = "fck", "ahclkx";
+			status = "disabled";
+		};
+
+		mcasp8: mcasp@4847c000 {
+			compatible = "ti,dra7-mcasp-audio";
+			ti,hwmods = "mcasp8";
+			reg = <0x4847c000 0x2000>,
+			      <0x48454000 0x1000>;
+			reg-names = "mpu","dat";
+			interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tx", "rx";
+			dmas = <&edma_xbar 143 1>, <&edma_xbar 142 1>;
+			dma-names = "tx", "rx";
+			clocks = <&mcasp8_aux_gfclk_mux>, <&mcasp8_ahclkx_mux>;
+			clock-names = "fck", "ahclkx";
+			status = "disabled";
+		};
+
 		crossbar_mpu: crossbar@4a002a48 {
 			compatible = "ti,irq-crossbar";
 			reg = <0x4a002a48 0x130>;
-- 
2.7.2
