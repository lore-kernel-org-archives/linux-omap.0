From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 45/45] ARM: dts: dra7: Add main and optional clock data into DT
Date: Thu, 29 Aug 2013 16:16:37 +0300
Message-ID: <1377782197-10611-46-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49187 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755039Ab3H2NTO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:19:14 -0400
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
 arch/arm/boot/dts/dra7.dtsi               |   82 +++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  101 -----------------------------
 2 files changed, 82 insertions(+), 101 deletions(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index c98997b..d9d910f 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -97,6 +97,8 @@
 			compatible = "ti,omap-counter32k";
 			reg = <0x4ae04000 0x40>;
 			ti,hwmods = "counter_32k";
+			clocks = <&wkupaon_iclk_mux>;
+			clock-names = "fck";
 		};
 
 		dra7_pmx_core: pinmux@4a003400 {
@@ -118,6 +120,8 @@
 			#dma-cells = <1>;
 			#dma-channels = <32>;
 			#dma-requests = <127>;
+			clocks = <&l3_iclk_div>;
+			clock-names = "fck";
 		};
 
 		gpio1: gpio@4ae10000 {
@@ -125,6 +129,8 @@
 			reg = <0x4ae10000 0x200>;
 			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio1";
+			clocks = <&wkupaon_iclk_mux>, <&gpio1_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -136,6 +142,8 @@
 			reg = <0x48055000 0x200>;
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio2";
+			clocks = <&l3_iclk_div>, <&gpio2_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -147,6 +155,8 @@
 			reg = <0x48057000 0x200>;
 			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio3";
+			clocks = <&l3_iclk_div>, <&gpio3_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -158,6 +168,8 @@
 			reg = <0x48059000 0x200>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio4";
+			clocks = <&l3_iclk_div>, <&gpio4_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -169,6 +181,8 @@
 			reg = <0x4805b000 0x200>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio5";
+			clocks = <&l3_iclk_div>, <&gpio5_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -180,6 +194,8 @@
 			reg = <0x4805d000 0x200>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio6";
+			clocks = <&l3_iclk_div>, <&gpio6_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -191,6 +207,8 @@
 			reg = <0x48051000 0x200>;
 			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio7";
+			clocks = <&l3_iclk_div>, <&gpio7_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -202,6 +220,8 @@
 			reg = <0x48053000 0x200>;
 			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio8";
+			clocks = <&l3_iclk_div>, <&gpio8_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -213,6 +233,8 @@
 			reg = <0x4806a000 0x100>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart1";
+			clocks = <&uart1_gfclk_mux>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 			status = "disabled";
 		};
@@ -222,6 +244,8 @@
 			reg = <0x4806c000 0x100>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart2";
+			clocks = <&uart2_gfclk_mux>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 			status = "disabled";
 		};
@@ -231,6 +255,8 @@
 			reg = <0x48020000 0x100>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart3";
+			clocks = <&uart3_gfclk_mux>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 			status = "disabled";
 		};
@@ -240,6 +266,8 @@
 			reg = <0x4806e000 0x100>;
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart4";
+			clocks = <&uart4_gfclk_mux>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
                         status = "disabled";
 		};
@@ -249,6 +277,8 @@
 			reg = <0x48066000 0x100>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart5";
+			clocks = <&uart5_gfclk_mux>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 			status = "disabled";
 		};
@@ -258,6 +288,8 @@
 			reg = <0x48068000 0x100>;
 			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart6";
+			clocks = <&uart6_gfclk_mux>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 			status = "disabled";
 		};
@@ -299,6 +331,8 @@
 			reg = <0x4ae18000 0x80>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer1";
+			clocks = <&timer1_gfclk_mux>;
+			clock-names = "fck";
 			ti,timer-alwon;
 		};
 
@@ -307,6 +341,8 @@
 			reg = <0x48032000 0x80>;
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer2";
+			clocks = <&timer2_gfclk_mux>;
+			clock-names = "fck";
 		};
 
 		timer3: timer@48034000 {
@@ -314,6 +350,8 @@
 			reg = <0x48034000 0x80>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer3";
+			clocks = <&timer3_gfclk_mux>;
+			clock-names = "fck";
 		};
 
 		timer4: timer@48036000 {
@@ -321,6 +359,8 @@
 			reg = <0x48036000 0x80>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer4";
+			clocks = <&timer4_gfclk_mux>;
+			clock-names = "fck";
 		};
 
 		timer5: timer@48820000 {
@@ -328,6 +368,8 @@
 			reg = <0x48820000 0x80>;
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer5";
+			clocks = <&timer5_gfclk_mux>;
+			clock-names = "fck";
 			ti,timer-dsp;
 		};
 
@@ -336,6 +378,8 @@
 			reg = <0x48822000 0x80>;
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer6";
+			clocks = <&timer6_gfclk_mux>;
+			clock-names = "fck";
 			ti,timer-dsp;
 			ti,timer-pwm;
 		};
@@ -345,6 +389,8 @@
 			reg = <0x48824000 0x80>;
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer7";
+			clocks = <&timer7_gfclk_mux>;
+			clock-names = "fck";
 			ti,timer-dsp;
 		};
 
@@ -353,6 +399,8 @@
 			reg = <0x48826000 0x80>;
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer8";
+			clocks = <&timer8_gfclk_mux>;
+			clock-names = "fck";
 			ti,timer-dsp;
 			ti,timer-pwm;
 		};
@@ -362,6 +410,8 @@
 			reg = <0x4803e000 0x80>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer9";
+			clocks = <&timer9_gfclk_mux>;
+			clock-names = "fck";
 		};
 
 		timer10: timer@48086000 {
@@ -369,6 +419,8 @@
 			reg = <0x48086000 0x80>;
 			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer10";
+			clocks = <&timer10_gfclk_mux>;
+			clock-names = "fck";
 		};
 
 		timer11: timer@48088000 {
@@ -376,6 +428,8 @@
 			reg = <0x48088000 0x80>;
 			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer11";
+			clocks = <&timer11_gfclk_mux>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -412,6 +466,8 @@
 			reg = <0x4ae14000 0x80>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "wd_timer2";
+			clocks = <&sys_32k_ck>;
+			clock-names = "fck";
 		};
 
 		i2c1: i2c@48070000 {
@@ -421,6 +477,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c1";
+			clocks = <&func_96m_fclk>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -431,6 +489,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c2";
+			clocks = <&func_96m_fclk>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -441,6 +501,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
+			clocks = <&func_96m_fclk>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -451,6 +513,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c4";
+			clocks = <&func_96m_fclk>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -461,6 +525,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c5";
+			clocks = <&func_96m_fclk>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -469,6 +535,8 @@
 			reg = <0x4809c000 0x400>;
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc1";
+			clocks = <&mmc1_fclk_div>, <&mmc1_clk32k>;
+			clock-names = "fck", "clk32k";
 			ti,dual-volt;
 			ti,needs-special-reset;
 			dmas = <&sdma 61>, <&sdma 62>;
@@ -481,6 +549,8 @@
 			reg = <0x480b4000 0x400>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc2";
+			clocks = <&mmc2_fclk_div>, <&mmc2_clk32k>;
+			clock-names = "fck", "clk32k";
 			ti,needs-special-reset;
 			dmas = <&sdma 47>, <&sdma 48>;
 			dma-names = "tx", "rx";
@@ -492,6 +562,8 @@
 			reg = <0x480ad000 0x400>;
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc3";
+			clocks = <&mmc3_gfclk_div>, <&mmc3_clk32k>;
+			clock-names = "fck", "clk32k";
 			ti,needs-special-reset;
 			dmas = <&sdma 77>, <&sdma 78>;
 			dma-names = "tx", "rx";
@@ -503,6 +575,8 @@
 			reg = <0x480d1000 0x400>;
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc4";
+			clocks = <&mmc4_gfclk_div>, <&mmc4_clk32k>;
+			clock-names = "fck", "clk32k";
 			ti,needs-special-reset;
 			dmas = <&sdma 57>, <&sdma 58>;
 			dma-names = "tx", "rx";
@@ -516,6 +590,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi1";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			ti,spi-num-cs = <4>;
 			dmas = <&sdma 35>,
 			       <&sdma 36>,
@@ -537,6 +613,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi2";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			ti,spi-num-cs = <2>;
 			dmas = <&sdma 43>,
 			       <&sdma 44>,
@@ -553,6 +631,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi3";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			ti,spi-num-cs = <2>;
 			dmas = <&sdma 15>, <&sdma 16>;
 			dma-names = "tx0", "rx0";
@@ -566,6 +646,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi4";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			ti,spi-num-cs = <1>;
 			dmas = <&sdma 70>, <&sdma 71>;
 			dma-names = "tx0", "rx0";
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index db32d53..2b20140 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -242,7 +242,6 @@ static struct omap_hwmod dra7xx_counter_32k_hwmod = {
 	.class		= &dra7xx_counter_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE,
-	.main_clk	= "wkupaon_iclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_WKUPAON_COUNTER_32K_CLKCTRL_OFFSET,
@@ -356,7 +355,6 @@ static struct omap_hwmod dra7xx_dma_system_hwmod = {
 	.class		= &dra7xx_dma_hwmod_class,
 	.clkdm_name	= "dma_clkdm",
 	.mpu_irqs	= dra7xx_dma_system_irqs,
-	.main_clk	= "l3_iclk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_DMA_DMA_SYSTEM_CLKCTRL_OFFSET,
@@ -568,15 +566,11 @@ static struct omap_gpio_dev_attr gpio_dev_attr = {
 };
 
 /* gpio1 */
-static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio1_dbclk" },
-};
 
 static struct omap_hwmod dra7xx_gpio1_hwmod = {
 	.name		= "gpio1",
 	.class		= &dra7xx_gpio_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
-	.main_clk	= "wkupaon_iclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_WKUPAON_GPIO1_CLKCTRL_OFFSET,
@@ -584,22 +578,16 @@ static struct omap_hwmod dra7xx_gpio1_hwmod = {
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
 
 static struct omap_hwmod dra7xx_gpio2_hwmod = {
 	.name		= "gpio2",
 	.class		= &dra7xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO2_CLKCTRL_OFFSET,
@@ -607,22 +595,16 @@ static struct omap_hwmod dra7xx_gpio2_hwmod = {
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
 
 static struct omap_hwmod dra7xx_gpio3_hwmod = {
 	.name		= "gpio3",
 	.class		= &dra7xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO3_CLKCTRL_OFFSET,
@@ -630,22 +612,16 @@ static struct omap_hwmod dra7xx_gpio3_hwmod = {
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
 
 static struct omap_hwmod dra7xx_gpio4_hwmod = {
 	.name		= "gpio4",
 	.class		= &dra7xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO4_CLKCTRL_OFFSET,
@@ -653,22 +629,16 @@ static struct omap_hwmod dra7xx_gpio4_hwmod = {
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
 
 static struct omap_hwmod dra7xx_gpio5_hwmod = {
 	.name		= "gpio5",
 	.class		= &dra7xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO5_CLKCTRL_OFFSET,
@@ -676,22 +646,16 @@ static struct omap_hwmod dra7xx_gpio5_hwmod = {
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
 
 static struct omap_hwmod dra7xx_gpio6_hwmod = {
 	.name		= "gpio6",
 	.class		= &dra7xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO6_CLKCTRL_OFFSET,
@@ -699,22 +663,16 @@ static struct omap_hwmod dra7xx_gpio6_hwmod = {
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
 
 static struct omap_hwmod dra7xx_gpio7_hwmod = {
 	.name		= "gpio7",
 	.class		= &dra7xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO7_CLKCTRL_OFFSET,
@@ -722,22 +680,16 @@ static struct omap_hwmod dra7xx_gpio7_hwmod = {
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
 
 static struct omap_hwmod dra7xx_gpio8_hwmod = {
 	.name		= "gpio8",
 	.class		= &dra7xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO8_CLKCTRL_OFFSET,
@@ -745,8 +697,6 @@ static struct omap_hwmod dra7xx_gpio8_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= gpio8_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio8_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
@@ -859,7 +809,6 @@ static struct omap_hwmod dra7xx_i2c1_hwmod = {
 	.class		= &dra7xx_i2c_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_I2C1_CLKCTRL_OFFSET,
@@ -876,7 +825,6 @@ static struct omap_hwmod dra7xx_i2c2_hwmod = {
 	.class		= &dra7xx_i2c_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_I2C2_CLKCTRL_OFFSET,
@@ -893,7 +841,6 @@ static struct omap_hwmod dra7xx_i2c3_hwmod = {
 	.class		= &dra7xx_i2c_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_I2C3_CLKCTRL_OFFSET,
@@ -910,7 +857,6 @@ static struct omap_hwmod dra7xx_i2c4_hwmod = {
 	.class		= &dra7xx_i2c_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_I2C4_CLKCTRL_OFFSET,
@@ -927,7 +873,6 @@ static struct omap_hwmod dra7xx_i2c5_hwmod = {
 	.class		= &dra7xx_i2c_hwmod_class,
 	.clkdm_name	= "ipu_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_IPU_I2C5_CLKCTRL_OFFSET,
@@ -969,7 +914,6 @@ static struct omap_hwmod dra7xx_mcspi1_hwmod = {
 	.name		= "mcspi1",
 	.class		= &dra7xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_MCSPI1_CLKCTRL_OFFSET,
@@ -990,7 +934,6 @@ static struct omap_hwmod dra7xx_mcspi2_hwmod = {
 	.name		= "mcspi2",
 	.class		= &dra7xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_MCSPI2_CLKCTRL_OFFSET,
@@ -1011,7 +954,6 @@ static struct omap_hwmod dra7xx_mcspi3_hwmod = {
 	.name		= "mcspi3",
 	.class		= &dra7xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_MCSPI3_CLKCTRL_OFFSET,
@@ -1032,7 +974,6 @@ static struct omap_hwmod dra7xx_mcspi4_hwmod = {
 	.name		= "mcspi4",
 	.class		= &dra7xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_MCSPI4_CLKCTRL_OFFSET,
@@ -1066,9 +1007,6 @@ static struct omap_hwmod_class dra7xx_mmc_hwmod_class = {
 };
 
 /* mmc1 */
-static struct omap_hwmod_opt_clk mmc1_opt_clks[] = {
-	{ .role = "clk32k", .clk = "mmc1_clk32k" },
-};
 
 /* mmc1 dev_attr */
 static struct omap_mmc_dev_attr mmc1_dev_attr = {
@@ -1079,7 +1017,6 @@ static struct omap_hwmod dra7xx_mmc1_hwmod = {
 	.name		= "mmc1",
 	.class		= &dra7xx_mmc_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "mmc1_fclk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L3INIT_MMC1_CLKCTRL_OFFSET,
@@ -1087,21 +1024,15 @@ static struct omap_hwmod dra7xx_mmc1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mmc1_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mmc1_opt_clks),
 	.dev_attr	= &mmc1_dev_attr,
 };
 
 /* mmc2 */
-static struct omap_hwmod_opt_clk mmc2_opt_clks[] = {
-	{ .role = "clk32k", .clk = "mmc2_clk32k" },
-};
 
 static struct omap_hwmod dra7xx_mmc2_hwmod = {
 	.name		= "mmc2",
 	.class		= &dra7xx_mmc_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "mmc2_fclk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L3INIT_MMC2_CLKCTRL_OFFSET,
@@ -1109,20 +1040,14 @@ static struct omap_hwmod dra7xx_mmc2_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mmc2_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mmc2_opt_clks),
 };
 
 /* mmc3 */
-static struct omap_hwmod_opt_clk mmc3_opt_clks[] = {
-	{ .role = "clk32k", .clk = "mmc3_clk32k" },
-};
 
 static struct omap_hwmod dra7xx_mmc3_hwmod = {
 	.name		= "mmc3",
 	.class		= &dra7xx_mmc_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "mmc3_gfclk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_MMC3_CLKCTRL_OFFSET,
@@ -1130,20 +1055,14 @@ static struct omap_hwmod dra7xx_mmc3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mmc3_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mmc3_opt_clks),
 };
 
 /* mmc4 */
-static struct omap_hwmod_opt_clk mmc4_opt_clks[] = {
-	{ .role = "clk32k", .clk = "mmc4_clk32k" },
-};
 
 static struct omap_hwmod dra7xx_mmc4_hwmod = {
 	.name		= "mmc4",
 	.class		= &dra7xx_mmc_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "mmc4_gfclk_div",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_MMC4_CLKCTRL_OFFSET,
@@ -1151,8 +1070,6 @@ static struct omap_hwmod dra7xx_mmc4_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mmc4_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mmc4_opt_clks),
 };
 
 /*
@@ -1449,7 +1366,6 @@ static struct omap_hwmod dra7xx_timer1_hwmod = {
 	.name		= "timer1",
 	.class		= &dra7xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
-	.main_clk	= "timer1_gfclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_WKUPAON_TIMER1_CLKCTRL_OFFSET,
@@ -1464,7 +1380,6 @@ static struct omap_hwmod dra7xx_timer2_hwmod = {
 	.name		= "timer2",
 	.class		= &dra7xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer2_gfclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_TIMER2_CLKCTRL_OFFSET,
@@ -1479,7 +1394,6 @@ static struct omap_hwmod dra7xx_timer3_hwmod = {
 	.name		= "timer3",
 	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer3_gfclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_TIMER3_CLKCTRL_OFFSET,
@@ -1494,7 +1408,6 @@ static struct omap_hwmod dra7xx_timer4_hwmod = {
 	.name		= "timer4",
 	.class		= &dra7xx_timer_secure_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer4_gfclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_TIMER4_CLKCTRL_OFFSET,
@@ -1509,7 +1422,6 @@ static struct omap_hwmod dra7xx_timer5_hwmod = {
 	.name		= "timer5",
 	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "ipu_clkdm",
-	.main_clk	= "timer5_gfclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_IPU_TIMER5_CLKCTRL_OFFSET,
@@ -1524,7 +1436,6 @@ static struct omap_hwmod dra7xx_timer6_hwmod = {
 	.name		= "timer6",
 	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "ipu_clkdm",
-	.main_clk	= "timer6_gfclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_IPU_TIMER6_CLKCTRL_OFFSET,
@@ -1539,7 +1450,6 @@ static struct omap_hwmod dra7xx_timer7_hwmod = {
 	.name		= "timer7",
 	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "ipu_clkdm",
-	.main_clk	= "timer7_gfclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_IPU_TIMER7_CLKCTRL_OFFSET,
@@ -1554,7 +1464,6 @@ static struct omap_hwmod dra7xx_timer8_hwmod = {
 	.name		= "timer8",
 	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "ipu_clkdm",
-	.main_clk	= "timer8_gfclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_IPU_TIMER8_CLKCTRL_OFFSET,
@@ -1569,7 +1478,6 @@ static struct omap_hwmod dra7xx_timer9_hwmod = {
 	.name		= "timer9",
 	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer9_gfclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_TIMER9_CLKCTRL_OFFSET,
@@ -1584,7 +1492,6 @@ static struct omap_hwmod dra7xx_timer10_hwmod = {
 	.name		= "timer10",
 	.class		= &dra7xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer10_gfclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_TIMER10_CLKCTRL_OFFSET,
@@ -1599,7 +1506,6 @@ static struct omap_hwmod dra7xx_timer11_hwmod = {
 	.name		= "timer11",
 	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer11_gfclk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER_TIMER11_CLKCTRL_OFFSET,
@@ -1636,7 +1542,6 @@ static struct omap_hwmod dra7xx_uart1_hwmod = {
 	.name		= "uart1",
 	.class		= &dra7xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "uart1_gfclk_mux",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm = {
 		.omap4 = {
@@ -1652,7 +1557,6 @@ static struct omap_hwmod dra7xx_uart2_hwmod = {
 	.name		= "uart2",
 	.class		= &dra7xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "uart2_gfclk_mux",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm = {
 		.omap4 = {
@@ -1668,7 +1572,6 @@ static struct omap_hwmod dra7xx_uart3_hwmod = {
 	.name		= "uart3",
 	.class		= &dra7xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "uart3_gfclk_mux",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm = {
 		.omap4 = {
@@ -1684,7 +1587,6 @@ static struct omap_hwmod dra7xx_uart4_hwmod = {
 	.name		= "uart4",
 	.class		= &dra7xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "uart4_gfclk_mux",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm = {
 		.omap4 = {
@@ -1700,7 +1602,6 @@ static struct omap_hwmod dra7xx_uart5_hwmod = {
 	.name		= "uart5",
 	.class		= &dra7xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "uart5_gfclk_mux",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm = {
 		.omap4 = {
@@ -1716,7 +1617,6 @@ static struct omap_hwmod dra7xx_uart6_hwmod = {
 	.name		= "uart6",
 	.class		= &dra7xx_uart_hwmod_class,
 	.clkdm_name	= "ipu_clkdm",
-	.main_clk	= "uart6_gfclk_mux",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm = {
 		.omap4 = {
@@ -1873,7 +1773,6 @@ static struct omap_hwmod dra7xx_wd_timer2_hwmod = {
 	.name		= "wd_timer2",
 	.class		= &dra7xx_wd_timer_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
-	.main_clk	= "sys_32k_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_WKUPAON_WD_TIMER2_CLKCTRL_OFFSET,
-- 
1.7.9.5

