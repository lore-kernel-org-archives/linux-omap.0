From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH DO NOT MERGE 6/6] ARM: OMAP4: hwmod_data: drop a few clkctrl setups replaced with clocks
Date: Mon, 13 Feb 2017 15:22:37 +0200
Message-ID: <1486992157-10673-7-git-send-email-t-kristo@ti.com>
References: <1486992157-10673-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1486992157-10673-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

With the clkctrl clocks being available as clocks now, the clkctrl
data within hwmod can be dropped away. Do this for the few sample
clocks that have been converted.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index dad871a..3625677 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -517,9 +517,7 @@
 	.main_clk	= "func_dmic_abe_gfclk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM1_ABE_DMIC_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_DMIC_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -1060,9 +1058,7 @@
 	.main_clk	= "l4_div_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_GPIO2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_GPIO2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio2_opt_clks,
@@ -1083,9 +1079,7 @@
 	.main_clk	= "l4_div_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_GPIO3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_GPIO3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
 	.opt_clks	= gpio3_opt_clks,
@@ -1361,9 +1355,7 @@
 	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_I2C2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_I2C2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -1378,9 +1370,7 @@
 	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_I2C3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_I2C3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -1395,9 +1385,7 @@
 	.main_clk	= "func_96m_fclk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_I2C4_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_I2C4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.dev_attr	= &i2c_dev_attr,
@@ -1659,9 +1647,7 @@
 	.main_clk	= "func_mcbsp1_gfclk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM1_ABE_MCBSP1_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_MCBSP1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 	.opt_clks	= mcbsp1_opt_clks,
@@ -1775,9 +1761,7 @@
 	.main_clk	= "pad_clks_ck",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM1_ABE_PDM_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_ABE_PDM_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2013,9 +1997,7 @@
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_MMCSD3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2035,9 +2017,7 @@
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD4_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_MMCSD4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2057,9 +2037,7 @@
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_MMCSD5_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_MMCSD5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2799,9 +2777,7 @@
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_UART1_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_UART1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2815,9 +2791,7 @@
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_UART2_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_UART2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2831,9 +2805,7 @@
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_UART3_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_UART3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
@@ -2847,9 +2819,7 @@
 	.main_clk	= "func_48m_fclk",
 	.prcm = {
 		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_UART4_CLKCTRL_OFFSET,
 			.context_offs = OMAP4_RM_L4PER_UART4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
 };
-- 
1.9.1

