From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 3/3] ARM: OMAP4: dts: Add main and optional clock data into DT
Date: Tue, 23 Jul 2013 11:54:39 +0530
Message-ID: <1374560679-14666-4-git-send-email-rnayak@ti.com>
References: <1374560679-14666-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43967 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab3GWGZ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jul 2013 02:25:28 -0400
In-Reply-To: <1374560679-14666-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, t-kristo@ti.com, benoit.cousson@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

With support to parse clock data from DT, move all main and optional
clock information from hwmod to DT.

We still retain clocks in hwmod for devices which do not have a DT node.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi               |  100 +++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  112 ----------------------------
 2 files changed, 100 insertions(+), 112 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 8e142f9..4dddf64 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -106,6 +106,8 @@
 			compatible = "ti,omap-counter32k";
 			reg = <0x4a304000 0x20>;
 			ti,hwmods = "counter_32k";
+			clocks = <&sys_32k_ck>;
+			clock-names = "fck";
 		};
 
 		omap4_pmx_core: pinmux@4a100040 {
@@ -135,6 +137,8 @@
 			#dma-cells = <1>;
 			#dma-channels = <32>;
 			#dma-requests = <127>;
+			clocks = <&l3_div_ck>;
+			clock-names = "fck";
 		};
 
 		gpio1: gpio@4a310000 {
@@ -147,6 +151,8 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&l4_wkup_clk_mux_ck>, <&gpio1_dbclk>;
+			clock-names = "fck", "dbclk";
 		};
 
 		gpio2: gpio@48055000 {
@@ -158,6 +164,8 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&l4_div_ck>, <&gpio2_dbclk>;
+			clock-names = "fck", "dbclk";
 		};
 
 		gpio3: gpio@48057000 {
@@ -169,6 +177,8 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&l4_div_ck>, <&gpio3_dbclk>;
+			clock-names = "fck", "dbclk";
 		};
 
 		gpio4: gpio@48059000 {
@@ -180,6 +190,8 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&l4_div_ck>, <&gpio4_dbclk>;
+			clock-names = "fck", "dbclk";
 		};
 
 		gpio5: gpio@4805b000 {
@@ -191,6 +203,8 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&l4_div_ck>, <&gpio5_dbclk>;
+			clock-names = "fck", "dbclk";
 		};
 
 		gpio6: gpio@4805d000 {
@@ -202,6 +216,8 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&l4_div_ck>, <&gpio6_dbclk>;
+			clock-names = "fck", "dbclk";
 		};
 
 		gpmc: gpmc@50000000 {
@@ -221,6 +237,8 @@
 			interrupts = <0 72 0x4>;
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 		};
 
 		uart2: serial@4806c000 {
@@ -229,6 +247,8 @@
 			interrupts = <0 73 0x4>;
 			ti,hwmods = "uart2";
 			clock-frequency = <48000000>;
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 		};
 
 		uart3: serial@48020000 {
@@ -237,6 +257,8 @@
 			interrupts = <0 74 0x4>;
 			ti,hwmods = "uart3";
 			clock-frequency = <48000000>;
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 		};
 
 		uart4: serial@4806e000 {
@@ -245,6 +267,8 @@
 			interrupts = <0 70 0x4>;
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 		};
 
 		i2c1: i2c@48070000 {
@@ -254,6 +278,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c1";
+			clocks = <&func_96m_fclk>;
+			clock-names = "fck";
 		};
 
 		i2c2: i2c@48072000 {
@@ -263,6 +289,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c2";
+			clocks = <&func_96m_fclk>;
+			clock-names = "fck";
 		};
 
 		i2c3: i2c@48060000 {
@@ -272,6 +300,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
+			clocks = <&func_96m_fclk>;
+			clock-names = "fck";
 		};
 
 		i2c4: i2c@48350000 {
@@ -281,6 +311,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c4";
+			clocks = <&func_96m_fclk>;
+			clock-names = "fck";
 		};
 
 		mcspi1: spi@48098000 {
@@ -301,6 +333,8 @@
 			       <&sdma 42>;
 			dma-names = "tx0", "rx0", "tx1", "rx1",
 				    "tx2", "rx2", "tx3", "rx3";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 		};
 
 		mcspi2: spi@4809a000 {
@@ -316,6 +350,8 @@
 			       <&sdma 45>,
 			       <&sdma 46>;
 			dma-names = "tx0", "rx0", "tx1", "rx1";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 		};
 
 		mcspi3: spi@480b8000 {
@@ -328,6 +364,8 @@
 			ti,spi-num-cs = <2>;
 			dmas = <&sdma 15>, <&sdma 16>;
 			dma-names = "tx0", "rx0";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 		};
 
 		mcspi4: spi@480ba000 {
@@ -340,6 +378,8 @@
 			ti,spi-num-cs = <1>;
 			dmas = <&sdma 70>, <&sdma 71>;
 			dma-names = "tx0", "rx0";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 		};
 
 		mmc1: mmc@4809c000 {
@@ -351,6 +391,8 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 61>, <&sdma 62>;
 			dma-names = "tx", "rx";
+			clocks = <&hsmmc1_fclk>;
+			clock-names = "fck";
 		};
 
 		mmc2: mmc@480b4000 {
@@ -361,6 +403,8 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 47>, <&sdma 48>;
 			dma-names = "tx", "rx";
+			clocks = <&hsmmc2_fclk>;
+			clock-names = "fck";
 		};
 
 		mmc3: mmc@480ad000 {
@@ -371,6 +415,8 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 77>, <&sdma 78>;
 			dma-names = "tx", "rx";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 		};
 
 		mmc4: mmc@480d1000 {
@@ -381,6 +427,8 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 57>, <&sdma 58>;
 			dma-names = "tx", "rx";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 		};
 
 		mmc5: mmc@480d5000 {
@@ -391,6 +439,8 @@
 			ti,needs-special-reset;
 			dmas = <&sdma 59>, <&sdma 60>;
 			dma-names = "tx", "rx";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 		};
 
 		wdt2: wdt@4a314000 {
@@ -398,6 +448,8 @@
 			reg = <0x4a314000 0x80>;
 			interrupts = <0 80 0x4>;
 			ti,hwmods = "wd_timer2";
+			clocks = <&sys_32k_ck>;
+			clock-names = "fck";
 		};
 
 		mcpdm: mcpdm@40132000 {
@@ -410,6 +462,8 @@
 			dmas = <&sdma 65>,
 			       <&sdma 66>;
 			dma-names = "up_link", "dn_link";
+			clocks = <&pad_clks_ck>;
+			clock-names = "fck";
 		};
 
 		dmic: dmic@4012e000 {
@@ -421,6 +475,8 @@
 			ti,hwmods = "dmic";
 			dmas = <&sdma 67>;
 			dma-names = "up_link";
+			clocks = <&func_dmic_abe_gfclk>;
+			clock-names = "fck";
 		};
 
 		mcbsp1: mcbsp@40122000 {
@@ -435,6 +491,8 @@
 			dmas = <&sdma 33>,
 			       <&sdma 34>;
 			dma-names = "tx", "rx";
+			clocks = <&func_mcbsp1_gfclk>, <&pad_clks_ck>, <&mcbsp1_sync_mux_ck>;
+			clock-names = "fck", "pad_fck", "prcm_fck";
 		};
 
 		mcbsp2: mcbsp@40124000 {
@@ -449,6 +507,8 @@
 			dmas = <&sdma 17>,
 			       <&sdma 18>;
 			dma-names = "tx", "rx";
+			clocks = <&func_mcbsp2_gfclk>, <&pad_clks_ck>, <&mcbsp2_sync_mux_ck>;
+			clock-names = "fck", "pad_fck", "prcm_fck";
 		};
 
 		mcbsp3: mcbsp@40126000 {
@@ -463,6 +523,8 @@
 			dmas = <&sdma 19>,
 			       <&sdma 20>;
 			dma-names = "tx", "rx";
+			clocks = <&func_mcbsp3_gfclk>, <&pad_clks_ck>, <&mcbsp3_sync_mux_ck>;
+			clock-names = "fck", "pad_fck", "prcm_fck";
 		};
 
 		mcbsp4: mcbsp@48096000 {
@@ -476,6 +538,8 @@
 			dmas = <&sdma 31>,
 			       <&sdma 32>;
 			dma-names = "tx", "rx";
+			clocks = <&per_mcbsp4_gfclk>, <&pad_clks_ck>, <&mcbsp4_sync_mux_ck>;
+			clock-names = "fck", "pad_fck", "prcm_fck";
 		};
 
 		keypad: keypad@4a31c000 {
@@ -484,6 +548,8 @@
 			interrupts = <0 120 0x4>;
 			reg-names = "mpu";
 			ti,hwmods = "kbd";
+			clocks = <&sys_32k_ck>;
+			clock-names = "fck";
 		};
 
 		emif1: emif@4c000000 {
@@ -495,6 +561,8 @@
 			hw-caps-read-idle-ctrl;
 			hw-caps-ll-interface;
 			hw-caps-temp-alert;
+			clocks = <&ddrphy_ck>;
+			clock-names = "fck";
 		};
 
 		emif2: emif@4d000000 {
@@ -506,6 +574,8 @@
 			hw-caps-read-idle-ctrl;
 			hw-caps-ll-interface;
 			hw-caps-temp-alert;
+			clocks = <&ddrphy_ck>;
+			clock-names = "fck";
 		};
 
 		ocp2scp@4a0ad000 {
@@ -515,6 +585,8 @@
 			#size-cells = <1>;
 			ranges;
 			ti,hwmods = "ocp2scp_usb_phy";
+			clocks = <&ocp2scp_usb_phy_phy_48m>;
+			clock-names = "fck";
 			usb2_phy: usb2phy@4a0ad080 {
 				compatible = "ti,omap-usb2";
 				reg = <0x4a0ad080 0x58>;
@@ -528,6 +600,8 @@
 			interrupts = <0 37 0x4>;
 			ti,hwmods = "timer1";
 			ti,timer-alwon;
+			clocks = <&dmt1_clk_mux>;
+			clock-names = "fck";
 		};
 
 		timer2: timer@48032000 {
@@ -535,6 +609,8 @@
 			reg = <0x48032000 0x80>;
 			interrupts = <0 38 0x4>;
 			ti,hwmods = "timer2";
+			clocks = <&cm2_dm2_mux>;
+			clock-names = "fck";
 		};
 
 		timer3: timer@48034000 {
@@ -542,6 +618,8 @@
 			reg = <0x48034000 0x80>;
 			interrupts = <0 39 0x4>;
 			ti,hwmods = "timer3";
+			clocks = <&cm2_dm3_mux>;
+			clock-names = "fck";
 		};
 
 		timer4: timer@48036000 {
@@ -549,6 +627,8 @@
 			reg = <0x48036000 0x80>;
 			interrupts = <0 40 0x4>;
 			ti,hwmods = "timer4";
+			clocks = <&cm2_dm4_mux>;
+			clock-names = "fck";
 		};
 
 		timer5: timer@40138000 {
@@ -558,6 +638,8 @@
 			interrupts = <0 41 0x4>;
 			ti,hwmods = "timer5";
 			ti,timer-dsp;
+			clocks = <&timer5_sync_mux>;
+			clock-names = "fck";
 		};
 
 		timer6: timer@4013a000 {
@@ -567,6 +649,8 @@
 			interrupts = <0 42 0x4>;
 			ti,hwmods = "timer6";
 			ti,timer-dsp;
+			clocks = <&timer6_sync_mux>;
+			clock-names = "fck";
 		};
 
 		timer7: timer@4013c000 {
@@ -576,6 +660,8 @@
 			interrupts = <0 43 0x4>;
 			ti,hwmods = "timer7";
 			ti,timer-dsp;
+			clocks = <&timer7_sync_mux>;
+			clock-names = "fck";
 		};
 
 		timer8: timer@4013e000 {
@@ -586,6 +672,8 @@
 			ti,hwmods = "timer8";
 			ti,timer-pwm;
 			ti,timer-dsp;
+			clocks = <&timer8_sync_mux>;
+			clock-names = "fck";
 		};
 
 		timer9: timer@4803e000 {
@@ -594,6 +682,8 @@
 			interrupts = <0 45 0x4>;
 			ti,hwmods = "timer9";
 			ti,timer-pwm;
+			clocks = <&cm2_dm9_mux>;
+			clock-names = "fck";
 		};
 
 		timer10: timer@48086000 {
@@ -602,6 +692,8 @@
 			interrupts = <0 46 0x4>;
 			ti,hwmods = "timer10";
 			ti,timer-pwm;
+			clocks = <&cm2_dm10_mux>;
+			clock-names = "fck";
 		};
 
 		timer11: timer@48088000 {
@@ -610,6 +702,8 @@
 			interrupts = <0 47 0x4>;
 			ti,hwmods = "timer11";
 			ti,timer-pwm;
+			clocks = <&cm2_dm11_mux>;
+			clock-names = "fck";
 		};
 
 		usbhstll: usbhstll@4a062000 {
@@ -617,6 +711,8 @@
 			reg = <0x4a062000 0x1000>;
 			interrupts = <0 78 0x4>;
 			ti,hwmods = "usb_tll_hs";
+			clocks = <&usb_tll_hs_ick>;
+			clock-names = "fck";
 		};
 
 		usbhshost: usbhshost@4a064000 {
@@ -626,6 +722,8 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			clocks = <&usb_host_hs_fck>;
+			clock-names = "fck";
 
 			usbhsohci: ohci@4a064800 {
 				compatible = "ti,ohci-omap3", "usb-ohci";
@@ -661,6 +759,8 @@
 			num-eps = <16>;
 			ram-bits = <12>;
 			ti,has-mailbox;
+			clocks = <&usb_otg_hs_ick>;
+			clock-names = "fck";
 		};
 	};
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 848b6dc..5ea01ea 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -419,7 +419,6 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod = {
 	.class		= &omap44xx_counter_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE,
-	.main_clk	= "sys_32k_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_SYNCTIMER_CLKCTRL_OFFSET,
@@ -570,7 +569,6 @@ static struct omap_hwmod omap44xx_dma_system_hwmod = {
 	.class		= &omap44xx_dma_hwmod_class,
 	.clkdm_name	= "l3_dma_clkdm",
 	.mpu_irqs	= omap44xx_dma_system_irqs,
-	.main_clk	= "l3_div_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_SDMA_SDMA_CLKCTRL_OFFSET,
@@ -617,7 +615,6 @@ static struct omap_hwmod omap44xx_dmic_hwmod = {
 	.clkdm_name	= "abe_clkdm",
 	.mpu_irqs	= omap44xx_dmic_irqs,
 	.sdma_reqs	= omap44xx_dmic_sdma_reqs,
-	.main_clk	= "func_dmic_abe_gfclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_DMIC_CLKCTRL_OFFSET,
@@ -1036,7 +1033,6 @@ static struct omap_hwmod omap44xx_emif1_hwmod = {
 	.clkdm_name	= "l3_emif_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_emif1_irqs,
-	.main_clk	= "ddrphy_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_MEMIF_EMIF_1_CLKCTRL_OFFSET,
@@ -1058,7 +1054,6 @@ static struct omap_hwmod omap44xx_emif2_hwmod = {
 	.clkdm_name	= "l3_emif_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
 	.mpu_irqs	= omap44xx_emif2_irqs,
-	.main_clk	= "ddrphy_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_MEMIF_EMIF_2_CLKCTRL_OFFSET,
@@ -1153,16 +1148,11 @@ static struct omap_hwmod_irq_info omap44xx_gpio1_irqs[] = {
 	{ .irq = -1 }
 };
 
-static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio1_dbclk" },
-};
-
 static struct omap_hwmod omap44xx_gpio1_hwmod = {
 	.name		= "gpio1",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.mpu_irqs	= omap44xx_gpio1_irqs,
-	.main_clk	= "l4_wkup_clk_mux_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_GPIO1_CLKCTRL_OFFSET,
@@ -1170,8 +1160,6 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= gpio1_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
@@ -1181,17 +1169,12 @@ static struct omap_hwmod_irq_info omap44xx_gpio2_irqs[] = {
 	{ .irq = -1 }
 };
 
-static struct omap_hwmod_opt_clk gpio2_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio2_dbclk" },
-};
-
 static struct omap_hwmod omap44xx_gpio2_hwmod = {
 	.name		= "gpio2",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap44xx_gpio2_irqs,
-	.main_clk	= "l4_div_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO2_CLKCTRL_OFFSET,
@@ -1199,8 +1182,6 @@ static struct omap_hwmod omap44xx_gpio2_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= gpio2_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio2_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
@@ -1210,17 +1191,12 @@ static struct omap_hwmod_irq_info omap44xx_gpio3_irqs[] = {
 	{ .irq = -1 }
 };
 
-static struct omap_hwmod_opt_clk gpio3_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio3_dbclk" },
-};
-
 static struct omap_hwmod omap44xx_gpio3_hwmod = {
 	.name		= "gpio3",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap44xx_gpio3_irqs,
-	.main_clk	= "l4_div_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO3_CLKCTRL_OFFSET,
@@ -1228,8 +1204,6 @@ static struct omap_hwmod omap44xx_gpio3_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= gpio3_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio3_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
@@ -1239,17 +1213,12 @@ static struct omap_hwmod_irq_info omap44xx_gpio4_irqs[] = {
 	{ .irq = -1 }
 };
 
-static struct omap_hwmod_opt_clk gpio4_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio4_dbclk" },
-};
-
 static struct omap_hwmod omap44xx_gpio4_hwmod = {
 	.name		= "gpio4",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap44xx_gpio4_irqs,
-	.main_clk	= "l4_div_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO4_CLKCTRL_OFFSET,
@@ -1257,8 +1226,6 @@ static struct omap_hwmod omap44xx_gpio4_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= gpio4_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio4_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
@@ -1268,17 +1235,12 @@ static struct omap_hwmod_irq_info omap44xx_gpio5_irqs[] = {
 	{ .irq = -1 }
 };
 
-static struct omap_hwmod_opt_clk gpio5_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio5_dbclk" },
-};
-
 static struct omap_hwmod omap44xx_gpio5_hwmod = {
 	.name		= "gpio5",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap44xx_gpio5_irqs,
-	.main_clk	= "l4_div_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO5_CLKCTRL_OFFSET,
@@ -1286,8 +1248,6 @@ static struct omap_hwmod omap44xx_gpio5_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= gpio5_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio5_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
@@ -1297,17 +1257,12 @@ static struct omap_hwmod_irq_info omap44xx_gpio6_irqs[] = {
 	{ .irq = -1 }
 };
 
-static struct omap_hwmod_opt_clk gpio6_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio6_dbclk" },
-};
-
 static struct omap_hwmod omap44xx_gpio6_hwmod = {
 	.name		= "gpio6",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap44xx_gpio6_irqs,
-	.main_clk	= "l4_div_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO6_CLKCTRL_OFFSET,
@@ -1315,8 +1270,6 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= gpio6_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio6_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
@@ -1551,7 +1504,6 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_i2c1_irqs,
 	.sdma_reqs	= omap44xx_i2c1_sdma_reqs,
-	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_I2C1_CLKCTRL_OFFSET,
@@ -1581,7 +1533,6 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_i2c2_irqs,
 	.sdma_reqs	= omap44xx_i2c2_sdma_reqs,
-	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_I2C2_CLKCTRL_OFFSET,
@@ -1611,7 +1562,6 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_i2c3_irqs,
 	.sdma_reqs	= omap44xx_i2c3_sdma_reqs,
-	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_I2C3_CLKCTRL_OFFSET,
@@ -1641,7 +1591,6 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_i2c4_irqs,
 	.sdma_reqs	= omap44xx_i2c4_sdma_reqs,
-	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_I2C4_CLKCTRL_OFFSET,
@@ -1830,7 +1779,6 @@ static struct omap_hwmod omap44xx_kbd_hwmod = {
 	.class		= &omap44xx_kbd_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.mpu_irqs	= omap44xx_kbd_irqs,
-	.main_clk	= "sys_32k_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_KEYBOARD_CLKCTRL_OFFSET,
@@ -1962,18 +1910,12 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp1_sdma_reqs[] = {
 	{ .dma_req = -1 }
 };
 
-static struct omap_hwmod_opt_clk mcbsp1_opt_clks[] = {
-	{ .role = "pad_fck", .clk = "pad_clks_ck" },
-	{ .role = "prcm_fck", .clk = "mcbsp1_sync_mux_ck" },
-};
-
 static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
 	.name		= "mcbsp1",
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
 	.mpu_irqs	= omap44xx_mcbsp1_irqs,
 	.sdma_reqs	= omap44xx_mcbsp1_sdma_reqs,
-	.main_clk	= "func_mcbsp1_gfclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP1_CLKCTRL_OFFSET,
@@ -1981,8 +1923,6 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mcbsp1_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mcbsp1_opt_clks),
 };
 
 /* mcbsp2 */
@@ -1997,18 +1937,12 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp2_sdma_reqs[] = {
 	{ .dma_req = -1 }
 };
 
-static struct omap_hwmod_opt_clk mcbsp2_opt_clks[] = {
-	{ .role = "pad_fck", .clk = "pad_clks_ck" },
-	{ .role = "prcm_fck", .clk = "mcbsp2_sync_mux_ck" },
-};
-
 static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
 	.name		= "mcbsp2",
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
 	.mpu_irqs	= omap44xx_mcbsp2_irqs,
 	.sdma_reqs	= omap44xx_mcbsp2_sdma_reqs,
-	.main_clk	= "func_mcbsp2_gfclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP2_CLKCTRL_OFFSET,
@@ -2016,8 +1950,6 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mcbsp2_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mcbsp2_opt_clks),
 };
 
 /* mcbsp3 */
@@ -2032,18 +1964,12 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp3_sdma_reqs[] = {
 	{ .dma_req = -1 }
 };
 
-static struct omap_hwmod_opt_clk mcbsp3_opt_clks[] = {
-	{ .role = "pad_fck", .clk = "pad_clks_ck" },
-	{ .role = "prcm_fck", .clk = "mcbsp3_sync_mux_ck" },
-};
-
 static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
 	.name		= "mcbsp3",
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
 	.mpu_irqs	= omap44xx_mcbsp3_irqs,
 	.sdma_reqs	= omap44xx_mcbsp3_sdma_reqs,
-	.main_clk	= "func_mcbsp3_gfclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP3_CLKCTRL_OFFSET,
@@ -2051,8 +1977,6 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mcbsp3_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mcbsp3_opt_clks),
 };
 
 /* mcbsp4 */
@@ -2067,11 +1991,6 @@ static struct omap_hwmod_dma_info omap44xx_mcbsp4_sdma_reqs[] = {
 	{ .dma_req = -1 }
 };
 
-static struct omap_hwmod_opt_clk mcbsp4_opt_clks[] = {
-	{ .role = "pad_fck", .clk = "pad_clks_ck" },
-	{ .role = "prcm_fck", .clk = "mcbsp4_sync_mux_ck" },
-};
-
 static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
 	.name		= "mcbsp4",
 	.class		= &omap44xx_mcbsp_hwmod_class,
@@ -2086,8 +2005,6 @@ static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mcbsp4_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mcbsp4_opt_clks),
 };
 
 /*
@@ -2141,7 +2058,6 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod = {
 	.flags		= HWMOD_EXT_OPT_MAIN_CLK | HWMOD_SWSUP_SIDLE,
 	.mpu_irqs	= omap44xx_mcpdm_irqs,
 	.sdma_reqs	= omap44xx_mcpdm_sdma_reqs,
-	.main_clk	= "pad_clks_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_PDM_CLKCTRL_OFFSET,
@@ -2202,7 +2118,6 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 	.clkdm_name	= "l4_per_clkdm",
 	.mpu_irqs	= omap44xx_mcspi1_irqs,
 	.sdma_reqs	= omap44xx_mcspi1_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI1_CLKCTRL_OFFSET,
@@ -2238,7 +2153,6 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 	.clkdm_name	= "l4_per_clkdm",
 	.mpu_irqs	= omap44xx_mcspi2_irqs,
 	.sdma_reqs	= omap44xx_mcspi2_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI2_CLKCTRL_OFFSET,
@@ -2274,7 +2188,6 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 	.clkdm_name	= "l4_per_clkdm",
 	.mpu_irqs	= omap44xx_mcspi3_irqs,
 	.sdma_reqs	= omap44xx_mcspi3_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI3_CLKCTRL_OFFSET,
@@ -2308,7 +2221,6 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
 	.clkdm_name	= "l4_per_clkdm",
 	.mpu_irqs	= omap44xx_mcspi4_irqs,
 	.sdma_reqs	= omap44xx_mcspi4_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI4_CLKCTRL_OFFSET,
@@ -2364,7 +2276,6 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 	.clkdm_name	= "l3_init_clkdm",
 	.mpu_irqs	= omap44xx_mmc1_irqs,
 	.sdma_reqs	= omap44xx_mmc1_sdma_reqs,
-	.main_clk	= "hsmmc1_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_MMC1_CLKCTRL_OFFSET,
@@ -2393,7 +2304,6 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 	.clkdm_name	= "l3_init_clkdm",
 	.mpu_irqs	= omap44xx_mmc2_irqs,
 	.sdma_reqs	= omap44xx_mmc2_sdma_reqs,
-	.main_clk	= "hsmmc2_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_MMC2_CLKCTRL_OFFSET,
@@ -2421,7 +2331,6 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
 	.clkdm_name	= "l4_per_clkdm",
 	.mpu_irqs	= omap44xx_mmc3_irqs,
 	.sdma_reqs	= omap44xx_mmc3_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD3_CLKCTRL_OFFSET,
@@ -2449,7 +2358,6 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
 	.clkdm_name	= "l4_per_clkdm",
 	.mpu_irqs	= omap44xx_mmc4_irqs,
 	.sdma_reqs	= omap44xx_mmc4_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD4_CLKCTRL_OFFSET,
@@ -2477,7 +2385,6 @@ static struct omap_hwmod omap44xx_mmc5_hwmod = {
 	.clkdm_name	= "l4_per_clkdm",
 	.mpu_irqs	= omap44xx_mmc5_irqs,
 	.sdma_reqs	= omap44xx_mmc5_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD5_CLKCTRL_OFFSET,
@@ -2729,7 +2636,6 @@ static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwmod = {
 	 * So listing ocp2scp_usb_phy_phy_48m as a main_clk here seems
 	 * to be the best workaround.
 	 */
-	.main_clk	= "ocp2scp_usb_phy_phy_48m",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL_OFFSET,
@@ -3189,7 +3095,6 @@ static struct omap_hwmod omap44xx_timer2_hwmod = {
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_timer2_irqs,
-	.main_clk	= "cm2_dm2_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER2_CLKCTRL_OFFSET,
@@ -3210,7 +3115,6 @@ static struct omap_hwmod omap44xx_timer3_hwmod = {
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.mpu_irqs	= omap44xx_timer3_irqs,
-	.main_clk	= "cm2_dm3_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER3_CLKCTRL_OFFSET,
@@ -3231,7 +3135,6 @@ static struct omap_hwmod omap44xx_timer4_hwmod = {
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.mpu_irqs	= omap44xx_timer4_irqs,
-	.main_clk	= "cm2_dm4_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER4_CLKCTRL_OFFSET,
@@ -3252,7 +3155,6 @@ static struct omap_hwmod omap44xx_timer5_hwmod = {
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
 	.mpu_irqs	= omap44xx_timer5_irqs,
-	.main_clk	= "timer5_sync_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_TIMER5_CLKCTRL_OFFSET,
@@ -3274,7 +3176,6 @@ static struct omap_hwmod omap44xx_timer6_hwmod = {
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
 	.mpu_irqs	= omap44xx_timer6_irqs,
-	.main_clk	= "timer6_sync_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_TIMER6_CLKCTRL_OFFSET,
@@ -3296,7 +3197,6 @@ static struct omap_hwmod omap44xx_timer7_hwmod = {
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
 	.mpu_irqs	= omap44xx_timer7_irqs,
-	.main_clk	= "timer7_sync_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_TIMER7_CLKCTRL_OFFSET,
@@ -3318,7 +3218,6 @@ static struct omap_hwmod omap44xx_timer8_hwmod = {
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
 	.mpu_irqs	= omap44xx_timer8_irqs,
-	.main_clk	= "timer8_sync_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_TIMER8_CLKCTRL_OFFSET,
@@ -3340,7 +3239,6 @@ static struct omap_hwmod omap44xx_timer9_hwmod = {
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.mpu_irqs	= omap44xx_timer9_irqs,
-	.main_clk	= "cm2_dm9_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER9_CLKCTRL_OFFSET,
@@ -3363,7 +3261,6 @@ static struct omap_hwmod omap44xx_timer10_hwmod = {
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 	.mpu_irqs	= omap44xx_timer10_irqs,
-	.main_clk	= "cm2_dm10_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER10_CLKCTRL_OFFSET,
@@ -3385,7 +3282,6 @@ static struct omap_hwmod omap44xx_timer11_hwmod = {
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.mpu_irqs	= omap44xx_timer11_irqs,
-	.main_clk	= "cm2_dm11_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER11_CLKCTRL_OFFSET,
@@ -3437,7 +3333,6 @@ static struct omap_hwmod omap44xx_uart1_hwmod = {
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.mpu_irqs	= omap44xx_uart1_irqs,
 	.sdma_reqs	= omap44xx_uart1_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_UART1_CLKCTRL_OFFSET,
@@ -3466,7 +3361,6 @@ static struct omap_hwmod omap44xx_uart2_hwmod = {
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.mpu_irqs	= omap44xx_uart2_irqs,
 	.sdma_reqs	= omap44xx_uart2_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_UART2_CLKCTRL_OFFSET,
@@ -3496,7 +3390,6 @@ static struct omap_hwmod omap44xx_uart3_hwmod = {
 				HWMOD_SWSUP_SIDLE_ACT,
 	.mpu_irqs	= omap44xx_uart3_irqs,
 	.sdma_reqs	= omap44xx_uart3_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_UART3_CLKCTRL_OFFSET,
@@ -3525,7 +3418,6 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.mpu_irqs	= omap44xx_uart4_irqs,
 	.sdma_reqs	= omap44xx_uart4_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_UART4_CLKCTRL_OFFSET,
@@ -3617,7 +3509,6 @@ static struct omap_hwmod omap44xx_usb_host_hs_hwmod = {
 	.name		= "usb_host_hs",
 	.class		= &omap44xx_usb_host_hs_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.main_clk	= "usb_host_hs_fck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_USB_HOST_CLKCTRL_OFFSET,
@@ -3716,7 +3607,6 @@ static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
 	.clkdm_name	= "l3_init_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
 	.mpu_irqs	= omap44xx_usb_otg_hs_irqs,
-	.main_clk	= "usb_otg_hs_ick",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_USB_OTG_CLKCTRL_OFFSET,
@@ -3759,7 +3649,6 @@ static struct omap_hwmod omap44xx_usb_tll_hs_hwmod = {
 	.class		= &omap44xx_usb_tll_hs_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
 	.mpu_irqs	= omap44xx_usb_tll_hs_irqs,
-	.main_clk	= "usb_tll_hs_ick",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_USB_TLL_CLKCTRL_OFFSET,
@@ -3804,7 +3693,6 @@ static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
 	.class		= &omap44xx_wd_timer_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.mpu_irqs	= omap44xx_wd_timer2_irqs,
-	.main_clk	= "sys_32k_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_WDT2_CLKCTRL_OFFSET,
-- 
1.7.9.5

