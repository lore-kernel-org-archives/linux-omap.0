From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/4] OMAP4: HWMOD: fix DSS opt clocks
Date: Tue,  2 Aug 2011 13:33:23 +0300
Message-ID: <1312281204-4708-3-git-send-email-tomi.valkeinen@ti.com>
References: <1312281204-4708-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:37586 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752330Ab1HBKeD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Aug 2011 06:34:03 -0400
Received: by mail-fx0-f49.google.com with SMTP id 20so7518743fxd.36
        for <linux-omap@vger.kernel.org>; Tue, 02 Aug 2011 03:34:02 -0700 (PDT)
In-Reply-To: <1312281204-4708-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Benoit Cousson <b-cousson@ti.com>

Remove the opt clocks for dss and dispc, as they are not needed.

Change the main_clk for hdmi and venc to dss_48mhz_clk and dss_tv_clk,
respectively.

Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   21 ++-------------------
 1 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 6201422..21f03d4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1254,13 +1254,6 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_slaves[] = {
 	&omap44xx_l4_per__dss,
 };
 
-static struct omap_hwmod_opt_clk dss_opt_clks[] = {
-	{ .role = "sys_clk", .clk = "dss_sys_clk" },
-	{ .role = "tv_clk", .clk = "dss_tv_clk" },
-	{ .role = "dss_clk", .clk = "dss_dss_clk" },
-	{ .role = "video_clk", .clk = "dss_48mhz_clk" },
-};
-
 static struct omap_hwmod omap44xx_dss_hwmod = {
 	.name		= "dss_core",
 	.class		= &omap44xx_dss_hwmod_class,
@@ -1272,8 +1265,6 @@ static struct omap_hwmod omap44xx_dss_hwmod = {
 			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
-	.opt_clks	= dss_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(dss_opt_clks),
 	.slaves		= omap44xx_dss_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_slaves),
 	.masters	= omap44xx_dss_masters,
@@ -1358,12 +1349,6 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_dispc_slaves[] = {
 	&omap44xx_l4_per__dss_dispc,
 };
 
-static struct omap_hwmod_opt_clk dss_dispc_opt_clks[] = {
-	{ .role = "sys_clk", .clk = "dss_sys_clk" },
-	{ .role = "tv_clk", .clk = "dss_tv_clk" },
-	{ .role = "hdmi_clk", .clk = "dss_48mhz_clk" },
-};
-
 static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 	.name		= "dss_dispc",
 	.class		= &omap44xx_dispc_hwmod_class,
@@ -1377,8 +1362,6 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
-	.opt_clks	= dss_dispc_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(dss_dispc_opt_clks),
 	.slaves		= omap44xx_dss_dispc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1645,7 +1628,7 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
 	.clkdm_name	= "l3_dss_clkdm",
 	.mpu_irqs	= omap44xx_dss_hdmi_irqs,
 	.sdma_reqs	= omap44xx_dss_hdmi_sdma_reqs,
-	.main_clk	= "dss_dss_clk",
+	.main_clk	= "dss_48mhz_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
@@ -1808,7 +1791,7 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 	.name		= "dss_venc",
 	.class		= &omap44xx_venc_hwmod_class,
 	.clkdm_name	= "l3_dss_clkdm",
-	.main_clk	= "dss_dss_clk",
+	.main_clk	= "dss_tv_clk",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
-- 
1.7.4.1

