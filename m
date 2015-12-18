From: Tero Kristo <t-kristo@ti.com>
Subject: [RFC 8/9] ARM: OMAP4: hwmod_data: use module clocks from DT
Date: Fri, 18 Dec 2015 15:59:00 +0200
Message-ID: <1450447141-29936-9-git-send-email-t-kristo@ti.com>
References: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1450447141-29936-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Replace the usage of prcm->clkstctrl with main_clk:s provided via DT.
This is done in preparation to get rid of hwmod data from kernel.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  339 ++++++++--------------------
 1 file changed, 95 insertions(+), 244 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index a5e444b..8da75eb 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -67,10 +67,10 @@ static struct omap_hwmod omap44xx_dmm_hwmod = {
 	.clkdm_name	= "l3_emif_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_MEMIF_DMM_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_MEMIF_DMM_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "dmm_mod_ck",
 };
 
 /*
@@ -88,11 +88,10 @@ static struct omap_hwmod omap44xx_l3_instr_hwmod = {
 	.clkdm_name	= "l3_instr_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L3INSTR_L3_INSTR_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3INSTR_L3_INSTR_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
+	.main_clk	= "l3_instr_mod_ck",
 };
 
 /* l3_main_1 */
@@ -102,10 +101,10 @@ static struct omap_hwmod omap44xx_l3_main_1_hwmod = {
 	.clkdm_name	= "l3_1_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L3_1_L3_1_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3_1_L3_1_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "l3_main_1_mod_ck",
 };
 
 /* l3_main_2 */
@@ -115,10 +114,10 @@ static struct omap_hwmod omap44xx_l3_main_2_hwmod = {
 	.clkdm_name	= "l3_2_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L3_2_L3_2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3_2_L3_2_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "l3_main_2_mod_ck",
 };
 
 /* l3_main_3 */
@@ -128,11 +127,10 @@ static struct omap_hwmod omap44xx_l3_main_3_hwmod = {
 	.clkdm_name	= "l3_instr_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L3INSTR_L3_3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3INSTR_L3_3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
+	.main_clk	= "l3_main_3_mod_ck",
 };
 
 /*
@@ -150,12 +148,12 @@ static struct omap_hwmod omap44xx_l4_abe_hwmod = {
 	.clkdm_name	= "abe_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM1_ABE_L4ABE_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_AESS_CONTEXT_OFFSET,
 			.lostcontext_mask = OMAP4430_LOSTMEM_AESSMEM_MASK,
 			.flags	      = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
 		},
 	},
+	.main_clk	= "l4_abe_mod_ck",
 };
 
 /* l4_cfg */
@@ -165,10 +163,10 @@ static struct omap_hwmod omap44xx_l4_cfg_hwmod = {
 	.clkdm_name	= "l4_cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4CFG_L4_CFG_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4CFG_L4_CFG_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "l4_cfg_mod_ck",
 };
 
 /* l4_per */
@@ -178,10 +176,10 @@ static struct omap_hwmod omap44xx_l4_per_hwmod = {
 	.clkdm_name	= "l4_per_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_L4PER_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_L4_PER_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "l4_per_mod_ck",
 };
 
 /* l4_wkup */
@@ -191,10 +189,10 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod = {
 	.clkdm_name	= "l4_wkup_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_WKUP_L4WKUP_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_WKUP_L4WKUP_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "l4_wkup_mod_ck",
 };
 
 /*
@@ -232,11 +230,10 @@ static struct omap_hwmod omap44xx_ocp_wp_noc_hwmod = {
 	.clkdm_name	= "l3_instr_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L3INSTR_OCP_WP1_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3INSTR_OCP_WP1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
+	.main_clk	= "ocp_wp_noc_mod_ck",
 };
 
 /*
@@ -276,13 +273,11 @@ static struct omap_hwmod omap44xx_aess_hwmod = {
 	.name		= "aess",
 	.class		= &omap44xx_aess_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "aess_fclk",
+	.main_clk	= "aess_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM1_ABE_AESS_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_AESS_CONTEXT_OFFSET,
 			.lostcontext_mask = OMAP4430_LOSTCONTEXT_DFF_MASK,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -304,10 +299,10 @@ static struct omap_hwmod omap44xx_c2c_hwmod = {
 	.clkdm_name	= "d2d_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_D2D_SAD2D_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_D2D_SAD2D_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "c2c_mod_ck",
 };
 
 /*
@@ -334,10 +329,9 @@ static struct omap_hwmod omap44xx_counter_32k_hwmod = {
 	.class		= &omap44xx_counter_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE,
-	.main_clk	= "sys_32k_ck",
+	.main_clk	= "counter_32k_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_WKUP_SYNCTIMER_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_WKUP_SYNCTIMER_CONTEXT_OFFSET,
 		},
 	},
@@ -425,10 +419,9 @@ static struct omap_hwmod omap44xx_debugss_hwmod = {
 	.name		= "debugss",
 	.class		= &omap44xx_debugss_hwmod_class,
 	.clkdm_name	= "emu_sys_clkdm",
-	.main_clk	= "trace_clk_div_ck",
+	.main_clk	= "debugss_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_EMU_DEBUGSS_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_EMU_DEBUGSS_CONTEXT_OFFSET,
 		},
 	},
@@ -480,10 +473,9 @@ static struct omap_hwmod omap44xx_dma_system_hwmod = {
 	.clkdm_name	= "l3_dma_clkdm",
 	.mpu_irqs	= omap44xx_dma_system_irqs,
 	.xlate_irq	= omap4_xlate_irq,
-	.main_clk	= "l3_div_ck",
+	.main_clk	= "dma_system_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_SDMA_SDMA_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_SDMA_SDMA_CONTEXT_OFFSET,
 		},
 	},
@@ -515,12 +507,10 @@ static struct omap_hwmod omap44xx_dmic_hwmod = {
 	.name		= "dmic",
 	.class		= &omap44xx_dmic_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "func_dmic_abe_gfclk",
+	.main_clk	= "dmic_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM1_ABE_DMIC_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_DMIC_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -545,13 +535,11 @@ static struct omap_hwmod omap44xx_dsp_hwmod = {
 	.clkdm_name	= "tesla_clkdm",
 	.rst_lines	= omap44xx_dsp_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_dsp_resets),
-	.main_clk	= "dpll_iva_m4x2_ck",
+	.main_clk	= "dsp_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_TESLA_TESLA_CLKCTRL_OFFSET,
 			.rstctrl_offs = OMAP4_RM_TESLA_RSTCTRL_OFFSET,
 			.context_offs = OMAP4_RM_TESLA_TESLA_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -585,12 +573,10 @@ static struct omap_hwmod omap44xx_dss_hwmod = {
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.class		= &omap44xx_dss_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
-	.main_clk	= "dss_dss_clk",
+	.main_clk	= "dss_core_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= dss_opt_clks,
@@ -643,10 +629,9 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 	.mpu_irqs	= omap44xx_dss_dispc_irqs,
 	.xlate_irq	= omap4_xlate_irq,
 	.sdma_reqs	= omap44xx_dss_dispc_sdma_reqs,
-	.main_clk	= "dss_dss_clk",
+	.main_clk	= "dss_dispc_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
@@ -697,10 +682,9 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 	.mpu_irqs	= omap44xx_dss_dsi1_irqs,
 	.xlate_irq	= omap4_xlate_irq,
 	.sdma_reqs	= omap44xx_dss_dsi1_sdma_reqs,
-	.main_clk	= "dss_dss_clk",
+	.main_clk	= "dss_dsi1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
@@ -731,10 +715,9 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 	.mpu_irqs	= omap44xx_dss_dsi2_irqs,
 	.xlate_irq	= omap4_xlate_irq,
 	.sdma_reqs	= omap44xx_dss_dsi2_sdma_reqs,
-	.main_clk	= "dss_dss_clk",
+	.main_clk	= "dss_dsi2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
@@ -790,10 +773,9 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	.mpu_irqs	= omap44xx_dss_hdmi_irqs,
 	.xlate_irq	= omap4_xlate_irq,
 	.sdma_reqs	= omap44xx_dss_hdmi_sdma_reqs,
-	.main_clk	= "dss_48mhz_clk",
+	.main_clk	= "dss_hdmi_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
@@ -837,10 +819,9 @@ static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
 	.class		= &omap44xx_rfbi_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
 	.sdma_reqs	= omap44xx_dss_rfbi_sdma_reqs,
-	.main_clk	= "dss_dss_clk",
+	.main_clk	= "dss_rfbi_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
@@ -863,10 +844,9 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap44xx_venc_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
-	.main_clk	= "dss_tv_clk",
+	.main_clk	= "dss_venc_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
@@ -901,10 +881,10 @@ static struct omap_hwmod omap44xx_elm_hwmod = {
 	.clkdm_name	= "l4_per_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_ELM_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_ELM_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "elm_mod_ck",
 };
 
 /*
@@ -927,12 +907,10 @@ static struct omap_hwmod omap44xx_emif1_hwmod = {
 	.class		= &omap44xx_emif_hwmod_class,
 	.clkdm_name	= "l3_emif_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE,
-	.main_clk	= "ddrphy_ck",
+	.main_clk	= "emif1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_MEMIF_EMIF_1_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_MEMIF_EMIF_1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -943,12 +921,10 @@ static struct omap_hwmod omap44xx_emif2_hwmod = {
 	.class		= &omap44xx_emif_hwmod_class,
 	.clkdm_name	= "l3_emif_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE,
-	.main_clk	= "ddrphy_ck",
+	.main_clk	= "emif2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_MEMIF_EMIF_2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_MEMIF_EMIF_2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -987,12 +963,10 @@ static struct omap_hwmod omap44xx_fdif_hwmod = {
 	.name		= "fdif",
 	.class		= &omap44xx_fdif_hwmod_class,
 	.clkdm_name	= "iss_clkdm",
-	.main_clk	= "fdif_fck",
+	.main_clk	= "fdif_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_CAM_FDIF_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_CAM_FDIF_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1035,12 +1009,10 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
 	.name		= "gpio1",
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.main_clk	= "l4_wkup_clk_mux_ck",
+	.main_clk	= "gpio1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_WKUP_GPIO1_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_WKUP_GPIO1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio1_opt_clks,
@@ -1058,12 +1030,10 @@ static struct omap_hwmod omap44xx_gpio2_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_div_ck",
+	.main_clk	= "gpio2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_GPIO2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_GPIO2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio2_opt_clks,
@@ -1081,12 +1051,10 @@ static struct omap_hwmod omap44xx_gpio3_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_div_ck",
+	.main_clk	= "gpio3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_GPIO3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_GPIO3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio3_opt_clks,
@@ -1104,12 +1072,10 @@ static struct omap_hwmod omap44xx_gpio4_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_div_ck",
+	.main_clk	= "gpio4_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_GPIO4_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_GPIO4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio4_opt_clks,
@@ -1127,12 +1093,10 @@ static struct omap_hwmod omap44xx_gpio5_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_div_ck",
+	.main_clk	= "gpio5_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_GPIO5_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_GPIO5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio5_opt_clks,
@@ -1150,12 +1114,10 @@ static struct omap_hwmod omap44xx_gpio6_hwmod = {
 	.class		= &omap44xx_gpio_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
-	.main_clk	= "l4_div_ck",
+	.main_clk	= "gpio6_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_GPIO6_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_GPIO6_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio6_opt_clks,
@@ -1192,11 +1154,10 @@ static struct omap_hwmod omap44xx_gpmc_hwmod = {
 	.flags		= DEBUG_OMAP_GPMC_HWMOD_FLAGS,
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L3_2_GPMC_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3_2_GPMC_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
+	.main_clk	= "gpmc_mod_ck",
 };
 
 /*
@@ -1224,12 +1185,10 @@ static struct omap_hwmod omap44xx_gpu_hwmod = {
 	.name		= "gpu",
 	.class		= &omap44xx_gpu_hwmod_class,
 	.clkdm_name	= "l3_gfx_clkdm",
-	.main_clk	= "sgx_clk_mux",
+	.main_clk	= "gpu_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_GFX_GFX_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_GFX_GFX_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1259,12 +1218,10 @@ static struct omap_hwmod omap44xx_hdq1w_hwmod = {
 	.class		= &omap44xx_hdq1w_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_INIT_NO_RESET, /* XXX temporary */
-	.main_clk	= "func_12m_fclk",
+	.main_clk	= "hdq1w_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_HDQ1W_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_HDQ1W_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1298,12 +1255,10 @@ static struct omap_hwmod omap44xx_hsi_hwmod = {
 	.name		= "hsi",
 	.class		= &omap44xx_hsi_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.main_clk	= "hsi_fck",
+	.main_clk	= "hsi_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L3INIT_HSI_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3INIT_HSI_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -1342,12 +1297,10 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
+	.main_clk	= "i2c1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_I2C1_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_I2C1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -1359,12 +1312,10 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
+	.main_clk	= "i2c2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_I2C2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_I2C2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -1376,12 +1327,10 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
+	.main_clk	= "i2c3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_I2C3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_I2C3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -1393,12 +1342,10 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	.class		= &omap44xx_i2c_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_16BIT_REG | HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "func_96m_fclk",
+	.main_clk	= "i2c4_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_I2C4_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_I2C4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -1425,13 +1372,11 @@ static struct omap_hwmod omap44xx_ipu_hwmod = {
 	.clkdm_name	= "ducati_clkdm",
 	.rst_lines	= omap44xx_ipu_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_ipu_resets),
-	.main_clk	= "ducati_clk_mux_ck",
+	.main_clk	= "ipu_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET,
 			.rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
 			.context_offs = OMAP4_RM_DUCATI_DUCATI_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -1475,12 +1420,10 @@ static struct omap_hwmod omap44xx_iss_hwmod = {
 	.name		= "iss",
 	.class		= &omap44xx_iss_hwmod_class,
 	.clkdm_name	= "iss_clkdm",
-	.main_clk	= "ducati_clk_mux_ck",
+	.main_clk	= "iss_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_CAM_ISS_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_CAM_ISS_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= iss_opt_clks,
@@ -1509,13 +1452,11 @@ static struct omap_hwmod omap44xx_iva_hwmod = {
 	.clkdm_name	= "ivahd_clkdm",
 	.rst_lines	= omap44xx_iva_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_iva_resets),
-	.main_clk	= "dpll_iva_m5x2_ck",
+	.main_clk	= "iva_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_IVAHD_IVAHD_CLKCTRL_OFFSET,
 			.rstctrl_offs = OMAP4_RM_IVAHD_RSTCTRL_OFFSET,
 			.context_offs = OMAP4_RM_IVAHD_IVAHD_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -1547,12 +1488,10 @@ static struct omap_hwmod omap44xx_kbd_hwmod = {
 	.name		= "kbd",
 	.class		= &omap44xx_kbd_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.main_clk	= "sys_32k_ck",
+	.main_clk	= "kbd_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_WKUP_KEYBOARD_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_WKUP_KEYBOARD_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1584,10 +1523,10 @@ static struct omap_hwmod omap44xx_mailbox_hwmod = {
 	.clkdm_name	= "l4_cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4CFG_MAILBOX_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4CFG_MAILBOX_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "mailbox_mod_ck",
 };
 
 /*
@@ -1618,12 +1557,10 @@ static struct omap_hwmod omap44xx_mcasp_hwmod = {
 	.name		= "mcasp",
 	.class		= &omap44xx_mcasp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "func_mcasp_abe_gfclk",
+	.main_clk	= "mcasp_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM1_ABE_MCASP_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_MCASP_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1657,12 +1594,10 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
 	.name		= "mcbsp1",
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "func_mcbsp1_gfclk",
+	.main_clk	= "mcbsp1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP1_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_MCBSP1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= mcbsp1_opt_clks,
@@ -1679,12 +1614,10 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
 	.name		= "mcbsp2",
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "func_mcbsp2_gfclk",
+	.main_clk	= "mcbsp2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_MCBSP2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= mcbsp2_opt_clks,
@@ -1701,12 +1634,10 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
 	.name		= "mcbsp3",
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "func_mcbsp3_gfclk",
+	.main_clk	= "mcbsp3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_MCBSP3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= mcbsp3_opt_clks,
@@ -1723,12 +1654,10 @@ static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
 	.name		= "mcbsp4",
 	.class		= &omap44xx_mcbsp_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.main_clk	= "per_mcbsp4_gfclk",
+	.main_clk	= "mcbsp4_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_MCBSP4_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_MCBSP4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= mcbsp4_opt_clks,
@@ -1773,12 +1702,10 @@ static struct omap_hwmod omap44xx_mcpdm_hwmod = {
 	 * results 'slow motion' audio playback.
 	 */
 	.flags		= HWMOD_EXT_OPT_MAIN_CLK | HWMOD_SWSUP_SIDLE,
-	.main_clk	= "pad_clks_ck",
+	.main_clk	= "mcpdm_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM1_ABE_PDM_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_PDM_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1828,12 +1755,10 @@ static struct omap_hwmod omap44xx_mcspi1_hwmod = {
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.sdma_reqs	= omap44xx_mcspi1_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "mcspi1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI1_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_MCSPI1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi1_dev_attr,
@@ -1858,12 +1783,10 @@ static struct omap_hwmod omap44xx_mcspi2_hwmod = {
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.sdma_reqs	= omap44xx_mcspi2_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "mcspi2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_MCSPI2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi2_dev_attr,
@@ -1888,12 +1811,10 @@ static struct omap_hwmod omap44xx_mcspi3_hwmod = {
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.sdma_reqs	= omap44xx_mcspi3_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "mcspi3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_MCSPI3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi3_dev_attr,
@@ -1916,12 +1837,10 @@ static struct omap_hwmod omap44xx_mcspi4_hwmod = {
 	.class		= &omap44xx_mcspi_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.sdma_reqs	= omap44xx_mcspi4_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "mcspi4_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_MCSPI4_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_MCSPI4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mcspi4_dev_attr,
@@ -1966,12 +1885,10 @@ static struct omap_hwmod omap44xx_mmc1_hwmod = {
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
 	.sdma_reqs	= omap44xx_mmc1_sdma_reqs,
-	.main_clk	= "hsmmc1_fclk",
+	.main_clk	= "mmc1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L3INIT_MMC1_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3INIT_MMC1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &mmc1_dev_attr,
@@ -1989,12 +1906,10 @@ static struct omap_hwmod omap44xx_mmc2_hwmod = {
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
 	.sdma_reqs	= omap44xx_mmc2_sdma_reqs,
-	.main_clk	= "hsmmc2_fclk",
+	.main_clk	= "mmc2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L3INIT_MMC2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3INIT_MMC2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2011,12 +1926,10 @@ static struct omap_hwmod omap44xx_mmc3_hwmod = {
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.sdma_reqs	= omap44xx_mmc3_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "mmc3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_MMCSD3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2033,12 +1946,10 @@ static struct omap_hwmod omap44xx_mmc4_hwmod = {
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.sdma_reqs	= omap44xx_mmc4_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "mmc4_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD4_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_MMCSD4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2055,12 +1966,10 @@ static struct omap_hwmod omap44xx_mmc5_hwmod = {
 	.class		= &omap44xx_mmc_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.sdma_reqs	= omap44xx_mmc5_sdma_reqs,
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "mmc5_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD5_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_MMCSD5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2121,13 +2030,11 @@ static struct omap_hwmod omap44xx_mmu_ipu_hwmod = {
 	.clkdm_name	= "ducati_clkdm",
 	.rst_lines	= omap44xx_mmu_ipu_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_mmu_ipu_resets),
-	.main_clk	= "ducati_clk_mux_ck",
+	.main_clk	= "mmu_ipu_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_DUCATI_DUCATI_CLKCTRL_OFFSET,
 			.rstctrl_offs = OMAP4_RM_DUCATI_RSTCTRL_OFFSET,
 			.context_offs = OMAP4_RM_DUCATI_DUCATI_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.dev_attr	= &mmu_ipu_dev_attr,
@@ -2168,13 +2075,11 @@ static struct omap_hwmod omap44xx_mmu_dsp_hwmod = {
 	.clkdm_name	= "tesla_clkdm",
 	.rst_lines	= omap44xx_mmu_dsp_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap44xx_mmu_dsp_resets),
-	.main_clk	= "dpll_iva_m4x2_ck",
+	.main_clk	= "mmu_dsp_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_TESLA_TESLA_CLKCTRL_OFFSET,
 			.rstctrl_offs = OMAP4_RM_TESLA_RSTCTRL_OFFSET,
 			.context_offs = OMAP4_RM_TESLA_TESLA_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.dev_attr	= &mmu_dsp_dev_attr,
@@ -2195,10 +2100,9 @@ static struct omap_hwmod omap44xx_mpu_hwmod = {
 	.class		= &omap44xx_mpu_hwmod_class,
 	.clkdm_name	= "mpuss_clkdm",
 	.flags		= HWMOD_INIT_NO_IDLE,
-	.main_clk	= "dpll_mpu_m2_ck",
+	.main_clk	= "mpu_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_MPU_MPU_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_MPU_MPU_CONTEXT_OFFSET,
 		},
 	},
@@ -2220,10 +2124,10 @@ static struct omap_hwmod omap44xx_ocmc_ram_hwmod = {
 	.clkdm_name	= "l3_2_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L3_2_OCMC_RAM_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3_2_OCMC_RAM_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "ocmc_ram_mod_ck",
 };
 
 /*
@@ -2262,12 +2166,10 @@ static struct omap_hwmod omap44xx_ocp2scp_usb_phy_hwmod = {
 	 * So listing ocp2scp_usb_phy_phy_48m as a main_clk here seems
 	 * to be the best workaround.
 	 */
-	.main_clk	= "ocp2scp_usb_phy_phy_48m",
+	.main_clk	= "ocp2scp_usb_phy_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L3INIT_USBPHYOCP2SCP_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3INIT_USBPHYOCP2SCP_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -2369,11 +2271,10 @@ static struct omap_hwmod omap44xx_sl2if_hwmod = {
 	.clkdm_name	= "ivahd_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_IVAHD_SL2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_IVAHD_SL2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
+	.main_clk	= "sl2if_mod_ck",
 };
 
 /*
@@ -2411,13 +2312,12 @@ static struct omap_hwmod omap44xx_slimbus1_hwmod = {
 	.clkdm_name	= "abe_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM1_ABE_SLIMBUS_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_SLIMBUS_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= slimbus1_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(slimbus1_opt_clks),
+	.main_clk	= "slimbus1_mod_ck",
 };
 
 /* slimbus2 */
@@ -2433,13 +2333,12 @@ static struct omap_hwmod omap44xx_slimbus2_hwmod = {
 	.clkdm_name	= "l4_per_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_SLIMBUS2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_SLIMBUS2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= slimbus2_opt_clks,
 	.opt_clks_cnt	= ARRAY_SIZE(slimbus2_opt_clks),
+	.main_clk	= "slimbus2_mod_ck",
 };
 
 /*
@@ -2478,12 +2377,10 @@ static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 	.class		= &omap44xx_smartreflex_hwmod_class,
 	.clkdm_name	= "l4_ao_clkdm",
 
-	.main_clk	= "smartreflex_core_fck",
+	.main_clk	= "smartreflex_core_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_ALWON_SR_CORE_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ALWON_SR_CORE_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &smartreflex_core_dev_attr,
@@ -2498,12 +2395,10 @@ static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 	.name		= "smartreflex_iva",
 	.class		= &omap44xx_smartreflex_hwmod_class,
 	.clkdm_name	= "l4_ao_clkdm",
-	.main_clk	= "smartreflex_iva_fck",
+	.main_clk	= "smartreflex_iva_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_ALWON_SR_IVA_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ALWON_SR_IVA_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &smartreflex_iva_dev_attr,
@@ -2518,12 +2413,10 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	.name		= "smartreflex_mpu",
 	.class		= &omap44xx_smartreflex_hwmod_class,
 	.clkdm_name	= "l4_ao_clkdm",
-	.main_clk	= "smartreflex_mpu_fck",
+	.main_clk	= "smartreflex_mpu_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_ALWON_SR_MPU_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ALWON_SR_MPU_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &smartreflex_mpu_dev_attr,
@@ -2558,10 +2451,10 @@ static struct omap_hwmod omap44xx_spinlock_hwmod = {
 	.clkdm_name	= "l4_cfg_clkdm",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4CFG_HW_SEM_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4CFG_HW_SEM_CONTEXT_OFFSET,
 		},
 	},
+	.main_clk	= "spinlock_mod_ck",
 };
 
 /*
@@ -2629,12 +2522,10 @@ static struct omap_hwmod omap44xx_timer1_hwmod = {
 	.class		= &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "dmt1_clk_mux",
+	.main_clk	= "timer1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_WKUP_TIMER1_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_WKUP_TIMER1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &capability_alwon_dev_attr,
@@ -2646,12 +2537,10 @@ static struct omap_hwmod omap44xx_timer2_hwmod = {
 	.class		= &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "cm2_dm2_mux",
+	.main_clk	= "timer2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_DMTIMER2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2661,12 +2550,10 @@ static struct omap_hwmod omap44xx_timer3_hwmod = {
 	.name		= "timer3",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.main_clk	= "cm2_dm3_mux",
+	.main_clk	= "timer3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_DMTIMER3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2676,12 +2563,10 @@ static struct omap_hwmod omap44xx_timer4_hwmod = {
 	.name		= "timer4",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.main_clk	= "cm2_dm4_mux",
+	.main_clk	= "timer4_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER4_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_DMTIMER4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2691,12 +2576,10 @@ static struct omap_hwmod omap44xx_timer5_hwmod = {
 	.name		= "timer5",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "timer5_sync_mux",
+	.main_clk	= "timer5_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM1_ABE_TIMER5_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_TIMER5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &capability_dsp_dev_attr,
@@ -2707,12 +2590,10 @@ static struct omap_hwmod omap44xx_timer6_hwmod = {
 	.name		= "timer6",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "timer6_sync_mux",
+	.main_clk	= "timer6_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM1_ABE_TIMER6_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_TIMER6_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &capability_dsp_dev_attr,
@@ -2723,12 +2604,10 @@ static struct omap_hwmod omap44xx_timer7_hwmod = {
 	.name		= "timer7",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "timer7_sync_mux",
+	.main_clk	= "timer7_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM1_ABE_TIMER7_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_TIMER7_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &capability_dsp_dev_attr,
@@ -2739,12 +2618,10 @@ static struct omap_hwmod omap44xx_timer8_hwmod = {
 	.name		= "timer8",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "timer8_sync_mux",
+	.main_clk	= "timer8_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM1_ABE_TIMER8_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_TIMER8_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &capability_dsp_pwm_dev_attr,
@@ -2755,12 +2632,10 @@ static struct omap_hwmod omap44xx_timer9_hwmod = {
 	.name		= "timer9",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.main_clk	= "cm2_dm9_mux",
+	.main_clk	= "timer9_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER9_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_DMTIMER9_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
@@ -2772,12 +2647,10 @@ static struct omap_hwmod omap44xx_timer10_hwmod = {
 	.class		= &omap44xx_timer_1ms_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_SET_DEFAULT_CLOCKACT,
-	.main_clk	= "cm2_dm10_mux",
+	.main_clk	= "timer10_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER10_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_DMTIMER10_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
@@ -2788,12 +2661,10 @@ static struct omap_hwmod omap44xx_timer11_hwmod = {
 	.name		= "timer11",
 	.class		= &omap44xx_timer_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
-	.main_clk	= "cm2_dm11_mux",
+	.main_clk	= "timer11_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_DMTIMER11_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_DMTIMER11_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &capability_pwm_dev_attr,
@@ -2827,12 +2698,10 @@ static struct omap_hwmod omap44xx_uart1_hwmod = {
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "uart1_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_UART1_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_UART1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2843,12 +2712,10 @@ static struct omap_hwmod omap44xx_uart2_hwmod = {
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "uart2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_UART2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_UART2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2859,12 +2726,10 @@ static struct omap_hwmod omap44xx_uart3_hwmod = {
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= DEBUG_OMAP4UART3_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "uart3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_UART3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_UART3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2875,12 +2740,10 @@ static struct omap_hwmod omap44xx_uart4_hwmod = {
 	.class		= &omap44xx_uart_hwmod_class,
 	.clkdm_name	= "l4_per_clkdm",
 	.flags		= DEBUG_OMAP4UART4_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "func_48m_fclk",
+	.main_clk	= "uart4_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_UART4_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_UART4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2917,12 +2780,10 @@ static struct omap_hwmod omap44xx_usb_host_fs_hwmod = {
 	.name		= "usb_host_fs",
 	.class		= &omap44xx_usb_host_fs_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.main_clk	= "usb_host_fs_fck",
+	.main_clk	= "usb_host_fs_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L3INIT_USB_HOST_FS_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3INIT_USB_HOST_FS_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2954,12 +2815,10 @@ static struct omap_hwmod omap44xx_usb_host_hs_hwmod = {
 	.name		= "usb_host_hs",
 	.class		= &omap44xx_usb_host_hs_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.main_clk	= "usb_host_hs_fck",
+	.main_clk	= "usb_host_hs_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L3INIT_USB_HOST_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3INIT_USB_HOST_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 
@@ -3037,12 +2896,10 @@ static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
 	.class		= &omap44xx_usb_otg_hs_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
-	.main_clk	= "usb_otg_hs_ick",
+	.main_clk	= "usb_otg_hs_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L3INIT_USB_OTG_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3INIT_USB_OTG_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= usb_otg_hs_opt_clks,
@@ -3074,12 +2931,10 @@ static struct omap_hwmod omap44xx_usb_tll_hs_hwmod = {
 	.name		= "usb_tll_hs",
 	.class		= &omap44xx_usb_tll_hs_hwmod_class,
 	.clkdm_name	= "l3_init_clkdm",
-	.main_clk	= "usb_tll_hs_ick",
+	.main_clk	= "usb_tll_hs_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L3INIT_USB_TLL_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L3INIT_USB_TLL_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 };
@@ -3113,12 +2968,10 @@ static struct omap_hwmod omap44xx_wd_timer2_hwmod = {
 	.name		= "wd_timer2",
 	.class		= &omap44xx_wd_timer_hwmod_class,
 	.clkdm_name	= "l4_wkup_clkdm",
-	.main_clk	= "sys_32k_ck",
+	.main_clk	= "wd_timer2_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_WKUP_WDT2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_WKUP_WDT2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -3128,12 +2981,10 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
 	.name		= "wd_timer3",
 	.class		= &omap44xx_wd_timer_hwmod_class,
 	.clkdm_name	= "abe_clkdm",
-	.main_clk	= "sys_32k_ck",
+	.main_clk	= "wd_timer3_mod_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM1_ABE_WDT3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_WDT3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
-- 
1.7.9.5

