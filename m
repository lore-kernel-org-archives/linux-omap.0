From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH RFC v3 05/12] ARM: OMAP2+: hwmod: AM335x: remove static register offs
Date: Mon, 16 Sep 2013 19:18:03 +0530
Message-ID: <25a366ecdd87ddde6e264d01caa1f178f8e5b73a.1379337301.git.afzal@ti.com>
References: <cover.1379337301.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37957 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755348Ab3IPNsb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Sep 2013 09:48:31 -0400
In-Reply-To: <cover.1379337301.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hwmod common to AM43x and AM335x has register offsets different. It is
now updated based on SoC detection at run time, hence remove statically
initialized ones.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 50 ----------------------
 1 file changed, 50 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index 47e0c0b..db45084 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -51,7 +51,6 @@ struct omap_hwmod am33xx_l3_main_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_L3_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -73,7 +72,6 @@ struct omap_hwmod am33xx_l3_instr_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_L3_INSTR_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -96,7 +94,6 @@ struct omap_hwmod am33xx_l4_ls_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_L4LS_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -110,7 +107,6 @@ struct omap_hwmod am33xx_l4_wkup_hwmod = {
 	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_L4WKUP_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -131,7 +127,6 @@ struct omap_hwmod am33xx_mpu_hwmod = {
 	.main_clk	= "dpll_mpu_m2_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_MPU_MPU_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -158,7 +153,6 @@ struct omap_hwmod am33xx_pruss_hwmod = {
 	.main_clk	= "pruss_ocp_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_PRUSS_CLKCTRL_OFFSET,
 			.rstctrl_offs	= AM33XX_RM_PER_RSTCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
@@ -184,7 +178,6 @@ struct omap_hwmod am33xx_gfx_hwmod = {
 	.main_clk	= "gfx_fck_div_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_GFX_GFX_CLKCTRL_OFFSET,
 			.rstctrl_offs	= AM33XX_RM_GFX_RSTCTRL_OFFSET,
 			.rstst_offs	= AM33XX_RM_GFX_RSTST_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
@@ -249,7 +242,6 @@ struct omap_hwmod am33xx_aes0_hwmod = {
 	.main_clk	= "aes0_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_AES0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -275,7 +267,6 @@ struct omap_hwmod am33xx_sha0_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_SHA0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -294,7 +285,6 @@ struct omap_hwmod am33xx_ocmcram_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_OCMCRAM_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -313,7 +303,6 @@ struct omap_hwmod am33xx_smartreflex0_hwmod = {
 	.main_clk	= "smartreflex0_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_SMARTREFLEX0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -327,7 +316,6 @@ struct omap_hwmod am33xx_smartreflex1_hwmod = {
 	.main_clk	= "smartreflex1_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_SMARTREFLEX1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -362,7 +350,6 @@ struct omap_hwmod am33xx_cpgmac0_hwmod = {
 	.mpu_rt_idx	= 1,
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_CPGMAC0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -397,7 +384,6 @@ struct omap_hwmod am33xx_dcan0_hwmod = {
 	.main_clk	= "dcan0_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_DCAN0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -411,7 +397,6 @@ struct omap_hwmod am33xx_dcan1_hwmod = {
 	.main_clk	= "dcan1_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_DCAN1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -441,7 +426,6 @@ struct omap_hwmod am33xx_elm_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_ELM_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -483,7 +467,6 @@ struct omap_hwmod am33xx_epwmss0_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_EPWMSS0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -521,7 +504,6 @@ struct omap_hwmod am33xx_epwmss1_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_EPWMSS1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -559,7 +541,6 @@ struct omap_hwmod am33xx_epwmss2_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_EPWMSS2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -628,7 +609,6 @@ struct omap_hwmod am33xx_gpio1_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_GPIO1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -650,7 +630,6 @@ struct omap_hwmod am33xx_gpio2_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_GPIO2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -672,7 +651,6 @@ struct omap_hwmod am33xx_gpio3_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_GPIO3_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -705,7 +683,6 @@ struct omap_hwmod am33xx_gpmc_hwmod = {
 	.main_clk	= "l3s_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_GPMC_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -759,7 +736,6 @@ struct omap_hwmod am33xx_i2c2_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_offs	= AM33XX_CM_PER_I2C1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -775,7 +751,6 @@ struct omap_hwmod am33xx_i2c3_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_I2C2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -808,7 +783,6 @@ struct omap_hwmod am33xx_mailbox_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs	= AM33XX_CM_PER_MAILBOX0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -838,7 +812,6 @@ struct omap_hwmod am33xx_mcasp0_hwmod = {
 	.main_clk	= "mcasp0_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_MCASP0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -852,7 +825,6 @@ struct omap_hwmod am33xx_mcasp1_hwmod = {
 	.main_clk	= "mcasp1_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_MCASP1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -887,7 +859,6 @@ struct omap_hwmod am33xx_mmc0_hwmod = {
 	.main_clk	= "mmc_clk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_MMC0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -906,7 +877,6 @@ struct omap_hwmod am33xx_mmc1_hwmod = {
 	.main_clk	= "mmc_clk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_MMC1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -924,7 +894,6 @@ struct omap_hwmod am33xx_mmc2_hwmod = {
 	.main_clk	= "mmc_clk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_MMC2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -956,7 +925,6 @@ struct omap_hwmod am33xx_rtc_hwmod = {
 	.main_clk	= "clk_32768_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_RTC_RTC_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -991,7 +959,6 @@ struct omap_hwmod am33xx_spi0_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_SPI0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1006,7 +973,6 @@ struct omap_hwmod am33xx_spi1_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_SPI1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1029,7 +995,6 @@ struct omap_hwmod am33xx_spinlock_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_SPINLOCK_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1088,7 +1053,6 @@ struct omap_hwmod am33xx_timer2_hwmod = {
 	.main_clk	= "timer2_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TIMER2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1101,7 +1065,6 @@ struct omap_hwmod am33xx_timer3_hwmod = {
 	.main_clk	= "timer3_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TIMER3_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1114,7 +1077,6 @@ struct omap_hwmod am33xx_timer4_hwmod = {
 	.main_clk	= "timer4_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TIMER4_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1127,7 +1089,6 @@ struct omap_hwmod am33xx_timer5_hwmod = {
 	.main_clk	= "timer5_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TIMER5_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1140,7 +1101,6 @@ struct omap_hwmod am33xx_timer6_hwmod = {
 	.main_clk	= "timer6_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TIMER6_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1153,7 +1113,6 @@ struct omap_hwmod am33xx_timer7_hwmod = {
 	.main_clk	= "timer7_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TIMER7_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1171,7 +1130,6 @@ struct omap_hwmod am33xx_tpcc_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TPCC_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1201,7 +1159,6 @@ struct omap_hwmod am33xx_tptc0_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TPTC0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1216,7 +1173,6 @@ struct omap_hwmod am33xx_tptc1_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TPTC1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1231,7 +1187,6 @@ struct omap_hwmod am33xx_tptc2_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TPTC2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1276,7 +1231,6 @@ struct omap_hwmod am33xx_uart2_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_UART1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1291,7 +1245,6 @@ struct omap_hwmod am33xx_uart3_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_UART2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1305,7 +1258,6 @@ struct omap_hwmod am33xx_uart4_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_UART3_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1319,7 +1271,6 @@ struct omap_hwmod am33xx_uart5_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_UART4_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1333,7 +1284,6 @@ struct omap_hwmod am33xx_uart6_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_UART5_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
-- 
1.8.3.4

