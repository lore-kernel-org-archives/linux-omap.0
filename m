From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 28/30] ARM: OMAP5: hwmod_data: use module clocks from DT
Date: Mon, 11 Apr 2016 11:19:19 +0300
Message-ID: <1460362761-4842-29-git-send-email-t-kristo@ti.com>
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
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |  274 ++++++++--------------------
 1 file changed, 76 insertions(+), 198 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 8cdfd9b..e36843e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -62,10 +62,10 @@ static struct omap_hwmod omap54xx_dmm_hwmod = {
 	.clkdm_name	= "emif_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_EMIF_DMM_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_EMIF_DMM_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "dmm_mod_ck",
 };
 
 /*
@@ -83,11 +83,10 @@ static struct omap_hwmod omap54xx_l3_instr_hwmod = {
 	.clkdm_name	= "l3instr_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L3INSTR_L3_INSTR_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L3INSTR_L3_INSTR_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
+	.main_clk	= "l3_instr_mod_ck",
 };
 
 /* l3_main_1 */
@@ -97,10 +96,10 @@ static struct omap_hwmod omap54xx_l3_main_1_hwmod = {
 	.clkdm_name	= "l3main1_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L3MAIN1_L3_MAIN_1_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L3MAIN1_L3_MAIN_1_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "l3_main_1_mod_ck",
 };
 
 /* l3_main_2 */
@@ -110,10 +109,10 @@ static struct omap_hwmod omap54xx_l3_main_2_hwmod = {
 	.clkdm_name	= "l3main2_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L3MAIN2_L3_MAIN_2_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L3MAIN2_L3_MAIN_2_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "l3_main_2_mod_ck",
 };
 
 /* l3_main_3 */
@@ -123,11 +122,10 @@ static struct omap_hwmod omap54xx_l3_main_3_hwmod = {
 	.clkdm_name	= "l3instr_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L3INSTR_L3_MAIN_3_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L3INSTR_L3_MAIN_3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
+	.main_clk	= "l3_main_3_mod_ck",
 };
 
 /*
@@ -145,10 +143,10 @@ static struct omap_hwmod omap54xx_l4_abe_hwmod = {
 	.clkdm_name	= "abe_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_ABE_L4_ABE_CLKCTRL_OFFSET,
 			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
 		},
 	},
+	.main_clk	= "l4_abe_mod_ck",
 };
 
 /* l4_cfg */
@@ -158,10 +156,10 @@ static struct omap_hwmod omap54xx_l4_cfg_hwmod = {
 	.clkdm_name	= "l4cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4CFG_L4_CFG_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4CFG_L4_CFG_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "l4_cfg_mod_ck",
 };
 
 /* l4_per */
@@ -171,10 +169,10 @@ static struct omap_hwmod omap54xx_l4_per_hwmod = {
 	.clkdm_name	= "l4per_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_L4_PER_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_L4_PER_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "l4_per_mod_ck",
 };
 
 /* l4_wkup */
@@ -184,10 +182,10 @@ static struct omap_hwmod omap54xx_l4_wkup_hwmod = {
 	.clkdm_name	= "wkupaon_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_WKUPAON_L4_WKUP_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_WKUPAON_L4_WKUP_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "l4_wkup_mod_ck",
 };
 
 /*
@@ -234,10 +232,9 @@ static struct omap_hwmod omap54xx_counter_32k_hwmod = {
 	.class		= &omap54xx_counter_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE,
-	.main_clk	= "wkupaon_iclk_mux",
+	.main_clk	= "counter_32k_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_WKUPAON_COUNTER_32K_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_WKUPAON_COUNTER_32K_CONTEXT_OFFSET,
 		},
 	},
@@ -289,10 +286,9 @@ static struct omap_hwmod omap54xx_dma_system_hwmod = {
 	.clkdm_name	= "dma_clkdm",
 	.mpu_irqs	= omap54xx_dma_system_irqs,
 	.xlate_irq	= omap4_xlate_irq,
-	.main_clk	= "l3_iclk_div",
+	.main_clk	= "dma_system_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DMA_DMA_SYSTEM_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_DMA_DMA_SYSTEM_CONTEXT_OFFSET,
 		},
 	},
@@ -324,12 +320,10 @@ static struct omap_hwmod omap54xx_dmic_hwmod = {
 	.name		= "dmic",
 	.class		= &omap54xx_dmic_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "dmic_gfclk",
+	.main_clk	= "dmic_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_ABE_DMIC_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_ABE_DMIC_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -362,12 +356,10 @@ static struct omap_hwmod omap54xx_dss_hwmod = {
 	.class		= &omap54xx_dss_hwmod_class,
 	.clkdm_name	= "dss_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "dss_dss_clk",
+	.main_clk	= "dss_core_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_DSS_DSS_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= dss_opt_clks,
@@ -412,10 +404,9 @@ static struct omap_hwmod omap54xx_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
 	.class		= &omap54xx_dispc_hwmod_class,
 	.clkdm_name	= "dss_clkdm",
-	.main_clk	= "dss_dss_clk",
+	.main_clk	= "dss_dispc_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
 			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
 		},
 	},
@@ -455,10 +446,9 @@ static struct omap_hwmod omap54xx_dss_dsi1_a_hwmod = {
 	.name		= "dss_dsi1",
 	.class		= &omap54xx_dsi1_hwmod_class,
 	.clkdm_name	= "dss_clkdm",
-	.main_clk	= "dss_dss_clk",
+	.main_clk	= "dss_dsi1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
 			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
 		},
 	},
@@ -476,10 +466,9 @@ static struct omap_hwmod omap54xx_dss_dsi1_c_hwmod = {
 	.name		= "dss_dsi2",
 	.class		= &omap54xx_dsi1_hwmod_class,
 	.clkdm_name	= "dss_clkdm",
-	.main_clk	= "dss_dss_clk",
+	.main_clk	= "dss_dsi2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
 			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
 		},
 	},
@@ -516,10 +505,9 @@ static struct omap_hwmod omap54xx_dss_hdmi_hwmod = {
 	.name		= "dss_hdmi",
 	.class		= &omap54xx_hdmi_hwmod_class,
 	.clkdm_name	= "dss_clkdm",
-	.main_clk	= "dss_48mhz_clk",
+	.main_clk	= "dss_hdmi_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
 			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
 		},
 	},
@@ -559,13 +547,13 @@ static struct omap_hwmod omap54xx_dss_rfbi_hwmod = {
 	.clkdm_name	= "dss_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
 			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
 		},
 	},
 	.opt_clks	= dss_rfbi_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
 	.parent_hwmod	= &omap54xx_dss_hwmod,
+	.main_clk	= "dss_rfbi_mod_ck",
 };
 
 /*
@@ -588,12 +576,10 @@ static struct omap_hwmod omap54xx_emif1_hwmod = {
 	.class		= &omap54xx_emif_hwmod_class,
 	.clkdm_name	= "emif_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE,
-	.main_clk	= "dpll_core_h11x2_ck",
+	.main_clk	= "emif1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_EMIF_EMIF1_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_EMIF_EMIF1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -604,12 +590,10 @@ static struct omap_hwmod omap54xx_emif2_hwmod = {
 	.class		= &omap54xx_emif_hwmod_class,
 	.clkdm_name	= "emif_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE,
-	.main_clk	= "dpll_core_h11x2_ck",
+	.main_clk	= "emif2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_EMIF_EMIF2_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_EMIF_EMIF2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -652,12 +636,10 @@ static struct omap_hwmod omap54xx_gpio1_hwmod = {
 	.name		= "gpio1",
 	.class		= &omap54xx_gpio_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
-	.main_clk	= "wkupaon_iclk_mux",
+	.main_clk	= "gpio1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_WKUPAON_GPIO1_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_WKUPAON_GPIO1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio1_opt_clks,
@@ -675,12 +657,10 @@ static struct omap_hwmod omap54xx_gpio2_hwmod = {
 	.class		= &omap54xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
+	.main_clk	= "gpio2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO2_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_GPIO2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio2_opt_clks,
@@ -698,12 +678,10 @@ static struct omap_hwmod omap54xx_gpio3_hwmod = {
 	.class		= &omap54xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
+	.main_clk	= "gpio3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO3_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_GPIO3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio3_opt_clks,
@@ -721,12 +699,10 @@ static struct omap_hwmod omap54xx_gpio4_hwmod = {
 	.class		= &omap54xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
+	.main_clk	= "gpio4_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO4_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_GPIO4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio4_opt_clks,
@@ -744,12 +720,10 @@ static struct omap_hwmod omap54xx_gpio5_hwmod = {
 	.class		= &omap54xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
+	.main_clk	= "gpio5_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO5_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_GPIO5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio5_opt_clks,
@@ -767,12 +741,10 @@ static struct omap_hwmod omap54xx_gpio6_hwmod = {
 	.class		= &omap54xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
+	.main_clk	= "gpio6_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO6_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_GPIO6_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio6_opt_clks,
@@ -790,12 +762,10 @@ static struct omap_hwmod omap54xx_gpio7_hwmod = {
 	.class		= &omap54xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
+	.main_clk	= "gpio7_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO7_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_GPIO7_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio7_opt_clks,
@@ -813,12 +783,10 @@ static struct omap_hwmod omap54xx_gpio8_hwmod = {
 	.class		= &omap54xx_gpio_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_root_clk_div",
+	.main_clk	= "gpio8_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_GPIO8_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_GPIO8_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio8_opt_clks,
@@ -861,12 +829,10 @@ static struct omap_hwmod omap54xx_i2c1_hwmod = {
 	.class		= &omap54xx_i2c_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
+	.main_clk	= "i2c1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_I2C1_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_I2C1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -878,12 +844,10 @@ static struct omap_hwmod omap54xx_i2c2_hwmod = {
 	.class		= &omap54xx_i2c_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
+	.main_clk	= "i2c2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_I2C2_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_I2C2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -895,12 +859,10 @@ static struct omap_hwmod omap54xx_i2c3_hwmod = {
 	.class		= &omap54xx_i2c_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
+	.main_clk	= "i2c3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_I2C3_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_I2C3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -912,12 +874,10 @@ static struct omap_hwmod omap54xx_i2c4_hwmod = {
 	.class		= &omap54xx_i2c_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
+	.main_clk	= "i2c4_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_I2C4_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_I2C4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -929,12 +889,10 @@ static struct omap_hwmod omap54xx_i2c5_hwmod = {
 	.class		= &omap54xx_i2c_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
+	.main_clk	= "i2c5_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_I2C5_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_I2C5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -964,12 +922,10 @@ static struct omap_hwmod omap54xx_kbd_hwmod = {
 	.name		= "kbd",
 	.class		= &omap54xx_kbd_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
-	.main_clk	= "sys_32k_ck",
+	.main_clk	= "kbd_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_WKUPAON_KBD_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_WKUPAON_KBD_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1001,10 +957,10 @@ static struct omap_hwmod omap54xx_mailbox_hwmod = {
 	.clkdm_name	= "l4cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4CFG_MAILBOX_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4CFG_MAILBOX_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "mailbox_mod_ck",
 };
 
 /*
@@ -1036,12 +992,10 @@ static struct omap_hwmod omap54xx_mcbsp1_hwmod = {
 	.name		= "mcbsp1",
 	.class		= &omap54xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "mcbsp1_gfclk",
+	.main_clk	= "mcbsp1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_ABE_MCBSP1_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_ABE_MCBSP1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= mcbsp1_opt_clks,
@@ -1058,12 +1012,10 @@ static struct omap_hwmod omap54xx_mcbsp2_hwmod = {
 	.name		= "mcbsp2",
 	.class		= &omap54xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "mcbsp2_gfclk",
+	.main_clk	= "mcbsp2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_ABE_MCBSP2_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_ABE_MCBSP2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= mcbsp2_opt_clks,
@@ -1080,12 +1032,10 @@ static struct omap_hwmod omap54xx_mcbsp3_hwmod = {
 	.name		= "mcbsp3",
 	.class		= &omap54xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "mcbsp3_gfclk",
+	.main_clk	= "mcbsp3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_ABE_MCBSP3_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_ABE_MCBSP3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= mcbsp3_opt_clks,
@@ -1131,12 +1081,10 @@ static struct omap_hwmod omap54xx_mcpdm_hwmod = {
 	 */
 
 	.flags		= HWMOD_EXT_OPT_MAIN_CLK | HWMOD_SWSUP_SIDLE,
-	.main_clk	= "pad_clks_ck",
+	.main_clk	= "mcpdm_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_ABE_MCPDM_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_ABE_MCPDM_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1173,12 +1121,10 @@ static struct omap_hwmod omap54xx_mcspi1_hwmod = {
 	.name		= "mcspi1",
 	.class		= &omap54xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "mcspi1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_MCSPI1_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_MCSPI1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi1_dev_attr,
@@ -1194,12 +1140,10 @@ static struct omap_hwmod omap54xx_mcspi2_hwmod = {
 	.name		= "mcspi2",
 	.class		= &omap54xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "mcspi2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_MCSPI2_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_MCSPI2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi2_dev_attr,
@@ -1215,12 +1159,10 @@ static struct omap_hwmod omap54xx_mcspi3_hwmod = {
 	.name		= "mcspi3",
 	.class		= &omap54xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "mcspi3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_MCSPI3_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_MCSPI3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi3_dev_attr,
@@ -1236,12 +1178,10 @@ static struct omap_hwmod omap54xx_mcspi4_hwmod = {
 	.name		= "mcspi4",
 	.class		= &omap54xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "mcspi4_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_MCSPI4_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_MCSPI4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi4_dev_attr,
@@ -1283,12 +1223,10 @@ static struct omap_hwmod omap54xx_mmc1_hwmod = {
 	.name		= "mmc1",
 	.class		= &omap54xx_mmc_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "mmc1_fclk",
+	.main_clk	= "mmc1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L3INIT_MMC1_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L3INIT_MMC1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= mmc1_opt_clks,
@@ -1301,12 +1239,10 @@ static struct omap_hwmod omap54xx_mmc2_hwmod = {
 	.name		= "mmc2",
 	.class		= &omap54xx_mmc_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "mmc2_fclk",
+	.main_clk	= "mmc2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L3INIT_MMC2_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L3INIT_MMC2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1316,12 +1252,10 @@ static struct omap_hwmod omap54xx_mmc3_hwmod = {
 	.name		= "mmc3",
 	.class		= &omap54xx_mmc_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "mmc3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_MMC3_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_MMC3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1331,12 +1265,10 @@ static struct omap_hwmod omap54xx_mmc4_hwmod = {
 	.name		= "mmc4",
 	.class		= &omap54xx_mmc_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "mmc4_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_MMC4_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_MMC4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1346,12 +1278,10 @@ static struct omap_hwmod omap54xx_mmc5_hwmod = {
 	.name		= "mmc5",
 	.class		= &omap54xx_mmc_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_96m_fclk",
+	.main_clk	= "mmc5_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_MMC5_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_MMC5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1388,13 +1318,11 @@ static struct omap_hwmod omap54xx_mmu_dsp_hwmod = {
 	.clkdm_name	= "dsp_clkdm",
 	.rst_lines	= omap54xx_mmu_dsp_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap54xx_mmu_dsp_resets),
-	.main_clk	= "dpll_iva_h11x2_ck",
+	.main_clk	= "mmu_dsp_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_DSP_DSP_CLKCTRL_OFFSET,
 			.rstctrl_offs = OMAP54XX_RM_DSP_RSTCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_DSP_DSP_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -1410,13 +1338,11 @@ static struct omap_hwmod omap54xx_mmu_ipu_hwmod = {
 	.clkdm_name	= "ipu_clkdm",
 	.rst_lines	= omap54xx_mmu_ipu_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap54xx_mmu_ipu_resets),
-	.main_clk	= "dpll_core_h22x2_ck",
+	.main_clk	= "mmu_ipu_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_IPU_IPU_CLKCTRL_OFFSET,
 			.rstctrl_offs = OMAP54XX_RM_IPU_RSTCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_IPU_IPU_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -1436,10 +1362,9 @@ static struct omap_hwmod omap54xx_mpu_hwmod = {
 	.class		= &omap54xx_mpu_hwmod_class,
 	.clkdm_name	= "mpu_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE,
-	.main_clk	= "dpll_mpu_m2_ck",
+	.main_clk	= "mpu_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_MPU_MPU_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_MPU_MPU_CONTEXT_OFFSET,
 		},
 	},
@@ -1474,10 +1399,10 @@ static struct omap_hwmod omap54xx_spinlock_hwmod = {
 	.clkdm_name	= "l4cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4CFG_SPINLOCK_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4CFG_SPINLOCK_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "spinlock_mod_ck",
 };
 
 /*
@@ -1506,12 +1431,10 @@ static struct omap_hwmod omap54xx_ocp2scp1_hwmod = {
 	.name		= "ocp2scp1",
 	.class		= &omap54xx_ocp2scp_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "l4_root_clk_div",
+	.main_clk	= "ocp2scp1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L3INIT_OCP2SCP1_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L3INIT_OCP2SCP1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -1558,13 +1481,11 @@ static struct omap_hwmod omap54xx_timer1_hwmod = {
 	.name		= "timer1",
 	.class		= &omap54xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
-	.main_clk	= "timer1_gfclk_mux",
+	.main_clk	= "timer1_mod_ck",
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_WKUPAON_TIMER1_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_WKUPAON_TIMER1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1574,13 +1495,11 @@ static struct omap_hwmod omap54xx_timer2_hwmod = {
 	.name		= "timer2",
 	.class		= &omap54xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer2_gfclk_mux",
+	.main_clk	= "timer2_mod_ck",
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_TIMER2_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_TIMER2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1590,12 +1509,10 @@ static struct omap_hwmod omap54xx_timer3_hwmod = {
 	.name		= "timer3",
 	.class		= &omap54xx_timer_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer3_gfclk_mux",
+	.main_clk	= "timer3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_TIMER3_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_TIMER3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1605,12 +1522,10 @@ static struct omap_hwmod omap54xx_timer4_hwmod = {
 	.name		= "timer4",
 	.class		= &omap54xx_timer_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer4_gfclk_mux",
+	.main_clk	= "timer4_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_TIMER4_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_TIMER4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1620,12 +1535,10 @@ static struct omap_hwmod omap54xx_timer5_hwmod = {
 	.name		= "timer5",
 	.class		= &omap54xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "timer5_gfclk_mux",
+	.main_clk	= "timer5_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_ABE_TIMER5_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_ABE_TIMER5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1635,12 +1548,10 @@ static struct omap_hwmod omap54xx_timer6_hwmod = {
 	.name		= "timer6",
 	.class		= &omap54xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "timer6_gfclk_mux",
+	.main_clk	= "timer6_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_ABE_TIMER6_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_ABE_TIMER6_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1650,12 +1561,10 @@ static struct omap_hwmod omap54xx_timer7_hwmod = {
 	.name		= "timer7",
 	.class		= &omap54xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "timer7_gfclk_mux",
+	.main_clk	= "timer7_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_ABE_TIMER7_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_ABE_TIMER7_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1665,12 +1574,10 @@ static struct omap_hwmod omap54xx_timer8_hwmod = {
 	.name		= "timer8",
 	.class		= &omap54xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "timer8_gfclk_mux",
+	.main_clk	= "timer8_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_ABE_TIMER8_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_ABE_TIMER8_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1680,12 +1587,10 @@ static struct omap_hwmod omap54xx_timer9_hwmod = {
 	.name		= "timer9",
 	.class		= &omap54xx_timer_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer9_gfclk_mux",
+	.main_clk	= "timer9_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_TIMER9_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_TIMER9_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1695,13 +1600,11 @@ static struct omap_hwmod omap54xx_timer10_hwmod = {
 	.name		= "timer10",
 	.class		= &omap54xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer10_gfclk_mux",
+	.main_clk	= "timer10_mod_ck",
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_TIMER10_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_TIMER10_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1711,12 +1614,10 @@ static struct omap_hwmod omap54xx_timer11_hwmod = {
 	.name		= "timer11",
 	.class		= &omap54xx_timer_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "timer11_gfclk_mux",
+	.main_clk	= "timer11_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_TIMER11_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_TIMER11_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1748,12 +1649,10 @@ static struct omap_hwmod omap54xx_uart1_hwmod = {
 	.name		= "uart1",
 	.class		= &omap54xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "uart1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_UART1_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_UART1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1763,12 +1662,10 @@ static struct omap_hwmod omap54xx_uart2_hwmod = {
 	.name		= "uart2",
 	.class		= &omap54xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "uart2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_UART2_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_UART2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1779,12 +1676,10 @@ static struct omap_hwmod omap54xx_uart3_hwmod = {
 	.class		= &omap54xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= DEBUG_OMAP4UART3_FLAGS,
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "uart3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_UART3_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_UART3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1795,12 +1690,10 @@ static struct omap_hwmod omap54xx_uart4_hwmod = {
 	.class		= &omap54xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
 	.flags		= DEBUG_OMAP4UART4_FLAGS,
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "uart4_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_UART4_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_UART4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1810,12 +1703,10 @@ static struct omap_hwmod omap54xx_uart5_hwmod = {
 	.name		= "uart5",
 	.class		= &omap54xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "uart5_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_UART5_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_UART5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1825,12 +1716,10 @@ static struct omap_hwmod omap54xx_uart6_hwmod = {
 	.name		= "uart6",
 	.class		= &omap54xx_uart_hwmod_class,
 	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "uart6_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_UART6_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L4PER_UART6_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1899,12 +1788,10 @@ static struct omap_hwmod omap54xx_usb_host_hs_hwmod = {
 	 */
 
 	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
-	.main_clk	= "l3init_60m_fclk",
+	.main_clk	= "usb_host_hs_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L3INIT_USB_HOST_HS_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L3INIT_USB_HOST_HS_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1934,12 +1821,10 @@ static struct omap_hwmod omap54xx_usb_tll_hs_hwmod = {
 	.name		= "usb_tll_hs",
 	.class		= &omap54xx_usb_tll_hs_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
-	.main_clk	= "l4_root_clk_div",
+	.main_clk	= "usb_tll_hs_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L3INIT_USB_TLL_HS_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L3INIT_USB_TLL_HS_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -1975,12 +1860,10 @@ static struct omap_hwmod omap54xx_usb_otg_ss_hwmod = {
 	.class		= &omap54xx_usb_otg_ss_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE,
-	.main_clk	= "dpll_core_h13x2_ck",
+	.main_clk	= "usb_otg_ss_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L3INIT_USB_OTG_SS_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L3INIT_USB_OTG_SS_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= usb_otg_ss_opt_clks,
@@ -2015,12 +1898,10 @@ static struct omap_hwmod omap54xx_wd_timer2_hwmod = {
 	.name		= "wd_timer2",
 	.class		= &omap54xx_wd_timer_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
-	.main_clk	= "sys_32k_ck",
+	.main_clk	= "wd_timer2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_WKUPAON_WD_TIMER2_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_WKUPAON_WD_TIMER2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2046,11 +1927,10 @@ static struct omap_hwmod omap54xx_ocp2scp3_hwmod = {
 	.clkdm_name	= "l3init_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L3INIT_OCP2SCP3_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L3INIT_OCP2SCP3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
+	.main_clk	= "ocp2scp3_mod_ck",
 };
 
 /*
@@ -2078,13 +1958,11 @@ static struct omap_hwmod omap54xx_sata_hwmod = {
 	.class		= &omap54xx_sata_hwmod_class,
 	.clkdm_name	= "l3init_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "sata_mod_ck",
 	.mpu_rt_idx	= 1,
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L3INIT_SATA_CLKCTRL_OFFSET,
 			.context_offs = OMAP54XX_RM_L3INIT_SATA_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
-- 
1.7.9.5

