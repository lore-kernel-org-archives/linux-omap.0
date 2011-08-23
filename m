From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/9] OMAP2xxx: HWMOD: Fix DSS reset
Date: Tue, 23 Aug 2011 15:28:11 +0300
Message-ID: <1314102499-30407-2-git-send-email-tomi.valkeinen@ti.com>
References: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:60082 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752273Ab1HWM2h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 08:28:37 -0400
Received: by mail-bw0-f54.google.com with SMTP id t8so42574bka.41
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 05:28:36 -0700 (PDT)
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

This patch sets HWMOD_CONTROL_OPT_CLKS_IN_RESET for dss_core in OMAP2xxx
HWMOD data, fixing the issue.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    5 +++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a015c69..8fe373d 100644
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
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 16743c7..7a5e7f5 100644
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
-- 
1.7.4.1

