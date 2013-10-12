From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v6 04/11] ARM: OMAP2+: hwmod: AM335x: remove static register offs
Date: Sat, 12 Oct 2013 15:45:36 +0530
Message-ID: <771f8cd8bbd120d2d4e92f6b791ac7c6ae50e0da.1381569236.git.afzal@ti.com>
References: <cover.1381569236.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57851 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579Ab3JLKQE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Oct 2013 06:16:04 -0400
In-Reply-To: <cover.1381569236.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rajendra Nayak <rnayak@ti.com>

Hwmod common to AM43x and AM335x has register offsets different. It is
now updated based on SoC detection at run time, hence remove statically
initialized ones.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Acked-by: Rajendra Nayak <rnayak@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 57 ----------------------
 1 file changed, 57 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index e66d02a..ffb371ff 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -44,7 +44,6 @@ struct omap_hwmod am33xx_l3_main_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_L3_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -66,7 +65,6 @@ struct omap_hwmod am33xx_l3_instr_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_L3_INSTR_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -89,7 +87,6 @@ struct omap_hwmod am33xx_l4_ls_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_L4LS_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -103,7 +100,6 @@ struct omap_hwmod am33xx_l4_wkup_hwmod = {
 	.flags		= HWMOD_INIT_NO_IDLE,
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_L4WKUP_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -124,7 +120,6 @@ struct omap_hwmod am33xx_mpu_hwmod = {
 	.main_clk	= "dpll_mpu_m2_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_MPU_MPU_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -159,8 +154,6 @@ struct omap_hwmod am33xx_pruss_hwmod = {
 	.main_clk	= "pruss_ocp_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_PRUSS_CLKCTRL_OFFSET,
-			.rstctrl_offs	= AM33XX_RM_PER_RSTCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -185,9 +178,6 @@ struct omap_hwmod am33xx_gfx_hwmod = {
 	.main_clk	= "gfx_fck_div_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_GFX_GFX_CLKCTRL_OFFSET,
-			.rstctrl_offs	= AM33XX_RM_GFX_RSTCTRL_OFFSET,
-			.rstst_offs	= AM33XX_RM_GFX_RSTST_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -232,7 +222,6 @@ struct omap_hwmod am33xx_aes0_hwmod = {
 	.main_clk	= "aes0_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_AES0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -258,7 +247,6 @@ struct omap_hwmod am33xx_sha0_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_SHA0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -277,7 +265,6 @@ struct omap_hwmod am33xx_ocmcram_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_OCMCRAM_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -296,7 +283,6 @@ struct omap_hwmod am33xx_smartreflex0_hwmod = {
 	.main_clk	= "smartreflex0_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_SMARTREFLEX0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -310,7 +296,6 @@ struct omap_hwmod am33xx_smartreflex1_hwmod = {
 	.main_clk	= "smartreflex1_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_SMARTREFLEX1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -352,7 +337,6 @@ struct omap_hwmod am33xx_cpgmac0_hwmod = {
 	.mpu_rt_idx	= 1,
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_CPGMAC0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -387,7 +371,6 @@ struct omap_hwmod am33xx_dcan0_hwmod = {
 	.main_clk	= "dcan0_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_DCAN0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -401,7 +384,6 @@ struct omap_hwmod am33xx_dcan1_hwmod = {
 	.main_clk	= "dcan1_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_DCAN1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -431,7 +413,6 @@ struct omap_hwmod am33xx_elm_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_ELM_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -473,7 +454,6 @@ struct omap_hwmod am33xx_epwmss0_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_EPWMSS0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -511,7 +491,6 @@ struct omap_hwmod am33xx_epwmss1_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_EPWMSS1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -549,7 +528,6 @@ struct omap_hwmod am33xx_epwmss2_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_EPWMSS2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -618,7 +596,6 @@ struct omap_hwmod am33xx_gpio1_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_GPIO1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -640,7 +617,6 @@ struct omap_hwmod am33xx_gpio2_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_GPIO2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -662,7 +638,6 @@ struct omap_hwmod am33xx_gpio3_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_GPIO3_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -695,7 +670,6 @@ struct omap_hwmod am33xx_gpmc_hwmod = {
 	.main_clk	= "l3s_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_GPMC_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -733,7 +707,6 @@ struct omap_hwmod am33xx_i2c1_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_wkupdm_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_I2C0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -749,7 +722,6 @@ struct omap_hwmod am33xx_i2c2_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4 = {
-			.clkctrl_offs	= AM33XX_CM_PER_I2C1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -765,7 +737,6 @@ struct omap_hwmod am33xx_i2c3_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_I2C2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -798,7 +769,6 @@ struct omap_hwmod am33xx_mailbox_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs	= AM33XX_CM_PER_MAILBOX0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -828,7 +798,6 @@ struct omap_hwmod am33xx_mcasp0_hwmod = {
 	.main_clk	= "mcasp0_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_MCASP0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -842,7 +811,6 @@ struct omap_hwmod am33xx_mcasp1_hwmod = {
 	.main_clk	= "mcasp1_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_MCASP1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -877,7 +845,6 @@ struct omap_hwmod am33xx_mmc0_hwmod = {
 	.main_clk	= "mmc_clk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_MMC0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -896,7 +863,6 @@ struct omap_hwmod am33xx_mmc1_hwmod = {
 	.main_clk	= "mmc_clk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_MMC1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -914,7 +880,6 @@ struct omap_hwmod am33xx_mmc2_hwmod = {
 	.main_clk	= "mmc_clk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_MMC2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -946,7 +911,6 @@ struct omap_hwmod am33xx_rtc_hwmod = {
 	.main_clk	= "clk_32768_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_RTC_RTC_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -981,7 +945,6 @@ struct omap_hwmod am33xx_spi0_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_SPI0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -996,7 +959,6 @@ struct omap_hwmod am33xx_spi1_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_SPI1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1032,7 +994,6 @@ struct omap_hwmod am33xx_spinlock_hwmod = {
 	.main_clk	= "l4ls_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_SPINLOCK_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1078,7 +1039,6 @@ struct omap_hwmod am33xx_timer1_hwmod = {
 	.main_clk	= "timer1_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_TIMER1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1091,7 +1051,6 @@ struct omap_hwmod am33xx_timer2_hwmod = {
 	.main_clk	= "timer2_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TIMER2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1104,7 +1063,6 @@ struct omap_hwmod am33xx_timer3_hwmod = {
 	.main_clk	= "timer3_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TIMER3_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1117,7 +1075,6 @@ struct omap_hwmod am33xx_timer4_hwmod = {
 	.main_clk	= "timer4_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TIMER4_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1130,7 +1087,6 @@ struct omap_hwmod am33xx_timer5_hwmod = {
 	.main_clk	= "timer5_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TIMER5_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1143,7 +1099,6 @@ struct omap_hwmod am33xx_timer6_hwmod = {
 	.main_clk	= "timer6_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TIMER6_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1156,7 +1111,6 @@ struct omap_hwmod am33xx_timer7_hwmod = {
 	.main_clk	= "timer7_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TIMER7_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1174,7 +1128,6 @@ struct omap_hwmod am33xx_tpcc_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TPCC_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1204,7 +1157,6 @@ struct omap_hwmod am33xx_tptc0_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TPTC0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1219,7 +1171,6 @@ struct omap_hwmod am33xx_tptc1_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TPTC1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1234,7 +1185,6 @@ struct omap_hwmod am33xx_tptc2_hwmod = {
 	.main_clk	= "l3_gclk",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_TPTC2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1265,7 +1215,6 @@ struct omap_hwmod am33xx_uart1_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_wkupdm_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_UART0_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1279,7 +1228,6 @@ struct omap_hwmod am33xx_uart2_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_UART1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1294,7 +1242,6 @@ struct omap_hwmod am33xx_uart3_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_UART2_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1308,7 +1255,6 @@ struct omap_hwmod am33xx_uart4_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_UART3_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1322,7 +1268,6 @@ struct omap_hwmod am33xx_uart5_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_UART4_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1336,7 +1281,6 @@ struct omap_hwmod am33xx_uart6_hwmod = {
 	.main_clk	= "dpll_per_m2_div4_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_UART5_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
@@ -1372,7 +1316,6 @@ struct omap_hwmod am33xx_wd_timer1_hwmod = {
 	.main_clk	= "wdt1_fck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_WDT1_CLKCTRL_OFFSET,
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
-- 
1.8.3.4

