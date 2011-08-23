From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/9] OMAP3: HWMOD: Fix DSS reset
Date: Tue, 23 Aug 2011 15:28:13 +0300
Message-ID: <1314102499-30407-4-git-send-email-tomi.valkeinen@ti.com>
References: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:39542 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753191Ab1HWM2l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 08:28:41 -0400
Received: by mail-bw0-f41.google.com with SMTP id zt4so42405bkb.28
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 05:28:40 -0700 (PDT)
In-Reply-To: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

DSS needs all DSS clocks to be enabled to be able to finish reset
properly. Before v3.1-rc1 the omapdss driver was managing clocks and
resets correctly. However, when omapdss started using runtime PM at
v3.1-rc1, the responsibility for the reset moved to HWMOD framework.

HWMOD framework does not currently enable all the DSS clocks when
resetting the DSS hardware. This hasn't caused any problems so far, but
we may just have been lucky.

dss_core's opt-clocks is also missing dss_96m_fck, which is a DSS clock
present only on OMAP3430, and thus required on OMAP3430 to finish the
reset.

This patch sets HWMOD_CONTROL_OPT_CLKS_IN_RESET and adds the dss_96m_fck
opt-clock for dss_core in OMAP3 HWMOD data, fixing the issue.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 25bf43b..484eda3 100644
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
-- 
1.7.4.1

