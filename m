From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/4] OMAP2xxx: HWMOD: fix DSS opt clocks
Date: Tue,  2 Aug 2011 13:33:21 +0300
Message-ID: <1312281204-4708-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:41178 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752330Ab1HBKeA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Aug 2011 06:34:00 -0400
Received: by fxg9 with SMTP id 9so7009269fxg.0
        for <linux-omap@vger.kernel.org>; Tue, 02 Aug 2011 03:33:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Set HWMOD_CONTROL_OPT_CLKS_IN_RESET for dss_core to allow DSS reset
properly.

Add missing ick opt-clock for rfbi. Rfbi uses the ick to calculate
timings.

Fix the venc iclk and fclk.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   15 +++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   15 +++++++++++++--
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a015c69..09d9395 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -874,12 +874,17 @@ static struct omap_hwmod_ocp_if *omap2420_dss_slaves[] = {
 };
 
 static struct omap_hwmod_opt_clk dss_opt_clks[] = {
+	/*
+	 * The DSS HW needs all DSS clocks enabled during reset. The dss_core
+	 * driver does not use these clocks.
+	 */
 	{ .role = "tv_clk", .clk = "dss_54m_fck" },
 	{ .role = "sys_clk", .clk = "dss2_fck" },
 };
 
 static struct omap_hwmod omap2420_dss_core_hwmod = {
 	.name		= "dss_core",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.class		= &omap2_dss_hwmod_class,
 	.main_clk	= "dss1_fck", /* instead of dss_fck */
 	.sdma_reqs	= omap2xxx_dss_sdma_chs,
@@ -962,6 +967,10 @@ static struct omap_hwmod_ocp_if *omap2420_dss_rfbi_slaves[] = {
 	&omap2420_l4_core__dss_rfbi,
 };
 
+static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
+	{ .role = "ick", .clk = "dss_ick" },
+};
+
 static struct omap_hwmod omap2420_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap2_rfbi_hwmod_class,
@@ -973,6 +982,8 @@ static struct omap_hwmod omap2420_dss_rfbi_hwmod = {
 			.module_offs = CORE_MOD,
 		},
 	},
+	.opt_clks	= dss_rfbi_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
 	.slaves		= omap2420_dss_rfbi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2420_dss_rfbi_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
@@ -983,7 +994,7 @@ static struct omap_hwmod omap2420_dss_rfbi_hwmod = {
 static struct omap_hwmod_ocp_if omap2420_l4_core__dss_venc = {
 	.master		= &omap2420_l4_core_hwmod,
 	.slave		= &omap2420_dss_venc_hwmod,
-	.clk		= "dss_54m_fck",
+	.clk		= "dss_ick",
 	.addr		= omap2_dss_venc_addrs,
 	.fw = {
 		.omap2 = {
@@ -1003,7 +1014,7 @@ static struct omap_hwmod_ocp_if *omap2420_dss_venc_slaves[] = {
 static struct omap_hwmod omap2420_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap2_venc_hwmod_class,
-	.main_clk	= "dss1_fck",
+	.main_clk	= "dss_54m_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 16743c7..67aff19 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -940,12 +940,17 @@ static struct omap_hwmod_ocp_if *omap2430_dss_slaves[] = {
 };
 
 static struct omap_hwmod_opt_clk dss_opt_clks[] = {
+	/*
+	 * The DSS HW needs all DSS clocks enabled during reset. The dss_core
+	 * driver does not use these clocks.
+	 */
 	{ .role = "tv_clk", .clk = "dss_54m_fck" },
 	{ .role = "sys_clk", .clk = "dss2_fck" },
 };
 
 static struct omap_hwmod omap2430_dss_core_hwmod = {
 	.name		= "dss_core",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.class		= &omap2_dss_hwmod_class,
 	.main_clk	= "dss1_fck", /* instead of dss_fck */
 	.sdma_reqs	= omap2xxx_dss_sdma_chs,
@@ -1016,6 +1021,10 @@ static struct omap_hwmod_ocp_if *omap2430_dss_rfbi_slaves[] = {
 	&omap2430_l4_core__dss_rfbi,
 };
 
+static struct omap_hwmod_opt_clk dss_rfbi_opt_clks[] = {
+	{ .role = "ick", .clk = "dss_ick" },
+};
+
 static struct omap_hwmod omap2430_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap2_rfbi_hwmod_class,
@@ -1027,6 +1036,8 @@ static struct omap_hwmod omap2430_dss_rfbi_hwmod = {
 			.module_offs = CORE_MOD,
 		},
 	},
+	.opt_clks	= dss_rfbi_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dss_rfbi_opt_clks),
 	.slaves		= omap2430_dss_rfbi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_dss_rfbi_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
@@ -1037,7 +1048,7 @@ static struct omap_hwmod omap2430_dss_rfbi_hwmod = {
 static struct omap_hwmod_ocp_if omap2430_l4_core__dss_venc = {
 	.master		= &omap2430_l4_core_hwmod,
 	.slave		= &omap2430_dss_venc_hwmod,
-	.clk		= "dss_54m_fck",
+	.clk		= "dss_ick",
 	.addr		= omap2_dss_venc_addrs,
 	.flags		= OCPIF_SWSUP_IDLE,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
@@ -1051,7 +1062,7 @@ static struct omap_hwmod_ocp_if *omap2430_dss_venc_slaves[] = {
 static struct omap_hwmod omap2430_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap2_venc_hwmod_class,
-	.main_clk	= "dss1_fck",
+	.main_clk	= "dss_54m_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
-- 
1.7.4.1

