From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/4] OMAP: DSS: Minor cleanup in ovl and mgr cache structs
Date: Wed, 22 Jun 2011 11:45:23 +0300
Message-ID: <1308732326-17278-2-git-send-email-tomi.valkeinen@ti.com>
References: <1308732326-17278-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:47857 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751513Ab1FVIpp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jun 2011 04:45:45 -0400
In-Reply-To: <1308732326-17278-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Nishant Kamat <nskamat@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Nishant Kamat <nskamat@ti.com>

The overlay_cache_data and manager_cache_data structs include
the elements of omap_overlay_info and omap_overlay_manager_info
structs respectively. Include the structs instead of the individual
elements to reduce code.

Signed-off-by: Nishant Kamat <nskamat@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/manager.c |  158 ++++++++++++++----------------------
 1 files changed, 62 insertions(+), 96 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index c6d26c6..4691b81 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -391,23 +391,7 @@ struct overlay_cache_data {
 
 	bool enabled;
 
-	u32 paddr;
-	void __iomem *vaddr;
-	u32 p_uv_addr; /* relevant for NV12 format only */
-	u16 screen_width;
-	u16 width;
-	u16 height;
-	enum omap_color_mode color_mode;
-	u8 rotation;
-	enum omap_dss_rotation_type rotation_type;
-	bool mirror;
-
-	u16 pos_x;
-	u16 pos_y;
-	u16 out_width;	/* if 0, out_width == width */
-	u16 out_height;	/* if 0, out_height == height */
-	u8 global_alpha;
-	u8 pre_mult_alpha;
+	struct omap_overlay_info info;
 
 	enum omap_channel channel;
 	bool replication;
@@ -427,13 +411,7 @@ struct manager_cache_data {
 	 * VSYNC/EVSYNC */
 	bool shadow_dirty;
 
-	u32 default_color;
-
-	enum omap_dss_trans_key_type trans_key_type;
-	u32 trans_key;
-	bool trans_enabled;
-
-	bool alpha_enabled;
+	struct omap_overlay_manager_info info;
 
 	bool manual_update;
 	bool do_manual_update;
@@ -699,10 +677,12 @@ static bool rectangle_intersects(int x1, int y1, int w1, int h1,
 
 static bool dispc_is_overlay_scaled(struct overlay_cache_data *oc)
 {
-	if (oc->out_width != 0 && oc->width != oc->out_width)
+	struct omap_overlay_info *oi = &oc->info;
+
+	if (oi->out_width != 0 && oi->width != oi->out_width)
 		return true;
 
-	if (oc->out_height != 0 && oc->height != oc->out_height)
+	if (oi->out_height != 0 && oi->height != oi->out_height)
 		return true;
 
 	return false;
@@ -712,6 +692,8 @@ static int configure_overlay(enum omap_plane plane)
 {
 	struct overlay_cache_data *c;
 	struct manager_cache_data *mc;
+	struct omap_overlay_info *oi;
+	struct omap_overlay_manager_info *mi;
 	u16 outw, outh;
 	u16 x, y, w, h;
 	u32 paddr;
@@ -721,6 +703,7 @@ static int configure_overlay(enum omap_plane plane)
 	DSSDBGF("%d", plane);
 
 	c = &dss_cache.overlay_cache[plane];
+	oi = &c->info;
 
 	if (!c->enabled) {
 		dispc_enable_plane(plane, 0);
@@ -728,14 +711,15 @@ static int configure_overlay(enum omap_plane plane)
 	}
 
 	mc = &dss_cache.manager_cache[c->channel];
+	mi = &mc->info;
 
-	x = c->pos_x;
-	y = c->pos_y;
-	w = c->width;
-	h = c->height;
-	outw = c->out_width == 0 ? c->width : c->out_width;
-	outh = c->out_height == 0 ? c->height : c->out_height;
-	paddr = c->paddr;
+	x = oi->pos_x;
+	y = oi->pos_y;
+	w = oi->width;
+	h = oi->height;
+	outw = oi->out_width == 0 ? oi->width : oi->out_width;
+	outh = oi->out_height == 0 ? oi->height : oi->out_height;
+	paddr = oi->paddr;
 
 	orig_w = w;
 	orig_h = h;
@@ -754,7 +738,7 @@ static int configure_overlay(enum omap_plane plane)
 			return 0;
 		}
 
-		switch (c->color_mode) {
+		switch (oi->color_mode) {
 		case OMAP_DSS_COLOR_NV12:
 			bpp = 8;
 			break;
@@ -784,23 +768,23 @@ static int configure_overlay(enum omap_plane plane)
 			BUG();
 		}
 
-		if (mc->x > c->pos_x) {
+		if (mc->x > oi->pos_x) {
 			x = 0;
-			outw -= (mc->x - c->pos_x);
-			paddr += (mc->x - c->pos_x) *
+			outw -= (mc->x - oi->pos_x);
+			paddr += (mc->x - oi->pos_x) *
 				scale_x_m / scale_x_d * bpp / 8;
 		} else {
-			x = c->pos_x - mc->x;
+			x = oi->pos_x - mc->x;
 		}
 
-		if (mc->y > c->pos_y) {
+		if (mc->y > oi->pos_y) {
 			y = 0;
-			outh -= (mc->y - c->pos_y);
-			paddr += (mc->y - c->pos_y) *
+			outh -= (mc->y - oi->pos_y);
+			paddr += (mc->y - oi->pos_y) *
 				scale_y_m / scale_y_d *
-				c->screen_width * bpp / 8;
+				oi->screen_width * bpp / 8;
 		} else {
-			y = c->pos_y - mc->y;
+			y = oi->pos_y - mc->y;
 		}
 
 		if (mc->w < (x + outw))
@@ -819,8 +803,8 @@ static int configure_overlay(enum omap_plane plane)
 		 * the width if the original width was bigger.
 		 */
 		if ((w & 1) &&
-				(c->color_mode == OMAP_DSS_COLOR_YUV2 ||
-				 c->color_mode == OMAP_DSS_COLOR_UYVY)) {
+				(oi->color_mode == OMAP_DSS_COLOR_YUV2 ||
+				 oi->color_mode == OMAP_DSS_COLOR_UYVY)) {
 			if (orig_w > w)
 				w += 1;
 			else
@@ -830,19 +814,19 @@ static int configure_overlay(enum omap_plane plane)
 
 	r = dispc_setup_plane(plane,
 			paddr,
-			c->screen_width,
+			oi->screen_width,
 			x, y,
 			w, h,
 			outw, outh,
-			c->color_mode,
+			oi->color_mode,
 			c->ilace,
-			c->rotation_type,
-			c->rotation,
-			c->mirror,
-			c->global_alpha,
-			c->pre_mult_alpha,
+			oi->rotation_type,
+			oi->rotation,
+			oi->mirror,
+			oi->global_alpha,
+			oi->pre_mult_alpha,
 			c->channel,
-			c->p_uv_addr);
+			oi->p_uv_addr);
 
 	if (r) {
 		/* this shouldn't happen */
@@ -863,16 +847,17 @@ static int configure_overlay(enum omap_plane plane)
 
 static void configure_manager(enum omap_channel channel)
 {
-	struct manager_cache_data *c;
+	struct omap_overlay_manager_info *mi;
 
 	DSSDBGF("%d", channel);
 
-	c = &dss_cache.manager_cache[channel];
+	/* picking info from the cache */
+	mi = &dss_cache.manager_cache[channel].info;
 
-	dispc_set_default_color(channel, c->default_color);
-	dispc_set_trans_key(channel, c->trans_key_type, c->trans_key);
-	dispc_enable_trans_key(channel, c->trans_enabled);
-	dispc_enable_alpha_blending(channel, c->alpha_enabled);
+	dispc_set_default_color(channel, mi->default_color);
+	dispc_set_trans_key(channel, mi->trans_key_type, mi->trans_key);
+	dispc_enable_trans_key(channel, mi->trans_enabled);
+	dispc_enable_alpha_blending(channel, mi->alpha_enabled);
 }
 
 /* configure_dispc() tries to write values from cache to shadow registers.
@@ -990,6 +975,7 @@ void dss_setup_partial_planes(struct omap_dss_device *dssdev,
 {
 	struct overlay_cache_data *oc;
 	struct manager_cache_data *mc;
+	struct omap_overlay_info *oi;
 	const int num_ovls = dss_feat_get_num_ovls();
 	struct omap_overlay_manager *mgr;
 	int i;
@@ -1032,6 +1018,7 @@ void dss_setup_partial_planes(struct omap_dss_device *dssdev,
 			unsigned outw, outh;
 
 			oc = &dss_cache.overlay_cache[i];
+			oi = &oc->info;
 
 			if (oc->channel != mgr->id)
 				continue;
@@ -1047,39 +1034,39 @@ void dss_setup_partial_planes(struct omap_dss_device *dssdev,
 			if (!dispc_is_overlay_scaled(oc))
 				continue;
 
-			outw = oc->out_width == 0 ?
-				oc->width : oc->out_width;
-			outh = oc->out_height == 0 ?
-				oc->height : oc->out_height;
+			outw = oi->out_width == 0 ?
+				oi->width : oi->out_width;
+			outh = oi->out_height == 0 ?
+				oi->height : oi->out_height;
 
 			/* is the overlay outside the update region? */
 			if (!rectangle_intersects(x, y, w, h,
-						oc->pos_x, oc->pos_y,
+						oi->pos_x, oi->pos_y,
 						outw, outh))
 				continue;
 
 			/* if the overlay totally inside the update region? */
-			if (rectangle_subset(oc->pos_x, oc->pos_y, outw, outh,
+			if (rectangle_subset(oi->pos_x, oi->pos_y, outw, outh,
 						x, y, w, h))
 				continue;
 
-			if (x > oc->pos_x)
-				x1 = oc->pos_x;
+			if (x > oi->pos_x)
+				x1 = oi->pos_x;
 			else
 				x1 = x;
 
-			if (y > oc->pos_y)
-				y1 = oc->pos_y;
+			if (y > oi->pos_y)
+				y1 = oi->pos_y;
 			else
 				y1 = y;
 
-			if ((x + w) < (oc->pos_x + outw))
-				x2 = oc->pos_x + outw;
+			if ((x + w) < (oi->pos_x + outw))
+				x2 = oi->pos_x + outw;
 			else
 				x2 = x + w;
 
-			if ((y + h) < (oc->pos_y + outh))
-				y2 = oc->pos_y + outh;
+			if ((y + h) < (oi->pos_y + outh))
+				y2 = oi->pos_y + outh;
 			else
 				y2 = y + h;
 
@@ -1258,23 +1245,7 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 		ovl->info_dirty = false;
 		oc->dirty = true;
-
-		oc->paddr = ovl->info.paddr;
-		oc->vaddr = ovl->info.vaddr;
-		oc->p_uv_addr = ovl->info.p_uv_addr;
-		oc->screen_width = ovl->info.screen_width;
-		oc->width = ovl->info.width;
-		oc->height = ovl->info.height;
-		oc->color_mode = ovl->info.color_mode;
-		oc->rotation = ovl->info.rotation;
-		oc->rotation_type = ovl->info.rotation_type;
-		oc->mirror = ovl->info.mirror;
-		oc->pos_x = ovl->info.pos_x;
-		oc->pos_y = ovl->info.pos_y;
-		oc->out_width = ovl->info.out_width;
-		oc->out_height = ovl->info.out_height;
-		oc->global_alpha = ovl->info.global_alpha;
-		oc->pre_mult_alpha = ovl->info.pre_mult_alpha;
+		oc->info = ovl->info;
 
 		oc->replication =
 			dss_use_replication(dssdev, ovl->info.color_mode);
@@ -1312,12 +1283,7 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 		mgr->info_dirty = false;
 		mc->dirty = true;
-
-		mc->default_color = mgr->info.default_color;
-		mc->trans_key_type = mgr->info.trans_key_type;
-		mc->trans_key = mgr->info.trans_key;
-		mc->trans_enabled = mgr->info.trans_enabled;
-		mc->alpha_enabled = mgr->info.alpha_enabled;
+		mc->info = mgr->info;
 
 		mc->manual_update =
 			dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
-- 
1.7.4.1

