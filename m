From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Add missing reg, interrupt and dma entries for
 omap3
Date: Thu, 17 Oct 2013 15:15:22 -0700
Message-ID: <20131017221522.GE15154@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26658 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757872Ab3JQWPZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Oct 2013 18:15:25 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Looks like omap3 is still relying on hwmod data for some basic
device tree information. Let's add the information to omap3.dtsi
so we can remove the related hwmod data once omap3 is DT only.

Cc: Benoit Cousson <bcousson@baylibre.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -37,6 +37,7 @@
 
 	pmu {
 		compatible = "arm,cortex-a8-pmu";
+		reg = <0x54000000 0x800000>;
 		interrupts = <3>;
 		ti,hwmods = "debugss";
 	};
@@ -71,6 +72,8 @@
 	 */
 	ocp {
 		compatible = "simple-bus";
+		reg = <0x68000000 0x10000>;
+		interrupts = <9 10>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
@@ -193,24 +196,40 @@
 
 		uart1: serial@4806a000 {
 			compatible = "ti,omap3-uart";
+			reg = <0x4806a000 0x2000>;
+			interrupts = <72>;
+			dmas = <&sdma 49 &sdma 50>;
+			dma-names = "tx", "rx";
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
 		};
 
 		uart2: serial@4806c000 {
 			compatible = "ti,omap3-uart";
+			reg = <0x4806c000 0x400>;
+			interrupts = <73>;
+			dmas = <&sdma 51 &sdma 52>;
+			dma-names = "tx", "rx";
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
 		};
 
 		uart3: serial@49020000 {
 			compatible = "ti,omap3-uart";
+			reg = <0x49020000 0x400>;
+			interrupts = <74>;
+			dmas = <&sdma 53 &sdma 54>;
+			dma-names = "tx", "rx";
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
 		};
 
 		i2c1: i2c@48070000 {
 			compatible = "ti,omap3-i2c";
+			reg = <0x48070000 0x80>;
+			interrupts = <56>;
+			dmas = <&sdma 27 &sdma 28>;
+			dma-names = "tx", "rx";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c1";
@@ -218,6 +237,10 @@
 
 		i2c2: i2c@48072000 {
 			compatible = "ti,omap3-i2c";
+			reg = <0x48072000 0x80>;
+			interrupts = <57>;
+			dmas = <&sdma 29 &sdma 30>;
+			dma-names = "tx", "rx";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c2";
@@ -225,6 +248,10 @@
 
 		i2c3: i2c@48060000 {
 			compatible = "ti,omap3-i2c";
+			reg = <0x48060000 0x80>;
+			interrupts = <61>;
+			dmas = <&sdma 25 &sdma 26>;
+			dma-names = "tx", "rx";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
@@ -232,6 +259,8 @@
 
 		mcspi1: spi@48098000 {
 			compatible = "ti,omap2-mcspi";
+			reg = <0x48098000 0x100>;
+			interrupts = <65>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi1";
@@ -250,6 +279,8 @@
 
 		mcspi2: spi@4809a000 {
 			compatible = "ti,omap2-mcspi";
+			reg = <0x4809a000 0x100>;
+			interrupts = <66>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi2";
@@ -263,6 +294,8 @@
 
 		mcspi3: spi@480b8000 {
 			compatible = "ti,omap2-mcspi";
+			reg = <0x480b8000 0x100>;
+			interrupts = <91>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi3";
@@ -276,6 +309,8 @@
 
 		mcspi4: spi@480ba000 {
 			compatible = "ti,omap2-mcspi";
+			reg = <0x480ba000 0x100>;
+			interrupts = <48>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi4";
@@ -284,8 +319,17 @@
 			dma-names = "tx0", "rx0";
 		};
 
+		hdqw1w: 1w@480b2000 {
+			compatible = "ti,omap3-1w";
+			reg = <0x480b2000 0x1000>;
+			interrupts = <58>;
+			ti,hwmods = "hdq1w";
+		};
+
 		mmc1: mmc@4809c000 {
 			compatible = "ti,omap3-hsmmc";
+			reg = <0x4809c000 0x200>;
+			interrupts = <83>;
 			ti,hwmods = "mmc1";
 			ti,dual-volt;
 			dmas = <&sdma 61>, <&sdma 62>;
@@ -294,6 +338,8 @@
 
 		mmc2: mmc@480b4000 {
 			compatible = "ti,omap3-hsmmc";
+			reg = <0x480b4000 0x200>;
+			interrupts = <86>;
 			ti,hwmods = "mmc2";
 			dmas = <&sdma 47>, <&sdma 48>;
 			dma-names = "tx", "rx";
@@ -301,6 +347,8 @@
 
 		mmc3: mmc@480ad000 {
 			compatible = "ti,omap3-hsmmc";
+			reg = <0x480ad000 0x200>;
+			interrupts = <94>;
 			ti,hwmods = "mmc3";
 			dmas = <&sdma 77>, <&sdma 78>;
 			dma-names = "tx", "rx";
@@ -308,6 +356,7 @@
 
 		wdt2: wdt@48314000 {
 			compatible = "ti,omap3-wdt";
+			reg = <0x48314000 0x80>;
 			ti,hwmods = "wd_timer2";
 		};
 
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index f8b3765..380c22e 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -31,6 +31,10 @@
 	ocp {
 		uart4: serial@49042000 {
 			compatible = "ti,omap3-uart";
+			reg = <0x49042000 0x400>;
+			interrupts = <80>;
+			dmas = <&sdma 81 &sdma 82>;
+			dma-names = "tx", "rx";
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 		};
