From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 01/10] OMAP: DSS2: Reduce the number of arguments in dispc_ovl_setup()
Date: Wed, 14 Sep 2011 17:53:27 +0530
Message-ID: <1316003008-24192-2-git-send-email-archit@ti.com>
References: <1316003008-24192-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46259 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756527Ab1INMWV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Sep 2011 08:22:21 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p8ECMKFg014188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:22:20 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p8ECMKtG021301
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:22:20 -0500 (CDT)
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p8ECMKhb029130
	for <linux-omap@vger.kernel.org>; Wed, 14 Sep 2011 07:22:20 -0500 (CDT)
In-Reply-To: <1316003008-24192-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

dispc_ovl_setup() currently takes a large number of overlay arguments, most of
these are members of the overlay_info struct. Replace these arguments by
passing a overlay_info pointer instead.

In configure_overlay(), we create an overlay_info struct called new_oi, this is
a copy of the overlay cache's overlay_info member. Update the new_oi parameters
which could have been possibly changed in configure_overlay(). Pass its pointer
pointer to dispc_ovl_setup().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |  125 +++++++++++++++++--------------------
 drivers/video/omap2/dss/dss.h     |   14 +----
 drivers/video/omap2/dss/manager.c |   28 ++++-----
 3 files changed, 72 insertions(+), 95 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 38d6595..f01a26d 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1674,17 +1674,8 @@ static unsigned long calc_fclk(enum omap_channel channel, u16 width,
 	return dispc_mgr_pclk_rate(channel) * vf * hf;
 }
 
-int dispc_ovl_setup(enum omap_plane plane,
-		u32 paddr, u16 screen_width,
-		u16 pos_x, u16 pos_y,
-		u16 width, u16 height,
-		u16 out_width, u16 out_height,
-		enum omap_color_mode color_mode,
-		bool ilace,
-		enum omap_dss_rotation_type rotation_type,
-		u8 rotation, bool mirror,
-		u8 global_alpha, u8 pre_mult_alpha,
-		enum omap_channel channel, u32 puv_addr)
+int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
+		bool ilace, enum omap_channel channel)
 {
 	const int maxdownscale = cpu_is_omap34xx() ? 4 : 2;
 	bool five_taps = 0;
@@ -1693,79 +1684,78 @@ int dispc_ovl_setup(enum omap_plane plane,
 	unsigned offset0, offset1;
 	s32 row_inc;
 	s32 pix_inc;
-	u16 frame_height = height;
+	u16 frame_height = oi->height;
 	unsigned int field_offset = 0;
 
-	DSSDBG("dispc_ovl_setup %d, pa %x, sw %d, %d,%d, %dx%d -> "
-	       "%dx%d, ilace %d, cmode %x, rot %d, mir %d chan %d\n",
-	       plane, paddr, screen_width, pos_x, pos_y,
-	       width, height,
-	       out_width, out_height,
-	       ilace, color_mode,
-	       rotation, mirror, channel);
+	DSSDBG("dispc_ovl_setup %d, pa %x, pa_uv %x, sw %d, %d,%d, %dx%d -> "
+		"%dx%d, cmode %x, rot %d, mir %d, ilace %d chan %d\n",
+		plane, oi->paddr, oi->p_uv_addr, oi->screen_width, oi->pos_x,
+		oi->pos_y, oi->width, oi->height, oi->out_width, oi->out_height,
+		oi->color_mode, oi->rotation, oi->mirror, ilace, channel);
 
-	if (paddr == 0)
+	if (oi->paddr == 0)
 		return -EINVAL;
 
-	if (ilace && height == out_height)
+	if (ilace && oi->height == oi->out_height)
 		fieldmode = 1;
 
 	if (ilace) {
 		if (fieldmode)
-			height /= 2;
-		pos_y /= 2;
-		out_height /= 2;
+			oi->height /= 2;
+		oi->pos_y /= 2;
+		oi->out_height /= 2;
 
 		DSSDBG("adjusting for ilace: height %d, pos_y %d, "
 				"out_height %d\n",
-				height, pos_y, out_height);
+				oi->height, oi->pos_y, oi->out_height);
 	}
 
-	if (!dss_feat_color_mode_supported(plane, color_mode))
+	if (!dss_feat_color_mode_supported(plane, oi->color_mode))
 		return -EINVAL;
 
 	if (plane == OMAP_DSS_GFX) {
-		if (width != out_width || height != out_height)
+		if (oi->width != oi->out_width || oi->height != oi->out_height)
 			return -EINVAL;
 	} else {
 		/* video plane */
 
 		unsigned long fclk = 0;
 
-		if (out_width < width / maxdownscale ||
-		   out_width > width * 8)
+		if (oi->out_width < oi->width / maxdownscale ||
+		   oi->out_width > oi->width * 8)
 			return -EINVAL;
 
-		if (out_height < height / maxdownscale ||
-		   out_height > height * 8)
+		if (oi->out_height < oi->height / maxdownscale ||
+		   oi->out_height > oi->height * 8)
 			return -EINVAL;
 
-		if (color_mode == OMAP_DSS_COLOR_YUV2 ||
-			color_mode == OMAP_DSS_COLOR_UYVY ||
-			color_mode == OMAP_DSS_COLOR_NV12)
+		if (oi->color_mode == OMAP_DSS_COLOR_YUV2 ||
+				oi->color_mode == OMAP_DSS_COLOR_UYVY ||
+				oi->color_mode == OMAP_DSS_COLOR_NV12)
 			cconv = 1;
 
 		/* Must use 5-tap filter? */
-		five_taps = height > out_height * 2;
+		five_taps = oi->height > oi->out_height * 2;
 
 		if (!five_taps) {
-			fclk = calc_fclk(channel, width, height, out_width,
-					out_height);
+			fclk = calc_fclk(channel, oi->width, oi->height,
+					oi->out_width, oi->out_height);
 
 			/* Try 5-tap filter if 3-tap fclk is too high */
-			if (cpu_is_omap34xx() && height > out_height &&
+			if (cpu_is_omap34xx() && oi->height > oi->out_height &&
 					fclk > dispc_fclk_rate())
 				five_taps = true;
 		}
 
-		if (width > (2048 >> five_taps)) {
+		if (oi->width > (2048 >> five_taps)) {
 			DSSERR("failed to set up scaling, fclk too low\n");
 			return -EINVAL;
 		}
 
 		if (five_taps)
-			fclk = calc_fclk_five_taps(channel, width, height,
-					out_width, out_height, color_mode);
+			fclk = calc_fclk_five_taps(channel, oi->width,
+					oi->height, oi->out_width,
+					oi->out_height, oi->color_mode);
 
 		DSSDBG("required fclk rate = %lu Hz\n", fclk);
 		DSSDBG("current fclk rate = %lu Hz\n", dispc_fclk_rate());
@@ -1787,64 +1777,65 @@ int dispc_ovl_setup(enum omap_plane plane,
 		 * so the integer part must be added to the base address of the
 		 * bottom field.
 		 */
-		if (!height || height == out_height)
+		if (!oi->height || oi->height == oi->out_height)
 			field_offset = 0;
 		else
-			field_offset = height / out_height / 2;
+			field_offset = oi->height / oi->out_height / 2;
 	}
 
 	/* Fields are independent but interleaved in memory. */
 	if (fieldmode)
 		field_offset = 1;
 
-	if (rotation_type == OMAP_DSS_ROT_DMA)
-		calc_dma_rotation_offset(rotation, mirror,
-				screen_width, width, frame_height, color_mode,
-				fieldmode, field_offset,
+	if (oi->rotation_type == OMAP_DSS_ROT_DMA)
+		calc_dma_rotation_offset(oi->rotation, oi->mirror,
+				oi->screen_width, oi->width, frame_height,
+				oi->color_mode, fieldmode, field_offset,
 				&offset0, &offset1, &row_inc, &pix_inc);
 	else
-		calc_vrfb_rotation_offset(rotation, mirror,
-				screen_width, width, frame_height, color_mode,
-				fieldmode, field_offset,
+		calc_vrfb_rotation_offset(oi->rotation, oi->mirror,
+				oi->screen_width, oi->width, frame_height,
+				oi->color_mode, fieldmode, field_offset,
 				&offset0, &offset1, &row_inc, &pix_inc);
 
 	DSSDBG("offset0 %u, offset1 %u, row_inc %d, pix_inc %d\n",
 			offset0, offset1, row_inc, pix_inc);
 
-	dispc_ovl_set_color_mode(plane, color_mode);
+	dispc_ovl_set_color_mode(plane, oi->color_mode);
 
-	dispc_ovl_set_ba0(plane, paddr + offset0);
-	dispc_ovl_set_ba1(plane, paddr + offset1);
+	dispc_ovl_set_ba0(plane, oi->paddr + offset0);
+	dispc_ovl_set_ba1(plane, oi->paddr + offset1);
 
-	if (OMAP_DSS_COLOR_NV12 == color_mode) {
-		dispc_ovl_set_ba0_uv(plane, puv_addr + offset0);
-		dispc_ovl_set_ba1_uv(plane, puv_addr + offset1);
+	if (OMAP_DSS_COLOR_NV12 == oi->color_mode) {
+		dispc_ovl_set_ba0_uv(plane, oi->p_uv_addr + offset0);
+		dispc_ovl_set_ba1_uv(plane, oi->p_uv_addr + offset1);
 	}
 
 
 	dispc_ovl_set_row_inc(plane, row_inc);
 	dispc_ovl_set_pix_inc(plane, pix_inc);
 
-	DSSDBG("%d,%d %dx%d -> %dx%d\n", pos_x, pos_y, width, height,
-			out_width, out_height);
+	DSSDBG("%d,%d %dx%d -> %dx%d\n", oi->pos_x, oi->pos_y, oi->width,
+			oi->height, oi->out_width, oi->out_height);
 
-	dispc_ovl_set_pos(plane, pos_x, pos_y);
+	dispc_ovl_set_pos(plane, oi->pos_x, oi->pos_y);
 
-	dispc_ovl_set_pic_size(plane, width, height);
+	dispc_ovl_set_pic_size(plane, oi->width, oi->height);
 
 	if (plane != OMAP_DSS_GFX) {
-		dispc_ovl_set_scaling(plane, width, height,
-				   out_width, out_height,
+		dispc_ovl_set_scaling(plane, oi->width, oi->height,
+				   oi->out_width, oi->out_height,
 				   ilace, five_taps, fieldmode,
-				   color_mode, rotation);
-		dispc_ovl_set_vid_size(plane, out_width, out_height);
+				   oi->color_mode, oi->rotation);
+		dispc_ovl_set_vid_size(plane, oi->out_width, oi->out_height);
 		dispc_ovl_set_vid_color_conv(plane, cconv);
 	}
 
-	dispc_ovl_set_rotation_attrs(plane, rotation, mirror, color_mode);
+	dispc_ovl_set_rotation_attrs(plane, oi->rotation, oi->mirror,
+			oi->color_mode);
 
-	dispc_ovl_set_pre_mult_alpha(plane, pre_mult_alpha);
-	dispc_ovl_setup_global_alpha(plane, global_alpha);
+	dispc_ovl_set_pre_mult_alpha(plane, oi->pre_mult_alpha);
+	dispc_ovl_setup_global_alpha(plane, oi->global_alpha);
 
 	dispc_ovl_set_channel_out(plane, channel);
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index f58c302..bcc9c4e 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -402,18 +402,8 @@ int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
 u32 dispc_ovl_get_fifo_size(enum omap_plane plane);
 void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
 u32 dispc_ovl_get_burst_size(enum omap_plane plane);
-int dispc_ovl_setup(enum omap_plane plane,
-		      u32 paddr, u16 screen_width,
-		      u16 pos_x, u16 pos_y,
-		      u16 width, u16 height,
-		      u16 out_width, u16 out_height,
-		      enum omap_color_mode color_mode,
-		      bool ilace,
-		      enum omap_dss_rotation_type rotation_type,
-		      u8 rotation, bool mirror,
-		      u8 global_alpha, u8 pre_mult_alpha,
-		      enum omap_channel channel,
-		      u32 puv_addr);
+int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
+		bool ilace, enum omap_channel channel);
 int dispc_ovl_enable(enum omap_plane plane, bool enable);
 void dispc_ovl_enable_replication(enum omap_plane plane, bool enable);
 
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 5d28ef6..f1c334c 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -809,7 +809,7 @@ static int configure_overlay(enum omap_plane plane)
 {
 	struct overlay_cache_data *c;
 	struct manager_cache_data *mc;
-	struct omap_overlay_info *oi;
+	struct omap_overlay_info *oi, new_oi;
 	struct omap_overlay_manager_info *mi;
 	u16 outw, outh;
 	u16 x, y, w, h;
@@ -929,22 +929,18 @@ static int configure_overlay(enum omap_plane plane)
 		}
 	}
 
-	r = dispc_ovl_setup(plane,
-			paddr,
-			oi->screen_width,
-			x, y,
-			w, h,
-			outw, outh,
-			oi->color_mode,
-			c->ilace,
-			oi->rotation_type,
-			oi->rotation,
-			oi->mirror,
-			oi->global_alpha,
-			oi->pre_mult_alpha,
-			c->channel,
-			oi->p_uv_addr);
+	new_oi = *oi;
+
+	/* update new_oi members which could have been possibly updated */
+	new_oi.pos_x = x;
+	new_oi.pos_y = y;
+	new_oi.width = w;
+	new_oi.height = h;
+	new_oi.out_width = outw;
+	new_oi.out_height = outh;
+	new_oi.paddr = paddr;
 
+	r = dispc_ovl_setup(plane, &new_oi, c->ilace, c->channel);
 	if (r) {
 		/* this shouldn't happen */
 		DSSERR("dispc_ovl_setup failed for ovl %d\n", plane);
-- 
1.7.1

