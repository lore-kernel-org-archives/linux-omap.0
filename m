From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 15/28] OMAP4: HWMOD: Modify DSS opt clocks
Date: Thu,  9 Jun 2011 16:56:37 +0300
Message-ID: <1307627810-3768-16-git-send-email-tomi.valkeinen@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:39341 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758105Ab1FIN5g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:57:36 -0400
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add missing DSS optional clocks to HWMOD data for OMAP4xxx.

Add HWMOD_CONTROL_OPT_CLKS_IN_RESET flag for dispc to fix dispc reset.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   40 ++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index abc548a..4f6ae94 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1263,9 +1263,21 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_dispc_slaves[] = {
 	&omap44xx_l4_per__dss_dispc,
 };
 
+static struct omap_hwmod_opt_clk dispc_opt_clks[] = {
+	{ .role = "dss_clk", .clk = "dss_dss_clk" },
+	/*
+	 * The rest of the clocks are not needed by the driver,
+	 * but are needed by the hwmod to reset DSS properly.
+	 */
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
@@ -1276,6 +1288,8 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
 		},
 	},
+	.opt_clks	= dispc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dispc_opt_clks),
 	.slaves		= omap44xx_dss_dispc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1354,6 +1368,11 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_dsi1_slaves[] = {
 	&omap44xx_l4_per__dss_dsi1,
 };
 
+static struct omap_hwmod_opt_clk dsi1_opt_clks[] = {
+	{ .role = "dss_clk", .clk = "dss_dss_clk" },
+	{ .role = "sys_clk", .clk = "dss_sys_clk" },
+};
+
 static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 	.name		= "dss_dsi1",
 	.class		= &omap44xx_dsi_hwmod_class,
@@ -1367,6 +1386,8 @@ static struct omap_hwmod omap44xx_dss_dsi1_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
 		},
 	},
+	.opt_clks	= dsi1_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dsi1_opt_clks),
 	.slaves		= omap44xx_dss_dsi1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_dsi1_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1514,6 +1535,11 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_hdmi_slaves[] = {
 	&omap44xx_l4_per__dss_hdmi,
 };
 
+static struct omap_hwmod_opt_clk hdmi_opt_clks[] = {
+	{ .role = "sys_clk", .clk = "dss_sys_clk" },
+	{ .role = "hdmi_clk", .clk = "dss_48mhz_clk" },
+};
+
 static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	.name		= "dss_hdmi",
 	.class		= &omap44xx_hdmi_hwmod_class,
@@ -1527,6 +1553,8 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
 		},
 	},
+	.opt_clks	= hdmi_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(hdmi_opt_clks),
 	.slaves		= omap44xx_dss_hdmi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_hdmi_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1600,6 +1628,10 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_rfbi_slaves[] = {
 	&omap44xx_l4_per__dss_rfbi,
 };
 
+static struct omap_hwmod_opt_clk rfbi_opt_clks[] = {
+	{ .role = "rfbi_iclk", .clk = "dss_fck" },
+};
+
 static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap44xx_rfbi_hwmod_class,
@@ -1611,6 +1643,8 @@ static struct omap_hwmod omap44xx_dss_rfbi_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
 		},
 	},
+	.opt_clks	= rfbi_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(rfbi_opt_clks),
 	.slaves		= omap44xx_dss_rfbi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_rfbi_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1669,6 +1703,10 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_venc_slaves[] = {
 	&omap44xx_l4_per__dss_venc,
 };
 
+static struct omap_hwmod_opt_clk venc_opt_clks[] = {
+	{ .role = "tv_clk", .clk = "dss_tv_clk" },
+};
+
 static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap44xx_venc_hwmod_class,
@@ -1678,6 +1716,8 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_DSS_DSS_CLKCTRL,
 		},
 	},
+	.opt_clks	= venc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(venc_opt_clks),
 	.slaves		= omap44xx_dss_venc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_venc_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-- 
1.7.4.1

