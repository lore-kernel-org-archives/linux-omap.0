From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH] ARM: OMAP5: Add omap5 DSS related hwmod data
Date: Wed, 12 Mar 2014 12:26:36 +0200
Message-ID: <1394619996-3525-2-git-send-email-tomi.valkeinen@ti.com>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59107 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbaCLK12 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Mar 2014 06:27:28 -0400
In-Reply-To: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Archit Taneja <archit@ti.com>

Add hwmod data for dss core, dispc dsi1, dsi2, rfbi and hdmi. It's more or less
similar to omap4 hwmod data.

Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 283 +++++++++++++++++++++++++++++
 1 file changed, 283 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index e297d6231c3a..c7d33ae26282 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -334,6 +334,235 @@ static struct omap_hwmod omap54xx_dmic_hwmod = {
 };
 
 /*
+ * 'dss' class
+ * display sub-system
+ */
+static struct omap_hwmod_class_sysconfig omap54xx_dss_sysc = {
+	.rev_offs	= 0x0000,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= SYSS_HAS_RESET_STATUS,
+};
+
+static struct omap_hwmod_class omap54xx_dss_hwmod_class = {
+	.name	= "dss",
+	.sysc	= &omap54xx_dss_sysc,
+	.reset	= omap_dss_reset,
+};
+
+/* dss */
+static struct omap_hwmod_opt_clk dss_opt_clks[] = {
+	{ .role = "32khz_clk", .clk = "dss_32khz_clk" },
+	{ .role = "sys_clk", .clk = "dss_sys_clk" },
+	{ .role = "hdmi_clk", .clk = "dss_48mhz_clk" },
+};
+
+static struct omap_hwmod omap54xx_dss_hwmod = {
+	.name		= "dss_core",
+	.class		= &omap54xx_dss_hwmod_class,
+	.clkdm_name	= "dss_clkdm",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
+	.main_clk	= "dss_dss_clk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.context_offs = OMAP54XX_RM_DSS_DSS_CONTEXT_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+	.opt_clks	= dss_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_opt_clks),
+};
+
+/*
+ * 'dispc' class
+ * display controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap54xx_dispc_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_MIDLEMODE |
+			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   MSTANDBY_FORCE | MSTANDBY_NO | MSTANDBY_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap54xx_dispc_hwmod_class = {
+	.name	= "dispc",
+	.sysc	= &omap54xx_dispc_sysc,
+};
+
+/* dss_dispc */
+static struct omap_hwmod_opt_clk dss_dispc_opt_clks[] = {
+	{ .role = "sys_clk", .clk = "dss_sys_clk" },
+};
+
+/* dss_dispc dev_attr */
+static struct omap_dss_dispc_dev_attr dss_dispc_dev_attr = {
+	.has_framedonetv_irq	= 1,
+	.manager_count		= 4,
+};
+
+static struct omap_hwmod omap54xx_dss_dispc_hwmod = {
+	.name		= "dss_dispc",
+	.class		= &omap54xx_dispc_hwmod_class,
+	.clkdm_name	= "dss_clkdm",
+	.main_clk	= "dss_dss_clk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+		},
+	},
+	.opt_clks	= dss_dispc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_dispc_opt_clks),
+	.dev_attr	= &dss_dispc_dev_attr,
+};
+
+/*
+ * 'dsi1' class
+ * display serial interface controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap54xx_dsi1_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap54xx_dsi1_hwmod_class = {
+	.name	= "dsi1",
+	.sysc	= &omap54xx_dsi1_sysc,
+};
+
+/* dss_dsi1_a */
+static struct omap_hwmod_opt_clk dss_dsi1_a_opt_clks[] = {
+	{ .role = "sys_clk", .clk = "dss_sys_clk" },
+};
+
+static struct omap_hwmod omap54xx_dss_dsi1_a_hwmod = {
+	.name		= "dss_dsi1",
+	.class		= &omap54xx_dsi1_hwmod_class,
+	.clkdm_name	= "dss_clkdm",
+	.main_clk	= "dss_dss_clk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+		},
+	},
+	.opt_clks	= dss_dsi1_a_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_dsi1_a_opt_clks),
+};
+
+/* dss_dsi1_c */
+static struct omap_hwmod_opt_clk dss_dsi1_c_opt_clks[] = {
+	{ .role = "sys_clk", .clk = "dss_sys_clk" },
+};
+
+static struct omap_hwmod omap54xx_dss_dsi1_c_hwmod = {
+	.name		= "dss_dsi2",
+	.class		= &omap54xx_dsi1_hwmod_class,
+	.clkdm_name	= "dss_clkdm",
+	.main_clk	= "dss_dss_clk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+		},
+	},
+	.opt_clks	= dss_dsi1_c_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_dsi1_c_opt_clks),
+};
+
+/*
+ * 'hdmi' class
+ * hdmi controller
+ */
+
+static struct omap_hwmod_class_sysconfig omap54xx_hdmi_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.sysc_flags	= (SYSC_HAS_RESET_STATUS | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class omap54xx_hdmi_hwmod_class = {
+	.name	= "hdmi",
+	.sysc	= &omap54xx_hdmi_sysc,
+};
+
+static struct omap_hwmod_opt_clk dss_hdmi_opt_clks[] = {
+	{ .role = "sys_clk", .clk = "dss_sys_clk" },
+};
+
+static struct omap_hwmod omap54xx_dss_hdmi_hwmod = {
+	.name		= "dss_hdmi",
+	.class		= &omap54xx_hdmi_hwmod_class,
+	.clkdm_name	= "dss_clkdm",
+	.main_clk	= "dss_48mhz_clk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+		},
+	},
+	.opt_clks	= dss_hdmi_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_hdmi_opt_clks),
+};
+
+/*
+ * 'rfbi' class
+ * remote frame buffer interface
+ */
+
+static struct omap_hwmod_class_sysconfig omap54xx_rfbi_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap54xx_rfbi_hwmod_class = {
+	.name	= "rfbi",
+	.sysc	= &omap54xx_rfbi_sysc,
+};
+
+/* dss_rfbi */
+static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
+	{ .role = "ick", .clk = "l3_iclk_div" },
+};
+
+static struct omap_hwmod omap54xx_dss_rfbi_hwmod = {
+	.name		= "dss_rfbi",
+	.class		= &omap54xx_rfbi_hwmod_class,
+	.clkdm_name	= "dss_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP54XX_CM_DSS_DSS_CLKCTRL_OFFSET,
+			.flags = HWMOD_OMAP4_NO_CONTEXT_LOSS_BIT,
+		},
+	},
+	.opt_clks	= dss_rfbi_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
+};
+
+/*
  * 'emif' class
  * external memory interface no1 (wrapper)
  */
@@ -1893,6 +2122,54 @@ static struct omap_hwmod_ocp_if omap54xx_l4_abe__dmic = {
 	.user		= OCP_USER_MPU,
 };
 
+/* l3_main_2 -> dss */
+static struct omap_hwmod_ocp_if omap54xx_l3_main_2__dss = {
+	.master		= &omap54xx_l3_main_2_hwmod,
+	.slave		= &omap54xx_dss_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3_main_2 -> dss_dispc */
+static struct omap_hwmod_ocp_if omap54xx_l3_main_2__dss_dispc = {
+	.master		= &omap54xx_l3_main_2_hwmod,
+	.slave		= &omap54xx_dss_dispc_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3_main_2 -> dss_dsi1_a */
+static struct omap_hwmod_ocp_if omap54xx_l3_main_2__dss_dsi1_a = {
+	.master		= &omap54xx_l3_main_2_hwmod,
+	.slave		= &omap54xx_dss_dsi1_a_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3_main_2 -> dss_dsi1_c */
+static struct omap_hwmod_ocp_if omap54xx_l3_main_2__dss_dsi1_c = {
+	.master		= &omap54xx_l3_main_2_hwmod,
+	.slave		= &omap54xx_dss_dsi1_c_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3_main_2 -> dss_hdmi */
+static struct omap_hwmod_ocp_if omap54xx_l3_main_2__dss_hdmi = {
+	.master		= &omap54xx_l3_main_2_hwmod,
+	.slave		= &omap54xx_dss_hdmi_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* l3_main_2 -> dss_rfbi */
+static struct omap_hwmod_ocp_if omap54xx_l3_main_2__dss_rfbi = {
+	.master		= &omap54xx_l3_main_2_hwmod,
+	.slave		= &omap54xx_dss_rfbi_hwmod,
+	.clk		= "l3_iclk_div",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 /* mpu -> emif1 */
 static struct omap_hwmod_ocp_if omap54xx_mpu__emif1 = {
 	.master		= &omap54xx_mpu_hwmod,
@@ -2345,6 +2622,12 @@ static struct omap_hwmod_ocp_if *omap54xx_hwmod_ocp_ifs[] __initdata = {
 	&omap54xx_l4_wkup__counter_32k,
 	&omap54xx_l4_cfg__dma_system,
 	&omap54xx_l4_abe__dmic,
+	&omap54xx_l3_main_2__dss,
+	&omap54xx_l3_main_2__dss_dispc,
+	&omap54xx_l3_main_2__dss_dsi1_a,
+	&omap54xx_l3_main_2__dss_dsi1_c,
+	&omap54xx_l3_main_2__dss_hdmi,
+	&omap54xx_l3_main_2__dss_rfbi,
 	&omap54xx_mpu__emif1,
 	&omap54xx_mpu__emif2,
 	&omap54xx_l4_wkup__gpio1,
-- 
1.8.3.2

