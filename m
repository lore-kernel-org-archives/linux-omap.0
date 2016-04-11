From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 30/30] ARM: DRA7: hwmod_data: use module clocks from DT
Date: Mon, 11 Apr 2016 11:19:21 +0300
Message-ID: <1460362761-4842-31-git-send-email-t-kristo@ti.com>
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
This is done in preparation to get rid of hwmod data from kernel.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  360 +++++++++--------------------
 1 file changed, 103 insertions(+), 257 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 9442d89..bc192f5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -63,10 +63,10 @@ static struct omap_hwmod dra7xx_dmm_hwmod = {
 	.clkdm_name	= "emif_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_EMIF_DMM_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_EMIF_DMM_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "dmm_mod_ck",
 };
 
 /*
@@ -84,11 +84,10 @@ static struct omap_hwmod dra7xx_l3_instr_hwmod = {
 	.clkdm_name	= "l3instr_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INSTR_L3_INSTR_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3INSTR_L3_INSTR_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
+	.main_clk	= "l3_instr_mod_ck",
 };
 
 /* l3_main_1 */
@@ -98,10 +97,10 @@ static struct omap_hwmod dra7xx_l3_main_1_hwmod = {
 	.clkdm_name	= "l3main1_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3MAIN1_L3_MAIN_1_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3MAIN1_L3_MAIN_1_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "l3_main_1_mod_ck",
 };
 
 /* l3_main_2 */
@@ -111,11 +110,10 @@ static struct omap_hwmod dra7xx_l3_main_2_hwmod = {
 	.clkdm_name	= "l3instr_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INSTR_L3_MAIN_2_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3INSTR_L3_MAIN_2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
+	.main_clk	= "l3_main_2_mod_ck",
 };
 
 /*
@@ -133,10 +131,10 @@ static struct omap_hwmod dra7xx_l4_cfg_hwmod = {
 	.clkdm_name	= "l4cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4CFG_L4_CFG_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4CFG_L4_CFG_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "l4_cfg_mod_ck",
 };
 
 /* l4_per1 */
@@ -146,10 +144,10 @@ static struct omap_hwmod dra7xx_l4_per1_hwmod = {
 	.clkdm_name	= "l4per_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_L4_PER1_CLKCTRL_OFFSET,
 			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
 		},
 	},
+	.main_clk	= "l4_per1_mod_ck",
 };
 
 /* l4_per2 */
@@ -159,10 +157,10 @@ static struct omap_hwmod dra7xx_l4_per2_hwmod = {
 	.clkdm_name	= "l4per2_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER2_L4_PER2_CLKCTRL_OFFSET,
 			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
 		},
 	},
+	.main_clk	= "l4_per2_mod_ck",
 };
 
 /* l4_per3 */
@@ -172,10 +170,10 @@ static struct omap_hwmod dra7xx_l4_per3_hwmod = {
 	.clkdm_name	= "l4per3_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER3_L4_PER3_CLKCTRL_OFFSET,
 			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
 		},
 	},
+	.main_clk	= "l4_per3_mod_ck",
 };
 
 /* l4_wkup */
@@ -185,10 +183,10 @@ static struct omap_hwmod dra7xx_l4_wkup_hwmod = {
 	.clkdm_name	= "wkupaon_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_WKUPAON_L4_WKUP_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_WKUPAON_L4_WKUP_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "l4_wkup_mod_ck",
 };
 
 /*
@@ -205,12 +203,10 @@ static struct omap_hwmod dra7xx_atl_hwmod = {
 	.name		= "atl",
 	.class		= &dra7xx_atl_hwmod_class,
 	.clkdm_name	= "atl_clkdm",
-	.main_clk	= "atl_gfclk_mux",
+	.main_clk	= "atl_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_ATL_ATL_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_ATL_ATL_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -229,12 +225,10 @@ static struct omap_hwmod dra7xx_bb2d_hwmod = {
 	.name		= "bb2d",
 	.class		= &dra7xx_bb2d_hwmod_class,
 	.clkdm_name	= "dss_clkdm",
-	.main_clk	= "dpll_core_h24x2_ck",
+	.main_clk	= "bb2d_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_DSS_BB2D_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_DSS_BB2D_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -264,10 +258,9 @@ static struct omap_hwmod dra7xx_counter_32k_hwmod = {
 	.class		= &dra7xx_counter_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE,
-	.main_clk	= "wkupaon_iclk_mux",
+	.main_clk	= "counter_32k_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_WKUPAON_COUNTER_32K_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_WKUPAON_COUNTER_32K_CONTEXT_OFFSET,
 		},
 	},
@@ -319,13 +312,11 @@ static struct omap_hwmod dra7xx_gmac_hwmod = {
 	.class		= &dra7xx_gmac_hwmod_class,
 	.clkdm_name	= "gmac_clkdm",
 	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
-	.main_clk	= "dpll_gmac_ck",
+	.main_clk	= "gmac_mod_ck",
 	.mpu_rt_idx	= 1,
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs	= DRA7XX_CM_GMAC_GMAC_CLKCTRL_OFFSET,
 			.context_offs	= DRA7XX_RM_GMAC_GMAC_CONTEXT_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -358,12 +349,10 @@ static struct omap_hwmod dra7xx_dcan1_hwmod = {
 	.name		= "dcan1",
 	.class		= &dra7xx_dcan_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
-	.main_clk	= "dcan1_sys_clk_mux",
+	.main_clk	= "dcan1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_WKUPAON_DCAN1_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_WKUPAON_DCAN1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -373,12 +362,10 @@ static struct omap_hwmod dra7xx_dcan2_hwmod = {
 	.name		= "dcan2",
 	.class		= &dra7xx_dcan_hwmod_class,
 	.clkdm_name	= "l4per2_clkdm",
-	.main_clk	= "sys_clkin1",
+	.main_clk	= "dcan2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER2_DCAN2_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER2_DCAN2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -419,10 +406,9 @@ static struct omap_hwmod dra7xx_dma_system_hwmod = {
 	.name		= "dma_system",
 	.class		= &dra7xx_dma_hwmod_class,
 	.clkdm_name	= "dma_clkdm",
-	.main_clk	= "l3_iclk_div",
+	.main_clk	= "dma_system_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_DMA_DMA_SYSTEM_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_DMA_DMA_SYSTEM_CONTEXT_OFFSET,
 		},
 	},
@@ -441,10 +427,9 @@ static struct omap_hwmod dra7xx_tpcc_hwmod = {
 	.name		= "tpcc",
 	.class		= &dra7xx_tpcc_hwmod_class,
 	.clkdm_name	= "l3main1_clkdm",
-	.main_clk	= "l3_iclk_div",
+	.main_clk	= "tpcc_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs = DRA7XX_CM_L3MAIN1_TPCC_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3MAIN1_TPCC_CONTEXT_OFFSET,
 		},
 	},
@@ -464,12 +449,10 @@ static struct omap_hwmod dra7xx_tptc0_hwmod = {
 	.class		= &dra7xx_tptc_hwmod_class,
 	.clkdm_name	= "l3main1_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
-	.main_clk	= "l3_iclk_div",
+	.main_clk	= "tptc0_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs = DRA7XX_CM_L3MAIN1_TPTC1_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3MAIN1_TPTC1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -480,12 +463,10 @@ static struct omap_hwmod dra7xx_tptc1_hwmod = {
 	.class		= &dra7xx_tptc_hwmod_class,
 	.clkdm_name	= "l3main1_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
-	.main_clk	= "l3_iclk_div",
+	.main_clk	= "tptc1_mod_ck",
 	.prcm		= {
 		.omap4	= {
-			.clkctrl_offs = DRA7XX_CM_L3MAIN1_TPTC2_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3MAIN1_TPTC2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -529,12 +510,10 @@ static struct omap_hwmod dra7xx_dss_hwmod = {
 	.clkdm_name	= "dss_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.sdma_reqs	= dra7xx_dss_sdma_reqs,
-	.main_clk	= "dss_dss_clk",
+	.main_clk	= "dss_core_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_DSS_DSS_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_DSS_DSS_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= dss_opt_clks,
@@ -575,10 +554,9 @@ static struct omap_hwmod dra7xx_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
 	.class		= &dra7xx_dispc_hwmod_class,
 	.clkdm_name	= "dss_clkdm",
-	.main_clk	= "dss_dss_clk",
+	.main_clk	= "dss_dispc_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_DSS_DSS_CLKCTRL_OFFSET,
 			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
 		},
 	},
@@ -616,10 +594,9 @@ static struct omap_hwmod dra7xx_dss_hdmi_hwmod = {
 	.name		= "dss_hdmi",
 	.class		= &dra7xx_hdmi_hwmod_class,
 	.clkdm_name	= "dss_clkdm",
-	.main_clk	= "dss_48mhz_clk",
+	.main_clk	= "dss_hdmi_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_DSS_DSS_CLKCTRL_OFFSET,
 			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
 		},
 	},
@@ -656,10 +633,9 @@ static struct omap_hwmod dra7xx_elm_hwmod = {
 	.name		= "elm",
 	.class		= &dra7xx_elm_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "l3_iclk_div",
+	.main_clk	= "elm_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_ELM_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_ELM_CONTEXT_OFFSET,
 		},
 	},
@@ -703,12 +679,10 @@ static struct omap_hwmod dra7xx_gpio1_hwmod = {
 	.name		= "gpio1",
 	.class		= &dra7xx_gpio_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
-	.main_clk	= "wkupaon_iclk_mux",
+	.main_clk	= "gpio1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_WKUPAON_GPIO1_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_WKUPAON_GPIO1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio1_opt_clks,
@@ -726,12 +700,10 @@ static struct omap_hwmod dra7xx_gpio2_hwmod = {
 	.class		= &dra7xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
+	.main_clk	= "gpio2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO2_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_GPIO2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio2_opt_clks,
@@ -749,12 +721,10 @@ static struct omap_hwmod dra7xx_gpio3_hwmod = {
 	.class		= &dra7xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
+	.main_clk	= "gpio3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO3_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_GPIO3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio3_opt_clks,
@@ -772,12 +742,10 @@ static struct omap_hwmod dra7xx_gpio4_hwmod = {
 	.class		= &dra7xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
+	.main_clk	= "gpio4_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO4_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_GPIO4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio4_opt_clks,
@@ -795,12 +763,10 @@ static struct omap_hwmod dra7xx_gpio5_hwmod = {
 	.class		= &dra7xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
+	.main_clk	= "gpio5_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO5_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_GPIO5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio5_opt_clks,
@@ -818,12 +784,10 @@ static struct omap_hwmod dra7xx_gpio6_hwmod = {
 	.class		= &dra7xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
+	.main_clk	= "gpio6_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO6_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_GPIO6_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio6_opt_clks,
@@ -841,12 +805,10 @@ static struct omap_hwmod dra7xx_gpio7_hwmod = {
 	.class		= &dra7xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
+	.main_clk	= "gpio7_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO7_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_GPIO7_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio7_opt_clks,
@@ -864,12 +826,10 @@ static struct omap_hwmod dra7xx_gpio8_hwmod = {
 	.class		= &dra7xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l3_iclk_div",
+	.main_clk	= "gpio8_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_GPIO8_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_GPIO8_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio8_opt_clks,
@@ -905,12 +865,10 @@ static struct omap_hwmod dra7xx_gpmc_hwmod = {
 	.clkdm_name	= "l3main1_clkdm",
 	/* Skip reset for CONFIG_OMAP_GPMC_DEBUG for bootloader timings */
 	.flags		= DEBUG_OMAP_GPMC_HWMOD_FLAGS,
-	.main_clk	= "l3_iclk_div",
+	.main_clk	= "gpmc_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3MAIN1_GPMC_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3MAIN1_GPMC_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -941,12 +899,10 @@ static struct omap_hwmod dra7xx_hdq1w_hwmod = {
 	.class		= &dra7xx_hdq1w_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_INIT_NO_RESET,
-	.main_clk	= "func_12m_fclk",
+	.main_clk	= "hdq1w_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_HDQ1W_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_HDQ1W_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -986,12 +942,10 @@ static struct omap_hwmod dra7xx_i2c1_hwmod = {
 	.class		= &dra7xx_i2c_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
+	.main_clk	= "i2c1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_I2C1_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_I2C1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -1003,12 +957,10 @@ static struct omap_hwmod dra7xx_i2c2_hwmod = {
 	.class		= &dra7xx_i2c_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
+	.main_clk	= "i2c2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_I2C2_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_I2C2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -1020,12 +972,10 @@ static struct omap_hwmod dra7xx_i2c3_hwmod = {
 	.class		= &dra7xx_i2c_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
+	.main_clk	= "i2c3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_I2C3_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_I2C3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -1037,12 +987,10 @@ static struct omap_hwmod dra7xx_i2c4_hwmod = {
 	.class		= &dra7xx_i2c_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
+	.main_clk	= "i2c4_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_I2C4_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_I2C4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -1054,12 +1002,10 @@ static struct omap_hwmod dra7xx_i2c5_hwmod = {
 	.class		= &dra7xx_i2c_hwmod_class,
 	.clkdm_name	= "ipu_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
+	.main_clk	= "i2c5_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_IPU_I2C5_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_IPU_I2C5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -1091,10 +1037,10 @@ static struct omap_hwmod dra7xx_mailbox1_hwmod = {
 	.clkdm_name	= "l4cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4CFG_MAILBOX1_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4CFG_MAILBOX1_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "mailbox1_mod_ck",
 };
 
 /* mailbox2 */
@@ -1104,10 +1050,10 @@ static struct omap_hwmod dra7xx_mailbox2_hwmod = {
 	.clkdm_name	= "l4cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4CFG_MAILBOX2_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4CFG_MAILBOX2_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "mailbox2_mod_ck",
 };
 
 /* mailbox3 */
@@ -1117,10 +1063,10 @@ static struct omap_hwmod dra7xx_mailbox3_hwmod = {
 	.clkdm_name	= "l4cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4CFG_MAILBOX3_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4CFG_MAILBOX3_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "mailbox3_mod_ck",
 };
 
 /* mailbox4 */
@@ -1130,10 +1076,10 @@ static struct omap_hwmod dra7xx_mailbox4_hwmod = {
 	.clkdm_name	= "l4cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4CFG_MAILBOX4_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4CFG_MAILBOX4_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "mailbox4_mod_ck",
 };
 
 /* mailbox5 */
@@ -1143,10 +1089,10 @@ static struct omap_hwmod dra7xx_mailbox5_hwmod = {
 	.clkdm_name	= "l4cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4CFG_MAILBOX5_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4CFG_MAILBOX5_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "mailbox5_mod_ck",
 };
 
 /* mailbox6 */
@@ -1156,10 +1102,10 @@ static struct omap_hwmod dra7xx_mailbox6_hwmod = {
 	.clkdm_name	= "l4cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4CFG_MAILBOX6_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4CFG_MAILBOX6_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "mailbox6_mod_ck",
 };
 
 /* mailbox7 */
@@ -1169,10 +1115,10 @@ static struct omap_hwmod dra7xx_mailbox7_hwmod = {
 	.clkdm_name	= "l4cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4CFG_MAILBOX7_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4CFG_MAILBOX7_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "mailbox7_mod_ck",
 };
 
 /* mailbox8 */
@@ -1182,10 +1128,10 @@ static struct omap_hwmod dra7xx_mailbox8_hwmod = {
 	.clkdm_name	= "l4cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4CFG_MAILBOX8_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4CFG_MAILBOX8_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "mailbox8_mod_ck",
 };
 
 /* mailbox9 */
@@ -1195,10 +1141,10 @@ static struct omap_hwmod dra7xx_mailbox9_hwmod = {
 	.clkdm_name	= "l4cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4CFG_MAILBOX9_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4CFG_MAILBOX9_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "mailbox9_mod_ck",
 };
 
 /* mailbox10 */
@@ -1208,10 +1154,10 @@ static struct omap_hwmod dra7xx_mailbox10_hwmod = {
 	.clkdm_name	= "l4cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4CFG_MAILBOX10_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4CFG_MAILBOX10_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "mailbox10_mod_ck",
 };
 
 /* mailbox11 */
@@ -1221,10 +1167,10 @@ static struct omap_hwmod dra7xx_mailbox11_hwmod = {
 	.clkdm_name	= "l4cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4CFG_MAILBOX11_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4CFG_MAILBOX11_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "mailbox11_mod_ck",
 };
 
 /* mailbox12 */
@@ -1234,10 +1180,10 @@ static struct omap_hwmod dra7xx_mailbox12_hwmod = {
 	.clkdm_name	= "l4cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4CFG_MAILBOX12_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4CFG_MAILBOX12_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "mailbox12_mod_ck",
 };
 
 /* mailbox13 */
@@ -1247,10 +1193,10 @@ static struct omap_hwmod dra7xx_mailbox13_hwmod = {
 	.clkdm_name	= "l4cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4CFG_MAILBOX13_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4CFG_MAILBOX13_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "mailbox13_mod_ck",
 };
 
 /*
@@ -1284,12 +1230,10 @@ static struct omap_hwmod dra7xx_mcspi1_hwmod = {
 	.name		= "mcspi1",
 	.class		= &dra7xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "mcspi1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_MCSPI1_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_MCSPI1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi1_dev_attr,
@@ -1305,12 +1249,10 @@ static struct omap_hwmod dra7xx_mcspi2_hwmod = {
 	.name		= "mcspi2",
 	.class		= &dra7xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "mcspi2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_MCSPI2_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_MCSPI2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi2_dev_attr,
@@ -1326,12 +1268,10 @@ static struct omap_hwmod dra7xx_mcspi3_hwmod = {
 	.name		= "mcspi3",
 	.class		= &dra7xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "mcspi3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_MCSPI3_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_MCSPI3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi3_dev_attr,
@@ -1347,12 +1287,10 @@ static struct omap_hwmod dra7xx_mcspi4_hwmod = {
 	.name		= "mcspi4",
 	.class		= &dra7xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "mcspi4_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_MCSPI4_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_MCSPI4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi4_dev_attr,
@@ -1383,13 +1321,11 @@ static struct omap_hwmod dra7xx_mcasp3_hwmod = {
 	.name		= "mcasp3",
 	.class		= &dra7xx_mcasp_hwmod_class,
 	.clkdm_name	= "l4per2_clkdm",
-	.main_clk	= "mcasp3_aux_gfclk_mux",
+	.main_clk	= "mcasp3_mod_ck",
 	.flags		= HWMOD_OPT_CLKS_NEEDED,
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER2_MCASP3_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER2_MCASP3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= mcasp3_opt_clks,
@@ -1432,12 +1368,10 @@ static struct omap_hwmod dra7xx_mmc1_hwmod = {
 	.name		= "mmc1",
 	.class		= &dra7xx_mmc_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "mmc1_fclk_div",
+	.main_clk	= "mmc1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INIT_MMC1_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3INIT_MMC1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= mmc1_opt_clks,
@@ -1454,12 +1388,10 @@ static struct omap_hwmod dra7xx_mmc2_hwmod = {
 	.name		= "mmc2",
 	.class		= &dra7xx_mmc_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "mmc2_fclk_div",
+	.main_clk	= "mmc2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INIT_MMC2_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3INIT_MMC2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= mmc2_opt_clks,
@@ -1475,12 +1407,10 @@ static struct omap_hwmod dra7xx_mmc3_hwmod = {
 	.name		= "mmc3",
 	.class		= &dra7xx_mmc_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "mmc3_gfclk_div",
+	.main_clk	= "mmc3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_MMC3_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_MMC3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= mmc3_opt_clks,
@@ -1496,12 +1426,10 @@ static struct omap_hwmod dra7xx_mmc4_hwmod = {
 	.name		= "mmc4",
 	.class		= &dra7xx_mmc_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "mmc4_gfclk_div",
+	.main_clk	= "mmc4_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_MMC4_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_MMC4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= mmc4_opt_clks,
@@ -1523,10 +1451,9 @@ static struct omap_hwmod dra7xx_mpu_hwmod = {
 	.class		= &dra7xx_mpu_hwmod_class,
 	.clkdm_name	= "mpu_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
-	.main_clk	= "dpll_mpu_m2_ck",
+	.main_clk	= "mpu_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_MPU_MPU_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_MPU_MPU_CONTEXT_OFFSET,
 		},
 	},
@@ -1557,12 +1484,10 @@ static struct omap_hwmod dra7xx_ocp2scp1_hwmod = {
 	.name		= "ocp2scp1",
 	.class		= &dra7xx_ocp2scp_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "l4_root_clk_div",
+	.main_clk	= "ocp2scp1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INIT_OCP2SCP1_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3INIT_OCP2SCP1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -1572,12 +1497,10 @@ static struct omap_hwmod dra7xx_ocp2scp3_hwmod = {
 	.name		= "ocp2scp3",
 	.class		= &dra7xx_ocp2scp_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "l4_root_clk_div",
+	.main_clk	= "ocp2scp3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INIT_OCP2SCP3_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3INIT_OCP2SCP3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -1625,13 +1548,11 @@ static struct omap_hwmod dra7xx_pciess1_hwmod = {
 	.clkdm_name	= "pcie_clkdm",
 	.rst_lines	= dra7xx_pciess1_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(dra7xx_pciess1_resets),
-	.main_clk	= "l4_root_clk_div",
+	.main_clk	= "pcie1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INIT_PCIESS1_CLKCTRL_OFFSET,
 			.rstctrl_offs = DRA7XX_RM_L3INIT_PCIESS_RSTCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3INIT_PCIESS1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1648,13 +1569,11 @@ static struct omap_hwmod dra7xx_pciess2_hwmod = {
 	.clkdm_name	= "pcie_clkdm",
 	.rst_lines	= dra7xx_pciess2_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(dra7xx_pciess2_resets),
-	.main_clk	= "l4_root_clk_div",
+	.main_clk	= "pcie2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INIT_PCIESS2_CLKCTRL_OFFSET,
 			.rstctrl_offs = DRA7XX_RM_L3INIT_PCIESS_RSTCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3INIT_PCIESS2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1682,12 +1601,10 @@ static struct omap_hwmod dra7xx_qspi_hwmod = {
 	.name		= "qspi",
 	.class		= &dra7xx_qspi_hwmod_class,
 	.clkdm_name	= "l4per2_clkdm",
-	.main_clk	= "qspi_gfclk_div",
+	.main_clk	= "qspi_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER2_QSPI_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER2_QSPI_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1714,12 +1631,10 @@ static struct omap_hwmod dra7xx_rtcss_hwmod = {
 	.name		= "rtcss",
 	.class		= &dra7xx_rtcss_hwmod_class,
 	.clkdm_name	= "rtc_clkdm",
-	.main_clk	= "sys_32k_ck",
+	.main_clk	= "rtcss_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_RTC_RTCSS_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_RTC_RTCSS_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1750,13 +1665,11 @@ static struct omap_hwmod dra7xx_sata_hwmod = {
 	.class		= &dra7xx_sata_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "sata_mod_ck",
 	.mpu_rt_idx	= 1,
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INIT_SATA_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3INIT_SATA_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1796,12 +1709,10 @@ static struct omap_hwmod dra7xx_smartreflex_core_hwmod = {
 	.name		= "smartreflex_core",
 	.class		= &dra7xx_smartreflex_hwmod_class,
 	.clkdm_name	= "coreaon_clkdm",
-	.main_clk	= "wkupaon_iclk_mux",
+	.main_clk	= "smartreflex_core_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_COREAON_SMARTREFLEX_CORE_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_COREAON_SMARTREFLEX_CORE_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &smartreflex_core_dev_attr,
@@ -1817,12 +1728,10 @@ static struct omap_hwmod dra7xx_smartreflex_mpu_hwmod = {
 	.name		= "smartreflex_mpu",
 	.class		= &dra7xx_smartreflex_hwmod_class,
 	.clkdm_name	= "coreaon_clkdm",
-	.main_clk	= "wkupaon_iclk_mux",
+	.main_clk	= "smartreflex_mpu_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_COREAON_SMARTREFLEX_MPU_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_COREAON_SMARTREFLEX_MPU_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &smartreflex_mpu_dev_attr,
@@ -1854,10 +1763,9 @@ static struct omap_hwmod dra7xx_spinlock_hwmod = {
 	.name		= "spinlock",
 	.class		= &dra7xx_spinlock_hwmod_class,
 	.clkdm_name	= "l4cfg_clkdm",
-	.main_clk	= "l3_iclk_div",
+	.main_clk	= "spinlock_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4CFG_SPINLOCK_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4CFG_SPINLOCK_CONTEXT_OFFSET,
 		},
 	},
@@ -1905,12 +1813,10 @@ static struct omap_hwmod dra7xx_timer1_hwmod = {
 	.name		= "timer1",
 	.class		= &dra7xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
-	.main_clk	= "timer1_gfclk_mux",
+	.main_clk	= "timer1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_WKUPAON_TIMER1_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_WKUPAON_TIMER1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1920,12 +1826,10 @@ static struct omap_hwmod dra7xx_timer2_hwmod = {
 	.name		= "timer2",
 	.class		= &dra7xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer2_gfclk_mux",
+	.main_clk	= "timer2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_TIMER2_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_TIMER2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1935,12 +1839,10 @@ static struct omap_hwmod dra7xx_timer3_hwmod = {
 	.name		= "timer3",
 	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer3_gfclk_mux",
+	.main_clk	= "timer3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_TIMER3_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_TIMER3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1950,12 +1852,10 @@ static struct omap_hwmod dra7xx_timer4_hwmod = {
 	.name		= "timer4",
 	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer4_gfclk_mux",
+	.main_clk	= "timer4_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_TIMER4_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_TIMER4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1965,12 +1865,10 @@ static struct omap_hwmod dra7xx_timer5_hwmod = {
 	.name		= "timer5",
 	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "ipu_clkdm",
-	.main_clk	= "timer5_gfclk_mux",
+	.main_clk	= "timer5_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_IPU_TIMER5_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_IPU_TIMER5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1980,12 +1878,10 @@ static struct omap_hwmod dra7xx_timer6_hwmod = {
 	.name		= "timer6",
 	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "ipu_clkdm",
-	.main_clk	= "timer6_gfclk_mux",
+	.main_clk	= "timer6_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_IPU_TIMER6_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_IPU_TIMER6_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1995,12 +1891,10 @@ static struct omap_hwmod dra7xx_timer7_hwmod = {
 	.name		= "timer7",
 	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "ipu_clkdm",
-	.main_clk	= "timer7_gfclk_mux",
+	.main_clk	= "timer7_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_IPU_TIMER7_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_IPU_TIMER7_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2010,12 +1904,10 @@ static struct omap_hwmod dra7xx_timer8_hwmod = {
 	.name		= "timer8",
 	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "ipu_clkdm",
-	.main_clk	= "timer8_gfclk_mux",
+	.main_clk	= "timer8_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_IPU_TIMER8_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_IPU_TIMER8_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2025,12 +1917,10 @@ static struct omap_hwmod dra7xx_timer9_hwmod = {
 	.name		= "timer9",
 	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer9_gfclk_mux",
+	.main_clk	= "timer9_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_TIMER9_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_TIMER9_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2040,12 +1930,10 @@ static struct omap_hwmod dra7xx_timer10_hwmod = {
 	.name		= "timer10",
 	.class		= &dra7xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer10_gfclk_mux",
+	.main_clk	= "timer10_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_TIMER10_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_TIMER10_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2055,12 +1943,10 @@ static struct omap_hwmod dra7xx_timer11_hwmod = {
 	.name		= "timer11",
 	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer11_gfclk_mux",
+	.main_clk	= "timer11_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_TIMER11_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_TIMER11_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2070,12 +1956,10 @@ static struct omap_hwmod dra7xx_timer13_hwmod = {
 	.name		= "timer13",
 	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "l4per3_clkdm",
-	.main_clk	= "timer13_gfclk_mux",
+	.main_clk	= "timer13_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER3_TIMER13_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER3_TIMER13_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2085,12 +1969,10 @@ static struct omap_hwmod dra7xx_timer14_hwmod = {
 	.name		= "timer14",
 	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "l4per3_clkdm",
-	.main_clk	= "timer14_gfclk_mux",
+	.main_clk	= "timer14_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER3_TIMER14_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER3_TIMER14_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2100,12 +1982,10 @@ static struct omap_hwmod dra7xx_timer15_hwmod = {
 	.name		= "timer15",
 	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "l4per3_clkdm",
-	.main_clk	= "timer15_gfclk_mux",
+	.main_clk	= "timer15_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER3_TIMER15_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER3_TIMER15_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2115,12 +1995,10 @@ static struct omap_hwmod dra7xx_timer16_hwmod = {
 	.name		= "timer16",
 	.class		= &dra7xx_timer_hwmod_class,
 	.clkdm_name	= "l4per3_clkdm",
-	.main_clk	= "timer16_gfclk_mux",
+	.main_clk	= "timer16_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER3_TIMER16_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER3_TIMER16_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2152,13 +2030,11 @@ static struct omap_hwmod dra7xx_uart1_hwmod = {
 	.name		= "uart1",
 	.class		= &dra7xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "uart1_gfclk_mux",
+	.main_clk	= "uart1_mod_ck",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT | DEBUG_OMAP2UART1_FLAGS,
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_UART1_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_UART1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2168,13 +2044,11 @@ static struct omap_hwmod dra7xx_uart2_hwmod = {
 	.name		= "uart2",
 	.class		= &dra7xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "uart2_gfclk_mux",
+	.main_clk	= "uart2_mod_ck",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_UART2_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_UART2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2184,13 +2058,11 @@ static struct omap_hwmod dra7xx_uart3_hwmod = {
 	.name		= "uart3",
 	.class		= &dra7xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "uart3_gfclk_mux",
+	.main_clk	= "uart3_mod_ck",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT | DEBUG_OMAP4UART3_FLAGS,
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_UART3_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_UART3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2200,13 +2072,11 @@ static struct omap_hwmod dra7xx_uart4_hwmod = {
 	.name		= "uart4",
 	.class		= &dra7xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "uart4_gfclk_mux",
+	.main_clk	= "uart4_mod_ck",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT | DEBUG_OMAP4UART4_FLAGS,
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_UART4_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_UART4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2216,13 +2086,11 @@ static struct omap_hwmod dra7xx_uart5_hwmod = {
 	.name		= "uart5",
 	.class		= &dra7xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "uart5_gfclk_mux",
+	.main_clk	= "uart5_mod_ck",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_UART5_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER_UART5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2232,13 +2100,11 @@ static struct omap_hwmod dra7xx_uart6_hwmod = {
 	.name		= "uart6",
 	.class		= &dra7xx_uart_hwmod_class,
 	.clkdm_name	= "ipu_clkdm",
-	.main_clk	= "uart6_gfclk_mux",
+	.main_clk	= "uart6_mod_ck",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_IPU_UART6_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_IPU_UART6_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2248,13 +2114,11 @@ static struct omap_hwmod dra7xx_uart7_hwmod = {
 	.name		= "uart7",
 	.class		= &dra7xx_uart_hwmod_class,
 	.clkdm_name	= "l4per2_clkdm",
-	.main_clk	= "uart7_gfclk_mux",
+	.main_clk	= "uart7_mod_ck",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER2_UART7_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER2_UART7_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2264,13 +2128,11 @@ static struct omap_hwmod dra7xx_uart8_hwmod = {
 	.name		= "uart8",
 	.class		= &dra7xx_uart_hwmod_class,
 	.clkdm_name	= "l4per2_clkdm",
-	.main_clk	= "uart8_gfclk_mux",
+	.main_clk	= "uart8_mod_ck",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER2_UART8_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER2_UART8_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2280,13 +2142,11 @@ static struct omap_hwmod dra7xx_uart9_hwmod = {
 	.name		= "uart9",
 	.class		= &dra7xx_uart_hwmod_class,
 	.clkdm_name	= "l4per2_clkdm",
-	.main_clk	= "uart9_gfclk_mux",
+	.main_clk	= "uart9_mod_ck",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER2_UART9_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L4PER2_UART9_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2296,13 +2156,11 @@ static struct omap_hwmod dra7xx_uart10_hwmod = {
 	.name		= "uart10",
 	.class		= &dra7xx_uart_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
-	.main_clk	= "uart10_gfclk_mux",
+	.main_clk	= "uart10_mod_ck",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_WKUPAON_UART10_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_WKUPAON_UART10_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2337,12 +2195,10 @@ static struct omap_hwmod dra7xx_usb_otg_ss1_hwmod = {
 	.name		= "usb_otg_ss1",
 	.class		= &dra7xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "dpll_core_h13x2_ck",
+	.main_clk	= "usb_otg_ss1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INIT_USB_OTG_SS1_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3INIT_USB_OTG_SS1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= usb_otg_ss1_opt_clks,
@@ -2358,12 +2214,10 @@ static struct omap_hwmod dra7xx_usb_otg_ss2_hwmod = {
 	.name		= "usb_otg_ss2",
 	.class		= &dra7xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "dpll_core_h13x2_ck",
+	.main_clk	= "usb_otg_ss2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INIT_USB_OTG_SS2_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3INIT_USB_OTG_SS2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= usb_otg_ss2_opt_clks,
@@ -2375,12 +2229,10 @@ static struct omap_hwmod dra7xx_usb_otg_ss3_hwmod = {
 	.name		= "usb_otg_ss3",
 	.class		= &dra7xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "dpll_core_h13x2_ck",
+	.main_clk	= "usb_otg_ss3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INIT_USB_OTG_SS3_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3INIT_USB_OTG_SS3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -2390,12 +2242,10 @@ static struct omap_hwmod dra7xx_usb_otg_ss4_hwmod = {
 	.name		= "usb_otg_ss4",
 	.class		= &dra7xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "dpll_core_h13x2_ck",
+	.main_clk	= "usb_otg_ss4_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3INIT_USB_OTG_SS4_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3INIT_USB_OTG_SS4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -2414,10 +2264,9 @@ static struct omap_hwmod dra7xx_vcp1_hwmod = {
 	.name		= "vcp1",
 	.class		= &dra7xx_vcp_hwmod_class,
 	.clkdm_name	= "l3main1_clkdm",
-	.main_clk	= "l3_iclk_div",
+	.main_clk	= "vcp1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3MAIN1_VCP1_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3MAIN1_VCP1_CONTEXT_OFFSET,
 		},
 	},
@@ -2428,10 +2277,9 @@ static struct omap_hwmod dra7xx_vcp2_hwmod = {
 	.name		= "vcp2",
 	.class		= &dra7xx_vcp_hwmod_class,
 	.clkdm_name	= "l3main1_clkdm",
-	.main_clk	= "l3_iclk_div",
+	.main_clk	= "vcp2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L3MAIN1_VCP2_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_L3MAIN1_VCP2_CONTEXT_OFFSET,
 		},
 	},
@@ -2465,12 +2313,10 @@ static struct omap_hwmod dra7xx_wd_timer2_hwmod = {
 	.name		= "wd_timer2",
 	.class		= &dra7xx_wd_timer_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
-	.main_clk	= "sys_32k_ck",
+	.main_clk	= "wd_timer2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_WKUPAON_WD_TIMER2_CLKCTRL_OFFSET,
 			.context_offs = DRA7XX_RM_WKUPAON_WD_TIMER2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
-- 
1.7.9.5

