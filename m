From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 14/14] ARM: DTS: am437x: Use the new DT bindings for the eDMA3
Date: Fri, 16 Oct 2015 10:18:12 +0300
Message-ID: <1444979892-31626-15-git-send-email-peter.ujfalusi@ti.com>
References: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444979892-31626-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, nsekhar@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, tony@atomide.com, r.schwebel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

Switch to use the ti,edma3-tpcc and ti,edma3-tptc binding for the eDMA3 and
enable the DMA even crossbar with ti,am335x-edma-crossbar.
With the new bindings boards can customize and tweak the DMA channel
priority to match their needs. With the new binding the memcpy is safe
to be used since with the old binding it was not possible for a driver
to know which channel is allowed to be used as non HW triggered channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi       | 82 ++++++++++++++++++++++++++++---------
 arch/arm/boot/dts/am437x-gp-evm.dts |  9 +---
 2 files changed, 64 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index d83ff9c9701e..a39428dd85b2 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -183,14 +183,56 @@
 		};
 
 		edma: edma@49000000 {
-			compatible = "ti,edma3";
-			ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
-			reg =	<0x49000000 0x10000>,
-				<0x44e10f90 0x10>;
+			compatible = "ti,edma3-tpcc";
+			ti,hwmods = "tpcc";
+			reg =	<0x49000000 0x10000>;
+			reg-names = "edma3_cc";
 			interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
-					<GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
-			#dma-cells = <1>;
+				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "edma3_ccint", "emda3_mperr",
+					  "edma3_ccerrint";
+			dma-requests = <64>;
+			#dma-cells = <2>;
+
+			ti,tptcs = <&edma_tptc0 7>, <&edma_tptc1 5>,
+				   <&edma_tptc2 0>;
+
+			ti,edma-memcpy-channels = /bits/ 16 <32 33>;
+		};
+
+		edma_tptc0: tptc@49800000 {
+			compatible = "ti,edma3-tptc";
+			ti,hwmods = "tptc0";
+			reg =	<0x49800000 0x100000>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "edma3_tcerrint";
+		};
+
+		edma_tptc1: tptc@49900000 {
+			compatible = "ti,edma3-tptc";
+			ti,hwmods = "tptc1";
+			reg =	<0x49900000 0x100000>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "edma3_tcerrint";
+		};
+
+		edma_tptc2: tptc@49a00000 {
+			compatible = "ti,edma3-tptc";
+			ti,hwmods = "tptc2";
+			reg =	<0x49a00000 0x100000>;
+			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "edma3_tcerrint";
+		};
+
+		edma_xbar: dma-router@44e10f90 {
+			compatible = "ti,am335x-edma-crossbar";
+			reg = <0x44e10f90 0x40>;
+
+			#dma-cells = <3>;
+			dma-requests = <64>;
+
+			dma-masters = <&edma>;
 		};
 
 		uart0: serial@44e09000 {
@@ -495,8 +537,8 @@
 			ti,hwmods = "mmc1";
 			ti,dual-volt;
 			ti,needs-special-reset;
-			dmas = <&edma 24
-				&edma 25>;
+			dmas = <&edma 24 0>,
+				<&edma 25 0>;
 			dma-names = "tx", "rx";
 			interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -507,8 +549,8 @@
 			reg = <0x481d8000 0x1000>;
 			ti,hwmods = "mmc2";
 			ti,needs-special-reset;
-			dmas = <&edma 2
-				&edma 3>;
+			dmas = <&edma 2 0>,
+				<&edma 3 0>;
 			dma-names = "tx", "rx";
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -776,7 +818,7 @@
 			compatible = "ti,omap5-sham";
 			ti,hwmods = "sham";
 			reg = <0x53100000 0x300>;
-			dmas = <&edma 36>;
+			dmas = <&edma 36 0>;
 			dma-names = "rx";
 			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 		};
@@ -786,8 +828,8 @@
 			ti,hwmods = "aes";
 			reg = <0x53501000 0xa0>;
 			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&edma 6
-				&edma 5>;
+			dmas = <&edma 6 0>,
+				<&edma 5 0>;
 			dma-names = "tx", "rx";
 		};
 
@@ -796,8 +838,8 @@
 			ti,hwmods = "des";
 			reg = <0x53701000 0xa0>;
 			interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&edma 34
-				&edma 33>;
+			dmas = <&edma 34 0>,
+				<&edma 33 0>;
 			dma-names = "tx", "rx";
 		};
 
@@ -810,8 +852,8 @@
 			interrupts = <80>, <81>;
 			interrupt-names = "tx", "rx";
 			status = "disabled";
-			dmas = <&edma 8>,
-			       <&edma 9>;
+			dmas = <&edma 8 2>,
+			       <&edma 9 2>;
 			dma-names = "tx", "rx";
 		};
 
@@ -824,8 +866,8 @@
 			interrupts = <82>, <83>;
 			interrupt-names = "tx", "rx";
 			status = "disabled";
-			dmas = <&edma 10>,
-			       <&edma 11>;
+			dmas = <&edma 10 2>,
+			       <&edma 11 2>;
 			dma-names = "tx", "rx";
 		};
 
diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 22038f21f228..28e3b252c08c 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -711,8 +711,8 @@
 	status = "okay";
 	/* these are on the crossbar and are outlined in the
 	   xbar-event-map element */
-	dmas = <&edma 30
-		&edma 31>;
+	dmas = <&edma_xbar 30 0 1>,
+		<&edma_xbar 31 0 2>;
 	dma-names = "tx", "rx";
 	vmmc-supply = <&vmmcwl_fixed>;
 	bus-width = <4>;
@@ -733,11 +733,6 @@
 	};
 };
 
-&edma {
-	ti,edma-xbar-event-map = /bits/ 16 <1 30
-					    2 31>;
-};
-
 &uart3 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.6.1
