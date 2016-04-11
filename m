From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 26/30] ARM: AMx3xx: hwmod_data: use module clocks from DT
Date: Mon, 11 Apr 2016 11:19:17 +0300
Message-ID: <1460362761-4842-27-git-send-email-t-kristo@ti.com>
References: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Replace the usage of prcm->clkstctrl with main_clk:s provided via DT.
This is done in preparation to get rid of hwmod data from kernel. This
patch is done for both AM33xx and AM43xx due to them sharing part of
their hwmod database.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  273 ++++----------------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   52 +---
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  115 +++------
 3 files changed, 97 insertions(+), 343 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index 907a452b..8ff9c16 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -43,10 +43,9 @@ struct omap_hwmod am33xx_l3_main_hwmod = {
 	.class		= &am33xx_l3_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE,
-	.main_clk	= "l3_gclk",
+	.main_clk	= "l3_main_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -64,10 +63,9 @@ struct omap_hwmod am33xx_l3_instr_hwmod = {
 	.class		= &am33xx_l3_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE,
-	.main_clk	= "l3_gclk",
+	.main_clk	= "l3_instr_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -86,10 +84,9 @@ struct omap_hwmod am33xx_l4_ls_hwmod = {
 	.class		= &am33xx_l4_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE,
-	.main_clk	= "l4ls_gclk",
+	.main_clk	= "l4_ls_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -102,9 +99,9 @@ struct omap_hwmod am33xx_l4_wkup_hwmod = {
 	.flags		= HWMOD_INIT_NO_IDLE,
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
+	.main_clk	= "l4_wkup_mod_ck",
 };
 
 /*
@@ -119,10 +116,9 @@ struct omap_hwmod am33xx_mpu_hwmod = {
 	.class		= &am33xx_mpu_hwmod_class,
 	.clkdm_name	= "mpu_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE,
-	.main_clk	= "dpll_mpu_m2_ck",
+	.main_clk	= "mpu_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -153,10 +149,9 @@ struct omap_hwmod am33xx_pruss_hwmod = {
 	.name		= "pruss",
 	.class		= &am33xx_pruss_hwmod_class,
 	.clkdm_name	= "pruss_ocp_clkdm",
-	.main_clk	= "pruss_ocp_gclk",
+	.main_clk	= "pruss_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 	.rst_lines	= am33xx_pruss_resets,
@@ -177,10 +172,9 @@ struct omap_hwmod am33xx_gfx_hwmod = {
 	.name		= "gfx",
 	.class		= &am33xx_gfx_hwmod_class,
 	.clkdm_name	= "gfx_l3_clkdm",
-	.main_clk	= "gfx_fck_div_ck",
+	.main_clk	= "gfx_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 	.rst_lines	= am33xx_gfx_resets,
@@ -234,10 +228,9 @@ struct omap_hwmod am33xx_aes0_hwmod = {
 	.name		= "aes",
 	.class		= &am33xx_aes0_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
-	.main_clk	= "aes0_fck",
+	.main_clk	= "aes_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -259,10 +252,9 @@ struct omap_hwmod am33xx_sha0_hwmod = {
 	.name		= "sham",
 	.class		= &am33xx_sha0_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
-	.main_clk	= "l3_gclk",
+	.main_clk	= "sham_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -277,10 +269,9 @@ struct omap_hwmod am33xx_ocmcram_hwmod = {
 	.class		= &am33xx_ocmcram_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE,
-	.main_clk	= "l3_gclk",
+	.main_clk	= "ocmcram_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -295,10 +286,9 @@ struct omap_hwmod am33xx_smartreflex0_hwmod = {
 	.name		= "smartreflex0",
 	.class		= &am33xx_smartreflex_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.main_clk	= "smartreflex0_fck",
+	.main_clk	= "smartreflex0_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -308,10 +298,9 @@ struct omap_hwmod am33xx_smartreflex1_hwmod = {
 	.name		= "smartreflex1",
 	.class		= &am33xx_smartreflex_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.main_clk	= "smartreflex1_fck",
+	.main_clk	= "smartreflex1_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -348,11 +337,10 @@ struct omap_hwmod am33xx_cpgmac0_hwmod = {
 	.class		= &am33xx_cpgmac0_hwmod_class,
 	.clkdm_name	= "cpsw_125mhz_clkdm",
 	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
-	.main_clk	= "cpsw_125mhz_gclk",
+	.main_clk	= "cpgmac0_mod_ck",
 	.mpu_rt_idx	= 1,
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -383,10 +371,9 @@ struct omap_hwmod am33xx_dcan0_hwmod = {
 	.name		= "d_can0",
 	.class		= &am33xx_dcan_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "dcan0_fck",
+	.main_clk	= "d_can0_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -396,10 +383,9 @@ struct omap_hwmod am33xx_dcan1_hwmod = {
 	.name		= "d_can1",
 	.class		= &am33xx_dcan_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "dcan1_fck",
+	.main_clk	= "d_can1_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -425,10 +411,9 @@ struct omap_hwmod am33xx_elm_hwmod = {
 	.name		= "elm",
 	.class		= &am33xx_elm_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
+	.main_clk	= "elm_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -466,10 +451,9 @@ struct omap_hwmod am33xx_epwmss0_hwmod = {
 	.name		= "epwmss0",
 	.class		= &am33xx_epwmss_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
+	.main_clk	= "epwmss0_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -503,10 +487,9 @@ struct omap_hwmod am33xx_epwmss1_hwmod = {
 	.name		= "epwmss1",
 	.class		= &am33xx_epwmss_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
+	.main_clk	= "epwmss1_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -540,10 +523,9 @@ struct omap_hwmod am33xx_epwmss2_hwmod = {
 	.name		= "epwmss2",
 	.class		= &am33xx_epwmss_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
+	.main_clk	= "epwmss2_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -608,10 +590,9 @@ struct omap_hwmod am33xx_gpio1_hwmod = {
 	.class		= &am33xx_gpio_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4ls_gclk",
+	.main_clk	= "gpio2_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= gpio1_opt_clks,
@@ -629,10 +610,9 @@ struct omap_hwmod am33xx_gpio2_hwmod = {
 	.class		= &am33xx_gpio_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4ls_gclk",
+	.main_clk	= "gpio3_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= gpio2_opt_clks,
@@ -650,10 +630,9 @@ struct omap_hwmod am33xx_gpio3_hwmod = {
 	.class		= &am33xx_gpio_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4ls_gclk",
+	.main_clk	= "gpio4_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= gpio3_opt_clks,
@@ -683,10 +662,9 @@ struct omap_hwmod am33xx_gpmc_hwmod = {
 	.clkdm_name	= "l3s_clkdm",
 	/* Skip reset for CONFIG_OMAP_GPMC_DEBUG for bootloader timings */
 	.flags		= DEBUG_OMAP_GPMC_HWMOD_FLAGS,
-	.main_clk	= "l3s_gclk",
+	.main_clk	= "gpmc_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -720,10 +698,9 @@ struct omap_hwmod am33xx_i2c1_hwmod = {
 	.class		= &i2c_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "dpll_per_m2_div4_wkupdm_ck",
+	.main_clk	= "i2c1_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -735,10 +712,9 @@ struct omap_hwmod am33xx_i2c2_hwmod = {
 	.class		= &i2c_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
+	.main_clk	= "i2c2_mod_ck",
 	.prcm		= {
 		.omap4 = {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -750,10 +726,9 @@ struct omap_hwmod am33xx_i2c3_hwmod = {
 	.class		= &i2c_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
+	.main_clk	= "i2c3_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -782,10 +757,9 @@ struct omap_hwmod am33xx_mailbox_hwmod = {
 	.name		= "mailbox",
 	.class		= &am33xx_mailbox_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
+	.main_clk	= "mailbox_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -811,10 +785,9 @@ struct omap_hwmod am33xx_mcasp0_hwmod = {
 	.name		= "mcasp0",
 	.class		= &am33xx_mcasp_hwmod_class,
 	.clkdm_name	= "l3s_clkdm",
-	.main_clk	= "mcasp0_fck",
+	.main_clk	= "mcasp0_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -824,10 +797,9 @@ struct omap_hwmod am33xx_mcasp1_hwmod = {
 	.name		= "mcasp1",
 	.class		= &am33xx_mcasp_hwmod_class,
 	.clkdm_name	= "l3s_clkdm",
-	.main_clk	= "mcasp1_fck",
+	.main_clk	= "mcasp1_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -858,10 +830,9 @@ struct omap_hwmod am33xx_mmc0_hwmod = {
 	.name		= "mmc1",
 	.class		= &am33xx_mmc_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "mmc_clk",
+	.main_clk	= "mmc1_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &am33xx_mmc0_dev_attr,
@@ -876,10 +847,9 @@ struct omap_hwmod am33xx_mmc1_hwmod = {
 	.name		= "mmc2",
 	.class		= &am33xx_mmc_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "mmc_clk",
+	.main_clk	= "mmc2_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &am33xx_mmc1_dev_attr,
@@ -893,10 +863,9 @@ struct omap_hwmod am33xx_mmc2_hwmod = {
 	.name		= "mmc3",
 	.class		= &am33xx_mmc_hwmod_class,
 	.clkdm_name	= "l3s_clkdm",
-	.main_clk	= "mmc_clk",
+	.main_clk	= "mmc3_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &am33xx_mmc2_dev_attr,
@@ -924,10 +893,9 @@ struct omap_hwmod am33xx_rtc_hwmod = {
 	.name		= "rtc",
 	.class		= &am33xx_rtc_hwmod_class,
 	.clkdm_name	= "l4_rtc_clkdm",
-	.main_clk	= "clk_32768_ck",
+	.main_clk	= "rtc_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -958,10 +926,9 @@ struct omap_hwmod am33xx_spi0_hwmod = {
 	.name		= "spi0",
 	.class		= &am33xx_spi_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "dpll_per_m2_div4_ck",
+	.main_clk	= "spi0_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi_attrib,
@@ -972,10 +939,9 @@ struct omap_hwmod am33xx_spi1_hwmod = {
 	.name		= "spi1",
 	.class		= &am33xx_spi_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "dpll_per_m2_div4_ck",
+	.main_clk	= "spi1_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi_attrib,
@@ -1007,10 +973,9 @@ struct omap_hwmod am33xx_spinlock_hwmod = {
 	.name		= "spinlock",
 	.class		= &am33xx_spinlock_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
+	.main_clk	= "spinlock_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1052,10 +1017,9 @@ struct omap_hwmod am33xx_timer1_hwmod = {
 	.name		= "timer1",
 	.class		= &am33xx_timer1ms_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.main_clk	= "timer1_fck",
+	.main_clk	= "timer1_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1064,10 +1028,9 @@ struct omap_hwmod am33xx_timer2_hwmod = {
 	.name		= "timer2",
 	.class		= &am33xx_timer_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "timer2_fck",
+	.main_clk	= "timer2_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1076,10 +1039,9 @@ struct omap_hwmod am33xx_timer3_hwmod = {
 	.name		= "timer3",
 	.class		= &am33xx_timer_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "timer3_fck",
+	.main_clk	= "timer3_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1088,10 +1050,9 @@ struct omap_hwmod am33xx_timer4_hwmod = {
 	.name		= "timer4",
 	.class		= &am33xx_timer_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "timer4_fck",
+	.main_clk	= "timer4_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1100,10 +1061,9 @@ struct omap_hwmod am33xx_timer5_hwmod = {
 	.name		= "timer5",
 	.class		= &am33xx_timer_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "timer5_fck",
+	.main_clk	= "timer5_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1112,10 +1072,9 @@ struct omap_hwmod am33xx_timer6_hwmod = {
 	.name		= "timer6",
 	.class		= &am33xx_timer_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "timer6_fck",
+	.main_clk	= "timer6_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1124,10 +1083,9 @@ struct omap_hwmod am33xx_timer7_hwmod = {
 	.name		= "timer7",
 	.class		= &am33xx_timer_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "timer7_fck",
+	.main_clk	= "timer7_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1141,10 +1099,9 @@ struct omap_hwmod am33xx_tpcc_hwmod = {
 	.name		= "tpcc",
 	.class		= &am33xx_tpcc_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
-	.main_clk	= "l3_gclk",
+	.main_clk	= "tpcc_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1170,10 +1127,9 @@ struct omap_hwmod am33xx_tptc0_hwmod = {
 	.class		= &am33xx_tptc_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
-	.main_clk	= "l3_gclk",
+	.main_clk	= "tptc0_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1184,10 +1140,9 @@ struct omap_hwmod am33xx_tptc1_hwmod = {
 	.class		= &am33xx_tptc_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
 	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
-	.main_clk	= "l3_gclk",
+	.main_clk	= "tptc1_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1198,10 +1153,9 @@ struct omap_hwmod am33xx_tptc2_hwmod = {
 	.class		= &am33xx_tptc_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
 	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
-	.main_clk	= "l3_gclk",
+	.main_clk	= "tptc2_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1228,10 +1182,9 @@ struct omap_hwmod am33xx_uart1_hwmod = {
 	.class		= &uart_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.flags		= DEBUG_AM33XXUART1_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "dpll_per_m2_div4_wkupdm_ck",
+	.main_clk	= "uart1_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1241,10 +1194,9 @@ struct omap_hwmod am33xx_uart2_hwmod = {
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
+	.main_clk	= "uart2_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1255,10 +1207,9 @@ struct omap_hwmod am33xx_uart3_hwmod = {
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
+	.main_clk	= "uart3_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1268,10 +1219,9 @@ struct omap_hwmod am33xx_uart4_hwmod = {
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
+	.main_clk	= "uart4_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1281,10 +1231,9 @@ struct omap_hwmod am33xx_uart5_hwmod = {
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
+	.main_clk	= "uart5_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1294,10 +1243,9 @@ struct omap_hwmod am33xx_uart6_hwmod = {
 	.class		= &uart_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "dpll_per_m2_div4_ck",
+	.main_clk	= "uart6_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1329,72 +1277,15 @@ struct omap_hwmod am33xx_wd_timer1_hwmod = {
 	.class		= &am33xx_wd_timer_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE,
-	.main_clk	= "wdt1_fck",
+	.main_clk	= "wd_timer2_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
 
 static void omap_hwmod_am33xx_clkctrl(void)
 {
-	CLKCTRL(am33xx_uart2_hwmod, AM33XX_CM_PER_UART1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart3_hwmod, AM33XX_CM_PER_UART2_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart4_hwmod, AM33XX_CM_PER_UART3_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart5_hwmod, AM33XX_CM_PER_UART4_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart6_hwmod, AM33XX_CM_PER_UART5_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_dcan0_hwmod, AM33XX_CM_PER_DCAN0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_dcan1_hwmod, AM33XX_CM_PER_DCAN1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_elm_hwmod, AM33XX_CM_PER_ELM_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_epwmss0_hwmod, AM33XX_CM_PER_EPWMSS0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_epwmss1_hwmod, AM33XX_CM_PER_EPWMSS1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_epwmss2_hwmod, AM33XX_CM_PER_EPWMSS2_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_gpio1_hwmod, AM33XX_CM_PER_GPIO1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_gpio2_hwmod, AM33XX_CM_PER_GPIO2_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_gpio3_hwmod, AM33XX_CM_PER_GPIO3_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_i2c2_hwmod, AM33XX_CM_PER_I2C1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_i2c3_hwmod, AM33XX_CM_PER_I2C2_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mailbox_hwmod, AM33XX_CM_PER_MAILBOX0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mcasp0_hwmod, AM33XX_CM_PER_MCASP0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mcasp1_hwmod, AM33XX_CM_PER_MCASP1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mmc0_hwmod, AM33XX_CM_PER_MMC0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mmc1_hwmod, AM33XX_CM_PER_MMC1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_spi0_hwmod, AM33XX_CM_PER_SPI0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_spi1_hwmod, AM33XX_CM_PER_SPI1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_spinlock_hwmod, AM33XX_CM_PER_SPINLOCK_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_timer2_hwmod, AM33XX_CM_PER_TIMER2_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_timer3_hwmod, AM33XX_CM_PER_TIMER3_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_timer4_hwmod, AM33XX_CM_PER_TIMER4_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_timer5_hwmod, AM33XX_CM_PER_TIMER5_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_timer6_hwmod, AM33XX_CM_PER_TIMER6_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_timer7_hwmod, AM33XX_CM_PER_TIMER7_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_smartreflex0_hwmod,
-		AM33XX_CM_WKUP_SMARTREFLEX0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_smartreflex1_hwmod,
-		AM33XX_CM_WKUP_SMARTREFLEX1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart1_hwmod, AM33XX_CM_WKUP_UART0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_timer1_hwmod, AM33XX_CM_WKUP_TIMER1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_i2c1_hwmod, AM33XX_CM_WKUP_I2C0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_wd_timer1_hwmod, AM33XX_CM_WKUP_WDT1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_rtc_hwmod, AM33XX_CM_RTC_RTC_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mmc2_hwmod, AM33XX_CM_PER_MMC2_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_gpmc_hwmod, AM33XX_CM_PER_GPMC_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_l4_ls_hwmod, AM33XX_CM_PER_L4LS_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_l4_wkup_hwmod, AM33XX_CM_WKUP_L4WKUP_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_l3_main_hwmod, AM33XX_CM_PER_L3_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_tpcc_hwmod, AM33XX_CM_PER_TPCC_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_tptc0_hwmod, AM33XX_CM_PER_TPTC0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_tptc1_hwmod, AM33XX_CM_PER_TPTC1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_tptc2_hwmod, AM33XX_CM_PER_TPTC2_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_gfx_hwmod, AM33XX_CM_GFX_GFX_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_cpgmac0_hwmod, AM33XX_CM_PER_CPGMAC0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_pruss_hwmod, AM33XX_CM_PER_PRUSS_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mpu_hwmod , AM33XX_CM_MPU_MPU_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_l3_instr_hwmod , AM33XX_CM_PER_L3_INSTR_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_ocmcram_hwmod , AM33XX_CM_PER_OCMCRAM_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_sha0_hwmod , AM33XX_CM_PER_SHA0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_aes0_hwmod , AM33XX_CM_PER_AES0_CLKCTRL_OFFSET);
 }
 
 static void omap_hwmod_am33xx_rst(void)
@@ -1412,62 +1303,6 @@ void omap_hwmod_am33xx_reg(void)
 
 static void omap_hwmod_am43xx_clkctrl(void)
 {
-	CLKCTRL(am33xx_uart2_hwmod, AM43XX_CM_PER_UART1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart3_hwmod, AM43XX_CM_PER_UART2_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart4_hwmod, AM43XX_CM_PER_UART3_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart5_hwmod, AM43XX_CM_PER_UART4_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart6_hwmod, AM43XX_CM_PER_UART5_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_dcan0_hwmod, AM43XX_CM_PER_DCAN0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_dcan1_hwmod, AM43XX_CM_PER_DCAN1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_elm_hwmod, AM43XX_CM_PER_ELM_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_epwmss0_hwmod, AM43XX_CM_PER_EPWMSS0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_epwmss1_hwmod, AM43XX_CM_PER_EPWMSS1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_epwmss2_hwmod, AM43XX_CM_PER_EPWMSS2_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_gpio1_hwmod, AM43XX_CM_PER_GPIO1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_gpio2_hwmod, AM43XX_CM_PER_GPIO2_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_gpio3_hwmod, AM43XX_CM_PER_GPIO3_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_i2c2_hwmod, AM43XX_CM_PER_I2C1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_i2c3_hwmod, AM43XX_CM_PER_I2C2_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mailbox_hwmod, AM43XX_CM_PER_MAILBOX0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mcasp0_hwmod, AM43XX_CM_PER_MCASP0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mcasp1_hwmod, AM43XX_CM_PER_MCASP1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mmc0_hwmod, AM43XX_CM_PER_MMC0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mmc1_hwmod, AM43XX_CM_PER_MMC1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_spi0_hwmod, AM43XX_CM_PER_SPI0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_spi1_hwmod, AM43XX_CM_PER_SPI1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_spinlock_hwmod, AM43XX_CM_PER_SPINLOCK_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_timer2_hwmod, AM43XX_CM_PER_TIMER2_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_timer3_hwmod, AM43XX_CM_PER_TIMER3_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_timer4_hwmod, AM43XX_CM_PER_TIMER4_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_timer5_hwmod, AM43XX_CM_PER_TIMER5_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_timer6_hwmod, AM43XX_CM_PER_TIMER6_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_timer7_hwmod, AM43XX_CM_PER_TIMER7_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_smartreflex0_hwmod,
-		AM43XX_CM_WKUP_SMARTREFLEX0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_smartreflex1_hwmod,
-		AM43XX_CM_WKUP_SMARTREFLEX1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_uart1_hwmod, AM43XX_CM_WKUP_UART0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_timer1_hwmod, AM43XX_CM_WKUP_TIMER1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_i2c1_hwmod, AM43XX_CM_WKUP_I2C0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_wd_timer1_hwmod, AM43XX_CM_WKUP_WDT1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_rtc_hwmod, AM43XX_CM_RTC_RTC_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mmc2_hwmod, AM43XX_CM_PER_MMC2_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_gpmc_hwmod, AM43XX_CM_PER_GPMC_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_l4_ls_hwmod, AM43XX_CM_PER_L4LS_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_l4_wkup_hwmod, AM43XX_CM_WKUP_L4WKUP_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_l3_main_hwmod, AM43XX_CM_PER_L3_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_tpcc_hwmod, AM43XX_CM_PER_TPCC_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_tptc0_hwmod, AM43XX_CM_PER_TPTC0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_tptc1_hwmod, AM43XX_CM_PER_TPTC1_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_tptc2_hwmod, AM43XX_CM_PER_TPTC2_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_gfx_hwmod, AM43XX_CM_GFX_GFX_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_cpgmac0_hwmod, AM43XX_CM_PER_CPGMAC0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_pruss_hwmod, AM43XX_CM_PER_PRUSS_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_mpu_hwmod , AM43XX_CM_MPU_MPU_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_l3_instr_hwmod , AM43XX_CM_PER_L3_INSTR_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_ocmcram_hwmod , AM43XX_CM_PER_OCMCRAM_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_sha0_hwmod , AM43XX_CM_PER_SHA0_CLKCTRL_OFFSET);
-	CLKCTRL(am33xx_aes0_hwmod , AM43XX_CM_PER_AES0_CLKCTRL_OFFSET);
 }
 
 static void omap_hwmod_am43xx_rst(void)
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index cc0791d..76c7e26 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -40,11 +40,9 @@ static struct omap_hwmod am33xx_emif_hwmod = {
 	.class		= &am33xx_emif_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE,
-	.main_clk	= "dpll_ddr_m2_div2_ck",
+	.main_clk	= "emif_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_EMIF_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -55,11 +53,9 @@ static struct omap_hwmod am33xx_l4_hs_hwmod = {
 	.class		= &am33xx_l4_hwmod_class,
 	.clkdm_name	= "l4hs_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE,
-	.main_clk	= "l4hs_gclk",
+	.main_clk	= "l4_hs_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_L4HS_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -75,13 +71,11 @@ static struct omap_hwmod am33xx_wkup_m3_hwmod = {
 	.clkdm_name	= "l4_wkup_aon_clkdm",
 	/* Keep hardreset asserted */
 	.flags		= HWMOD_INIT_NO_RESET | HWMOD_NO_IDLEST,
-	.main_clk	= "dpll_core_m4_div2_ck",
+	.main_clk	= "wkup_m3_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_WKUP_M3_CLKCTRL_OFFSET,
 			.rstctrl_offs	= AM33XX_RM_WKUP_RSTCTRL_OFFSET,
 			.rstst_offs	= AM33XX_RM_WKUP_RSTST_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 	.rst_lines	= am33xx_wkup_m3_resets,
@@ -110,11 +104,9 @@ static struct omap_hwmod am33xx_adc_tsc_hwmod = {
 	.name		= "adc_tsc",
 	.class		= &am33xx_adc_tsc_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.main_clk	= "adc_tsc_fck",
+	.main_clk	= "adc_tsc_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_ADC_TSC_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -143,11 +135,9 @@ static struct omap_hwmod am33xx_cefuse_hwmod = {
 	.name		= "cefuse",
 	.class		= &am33xx_cefuse_hwmod_class,
 	.clkdm_name	= "l4_cefuse_clkdm",
-	.main_clk	= "cefuse_fck",
+	.main_clk	= "cefuse_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_CEFUSE_CEFUSE_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -163,11 +153,9 @@ static struct omap_hwmod am33xx_clkdiv32k_hwmod = {
 	.name		= "clkdiv32k",
 	.class		= &am33xx_clkdiv32k_hwmod_class,
 	.clkdm_name	= "clk_24mhz_clkdm",
-	.main_clk	= "clkdiv32k_ick",
+	.main_clk	= "clkdiv32k_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_CLKDIV32K_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -181,11 +169,9 @@ static struct omap_hwmod am33xx_ocpwp_hwmod = {
 	.name		= "ocpwp",
 	.class		= &am33xx_ocpwp_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
+	.main_clk	= "ocpwp_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_OCPWP_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -208,11 +194,9 @@ static struct omap_hwmod am33xx_debugss_hwmod = {
 	.name		= "debugss",
 	.class		= &am33xx_debugss_hwmod_class,
 	.clkdm_name	= "l3_aon_clkdm",
-	.main_clk	= "trace_clk_div_ck",
+	.main_clk	= "debugss_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_DEBUGSS_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= debugss_opt_clks,
@@ -224,11 +208,9 @@ static struct omap_hwmod am33xx_control_hwmod = {
 	.class		= &am33xx_control_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE,
-	.main_clk	= "dpll_core_m4_div2_ck",
+	.main_clk	= "control_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_CONTROL_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -243,11 +225,9 @@ static struct omap_hwmod am33xx_gpio0_hwmod = {
 	.class		= &am33xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "dpll_core_m4_div2_ck",
+	.main_clk	= "gpio1_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_WKUP_GPIO0_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= gpio0_opt_clks,
@@ -274,11 +254,9 @@ static struct omap_hwmod am33xx_lcdc_hwmod = {
 	.class		= &am33xx_lcdc_hwmod_class,
 	.clkdm_name	= "lcdc_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
-	.main_clk	= "lcd_gclk",
+	.main_clk	= "lcdc_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_LCDC_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -306,11 +284,9 @@ static struct omap_hwmod am33xx_usbss_hwmod = {
 	.class		= &am33xx_usbotg_class,
 	.clkdm_name	= "l3s_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
-	.main_clk	= "usbotg_fck",
+	.main_clk	= "usb_otg_hs_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_USB0_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -522,11 +498,9 @@ static struct omap_hwmod am33xx_rng_hwmod = {
 	.class		= &am33xx_rng_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE,
-	.main_clk	= "rng_fck",
+	.main_clk	= "rng_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_RNG_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index 97fd399..6c6a14f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -29,11 +29,9 @@ static struct omap_hwmod am43xx_emif_hwmod = {
 	.class		= &am33xx_emif_hwmod_class,
 	.clkdm_name	= "emif_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE,
-	.main_clk	= "dpll_ddr_m2_ck",
+	.main_clk	= "emif_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM43XX_CM_PER_EMIF_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -43,11 +41,9 @@ static struct omap_hwmod am43xx_l4_hs_hwmod = {
 	.class		= &am33xx_l4_hwmod_class,
 	.clkdm_name	= "l3_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE,
-	.main_clk	= "l4hs_gclk",
+	.main_clk	= "l4_hs_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM43XX_CM_PER_L4HS_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -62,13 +58,11 @@ static struct omap_hwmod am43xx_wkup_m3_hwmod = {
 	.clkdm_name	= "l4_wkup_aon_clkdm",
 	/* Keep hardreset asserted */
 	.flags		= HWMOD_INIT_NO_RESET | HWMOD_NO_IDLEST,
-	.main_clk	= "sys_clkin_ck",
+	.main_clk	= "wkup_m3_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM43XX_CM_WKUP_WKUP_M3_CLKCTRL_OFFSET,
 			.rstctrl_offs	= AM43XX_RM_WKUP_RSTCTRL_OFFSET,
 			.rstst_offs	= AM43XX_RM_WKUP_RSTST_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 	.rst_lines	= am33xx_wkup_m3_resets,
@@ -80,11 +74,9 @@ static struct omap_hwmod am43xx_control_hwmod = {
 	.class		= &am33xx_control_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE,
-	.main_clk	= "sys_clkin_ck",
+	.main_clk	= "control_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM43XX_CM_WKUP_CONTROL_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -98,11 +90,9 @@ static struct omap_hwmod am43xx_gpio0_hwmod = {
 	.class		= &am33xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "sys_clkin_ck",
+	.main_clk	= "gpio1_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM43XX_CM_WKUP_GPIO0_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= gpio0_opt_clks,
@@ -128,11 +118,9 @@ static struct omap_hwmod am43xx_synctimer_hwmod = {
 	.class		= &am43xx_synctimer_hwmod_class,
 	.clkdm_name	= "l4_wkup_aon_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE,
-	.main_clk	= "synctimer_32kclk",
+	.main_clk	= "counter_32k_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = AM43XX_CM_WKUP_SYNCTIMER_CLKCTRL_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -141,11 +129,9 @@ static struct omap_hwmod am43xx_timer8_hwmod = {
 	.name		= "timer8",
 	.class		= &am33xx_timer_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "timer8_fck",
+	.main_clk	= "timer8_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM43XX_CM_PER_TIMER8_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -154,11 +140,9 @@ static struct omap_hwmod am43xx_timer9_hwmod = {
 	.name		= "timer9",
 	.class		= &am33xx_timer_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "timer9_fck",
+	.main_clk	= "timer9_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM43XX_CM_PER_TIMER9_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -167,11 +151,9 @@ static struct omap_hwmod am43xx_timer10_hwmod = {
 	.name		= "timer10",
 	.class		= &am33xx_timer_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "timer10_fck",
+	.main_clk	= "timer10_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM43XX_CM_PER_TIMER10_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -180,11 +162,9 @@ static struct omap_hwmod am43xx_timer11_hwmod = {
 	.name		= "timer11",
 	.class		= &am33xx_timer_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "timer11_fck",
+	.main_clk	= "timer11_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= AM43XX_CM_PER_TIMER11_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -193,11 +173,9 @@ static struct omap_hwmod am43xx_epwmss3_hwmod = {
 	.name		= "epwmss3",
 	.class		= &am33xx_epwmss_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
+	.main_clk	= "epwmss3_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs = AM43XX_CM_PER_EPWMSS3_CLKCTRL_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -213,11 +191,9 @@ static struct omap_hwmod am43xx_epwmss4_hwmod = {
 	.name		= "epwmss4",
 	.class		= &am33xx_epwmss_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
+	.main_clk	= "epwmss4_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs = AM43XX_CM_PER_EPWMSS4_CLKCTRL_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -233,11 +209,9 @@ static struct omap_hwmod am43xx_epwmss5_hwmod = {
 	.name		= "epwmss5",
 	.class		= &am33xx_epwmss_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
+	.main_clk	= "epwmss5_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs = AM43XX_CM_PER_EPWMSS5_CLKCTRL_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -253,11 +227,9 @@ static struct omap_hwmod am43xx_spi2_hwmod = {
 	.name		= "spi2",
 	.class		= &am33xx_spi_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "dpll_per_m2_div4_ck",
+	.main_clk	= "spi2_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs = AM43XX_CM_PER_SPI2_CLKCTRL_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi_attrib,
@@ -267,11 +239,9 @@ static struct omap_hwmod am43xx_spi3_hwmod = {
 	.name		= "spi3",
 	.class		= &am33xx_spi_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "dpll_per_m2_div4_ck",
+	.main_clk	= "spi3_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs = AM43XX_CM_PER_SPI3_CLKCTRL_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi_attrib,
@@ -281,11 +251,9 @@ static struct omap_hwmod am43xx_spi4_hwmod = {
 	.name		= "spi4",
 	.class		= &am33xx_spi_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "dpll_per_m2_div4_ck",
+	.main_clk	= "spi4_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs = AM43XX_CM_PER_SPI4_CLKCTRL_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi_attrib,
@@ -300,11 +268,9 @@ static struct omap_hwmod am43xx_gpio4_hwmod = {
 	.class		= &am33xx_gpio_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4ls_gclk",
+	.main_clk	= "gpio5_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs = AM43XX_CM_PER_GPIO4_CLKCTRL_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= gpio4_opt_clks,
@@ -321,11 +287,9 @@ static struct omap_hwmod am43xx_gpio5_hwmod = {
 	.class		= &am33xx_gpio_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4ls_gclk",
+	.main_clk	= "gpio6_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs = AM43XX_CM_PER_GPIO5_CLKCTRL_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= gpio5_opt_clks,
@@ -341,11 +305,9 @@ static struct omap_hwmod am43xx_ocp2scp0_hwmod = {
 	.name		= "ocp2scp0",
 	.class		= &am43xx_ocp2scp_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
+	.main_clk	= "ocp2scp0_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = AM43XX_CM_PER_USBPHYOCP2SCP0_CLKCTRL_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -354,11 +316,9 @@ static struct omap_hwmod am43xx_ocp2scp1_hwmod = {
 	.name		= "ocp2scp1",
 	.class		= &am43xx_ocp2scp_hwmod_class,
 	.clkdm_name	= "l4ls_clkdm",
-	.main_clk	= "l4ls_gclk",
+	.main_clk	= "ocp2scp1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs	= AM43XX_CM_PER_USBPHYOCP2SCP1_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -384,11 +344,9 @@ static struct omap_hwmod am43xx_usb_otg_ss0_hwmod = {
 	.name		= "usb_otg_ss0",
 	.class		= &am43xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	= "l3s_clkdm",
-	.main_clk	= "l3s_gclk",
+	.main_clk	= "usb_otg_ss0_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs	= AM43XX_CM_PER_USB_OTG_SS0_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -397,11 +355,9 @@ static struct omap_hwmod am43xx_usb_otg_ss1_hwmod = {
 	.name		= "usb_otg_ss1",
 	.class		= &am43xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	= "l3s_clkdm",
-	.main_clk	= "l3s_gclk",
+	.main_clk	= "usb_otg_ss1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs	= AM43XX_CM_PER_USB_OTG_SS1_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -423,11 +379,9 @@ static struct omap_hwmod am43xx_qspi_hwmod = {
 	.name           = "qspi",
 	.class          = &am43xx_qspi_hwmod_class,
 	.clkdm_name     = "l3s_clkdm",
-	.main_clk       = "l3s_gclk",
+	.main_clk	= "qspi_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = AM43XX_CM_PER_QSPI_CLKCTRL_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -454,11 +408,9 @@ static struct omap_hwmod am43xx_adc_tsc_hwmod = {
 	.name		= "adc_tsc",
 	.class		= &am43xx_adc_tsc_hwmod_class,
 	.clkdm_name	= "l3s_tsc_clkdm",
-	.main_clk	= "adc_tsc_fck",
+	.main_clk	= "adc_tsc_mod_ck",
 	.prcm		= {
 		.omap4  = {
-			.clkctrl_offs   = AM43XX_CM_WKUP_ADC_TSC_CLKCTRL_OFFSET,
-			.modulemode     = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -469,11 +421,9 @@ static struct omap_hwmod am43xx_dss_core_hwmod = {
 	.name		= "dss_core",
 	.class		= &omap2_dss_hwmod_class,
 	.clkdm_name	= "dss_clkdm",
-	.main_clk	= "disp_clk",
+	.main_clk	= "dss_core_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -506,10 +456,9 @@ static struct omap_hwmod am43xx_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
 	.class		= &am43xx_dispc_hwmod_class,
 	.clkdm_name	= "dss_clkdm",
-	.main_clk	= "disp_clk",
+	.main_clk	= "dss_dispc_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
 		},
 	},
 	.dev_attr	= &am43xx_dss_dispc_dev_attr,
@@ -522,10 +471,9 @@ static struct omap_hwmod am43xx_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap2_rfbi_hwmod_class,
 	.clkdm_name	= "dss_clkdm",
-	.main_clk	= "disp_clk",
+	.main_clk	= "dss_rfbi_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = AM43XX_CM_PER_DSS_CLKCTRL_OFFSET,
 		},
 	},
 	.parent_hwmod	= &am43xx_dss_core_hwmod,
@@ -552,10 +500,9 @@ static struct omap_hwmod am43xx_hdq1w_hwmod = {
 	.clkdm_name     = "l4ls_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = AM43XX_CM_PER_HDQ1W_CLKCTRL_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
+	.main_clk	= "hdq1w_mod_ck",
 };
 
 static struct omap_hwmod_class_sysconfig am43xx_vpfe_sysc = {
@@ -578,10 +525,9 @@ static struct omap_hwmod am43xx_vpfe0_hwmod = {
 	.clkdm_name     = "l3s_clkdm",
 	.prcm           = {
 		.omap4  = {
-			.modulemode     = MODULEMODE_SWCTRL,
-			.clkctrl_offs   = AM43XX_CM_PER_VPFE0_CLKCTRL_OFFSET,
 		},
 	},
+	.main_clk	= "vpfe0_mod_ck",
 };
 
 static struct omap_hwmod am43xx_vpfe1_hwmod = {
@@ -590,10 +536,9 @@ static struct omap_hwmod am43xx_vpfe1_hwmod = {
 	.clkdm_name     = "l3s_clkdm",
 	.prcm           = {
 		.omap4  = {
-			.modulemode     = MODULEMODE_SWCTRL,
-			.clkctrl_offs   = AM43XX_CM_PER_VPFE1_CLKCTRL_OFFSET,
 		},
 	},
+	.main_clk	= "vpfe1_mod_ck",
 };
 
 /* Interfaces */
-- 
1.7.9.5

