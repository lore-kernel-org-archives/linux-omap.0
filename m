From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/8] OMAPDSS: use DSI_FIFO_BUG workaround only for manual update displays
Date: Mon, 21 May 2012 12:27:59 +0300
Message-ID: <1337592486-13040-2-git-send-email-tomi.valkeinen@ti.com>
References: <1337592486-13040-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:39808 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932458Ab2EUJ2W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 05:28:22 -0400
Received: by lboj14 with SMTP id j14so4663414lbo.35
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 02:28:19 -0700 (PDT)
In-Reply-To: <1337592486-13040-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Joe Woodward <jw@terrafix.co.uk>

There is a problem related to DSS FIFO thresholds and power management
on OMAP3. It seems that when the full PM hits in, we get underflows. The
core reason is unknown, but after experiments it looks like only
particular FIFO thresholds work correctly.

This bug is related to an earlier patch, which added special FIFO
threshold configuration for OMAP3, because DSI command mode output
didn't work with the normal threshold configuration.

However, as the above work-around worked fine for other output types
also, we currently always configure thresholds in this special way on
OMAP3. In theory there should be negligible difference with this special
way and the standard way. The first paragraph explains what happens in
practice.

This patch changes the driver to use the special threshold configuration
only when the output is a manual update display on OMAP3. This does
include RFBI displays also, and although it hasn't been tested (no
boards using RFBI) I suspect the similar behaviour is present there
also, as the DISPC side should work similarly for DSI command mode and
RFBI.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>
---
 drivers/video/omap2/dss/apply.c |    2 +-
 drivers/video/omap2/dss/dispc.c |    5 +++--
 drivers/video/omap2/dss/dss.h   |    3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index dd88b8f..ab22cc2 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -966,7 +966,7 @@ static void dss_ovl_setup_fifo(struct omap_overlay *ovl,
 		return;
 
 	dispc_ovl_compute_fifo_thresholds(ovl->id, &fifo_low, &fifo_high,
-			use_fifo_merge);
+			use_fifo_merge, ovl_manual_update(ovl));
 
 	dss_apply_ovl_fifo_thresholds(ovl, fifo_low, fifo_high);
 }
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index b81fafa..ac71fec 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1031,7 +1031,8 @@ void dispc_enable_fifomerge(bool enable)
 }
 
 void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
-		u32 *fifo_low, u32 *fifo_high, bool use_fifomerge)
+		u32 *fifo_low, u32 *fifo_high, bool use_fifomerge,
+		bool manual_update)
 {
 	/*
 	 * All sizes are in bytes. Both the buffer and burst are made of
@@ -1059,7 +1060,7 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
 	 * combined fifo size
 	 */
 
-	if (dss_has_feature(FEAT_OMAP3_DSI_FIFO_BUG)) {
+	if (manual_update && dss_has_feature(FEAT_OMAP3_DSI_FIFO_BUG)) {
 		*fifo_low = ovl_fifo_size - burst_size * 2;
 		*fifo_high = total_fifo_size - burst_size;
 	} else {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 4aa9529..dd1092c 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -395,7 +395,8 @@ int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
 
 void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
 void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
-		u32 *fifo_low, u32 *fifo_high, bool use_fifomerge);
+		u32 *fifo_low, u32 *fifo_high, bool use_fifomerge,
+		bool manual_update);
 int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 		bool ilace, bool replication,
 		const struct omap_video_timings *mgr_timings);
-- 
1.7.9.5

