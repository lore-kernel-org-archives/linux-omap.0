From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 36/45] ARM: dts: omap3: Add main and optional clock data into DT
Date: Thu, 29 Aug 2013 16:16:28 +0300
Message-ID: <1377782197-10611-37-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55614 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753789Ab3H2NSe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 09:18:34 -0400
In-Reply-To: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, nm@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

With support to partse clock data from DT, move all main and optional
clock information from hwmod to DT.

We still retain clocks in hwmod for devices which do not have a DT node.

Also, this patch does not remove the clock info from hwmod yet, to
retain legacy boot mode support.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi |   82 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 939cc20..b7b5522 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -80,6 +80,8 @@
 			compatible = "ti,omap-counter32k";
 			reg = <0x48320000 0x20>;
 			ti,hwmods = "counter_32k";
+			clocks = <&wkup_32k_fck>;
+			clock-names = "fck";
 		};
 
 		intc: interrupt-controller@48200000 {
@@ -100,6 +102,8 @@
 			#dma-cells = <1>;
 			#dma-channels = <32>;
 			#dma-requests = <96>;
+			clocks = <&core_l3_ick>;
+			clock-names = "fck";
 		};
 
 		omap3_pmx_core: pinmux@48002030 {
@@ -125,6 +129,8 @@
 			reg = <0x48310000 0x200>;
 			interrupts = <29>;
 			ti,hwmods = "gpio1";
+			clocks = <&gpio1_ick>, <&gpio1_dbck>;
+			clock-names = "fck", "dbclk";
 			ti,gpio-always-on;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -137,6 +143,8 @@
 			reg = <0x49050000 0x200>;
 			interrupts = <30>;
 			ti,hwmods = "gpio2";
+			clocks = <&gpio2_ick>, <&gpio2_dbck>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -148,6 +156,8 @@
 			reg = <0x49052000 0x200>;
 			interrupts = <31>;
 			ti,hwmods = "gpio3";
+			clocks = <&gpio3_ick>, <&gpio3_dbck>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -159,6 +169,8 @@
 			reg = <0x49054000 0x200>;
 			interrupts = <32>;
 			ti,hwmods = "gpio4";
+			clocks = <&gpio4_ick>, <&gpio4_dbck>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -170,6 +182,8 @@
 			reg = <0x49056000 0x200>;
 			interrupts = <33>;
 			ti,hwmods = "gpio5";
+			clocks = <&gpio5_ick>, <&gpio5_dbck>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -181,6 +195,8 @@
 			reg = <0x49058000 0x200>;
 			interrupts = <34>;
 			ti,hwmods = "gpio6";
+			clocks = <&gpio6_ick>, <&gpio6_dbck>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -190,18 +206,24 @@
 		uart1: serial@4806a000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart1";
+			clocks = <&uart1_fck>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 		};
 
 		uart2: serial@4806c000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart2";
+			clocks = <&uart2_fck>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 		};
 
 		uart3: serial@49020000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart3";
+			clocks = <&uart3_fck>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 		};
 
@@ -210,6 +232,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c1";
+			clocks = <&i2c1_fck>;
+			clock-names = "fck";
 		};
 
 		i2c2: i2c@48072000 {
@@ -217,6 +241,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c2";
+			clocks = <&i2c2_fck>;
+			clock-names = "fck";
 		};
 
 		i2c3: i2c@48060000 {
@@ -224,6 +250,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
+			clocks = <&i2c3_fck>;
+			clock-names = "fck";
 		};
 
 		mcspi1: spi@48098000 {
@@ -231,6 +259,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi1";
+			clocks = <&mcspi1_fck>;
+			clock-names = "fck";
 			ti,spi-num-cs = <4>;
 			dmas = <&sdma 35>,
 			       <&sdma 36>,
@@ -249,6 +279,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi2";
+			clocks = <&mcspi2_fck>;
+			clock-names = "fck";
 			ti,spi-num-cs = <2>;
 			dmas = <&sdma 43>,
 			       <&sdma 44>,
@@ -262,6 +294,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi3";
+			clocks = <&mcspi3_fck>;
+			clock-names = "fck";
 			ti,spi-num-cs = <2>;
 			dmas = <&sdma 15>,
 			       <&sdma 16>,
@@ -275,6 +309,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi4";
+			clocks = <&mcspi4_fck>;
+			clock-names = "fck";
 			ti,spi-num-cs = <1>;
 			dmas = <&sdma 70>, <&sdma 71>;
 			dma-names = "tx0", "rx0";
@@ -283,6 +319,8 @@
 		mmc1: mmc@4809c000 {
 			compatible = "ti,omap3-hsmmc";
 			ti,hwmods = "mmc1";
+			clocks = <&mmchs1_fck>, <&omap_32k_fck>;
+			clock-names = "fck", "dbck";
 			ti,dual-volt;
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
@@ -291,6 +329,8 @@
 		mmc2: mmc@480b4000 {
 			compatible = "ti,omap3-hsmmc";
 			ti,hwmods = "mmc2";
+			clocks = <&mmchs2_fck>, <&omap_32k_fck>;
+			clock-names = "fck", "dbck";
 			dmas = <&sdma 47>, <&sdma 48>;
 			dma-names = "tx", "rx";
 		};
@@ -298,6 +338,8 @@
 		mmc3: mmc@480ad000 {
 			compatible = "ti,omap3-hsmmc";
 			ti,hwmods = "mmc3";
+			clocks = <&mmchs3_fck>, <&omap_32k_fck>;
+			clock-names = "fck", "dbck";
 			dmas = <&sdma 77>, <&sdma 78>;
 			dma-names = "tx", "rx";
 		};
@@ -305,6 +347,8 @@
 		wdt2: wdt@48314000 {
 			compatible = "ti,omap3-wdt";
 			ti,hwmods = "wd_timer2";
+			clocks = <&wdt2_fck>;
+			clock-names = "fck";
 		};
 
 		mcbsp1: mcbsp@48074000 {
@@ -317,6 +361,8 @@
 			interrupt-names = "common", "tx", "rx";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp1";
+			clocks = <&mcbsp1_fck>, <&mcbsp_clks>, <&core_96m_fck>;
+			clock-names = "fck", "pad_fck", "prcm_fck";
 			dmas = <&sdma 31>,
 			       <&sdma 32>;
 			dma-names = "tx", "rx";
@@ -366,6 +412,8 @@
 			interrupt-names = "common", "tx", "rx";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp4";
+			clocks = <&mcbsp4_fck>, <&mcbsp_clks>, <&per_96m_fck>;
+			clock-names = "fck", "pad_fck", "prcm_fck";
 			dmas = <&sdma 19>,
 			       <&sdma 20>;
 			dma-names = "tx", "rx";
@@ -381,6 +429,8 @@
 			interrupt-names = "common", "tx", "rx";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp5";
+			clocks = <&mcbsp5_fck>, <&mcbsp_clks>, <&core_96m_fck>;
+			clock-names = "fck", "pad_fck", "prcm_fck";
 			dmas = <&sdma 21>,
 			       <&sdma 22>;
 			dma-names = "tx", "rx";
@@ -391,6 +441,8 @@
 			reg = <0x48318000 0x400>;
 			interrupts = <37>;
 			ti,hwmods = "timer1";
+			clocks = <&gpt1_fck>;
+			clock-names = "fck";
 			ti,timer-alwon;
 		};
 
@@ -399,6 +451,8 @@
 			reg = <0x49032000 0x400>;
 			interrupts = <38>;
 			ti,hwmods = "timer2";
+			clocks = <&gpt2_fck>;
+			clock-names = "fck";
 		};
 
 		timer3: timer@49034000 {
@@ -406,6 +460,8 @@
 			reg = <0x49034000 0x400>;
 			interrupts = <39>;
 			ti,hwmods = "timer3";
+			clocks = <&gpt3_fck>;
+			clock-names = "fck";
 		};
 
 		timer4: timer@49036000 {
@@ -413,6 +469,8 @@
 			reg = <0x49036000 0x400>;
 			interrupts = <40>;
 			ti,hwmods = "timer4";
+			clocks = <&gpt4_fck>;
+			clock-names = "fck";
 		};
 
 		timer5: timer@49038000 {
@@ -420,6 +478,8 @@
 			reg = <0x49038000 0x400>;
 			interrupts = <41>;
 			ti,hwmods = "timer5";
+			clocks = <&gpt5_fck>;
+			clock-names = "fck";
 			ti,timer-dsp;
 		};
 
@@ -428,6 +488,8 @@
 			reg = <0x4903a000 0x400>;
 			interrupts = <42>;
 			ti,hwmods = "timer6";
+			clocks = <&gpt6_fck>;
+			clock-names = "fck";
 			ti,timer-dsp;
 		};
 
@@ -436,6 +498,8 @@
 			reg = <0x4903c000 0x400>;
 			interrupts = <43>;
 			ti,hwmods = "timer7";
+			clocks = <&gpt7_fck>;
+			clock-names = "fck";
 			ti,timer-dsp;
 		};
 
@@ -444,6 +508,8 @@
 			reg = <0x4903e000 0x400>;
 			interrupts = <44>;
 			ti,hwmods = "timer8";
+			clocks = <&gpt8_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 			ti,timer-dsp;
 		};
@@ -453,6 +519,8 @@
 			reg = <0x49040000 0x400>;
 			interrupts = <45>;
 			ti,hwmods = "timer9";
+			clocks = <&gpt9_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -461,6 +529,8 @@
 			reg = <0x48086000 0x400>;
 			interrupts = <46>;
 			ti,hwmods = "timer10";
+			clocks = <&gpt10_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -469,6 +539,8 @@
 			reg = <0x48088000 0x400>;
 			interrupts = <47>;
 			ti,hwmods = "timer11";
+			clocks = <&gpt11_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -477,6 +549,8 @@
 			reg = <0x48304000 0x400>;
 			interrupts = <95>;
 			ti,hwmods = "timer12";
+			clocks = <&gpt12_fck>;
+			clock-names = "fck";
 			ti,timer-alwon;
 			ti,timer-secure;
 		};
@@ -486,12 +560,16 @@
 			reg = <0x48062000 0x1000>;
 			interrupts = <78>;
 			ti,hwmods = "usb_tll_hs";
+			clocks = <&usbtll_fck>;
+			clock-names = "fck";
 		};
 
 		usbhshost: usbhshost@48064000 {
 			compatible = "ti,usbhs-host";
 			reg = <0x48064000 0x400>;
 			ti,hwmods = "usb_host_hs";
+			clocks = <&usbhost_48m_fck>, <&usbhost_120m_fck>;
+			clock-names = "fck", "ehci_logic_fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -514,6 +592,8 @@
 		gpmc: gpmc@6e000000 {
 			compatible = "ti,omap3430-gpmc";
 			ti,hwmods = "gpmc";
+			clocks = <&gpmc_fck>;
+			clock-names = "fck";
 			reg = <0x6e000000 0x02d0>;
 			interrupts = <20>;
 			gpmc,num-cs = <8>;
@@ -528,6 +608,8 @@
 			interrupts = <92>, <93>;
 			interrupt-names = "mc", "dma";
 			ti,hwmods = "usb_otg_hs";
+			clocks = <&hsotgusb_ick>;
+			clock-names = "fck";
 			multipoint = <1>;
 			num-eps = <16>;
 			ram-bits = <12>;
-- 
1.7.9.5

