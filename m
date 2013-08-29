From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 41/45] ARM: dts: omap5: Add main and optional clock data into DT
Date: Thu, 29 Aug 2013 16:16:33 +0300
Message-ID: <1377782197-10611-42-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55662 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070Ab3H2NTO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Aug 2013 09:19:14 -0400
In-Reply-To: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, nm@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

With support to parse clock data from DT, move all main and optional
clock information from hwmod to DT.

We still retain clocks in hwmod for devices which do not have a DT node.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi               |  102 ++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |  119 ----------------------------
 2 files changed, 102 insertions(+), 119 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 59f7246..d269355 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -100,6 +100,8 @@
 			compatible = "ti,omap-counter32k";
 			reg = <0x4ae04000 0x40>;
 			ti,hwmods = "counter_32k";
+			clocks = <&wkupaon_iclk_mux>;
+			clock-names = "fck";
 		};
 
 		omap5_pmx_core: pinmux@4a002840 {
@@ -129,6 +131,8 @@
 			#dma-cells = <1>;
 			#dma-channels = <32>;
 			#dma-requests = <127>;
+			clocks = <&l3_iclk_div>;
+			clock-names = "fck";
 		};
 
 		gpio1: gpio@4ae10000 {
@@ -136,6 +140,8 @@
 			reg = <0x4ae10000 0x200>;
 			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio1";
+			clocks = <&wkupaon_iclk_mux>, <&gpio1_dbclk>;
+			clock-names = "fck", "dbclk";
 			ti,gpio-always-on;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -148,6 +154,8 @@
 			reg = <0x48055000 0x200>;
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio2";
+			clocks = <&l4_root_clk_div>, <&gpio2_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -159,6 +167,8 @@
 			reg = <0x48057000 0x200>;
 			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio3";
+			clocks = <&l4_root_clk_div>, <&gpio3_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -170,6 +180,8 @@
 			reg = <0x48059000 0x200>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio4";
+			clocks = <&l4_root_clk_div>, <&gpio4_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -181,6 +193,8 @@
 			reg = <0x4805b000 0x200>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio5";
+			clocks = <&l4_root_clk_div>, <&gpio5_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -192,6 +206,8 @@
 			reg = <0x4805d000 0x200>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio6";
+			clocks = <&l4_root_clk_div>, <&gpio6_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -203,6 +219,8 @@
 			reg = <0x48051000 0x200>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio7";
+			clocks = <&l4_root_clk_div>, <&gpio7_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -214,6 +232,8 @@
 			reg = <0x48053000 0x200>;
 			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio8";
+			clocks = <&l4_root_clk_div>, <&gpio8_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -238,6 +258,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c1";
+			clocks = <&func_96m_fclk>;
+			clock-names = "fck";
 		};
 
 		i2c2: i2c@48072000 {
@@ -247,6 +269,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c2";
+			clocks = <&func_96m_fclk>;
+			clock-names = "fck";
 		};
 
 		i2c3: i2c@48060000 {
@@ -256,6 +280,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
+			clocks = <&func_96m_fclk>;
+			clock-names = "fck";
 		};
 
 		i2c4: i2c@4807a000 {
@@ -265,6 +291,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c4";
+			clocks = <&func_96m_fclk>;
+			clock-names = "fck";
 		};
 
 		i2c5: i2c@4807c000 {
@@ -274,6 +302,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c5";
+			clocks = <&func_96m_fclk>;
+			clock-names = "fck";
 		};
 
 		mcspi1: spi@48098000 {
@@ -283,6 +313,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi1";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			ti,spi-num-cs = <4>;
 			dmas = <&sdma 35>,
 			       <&sdma 36>,
@@ -303,6 +335,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi2";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			ti,spi-num-cs = <2>;
 			dmas = <&sdma 43>,
 			       <&sdma 44>,
@@ -318,6 +352,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi3";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			ti,spi-num-cs = <2>;
 			dmas = <&sdma 15>, <&sdma 16>;
 			dma-names = "tx0", "rx0";
@@ -330,6 +366,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi4";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			ti,spi-num-cs = <1>;
 			dmas = <&sdma 70>, <&sdma 71>;
 			dma-names = "tx0", "rx0";
@@ -340,6 +378,8 @@
 			reg = <0x4806a000 0x100>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart1";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 		};
 
@@ -348,6 +388,8 @@
 			reg = <0x4806c000 0x100>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart2";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 		};
 
@@ -356,6 +398,8 @@
 			reg = <0x48020000 0x100>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart3";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 		};
 
@@ -364,6 +408,8 @@
 			reg = <0x4806e000 0x100>;
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart4";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 		};
 
@@ -372,6 +418,8 @@
 			reg = <0x48066000 0x100>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart5";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 		};
 
@@ -380,6 +428,8 @@
 			reg = <0x48068000 0x100>;
 			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart6";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 		};
 
@@ -388,6 +438,8 @@
 			reg = <0x4809c000 0x400>;
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc1";
+			clocks = <&mmc1_fclk>, <&mmc1_32khz_clk>;
+			clock-names = "fck", "32khz_clk";
 			ti,dual-volt;
 			ti,needs-special-reset;
 			dmas = <&sdma 61>, <&sdma 62>;
@@ -399,6 +451,8 @@
 			reg = <0x480b4000 0x400>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc2";
+			clocks = <&mmc2_fclk>;
+			clock-names = "fck";
 			ti,needs-special-reset;
 			dmas = <&sdma 47>, <&sdma 48>;
 			dma-names = "tx", "rx";
@@ -409,6 +463,8 @@
 			reg = <0x480ad000 0x400>;
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc3";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			ti,needs-special-reset;
 			dmas = <&sdma 77>, <&sdma 78>;
 			dma-names = "tx", "rx";
@@ -419,6 +475,8 @@
 			reg = <0x480d1000 0x400>;
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc4";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			ti,needs-special-reset;
 			dmas = <&sdma 57>, <&sdma 58>;
 			dma-names = "tx", "rx";
@@ -429,6 +487,8 @@
 			reg = <0x480d5000 0x400>;
 			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc5";
+			clocks = <&func_96m_fclk>;
+			clock-names = "fck";
 			ti,needs-special-reset;
 			dmas = <&sdma 59>, <&sdma 60>;
 			dma-names = "tx", "rx";
@@ -438,6 +498,8 @@
 			compatible = "ti,omap4-keypad";
 			reg = <0x4ae1c000 0x400>;
 			ti,hwmods = "kbd";
+			clocks = <&sys_32k_ck>;
+			clock-names = "fck";
 		};
 
 		mcpdm: mcpdm@40132000 {
@@ -447,6 +509,8 @@
 			reg-names = "mpu", "dma";
 			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mcpdm";
+			clocks = <&pad_clks_ck>;
+			clock-names = "fck";
 			dmas = <&sdma 65>,
 			       <&sdma 66>;
 			dma-names = "up_link", "dn_link";
@@ -459,6 +523,8 @@
 			reg-names = "mpu", "dma";
 			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "dmic";
+			clocks = <&dmic_gfclk>;
+			clock-names = "fck";
 			dmas = <&sdma 67>;
 			dma-names = "up_link";
 		};
@@ -472,6 +538,8 @@
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp1";
+			clocks = <&mcbsp1_gfclk>, <&pad_clks_ck>, <&mcbsp1_sync_mux_ck>;
+			clock-names = "fck", "pad_fck", "prcm_fck";
 			dmas = <&sdma 33>,
 			       <&sdma 34>;
 			dma-names = "tx", "rx";
@@ -486,6 +554,8 @@
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp2";
+			clocks = <&mcbsp2_gfclk>, <&pad_clks_ck>, <&mcbsp2_sync_mux_ck>;
+			clock-names = "fck", "pad_fck", "prcm_fck";
 			dmas = <&sdma 17>,
 			       <&sdma 18>;
 			dma-names = "tx", "rx";
@@ -500,6 +570,8 @@
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp3";
+			clocks = <&mcbsp3_gfclk>, <&pad_clks_ck>, <&mcbsp3_sync_mux_ck>;
+			clock-names = "fck", "pad_fck", "prcm_fck";
 			dmas = <&sdma 19>,
 			       <&sdma 20>;
 			dma-names = "tx", "rx";
@@ -510,6 +582,8 @@
 			reg = <0x4ae18000 0x80>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer1";
+			clocks = <&timer1_gfclk_mux>;
+			clock-names = "fck";
 			ti,timer-alwon;
 		};
 
@@ -518,6 +592,8 @@
 			reg = <0x48032000 0x80>;
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer2";
+			clocks = <&timer2_gfclk_mux>;
+			clock-names = "fck";
 		};
 
 		timer3: timer@48034000 {
@@ -525,6 +601,8 @@
 			reg = <0x48034000 0x80>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer3";
+			clocks = <&timer3_gfclk_mux>;
+			clock-names = "fck";
 		};
 
 		timer4: timer@48036000 {
@@ -532,6 +610,8 @@
 			reg = <0x48036000 0x80>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer4";
+			clocks = <&timer4_gfclk_mux>;
+			clock-names = "fck";
 		};
 
 		timer5: timer@40138000 {
@@ -540,6 +620,8 @@
 			      <0x49038000 0x80>;
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer5";
+			clocks = <&timer5_gfclk_mux>;
+			clock-names = "fck";
 			ti,timer-dsp;
 			ti,timer-pwm;
 		};
@@ -550,6 +632,8 @@
 			      <0x4903a000 0x80>;
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer6";
+			clocks = <&timer6_gfclk_mux>;
+			clock-names = "fck";
 			ti,timer-dsp;
 			ti,timer-pwm;
 		};
@@ -560,6 +644,8 @@
 			      <0x4903c000 0x80>;
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer7";
+			clocks = <&timer7_gfclk_mux>;
+			clock-names = "fck";
 			ti,timer-dsp;
 		};
 
@@ -569,6 +655,8 @@
 			      <0x4903e000 0x80>;
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer8";
+			clocks = <&timer8_gfclk_mux>;
+			clock-names = "fck";
 			ti,timer-dsp;
 			ti,timer-pwm;
 		};
@@ -578,6 +666,8 @@
 			reg = <0x4803e000 0x80>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer9";
+			clocks = <&timer9_gfclk_mux>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -586,6 +676,8 @@
 			reg = <0x48086000 0x80>;
 			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer10";
+			clocks = <&timer10_gfclk_mux>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -594,6 +686,8 @@
 			reg = <0x48088000 0x80>;
 			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer11";
+			clocks = <&timer11_gfclk_mux>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -602,11 +696,15 @@
 			reg = <0x4ae14000 0x80>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "wd_timer2";
+			clocks = <&sys_32k_ck>;
+			clock-names = "fck";
 		};
 
 		emif1: emif@0x4c000000 {
 			compatible	= "ti,emif-4d5";
 			ti,hwmods	= "emif1";
+			clocks = <&dpll_core_h11x2_ck>;
+			clock-names = "fck";
 			phy-type	= <2>; /* DDR PHY type: Intelli PHY */
 			reg = <0x4c000000 0x400>;
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
@@ -618,6 +716,8 @@
 		emif2: emif@0x4d000000 {
 			compatible	= "ti,emif-4d5";
 			ti,hwmods	= "emif2";
+			clocks = <&dpll_core_h11x2_ck>;
+			clock-names = "fck";
 			phy-type	= <2>; /* DDR PHY type: Intelli PHY */
 			reg = <0x4d000000 0x400>;
 			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
@@ -637,6 +737,8 @@
 		omap_dwc3@4a020000 {
 			compatible = "ti,dwc3";
 			ti,hwmods = "usb_otg_ss";
+			clocks = <&dpll_core_h13x2_ck>, <&usb_otg_ss_refclk960m>;
+			clock-names = "fck", "refclk960m";
 			reg = <0x4a020000 0x1000>;
 			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 			#address-cells = <1>;
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 3c70f5c..ef50f7c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -235,7 +235,6 @@ static struct omap_hwmod omap54xx_counter_32k_hwmod = {
 	.class		= &omap54xx_counter_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE,
-	.main_clk	= "wkupaon_iclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_WKUPAON_COUNTER_32K_CLKCTRL_OFFSET,
@@ -289,7 +288,6 @@ static struct omap_hwmod omap54xx_dma_system_hwmod = {
 	.class		= &omap54xx_dma_hwmod_class,
 	.clkdm_name	= "dma_clkdm",
 	.mpu_irqs	= omap54xx_dma_system_irqs,
-	.main_clk	= "l3_iclk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_DMA_DMA_SYSTEM_CLKCTRL_OFFSET,
@@ -324,7 +322,6 @@ static struct omap_hwmod omap54xx_dmic_hwmod = {
 	.name		= "dmic",
 	.class		= &omap54xx_dmic_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "dmic_gfclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_ABE_DMIC_CLKCTRL_OFFSET,
@@ -354,7 +351,6 @@ static struct omap_hwmod omap54xx_emif1_hwmod = {
 	.class		= &omap54xx_emif_hwmod_class,
 	.clkdm_name	= "emif_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
-	.main_clk	= "dpll_core_h11x2_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_EMIF_EMIF1_CLKCTRL_OFFSET,
@@ -370,7 +366,6 @@ static struct omap_hwmod omap54xx_emif2_hwmod = {
 	.class		= &omap54xx_emif_hwmod_class,
 	.clkdm_name	= "emif_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
-	.main_clk	= "dpll_core_h11x2_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_EMIF_EMIF2_CLKCTRL_OFFSET,
@@ -410,15 +405,11 @@ static struct omap_gpio_dev_attr gpio_dev_attr = {
 };
 
 /* gpio1 */
-static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio1_dbclk" },
-};
 
 static struct omap_hwmod omap54xx_gpio1_hwmod = {
 	.name		= "gpio1",
 	.class		= &omap54xx_gpio_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
-	.main_clk	= "wkupaon_iclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_WKUPAON_GPIO1_CLKCTRL_OFFSET,
@@ -426,22 +417,16 @@ static struct omap_hwmod omap54xx_gpio1_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= gpio1_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio2 */
-static struct omap_hwmod_opt_clk gpio2_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio2_dbclk" },
-};
 
 static struct omap_hwmod omap54xx_gpio2_hwmod = {
 	.name		= "gpio2",
 	.class		= &omap54xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO2_CLKCTRL_OFFSET,
@@ -449,22 +434,16 @@ static struct omap_hwmod omap54xx_gpio2_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= gpio2_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio2_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio3 */
-static struct omap_hwmod_opt_clk gpio3_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio3_dbclk" },
-};
 
 static struct omap_hwmod omap54xx_gpio3_hwmod = {
 	.name		= "gpio3",
 	.class		= &omap54xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO3_CLKCTRL_OFFSET,
@@ -472,22 +451,16 @@ static struct omap_hwmod omap54xx_gpio3_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= gpio3_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio3_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio4 */
-static struct omap_hwmod_opt_clk gpio4_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio4_dbclk" },
-};
 
 static struct omap_hwmod omap54xx_gpio4_hwmod = {
 	.name		= "gpio4",
 	.class		= &omap54xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO4_CLKCTRL_OFFSET,
@@ -495,22 +468,16 @@ static struct omap_hwmod omap54xx_gpio4_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= gpio4_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio4_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio5 */
-static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio5_dbclk" },
-};
 
 static struct omap_hwmod omap54xx_gpio5_hwmod = {
 	.name		= "gpio5",
 	.class		= &omap54xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO5_CLKCTRL_OFFSET,
@@ -518,22 +485,16 @@ static struct omap_hwmod omap54xx_gpio5_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= gpio5_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio5_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio6 */
-static struct omap_hwmod_opt_clk gpio6_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio6_dbclk" },
-};
 
 static struct omap_hwmod omap54xx_gpio6_hwmod = {
 	.name		= "gpio6",
 	.class		= &omap54xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO6_CLKCTRL_OFFSET,
@@ -541,22 +502,16 @@ static struct omap_hwmod omap54xx_gpio6_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= gpio6_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio6_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio7 */
-static struct omap_hwmod_opt_clk gpio7_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio7_dbclk" },
-};
 
 static struct omap_hwmod omap54xx_gpio7_hwmod = {
 	.name		= "gpio7",
 	.class		= &omap54xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO7_CLKCTRL_OFFSET,
@@ -564,22 +519,16 @@ static struct omap_hwmod omap54xx_gpio7_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= gpio7_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio7_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio8 */
-static struct omap_hwmod_opt_clk gpio8_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio8_dbclk" },
-};
 
 static struct omap_hwmod omap54xx_gpio8_hwmod = {
 	.name		= "gpio8",
 	.class		= &omap54xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO8_CLKCTRL_OFFSET,
@@ -587,8 +536,6 @@ static struct omap_hwmod omap54xx_gpio8_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= gpio8_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio8_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
@@ -627,7 +574,6 @@ static struct omap_hwmod omap54xx_i2c1_hwmod = {
 	.class		= &omap54xx_i2c_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_I2C1_CLKCTRL_OFFSET,
@@ -644,7 +590,6 @@ static struct omap_hwmod omap54xx_i2c2_hwmod = {
 	.class		= &omap54xx_i2c_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_I2C2_CLKCTRL_OFFSET,
@@ -661,7 +606,6 @@ static struct omap_hwmod omap54xx_i2c3_hwmod = {
 	.class		= &omap54xx_i2c_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_I2C3_CLKCTRL_OFFSET,
@@ -678,7 +622,6 @@ static struct omap_hwmod omap54xx_i2c4_hwmod = {
 	.class		= &omap54xx_i2c_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_I2C4_CLKCTRL_OFFSET,
@@ -695,7 +638,6 @@ static struct omap_hwmod omap54xx_i2c5_hwmod = {
 	.class		= &omap54xx_i2c_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_I2C5_CLKCTRL_OFFSET,
@@ -730,7 +672,6 @@ static struct omap_hwmod omap54xx_kbd_hwmod = {
 	.name		= "kbd",
 	.class		= &omap54xx_kbd_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
-	.main_clk	= "sys_32k_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_WKUPAON_KBD_CLKCTRL_OFFSET,
@@ -760,16 +701,11 @@ static struct omap_hwmod_class omap54xx_mcbsp_hwmod_class = {
 };
 
 /* mcbsp1 */
-static struct omap_hwmod_opt_clk mcbsp1_opt_clks[] = {
-	{ .role = "pad_fck", .clk = "pad_clks_ck" },
-	{ .role = "prcm_fck", .clk = "mcbsp1_sync_mux_ck" },
-};
 
 static struct omap_hwmod omap54xx_mcbsp1_hwmod = {
 	.name		= "mcbsp1",
 	.class		= &omap54xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "mcbsp1_gfclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_ABE_MCBSP1_CLKCTRL_OFFSET,
@@ -777,21 +713,14 @@ static struct omap_hwmod omap54xx_mcbsp1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mcbsp1_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mcbsp1_opt_clks),
 };
 
 /* mcbsp2 */
-static struct omap_hwmod_opt_clk mcbsp2_opt_clks[] = {
-	{ .role = "pad_fck", .clk = "pad_clks_ck" },
-	{ .role = "prcm_fck", .clk = "mcbsp2_sync_mux_ck" },
-};
 
 static struct omap_hwmod omap54xx_mcbsp2_hwmod = {
 	.name		= "mcbsp2",
 	.class		= &omap54xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "mcbsp2_gfclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_ABE_MCBSP2_CLKCTRL_OFFSET,
@@ -799,21 +728,14 @@ static struct omap_hwmod omap54xx_mcbsp2_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mcbsp2_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mcbsp2_opt_clks),
 };
 
 /* mcbsp3 */
-static struct omap_hwmod_opt_clk mcbsp3_opt_clks[] = {
-	{ .role = "pad_fck", .clk = "pad_clks_ck" },
-	{ .role = "prcm_fck", .clk = "mcbsp3_sync_mux_ck" },
-};
 
 static struct omap_hwmod omap54xx_mcbsp3_hwmod = {
 	.name		= "mcbsp3",
 	.class		= &omap54xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "mcbsp3_gfclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_ABE_MCBSP3_CLKCTRL_OFFSET,
@@ -821,8 +743,6 @@ static struct omap_hwmod omap54xx_mcbsp3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mcbsp3_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mcbsp3_opt_clks),
 };
 
 /*
@@ -864,7 +784,6 @@ static struct omap_hwmod omap54xx_mcpdm_hwmod = {
 	 */
 
 	.flags		= HWMOD_EXT_OPT_MAIN_CLK,
-	.main_clk	= "pad_clks_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_ABE_MCPDM_CLKCTRL_OFFSET,
@@ -906,7 +825,6 @@ static struct omap_hwmod omap54xx_mcspi1_hwmod = {
 	.name		= "mcspi1",
 	.class		= &omap54xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_MCSPI1_CLKCTRL_OFFSET,
@@ -927,7 +845,6 @@ static struct omap_hwmod omap54xx_mcspi2_hwmod = {
 	.name		= "mcspi2",
 	.class		= &omap54xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_MCSPI2_CLKCTRL_OFFSET,
@@ -948,7 +865,6 @@ static struct omap_hwmod omap54xx_mcspi3_hwmod = {
 	.name		= "mcspi3",
 	.class		= &omap54xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_MCSPI3_CLKCTRL_OFFSET,
@@ -969,7 +885,6 @@ static struct omap_hwmod omap54xx_mcspi4_hwmod = {
 	.name		= "mcspi4",
 	.class		= &omap54xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_MCSPI4_CLKCTRL_OFFSET,
@@ -1003,9 +918,6 @@ static struct omap_hwmod_class omap54xx_mmc_hwmod_class = {
 };
 
 /* mmc1 */
-static struct omap_hwmod_opt_clk mmc1_opt_clks[] = {
-	{ .role = "32khz_clk", .clk = "mmc1_32khz_clk" },
-};
 
 /* mmc1 dev_attr */
 static struct omap_mmc_dev_attr mmc1_dev_attr = {
@@ -1016,7 +928,6 @@ static struct omap_hwmod omap54xx_mmc1_hwmod = {
 	.name		= "mmc1",
 	.class		= &omap54xx_mmc_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "mmc1_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L3INIT_MMC1_CLKCTRL_OFFSET,
@@ -1024,8 +935,6 @@ static struct omap_hwmod omap54xx_mmc1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mmc1_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mmc1_opt_clks),
 	.dev_attr	= &mmc1_dev_attr,
 };
 
@@ -1034,7 +943,6 @@ static struct omap_hwmod omap54xx_mmc2_hwmod = {
 	.name		= "mmc2",
 	.class		= &omap54xx_mmc_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "mmc2_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L3INIT_MMC2_CLKCTRL_OFFSET,
@@ -1049,7 +957,6 @@ static struct omap_hwmod omap54xx_mmc3_hwmod = {
 	.name		= "mmc3",
 	.class		= &omap54xx_mmc_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_MMC3_CLKCTRL_OFFSET,
@@ -1064,7 +971,6 @@ static struct omap_hwmod omap54xx_mmc4_hwmod = {
 	.name		= "mmc4",
 	.class		= &omap54xx_mmc_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_MMC4_CLKCTRL_OFFSET,
@@ -1079,7 +985,6 @@ static struct omap_hwmod omap54xx_mmc5_hwmod = {
 	.name		= "mmc5",
 	.class		= &omap54xx_mmc_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_MMC5_CLKCTRL_OFFSET,
@@ -1155,7 +1060,6 @@ static struct omap_hwmod omap54xx_timer1_hwmod = {
 	.name		= "timer1",
 	.class		= &omap54xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
-	.main_clk	= "timer1_gfclk_mux",
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 	.prcm = {
 		.omap4 = {
@@ -1171,7 +1075,6 @@ static struct omap_hwmod omap54xx_timer2_hwmod = {
 	.name		= "timer2",
 	.class		= &omap54xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer2_gfclk_mux",
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 	.prcm = {
 		.omap4 = {
@@ -1187,7 +1090,6 @@ static struct omap_hwmod omap54xx_timer3_hwmod = {
 	.name		= "timer3",
 	.class		= &omap54xx_timer_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer3_gfclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_TIMER3_CLKCTRL_OFFSET,
@@ -1202,7 +1104,6 @@ static struct omap_hwmod omap54xx_timer4_hwmod = {
 	.name		= "timer4",
 	.class		= &omap54xx_timer_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer4_gfclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_TIMER4_CLKCTRL_OFFSET,
@@ -1217,7 +1118,6 @@ static struct omap_hwmod omap54xx_timer5_hwmod = {
 	.name		= "timer5",
 	.class		= &omap54xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "timer5_gfclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_ABE_TIMER5_CLKCTRL_OFFSET,
@@ -1232,7 +1132,6 @@ static struct omap_hwmod omap54xx_timer6_hwmod = {
 	.name		= "timer6",
 	.class		= &omap54xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "timer6_gfclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_ABE_TIMER6_CLKCTRL_OFFSET,
@@ -1247,7 +1146,6 @@ static struct omap_hwmod omap54xx_timer7_hwmod = {
 	.name		= "timer7",
 	.class		= &omap54xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "timer7_gfclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_ABE_TIMER7_CLKCTRL_OFFSET,
@@ -1262,7 +1160,6 @@ static struct omap_hwmod omap54xx_timer8_hwmod = {
 	.name		= "timer8",
 	.class		= &omap54xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "timer8_gfclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_ABE_TIMER8_CLKCTRL_OFFSET,
@@ -1277,7 +1174,6 @@ static struct omap_hwmod omap54xx_timer9_hwmod = {
 	.name		= "timer9",
 	.class		= &omap54xx_timer_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer9_gfclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_TIMER9_CLKCTRL_OFFSET,
@@ -1292,7 +1188,6 @@ static struct omap_hwmod omap54xx_timer10_hwmod = {
 	.name		= "timer10",
 	.class		= &omap54xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer10_gfclk_mux",
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 	.prcm = {
 		.omap4 = {
@@ -1308,7 +1203,6 @@ static struct omap_hwmod omap54xx_timer11_hwmod = {
 	.name		= "timer11",
 	.class		= &omap54xx_timer_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer11_gfclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_TIMER11_CLKCTRL_OFFSET,
@@ -1345,7 +1239,6 @@ static struct omap_hwmod omap54xx_uart1_hwmod = {
 	.name		= "uart1",
 	.class		= &omap54xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_UART1_CLKCTRL_OFFSET,
@@ -1360,7 +1253,6 @@ static struct omap_hwmod omap54xx_uart2_hwmod = {
 	.name		= "uart2",
 	.class		= &omap54xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_UART2_CLKCTRL_OFFSET,
@@ -1376,7 +1268,6 @@ static struct omap_hwmod omap54xx_uart3_hwmod = {
 	.class		= &omap54xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= DEBUG_OMAP4UART3_FLAGS,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_UART3_CLKCTRL_OFFSET,
@@ -1392,7 +1283,6 @@ static struct omap_hwmod omap54xx_uart4_hwmod = {
 	.class		= &omap54xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= DEBUG_OMAP4UART4_FLAGS,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_UART4_CLKCTRL_OFFSET,
@@ -1407,7 +1297,6 @@ static struct omap_hwmod omap54xx_uart5_hwmod = {
 	.name		= "uart5",
 	.class		= &omap54xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_UART5_CLKCTRL_OFFSET,
@@ -1422,7 +1311,6 @@ static struct omap_hwmod omap54xx_uart6_hwmod = {
 	.name		= "uart6",
 	.class		= &omap54xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L4PER_UART6_CLKCTRL_OFFSET,
@@ -1454,16 +1342,12 @@ static struct omap_hwmod_class omap54xx_usb_otg_ss_hwmod_class = {
 };
 
 /* usb_otg_ss */
-static struct omap_hwmod_opt_clk usb_otg_ss_opt_clks[] = {
-	{ .role = "refclk960m", .clk = "usb_otg_ss_refclk960m" },
-};
 
 static struct omap_hwmod omap54xx_usb_otg_ss_hwmod = {
 	.name		= "usb_otg_ss",
 	.class		= &omap54xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE,
-	.main_clk	= "dpll_core_h13x2_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_L3INIT_USB_OTG_SS_CLKCTRL_OFFSET,
@@ -1471,8 +1355,6 @@ static struct omap_hwmod omap54xx_usb_otg_ss_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= usb_otg_ss_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(usb_otg_ss_opt_clks),
 };
 
 /*
@@ -1503,7 +1385,6 @@ static struct omap_hwmod omap54xx_wd_timer2_hwmod = {
 	.name		= "wd_timer2",
 	.class		= &omap54xx_wd_timer_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
-	.main_clk	= "sys_32k_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP54XX_CM_WKUPAON_WD_TIMER2_CLKCTRL_OFFSET,
-- 
1.7.9.5

