From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 17/18] OMAP4: hwmod data: Modify DSS opt clocks
Date: Fri, 1 Jul 2011 22:41:40 +0200
Message-ID: <1309552901-8944-18-git-send-email-b-cousson@ti.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34649 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756524Ab1GAUmU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 16:42:20 -0400
In-Reply-To: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add missing DSS optional clocks to HWMOD data for OMAP4xxx.

Add HWMOD_CONTROL_OPT_CLKS_IN_RESET flag for dispc to fix dispc reset.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
[b-cousson@ti.com: Remove a comment and update the subject]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   44 ++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index f7f4840..ce4259d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1165,6 +1165,7 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_slaves[] = {
 };
 
 static struct omap_hwmod_opt_clk dss_opt_clks[] = {
+	{ .role = "fck", .clk = "dss_dss_clk" },
 	{ .role = "sys_clk", .clk = "dss_sys_clk" },
 	{ .role = "tv_clk", .clk = "dss_tv_clk" },
 	{ .role = "dss_clk", .clk = "dss_dss_clk" },
@@ -1264,9 +1265,17 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_dispc_slaves[] = {
 	&omap44xx_l4_per__dss_dispc,
 };
 
+static struct omap_hwmod_opt_clk dss_dispc_opt_clks[] = {
+	{ .role = "fck", .clk = "dss_dss_clk" },
+	{ .role = "sys_clk", .clk = "dss_sys_clk" },
+	{ .role = "tv_clk", .clk = "dss_tv_clk" },
+	{ .role = "hdmi_clk", .clk = "dss_48mhz_clk" },
+};
+
 static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
 	.class		= &omap44xx_dispc_hwmod_class,
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.mpu_irqs	= omap44xx_dss_dispc_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_irqs),
 	.sdma_reqs	= omap44xx_dss_dispc_sdma_reqs,
@@ -1277,6 +1286,8 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
 		},
 	},
+	.opt_clks	= dss_dispc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_dispc_opt_clks),
 	.slaves		= omap44xx_dss_dispc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
@@ -1355,6 +1366,11 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_dsi1_slaves[] = {
 	&omap44xx_l4_per__dss_dsi1,
 };
 
+static struct omap_hwmod_opt_clk dss_dsi1_opt_clks[] = {
+	{ .role = "fck", .clk = "dss_dss_clk" },
+	{ .role = "sys_clk", .clk = "dss_sys_clk" },
+};
+
 static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 	.name		= "dss_dsi1",
 	.class		= &omap44xx_dsi_hwmod_class,
@@ -1368,6 +1384,8 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
 		},
 	},
+	.opt_clks	= dss_dsi1_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_dsi1_opt_clks),
 	.slaves		= omap44xx_dss_dsi1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_dsi1_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
@@ -1425,6 +1443,11 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_dsi2_slaves[] = {
 	&omap44xx_l4_per__dss_dsi2,
 };
 
+static struct omap_hwmod_opt_clk dss_dsi2_opt_clks[] = {
+	{ .role = "fck", .clk = "dss_dss_clk" },
+	{ .role = "sys_clk", .clk = "dss_sys_clk" },
+};
+
 static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 	.name		= "dss_dsi2",
 	.class		= &omap44xx_dsi_hwmod_class,
@@ -1438,6 +1461,8 @@ static struct omap_hwmod omap44xx_dss_dsi2_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
 		},
 	},
+	.opt_clks	= dss_dsi2_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_dsi2_opt_clks),
 	.slaves		= omap44xx_dss_dsi2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_dsi2_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
@@ -1515,6 +1540,11 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_hdmi_slaves[] = {
 	&omap44xx_l4_per__dss_hdmi,
 };
 
+static struct omap_hwmod_opt_clk dss_hdmi_opt_clks[] = {
+	{ .role = "sys_clk", .clk = "dss_sys_clk" },
+	{ .role = "fck", .clk = "dss_48mhz_clk" },
+};
+
 static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	.name		= "dss_hdmi",
 	.class		= &omap44xx_hdmi_hwmod_class,
@@ -1528,6 +1558,8 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
 		},
 	},
+	.opt_clks	= dss_hdmi_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_hdmi_opt_clks),
 	.slaves		= omap44xx_dss_hdmi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_hdmi_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
@@ -1601,6 +1633,10 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_rfbi_slaves[] = {
 	&omap44xx_l4_per__dss_rfbi,
 };
 
+static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
+	{ .role = "ick", .clk = "dss_fck" },
+};
+
 static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap44xx_rfbi_hwmod_class,
@@ -1612,6 +1648,8 @@ static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
 		},
 	},
+	.opt_clks	= dss_rfbi_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
 	.slaves		= omap44xx_dss_rfbi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_rfbi_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
@@ -1670,6 +1708,10 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_venc_slaves[] = {
 	&omap44xx_l4_per__dss_venc,
 };
 
+static struct omap_hwmod_opt_clk dss_venc_opt_clks[] = {
+	{ .role = "fck", .clk = "dss_tv_clk" },
+};
+
 static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap44xx_venc_hwmod_class,
@@ -1679,6 +1721,8 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
 		},
 	},
+	.opt_clks	= dss_venc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_venc_opt_clks),
 	.slaves		= omap44xx_dss_venc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_venc_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP44XX),
-- 
1.7.0.4

