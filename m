From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/65] OMAPDSS: DISPC: handle 0 out_width/out_height in ovl_setup()
Date: Tue, 22 Nov 2011 11:21:09 +0200
Message-ID: <1321953724-6350-11-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:59958 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757184Ab1KVJWx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:22:53 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Overlay out_width/height are set to 0 when scaling is not used by the
users of omapdss. Currently ovl_setup() expects the caller of
ovl_setup() to convert those zero values to width or height.

This patch makes ovl_setup() accept zero values for out_width/height,
making calling ovl_setup() a bit simpler as the overlay_info can be
just passed to this function without modifications.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 7387e23..49f97db 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1781,6 +1781,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	s32 pix_inc;
 	u16 frame_height = oi->height;
 	unsigned int field_offset = 0;
+	u16 outw, outh;
 
 	DSSDBG("dispc_ovl_setup %d, pa %x, pa_uv %x, sw %d, %d,%d, %dx%d -> "
 		"%dx%d, cmode %x, rot %d, mir %d, ilace %d chan %d repl %d "
@@ -1792,25 +1793,28 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	if (oi->paddr == 0)
 		return -EINVAL;
 
-	if (ilace && oi->height == oi->out_height)
+	outw = oi->out_width == 0 ? oi->width : oi->out_width;
+	outh = oi->out_height == 0 ? oi->height : oi->out_height;
+
+	if (ilace && oi->height == outh)
 		fieldmode = 1;
 
 	if (ilace) {
 		if (fieldmode)
 			oi->height /= 2;
 		oi->pos_y /= 2;
-		oi->out_height /= 2;
+		outh /= 2;
 
 		DSSDBG("adjusting for ilace: height %d, pos_y %d, "
 				"out_height %d\n",
-				oi->height, oi->pos_y, oi->out_height);
+				oi->height, oi->pos_y, outh);
 	}
 
 	if (!dss_feat_color_mode_supported(plane, oi->color_mode))
 		return -EINVAL;
 
 	r = dispc_ovl_calc_scaling(plane, channel, oi->width, oi->height,
-			oi->out_width, oi->out_height, oi->color_mode,
+			outw, outh, oi->color_mode,
 			&five_taps);
 	if (r)
 		return r;
@@ -1828,10 +1832,10 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 		 * so the integer part must be added to the base address of the
 		 * bottom field.
 		 */
-		if (!oi->height || oi->height == oi->out_height)
+		if (!oi->height || oi->height == outh)
 			field_offset = 0;
 		else
-			field_offset = oi->height / oi->out_height / 2;
+			field_offset = oi->height / outh / 2;
 	}
 
 	/* Fields are independent but interleaved in memory. */
@@ -1867,7 +1871,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	dispc_ovl_set_pix_inc(plane, pix_inc);
 
 	DSSDBG("%d,%d %dx%d -> %dx%d\n", oi->pos_x, oi->pos_y, oi->width,
-			oi->height, oi->out_width, oi->out_height);
+			oi->height, outw, outh);
 
 	dispc_ovl_set_pos(plane, oi->pos_x, oi->pos_y);
 
@@ -1875,10 +1879,10 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 
 	if (ovl->caps & OMAP_DSS_OVL_CAP_SCALE) {
 		dispc_ovl_set_scaling(plane, oi->width, oi->height,
-				   oi->out_width, oi->out_height,
+				   outw, outh,
 				   ilace, five_taps, fieldmode,
 				   oi->color_mode, oi->rotation);
-		dispc_ovl_set_vid_size(plane, oi->out_width, oi->out_height);
+		dispc_ovl_set_vid_size(plane, outw, outh);
 		dispc_ovl_set_vid_color_conv(plane, cconv);
 	}
 
-- 
1.7.4.1

