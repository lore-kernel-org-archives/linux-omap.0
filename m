From: Archit Taneja <archit@ti.com>
Subject: [PATCH 13/17] OMAPDSS: DISPC/APPLY: Use interlace info in manager timings for dispc_ovl_setup()
Date: Tue, 26 Jun 2012 15:06:50 +0530
Message-ID: <1340703414-1915-15-git-send-email-archit@ti.com>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37215 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756180Ab2FZJjR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jun 2012 05:39:17 -0400
In-Reply-To: <1340703414-1915-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Currently the interlace parameter passed to dispc_ovl_setup() is configured by
checking the display type, and set to true if the display type is VENC.

This isn't correct as other panels can take interlaced content too. The
omap_video_timings struct in manager's private data contains the info whether
the panel is in interlaced mode or not.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |    6 ++----
 drivers/video/omap2/dss/dispc.c |    4 ++--
 drivers/video/omap2/dss/dss.h   |    3 +--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index ab22cc2..3ce7a3e 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -537,7 +537,7 @@ static void dss_ovl_write_regs(struct omap_overlay *ovl)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	struct omap_overlay_info *oi;
-	bool ilace, replication;
+	bool replication;
 	struct mgr_priv_data *mp;
 	int r;
 
@@ -552,9 +552,7 @@ static void dss_ovl_write_regs(struct omap_overlay *ovl)
 
 	replication = dss_use_replication(ovl->manager->device, oi->color_mode);
 
-	ilace = ovl->manager->device->type == OMAP_DISPLAY_TYPE_VENC;
-
-	r = dispc_ovl_setup(ovl->id, oi, ilace, replication, &mp->timings);
+	r = dispc_ovl_setup(ovl->id, oi, replication, &mp->timings);
 	if (r) {
 		/*
 		 * We can't do much here, as this function can be called from
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 92b6428..c0b82c6 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2086,8 +2086,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 }
 
 int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
-		bool ilace, bool replication,
-		const struct omap_video_timings *mgr_timings)
+		bool replication, const struct omap_video_timings *mgr_timings)
 {
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
 	bool five_taps = true;
@@ -2103,6 +2102,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	u16 out_width, out_height;
 	enum omap_channel channel;
 	int x_predecim = 1, y_predecim = 1;
+	bool ilace = mgr_timings->interlace;
 
 	channel = dispc_ovl_get_channel_out(plane);
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 3d23a23..20151d5 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -394,8 +394,7 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
 		u32 *fifo_low, u32 *fifo_high, bool use_fifomerge,
 		bool manual_update);
 int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
-		bool ilace, bool replication,
-		const struct omap_video_timings *mgr_timings);
+		bool replication, const struct omap_video_timings *mgr_timings);
 int dispc_ovl_enable(enum omap_plane plane, bool enable);
 void dispc_ovl_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel);
-- 
1.7.9.5

