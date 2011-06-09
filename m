From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 22/28] OMAP: DSS2: Remove unused opt_clock_available
Date: Thu,  9 Jun 2011 16:56:44 +0300
Message-ID: <1307627810-3768-23-git-send-email-tomi.valkeinen@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:34532 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758125Ab1FIN5y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:57:54 -0400
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

opt_clock_available() is no longer needed, so remove it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c |   12 ------------
 include/video/omapdss.h       |    2 --
 2 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index c7e19c4..af43620 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -46,17 +46,6 @@ static struct omap_device_pm_latency omap_dss_latency[] = {
 /* oh_core is used for getting opt-clocks */
 static struct omap_hwmod	*oh_core;
 
-static bool opt_clock_available(const char *clk_role)
-{
-	int i;
-
-	for (i = 0; i < oh_core->opt_clks_cnt; i++) {
-		if (!strcmp(oh_core->opt_clks[i].role, clk_role))
-			return true;
-	}
-	return false;
-}
-
 struct omap_dss_hwmod_data {
 	const char *oh_name;
 	const char *dev_name;
@@ -120,7 +109,6 @@ int __init omap_display_init(struct omap_dss_board_info *board_data)
 	pdata.board_data = board_data;
 	pdata.board_data->get_context_loss_count =
 		omap_pm_get_dev_context_loss_count;
-	pdata.opt_clock_available = opt_clock_available;
 
 	for (i = 0; i < oh_count; i++) {
 		oh = omap_hwmod_lookup(curr_dss_hwmod[i].oh_name);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 4f914a5..06914b1 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -264,8 +264,6 @@ static inline int omap_display_init(struct omap_dss_board_info *board_data)
 struct omap_display_platform_data {
 	struct omap_dss_board_info *board_data;
 	/* TODO: Additional members to be added when PM is considered */
-
-	bool (*opt_clock_available)(const char *clk_role);
 };
 
 struct omap_video_timings {
-- 
1.7.4.1

