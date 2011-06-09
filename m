From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 13/28] OMAP: DSS2: Remove core_dump_clocks
Date: Thu,  9 Jun 2011 16:56:35 +0300
Message-ID: <1307627810-3768-14-git-send-email-tomi.valkeinen@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:53185 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758081Ab1FIN5c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:57:32 -0400
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Currently dss.c does all the low level clock handling in the DSS, and
thus it contains pointers to all the clocks. This allows dss.c to dump
the clock information for all the clocks.

With pm_runtime this is no longer the case, as each submodule will
handle its clocks independently. Thus remove the core_dump_clocks
function as it cannot be used with pm_runtime.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dss.c |   40 ----------------------------------------
 1 files changed, 0 insertions(+), 40 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 4f3de35..ff5664e 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -989,50 +989,10 @@ static void dss_clk_disable_all_no_ctx(void)
 	dss_clk_disable_no_ctx(clks);
 }
 
-#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
-/* CLOCKS */
-static void core_dump_clocks(struct seq_file *s)
-{
-	int i;
-	struct clk *clocks[5] = {
-		dss.dss_ick,
-		dss.dss_fck,
-		dss.dss_sys_clk,
-		dss.dss_tv_fck,
-		dss.dss_video_fck
-	};
-
-	const char *names[5] = {
-		"ick",
-		"fck",
-		"sys_clk",
-		"tv_fck",
-		"video_fck"
-	};
-
-	seq_printf(s, "- CORE -\n");
-
-	seq_printf(s, "internal clk count\t\t%u\n", dss.num_clks_enabled);
-
-	for (i = 0; i < 5; i++) {
-		if (!clocks[i])
-			continue;
-		seq_printf(s, "%s (%s)%*s\t%lu\t%d\n",
-				names[i],
-				clocks[i]->name,
-				24 - strlen(names[i]) - strlen(clocks[i]->name),
-				"",
-				clk_get_rate(clocks[i]),
-				clocks[i]->usecount);
-	}
-}
-#endif /* defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT) */
-
 /* DEBUGFS */
 #if defined(CONFIG_DEBUG_FS) && defined(CONFIG_OMAP2_DSS_DEBUG_SUPPORT)
 void dss_debug_dump_clocks(struct seq_file *s)
 {
-	core_dump_clocks(s);
 	dss_dump_clocks(s);
 	dispc_dump_clocks(s);
 #ifdef CONFIG_OMAP2_DSS_DSI
-- 
1.7.4.1

