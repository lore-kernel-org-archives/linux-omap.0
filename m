From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 42/45] ARM: dts: am335x: Add main and optional clock data into DT
Date: Thu, 29 Aug 2013 16:16:34 +0300
Message-ID: <1377782197-10611-43-git-send-email-t-kristo@ti.com>
References: <1377782197-10611-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49163 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754772Ab3H2NSr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:18:47 -0400
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
 arch/arm/boot/dts/am33xx.dtsi              |   88 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   64 --------------------
 2 files changed, 88 insertions(+), 64 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4701e3c..509eab3 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -87,6 +87,8 @@
 		#size-cells = <1>;
 		ranges;
 		ti,hwmods = "l3_main";
+		clocks = <&l3_gclk>;
+		clock-names = "fck";
 
 		intc: interrupt-controller@48200000 {
 			compatible = "ti,omap2-intc";
@@ -99,6 +101,8 @@
 		gpio0: gpio@44e07000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio1";
+			clocks = <&dpll_core_m4_div2_ck>, <&gpio0_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -110,6 +114,8 @@
 		gpio1: gpio@4804c000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio2";
+			clocks = <&l4ls_gclk>, <&gpio1_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -121,6 +127,8 @@
 		gpio2: gpio@481ac000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio3";
+			clocks = <&l4ls_gclk>, <&gpio2_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -132,6 +140,8 @@
 		gpio3: gpio@481ae000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio4";
+			clocks = <&l4ls_gclk>, <&gpio3_dbclk>;
+			clock-names = "fck", "dbclk";
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -143,6 +153,8 @@
 		uart0: serial@44e09000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart1";
+			clocks = <&dpll_per_m2_div4_wkupdm_ck>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 			reg = <0x44e09000 0x2000>;
 			interrupts = <72>;
@@ -152,6 +164,8 @@
 		uart1: serial@48022000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart2";
+			clocks = <&dpll_per_m2_div4_ck>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 			reg = <0x48022000 0x2000>;
 			interrupts = <73>;
@@ -161,6 +175,8 @@
 		uart2: serial@48024000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart3";
+			clocks = <&dpll_per_m2_div4_ck>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 			reg = <0x48024000 0x2000>;
 			interrupts = <74>;
@@ -170,6 +186,8 @@
 		uart3: serial@481a6000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart4";
+			clocks = <&dpll_per_m2_div4_ck>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 			reg = <0x481a6000 0x2000>;
 			interrupts = <44>;
@@ -179,6 +197,8 @@
 		uart4: serial@481a8000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart5";
+			clocks = <&dpll_per_m2_div4_ck>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 			reg = <0x481a8000 0x2000>;
 			interrupts = <45>;
@@ -188,6 +208,8 @@
 		uart5: serial@481aa000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart6";
+			clocks = <&dpll_per_m2_div4_ck>;
+			clock-names = "fck";
 			clock-frequency = <48000000>;
 			reg = <0x481aa000 0x2000>;
 			interrupts = <46>;
@@ -199,6 +221,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c1";
+			clocks = <&dpll_per_m2_div4_wkupdm_ck>;
+			clock-names = "fck";
 			reg = <0x44e0b000 0x1000>;
 			interrupts = <70>;
 			status = "disabled";
@@ -209,6 +233,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c2";
+			clocks = <&dpll_per_m2_div4_ck>;
+			clock-names = "fck";
 			reg = <0x4802a000 0x1000>;
 			interrupts = <71>;
 			status = "disabled";
@@ -219,6 +245,8 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "i2c3";
+			clocks = <&dpll_per_m2_div4_ck>;
+			clock-names = "fck";
 			reg = <0x4819c000 0x1000>;
 			interrupts = <30>;
 			status = "disabled";
@@ -227,6 +255,8 @@
 		wdt2: wdt@44e35000 {
 			compatible = "ti,omap3-wdt";
 			ti,hwmods = "wd_timer2";
+			clocks = <&wdt1_fck>;
+			clock-names = "fck";
 			reg = <0x44e35000 0x1000>;
 			interrupts = <91>;
 		};
@@ -234,6 +264,8 @@
 		dcan0: d_can@481cc000 {
 			compatible = "bosch,d_can";
 			ti,hwmods = "d_can0";
+			clocks = <&dcan0_fck>;
+			clock-names = "fck";
 			reg = <0x481cc000 0x2000
 				0x44e10644 0x4>;
 			interrupts = <52>;
@@ -243,6 +275,8 @@
 		dcan1: d_can@481d0000 {
 			compatible = "bosch,d_can";
 			ti,hwmods = "d_can1";
+			clocks = <&dcan1_fck>;
+			clock-names = "fck";
 			reg = <0x481d0000 0x2000
 				0x44e10644 0x4>;
 			interrupts = <55>;
@@ -254,6 +288,8 @@
 			reg = <0x44e31000 0x400>;
 			interrupts = <67>;
 			ti,hwmods = "timer1";
+			clocks = <&timer1_fck>;
+			clock-names = "fck";
 			ti,timer-alwon;
 		};
 
@@ -262,6 +298,8 @@
 			reg = <0x48040000 0x400>;
 			interrupts = <68>;
 			ti,hwmods = "timer2";
+			clocks = <&timer2_fck>;
+			clock-names = "fck";
 		};
 
 		timer3: timer@48042000 {
@@ -269,6 +307,8 @@
 			reg = <0x48042000 0x400>;
 			interrupts = <69>;
 			ti,hwmods = "timer3";
+			clocks = <&timer3_fck>;
+			clock-names = "fck";
 		};
 
 		timer4: timer@48044000 {
@@ -276,6 +316,8 @@
 			reg = <0x48044000 0x400>;
 			interrupts = <92>;
 			ti,hwmods = "timer4";
+			clocks = <&timer4_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -284,6 +326,8 @@
 			reg = <0x48046000 0x400>;
 			interrupts = <93>;
 			ti,hwmods = "timer5";
+			clocks = <&timer5_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -292,6 +336,8 @@
 			reg = <0x48048000 0x400>;
 			interrupts = <94>;
 			ti,hwmods = "timer6";
+			clocks = <&timer6_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -300,6 +346,8 @@
 			reg = <0x4804a000 0x400>;
 			interrupts = <95>;
 			ti,hwmods = "timer7";
+			clocks = <&timer7_fck>;
+			clock-names = "fck";
 			ti,timer-pwm;
 		};
 
@@ -309,6 +357,8 @@
 			interrupts = <75
 				      76>;
 			ti,hwmods = "rtc";
+			clocks = <&clk_32768_ck>;
+			clock-names = "fck";
 		};
 
 		spi0: spi@48030000 {
@@ -319,6 +369,8 @@
 			interrupts = <65>;
 			ti,spi-num-cs = <2>;
 			ti,hwmods = "spi0";
+			clocks = <&dpll_per_m2_div4_ck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -330,6 +382,8 @@
 			interrupts = <125>;
 			ti,spi-num-cs = <2>;
 			ti,hwmods = "spi1";
+			clocks = <&dpll_per_m2_div4_ck>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -348,12 +402,16 @@
 			port1-mode = <3>;
 			power = <250>;
 			ti,hwmods = "usb_otg_hs";
+			clocks = <&usbotg_fck>;
+			clock-names = "fck";
 		};
 
 		epwmss0: epwmss@48300000 {
 			compatible = "ti,am33xx-pwmss";
 			reg = <0x48300000 0x10>;
 			ti,hwmods = "epwmss0";
+			clocks = <&l4ls_gclk>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			status = "disabled";
@@ -366,6 +424,8 @@
 				#pwm-cells = <3>;
 				reg = <0x48300100 0x80>;
 				ti,hwmods = "ecap0";
+			clocks = <&l4ls_gclk>;
+			clock-names = "fck";
 				status = "disabled";
 			};
 
@@ -374,6 +434,8 @@
 				#pwm-cells = <3>;
 				reg = <0x48300200 0x80>;
 				ti,hwmods = "ehrpwm0";
+			clocks = <&l4ls_gclk>;
+			clock-names = "fck";
 				status = "disabled";
 			};
 		};
@@ -382,6 +444,8 @@
 			compatible = "ti,am33xx-pwmss";
 			reg = <0x48302000 0x10>;
 			ti,hwmods = "epwmss1";
+			clocks = <&l4ls_gclk>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			status = "disabled";
@@ -394,6 +458,8 @@
 				#pwm-cells = <3>;
 				reg = <0x48302100 0x80>;
 				ti,hwmods = "ecap1";
+			clocks = <&l4ls_gclk>;
+			clock-names = "fck";
 				status = "disabled";
 			};
 
@@ -402,6 +468,8 @@
 				#pwm-cells = <3>;
 				reg = <0x48302200 0x80>;
 				ti,hwmods = "ehrpwm1";
+			clocks = <&l4ls_gclk>;
+			clock-names = "fck";
 				status = "disabled";
 			};
 		};
@@ -410,6 +478,8 @@
 			compatible = "ti,am33xx-pwmss";
 			reg = <0x48304000 0x10>;
 			ti,hwmods = "epwmss2";
+			clocks = <&l4ls_gclk>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			status = "disabled";
@@ -422,6 +492,8 @@
 				#pwm-cells = <3>;
 				reg = <0x48304100 0x80>;
 				ti,hwmods = "ecap2";
+			clocks = <&l4ls_gclk>;
+			clock-names = "fck";
 				status = "disabled";
 			};
 
@@ -430,6 +502,8 @@
 				#pwm-cells = <3>;
 				reg = <0x48304200 0x80>;
 				ti,hwmods = "ehrpwm2";
+			clocks = <&l4ls_gclk>;
+			clock-names = "fck";
 				status = "disabled";
 			};
 		};
@@ -437,6 +511,8 @@
 		mac: ethernet@4a100000 {
 			compatible = "ti,cpsw";
 			ti,hwmods = "cpgmac0";
+			clocks = <&cpsw_125mhz_gclk>;
+			clock-names = "fck";
 			cpdma_channels = <8>;
 			ale_entries = <1024>;
 			bd_ram_size = <0x2000>;
@@ -466,6 +542,8 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				ti,hwmods = "davinci_mdio";
+			clocks = <&cpsw_125mhz_gclk>;
+			clock-names = "fck";
 				bus_freq = <1000000>;
 				reg = <0x4a101000 0x100>;
 			};
@@ -485,6 +563,8 @@
 			compatible = "ti,am3352-ocmcram";
 			reg = <0x40300000 0x10000>;
 			ti,hwmods = "ocmcram";
+			clocks = <&l3_gclk>;
+			clock-names = "fck";
 		};
 
 		wkup_m3: wkup_m3@44d00000 {
@@ -492,6 +572,8 @@
 			reg = <0x44d00000 0x4000	/* M3 UMEM */
 			       0x44d80000 0x2000>;	/* M3 DMEM */
 			ti,hwmods = "wkup_m3";
+			clocks = <&dpll_core_m4_div2_ck>;
+			clock-names = "fck";
 		};
 
 		elm: elm@48080000 {
@@ -499,6 +581,8 @@
 			reg = <0x48080000 0x2000>;
 			interrupts = <4>;
 			ti,hwmods = "elm";
+			clocks = <&l4ls_gclk>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 
@@ -508,6 +592,8 @@
 			interrupt-parent = <&intc>;
 			interrupts = <16>;
 			ti,hwmods = "adc_tsc";
+			clocks = <&adc_tsc_fck>;
+			clock-names = "fck";
 			status = "disabled";
 
 			tsc {
@@ -522,6 +608,8 @@
 		gpmc: gpmc@50000000 {
 			compatible = "ti,am3352-gpmc";
 			ti,hwmods = "gpmc";
+			clocks = <&l3s_gclk>;
+			clock-names = "fck";
 			reg = <0x50000000 0x2000>;
 			interrupts = <100>;
 			gpmc,num-cs = <7>;
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index eb2f3b9..46de57b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -75,7 +75,6 @@ static struct omap_hwmod am33xx_l3_main_hwmod = {
 	.class		= &am33xx_l3_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
 	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
-	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_L3_CLKCTRL_OFFSET,
@@ -199,7 +198,6 @@ static struct omap_hwmod am33xx_wkup_m3_hwmod = {
 	.clkdm_name	= "l4_wkup_aon_clkdm",
 	/* Keep hardreset asserted */
 	.flags		= HWMOD_INIT_NO_RESET | HWMOD_NO_IDLEST,
-	.main_clk	= "dpll_core_m4_div2_ck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_WKUP_WKUP_M3_CLKCTRL_OFFSET,
@@ -306,7 +304,6 @@ static struct omap_hwmod am33xx_adc_tsc_hwmod = {
 	.name		= "adc_tsc",
 	.class		= &am33xx_adc_tsc_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.main_clk	= "adc_tsc_fck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_WKUP_ADC_TSC_CLKCTRL_OFFSET,
@@ -473,7 +470,6 @@ static struct omap_hwmod am33xx_ocmcram_hwmod = {
 	.class		= &am33xx_ocmcram_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
 	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
-	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_OCMCRAM_CLKCTRL_OFFSET,
@@ -561,7 +557,6 @@ static struct omap_hwmod am33xx_cpgmac0_hwmod = {
 	.class		= &am33xx_cpgmac0_hwmod_class,
 	.clkdm_name	= "cpsw_125mhz_clkdm",
 	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
-	.main_clk	= "cpsw_125mhz_gclk",
 	.mpu_rt_idx	= 1,
 	.prcm		= {
 		.omap4	= {
@@ -582,7 +577,6 @@ static struct omap_hwmod am33xx_mdio_hwmod = {
 	.name		= "davinci_mdio",
 	.class		= &am33xx_mdio_hwmod_class,
 	.clkdm_name	= "cpsw_125mhz_clkdm",
-	.main_clk	= "cpsw_125mhz_gclk",
 };
 
 /*
@@ -597,7 +591,6 @@ static struct omap_hwmod am33xx_dcan0_hwmod = {
 	.name		= "d_can0",
 	.class		= &am33xx_dcan_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "dcan0_fck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_DCAN0_CLKCTRL_OFFSET,
@@ -611,7 +604,6 @@ static struct omap_hwmod am33xx_dcan1_hwmod = {
 	.name		= "d_can1",
 	.class		= &am33xx_dcan_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "dcan1_fck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_DCAN1_CLKCTRL_OFFSET,
@@ -641,7 +633,6 @@ static struct omap_hwmod am33xx_elm_hwmod = {
 	.name		= "elm",
 	.class		= &am33xx_elm_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_ELM_CLKCTRL_OFFSET,
@@ -683,7 +674,6 @@ static struct omap_hwmod am33xx_epwmss0_hwmod = {
 	.name		= "epwmss0",
 	.class		= &am33xx_epwmss_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_EPWMSS0_CLKCTRL_OFFSET,
@@ -697,7 +687,6 @@ static struct omap_hwmod am33xx_ecap0_hwmod = {
 	.name		= "ecap0",
 	.class		= &am33xx_ecap_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
 };
 
 /* eqep0 */
@@ -713,7 +702,6 @@ static struct omap_hwmod am33xx_ehrpwm0_hwmod = {
 	.name		= "ehrpwm0",
 	.class		= &am33xx_ehrpwm_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
 };
 
 /* epwmss1 */
@@ -721,7 +709,6 @@ static struct omap_hwmod am33xx_epwmss1_hwmod = {
 	.name		= "epwmss1",
 	.class		= &am33xx_epwmss_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_EPWMSS1_CLKCTRL_OFFSET,
@@ -735,7 +722,6 @@ static struct omap_hwmod am33xx_ecap1_hwmod = {
 	.name		= "ecap1",
 	.class		= &am33xx_ecap_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
 };
 
 /* eqep1 */
@@ -751,7 +737,6 @@ static struct omap_hwmod am33xx_ehrpwm1_hwmod = {
 	.name		= "ehrpwm1",
 	.class		= &am33xx_ehrpwm_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
 };
 
 /* epwmss2 */
@@ -759,7 +744,6 @@ static struct omap_hwmod am33xx_epwmss2_hwmod = {
 	.name		= "epwmss2",
 	.class		= &am33xx_epwmss_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_EPWMSS2_CLKCTRL_OFFSET,
@@ -773,7 +757,6 @@ static struct omap_hwmod am33xx_ecap2_hwmod = {
 	.name		= "ecap2",
 	.class		= &am33xx_ecap_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
 };
 
 /* eqep2 */
@@ -789,7 +772,6 @@ static struct omap_hwmod am33xx_ehrpwm2_hwmod = {
 	.name		= "ehrpwm2",
 	.class		= &am33xx_ehrpwm_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
 };
 
 /*
@@ -819,90 +801,66 @@ static struct omap_gpio_dev_attr gpio_dev_attr = {
 };
 
 /* gpio0 */
-static struct omap_hwmod_opt_clk gpio0_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio0_dbclk" },
-};
 
 static struct omap_hwmod am33xx_gpio0_hwmod = {
 	.name		= "gpio1",
 	.class		= &am33xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "dpll_core_m4_div2_ck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_WKUP_GPIO0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= gpio0_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio0_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
 /* gpio1 */
-static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio1_dbclk" },
-};
 
 static struct omap_hwmod am33xx_gpio1_hwmod = {
 	.name		= "gpio2",
 	.class		= &am33xx_gpio_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_GPIO1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
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
 
 static struct omap_hwmod am33xx_gpio2_hwmod = {
 	.name		= "gpio3",
 	.class		= &am33xx_gpio_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_GPIO2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
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
 
 static struct omap_hwmod am33xx_gpio3_hwmod = {
 	.name		= "gpio4",
 	.class		= &am33xx_gpio_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_GPIO3_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= gpio3_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio3_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
@@ -927,7 +885,6 @@ static struct omap_hwmod am33xx_gpmc_hwmod = {
 	.class		= &am33xx_gpmc_hwmod_class,
 	.clkdm_name	= "l3s_clkdm",
 	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
-	.main_clk	= "l3s_gclk",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_GPMC_CLKCTRL_OFFSET,
@@ -965,7 +922,6 @@ static struct omap_hwmod am33xx_i2c1_hwmod = {
 	.class		= &i2c_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "dpll_per_m2_div4_wkupdm_ck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_WKUP_I2C0_CLKCTRL_OFFSET,
@@ -981,7 +937,6 @@ static struct omap_hwmod am33xx_i2c2_hwmod = {
 	.class		= &i2c_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4 = {
 			.clkctrl_offs	= AM33XX_CM_PER_I2C1_CLKCTRL_OFFSET,
@@ -997,7 +952,6 @@ static struct omap_hwmod am33xx_i2c3_hwmod = {
 	.class		= &i2c_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_I2C2_CLKCTRL_OFFSET,
@@ -1207,7 +1161,6 @@ static struct omap_hwmod am33xx_rtc_hwmod = {
 	.name		= "rtc",
 	.class		= &am33xx_rtc_hwmod_class,
 	.clkdm_name	= "l4_rtc_clkdm",
-	.main_clk	= "clk_32768_ck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_RTC_RTC_CLKCTRL_OFFSET,
@@ -1242,7 +1195,6 @@ static struct omap_hwmod am33xx_spi0_hwmod = {
 	.name		= "spi0",
 	.class		= &am33xx_spi_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_SPI0_CLKCTRL_OFFSET,
@@ -1257,7 +1209,6 @@ static struct omap_hwmod am33xx_spi1_hwmod = {
 	.name		= "spi1",
 	.class		= &am33xx_spi_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_SPI1_CLKCTRL_OFFSET,
@@ -1326,7 +1277,6 @@ static struct omap_hwmod am33xx_timer1_hwmod = {
 	.name		= "timer1",
 	.class		= &am33xx_timer1ms_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.main_clk	= "timer1_fck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_WKUP_TIMER1_CLKCTRL_OFFSET,
@@ -1339,7 +1289,6 @@ static struct omap_hwmod am33xx_timer2_hwmod = {
 	.name		= "timer2",
 	.class		= &am33xx_timer_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "timer2_fck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_TIMER2_CLKCTRL_OFFSET,
@@ -1352,7 +1301,6 @@ static struct omap_hwmod am33xx_timer3_hwmod = {
 	.name		= "timer3",
 	.class		= &am33xx_timer_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "timer3_fck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_TIMER3_CLKCTRL_OFFSET,
@@ -1365,7 +1313,6 @@ static struct omap_hwmod am33xx_timer4_hwmod = {
 	.name		= "timer4",
 	.class		= &am33xx_timer_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "timer4_fck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_TIMER4_CLKCTRL_OFFSET,
@@ -1378,7 +1325,6 @@ static struct omap_hwmod am33xx_timer5_hwmod = {
 	.name		= "timer5",
 	.class		= &am33xx_timer_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "timer5_fck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_TIMER5_CLKCTRL_OFFSET,
@@ -1391,7 +1337,6 @@ static struct omap_hwmod am33xx_timer6_hwmod = {
 	.name		= "timer6",
 	.class		= &am33xx_timer_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "timer6_fck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_TIMER6_CLKCTRL_OFFSET,
@@ -1404,7 +1349,6 @@ static struct omap_hwmod am33xx_timer7_hwmod = {
 	.name		= "timer7",
 	.class		= &am33xx_timer_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "timer7_fck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_TIMER7_CLKCTRL_OFFSET,
@@ -1514,7 +1458,6 @@ static struct omap_hwmod am33xx_uart1_hwmod = {
 	.class		= &uart_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.flags		= DEBUG_AM33XXUART1_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "dpll_per_m2_div4_wkupdm_ck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_WKUP_UART0_CLKCTRL_OFFSET,
@@ -1528,7 +1471,6 @@ static struct omap_hwmod am33xx_uart2_hwmod = {
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_UART1_CLKCTRL_OFFSET,
@@ -1543,7 +1485,6 @@ static struct omap_hwmod am33xx_uart3_hwmod = {
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_UART2_CLKCTRL_OFFSET,
@@ -1557,7 +1498,6 @@ static struct omap_hwmod am33xx_uart4_hwmod = {
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_UART3_CLKCTRL_OFFSET,
@@ -1571,7 +1511,6 @@ static struct omap_hwmod am33xx_uart5_hwmod = {
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_UART4_CLKCTRL_OFFSET,
@@ -1585,7 +1524,6 @@ static struct omap_hwmod am33xx_uart6_hwmod = {
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_UART5_CLKCTRL_OFFSET,
@@ -1621,7 +1559,6 @@ static struct omap_hwmod am33xx_wd_timer1_hwmod = {
 	.class		= &am33xx_wd_timer_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE,
-	.main_clk	= "wdt1_fck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_WKUP_WDT1_CLKCTRL_OFFSET,
@@ -1653,7 +1590,6 @@ static struct omap_hwmod am33xx_usbss_hwmod = {
 	.class		= &am33xx_usbotg_class,
 	.clkdm_name	= "l3s_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
-	.main_clk	= "usbotg_fck",
 	.prcm		= {
 		.omap4	= {
 			.clkctrl_offs	= AM33XX_CM_PER_USB0_CLKCTRL_OFFSET,
-- 
1.7.9.5

