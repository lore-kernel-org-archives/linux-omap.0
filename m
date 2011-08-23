From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 5/9] OMAP4: HWMOD: remove extra clocks
Date: Tue, 23 Aug 2011 15:28:15 +0300
Message-ID: <1314102499-30407-6-git-send-email-tomi.valkeinen@ti.com>
References: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:50870 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753191Ab1HWM2p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 08:28:45 -0400
Received: by mail-bw0-f54.google.com with SMTP id t8so42574bka.41
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 05:28:44 -0700 (PDT)
In-Reply-To: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Remove the dss_dss_clk from dss_core's opt-clocks. dss_dss_clk already
defined as the dss main_clk, and thus is not needed as an opt-clock.

Remove opt-clocks for dss_dispc, as dispc only uses the main_clk.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 6201422..48c0458 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1257,7 +1257,6 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_slaves[] = {
 static struct omap_hwmod_opt_clk dss_opt_clks[] = {
 	{ .role = "sys_clk", .clk = "dss_sys_clk" },
 	{ .role = "tv_clk", .clk = "dss_tv_clk" },
-	{ .role = "dss_clk", .clk = "dss_dss_clk" },
 	{ .role = "video_clk", .clk = "dss_48mhz_clk" },
 };
 
@@ -1358,12 +1357,6 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_dispc_slaves[] = {
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
@@ -1377,8 +1370,6 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
 			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
 		},
 	},
-	.opt_clks	= dss_dispc_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(dss_dispc_opt_clks),
 	.slaves		= omap44xx_dss_dispc_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-- 
1.7.4.1

