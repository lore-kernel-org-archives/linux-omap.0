From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 18/28] OMAP2430: HWMOD: Add DSS opt clocks
Date: Thu,  9 Jun 2011 16:56:40 +0300
Message-ID: <1307627810-3768-19-git-send-email-tomi.valkeinen@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:47278 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758119Ab1FIN5n (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:57:43 -0400
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add DSS optional clocks to HWMOD data for OMAP2430.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 9682dd5..8009945 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1302,6 +1302,7 @@ static struct omap_hwmod_ocp_if *omap2430_dss_slaves[] = {
 };
 
 static struct omap_hwmod_opt_clk dss_opt_clks[] = {
+	{ .role = "dss_clk", .clk = "dss1_fck" },
 	{ .role = "tv_clk", .clk = "dss_54m_fck" },
 	{ .role = "sys_clk", .clk = "dss2_fck" },
 };
@@ -1379,6 +1380,10 @@ static struct omap_hwmod_ocp_if *omap2430_dss_dispc_slaves[] = {
 	&omap2430_l4_core__dss_dispc,
 };
 
+static struct omap_hwmod_opt_clk dispc_opt_clks[] = {
+	{ .role = "dss_clk", .clk = "dss1_fck" },
+};
+
 static struct omap_hwmod omap2430_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
 	.class		= &omap2430_dispc_hwmod_class,
@@ -1394,6 +1399,8 @@ static struct omap_hwmod omap2430_dss_dispc_hwmod = {
 			.idlest_stdby_bit = OMAP24XX_ST_DSS_SHIFT,
 		},
 	},
+	.opt_clks	= dispc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dispc_opt_clks),
 	.slaves		= omap2430_dss_dispc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_dss_dispc_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
@@ -1443,6 +1450,10 @@ static struct omap_hwmod_ocp_if *omap2430_dss_rfbi_slaves[] = {
 	&omap2430_l4_core__dss_rfbi,
 };
 
+static struct omap_hwmod_opt_clk rfbi_opt_clks[] = {
+	{ .role = "rfbi_iclk", .clk = "dss_ick" },
+};
+
 static struct omap_hwmod omap2430_dss_rfbi_hwmod = {
 	.name		= "dss_rfbi",
 	.class		= &omap2430_rfbi_hwmod_class,
@@ -1454,6 +1465,8 @@ static struct omap_hwmod omap2430_dss_rfbi_hwmod = {
 			.module_offs = CORE_MOD,
 		},
 	},
+	.opt_clks	= rfbi_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(rfbi_opt_clks),
 	.slaves		= omap2430_dss_rfbi_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_dss_rfbi_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
@@ -1494,6 +1507,10 @@ static struct omap_hwmod_ocp_if *omap2430_dss_venc_slaves[] = {
 	&omap2430_l4_core__dss_venc,
 };
 
+static struct omap_hwmod_opt_clk venc_opt_clks[] = {
+	{ .role = "tv_clk", .clk = "dss_54m_fck" },
+};
+
 static struct omap_hwmod omap2430_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap2430_venc_hwmod_class,
@@ -1505,6 +1522,8 @@ static struct omap_hwmod omap2430_dss_venc_hwmod = {
 			.module_offs = CORE_MOD,
 		},
 	},
+	.opt_clks	= venc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(venc_opt_clks),
 	.slaves		= omap2430_dss_venc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_dss_venc_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
-- 
1.7.4.1

