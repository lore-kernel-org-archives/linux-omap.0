From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 16/27] OMAP3: HWMOD: Add DSS opt clocks
Date: Fri,  3 Jun 2011 13:00:26 +0300
Message-ID: <1307095237-14805-17-git-send-email-tomi.valkeinen@ti.com>
References: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:52178 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754209Ab1FCKBg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 06:01:36 -0400
In-Reply-To: <1307095237-14805-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DSS optional clocks to HWMOD data for OMAP3xxx.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   37 ++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 909a84d..5fac4c0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1542,9 +1542,15 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_slaves[] = {
 };
 
 static struct omap_hwmod_opt_clk dss_opt_clks[] = {
-	{ .role = "tv_clk", .clk = "dss_tv_fck" },
-	{ .role = "video_clk", .clk = "dss_96m_fck" },
+	{ .role = "dss_clk", .clk = "dss1_alwon_fck" },
+	/*
+	 * The rest of the clocks are not needed by the driver,
+	 * but are needed by the hwmod to reset DSS properly.
+	 */
 	{ .role = "sys_clk", .clk = "dss2_alwon_fck" },
+	{ .role = "tv_clk", .clk = "dss_tv_fck" },
+	/* required only on OMAP3430 */
+	{ .role = "tv_dac_clk", .clk = "dss_96m_fck" },
 };
 
 static struct omap_hwmod omap3430es1_dss_core_hwmod = {
@@ -1656,6 +1662,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_dispc_slaves[] = {
 	&omap3xxx_l4_core__dss_dispc,
 };
 
+static struct omap_hwmod_opt_clk dispc_opt_clks[] = {
+	{ .role = "dss_clk", .clk = "dss1_alwon_fck" },
+};
+
 static struct omap_hwmod omap3xxx_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
 	.class		= &omap3xxx_dispc_hwmod_class,
@@ -1669,6 +1679,8 @@ static struct omap_hwmod omap3xxx_dss_dispc_hwmod = {
 			.module_offs = OMAP3430_DSS_MOD,
 		},
 	},
+	.opt_clks	= dispc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dispc_opt_clks),
 	.slaves		= omap3xxx_dss_dispc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_dispc_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
@@ -1720,6 +1732,11 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_dsi1_slaves[] = {
 	&omap3xxx_l4_core__dss_dsi1,
 };
 
+static struct omap_hwmod_opt_clk dsi1_opt_clks[] = {
+	{ .role = "dss_clk", .clk = "dss1_alwon_fck" },
+	{ .role = "sys_clk", .clk = "dss2_alwon_fck" },
+};
+
 static struct omap_hwmod omap3xxx_dss_dsi1_hwmod = {
 	.name		= "dss_dsi1",
 	.class		= &omap3xxx_dsi_hwmod_class,
@@ -1733,6 +1750,8 @@ static struct omap_hwmod omap3xxx_dss_dsi1_hwmod = {
 			.module_offs = OMAP3430_DSS_MOD,
 		},
 	},
+	.opt_clks	= dsi1_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dsi1_opt_clks),
 	.slaves		= omap3xxx_dss_dsi1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_dsi1_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
@@ -1791,6 +1810,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_rfbi_slaves[] = {
 	&omap3xxx_l4_core__dss_rfbi,
 };
 
+static struct omap_hwmod_opt_clk rfbi_opt_clks[] = {
+	{ .role = "rfbi_iclk", .clk = "dss_ick" },
+};
+
 static struct omap_hwmod omap3xxx_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap3xxx_rfbi_hwmod_class,
@@ -1802,6 +1825,8 @@ static struct omap_hwmod omap3xxx_dss_rfbi_hwmod = {
 			.module_offs = OMAP3430_DSS_MOD,
 		},
 	},
+	.opt_clks	= rfbi_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(rfbi_opt_clks),
 	.slaves		= omap3xxx_dss_rfbi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_rfbi_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
@@ -1851,6 +1876,12 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_venc_slaves[] = {
 	&omap3xxx_l4_core__dss_venc,
 };
 
+static struct omap_hwmod_opt_clk venc_opt_clks[] = {
+	{ .role = "tv_clk", .clk = "dss_tv_fck" },
+	/* required only on OMAP3430 */
+	{ .role = "tv_dac_clk", .clk = "dss_96m_fck" },
+};
+
 static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap3xxx_venc_hwmod_class,
@@ -1862,6 +1893,8 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
 			.module_offs = OMAP3430_DSS_MOD,
 		},
 	},
+	.opt_clks	= venc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(venc_opt_clks),
 	.slaves		= omap3xxx_dss_venc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_venc_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
-- 
1.7.4.1

