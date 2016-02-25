From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 10/11] ARM: DRA7: hwmod: Add data for McASP1/2/4/5/6/7/8
Date: Thu, 25 Feb 2016 16:50:26 +0200
Message-ID: <1456411827-23962-11-git-send-email-peter.ujfalusi@ti.com>
References: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456411827-23962-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, paul@pwsan.com, robh+dt@kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add missing data for all McASP ports for the dra7 family

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 235 ++++++++++++++++++++++++++++++
 1 file changed, 235 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 3953ad031c43..3bd067afa702 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1374,6 +1374,50 @@ static struct omap_hwmod_class dra7xx_mcasp_hwmod_class = {
 	.sysc	= &dra7xx_mcasp_sysc,
 };
 
+/* mcasp1 */
+static struct omap_hwmod_opt_clk mcasp1_opt_clks[] = {
+	{ .role = "ahclkx", .clk = "mcasp1_ahclkx_mux" },
+};
+
+static struct omap_hwmod dra7xx_mcasp1_hwmod = {
+	.name		= "mcasp1",
+	.class		= &dra7xx_mcasp_hwmod_class,
+	.clkdm_name	= "ipu_clkdm",
+	.main_clk	= "mcasp1_aux_gfclk_mux",
+	.flags		= HWMOD_SWSUP_SIDLE,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_IPU_MCASP1_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_IPU_MCASP1_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+	.opt_clks	= mcasp1_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcasp1_opt_clks),
+};
+
+/* mcasp2 */
+static struct omap_hwmod_opt_clk mcasp2_opt_clks[] = {
+	{ .role = "ahclkx", .clk = "mcasp2_ahclkx_mux" },
+};
+
+static struct omap_hwmod dra7xx_mcasp2_hwmod = {
+	.name		= "mcasp2",
+	.class		= &dra7xx_mcasp_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "mcasp2_aux_gfclk_mux",
+	.flags		= HWMOD_SWSUP_SIDLE,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L4PER2_MCASP2_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L4PER2_MCASP2_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+	.opt_clks	= mcasp2_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcasp2_opt_clks),
+};
+
 /* mcasp3 */
 static struct omap_hwmod_opt_clk mcasp3_opt_clks[] = {
 	{ .role = "ahclkx", .clk = "mcasp3_ahclkx_mux" },
@@ -1396,6 +1440,116 @@ static struct omap_hwmod dra7xx_mcasp3_hwmod = {
 	.opt_clks_cnt	= ARRAY_SIZE(mcasp3_opt_clks),
 };
 
+/* mcasp4 */
+static struct omap_hwmod_opt_clk mcasp4_opt_clks[] = {
+	{ .role = "ahclkx", .clk = "mcasp4_ahclkx_mux" },
+};
+
+static struct omap_hwmod dra7xx_mcasp4_hwmod = {
+	.name		= "mcasp4",
+	.class		= &dra7xx_mcasp_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "mcasp4_aux_gfclk_mux",
+	.flags		= HWMOD_OPT_CLKS_NEEDED,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L4PER2_MCASP4_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L4PER2_MCASP4_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+	.opt_clks	= mcasp4_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcasp4_opt_clks),
+};
+
+/* mcasp5 */
+static struct omap_hwmod_opt_clk mcasp5_opt_clks[] = {
+	{ .role = "ahclkx", .clk = "mcasp5_ahclkx_mux" },
+};
+
+static struct omap_hwmod dra7xx_mcasp5_hwmod = {
+	.name		= "mcasp5",
+	.class		= &dra7xx_mcasp_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "mcasp5_aux_gfclk_mux",
+	.flags		= HWMOD_OPT_CLKS_NEEDED,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L4PER2_MCASP5_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L4PER2_MCASP5_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+	.opt_clks	= mcasp5_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcasp5_opt_clks),
+};
+
+/* mcasp6 */
+static struct omap_hwmod_opt_clk mcasp6_opt_clks[] = {
+	{ .role = "ahclkx", .clk = "mcasp6_ahclkx_mux" },
+};
+
+static struct omap_hwmod dra7xx_mcasp6_hwmod = {
+	.name		= "mcasp6",
+	.class		= &dra7xx_mcasp_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "mcasp6_aux_gfclk_mux",
+	.flags		= HWMOD_OPT_CLKS_NEEDED,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L4PER2_MCASP6_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L4PER2_MCASP6_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+	.opt_clks	= mcasp6_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcasp6_opt_clks),
+};
+
+/* mcasp7 */
+static struct omap_hwmod_opt_clk mcasp7_opt_clks[] = {
+	{ .role = "ahclkx", .clk = "mcasp7_ahclkx_mux" },
+};
+
+static struct omap_hwmod dra7xx_mcasp7_hwmod = {
+	.name		= "mcasp7",
+	.class		= &dra7xx_mcasp_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "mcasp7_aux_gfclk_mux",
+	.flags		= HWMOD_OPT_CLKS_NEEDED,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L4PER2_MCASP7_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L4PER2_MCASP7_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+	.opt_clks	= mcasp7_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcasp7_opt_clks),
+};
+
+/* mcasp8 */
+static struct omap_hwmod_opt_clk mcasp8_opt_clks[] = {
+	{ .role = "ahclkx", .clk = "mcasp8_ahclkx_mux" },
+};
+
+static struct omap_hwmod dra7xx_mcasp8_hwmod = {
+	.name		= "mcasp8",
+	.class		= &dra7xx_mcasp_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "mcasp8_aux_gfclk_mux",
+	.flags		= HWMOD_OPT_CLKS_NEEDED,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DRA7XX_CM_L4PER2_MCASP8_CLKCTRL_OFFSET,
+			.context_offs = DRA7XX_RM_L4PER2_MCASP8_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+	.opt_clks	= mcasp8_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcasp8_opt_clks),
+};
+
 /*
  * 'mmc' class
  *
@@ -2703,6 +2857,38 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__hdmi = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_per2 -> mcasp1 */
+static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp1 = {
+	.master		= &dra7xx_l4_per2_hwmod,
+	.slave		= &dra7xx_mcasp1_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3_main_1 -> mcasp1 */
+static struct omap_hwmod_ocp_if dra7xx_l3_main_1__mcasp1 = {
+	.master		= &dra7xx_l3_main_1_hwmod,
+	.slave		= &dra7xx_mcasp1_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_per2 -> mcasp2 */
+static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp2 = {
+	.master		= &dra7xx_l4_per2_hwmod,
+	.slave		= &dra7xx_mcasp2_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3_main_1 -> mcasp2 */
+static struct omap_hwmod_ocp_if dra7xx_l3_main_1__mcasp2 = {
+	.master		= &dra7xx_l3_main_1_hwmod,
+	.slave		= &dra7xx_mcasp2_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l4_per2 -> mcasp3 */
 static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp3 = {
 	.master		= &dra7xx_l4_per2_hwmod,
@@ -2719,6 +2905,46 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__mcasp3 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_per2 -> mcasp4 */
+static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp4 = {
+	.master		= &dra7xx_l4_per2_hwmod,
+	.slave		= &dra7xx_mcasp4_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_per2 -> mcasp5 */
+static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp5 = {
+	.master		= &dra7xx_l4_per2_hwmod,
+	.slave		= &dra7xx_mcasp5_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_per2 -> mcasp6 */
+static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp6 = {
+	.master		= &dra7xx_l4_per2_hwmod,
+	.slave		= &dra7xx_mcasp6_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_per2 -> mcasp7 */
+static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp7 = {
+	.master		= &dra7xx_l4_per2_hwmod,
+	.slave		= &dra7xx_mcasp7_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l4_per2 -> mcasp8 */
+static struct omap_hwmod_ocp_if dra7xx_l4_per2__mcasp8 = {
+	.master		= &dra7xx_l4_per2_hwmod,
+	.slave		= &dra7xx_mcasp8_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* l4_per1 -> elm */
 static struct omap_hwmod_ocp_if dra7xx_l4_per1__elm = {
 	.master		= &dra7xx_l4_per1_hwmod,
@@ -3461,8 +3687,17 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_wkup__dcan1,
 	&dra7xx_l4_per2__dcan2,
 	&dra7xx_l4_per2__cpgmac0,
+	&dra7xx_l4_per2__mcasp1,
+	&dra7xx_l3_main_1__mcasp1,
+	&dra7xx_l4_per2__mcasp2,
+	&dra7xx_l3_main_1__mcasp2,
 	&dra7xx_l4_per2__mcasp3,
 	&dra7xx_l3_main_1__mcasp3,
+	&dra7xx_l4_per2__mcasp4,
+	&dra7xx_l4_per2__mcasp5,
+	&dra7xx_l4_per2__mcasp6,
+	&dra7xx_l4_per2__mcasp7,
+	&dra7xx_l4_per2__mcasp8,
 	&dra7xx_gmac__mdio,
 	&dra7xx_l4_cfg__dma_system,
 	&dra7xx_l3_main_1__tpcc,
-- 
2.7.1
