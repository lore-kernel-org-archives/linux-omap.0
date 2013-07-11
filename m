From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH RFC 03/13] ARM: OMAP2+: hwmod: AMx3: remove common static fields
Date: Thu, 11 Jul 2013 12:05:38 +0530
Message-ID: <937b821fd59e9260d5f7c9c84ee5a4915f1cdaa4.1373519192.git.afzal@ti.com>
References: <cover.1373519192.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38866 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009Ab3GKGgH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Jul 2013 02:36:07 -0400
In-Reply-To: <cover.1373519192.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <benoit.cousson@linaro.org>, Tony Lindgren <tony@atomide.com>

Hwmod common to AM43x & AM335x has some of fields different (CLKCTRL,
RSTCTRL, RSTST, ocpif clk and clockdomain). It is now updated based
on SoC detection at run time, hence remove statically initialized
entries.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 79 ------------------------------
 1 file changed, 79 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 57234a0..a61032d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -79,7 +79,6 @@ static struct omap_hwmod am33xx_l3_main_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_L3_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -101,7 +100,6 @@ static struct omap_hwmod am33xx_l3_instr_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_L3_INSTR_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -124,7 +122,6 @@ static struct omap_hwmod am33xx_l4_ls_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_L4LS_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -134,12 +131,10 @@ static struct omap_hwmod am33xx_l4_ls_hwmod = {
 static struct omap_hwmod am33xx_l4_hs_hwmod = {
 	.name		= "l4_hs",
 	.class		= &am33xx_l4_hwmod_class,
-	.clkdm_name	= "l4hs_clkdm",
 	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
 	.main_clk	= "l4hs_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_L4HS_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -154,7 +149,6 @@ static struct omap_hwmod am33xx_l4_wkup_hwmod = {
 	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_L4WKUP_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -175,7 +169,6 @@ static struct omap_hwmod am33xx_mpu_hwmod = {
 	.main_clk	= "dpll_mpu_m2_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_MPU_MPU_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -200,12 +193,8 @@ static struct omap_hwmod am33xx_wkup_m3_hwmod = {
 	.clkdm_name	= "l4_wkup_aon_clkdm",
 	/* Keep hardreset asserted */
 	.flags		= HWMOD_INIT_NO_RESET | HWMOD_NO_IDLEST,
-	.main_clk	= "dpll_core_m4_div2_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_WKUP_M3_CLKCTRL_OFFSET,
-			.rstctrl_offs	= AM33XX_RM_WKUP_RSTCTRL_OFFSET,
-			.rstst_offs	= AM33XX_RM_WKUP_RSTST_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -234,8 +223,6 @@ static struct omap_hwmod am33xx_pruss_hwmod = {
 	.main_clk	= "pruss_ocp_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_PRUSS_CLKCTRL_OFFSET,
-			.rstctrl_offs	= AM33XX_RM_PER_RSTCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -260,9 +247,6 @@ static struct omap_hwmod am33xx_gfx_hwmod = {
 	.main_clk	= "gfx_fck_div_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_GFX_GFX_CLKCTRL_OFFSET,
-			.rstctrl_offs	= AM33XX_RM_GFX_RSTCTRL_OFFSET,
-			.rstst_offs	= AM33XX_RM_GFX_RSTST_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -306,11 +290,9 @@ static struct omap_hwmod_class am33xx_adc_tsc_hwmod_class = {
 static struct omap_hwmod am33xx_adc_tsc_hwmod = {
 	.name		= "adc_tsc",
 	.class		= &am33xx_adc_tsc_hwmod_class,
-	.clkdm_name	= "l4_wkup_clkdm",
 	.main_clk	= "adc_tsc_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_ADC_TSC_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -432,7 +414,6 @@ static struct omap_hwmod am33xx_aes0_hwmod = {
 	.main_clk	= "aes0_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_AES0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -458,7 +439,6 @@ static struct omap_hwmod am33xx_sha0_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_SHA0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -477,7 +457,6 @@ static struct omap_hwmod am33xx_ocmcram_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_OCMCRAM_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -496,7 +475,6 @@ static struct omap_hwmod am33xx_smartreflex0_hwmod = {
 	.main_clk	= "smartreflex0_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_SMARTREFLEX0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -510,7 +488,6 @@ static struct omap_hwmod am33xx_smartreflex1_hwmod = {
 	.main_clk	= "smartreflex1_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_SMARTREFLEX1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -528,10 +505,8 @@ static struct omap_hwmod am33xx_control_hwmod = {
 	.class		= &am33xx_control_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
-	.main_clk	= "dpll_core_m4_div2_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_CONTROL_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -566,7 +541,6 @@ static struct omap_hwmod am33xx_cpgmac0_hwmod = {
 	.mpu_rt_idx	= 1,
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_CPGMAC0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -601,7 +575,6 @@ static struct omap_hwmod am33xx_dcan0_hwmod = {
 	.main_clk	= "dcan0_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_DCAN0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -615,7 +588,6 @@ static struct omap_hwmod am33xx_dcan1_hwmod = {
 	.main_clk	= "dcan1_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_DCAN1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -645,7 +617,6 @@ static struct omap_hwmod am33xx_elm_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_ELM_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -687,7 +658,6 @@ static struct omap_hwmod am33xx_epwmss0_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_EPWMSS0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -725,7 +695,6 @@ static struct omap_hwmod am33xx_epwmss1_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_EPWMSS1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -763,7 +732,6 @@ static struct omap_hwmod am33xx_epwmss2_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_EPWMSS2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -829,10 +797,8 @@ static struct omap_hwmod am33xx_gpio0_hwmod = {
 	.class		= &am33xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "dpll_core_m4_div2_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_GPIO0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -854,7 +820,6 @@ static struct omap_hwmod am33xx_gpio1_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_GPIO1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -876,7 +841,6 @@ static struct omap_hwmod am33xx_gpio2_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_GPIO2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -898,7 +862,6 @@ static struct omap_hwmod am33xx_gpio3_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_GPIO3_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -931,7 +894,6 @@ static struct omap_hwmod am33xx_gpmc_hwmod = {
 	.main_clk	= "l3s_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_GPMC_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -969,7 +931,6 @@ static struct omap_hwmod am33xx_i2c1_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_wkupdm_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_I2C0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -985,7 +946,6 @@ static struct omap_hwmod am33xx_i2c2_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_offs	= AM33XX_CM_PER_I2C1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1001,7 +961,6 @@ static struct omap_hwmod am33xx_i2c3_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_I2C2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1063,7 +1022,6 @@ static struct omap_hwmod am33xx_mailbox_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs	= AM33XX_CM_PER_MAILBOX0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1093,7 +1051,6 @@ static struct omap_hwmod am33xx_mcasp0_hwmod = {
 	.main_clk	= "mcasp0_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_MCASP0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1107,7 +1064,6 @@ static struct omap_hwmod am33xx_mcasp1_hwmod = {
 	.main_clk	= "mcasp1_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_MCASP1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1142,7 +1098,6 @@ static struct omap_hwmod am33xx_mmc0_hwmod = {
 	.main_clk	= "mmc_clk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_MMC0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1161,7 +1116,6 @@ static struct omap_hwmod am33xx_mmc1_hwmod = {
 	.main_clk	= "mmc_clk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_MMC1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1179,7 +1133,6 @@ static struct omap_hwmod am33xx_mmc2_hwmod = {
 	.main_clk	= "mmc_clk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_MMC2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1211,7 +1164,6 @@ static struct omap_hwmod am33xx_rtc_hwmod = {
 	.main_clk	= "clk_32768_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_RTC_RTC_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1246,7 +1198,6 @@ static struct omap_hwmod am33xx_spi0_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_SPI0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1261,7 +1212,6 @@ static struct omap_hwmod am33xx_spi1_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_SPI1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1284,7 +1234,6 @@ static struct omap_hwmod am33xx_spinlock_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_SPINLOCK_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1330,7 +1279,6 @@ static struct omap_hwmod am33xx_timer1_hwmod = {
 	.main_clk	= "timer1_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_TIMER1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1343,7 +1291,6 @@ static struct omap_hwmod am33xx_timer2_hwmod = {
 	.main_clk	= "timer2_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TIMER2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1356,7 +1303,6 @@ static struct omap_hwmod am33xx_timer3_hwmod = {
 	.main_clk	= "timer3_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TIMER3_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1369,7 +1315,6 @@ static struct omap_hwmod am33xx_timer4_hwmod = {
 	.main_clk	= "timer4_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TIMER4_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1382,7 +1327,6 @@ static struct omap_hwmod am33xx_timer5_hwmod = {
 	.main_clk	= "timer5_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TIMER5_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1395,7 +1339,6 @@ static struct omap_hwmod am33xx_timer6_hwmod = {
 	.main_clk	= "timer6_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TIMER6_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1408,7 +1351,6 @@ static struct omap_hwmod am33xx_timer7_hwmod = {
 	.main_clk	= "timer7_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TIMER7_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1426,7 +1368,6 @@ static struct omap_hwmod am33xx_tpcc_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TPCC_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1456,7 +1397,6 @@ static struct omap_hwmod am33xx_tptc0_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TPTC0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1471,7 +1411,6 @@ static struct omap_hwmod am33xx_tptc1_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TPTC1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1486,7 +1425,6 @@ static struct omap_hwmod am33xx_tptc2_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TPTC2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1518,7 +1456,6 @@ static struct omap_hwmod am33xx_uart1_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_wkupdm_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_UART0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1532,7 +1469,6 @@ static struct omap_hwmod am33xx_uart2_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_UART1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1547,7 +1483,6 @@ static struct omap_hwmod am33xx_uart3_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_UART2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1561,7 +1496,6 @@ static struct omap_hwmod am33xx_uart4_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_UART3_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1575,7 +1509,6 @@ static struct omap_hwmod am33xx_uart5_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_UART4_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1589,7 +1522,6 @@ static struct omap_hwmod am33xx_uart6_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_UART5_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1625,7 +1557,6 @@ static struct omap_hwmod am33xx_wd_timer1_hwmod = {
 	.main_clk	= "wdt1_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_WDT1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1761,7 +1692,6 @@ static struct omap_hwmod_ocp_if am33xx_pruss__l3_main = {
 static struct omap_hwmod_ocp_if am33xx_wkup_m3__l4_wkup = {
 	.master		= &am33xx_wkup_m3_hwmod,
 	.slave		= &am33xx_l4_wkup_hwmod,
-	.clk		= "dpll_core_m4_div2_ck",
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -1777,7 +1707,6 @@ static struct omap_hwmod_ocp_if am33xx_gfx__l3_main = {
 static struct omap_hwmod_ocp_if am33xx_l4_wkup__wkup_m3 = {
 	.master		= &am33xx_l4_wkup_hwmod,
 	.slave		= &am33xx_wkup_m3_hwmod,
-	.clk		= "dpll_core_m4_div2_ck",
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -1801,7 +1730,6 @@ static struct omap_hwmod_ocp_if am33xx_l3_main__gfx = {
 static struct omap_hwmod_ocp_if am33xx_l4_wkup__smartreflex0 = {
 	.master		= &am33xx_l4_wkup_hwmod,
 	.slave		= &am33xx_smartreflex0_hwmod,
-	.clk		= "dpll_core_m4_div2_ck",
 	.user		= OCP_USER_MPU,
 };
 
@@ -1809,7 +1737,6 @@ static struct omap_hwmod_ocp_if am33xx_l4_wkup__smartreflex0 = {
 static struct omap_hwmod_ocp_if am33xx_l4_wkup__smartreflex1 = {
 	.master		= &am33xx_l4_wkup_hwmod,
 	.slave		= &am33xx_smartreflex1_hwmod,
-	.clk		= "dpll_core_m4_div2_ck",
 	.user		= OCP_USER_MPU,
 };
 
@@ -1817,7 +1744,6 @@ static struct omap_hwmod_ocp_if am33xx_l4_wkup__smartreflex1 = {
 static struct omap_hwmod_ocp_if am33xx_l4_wkup__control = {
 	.master		= &am33xx_l4_wkup_hwmod,
 	.slave		= &am33xx_control_hwmod,
-	.clk		= "dpll_core_m4_div2_ck",
 	.user		= OCP_USER_MPU,
 };
 
@@ -1873,7 +1799,6 @@ static struct omap_hwmod_ocp_if am33xx_l4_per__gpio3 = {
 static struct omap_hwmod_ocp_if am33xx_l4_wkup__i2c1 = {
 	.master		= &am33xx_l4_wkup_hwmod,
 	.slave		= &am33xx_i2c1_hwmod,
-	.clk		= "dpll_core_m4_div2_ck",
 	.user		= OCP_USER_MPU,
 };
 
@@ -1881,7 +1806,6 @@ static struct omap_hwmod_ocp_if am33xx_l4_wkup__i2c1 = {
 static struct omap_hwmod_ocp_if am33xx_l4_wkup__gpio0 = {
 	.master		= &am33xx_l4_wkup_hwmod,
 	.slave		= &am33xx_gpio0_hwmod,
-	.clk		= "dpll_core_m4_div2_ck",
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -2234,7 +2158,6 @@ static struct omap_hwmod_ocp_if am33xx_l4_ls__mcspi1 = {
 static struct omap_hwmod_ocp_if am33xx_l4_wkup__timer1 = {
 	.master		= &am33xx_l4_wkup_hwmod,
 	.slave		= &am33xx_timer1_hwmod,
-	.clk		= "dpll_core_m4_div2_ck",
 	.user		= OCP_USER_MPU,
 };
 
@@ -2352,7 +2275,6 @@ static struct omap_hwmod_ocp_if am33xx_l3_main__tptc2 = {
 static struct omap_hwmod_ocp_if am33xx_l4_wkup__uart1 = {
 	.master		= &am33xx_l4_wkup_hwmod,
 	.slave		= &am33xx_uart1_hwmod,
-	.clk		= "dpll_core_m4_div2_ck",
 	.user		= OCP_USER_MPU,
 };
 
@@ -2400,7 +2322,6 @@ static struct omap_hwmod_ocp_if am33xx_l4_ls__uart6 = {
 static struct omap_hwmod_ocp_if am33xx_l4_wkup__wd_timer1 = {
 	.master		= &am33xx_l4_wkup_hwmod,
 	.slave		= &am33xx_wd_timer1_hwmod,
-	.clk		= "dpll_core_m4_div2_ck",
 	.user		= OCP_USER_MPU,
 };
 
-- 
1.8.3.1

