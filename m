From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 17/29] OMAPDSS: DISPC: Make dispc_ovl_setup call dispc_plane_setup
Date: Tue, 27 Dec 2011 18:07:00 +0530
Message-ID: <1324989432-3625-18-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58065 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753752Ab1L0Mjg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Dec 2011 07:39:36 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Add a new static function called dispc_plane_setup(). This function is used by
dispc_ovl_setup() to configure the overlay registers.

This split is done so that dispc_wb_setup() can reuse the common overlay related
registers configured in dispc_plane_setup().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  126 ++++++++++++++++++++++-----------------
 1 files changed, 71 insertions(+), 55 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 58de7d7..eca6157 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1783,63 +1783,54 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 	return 0;
 }
 
-int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
+static int dispc_plane_setup(enum omap_plane plane, enum omap_channel channel,
+		enum omap_overlay_caps caps, u32 paddr, u32 p_uv_addr,
+		u16 screen_width, int pos_x, int pos_y, u16 width, u16 height,
+		u16 out_width, u16 out_height, enum omap_color_mode color_mode,
+		u8 rotation, bool mirror, u8 zorder, u8 pre_mult_alpha,
+		u8 global_alpha, enum omap_dss_rotation_type rotation_type,
 		bool ilace, bool replication)
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
 	u16 outw, outh;
-	enum omap_channel channel;
-
-	channel = dispc_ovl_get_channel_out(plane);
 
-	DSSDBG("dispc_ovl_setup %d, pa %x, pa_uv %x, sw %d, %d,%d, %dx%d -> "
-		"%dx%d, cmode %x, rot %d, mir %d, ilace %d chan %d repl %d\n",
-		plane, oi->paddr, oi->p_uv_addr,
-		oi->screen_width, oi->pos_x, oi->pos_y, oi->width, oi->height,
-		oi->out_width, oi->out_height, oi->color_mode, oi->rotation,
-		oi->mirror, ilace, channel, replication);
-
-	if (oi->paddr == 0)
+	if (paddr == 0)
 		return -EINVAL;
 
-	outw = oi->out_width == 0 ? oi->width : oi->out_width;
-	outh = oi->out_height == 0 ? oi->height : oi->out_height;
+	outw = out_width == 0 ? width : out_width;
+	outh = out_height == 0 ? height : out_height;
 
-	if (ilace && oi->height == outh)
+	if (ilace && height == outh)
 		fieldmode = 1;
 
 	if (ilace) {
 		if (fieldmode)
-			oi->height /= 2;
-		oi->pos_y /= 2;
+			height /= 2;
+		pos_y /= 2;
 		outh /= 2;
 
 		DSSDBG("adjusting for ilace: height %d, pos_y %d, "
-				"out_height %d\n",
-				oi->height, oi->pos_y, outh);
+				"out_height %d\n", height, pos_y, outh);
 	}
 
-	if (!dss_feat_color_mode_supported(plane, oi->color_mode))
+	if (!dss_feat_color_mode_supported(plane, color_mode))
 		return -EINVAL;
 
-	r = dispc_ovl_calc_scaling(plane, channel, caps, oi->width, oi->height,
-			outw, outh, oi->color_mode,
-			&five_taps);
+	r = dispc_ovl_calc_scaling(plane, channel, caps, width, height,
+			outw, outh, color_mode, &five_taps);
 	if (r)
 		return r;
 
-	if (oi->color_mode == OMAP_DSS_COLOR_YUV2 ||
-			oi->color_mode == OMAP_DSS_COLOR_UYVY ||
-			oi->color_mode == OMAP_DSS_COLOR_NV12)
+	if (color_mode == OMAP_DSS_COLOR_YUV2 ||
+			color_mode == OMAP_DSS_COLOR_UYVY ||
+			color_mode == OMAP_DSS_COLOR_NV12)
 		cconv = 1;
 
 	if (ilace && !fieldmode) {
@@ -1850,72 +1841,97 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 		 * so the integer part must be added to the base address of the
 		 * bottom field.
 		 */
-		if (!oi->height || oi->height == outh)
+		if (!height || height == outh)
 			field_offset = 0;
 		else
-			field_offset = oi->height / outh / 2;
+			field_offset = height / outh / 2;
 	}
 
 	/* Fields are independent but interleaved in memory. */
 	if (fieldmode)
 		field_offset = 1;
 
-	if (oi->rotation_type == OMAP_DSS_ROT_DMA)
-		calc_dma_rotation_offset(oi->rotation, oi->mirror,
-				oi->screen_width, oi->width, frame_height,
-				oi->color_mode, fieldmode, field_offset,
+	if (rotation_type == OMAP_DSS_ROT_DMA)
+		calc_dma_rotation_offset(rotation, mirror,
+				screen_width, width, frame_height,
+				color_mode, fieldmode, field_offset,
 				&offset0, &offset1, &row_inc, &pix_inc);
 	else
-		calc_vrfb_rotation_offset(oi->rotation, oi->mirror,
-				oi->screen_width, oi->width, frame_height,
-				oi->color_mode, fieldmode, field_offset,
+		calc_vrfb_rotation_offset(rotation, mirror,
+				screen_width, width, frame_height,
+				color_mode, fieldmode, field_offset,
 				&offset0, &offset1, &row_inc, &pix_inc);
 
 	DSSDBG("offset0 %u, offset1 %u, row_inc %d, pix_inc %d\n",
 			offset0, offset1, row_inc, pix_inc);
 
-	dispc_ovl_set_color_mode(plane, oi->color_mode);
+	dispc_ovl_set_color_mode(plane, color_mode);
 
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
 
 
 	dispc_ovl_set_row_inc(plane, row_inc);
 	dispc_ovl_set_pix_inc(plane, pix_inc);
 
-	DSSDBG("%d,%d %dx%d -> %dx%d\n", oi->pos_x, oi->pos_y, oi->width,
-			oi->height, outw, outh);
+	DSSDBG("%d,%d %dx%d -> %dx%d\n", pos_x, pos_y, width, height,
+			outw, outh);
 
-	dispc_ovl_set_pos(plane, caps, oi->pos_x, oi->pos_y);
+	dispc_ovl_set_pos(plane, caps, pos_x, pos_y);
 
-	dispc_ovl_set_pic_size(plane, oi->width, oi->height);
+	dispc_ovl_set_pic_size(plane, width, height);
 
 	if (caps & OMAP_DSS_OVL_CAP_SCALE) {
-		dispc_ovl_set_scaling(plane, oi->width, oi->height,
+		dispc_ovl_set_scaling(plane, width, height,
 				   outw, outh,
 				   ilace, five_taps, fieldmode,
-				   oi->color_mode, oi->rotation, true);
+				   color_mode, rotation, true);
 		dispc_ovl_set_vid_size(plane, outw, outh);
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
 
+int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
+		bool ilace, bool replication)
+{
+	int r;
+	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
+	enum omap_channel channel;
+
+	channel = dispc_ovl_get_channel_out(plane);
+
+	DSSDBG("dispc_ovl_setup %d, pa %x, pa_uv %x, sw %d, %d,%d, %dx%d -> "
+		"%dx%d, cmode %x, rot %d, mir %d, ilace %d chan %d repl %d\n",
+		plane, oi->paddr, oi->p_uv_addr,
+		oi->screen_width, oi->pos_x, oi->pos_y, oi->width, oi->height,
+		oi->out_width, oi->out_height, oi->color_mode, oi->rotation,
+		oi->mirror, ilace, channel, replication);
+
+	r = dispc_plane_setup(plane, channel, ovl->caps, oi->paddr,
+		oi->p_uv_addr, oi->screen_width, oi->pos_x, oi->pos_y,
+		oi->width, oi->height, oi->out_width, oi->out_height,
+		oi->color_mode, oi->rotation, oi->mirror, oi->zorder,
+		oi->pre_mult_alpha, oi->global_alpha, oi->rotation_type,
+		ilace, replication);
+
+	return r;
+}
+
 int dispc_wb_setup(int id, struct omap_dss_writeback_info *wi)
 {
 	return 0;
-- 
1.7.4.1

