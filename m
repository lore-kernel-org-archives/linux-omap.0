From: Archit Taneja <archit@ti.com>
Subject: [PATCH v4 9/9] OMAPDSS: DISPC: Remove usage of dispc_mgr_get_device()
Date: Wed, 9 May 2012 15:40:56 +0530
Message-ID: <1336558256-26140-10-git-send-email-archit@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
 <1336558256-26140-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53890 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755178Ab2EIKMT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 06:12:19 -0400
In-Reply-To: <1336558256-26140-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The functions calc_fclk_five_taps() and check_horiz_timing_omap3() use the
function dispc_mgr_get_device() to get the omap_dss_device pointer to which
the manager is connected, the width of the panel is derived from it.

The manager's timing is stored in it's private data in APPLY. This contains
the latest timings applied to the manager. Pass these timings to
dispc_ovl_setup() and use them in the above functions. Remove the function
dispc_mgr_get_device() as it isn't used any more.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |    6 ++--
 drivers/video/omap2/dss/dispc.c |   51 +++++++++++++++++---------------------
 drivers/video/omap2/dss/dss.h   |    3 +-
 3 files changed, 28 insertions(+), 32 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 15c070c..dd88b8f 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -548,11 +548,13 @@ static void dss_ovl_write_regs(struct omap_overlay *ovl)
 
 	oi = &op->info;
 
+	mp = get_mgr_priv(ovl->manager);
+
 	replication = dss_use_replication(ovl->manager->device, oi->color_mode);
 
 	ilace = ovl->manager->device->type == OMAP_DISPLAY_TYPE_VENC;
 
-	r = dispc_ovl_setup(ovl->id, oi, ilace, replication);
+	r = dispc_ovl_setup(ovl->id, oi, ilace, replication, &mp->timings);
 	if (r) {
 		/*
 		 * We can't do much here, as this function can be called from
@@ -566,8 +568,6 @@ static void dss_ovl_write_regs(struct omap_overlay *ovl)
 		return;
 	}
 
-	mp = get_mgr_priv(ovl->manager);
-
 	op->info_dirty = false;
 	if (mp->updating)
 		op->shadow_info_dirty = true;
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index cd0a397..727e15b 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -413,14 +413,6 @@ static inline bool dispc_mgr_is_lcd(enum omap_channel channel)
 		return false;
 }
 
-static struct omap_dss_device *dispc_mgr_get_device(enum omap_channel channel)
-{
-	struct omap_overlay_manager *mgr =
-		omap_dss_get_overlay_manager(channel);
-
-	return mgr ? mgr->device : NULL;
-}
-
 u32 dispc_mgr_get_vsync_irq(enum omap_channel channel)
 {
 	switch (channel) {
@@ -1661,18 +1653,17 @@ static void calc_dma_rotation_offset(u8 rotation, bool mirror,
  * This function is used to avoid synclosts in OMAP3, because of some
  * undocumented horizontal position and timing related limitations.
  */
-static int check_horiz_timing_omap3(enum omap_channel channel, u16 pos_x,
+static int check_horiz_timing_omap3(enum omap_channel channel,
+		const struct omap_video_timings *t, u16 pos_x,
 		u16 width, u16 height, u16 out_width, u16 out_height)
 {
 	int DS = DIV_ROUND_UP(height, out_height);
-	struct omap_dss_device *dssdev = dispc_mgr_get_device(channel);
-	struct omap_video_timings t = dssdev->panel.timings;
 	unsigned long nonactive, lclk, pclk;
 	static const u8 limits[3] = { 8, 10, 20 };
 	u64 val, blank;
 	int i;
 
-	nonactive = t.x_res + t.hfp + t.hsw + t.hbp - out_width;
+	nonactive = t->x_res + t->hfp + t->hsw + t->hbp - out_width;
 	pclk = dispc_mgr_pclk_rate(channel);
 	if (dispc_mgr_is_lcd(channel))
 		lclk = dispc_mgr_lclk_rate(channel);
@@ -1684,7 +1675,7 @@ static int check_horiz_timing_omap3(enum omap_channel channel, u16 pos_x,
 		i++;
 	if (out_width < width)
 		i++;
-	blank = div_u64((u64)(t.hbp + t.hsw + t.hfp) * lclk, pclk);
+	blank = div_u64((u64)(t->hbp + t->hsw + t->hfp) * lclk, pclk);
 	DSSDBG("blanking period + ppl = %llu (limit = %u)\n", blank, limits[i]);
 	if (blank <= limits[i])
 		return -EINVAL;
@@ -1715,7 +1706,8 @@ static int check_horiz_timing_omap3(enum omap_channel channel, u16 pos_x,
 }
 
 static unsigned long calc_core_clk_five_taps(enum omap_channel channel,
-		u16 width, u16 height, u16 out_width, u16 out_height,
+		const struct omap_video_timings *mgr_timings, u16 width,
+		u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode)
 {
 	u32 core_clk = 0;
@@ -1725,8 +1717,7 @@ static unsigned long calc_core_clk_five_taps(enum omap_channel channel,
 		return (unsigned long) pclk;
 
 	if (height > out_height) {
-		struct omap_dss_device *dssdev = dispc_mgr_get_device(channel);
-		unsigned int ppl = dssdev->panel.timings.x_res;
+		unsigned int ppl = mgr_timings->x_res;
 
 		tmp = pclk * height * out_width;
 		do_div(tmp, 2 * out_height * ppl);
@@ -1795,8 +1786,9 @@ static unsigned long calc_core_clk(enum omap_channel channel, u16 width,
 }
 
 static int dispc_ovl_calc_scaling(enum omap_plane plane,
-		enum omap_channel channel, u16 width, u16 height,
-		u16 out_width, u16 out_height,
+		enum omap_channel channel,
+		const struct omap_video_timings *mgr_timings,
+		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
 		int *x_predecim, int *y_predecim, u16 pos_x)
 {
@@ -1871,11 +1863,13 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 		do {
 			in_height = DIV_ROUND_UP(height, decim_y);
 			in_width = DIV_ROUND_UP(width, decim_x);
-			core_clk = calc_core_clk_five_taps(channel, in_width,
-				in_height, out_width, out_height, color_mode);
+			core_clk = calc_core_clk_five_taps(channel, mgr_timings,
+				in_width, in_height, out_width, out_height,
+				color_mode);
 
-			error = check_horiz_timing_omap3(channel, pos_x,
-				in_width, in_height, out_width, out_height);
+			error = check_horiz_timing_omap3(channel, mgr_timings,
+				pos_x, in_width, in_height, out_width,
+				out_height);
 
 			if (in_width > maxsinglelinewidth)
 				if (in_height > out_height &&
@@ -1900,8 +1894,8 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 		} while (decim_x <= *x_predecim && decim_y <= *y_predecim
 			&& error);
 
-		if (check_horiz_timing_omap3(channel, pos_x, width, height,
-			out_width, out_height)){
+		if (check_horiz_timing_omap3(channel, mgr_timings, pos_x, width,
+			height, out_width, out_height)){
 				DSSERR("horizontal timing too tight\n");
 				return -EINVAL;
 		}
@@ -1959,7 +1953,8 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 }
 
 int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
-		bool ilace, bool replication)
+		bool ilace, bool replication,
+		const struct omap_video_timings *mgr_timings)
 {
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
 	bool five_taps = true;
@@ -2008,9 +2003,9 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	if (!dss_feat_color_mode_supported(plane, oi->color_mode))
 		return -EINVAL;
 
-	r = dispc_ovl_calc_scaling(plane, channel, in_width, in_height,
-			out_width, out_height, oi->color_mode, &five_taps,
-			&x_predecim, &y_predecim, oi->pos_x);
+	r = dispc_ovl_calc_scaling(plane, channel, mgr_timings, in_width,
+			in_height, out_width, out_height, oi->color_mode,
+			&five_taps, &x_predecim, &y_predecim, oi->pos_x);
 	if (r)
 		return r;
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index f3fa445..8e9e9a5 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -428,7 +428,8 @@ void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
 void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
 		u32 *fifo_low, u32 *fifo_high, bool use_fifomerge);
 int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
-		bool ilace, bool replication);
+		bool ilace, bool replication,
+		const struct omap_video_timings *mgr_timings);
 int dispc_ovl_enable(enum omap_plane plane, bool enable);
 void dispc_ovl_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel);
-- 
1.7.5.4

