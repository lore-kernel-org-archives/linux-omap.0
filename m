From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 01/18] OMAPDSS: DISPC: Constify omap_overlay_info in dispc_ovl_setup()
Date: Tue, 25 Sep 2012 11:49:36 +0530
Message-ID: <1348553993-8083-2-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
 <1348553993-8083-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60550 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753112Ab2IYGUA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 02:20:00 -0400
In-Reply-To: <1348553993-8083-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The struct omap_overlay_info passed to dispc_ovl_setup() is used to configure
DISPC registers. It shouldn't modify the overlay_info structure. The pos_y field
was being changed in dispc_ovl_setup in the case of interlaced displays. Fix
this and const qualifier to the omap_overlay_info argument.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    9 +++++----
 drivers/video/omap2/dss/dss.h   |    2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 33db882..cd3d532 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2253,7 +2253,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 	return 0;
 }
 
-int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
+int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 		bool replication, const struct omap_video_timings *mgr_timings)
 {
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
@@ -2271,6 +2271,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	enum omap_channel channel;
 	int x_predecim = 1, y_predecim = 1;
 	bool ilace = mgr_timings->interlace;
+	u16 pos_y = oi->pos_y;
 
 	channel = dispc_ovl_get_channel_out(plane);
 
@@ -2293,12 +2294,12 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	if (ilace) {
 		if (fieldmode)
 			in_height /= 2;
-		oi->pos_y /= 2;
+		pos_y /= 2;
 		out_height /= 2;
 
 		DSSDBG("adjusting for ilace: height %d, pos_y %d, "
 				"out_height %d\n",
-				in_height, oi->pos_y, out_height);
+				in_height, pos_y, out_height);
 	}
 
 	if (!dss_feat_color_mode_supported(plane, oi->color_mode))
@@ -2381,7 +2382,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	DSSDBG("%d,%d %dx%d -> %dx%d\n", oi->pos_x, oi->pos_y, in_width,
 			in_height, out_width, out_height);
 
-	dispc_ovl_set_pos(plane, oi->pos_x, oi->pos_y);
+	dispc_ovl_set_pos(plane, oi->pos_x, pos_y);
 
 	dispc_ovl_set_pic_size(plane, in_width, in_height);
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index c2bc092..43210b8 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -440,7 +440,7 @@ void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
 void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
 		u32 *fifo_low, u32 *fifo_high, bool use_fifomerge,
 		bool manual_update);
-int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
+int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 		bool replication, const struct omap_video_timings *mgr_timings);
 int dispc_ovl_enable(enum omap_plane plane, bool enable);
 void dispc_ovl_set_channel_out(enum omap_plane plane,
-- 
1.7.9.5

