From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 2/5] OMAP3: HWMOD: fix DSS opt clocks
Date: Mon,  8 Aug 2011 12:15:11 +0300
Message-ID: <1312794914-22894-3-git-send-email-tomi.valkeinen@ti.com>
References: <1312794914-22894-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:54547 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752195Ab1HHJP3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Aug 2011 05:15:29 -0400
Received: by mail-fx0-f50.google.com with SMTP id 2so4443266fxh.9
        for <linux-omap@vger.kernel.org>; Mon, 08 Aug 2011 02:15:28 -0700 (PDT)
In-Reply-To: <1312794914-22894-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, linux-omap@vger.kernel.org, b-cousson@ti.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Set HWMOD_CONTROL_OPT_CLKS_IN_RESET for dss_core to allow DSS reset
properly.

Add missing dss_96m_fck, which is used by venc on OMAP3430.

Add missing ick and sys_clk for dsi.

Add missing ick for rfbi.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   35 ++++++++++++++++++++++++---
 1 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 25bf43b..4a02cc3 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1365,13 +1365,19 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_slaves[] = {
 };
 
 static struct omap_hwmod_opt_clk dss_opt_clks[] = {
-	{ .role = "tv_clk", .clk = "dss_tv_fck" },
-	{ .role = "video_clk", .clk = "dss_96m_fck" },
+	/*
+	 * The DSS HW needs all DSS clocks enabled during reset. The dss_core
+	 * driver does not use these clocks.
+	 */
 	{ .role = "sys_clk", .clk = "dss2_alwon_fck" },
+	{ .role = "tv_clk", .clk = "dss_tv_fck" },
+	/* required only on OMAP3430 */
+	{ .role = "tv_dac_clk", .clk = "dss_96m_fck" },
 };
 
 static struct omap_hwmod omap3430es1_dss_core_hwmod = {
 	.name		= "dss_core",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.class		= &omap2_dss_hwmod_class,
 	.main_clk	= "dss1_alwon_fck", /* instead of dss_fck */
 	.sdma_reqs	= omap3xxx_dss_sdma_chs,
@@ -1396,6 +1402,7 @@ static struct omap_hwmod omap3430es1_dss_core_hwmod = {
 
 static struct omap_hwmod omap3xxx_dss_core_hwmod = {
 	.name		= "dss_core",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.class		= &omap2_dss_hwmod_class,
 	.main_clk	= "dss1_alwon_fck", /* instead of dss_fck */
 	.sdma_reqs	= omap3xxx_dss_sdma_chs,
@@ -1488,6 +1495,7 @@ static struct omap_hwmod_addr_space omap3xxx_dss_dsi1_addrs[] = {
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_dsi1 = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_dss_dsi1_hwmod,
+	.clk		= "dss_ick",
 	.addr		= omap3xxx_dss_dsi1_addrs,
 	.fw = {
 		.omap2 = {
@@ -1504,6 +1512,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_dsi1_slaves[] = {
 	&omap3xxx_l4_core__dss_dsi1,
 };
 
+static struct omap_hwmod_opt_clk dss_dsi1_opt_clks[] = {
+	{ .role = "sys_clk", .clk = "dss2_alwon_fck" },
+};
+
 static struct omap_hwmod omap3xxx_dss_dsi1_hwmod = {
 	.name		= "dss_dsi1",
 	.class		= &omap3xxx_dsi_hwmod_class,
@@ -1516,6 +1528,8 @@ static struct omap_hwmod omap3xxx_dss_dsi1_hwmod = {
 			.module_offs = OMAP3430_DSS_MOD,
 		},
 	},
+	.opt_clks	= dss_dsi1_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_dsi1_opt_clks),
 	.slaves		= omap3xxx_dss_dsi1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_dsi1_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
@@ -1545,6 +1559,10 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_rfbi_slaves[] = {
 	&omap3xxx_l4_core__dss_rfbi,
 };
 
+static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
+	{ .role = "ick", .clk = "dss_ick" },
+};
+
 static struct omap_hwmod omap3xxx_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap2_rfbi_hwmod_class,
@@ -1556,6 +1574,8 @@ static struct omap_hwmod omap3xxx_dss_rfbi_hwmod = {
 			.module_offs = OMAP3430_DSS_MOD,
 		},
 	},
+	.opt_clks	= dss_rfbi_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
 	.slaves		= omap3xxx_dss_rfbi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_rfbi_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
@@ -1568,7 +1588,7 @@ static struct omap_hwmod omap3xxx_dss_rfbi_hwmod = {
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__dss_venc = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_dss_venc_hwmod,
-	.clk		= "dss_tv_fck",
+	.clk		= "dss_ick",
 	.addr		= omap2_dss_venc_addrs,
 	.fw = {
 		.omap2 = {
@@ -1586,10 +1606,15 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_venc_slaves[] = {
 	&omap3xxx_l4_core__dss_venc,
 };
 
+static struct omap_hwmod_opt_clk dss_venc_opt_clks[] = {
+	/* required only on OMAP3430 */
+	{ .role = "tv_dac_clk", .clk = "dss_96m_fck" },
+};
+
 static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap2_venc_hwmod_class,
-	.main_clk	= "dss1_alwon_fck",
+	.main_clk	= "dss_tv_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -1597,6 +1622,8 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
 			.module_offs = OMAP3430_DSS_MOD,
 		},
 	},
+	.opt_clks	= dss_venc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_venc_opt_clks),
 	.slaves		= omap3xxx_dss_venc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_dss_venc_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1 |
-- 
1.7.4.1

