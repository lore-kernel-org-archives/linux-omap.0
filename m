From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/65] OMAPDSS: remove partial update from the overlay manager
Date: Tue, 22 Nov 2011 11:21:05 +0200
Message-ID: <1321953724-6350-7-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:40560 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753786Ab1KVJWq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:22:46 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Partial update for manual update displays has never worked quite well:
* The HW has limitations on the update area, and the x and width need to
  be even.
* Showing a part of a scaled overlay causes artifacts.
* Makes the management of dispc very complex

Considering the above points and the fact that partial update is not
used anywhere, this and the following patches remove the partial update
support. This will greatly simplify the following re-write of the apply
mechanism to get proper locking and additional features like fifo-merge.

This patch removes the partial update from the manager.c.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c     |    2 -
 drivers/video/omap2/dss/dss.h     |    3 -
 drivers/video/omap2/dss/manager.c |  333 +------------------------------------
 drivers/video/omap2/dss/rfbi.c    |    1 -
 4 files changed, 6 insertions(+), 333 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 5abf8e7..787cebd 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4172,8 +4172,6 @@ int omap_dsi_prepare_update(struct omap_dss_device *dssdev,
 
 	dsi_perf_mark_setup(dsidev);
 
-	dss_setup_partial_planes(dssdev, x, y, w, h,
-			enlarge_update_area);
 	dispc_mgr_set_lcd_size(dssdev->manager->id, *w, *h);
 
 	return 0;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 313a7ca..7f6a612 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -182,9 +182,6 @@ void default_get_overlay_fifo_thresholds(enum omap_plane plane,
 int dss_init_overlay_managers(struct platform_device *pdev);
 void dss_uninit_overlay_managers(struct platform_device *pdev);
 int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl);
-void dss_setup_partial_planes(struct omap_dss_device *dssdev,
-				u16 *x, u16 *y, u16 *w, u16 *h,
-				bool enlarge_update_area);
 void dss_start_update(struct omap_dss_device *dssdev);
 
 /* overlay */
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 1be5f47..c616f85 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -530,13 +530,6 @@ struct manager_cache_data {
 
 	bool manual_update;
 	bool do_manual_update;
-
-	/* manual update region */
-	u16 x, y, w, h;
-
-	/* enlarge the update area if the update area contains scaled
-	 * overlays */
-	bool enlarge_update_area;
 };
 
 static struct {
@@ -762,65 +755,11 @@ static int overlay_enabled(struct omap_overlay *ovl)
 	return ovl->info.enabled && ovl->manager && ovl->manager->device;
 }
 
-/* Is rect1 a subset of rect2? */
-static bool rectangle_subset(int x1, int y1, int w1, int h1,
-		int x2, int y2, int w2, int h2)
-{
-	if (x1 < x2 || y1 < y2)
-		return false;
-
-	if (x1 + w1 > x2 + w2)
-		return false;
-
-	if (y1 + h1 > y2 + h2)
-		return false;
-
-	return true;
-}
-
-/* Do rect1 and rect2 overlap? */
-static bool rectangle_intersects(int x1, int y1, int w1, int h1,
-		int x2, int y2, int w2, int h2)
-{
-	if (x1 >= x2 + w2)
-		return false;
-
-	if (x2 >= x1 + w1)
-		return false;
-
-	if (y1 >= y2 + h2)
-		return false;
-
-	if (y2 >= y1 + h1)
-		return false;
-
-	return true;
-}
-
-static bool dispc_is_overlay_scaled(struct overlay_cache_data *oc)
-{
-	struct omap_overlay_info *oi = &oc->info;
-
-	if (oi->out_width != 0 && oi->width != oi->out_width)
-		return true;
-
-	if (oi->out_height != 0 && oi->height != oi->out_height)
-		return true;
-
-	return false;
-}
-
 static int configure_overlay(enum omap_plane plane)
 {
 	struct overlay_cache_data *c;
-	struct manager_cache_data *mc;
-	struct omap_overlay_info *oi, new_oi;
-	struct omap_overlay_manager_info *mi;
-	u16 outw, outh;
-	u16 x, y, w, h;
-	u32 paddr;
+	struct omap_overlay_info *oi;
 	int r;
-	u16 orig_w, orig_h, orig_outw, orig_outh;
 
 	DSSDBGF("%d", plane);
 
@@ -832,120 +771,7 @@ static int configure_overlay(enum omap_plane plane)
 		return 0;
 	}
 
-	mc = &dss_cache.manager_cache[c->channel];
-	mi = &mc->info;
-
-	x = oi->pos_x;
-	y = oi->pos_y;
-	w = oi->width;
-	h = oi->height;
-	outw = oi->out_width == 0 ? oi->width : oi->out_width;
-	outh = oi->out_height == 0 ? oi->height : oi->out_height;
-	paddr = oi->paddr;
-
-	orig_w = w;
-	orig_h = h;
-	orig_outw = outw;
-	orig_outh = outh;
-
-	if (mc->manual_update && mc->do_manual_update) {
-		unsigned bpp;
-		unsigned scale_x_m = w, scale_x_d = outw;
-		unsigned scale_y_m = h, scale_y_d = outh;
-
-		/* If the overlay is outside the update region, disable it */
-		if (!rectangle_intersects(mc->x, mc->y, mc->w, mc->h,
-					x, y, outw, outh)) {
-			dispc_ovl_enable(plane, 0);
-			return 0;
-		}
-
-		switch (oi->color_mode) {
-		case OMAP_DSS_COLOR_NV12:
-			bpp = 8;
-			break;
-		case OMAP_DSS_COLOR_RGB16:
-		case OMAP_DSS_COLOR_ARGB16:
-		case OMAP_DSS_COLOR_YUV2:
-		case OMAP_DSS_COLOR_UYVY:
-		case OMAP_DSS_COLOR_RGBA16:
-		case OMAP_DSS_COLOR_RGBX16:
-		case OMAP_DSS_COLOR_ARGB16_1555:
-		case OMAP_DSS_COLOR_XRGB16_1555:
-			bpp = 16;
-			break;
-
-		case OMAP_DSS_COLOR_RGB24P:
-			bpp = 24;
-			break;
-
-		case OMAP_DSS_COLOR_RGB24U:
-		case OMAP_DSS_COLOR_ARGB32:
-		case OMAP_DSS_COLOR_RGBA32:
-		case OMAP_DSS_COLOR_RGBX32:
-			bpp = 32;
-			break;
-
-		default:
-			BUG();
-		}
-
-		if (mc->x > oi->pos_x) {
-			x = 0;
-			outw -= (mc->x - oi->pos_x);
-			paddr += (mc->x - oi->pos_x) *
-				scale_x_m / scale_x_d * bpp / 8;
-		} else {
-			x = oi->pos_x - mc->x;
-		}
-
-		if (mc->y > oi->pos_y) {
-			y = 0;
-			outh -= (mc->y - oi->pos_y);
-			paddr += (mc->y - oi->pos_y) *
-				scale_y_m / scale_y_d *
-				oi->screen_width * bpp / 8;
-		} else {
-			y = oi->pos_y - mc->y;
-		}
-
-		if (mc->w < (x + outw))
-			outw -= (x + outw) - (mc->w);
-
-		if (mc->h < (y + outh))
-			outh -= (y + outh) - (mc->h);
-
-		w = w * outw / orig_outw;
-		h = h * outh / orig_outh;
-
-		/* YUV mode overlay's input width has to be even and the
-		 * algorithm above may adjust the width to be odd.
-		 *
-		 * Here we adjust the width if needed, preferring to increase
-		 * the width if the original width was bigger.
-		 */
-		if ((w & 1) &&
-				(oi->color_mode == OMAP_DSS_COLOR_YUV2 ||
-				 oi->color_mode == OMAP_DSS_COLOR_UYVY)) {
-			if (orig_w > w)
-				w += 1;
-			else
-				w -= 1;
-		}
-	}
-
-	new_oi = *oi;
-
-	/* update new_oi members which could have been possibly updated */
-	new_oi.pos_x = x;
-	new_oi.pos_y = y;
-	new_oi.width = w;
-	new_oi.height = h;
-	new_oi.out_width = outw;
-	new_oi.out_height = outh;
-	new_oi.paddr = paddr;
-
-	r = dispc_ovl_setup(plane, &new_oi, c->ilace, c->channel,
+	r = dispc_ovl_setup(plane, oi, c->ilace, c->channel,
 		c->replication, c->fifo_low, c->fifo_high);
 	if (r) {
 		/* this shouldn't happen */
@@ -1070,170 +896,23 @@ static int configure_dispc(void)
 	return r;
 }
 
-/* Make the coordinates even. There are some strange problems with OMAP and
- * partial DSI update when the update widths are odd. */
-static void make_even(u16 *x, u16 *w)
-{
-	u16 x1, x2;
-
-	x1 = *x;
-	x2 = *x + *w;
-
-	x1 &= ~1;
-	x2 = ALIGN(x2, 2);
-
-	*x = x1;
-	*w = x2 - x1;
-}
-
-/* Configure dispc for partial update. Return possibly modified update
- * area */
-void dss_setup_partial_planes(struct omap_dss_device *dssdev,
-		u16 *xi, u16 *yi, u16 *wi, u16 *hi, bool enlarge_update_area)
+void dss_start_update(struct omap_dss_device *dssdev)
 {
-	struct overlay_cache_data *oc;
 	struct manager_cache_data *mc;
-	struct omap_overlay_info *oi;
+	struct overlay_cache_data *oc;
 	const int num_ovls = dss_feat_get_num_ovls();
+	const int num_mgrs = dss_feat_get_num_mgrs();
 	struct omap_overlay_manager *mgr;
 	int i;
-	u16 x, y, w, h;
-	unsigned long flags;
-	bool area_changed;
-
-	x = *xi;
-	y = *yi;
-	w = *wi;
-	h = *hi;
-
-	DSSDBG("dispc_setup_partial_planes %d,%d %dx%d\n",
-		*xi, *yi, *wi, *hi);
 
 	mgr = dssdev->manager;
 
-	if (!mgr) {
-		DSSDBG("no manager\n");
-		return;
-	}
-
-	make_even(&x, &w);
-
-	spin_lock_irqsave(&dss_cache.lock, flags);
-
-	/*
-	 * Execute the outer loop until the inner loop has completed
-	 * once without increasing the update area. This will ensure that
-	 * all scaled overlays end up completely within the update area.
-	 */
-	do {
-		area_changed = false;
-
-		/* We need to show the whole overlay if it is scaled. So look
-		 * for those, and make the update area larger if found.
-		 * Also mark the overlay cache dirty */
-		for (i = 0; i < num_ovls; ++i) {
-			unsigned x1, y1, x2, y2;
-			unsigned outw, outh;
-
-			oc = &dss_cache.overlay_cache[i];
-			oi = &oc->info;
-
-			if (oc->channel != mgr->id)
-				continue;
-
-			oc->dirty = true;
-
-			if (!enlarge_update_area)
-				continue;
-
-			if (!oc->enabled)
-				continue;
-
-			if (!dispc_is_overlay_scaled(oc))
-				continue;
-
-			outw = oi->out_width == 0 ?
-				oi->width : oi->out_width;
-			outh = oi->out_height == 0 ?
-				oi->height : oi->out_height;
-
-			/* is the overlay outside the update region? */
-			if (!rectangle_intersects(x, y, w, h,
-						oi->pos_x, oi->pos_y,
-						outw, outh))
-				continue;
-
-			/* if the overlay totally inside the update region? */
-			if (rectangle_subset(oi->pos_x, oi->pos_y, outw, outh,
-						x, y, w, h))
-				continue;
-
-			if (x > oi->pos_x)
-				x1 = oi->pos_x;
-			else
-				x1 = x;
-
-			if (y > oi->pos_y)
-				y1 = oi->pos_y;
-			else
-				y1 = y;
-
-			if ((x + w) < (oi->pos_x + outw))
-				x2 = oi->pos_x + outw;
-			else
-				x2 = x + w;
-
-			if ((y + h) < (oi->pos_y + outh))
-				y2 = oi->pos_y + outh;
-			else
-				y2 = y + h;
-
-			x = x1;
-			y = y1;
-			w = x2 - x1;
-			h = y2 - y1;
-
-			make_even(&x, &w);
-
-			DSSDBG("changing upd area due to ovl(%d) "
-			       "scaling %d,%d %dx%d\n",
-				i, x, y, w, h);
-
-			area_changed = true;
-		}
-	} while (area_changed);
-
 	mc = &dss_cache.manager_cache[mgr->id];
-	mc->do_manual_update = true;
-	mc->enlarge_update_area = enlarge_update_area;
-	mc->x = x;
-	mc->y = y;
-	mc->w = w;
-	mc->h = h;
 
+	mc->do_manual_update = true;
 	configure_dispc();
-
 	mc->do_manual_update = false;
 
-	spin_unlock_irqrestore(&dss_cache.lock, flags);
-
-	*xi = x;
-	*yi = y;
-	*wi = w;
-	*hi = h;
-}
-
-void dss_start_update(struct omap_dss_device *dssdev)
-{
-	struct manager_cache_data *mc;
-	struct overlay_cache_data *oc;
-	const int num_ovls = dss_feat_get_num_ovls();
-	const int num_mgrs = dss_feat_get_num_mgrs();
-	struct omap_overlay_manager *mgr;
-	int i;
-
-	mgr = dssdev->manager;
-
 	for (i = 0; i < num_ovls; ++i) {
 		oc = &dss_cache.overlay_cache[i];
 		if (oc->channel != mgr->id)
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 1130c60..814bb95 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -784,7 +784,6 @@ int omap_rfbi_prepare_update(struct omap_dss_device *dssdev,
 	if (*w == 0 || *h == 0)
 		return -EINVAL;
 
-	dss_setup_partial_planes(dssdev, x, y, w, h, true);
 	dispc_mgr_set_lcd_size(dssdev->manager->id, *w, *h);
 
 	return 0;
-- 
1.7.4.1

