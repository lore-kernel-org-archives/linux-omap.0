From: Archit Taneja <archit@ti.com>
Subject: [PATCH 03/21] OMAPDSS: DISPC: Rename fifo/burst related functions from dispc_ovl_* to dispc_plane_*
Date: Thu, 13 Sep 2012 17:44:47 +0530
Message-ID: <1347538505-25359-4-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39472 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757877Ab2IMMPM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 08:15:12 -0400
In-Reply-To: <1347538505-25359-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Writeback pipeline uses fifo and burst related IP similar to what the graphics
and video pipe have. Rename the related functions from dispc_ovl_* to
dispc_plane_*. The actual registers are kept as DISPC_OVL_* only to prevent too
much change.

All functions which are common to overlays and writeback are to be named as
dispc_plane_*, functions which are specific to overlays are to be named as
dispc_ovl_*, and writeback as dispc_wb_*.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |    4 ++--
 drivers/video/omap2/dss/dispc.c |   30 +++++++++++++++---------------
 drivers/video/omap2/dss/dss.h   |    4 ++--
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 2b1fa85..9abeca0 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -618,7 +618,7 @@ static void dss_ovl_write_regs_extra(struct omap_overlay *ovl)
 
 	dispc_ovl_enable(ovl->id, op->enabled);
 	dispc_ovl_set_channel_out(ovl->id, op->channel);
-	dispc_ovl_set_fifo_threshold(ovl->id, op->fifo_low, op->fifo_high);
+	dispc_plane_set_fifo_threshold(ovl->id, op->fifo_low, op->fifo_high);
 
 	mp = get_mgr_priv(ovl->manager);
 
@@ -973,7 +973,7 @@ static void dss_ovl_setup_fifo(struct omap_overlay *ovl)
 	if (!op->enabled && !op->enabling)
 		return;
 
-	dispc_ovl_compute_fifo_thresholds(ovl->id, &fifo_low, &fifo_high,
+	dispc_plane_compute_fifo_thresholds(ovl->id, &fifo_low, &fifo_high,
 			use_fifo_merge, ovl_manual_update(ovl));
 
 	dss_apply_ovl_fifo_thresholds(ovl, fifo_low, fifo_high);
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index eae9da4..44e86ad 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -866,7 +866,7 @@ static void dispc_ovl_set_color_mode(enum omap_plane plane,
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), m, 4, 1);
 }
 
-static void dispc_ovl_configure_burst_type(enum omap_plane plane,
+static void dispc_plane_configure_burst_type(enum omap_plane plane,
 		enum omap_dss_rotation_type rotation_type)
 {
 	if (dss_has_feature(FEAT_BURST_2D) == 0)
@@ -976,7 +976,7 @@ static enum omap_channel dispc_ovl_get_channel_out(enum omap_plane plane)
 	return channel;
 }
 
-static void dispc_ovl_set_burst_size(enum omap_plane plane,
+static void dispc_plane_set_burst_size(enum omap_plane plane,
 		enum omap_burst_size burst_size)
 {
 	static const unsigned shifts[] = { 6, 14, 14, 14, };
@@ -993,10 +993,10 @@ static void dispc_configure_burst_sizes(void)
 
 	/* Configure burst size always to maximum size */
 	for (i = 0; i < omap_dss_get_num_overlays(); ++i)
-		dispc_ovl_set_burst_size(i, burst_size);
+		dispc_plane_set_burst_size(i, burst_size);
 }
 
-static u32 dispc_ovl_get_burst_size(enum omap_plane plane)
+static u32 dispc_plane_get_burst_size(enum omap_plane plane)
 {
 	unsigned unit = dss_feat_get_burst_size_unit();
 	/* burst multiplier is always x8 (see dispc_configure_burst_sizes()) */
@@ -1121,7 +1121,7 @@ static void dispc_init_fifos(void)
 	}
 }
 
-static u32 dispc_ovl_get_fifo_size(enum omap_plane plane)
+static u32 dispc_plane_get_fifo_size(enum omap_plane plane)
 {
 	int fifo;
 	u32 size = 0;
@@ -1134,7 +1134,7 @@ static u32 dispc_ovl_get_fifo_size(enum omap_plane plane)
 	return size;
 }
 
-void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
+void dispc_plane_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
 {
 	u8 hi_start, hi_end, lo_start, lo_end;
 	u32 unit;
@@ -1174,7 +1174,7 @@ void dispc_enable_fifomerge(bool enable)
 	REG_FLD_MOD(DISPC_CONFIG, enable ? 1 : 0, 14, 14);
 }
 
-void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
+void dispc_plane_compute_fifo_thresholds(enum omap_plane plane,
 		u32 *fifo_low, u32 *fifo_high, bool use_fifomerge,
 		bool manual_update)
 {
@@ -1184,18 +1184,18 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
 	 */
 
 	unsigned buf_unit = dss_feat_get_buffer_size_unit();
-	unsigned ovl_fifo_size, total_fifo_size, burst_size;
+	unsigned plane_fifo_size, total_fifo_size, burst_size;
 	int i;
 
-	burst_size = dispc_ovl_get_burst_size(plane);
-	ovl_fifo_size = dispc_ovl_get_fifo_size(plane);
+	burst_size = dispc_plane_get_burst_size(plane);
+	plane_fifo_size = dispc_plane_get_fifo_size(plane);
 
 	if (use_fifomerge) {
 		total_fifo_size = 0;
 		for (i = 0; i < omap_dss_get_num_overlays(); ++i)
-			total_fifo_size += dispc_ovl_get_fifo_size(i);
+			total_fifo_size += dispc_plane_get_fifo_size(i);
 	} else {
-		total_fifo_size = ovl_fifo_size;
+		total_fifo_size = plane_fifo_size;
 	}
 
 	/*
@@ -1205,10 +1205,10 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
 	 */
 
 	if (manual_update && dss_has_feature(FEAT_OMAP3_DSI_FIFO_BUG)) {
-		*fifo_low = ovl_fifo_size - burst_size * 2;
+		*fifo_low = plane_fifo_size - burst_size * 2;
 		*fifo_high = total_fifo_size - burst_size;
 	} else {
-		*fifo_low = ovl_fifo_size - burst_size;
+		*fifo_low = plane_fifo_size - burst_size;
 		*fifo_high = total_fifo_size - buf_unit;
 	}
 }
@@ -2371,7 +2371,7 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 
 	dispc_ovl_set_color_mode(plane, oi->color_mode);
 
-	dispc_ovl_configure_burst_type(plane, oi->rotation_type);
+	dispc_plane_configure_burst_type(plane, oi->rotation_type);
 
 	dispc_ovl_set_ba0(plane, oi->paddr + offset0);
 	dispc_ovl_set_ba1(plane, oi->paddr + offset1);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 43210b8..4b1ca03 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -436,8 +436,8 @@ int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
 		struct dispc_clock_info *cinfo);
 
 
-void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
-void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
+void dispc_plane_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
+void dispc_plane_compute_fifo_thresholds(enum omap_plane plane,
 		u32 *fifo_low, u32 *fifo_high, bool use_fifomerge,
 		bool manual_update);
 int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
-- 
1.7.9.5

