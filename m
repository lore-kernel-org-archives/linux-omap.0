From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 7/7] ARM: DTS: dra7x: Integrate sDMA crossbar
Date: Fri, 27 Mar 2015 14:26:53 +0200
Message-ID: <1427459213-14611-8-git-send-email-peter.ujfalusi@ti.com>
References: <1427459213-14611-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427459213-14611-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, tony@atomide.com, linux@arm.linux.org.uk
Cc: grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com
List-Id: linux-omap@vger.kernel.org

The sDMA requests are routed through the DMA crossbar and without the
crossbar only peripherals using DMA request 0-127 can be used.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 57 ++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 1b65d3396ff2..48167c990fe8 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -261,6 +261,15 @@
 			dma-requests = <127>;
 		};
 
+		sdma_xbar: dma-router@4a002b78 {
+			compatible = "ti,dra7-dma-crossbar";
+			reg = <0x4a002b78 0xfc>;
+			#dma-cells = <1>;
+			dma-requests = <205>;
+			ti,dma-safe-map = <0>;
+			dma-device = <&sdma>;
+		};
+
 		gpio1: gpio@4ae10000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x4ae10000 0x200>;
@@ -356,7 +365,7 @@
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
 			status = "disabled";
-			dmas = <&sdma 49>, <&sdma 50>;
+			dmas = <&sdma_xbar 49>, <&sdma_xbar 50>;
 			dma-names = "tx", "rx";
 		};
 
@@ -367,7 +376,7 @@
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 			status = "disabled";
-			dmas = <&sdma 51>, <&sdma 52>;
+			dmas = <&sdma_xbar 51>, <&sdma_xbar 52>;
 			dma-names = "tx", "rx";
 		};
 
@@ -378,7 +387,7 @@
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 			status = "disabled";
-			dmas = <&sdma 53>, <&sdma 54>;
+			dmas = <&sdma_xbar 53>, <&sdma_xbar 54>;
 			dma-names = "tx", "rx";
 		};
 
@@ -389,7 +398,7 @@
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
                         status = "disabled";
-			dmas = <&sdma 55>, <&sdma 56>;
+			dmas = <&sdma_xbar 55>, <&sdma_xbar 56>;
 			dma-names = "tx", "rx";
 		};
 
@@ -400,7 +409,7 @@
 			ti,hwmods = "uart5";
 			clock-frequency = <48000000>;
 			status = "disabled";
-			dmas = <&sdma 63>, <&sdma 64>;
+			dmas = <&sdma_xbar 63>, <&sdma_xbar 64>;
 			dma-names = "tx", "rx";
 		};
 
@@ -411,7 +420,7 @@
 			ti,hwmods = "uart6";
 			clock-frequency = <48000000>;
 			status = "disabled";
-			dmas = <&sdma 79>, <&sdma 80>;
+			dmas = <&sdma_xbar 79>, <&sdma_xbar 80>;
 			dma-names = "tx", "rx";
 		};
 
@@ -820,7 +829,7 @@
 			ti,hwmods = "mmc1";
 			ti,dual-volt;
 			ti,needs-special-reset;
-			dmas = <&sdma 61>, <&sdma 62>;
+			dmas = <&sdma_xbar 61>, <&sdma_xbar 62>;
 			dma-names = "tx", "rx";
 			status = "disabled";
 			pbias-supply = <&pbias_mmc_reg>;
@@ -832,7 +841,7 @@
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc2";
 			ti,needs-special-reset;
-			dmas = <&sdma 47>, <&sdma 48>;
+			dmas = <&sdma_xbar 47>, <&sdma_xbar 48>;
 			dma-names = "tx", "rx";
 			status = "disabled";
 		};
@@ -843,7 +852,7 @@
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc3";
 			ti,needs-special-reset;
-			dmas = <&sdma 77>, <&sdma 78>;
+			dmas = <&sdma_xbar 77>, <&sdma_xbar 78>;
 			dma-names = "tx", "rx";
 			status = "disabled";
 		};
@@ -854,7 +863,7 @@
 			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc4";
 			ti,needs-special-reset;
-			dmas = <&sdma 57>, <&sdma 58>;
+			dmas = <&sdma_xbar 57>, <&sdma_xbar 58>;
 			dma-names = "tx", "rx";
 			status = "disabled";
 		};
@@ -999,14 +1008,14 @@
 			#size-cells = <0>;
 			ti,hwmods = "mcspi1";
 			ti,spi-num-cs = <4>;
-			dmas = <&sdma 35>,
-			       <&sdma 36>,
-			       <&sdma 37>,
-			       <&sdma 38>,
-			       <&sdma 39>,
-			       <&sdma 40>,
-			       <&sdma 41>,
-			       <&sdma 42>;
+			dmas = <&sdma_xbar 35>,
+			       <&sdma_xbar 36>,
+			       <&sdma_xbar 37>,
+			       <&sdma_xbar 38>,
+			       <&sdma_xbar 39>,
+			       <&sdma_xbar 40>,
+			       <&sdma_xbar 41>,
+			       <&sdma_xbar 42>;
 			dma-names = "tx0", "rx0", "tx1", "rx1",
 				    "tx2", "rx2", "tx3", "rx3";
 			status = "disabled";
@@ -1020,10 +1029,10 @@
 			#size-cells = <0>;
 			ti,hwmods = "mcspi2";
 			ti,spi-num-cs = <2>;
-			dmas = <&sdma 43>,
-			       <&sdma 44>,
-			       <&sdma 45>,
-			       <&sdma 46>;
+			dmas = <&sdma_xbar 43>,
+			       <&sdma_xbar 44>,
+			       <&sdma_xbar 45>,
+			       <&sdma_xbar 46>;
 			dma-names = "tx0", "rx0", "tx1", "rx1";
 			status = "disabled";
 		};
@@ -1036,7 +1045,7 @@
 			#size-cells = <0>;
 			ti,hwmods = "mcspi3";
 			ti,spi-num-cs = <2>;
-			dmas = <&sdma 15>, <&sdma 16>;
+			dmas = <&sdma_xbar 15>, <&sdma_xbar 16>;
 			dma-names = "tx0", "rx0";
 			status = "disabled";
 		};
@@ -1049,7 +1058,7 @@
 			#size-cells = <0>;
 			ti,hwmods = "mcspi4";
 			ti,spi-num-cs = <1>;
-			dmas = <&sdma 70>, <&sdma 71>;
+			dmas = <&sdma_xbar 70>, <&sdma_xbar 71>;
 			dma-names = "tx0", "rx0";
 			status = "disabled";
 		};
-- 
2.3.3
