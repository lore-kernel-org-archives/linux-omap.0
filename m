From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 05/18] OMAPDSS: DISPC: Make dispc_ovl_setup call dispc_ovl_setup_common
Date: Tue, 25 Sep 2012 11:49:40 +0530
Message-ID: <1348553993-8083-6-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
 <1348553993-8083-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48586 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753161Ab2IYGUM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 02:20:12 -0400
In-Reply-To: <1348553993-8083-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Add a new static function called dispc_ovl_setup_common(). This function is used by
dispc_ovl_setup() to configure the overlay registers. This split is done so that
dispc_wb_setup() can reuse overlay register configuration related code.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  128 ++++++++++++++++++++++-----------------
 1 file changed, 71 insertions(+), 57 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 0ff1c07..782de44 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2262,43 +2262,35 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 	return 0;
 }
 
-int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
+static int dispc_ovl_setup_common(enum omap_plane plane,
+		enum omap_channel channel, enum omap_overlay_caps caps,
+		u32 paddr, u32 p_uv_addr, u16 screen_width, int pos_x,
+		int pos_y, u16 width, u16 height, u16 out_width, u16 out_height,
+		enum omap_color_mode color_mode, u8 rotation, bool mirror,
+		u8 zorder, u8 pre_mult_alpha, u8 global_alpha,
+		enum omap_dss_rotation_type rotation_type,
 		bool replication, const struct omap_video_timings *mgr_timings)
 {
-	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
-	enum omap_overlay_caps caps = ovl->caps;
 	bool five_taps = true;
 	bool fieldmode = 0;
 	int r, cconv = 0;
 	unsigned offset0, offset1;
 	s32 row_inc;
 	s32 pix_inc;
-	u16 frame_height = oi->height;
+	u16 frame_height = height;
 	unsigned int field_offset = 0;
-	u16 in_height = oi->height;
-	u16 in_width = oi->width;
-	u16 out_width, out_height;
-	enum omap_channel channel;
+	u16 in_height = height;
+	u16 in_width = width;
 	int x_predecim = 1, y_predecim = 1;
 	bool ilace = mgr_timings->interlace;
-	u16 pos_y = oi->pos_y;
-
-	channel = dispc_ovl_get_channel_out(plane);
-
-	DSSDBG("dispc_ovl_setup %d, pa %x, pa_uv %x, sw %d, %d,%d, %dx%d -> "
-		"%dx%d, cmode %x, rot %d, mir %d, ilace %d chan %d repl %d\n",
-		plane, oi->paddr, oi->p_uv_addr,
-		oi->screen_width, oi->pos_x, oi->pos_y, oi->width, oi->height,
-		oi->out_width, oi->out_height, oi->color_mode, oi->rotation,
-		oi->mirror, ilace, channel, replication);
 
-	if (oi->paddr == 0)
+	if (paddr == 0)
 		return -EINVAL;
 
-	out_width = oi->out_width == 0 ? oi->width : oi->out_width;
-	out_height = oi->out_height == 0 ? oi->height : oi->out_height;
+	out_width = out_width == 0 ? width : out_width;
+	out_height = out_height == 0 ? height : out_height;
 
-	if (ilace && oi->height == out_height)
+	if (ilace && height == out_height)
 		fieldmode = 1;
 
 	if (ilace) {
@@ -2308,26 +2300,26 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 		out_height /= 2;
 
 		DSSDBG("adjusting for ilace: height %d, pos_y %d, "
-				"out_height %d\n",
-				in_height, pos_y, out_height);
+			"out_height %d\n", in_height, pos_y,
+			out_height);
 	}
 
-	if (!dss_feat_color_mode_supported(plane, oi->color_mode))
+	if (!dss_feat_color_mode_supported(plane, color_mode))
 		return -EINVAL;
 
 	r = dispc_ovl_calc_scaling(plane, caps, channel, mgr_timings,
 			in_width, in_height, out_width, out_height,
-			oi->color_mode, &five_taps, &x_predecim, &y_predecim,
-			oi->pos_x);
+			color_mode, &five_taps, &x_predecim, &y_predecim,
+			pos_x);
 	if (r)
 		return r;
 
 	in_width = DIV_ROUND_UP(in_width, x_predecim);
 	in_height = DIV_ROUND_UP(in_height, y_predecim);
 
-	if (oi->color_mode == OMAP_DSS_COLOR_YUV2 ||
-			oi->color_mode == OMAP_DSS_COLOR_UYVY ||
-			oi->color_mode == OMAP_DSS_COLOR_NV12)
+	if (color_mode == OMAP_DSS_COLOR_YUV2 ||
+			color_mode == OMAP_DSS_COLOR_UYVY ||
+			color_mode == OMAP_DSS_COLOR_NV12)
 		cconv = 1;
 
 	if (ilace && !fieldmode) {
@@ -2353,71 +2345,93 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 	row_inc = 0;
 	pix_inc = 0;
 
-	if (oi->rotation_type == OMAP_DSS_ROT_TILER)
-		calc_tiler_rotation_offset(oi->screen_width, in_width,
-				oi->color_mode, fieldmode, field_offset,
+	if (rotation_type == OMAP_DSS_ROT_TILER)
+		calc_tiler_rotation_offset(screen_width, in_width,
+				color_mode, fieldmode, field_offset,
 				&offset0, &offset1, &row_inc, &pix_inc,
 				x_predecim, y_predecim);
-	else if (oi->rotation_type == OMAP_DSS_ROT_DMA)
-		calc_dma_rotation_offset(oi->rotation, oi->mirror,
-				oi->screen_width, in_width, frame_height,
-				oi->color_mode, fieldmode, field_offset,
+	else if (rotation_type == OMAP_DSS_ROT_DMA)
+		calc_dma_rotation_offset(rotation, mirror,
+				screen_width, in_width, frame_height,
+				color_mode, fieldmode, field_offset,
 				&offset0, &offset1, &row_inc, &pix_inc,
 				x_predecim, y_predecim);
 	else
-		calc_vrfb_rotation_offset(oi->rotation, oi->mirror,
-				oi->screen_width, in_width, frame_height,
-				oi->color_mode, fieldmode, field_offset,
+		calc_vrfb_rotation_offset(rotation, mirror,
+				screen_width, in_width, frame_height,
+				color_mode, fieldmode, field_offset,
 				&offset0, &offset1, &row_inc, &pix_inc,
 				x_predecim, y_predecim);
 
 	DSSDBG("offset0 %u, offset1 %u, row_inc %d, pix_inc %d\n",
 			offset0, offset1, row_inc, pix_inc);
 
-	dispc_ovl_set_color_mode(plane, oi->color_mode);
+	dispc_ovl_set_color_mode(plane, color_mode);
 
-	dispc_ovl_configure_burst_type(plane, oi->rotation_type);
+	dispc_ovl_configure_burst_type(plane, rotation_type);
 
-	dispc_ovl_set_ba0(plane, oi->paddr + offset0);
-	dispc_ovl_set_ba1(plane, oi->paddr + offset1);
+	dispc_ovl_set_ba0(plane, paddr + offset0);
+	dispc_ovl_set_ba1(plane, paddr + offset1);
 
-	if (OMAP_DSS_COLOR_NV12 == oi->color_mode) {
-		dispc_ovl_set_ba0_uv(plane, oi->p_uv_addr + offset0);
-		dispc_ovl_set_ba1_uv(plane, oi->p_uv_addr + offset1);
+	if (OMAP_DSS_COLOR_NV12 == color_mode) {
+		dispc_ovl_set_ba0_uv(plane, p_uv_addr + offset0);
+		dispc_ovl_set_ba1_uv(plane, p_uv_addr + offset1);
 	}
 
-
 	dispc_ovl_set_row_inc(plane, row_inc);
 	dispc_ovl_set_pix_inc(plane, pix_inc);
 
-	DSSDBG("%d,%d %dx%d -> %dx%d\n", oi->pos_x, oi->pos_y, in_width,
+	DSSDBG("%d,%d %dx%d -> %dx%d\n", pos_x, pos_y, in_width,
 			in_height, out_width, out_height);
 
-	dispc_ovl_set_pos(plane, caps, oi->pos_x, pos_y);
+	dispc_ovl_set_pos(plane, caps, pos_x, pos_y);
 
 	dispc_ovl_set_input_size(plane, in_width, in_height);
 
 	if (caps & OMAP_DSS_OVL_CAP_SCALE) {
 		dispc_ovl_set_scaling(plane, in_width, in_height, out_width,
 				   out_height, ilace, five_taps, fieldmode,
-				   oi->color_mode, oi->rotation);
-
+				   color_mode, rotation);
 		dispc_ovl_set_output_size(plane, out_width, out_height);
 		dispc_ovl_set_vid_color_conv(plane, cconv);
 	}
 
-	dispc_ovl_set_rotation_attrs(plane, oi->rotation, oi->mirror,
-			oi->color_mode);
+	dispc_ovl_set_rotation_attrs(plane, rotation, mirror, color_mode);
 
-	dispc_ovl_set_zorder(plane, caps, oi->zorder);
-	dispc_ovl_set_pre_mult_alpha(plane, caps, oi->pre_mult_alpha);
-	dispc_ovl_setup_global_alpha(plane, caps, oi->global_alpha);
+	dispc_ovl_set_zorder(plane, caps, zorder);
+	dispc_ovl_set_pre_mult_alpha(plane, caps, pre_mult_alpha);
+	dispc_ovl_setup_global_alpha(plane, caps, global_alpha);
 
 	dispc_ovl_enable_replication(plane, caps, replication);
 
 	return 0;
 }
 
+int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
+		bool replication, const struct omap_video_timings *mgr_timings)
+{
+	int r;
+	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
+	enum omap_channel channel;
+
+	channel = dispc_ovl_get_channel_out(plane);
+
+	DSSDBG("dispc_ovl_setup %d, pa %x, pa_uv %x, sw %d, %d,%d, %dx%d -> "
+		"%dx%d, cmode %x, rot %d, mir %d, chan %d repl %d\n",
+		plane, oi->paddr, oi->p_uv_addr, oi->screen_width, oi->pos_x,
+		oi->pos_y, oi->width, oi->height, oi->out_width, oi->out_height,
+		oi->color_mode, oi->rotation, oi->mirror, channel, replication);
+
+	r = dispc_ovl_setup_common(plane, channel, ovl->caps, oi->paddr,
+		oi->p_uv_addr, oi->screen_width, oi->pos_x, oi->pos_y,
+		oi->width, oi->height, oi->out_width, oi->out_height,
+		oi->color_mode, oi->rotation, oi->mirror, oi->zorder,
+		oi->pre_mult_alpha, oi->global_alpha, oi->rotation_type,
+		replication, mgr_timings);
+
+	return r;
+}
+
 int dispc_ovl_enable(enum omap_plane plane, bool enable)
 {
 	DSSDBG("dispc_enable_plane %d, %d\n", plane, enable);
-- 
1.7.9.5

