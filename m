From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 35/45] ARM: OMAP4: dts: Add main and optional clock data into DT
Date: Thu, 29 Aug 2013 16:16:27 +0300
Message-ID: <1377782197-10611-36-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50767 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755039Ab3H2NTL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:19:11 -0400
In-Reply-To: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, nm@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

From: Rajendra Nayak <rnayak@ti.com>

With support to parse clock data from DT, move all main and optional
clock information from hwmod to DT.

We still retain clocks in hwmod for devices which do not have a DT node.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
[t-kristo@ti.com: refreshed against latest hwmod data]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi               |  100 +++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  109 ----------------------------
 2 files changed, 100 insertions(+), 109 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 22d9f2b..0b35761 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -107,6 +107,8 @@
 			compatible = "ti,omap-counter32k";
 			reg = <0x4a304000 0x20>;
 			ti,hwmods = "counter_32k";
+			clocks = <&sys_32k_ck>;
+			clock-names = "fck";
 		};
 
 		omap4_pmx_core: pinmux@4a100040 {
@@ -136,6 +138,8 @@
 			#dma-cells = <1>;
 			#dma-channels = <32>;
 			#dma-requests = <127>;
+			clocks = <&l3_div_ck>;
+			clock-names = "fck";
 		};
 
 		gpio1: gpio@4a310000 {
@@ -143,6 +147,8 @@
 			reg = <0x4a310000 0x200>;
 			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio1";
+			clocks = <&l4_wkup_clk_mux_ck>, <&gpio1_dbclk>;
+			clock-names = "fck", "dbclk";
 			ti,gpio-always-on;
 			gpio-controller;
 			#gpio-cells = <2>;
@@ -155,6 +161,8 @@
 			reg = <0x48055000 0x200>;
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio2";
+			clocks = <&l4_div_ck>, <&gpio2_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -166,6 +174,8 @@
 			reg = <0x48057000 0x200>;
 			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio3";
+			clocks = <&l4_div_ck>, <&gpio3_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -177,6 +187,8 @@
 			reg = <0x48059000 0x200>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio4";
+			clocks = <&l4_div_ck>, <&gpio4_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -188,6 +200,8 @@
 			reg = <0x4805b000 0x200>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio5";
+			clocks = <&l4_div_ck>, <&gpio5_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -199,6 +213,8 @@
 			reg = <0x4805d000 0x200>;
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "gpio6";
+			clocks = <&l4_div_ck>, <&gpio6_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -221,6 +237,8 @@
 			reg = <0x4806a000 0x100>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart1";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 		};
 
@@ -229,6 +247,8 @@
 			reg = <0x4806c000 0x100>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart2";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 		};
 
@@ -237,6 +257,8 @@
 			reg = <0x48020000 0x100>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart3";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 		};
 
@@ -245,6 +267,8 @@
 			reg = <0x4806e000 0x100>;
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "uart4";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 		};
 
@@ -255,6 +279,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c1";
+			clocks = <&func_96m_fclk>;
+			clock-names = "fck";
 		};
 
 		i2c2: i2c@48072000 {
@@ -264,6 +290,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c2";
+			clocks = <&func_96m_fclk>;
+			clock-names = "fck";
 		};
 
 		i2c3: i2c@48060000 {
@@ -273,6 +301,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
+			clocks = <&func_96m_fclk>;
+			clock-names = "fck";
 		};
 
 		i2c4: i2c@48350000 {
@@ -282,6 +312,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c4";
+			clocks = <&func_96m_fclk>;
+			clock-names = "fck";
 		};
 
 		mcspi1: spi@48098000 {
@@ -291,6 +323,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi1";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			ti,spi-num-cs = <4>;
 			dmas = <&sdma 35>,
 			       <&sdma 36>,
@@ -311,6 +345,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi2";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			ti,spi-num-cs = <2>;
 			dmas = <&sdma 43>,
 			       <&sdma 44>,
@@ -326,6 +362,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi3";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			ti,spi-num-cs = <2>;
 			dmas = <&sdma 15>, <&sdma 16>;
 			dma-names = "tx0", "rx0";
@@ -338,6 +376,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcspi4";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			ti,spi-num-cs = <1>;
 			dmas = <&sdma 70>, <&sdma 71>;
 			dma-names = "tx0", "rx0";
@@ -348,6 +388,8 @@
 			reg = <0x4809c000 0x400>;
 			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc1";
+			clocks = <&hsmmc1_fclk>;
+			clock-names = "fck";
 			ti,dual-volt;
 			ti,needs-special-reset;
 			dmas = <&sdma 61>, <&sdma 62>;
@@ -359,6 +401,8 @@
 			reg = <0x480b4000 0x400>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc2";
+			clocks = <&hsmmc2_fclk>;
+			clock-names = "fck";
 			ti,needs-special-reset;
 			dmas = <&sdma 47>, <&sdma 48>;
 			dma-names = "tx", "rx";
@@ -369,6 +413,8 @@
 			reg = <0x480ad000 0x400>;
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc3";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			ti,needs-special-reset;
 			dmas = <&sdma 77>, <&sdma 78>;
 			dma-names = "tx", "rx";
@@ -379,6 +425,8 @@
 			reg = <0x480d1000 0x400>;
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc4";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			ti,needs-special-reset;
 			dmas = <&sdma 57>, <&sdma 58>;
 			dma-names = "tx", "rx";
@@ -389,6 +437,8 @@
 			reg = <0x480d5000 0x400>;
 			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mmc5";
+			clocks = <&func_48m_fclk>;
+			clock-names = "fck";
 			ti,needs-special-reset;
 			dmas = <&sdma 59>, <&sdma 60>;
 			dma-names = "tx", "rx";
@@ -399,6 +449,8 @@
 			reg = <0x4a314000 0x80>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "wd_timer2";
+			clocks = <&sys_32k_ck>;
+			clock-names = "fck";
 		};
 
 		mcpdm: mcpdm@40132000 {
@@ -408,6 +460,8 @@
 			reg-names = "mpu", "dma";
 			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mcpdm";
+			clocks = <&pad_clks_ck>;
+			clock-names = "fck";
 			dmas = <&sdma 65>,
 			       <&sdma 66>;
 			dma-names = "up_link", "dn_link";
@@ -420,6 +474,8 @@
 			reg-names = "mpu", "dma";
 			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "dmic";
+			clocks = <&func_dmic_abe_gfclk>;
+			clock-names = "fck";
 			dmas = <&sdma 67>;
 			dma-names = "up_link";
 		};
@@ -433,6 +489,8 @@
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp1";
+			clocks = <&func_mcbsp1_gfclk>, <&pad_clks_ck>, <&mcbsp1_sync_mux_ck>;
+			clock-names = "fck", "pad_fck", "prcm_fck";
 			dmas = <&sdma 33>,
 			       <&sdma 34>;
 			dma-names = "tx", "rx";
@@ -447,6 +505,8 @@
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp2";
+			clocks = <&func_mcbsp2_gfclk>, <&pad_clks_ck>, <&mcbsp2_sync_mux_ck>;
+			clock-names = "fck", "pad_fck", "prcm_fck";
 			dmas = <&sdma 17>,
 			       <&sdma 18>;
 			dma-names = "tx", "rx";
@@ -461,6 +521,8 @@
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp3";
+			clocks = <&func_mcbsp3_gfclk>, <&pad_clks_ck>, <&mcbsp3_sync_mux_ck>;
+			clock-names = "fck", "pad_fck", "prcm_fck";
 			dmas = <&sdma 19>,
 			       <&sdma 20>;
 			dma-names = "tx", "rx";
@@ -474,6 +536,8 @@
 			interrupt-names = "common";
 			ti,buffer-size = <128>;
 			ti,hwmods = "mcbsp4";
+			clocks = <&per_mcbsp4_gfclk>, <&pad_clks_ck>, <&mcbsp4_sync_mux_ck>;
+			clock-names = "fck", "pad_fck", "prcm_fck";
 			dmas = <&sdma 31>,
 			       <&sdma 32>;
 			dma-names = "tx", "rx";
@@ -485,6 +549,8 @@
 			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			reg-names = "mpu";
 			ti,hwmods = "kbd";
+			clocks = <&sys_32k_ck>;
+			clock-names = "fck";
 		};
 
 		emif1: emif@4c000000 {
@@ -492,6 +558,8 @@
 			reg = <0x4c000000 0x100>;
 			interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "emif1";
+			clocks = <&ddrphy_ck>;
+			clock-names = "fck";
 			phy-type = <1>;
 			hw-caps-read-idle-ctrl;
 			hw-caps-ll-interface;
@@ -503,6 +571,8 @@
 			reg = <0x4d000000 0x100>;
 			interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "emif2";
+			clocks = <&ddrphy_ck>;
+			clock-names = "fck";
 			phy-type = <1>;
 			hw-caps-read-idle-ctrl;
 			hw-caps-ll-interface;
@@ -516,6 +586,8 @@
 			#size-cells = <1>;
 			ranges;
 			ti,hwmods = "ocp2scp_usb_phy";
+			clocks = <&ocp2scp_usb_phy_phy_48m>;
+			clock-names = "fck";
 			usb2_phy: usb2phy@4a0ad080 {
 				compatible = "ti,omap-usb2";
 				reg = <0x4a0ad080 0x58>;
@@ -528,6 +600,8 @@
 			reg = <0x4a318000 0x80>;
 			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer1";
+			clocks = <&dmt1_clk_mux>;
+			clock-names = "fck";
 			ti,timer-alwon;
 		};
 
@@ -536,6 +610,8 @@
 			reg = <0x48032000 0x80>;
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer2";
+			clocks = <&cm2_dm2_mux>;
+			clock-names = "fck";
 		};
 
 		timer3: timer@48034000 {
@@ -543,6 +619,8 @@
 			reg = <0x48034000 0x80>;
 			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer3";
+			clocks = <&cm2_dm3_mux>;
+			clock-names = "fck";
 		};
 
 		timer4: timer@48036000 {
@@ -550,6 +628,8 @@
 			reg = <0x48036000 0x80>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer4";
+			clocks = <&cm2_dm4_mux>;
+			clock-names = "fck";
 		};
 
 		timer5: timer@40138000 {
@@ -558,6 +638,8 @@
 			      <0x49038000 0x80>;
 			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer5";
+			clocks = <&timer5_sync_mux>;
+			clock-names = "fck";
 			ti,timer-dsp;
 		};
 
@@ -567,6 +649,8 @@
 			      <0x4903a000 0x80>;
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer6";
+			clocks = <&timer6_sync_mux>;
+			clock-names = "fck";
 			ti,timer-dsp;
 		};
 
@@ -576,6 +660,8 @@
 			      <0x4903c000 0x80>;
 			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer7";
+			clocks = <&timer7_sync_mux>;
+			clock-names = "fck";
 			ti,timer-dsp;
 		};
 
@@ -585,6 +671,8 @@
 			      <0x4903e000 0x80>;
 			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer8";
+			clocks = <&timer8_sync_mux>;
+			clock-names = "fck";
 			ti,timer-pwm;
 			ti,timer-dsp;
 		};
@@ -594,6 +682,8 @@
 			reg = <0x4803e000 0x80>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer9";
+			clocks = <&cm2_dm9_mux>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -602,6 +692,8 @@
 			reg = <0x48086000 0x80>;
 			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer10";
+			clocks = <&cm2_dm10_mux>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -610,6 +702,8 @@
 			reg = <0x48088000 0x80>;
 			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "timer11";
+			clocks = <&cm2_dm11_mux>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -618,12 +712,16 @@
 			reg = <0x4a062000 0x1000>;
 			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "usb_tll_hs";
+			clocks = <&usb_tll_hs_ick>;
+			clock-names = "fck";
 		};
 
 		usbhshost: usbhshost@4a064000 {
 			compatible = "ti,usbhs-host";
 			reg = <0x4a064000 0x800>;
 			ti,hwmods = "usb_host_hs";
+			clocks = <&usb_host_hs_fck>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -657,6 +755,8 @@
 			interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "mc", "dma";
 			ti,hwmods = "usb_otg_hs";
+			clocks = <&usb_otg_hs_ick>, <&usb_otg_hs_xclk>;
+			clock-names = "fck", "xclk";
 			usb-phy = <&usb2_phy>;
 			multipoint = <1>;
 			num-eps = <16>;
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 9c3b504..6543383 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -334,7 +334,6 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod = {
 	.class		= &omap44xx_counter_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE,
-	.main_clk	= "sys_32k_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_SYNCTIMER_CLKCTRL_OFFSET,
@@ -479,7 +478,6 @@ static struct omap_hwmod omap44xx_dma_system_hwmod = {
 	.class		= &omap44xx_dma_hwmod_class,
 	.clkdm_name	= "l3_dma_clkdm",
 	.mpu_irqs	= omap44xx_dma_system_irqs,
-	.main_clk	= "l3_div_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_SDMA_SDMA_CLKCTRL_OFFSET,
@@ -514,7 +512,6 @@ static struct omap_hwmod omap44xx_dmic_hwmod = {
 	.name		= "dmic",
 	.class		= &omap44xx_dmic_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "func_dmic_abe_gfclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_DMIC_CLKCTRL_OFFSET,
@@ -915,7 +912,6 @@ static struct omap_hwmod omap44xx_emif1_hwmod = {
 	.class		= &omap44xx_emif_hwmod_class,
 	.clkdm_name	= "l3_emif_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
-	.main_clk	= "ddrphy_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_MEMIF_EMIF_1_CLKCTRL_OFFSET,
@@ -931,7 +927,6 @@ static struct omap_hwmod omap44xx_emif2_hwmod = {
 	.class		= &omap44xx_emif_hwmod_class,
 	.clkdm_name	= "l3_emif_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
-	.main_clk	= "ddrphy_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_MEMIF_EMIF_2_CLKCTRL_OFFSET,
@@ -1015,15 +1010,11 @@ static struct omap_gpio_dev_attr gpio_dev_attr = {
 };
 
 /* gpio1 */
-static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio1_dbclk" },
-};
 
 static struct omap_hwmod omap44xx_gpio1_hwmod = {
 	.name		= "gpio1",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.main_clk	= "l4_wkup_clk_mux_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_GPIO1_CLKCTRL_OFFSET,
@@ -1031,22 +1022,16 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
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
 
 static struct omap_hwmod omap44xx_gpio2_hwmod = {
 	.name		= "gpio2",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_div_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO2_CLKCTRL_OFFSET,
@@ -1054,22 +1039,16 @@ static struct omap_hwmod omap44xx_gpio2_hwmod = {
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
 
 static struct omap_hwmod omap44xx_gpio3_hwmod = {
 	.name		= "gpio3",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_div_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO3_CLKCTRL_OFFSET,
@@ -1077,22 +1056,16 @@ static struct omap_hwmod omap44xx_gpio3_hwmod = {
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
 
 static struct omap_hwmod omap44xx_gpio4_hwmod = {
 	.name		= "gpio4",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_div_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO4_CLKCTRL_OFFSET,
@@ -1100,22 +1073,16 @@ static struct omap_hwmod omap44xx_gpio4_hwmod = {
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
 
 static struct omap_hwmod omap44xx_gpio5_hwmod = {
 	.name		= "gpio5",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_div_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO5_CLKCTRL_OFFSET,
@@ -1123,22 +1090,16 @@ static struct omap_hwmod omap44xx_gpio5_hwmod = {
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
 
 static struct omap_hwmod omap44xx_gpio6_hwmod = {
 	.name		= "gpio6",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_div_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_GPIO6_CLKCTRL_OFFSET,
@@ -1146,8 +1107,6 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= gpio6_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio6_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
@@ -1337,7 +1296,6 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_I2C1_CLKCTRL_OFFSET,
@@ -1354,7 +1312,6 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_I2C2_CLKCTRL_OFFSET,
@@ -1371,7 +1328,6 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_I2C3_CLKCTRL_OFFSET,
@@ -1388,7 +1344,6 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_I2C4_CLKCTRL_OFFSET,
@@ -1542,7 +1497,6 @@ static struct omap_hwmod omap44xx_kbd_hwmod = {
 	.name		= "kbd",
 	.class		= &omap44xx_kbd_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.main_clk	= "sys_32k_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_KEYBOARD_CLKCTRL_OFFSET,
@@ -1643,16 +1597,11 @@ static struct omap_hwmod_class omap44xx_mcbsp_hwmod_class = {
 };
 
 /* mcbsp1 */
-static struct omap_hwmod_opt_clk mcbsp1_opt_clks[] = {
-	{ .role = "pad_fck", .clk = "pad_clks_ck" },
-	{ .role = "prcm_fck", .clk = "mcbsp1_sync_mux_ck" },
-};
 
 static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
 	.name		= "mcbsp1",
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "func_mcbsp1_gfclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP1_CLKCTRL_OFFSET,
@@ -1660,21 +1609,14 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
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
 
 static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
 	.name		= "mcbsp2",
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "func_mcbsp2_gfclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP2_CLKCTRL_OFFSET,
@@ -1682,21 +1624,14 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
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
 
 static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
 	.name		= "mcbsp3",
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "func_mcbsp3_gfclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP3_CLKCTRL_OFFSET,
@@ -1704,21 +1639,14 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mcbsp3_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mcbsp3_opt_clks),
 };
 
 /* mcbsp4 */
-static struct omap_hwmod_opt_clk mcbsp4_opt_clks[] = {
-	{ .role = "pad_fck", .clk = "pad_clks_ck" },
-	{ .role = "prcm_fck", .clk = "mcbsp4_sync_mux_ck" },
-};
 
 static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
 	.name		= "mcbsp4",
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.main_clk	= "per_mcbsp4_gfclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MCBSP4_CLKCTRL_OFFSET,
@@ -1726,8 +1654,6 @@ static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mcbsp4_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mcbsp4_opt_clks),
 };
 
 /*
@@ -1768,7 +1694,6 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod = {
 	 * results 'slow motion' audio playback.
 	 */
 	.flags		= HWMOD_EXT_OPT_MAIN_CLK | HWMOD_SWSUP_SIDLE,
-	.main_clk	= "pad_clks_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_PDM_CLKCTRL_OFFSET,
@@ -1823,7 +1748,6 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.sdma_reqs	= omap44xx_mcspi1_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI1_CLKCTRL_OFFSET,
@@ -1853,7 +1777,6 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.sdma_reqs	= omap44xx_mcspi2_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI2_CLKCTRL_OFFSET,
@@ -1883,7 +1806,6 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.sdma_reqs	= omap44xx_mcspi3_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI3_CLKCTRL_OFFSET,
@@ -1911,7 +1833,6 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.sdma_reqs	= omap44xx_mcspi4_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI4_CLKCTRL_OFFSET,
@@ -1961,7 +1882,6 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
 	.sdma_reqs	= omap44xx_mmc1_sdma_reqs,
-	.main_clk	= "hsmmc1_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_MMC1_CLKCTRL_OFFSET,
@@ -1984,7 +1904,6 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
 	.sdma_reqs	= omap44xx_mmc2_sdma_reqs,
-	.main_clk	= "hsmmc2_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_MMC2_CLKCTRL_OFFSET,
@@ -2006,7 +1925,6 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.sdma_reqs	= omap44xx_mmc3_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD3_CLKCTRL_OFFSET,
@@ -2028,7 +1946,6 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.sdma_reqs	= omap44xx_mmc4_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD4_CLKCTRL_OFFSET,
@@ -2050,7 +1967,6 @@ static struct omap_hwmod omap44xx_mmc5_hwmod = {
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.sdma_reqs	= omap44xx_mmc5_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD5_CLKCTRL_OFFSET,
@@ -2261,7 +2177,6 @@ static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwmod = {
 	 * So listing ocp2scp_usb_phy_phy_48m as a main_clk here seems
 	 * to be the best workaround.
 	 */
-	.main_clk	= "ocp2scp_usb_phy_phy_48m",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL_OFFSET,
@@ -2629,7 +2544,6 @@ static struct omap_hwmod omap44xx_timer1_hwmod = {
 	.class		= &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "dmt1_clk_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_TIMER1_CLKCTRL_OFFSET,
@@ -2646,7 +2560,6 @@ static struct omap_hwmod omap44xx_timer2_hwmod = {
 	.class		= &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "cm2_dm2_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER2_CLKCTRL_OFFSET,
@@ -2661,7 +2574,6 @@ static struct omap_hwmod omap44xx_timer3_hwmod = {
 	.name		= "timer3",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.main_clk	= "cm2_dm3_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER3_CLKCTRL_OFFSET,
@@ -2676,7 +2588,6 @@ static struct omap_hwmod omap44xx_timer4_hwmod = {
 	.name		= "timer4",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.main_clk	= "cm2_dm4_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER4_CLKCTRL_OFFSET,
@@ -2691,7 +2602,6 @@ static struct omap_hwmod omap44xx_timer5_hwmod = {
 	.name		= "timer5",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "timer5_sync_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_TIMER5_CLKCTRL_OFFSET,
@@ -2707,7 +2617,6 @@ static struct omap_hwmod omap44xx_timer6_hwmod = {
 	.name		= "timer6",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "timer6_sync_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_TIMER6_CLKCTRL_OFFSET,
@@ -2723,7 +2632,6 @@ static struct omap_hwmod omap44xx_timer7_hwmod = {
 	.name		= "timer7",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "timer7_sync_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_TIMER7_CLKCTRL_OFFSET,
@@ -2739,7 +2647,6 @@ static struct omap_hwmod omap44xx_timer8_hwmod = {
 	.name		= "timer8",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "timer8_sync_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM1_ABE_TIMER8_CLKCTRL_OFFSET,
@@ -2755,7 +2662,6 @@ static struct omap_hwmod omap44xx_timer9_hwmod = {
 	.name		= "timer9",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.main_clk	= "cm2_dm9_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER9_CLKCTRL_OFFSET,
@@ -2772,7 +2678,6 @@ static struct omap_hwmod omap44xx_timer10_hwmod = {
 	.class		= &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "cm2_dm10_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER10_CLKCTRL_OFFSET,
@@ -2788,7 +2693,6 @@ static struct omap_hwmod omap44xx_timer11_hwmod = {
 	.name		= "timer11",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.main_clk	= "cm2_dm11_mux",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER11_CLKCTRL_OFFSET,
@@ -2827,7 +2731,6 @@ static struct omap_hwmod omap44xx_uart1_hwmod = {
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_UART1_CLKCTRL_OFFSET,
@@ -2843,7 +2746,6 @@ static struct omap_hwmod omap44xx_uart2_hwmod = {
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_UART2_CLKCTRL_OFFSET,
@@ -2859,7 +2761,6 @@ static struct omap_hwmod omap44xx_uart3_hwmod = {
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= DEBUG_OMAP4UART3_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_UART3_CLKCTRL_OFFSET,
@@ -2875,7 +2776,6 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= DEBUG_OMAP4UART4_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L4PER_UART4_CLKCTRL_OFFSET,
@@ -2954,7 +2854,6 @@ static struct omap_hwmod omap44xx_usb_host_hs_hwmod = {
 	.name		= "usb_host_hs",
 	.class		= &omap44xx_usb_host_hs_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.main_clk	= "usb_host_hs_fck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_USB_HOST_CLKCTRL_OFFSET,
@@ -3036,16 +2935,12 @@ static struct omap_hwmod_class omap44xx_usb_otg_hs_hwmod_class = {
 };
 
 /* usb_otg_hs */
-static struct omap_hwmod_opt_clk usb_otg_hs_opt_clks[] = {
-	{ .role = "xclk", .clk = "usb_otg_hs_xclk" },
-};
 
 static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
 	.name		= "usb_otg_hs",
 	.class		= &omap44xx_usb_otg_hs_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
-	.main_clk	= "usb_otg_hs_ick",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_USB_OTG_CLKCTRL_OFFSET,
@@ -3053,8 +2948,6 @@ static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= usb_otg_hs_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(usb_otg_hs_opt_clks),
 };
 
 /*
@@ -3082,7 +2975,6 @@ static struct omap_hwmod omap44xx_usb_tll_hs_hwmod = {
 	.name		= "usb_tll_hs",
 	.class		= &omap44xx_usb_tll_hs_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.main_clk	= "usb_tll_hs_ick",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3INIT_USB_TLL_CLKCTRL_OFFSET,
@@ -3121,7 +3013,6 @@ static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
 	.name		= "wd_timer2",
 	.class		= &omap44xx_wd_timer_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.main_clk	= "sys_32k_ck",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_WKUP_WDT2_CLKCTRL_OFFSET,
-- 
1.7.9.5

