From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC] ARM: OMAP2+: hwmod: Cleanup unused optional clock information
Date: Tue, 20 May 2014 13:54:41 +0530
Message-ID: <1400574281-15094-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33740 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966AbaETI1E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2014 04:27:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, tomi.valkeinen@ti.com, paul@pwsan.com, t-kristo@ti.com, archit@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Some modules need their optional clocks to be enabled in order to complete
the ocp softreset. This is what hwmod uses optional clock information
for. While these modules are limited (GPIO and DSS) there are others which have
this data in hwmod but it seems to be completely unused. Get rid of all opt_clks
for all such instances.

The modules (like GPIO and DSS) which do have this need to handle optional
clocks during a ocp softreset are marked with a flag 'HWMOD_CONTROL_OPT_CLKS_IN_RESET'
so its easy to identify the ones which don't have this requirement.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
I have only sanity tested this on a couple boards. Need to test on all
affected platforms.

 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    9 --
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   15 ----
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    6 --
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |    7 --
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   87 --------------------
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |   39 ---------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          |   55 -------------
 7 files changed, 218 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 2f15979..25e2266 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -200,11 +200,6 @@ static struct omap_hwmod_class omap2420_mcbsp_hwmod_class = {
 	.name = "mcbsp",
 };
 
-static struct omap_hwmod_opt_clk mcbsp_opt_clks[] = {
-	{ .role = "pad_fck", .clk = "mcbsp_clks" },
-	{ .role = "prcm_fck", .clk = "func_96m_ck" },
-};
-
 /* mcbsp1 */
 static struct omap_hwmod omap2420_mcbsp1_hwmod = {
 	.name		= "mcbsp1",
@@ -219,8 +214,6 @@ static struct omap_hwmod omap2420_mcbsp1_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_MCBSP1_SHIFT,
 		},
 	},
-	.opt_clks	= mcbsp_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
 };
 
 /* mcbsp2 */
@@ -237,8 +230,6 @@ static struct omap_hwmod omap2420_mcbsp2_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_MCBSP2_SHIFT,
 		},
 	},
-	.opt_clks	= mcbsp_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
 };
 
 static struct omap_hwmod_class_sysconfig omap2420_msdi_sysc = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 6d1b609..d755bf0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -268,11 +268,6 @@ static struct omap_hwmod_class omap2430_mcbsp_hwmod_class = {
 	.rev  = MCBSP_CONFIG_TYPE2,
 };
 
-static struct omap_hwmod_opt_clk mcbsp_opt_clks[] = {
-	{ .role = "pad_fck", .clk = "mcbsp_clks" },
-	{ .role = "prcm_fck", .clk = "func_96m_ck" },
-};
-
 /* mcbsp1 */
 static struct omap_hwmod omap2430_mcbsp1_hwmod = {
 	.name		= "mcbsp1",
@@ -287,8 +282,6 @@ static struct omap_hwmod omap2430_mcbsp1_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_MCBSP1_SHIFT,
 		},
 	},
-	.opt_clks	= mcbsp_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
 };
 
 /* mcbsp2 */
@@ -305,8 +298,6 @@ static struct omap_hwmod omap2430_mcbsp2_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_MCBSP2_SHIFT,
 		},
 	},
-	.opt_clks	= mcbsp_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
 };
 
 /* mcbsp3 */
@@ -323,8 +314,6 @@ static struct omap_hwmod omap2430_mcbsp3_hwmod = {
 			.idlest_idle_bit = OMAP2430_ST_MCBSP3_SHIFT,
 		},
 	},
-	.opt_clks	= mcbsp_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
 };
 
 /* mcbsp4 */
@@ -341,8 +330,6 @@ static struct omap_hwmod omap2430_mcbsp4_hwmod = {
 			.idlest_idle_bit = OMAP2430_ST_MCBSP4_SHIFT,
 		},
 	},
-	.opt_clks	= mcbsp_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
 };
 
 /* mcbsp5 */
@@ -359,8 +346,6 @@ static struct omap_hwmod omap2430_mcbsp5_hwmod = {
 			.idlest_idle_bit = OMAP2430_ST_MCBSP5_SHIFT,
 		},
 	},
-	.opt_clks	= mcbsp_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
 };
 
 /* MMC/SD/SDIO common */
diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 8821b9d..a33a2d7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -584,10 +584,6 @@ struct omap_hwmod omap2xxx_dss_dispc_hwmod = {
 	.dev_attr	= &omap2_3_dss_dispc_dev_attr,
 };
 
-static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
-	{ .role = "ick", .clk = "dss_ick" },
-};
-
 struct omap_hwmod omap2xxx_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap2_rfbi_hwmod_class,
@@ -599,8 +595,6 @@ struct omap_hwmod omap2xxx_dss_rfbi_hwmod = {
 			.module_offs = CORE_MOD,
 		},
 	},
-	.opt_clks	= dss_rfbi_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 6b406ca..f36ef0b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -209,11 +209,6 @@ static struct omap_hwmod am33xx_ocpwp_hwmod = {
  * 'debugss' class
  * debug sub system
  */
-static struct omap_hwmod_opt_clk debugss_opt_clks[] = {
-	{ .role = "dbg_sysclk", .clk = "dbg_sysclk_ck" },
-	{ .role = "dbg_clka", .clk = "dbg_clka_ck" },
-};
-
 static struct omap_hwmod_class am33xx_debugss_hwmod_class = {
 	.name		= "debugss",
 };
@@ -229,8 +224,6 @@ static struct omap_hwmod am33xx_debugss_hwmod = {
 			.modulemode	= MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= debugss_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(debugss_opt_clks),
 };
 
 static struct omap_hwmod am33xx_control_hwmod = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 1219280..5b6cbb4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -682,10 +682,6 @@ static struct omap_hwmod_dma_info omap44xx_dss_dsi1_sdma_reqs[] = {
 	{ .dma_req = -1 }
 };
 
-static struct omap_hwmod_opt_clk dss_dsi1_opt_clks[] = {
-	{ .role = "sys_clk", .clk = "dss_sys_clk" },
-};
-
 static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 	.name		= "dss_dsi1",
 	.class		= &omap44xx_dsi_hwmod_class,
@@ -699,8 +695,6 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
-	.opt_clks	= dss_dsi1_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(dss_dsi1_opt_clks),
 };
 
 /* dss_dsi2 */
@@ -714,10 +708,6 @@ static struct omap_hwmod_dma_info omap44xx_dss_dsi2_sdma_reqs[] = {
 	{ .dma_req = -1 }
 };
 
-static struct omap_hwmod_opt_clk dss_dsi2_opt_clks[] = {
-	{ .role = "sys_clk", .clk = "dss_sys_clk" },
-};
-
 static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 	.name		= "dss_dsi2",
 	.class		= &omap44xx_dsi_hwmod_class,
@@ -731,8 +721,6 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
-	.opt_clks	= dss_dsi2_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(dss_dsi2_opt_clks),
 };
 
 /*
@@ -766,10 +754,6 @@ static struct omap_hwmod_dma_info omap44xx_dss_hdmi_sdma_reqs[] = {
 	{ .dma_req = -1 }
 };
 
-static struct omap_hwmod_opt_clk dss_hdmi_opt_clks[] = {
-	{ .role = "sys_clk", .clk = "dss_sys_clk" },
-};
-
 static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	.name		= "dss_hdmi",
 	.class		= &omap44xx_hdmi_hwmod_class,
@@ -788,8 +772,6 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
-	.opt_clks	= dss_hdmi_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(dss_hdmi_opt_clks),
 };
 
 /*
@@ -818,10 +800,6 @@ static struct omap_hwmod_dma_info omap44xx_dss_rfbi_sdma_reqs[] = {
 	{ .dma_req = -1 }
 };
 
-static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
-	{ .role = "ick", .clk = "dss_fck" },
-};
-
 static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap44xx_rfbi_hwmod_class,
@@ -834,8 +812,6 @@ static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
 			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
-	.opt_clks	= dss_rfbi_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
 };
 
 /*
@@ -1015,10 +991,6 @@ static struct omap_gpio_dev_attr gpio_dev_attr = {
 };
 
 /* gpio1 */
-static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio1_dbclk" },
-};
-
 static struct omap_hwmod omap44xx_gpio1_hwmod = {
 	.name		= "gpio1",
 	.class		= &omap44xx_gpio_hwmod_class,
@@ -1031,8 +1003,6 @@ static struct omap_hwmod omap44xx_gpio1_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= gpio1_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
@@ -1462,10 +1432,6 @@ static struct omap_hwmod_class omap44xx_iss_hwmod_class = {
 };
 
 /* iss */
-static struct omap_hwmod_opt_clk iss_opt_clks[] = {
-	{ .role = "ctrlclk", .clk = "iss_ctrlclk" },
-};
-
 static struct omap_hwmod omap44xx_iss_hwmod = {
 	.name		= "iss",
 	.class		= &omap44xx_iss_hwmod_class,
@@ -1478,8 +1444,6 @@ static struct omap_hwmod omap44xx_iss_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= iss_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(iss_opt_clks),
 };
 
 /*
@@ -1643,11 +1607,6 @@ static struct omap_hwmod_class omap44xx_mcbsp_hwmod_class = {
 };
 
 /* mcbsp1 */
-static struct omap_hwmod_opt_clk mcbsp1_opt_clks[] = {
-	{ .role = "pad_fck", .clk = "pad_clks_ck" },
-	{ .role = "prcm_fck", .clk = "mcbsp1_sync_mux_ck" },
-};
-
 static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
 	.name		= "mcbsp1",
 	.class		= &omap44xx_mcbsp_hwmod_class,
@@ -1660,16 +1619,9 @@ static struct omap_hwmod omap44xx_mcbsp1_hwmod = {
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
-
 static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
 	.name		= "mcbsp2",
 	.class		= &omap44xx_mcbsp_hwmod_class,
@@ -1682,16 +1634,9 @@ static struct omap_hwmod omap44xx_mcbsp2_hwmod = {
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
-
 static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
 	.name		= "mcbsp3",
 	.class		= &omap44xx_mcbsp_hwmod_class,
@@ -1704,16 +1649,9 @@ static struct omap_hwmod omap44xx_mcbsp3_hwmod = {
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
-
 static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
 	.name		= "mcbsp4",
 	.class		= &omap44xx_mcbsp_hwmod_class,
@@ -1726,8 +1664,6 @@ static struct omap_hwmod omap44xx_mcbsp4_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mcbsp4_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mcbsp4_opt_clks),
 };
 
 /*
@@ -2397,13 +2333,6 @@ static struct omap_hwmod_class omap44xx_slimbus_hwmod_class = {
 };
 
 /* slimbus1 */
-static struct omap_hwmod_opt_clk slimbus1_opt_clks[] = {
-	{ .role = "fclk_1", .clk = "slimbus1_fclk_1" },
-	{ .role = "fclk_0", .clk = "slimbus1_fclk_0" },
-	{ .role = "fclk_2", .clk = "slimbus1_fclk_2" },
-	{ .role = "slimbus_clk", .clk = "slimbus1_slimbus_clk" },
-};
-
 static struct omap_hwmod omap44xx_slimbus1_hwmod = {
 	.name		= "slimbus1",
 	.class		= &omap44xx_slimbus_hwmod_class,
@@ -2415,17 +2344,9 @@ static struct omap_hwmod omap44xx_slimbus1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= slimbus1_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(slimbus1_opt_clks),
 };
 
 /* slimbus2 */
-static struct omap_hwmod_opt_clk slimbus2_opt_clks[] = {
-	{ .role = "fclk_1", .clk = "slimbus2_fclk_1" },
-	{ .role = "fclk_0", .clk = "slimbus2_fclk_0" },
-	{ .role = "slimbus_clk", .clk = "slimbus2_slimbus_clk" },
-};
-
 static struct omap_hwmod omap44xx_slimbus2_hwmod = {
 	.name		= "slimbus2",
 	.class		= &omap44xx_slimbus_hwmod_class,
@@ -2437,8 +2358,6 @@ static struct omap_hwmod omap44xx_slimbus2_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= slimbus2_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(slimbus2_opt_clks),
 };
 
 /*
@@ -3027,10 +2946,6 @@ static struct omap_hwmod_class omap44xx_usb_otg_hs_hwmod_class = {
 };
 
 /* usb_otg_hs */
-static struct omap_hwmod_opt_clk usb_otg_hs_opt_clks[] = {
-	{ .role = "xclk", .clk = "usb_otg_hs_xclk" },
-};
-
 static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
 	.name		= "usb_otg_hs",
 	.class		= &omap44xx_usb_otg_hs_hwmod_class,
@@ -3044,8 +2959,6 @@ static struct omap_hwmod omap44xx_usb_otg_hs_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= usb_otg_hs_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(usb_otg_hs_opt_clks),
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index 8923172..d4ca9ca 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -409,10 +409,6 @@ static struct omap_gpio_dev_attr gpio_dev_attr = {
 };
 
 /* gpio1 */
-static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio1_dbclk" },
-};
-
 static struct omap_hwmod omap54xx_gpio1_hwmod = {
 	.name		= "gpio1",
 	.class		= &omap54xx_gpio_hwmod_class,
@@ -425,8 +421,6 @@ static struct omap_hwmod omap54xx_gpio1_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= gpio1_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
@@ -792,11 +786,6 @@ static struct omap_hwmod_class omap54xx_mcbsp_hwmod_class = {
 };
 
 /* mcbsp1 */
-static struct omap_hwmod_opt_clk mcbsp1_opt_clks[] = {
-	{ .role = "pad_fck", .clk = "pad_clks_ck" },
-	{ .role = "prcm_fck", .clk = "mcbsp1_sync_mux_ck" },
-};
-
 static struct omap_hwmod omap54xx_mcbsp1_hwmod = {
 	.name		= "mcbsp1",
 	.class		= &omap54xx_mcbsp_hwmod_class,
@@ -809,16 +798,9 @@ static struct omap_hwmod omap54xx_mcbsp1_hwmod = {
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
-
 static struct omap_hwmod omap54xx_mcbsp2_hwmod = {
 	.name		= "mcbsp2",
 	.class		= &omap54xx_mcbsp_hwmod_class,
@@ -831,16 +813,9 @@ static struct omap_hwmod omap54xx_mcbsp2_hwmod = {
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
-
 static struct omap_hwmod omap54xx_mcbsp3_hwmod = {
 	.name		= "mcbsp3",
 	.class		= &omap54xx_mcbsp_hwmod_class,
@@ -853,8 +828,6 @@ static struct omap_hwmod omap54xx_mcbsp3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mcbsp3_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mcbsp3_opt_clks),
 };
 
 /*
@@ -1035,10 +1008,6 @@ static struct omap_hwmod_class omap54xx_mmc_hwmod_class = {
 };
 
 /* mmc1 */
-static struct omap_hwmod_opt_clk mmc1_opt_clks[] = {
-	{ .role = "32khz_clk", .clk = "mmc1_32khz_clk" },
-};
-
 /* mmc1 dev_attr */
 static struct omap_mmc_dev_attr mmc1_dev_attr = {
 	.flags	= OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
@@ -1056,8 +1025,6 @@ static struct omap_hwmod omap54xx_mmc1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mmc1_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mmc1_opt_clks),
 	.dev_attr	= &mmc1_dev_attr,
 };
 
@@ -1732,10 +1699,6 @@ static struct omap_hwmod_class omap54xx_usb_otg_ss_hwmod_class = {
 };
 
 /* usb_otg_ss */
-static struct omap_hwmod_opt_clk usb_otg_ss_opt_clks[] = {
-	{ .role = "refclk960m", .clk = "usb_otg_ss_refclk960m" },
-};
-
 static struct omap_hwmod omap54xx_usb_otg_ss_hwmod = {
 	.name		= "usb_otg_ss",
 	.class		= &omap54xx_usb_otg_ss_hwmod_class,
@@ -1749,8 +1712,6 @@ static struct omap_hwmod omap54xx_usb_otg_ss_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= usb_otg_ss_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(usb_otg_ss_opt_clks),
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 810c205..cfe31310 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -481,11 +481,6 @@ static struct omap_hwmod_class dra7xx_hdmi_hwmod_class = {
 };
 
 /* dss_hdmi */
-
-static struct omap_hwmod_opt_clk dss_hdmi_opt_clks[] = {
-	{ .role = "sys_clk", .clk = "dss_hdmi_clk" },
-};
-
 static struct omap_hwmod dra7xx_dss_hdmi_hwmod = {
 	.name		= "dss_hdmi",
 	.class		= &dra7xx_hdmi_hwmod_class,
@@ -497,8 +492,6 @@ static struct omap_hwmod dra7xx_dss_hdmi_hwmod = {
 			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
 		},
 	},
-	.opt_clks	= dss_hdmi_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(dss_hdmi_opt_clks),
 };
 
 /*
@@ -568,10 +561,6 @@ static struct omap_gpio_dev_attr gpio_dev_attr = {
 };
 
 /* gpio1 */
-static struct omap_hwmod_opt_clk gpio1_opt_clks[] = {
-	{ .role = "dbclk", .clk = "gpio1_dbclk" },
-};
-
 static struct omap_hwmod dra7xx_gpio1_hwmod = {
 	.name		= "gpio1",
 	.class		= &dra7xx_gpio_hwmod_class,
@@ -584,8 +573,6 @@ static struct omap_hwmod dra7xx_gpio1_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= gpio1_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(gpio1_opt_clks),
 	.dev_attr	= &gpio_dev_attr,
 };
 
@@ -1066,10 +1053,6 @@ static struct omap_hwmod_class dra7xx_mmc_hwmod_class = {
 };
 
 /* mmc1 */
-static struct omap_hwmod_opt_clk mmc1_opt_clks[] = {
-	{ .role = "clk32k", .clk = "mmc1_clk32k" },
-};
-
 /* mmc1 dev_attr */
 static struct omap_mmc_dev_attr mmc1_dev_attr = {
 	.flags	= OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
@@ -1087,16 +1070,10 @@ static struct omap_hwmod dra7xx_mmc1_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mmc1_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mmc1_opt_clks),
 	.dev_attr	= &mmc1_dev_attr,
 };
 
 /* mmc2 */
-static struct omap_hwmod_opt_clk mmc2_opt_clks[] = {
-	{ .role = "clk32k", .clk = "mmc2_clk32k" },
-};
-
 static struct omap_hwmod dra7xx_mmc2_hwmod = {
 	.name		= "mmc2",
 	.class		= &dra7xx_mmc_hwmod_class,
@@ -1109,15 +1086,9 @@ static struct omap_hwmod dra7xx_mmc2_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mmc2_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mmc2_opt_clks),
 };
 
 /* mmc3 */
-static struct omap_hwmod_opt_clk mmc3_opt_clks[] = {
-	{ .role = "clk32k", .clk = "mmc3_clk32k" },
-};
-
 static struct omap_hwmod dra7xx_mmc3_hwmod = {
 	.name		= "mmc3",
 	.class		= &dra7xx_mmc_hwmod_class,
@@ -1130,15 +1101,9 @@ static struct omap_hwmod dra7xx_mmc3_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mmc3_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mmc3_opt_clks),
 };
 
 /* mmc4 */
-static struct omap_hwmod_opt_clk mmc4_opt_clks[] = {
-	{ .role = "clk32k", .clk = "mmc4_clk32k" },
-};
-
 static struct omap_hwmod dra7xx_mmc4_hwmod = {
 	.name		= "mmc4",
 	.class		= &dra7xx_mmc_hwmod_class,
@@ -1151,8 +1116,6 @@ static struct omap_hwmod dra7xx_mmc4_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= mmc4_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(mmc4_opt_clks),
 };
 
 /*
@@ -1268,10 +1231,6 @@ static struct omap_hwmod_class dra7xx_sata_hwmod_class = {
 };
 
 /* sata */
-static struct omap_hwmod_opt_clk sata_opt_clks[] = {
-	{ .role = "ref_clk", .clk = "sata_ref_clk" },
-};
-
 static struct omap_hwmod dra7xx_sata_hwmod = {
 	.name		= "sata",
 	.class		= &dra7xx_sata_hwmod_class,
@@ -1285,8 +1244,6 @@ static struct omap_hwmod dra7xx_sata_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= sata_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(sata_opt_clks),
 };
 
 /*
@@ -1736,10 +1693,6 @@ static struct omap_hwmod_class dra7xx_usb_otg_ss_hwmod_class = {
 };
 
 /* usb_otg_ss1 */
-static struct omap_hwmod_opt_clk usb_otg_ss1_opt_clks[] = {
-	{ .role = "refclk960m", .clk = "usb_otg_ss1_refclk960m" },
-};
-
 static struct omap_hwmod dra7xx_usb_otg_ss1_hwmod = {
 	.name		= "usb_otg_ss1",
 	.class		= &dra7xx_usb_otg_ss_hwmod_class,
@@ -1752,15 +1705,9 @@ static struct omap_hwmod dra7xx_usb_otg_ss1_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= usb_otg_ss1_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(usb_otg_ss1_opt_clks),
 };
 
 /* usb_otg_ss2 */
-static struct omap_hwmod_opt_clk usb_otg_ss2_opt_clks[] = {
-	{ .role = "refclk960m", .clk = "usb_otg_ss2_refclk960m" },
-};
-
 static struct omap_hwmod dra7xx_usb_otg_ss2_hwmod = {
 	.name		= "usb_otg_ss2",
 	.class		= &dra7xx_usb_otg_ss_hwmod_class,
@@ -1773,8 +1720,6 @@ static struct omap_hwmod dra7xx_usb_otg_ss2_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.opt_clks	= usb_otg_ss2_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(usb_otg_ss2_opt_clks),
 };
 
 /* usb_otg_ss3 */
-- 
1.7.9.5

