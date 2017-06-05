From: sunil.m@techveda.org
Subject: [PATCH] arm: dts: am33xx: Remove redundant interrupt-parent property
Date: Mon,  5 Jun 2017 23:47:16 +0530
Message-ID: <1496686636-19194-1-git-send-email-sunil.m@techveda.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, suniel.spartan@gmail.com, Suniel Mahesh <sunil.m@techveda.org>
List-Id: linux-omap@vger.kernel.org

From: Suniel Mahesh <sunil.m@techveda.org>

Interrupt-parent property is defined in the root node as
"interrupt-parent = <&intc>". This interrupt-parent value becomes
the default for the system, so removed redundant "interrupt-parent"
property from mmc, mac, lcdc and tscadc nodes.

Signed-off-by: Suniel Mahesh <sunil.m@techveda.org>
---
 arch/arm/boot/dts/am33xx.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index bdacb3d..7d7ca05 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -431,7 +431,6 @@
 				&edma_xbar 25 0 0>;
 			dma-names = "tx", "rx";
 			interrupts = <64>;
-			interrupt-parent = <&intc>;
 			reg = <0x48060000 0x1000>;
 			status = "disabled";
 		};
@@ -444,7 +443,6 @@
 				&edma 3 0>;
 			dma-names = "tx", "rx";
 			interrupts = <28>;
-			interrupt-parent = <&intc>;
 			reg = <0x481d8000 0x1000>;
 			status = "disabled";
 		};
@@ -454,7 +452,6 @@
 			ti,hwmods = "mmc3";
 			ti,needs-special-reset;
 			interrupts = <29>;
-			interrupt-parent = <&intc>;
 			reg = <0x47810000 0x1000>;
 			status = "disabled";
 		};
@@ -853,7 +850,6 @@
 			       0x4a101200 0x100>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-			interrupt-parent = <&intc>;
 			/*
 			 * c0_rx_thresh_pend
 			 * c0_rx_pend
@@ -908,7 +904,6 @@
 		lcdc: lcdc@4830e000 {
 			compatible = "ti,am33xx-tilcdc";
 			reg = <0x4830e000 0x1000>;
-			interrupt-parent = <&intc>;
 			interrupts = <36>;
 			ti,hwmods = "lcdc";
 			status = "disabled";
@@ -917,7 +912,6 @@
 		tscadc: tscadc@44e0d000 {
 			compatible = "ti,am3359-tscadc";
 			reg = <0x44e0d000 0x1000>;
-			interrupt-parent = <&intc>;
 			interrupts = <16>;
 			ti,hwmods = "adc_tsc";
 			status = "disabled";
-- 
1.9.1
