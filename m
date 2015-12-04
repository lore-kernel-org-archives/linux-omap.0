From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: DTS: am437x: Use the new DT bindings for the eDMA3
Date: Fri, 4 Dec 2015 12:45:24 +0200
Message-ID: <1449225924-28922-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Switch to use the ti,edma3-tpcc and ti,edma3-tptc binding for the eDMA3 and
enable the DMA even crossbar with ti,am335x-edma-crossbar.
With the new bindings boards can customize and tweak the DMA channel
priority to match their needs. With the new binding the memcpy is safe
to be used since with the old binding it was not possible for a driver
to know which channel is allowed to be used as non HW triggered channel.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am4372.dtsi       | 80 +++++++++++++++++++++++++++----------
 arch/arm/boot/dts/am437x-gp-evm.dts |  9 +----
 2 files changed, 62 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index fda655c252f5..2714fa0f8bc8 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -172,6 +172,14 @@
 					mboxes = <&mailbox &mbox_wkupm3>;
 				};
 
+				edma_xbar: dma-router@f90 {
+					compatible = "ti,am335x-edma-crossbar";
+					reg = <0xf90 0x40>;
+					#dma-cells = <3>;
+					dma-requests = <64>;
+					dma-masters = <&edma>;
+				};
+
 				scm_clockdomains: clockdomains {
 				};
 			};
@@ -184,14 +192,46 @@
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
 		};
 
 		uart0: serial@44e09000 {
@@ -496,8 +536,8 @@
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
@@ -508,8 +548,8 @@
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
@@ -777,7 +817,7 @@
 			compatible = "ti,omap5-sham";
 			ti,hwmods = "sham";
 			reg = <0x53100000 0x300>;
-			dmas = <&edma 36>;
+			dmas = <&edma 36 0>;
 			dma-names = "rx";
 			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
 		};
@@ -787,8 +827,8 @@
 			ti,hwmods = "aes";
 			reg = <0x53501000 0xa0>;
 			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&edma 6
-				&edma 5>;
+			dmas = <&edma 6 0>,
+				<&edma 5 0>;
 			dma-names = "tx", "rx";
 		};
 
@@ -797,8 +837,8 @@
 			ti,hwmods = "des";
 			reg = <0x53701000 0xa0>;
 			interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
-			dmas = <&edma 34
-				&edma 33>;
+			dmas = <&edma 34 0>,
+				<&edma 33 0>;
 			dma-names = "tx", "rx";
 		};
 
@@ -811,8 +851,8 @@
 			interrupts = <80>, <81>;
 			interrupt-names = "tx", "rx";
 			status = "disabled";
-			dmas = <&edma 8>,
-			       <&edma 9>;
+			dmas = <&edma 8 2>,
+			       <&edma 9 2>;
 			dma-names = "tx", "rx";
 		};
 
@@ -825,8 +865,8 @@
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
index 7f00e85eebed..64d43325bcbc 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -734,8 +734,8 @@
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
@@ -756,11 +756,6 @@
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
2.6.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
