From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH DO NOT MERGE 5/6] ARM: dts: omap4: add some sample clkctrl data
Date: Mon, 13 Feb 2017 15:22:36 +0200
Message-ID: <1486992157-10673-6-git-send-email-t-kristo@ti.com>
References: <1486992157-10673-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1486992157-10673-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Adds clkctrl nodes for cm_l4per and cm_abe as example. Peripherals using
clocks from these nodes are modified also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 72 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 8087456..214e58d 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/omap.h>
+#include <dt-bindings/clock/omap4.h>
 
 / {
 	compatible = "ti,omap4430", "ti,omap4";
@@ -131,27 +132,61 @@
 			ranges = <0 0x4a000000 0x1000000>;
 
 			cm1: cm1@4000 {
-				compatible = "ti,omap4-cm1";
+				compatible = "ti,omap4-cm1", "simple-bus";
 				reg = <0x4000 0x2000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x4000 0x2000>;
 
 				cm1_clocks: clocks {
 					#address-cells = <1>;
 					#size-cells = <0>;
 				};
 
+				cm_abe: cm_abe@0 {
+					compatible = "ti,omap4-cm";
+					reg = <0x500 0x100>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					ranges = <0 0x500 0x100>;
+
+					cm_abe_clkctrl: cm_abe_clkctrl@20 {
+						compatible = "ti,omap4-clkctrl";
+						reg = <0x20 0x6c>;
+						#clock-cells = <2>;
+					};
+				};
+
 				cm1_clockdomains: clockdomains {
 				};
 			};
 
 			cm2: cm2@8000 {
-				compatible = "ti,omap4-cm2";
+				compatible = "ti,omap4-cm2", "simple-bus";
 				reg = <0x8000 0x3000>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x8000 0x3000>;
 
 				cm2_clocks: clocks {
 					#address-cells = <1>;
 					#size-cells = <0>;
 				};
 
+				cm_l4per: cm_l4per@0 {
+					compatible = "ti,omap4-cm";
+					reg = <0x1400 0x200>;
+					#address-cells = <1>;
+					#size-cells = <1>;
+					ranges = <0 0x1400 0x200>;
+
+					cm_l4per_clkctrl: cm_l4per_clkctrl@20 {
+						compatible = "ti,omap4-clkctrl";
+						reg = <0x20 0x1b0>;
+						#clock-cells = <2>;
+					};
+				};
+
 				cm2_clockdomains: clockdomains {
 				};
 			};
@@ -304,6 +339,8 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&cm_l4per_clkctrl OMAP4_GPIO2_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		gpio3: gpio@48057000 {
@@ -315,6 +352,8 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&cm_l4per_clkctrl OMAP4_GPIO3_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		gpio4: gpio@48059000 {
@@ -384,6 +423,8 @@
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
+			clocks = <&cm_l4per_clkctrl OMAP4_UART1_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		uart2: serial@4806c000 {
@@ -392,6 +433,8 @@
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
+			clocks = <&cm_l4per_clkctrl OMAP4_UART2_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		uart3: serial@48020000 {
@@ -400,6 +443,8 @@
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
+			clocks = <&cm_l4per_clkctrl OMAP4_UART3_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		uart4: serial@4806e000 {
@@ -408,6 +453,8 @@
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
+			clocks = <&cm_l4per_clkctrl OMAP4_UART4_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		hwspinlock: spinlock@4a0f6000 {
@@ -424,6 +471,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c1";
+			clocks = <&cm_l4per_clkctrl OMAP4_I2C1_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		i2c2: i2c@48072000 {
@@ -433,6 +482,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c2";
+			clocks = <&cm_l4per_clkctrl OMAP4_I2C2_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		i2c3: i2c@48060000 {
@@ -442,6 +493,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
+			clocks = <&cm_l4per_clkctrl OMAP4_I2C3_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		i2c4: i2c@48350000 {
@@ -451,6 +504,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c4";
+			clocks = <&cm_l4per_clkctrl OMAP4_I2C4_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mcspi1: spi@48098000 {
@@ -522,6 +577,7 @@
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
 			pbias-supply = <&pbias_mmc_reg>;
+
 		};
 
 		mmc2: mmc@480b4000 {
@@ -542,6 +598,8 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 77>, <&sdma 78>;
 			dma-names = "tx", "rx";
+			clocks = <&cm_l4per_clkctrl OMAP4_MMC3_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mmc4: mmc@480d1000 {
@@ -552,6 +610,8 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 57>, <&sdma 58>;
 			dma-names = "tx", "rx";
+			clocks = <&cm_l4per_clkctrl OMAP4_MMC4_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mmc5: mmc@480d5000 {
@@ -562,6 +622,8 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 59>, <&sdma 60>;
 			dma-names = "tx", "rx";
+			clocks = <&cm_l4per_clkctrl OMAP4_MMC5_CLKCTRL 0>;
+			clock-names = "clkctrl";
 		};
 
 		mmu_dsp: mmu@4a066000 {
@@ -598,6 +660,8 @@
 			dmas = <&sdma 65>,
 			       <&sdma 66>;
 			dma-names = "up_link", "dn_link";
+			clocks = <&cm_abe_clkctrl OMAP4_MCPDM_CLKCTRL 0>;
+			clock-names = "clkctrl";
 			status = "disabled";
 		};
 
@@ -610,6 +674,8 @@
 			ti,hwmods = "dmic";
 			dmas = <&sdma 67>;
 			dma-names = "up_link";
+			clocks = <&cm_abe_clkctrl OMAP4_DMIC_CLKCTRL 0>;
+			clock-names = "clkctrl";
 			status = "disabled";
 		};
 
@@ -625,6 +691,8 @@
 			dmas = <&sdma 33>,
 			       <&sdma 34>;
 			dma-names = "tx", "rx";
+			clocks = <&cm_abe_clkctrl OMAP4_MCBSP1_CLKCTRL 0>;
+			clock-names = "clkctrl";
 			status = "disabled";
 		};
 
-- 
1.9.1

