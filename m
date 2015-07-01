From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH - resend for 4.2-rc2] ARM: DTS: dra7x: Integrate sDMA crossbar
Date: Wed, 1 Jul 2015 15:52:29 +0300
Message-ID: <1435755149-10328-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The sDMA requests are routed through the DMA crossbar and without the
crossbar only peripherals using DMA request 0-127 can be used.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
Hi Tony,

as you have suggested: http://permalink.gmane.org/gmane.linux.ports.arm.omap/125999
the DTS change has not been taken by Vinod.
Now that the dmaengine pull request is in for 4.2 it would be great if you could
pick up the DTS part of the series and send it for -rc2.

Thank you,
Peter

 arch/arm/boot/dts/dra7.dtsi | 57 ++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 8f1e25bcecbd..c6474dba44cf 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -308,6 +308,15 @@
 			dma-requests = <127>;
 		};
 
+		sdma_xbar: dma-router@4a002b78 {
+			compatible = "ti,dra7-dma-crossbar";
+			reg = <0x4a002b78 0xfc>;
+			#dma-cells = <1>;
+			dma-requests = <205>;
+			ti,dma-safe-map = <0>;
+			dma-masters = <&sdma>;
+		};
+
 		gpio1: gpio@4ae10000 {
 			compatible = "ti,omap4-gpio";
 			reg = <0x4ae10000 0x200>;
@@ -403,7 +412,7 @@
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
 			status = "disabled";
-			dmas = <&sdma 49>, <&sdma 50>;
+			dmas = <&sdma_xbar 49>, <&sdma_xbar 50>;
 			dma-names = "tx", "rx";
 		};
 
@@ -414,7 +423,7 @@
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 			status = "disabled";
-			dmas = <&sdma 51>, <&sdma 52>;
+			dmas = <&sdma_xbar 51>, <&sdma_xbar 52>;
 			dma-names = "tx", "rx";
 		};
 
@@ -425,7 +434,7 @@
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 			status = "disabled";
-			dmas = <&sdma 53>, <&sdma 54>;
+			dmas = <&sdma_xbar 53>, <&sdma_xbar 54>;
 			dma-names = "tx", "rx";
 		};
 
@@ -436,7 +445,7 @@
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
                         status = "disabled";
-			dmas = <&sdma 55>, <&sdma 56>;
+			dmas = <&sdma_xbar 55>, <&sdma_xbar 56>;
 			dma-names = "tx", "rx";
 		};
 
@@ -447,7 +456,7 @@
 			ti,hwmods = "uart5";
 			clock-frequency = <48000000>;
 			status = "disabled";
-			dmas = <&sdma 63>, <&sdma 64>;
+			dmas = <&sdma_xbar 63>, <&sdma_xbar 64>;
 			dma-names = "tx", "rx";
 		};
 
@@ -458,7 +467,7 @@
 			ti,hwmods = "uart6";
 			clock-frequency = <48000000>;
 			status = "disabled";
-			dmas = <&sdma 79>, <&sdma 80>;
+			dmas = <&sdma_xbar 79>, <&sdma_xbar 80>;
 			dma-names = "tx", "rx";
 		};
 
@@ -867,7 +876,7 @@
 			ti,hwmods = "mmc1";
 			ti,dual-volt;
 			ti,needs-special-reset;
-			dmas = <&sdma 61>, <&sdma 62>;
+			dmas = <&sdma_xbar 61>, <&sdma_xbar 62>;
 			dma-names = "tx", "rx";
 			status = "disabled";
 			pbias-supply = <&pbias_mmc_reg>;
@@ -879,7 +888,7 @@
 			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc2";
 			ti,needs-special-reset;
-			dmas = <&sdma 47>, <&sdma 48>;
+			dmas = <&sdma_xbar 47>, <&sdma_xbar 48>;
 			dma-names = "tx", "rx";
 			status = "disabled";
 		};
@@ -890,7 +899,7 @@
 			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc3";
 			ti,needs-special-reset;
-			dmas = <&sdma 77>, <&sdma 78>;
+			dmas = <&sdma_xbar 77>, <&sdma_xbar 78>;
 			dma-names = "tx", "rx";
 			status = "disabled";
 		};
@@ -901,7 +910,7 @@
 			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc4";
 			ti,needs-special-reset;
-			dmas = <&sdma 57>, <&sdma 58>;
+			dmas = <&sdma_xbar 57>, <&sdma_xbar 58>;
 			dma-names = "tx", "rx";
 			status = "disabled";
 		};
@@ -1046,14 +1055,14 @@
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
@@ -1067,10 +1076,10 @@
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
@@ -1083,7 +1092,7 @@
 			#size-cells = <0>;
 			ti,hwmods = "mcspi3";
 			ti,spi-num-cs = <2>;
-			dmas = <&sdma 15>, <&sdma 16>;
+			dmas = <&sdma_xbar 15>, <&sdma_xbar 16>;
 			dma-names = "tx0", "rx0";
 			status = "disabled";
 		};
@@ -1096,7 +1105,7 @@
 			#size-cells = <0>;
 			ti,hwmods = "mcspi4";
 			ti,spi-num-cs = <1>;
-			dmas = <&sdma 70>, <&sdma 71>;
+			dmas = <&sdma_xbar 70>, <&sdma_xbar 71>;
 			dma-names = "tx0", "rx0";
 			status = "disabled";
 		};
-- 
2.4.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
