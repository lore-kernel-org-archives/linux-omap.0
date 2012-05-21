From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 6/8] OMAPDSS: DISPC: Support rotation through TILER
Date: Mon, 21 May 2012 12:28:04 +0300
Message-ID: <1337592486-13040-7-git-send-email-tomi.valkeinen@ti.com>
References: <1337592486-13040-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:42760 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932508Ab2EUJ2g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 05:28:36 -0400
Received: by lbbgo11 with SMTP id go11so3142378lbb.3
        for <linux-omap@vger.kernel.org>; Mon, 21 May 2012 02:28:31 -0700 (PDT)
In-Reply-To: <1337592486-13040-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: archit@ti.com, Chandrabhanu Mahapatra <cmahapatra@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Chandrabhanu Mahapatra <cmahapatra@ti.com>

TILER is a block in OMAP4's DMM which lets DSS fetch frames in a rotated manner.
Physical memory can be mapped to a portion of OMAP's system address space called
TILER address space. The TILER address space is split into 8 views. Each view
represents a rotated or mirrored form of the mapped physical memory. When a
DISPC overlay's base address is programmed to one of these views, the TILER
fetches the pixels according to the orientation of the view. A view is further
split into 4 containers, each container holds elements of a particular size.
Rotation can be achieved at the granularity of elements in the container. For
more information on TILER, refer to the Memory Subsytem section in OMAP4 TRM.
Rotation type TILER has been added which is used to exploit the capabilities of
these 8 views for performing various rotations.

When fetching from addresses mapped to TILER space, the DISPC DMA can fetch
pixels in either 1D or 2D bursts. The fetch depends on which TILER container we
are accessing. Accessing 8, 16 and 32 bit sized containers requires 2D bursts,
and page mode sized containers require 1D bursts.

The DSS2 user is expected to provide the Tiler address of the view that it is
interested in. This is passed to the paddr and p_uv_addr parameters in
omap_overlay_info. It is also expected to provide the stride value based on the
view's orientation and container type, this should be passed to the screen_width
parameter of omap_overlay_info. In calc_tiler_rotation_offset screen_width is
used to calculate the required row_inc for DISPC. x_predecim and y_predecim are
also used to calculate row_inc and pix_inc thereby adding predecimation support
for TILER.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |   60 +++++++++++++++++++++++++++++++-
 drivers/video/omap2/dss/dss_features.c |   16 +++++++++
 drivers/video/omap2/dss/dss_features.h |    3 ++
 drivers/video/omap2/dss/overlay.c      |    6 ++++
 include/video/omapdss.h                |    5 +--
 5 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 3d0576d..9626b2c 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -785,6 +785,18 @@ static void dispc_ovl_set_color_mode(enum omap_plane plane,
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), m, 4, 1);
 }
 
+static void dispc_ovl_configure_burst_type(enum omap_plane plane,
+		enum omap_dss_rotation_type rotation_type)
+{
+	if (dss_has_feature(FEAT_BURST_2D) == 0)
+		return;
+
+	if (rotation_type == OMAP_DSS_ROT_TILER)
+		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), 1, 29, 29);
+	else
+		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), 0, 29, 29);
+}
+
 void dispc_ovl_set_channel_out(enum omap_plane plane, enum omap_channel channel)
 {
 	int shift;
@@ -1731,6 +1743,45 @@ static void calc_dma_rotation_offset(u8 rotation, bool mirror,
 	}
 }
 
+static void calc_tiler_rotation_offset(u16 screen_width, u16 width,
+		enum omap_color_mode color_mode, bool fieldmode,
+		unsigned int field_offset, unsigned *offset0, unsigned *offset1,
+		s32 *row_inc, s32 *pix_inc, int x_predecim, int y_predecim)
+{
+	u8 ps;
+
+	switch (color_mode) {
+	case OMAP_DSS_COLOR_CLUT1:
+	case OMAP_DSS_COLOR_CLUT2:
+	case OMAP_DSS_COLOR_CLUT4:
+	case OMAP_DSS_COLOR_CLUT8:
+		BUG();
+		return;
+	default:
+		ps = color_mode_to_bpp(color_mode) / 8;
+		break;
+	}
+
+	DSSDBG("scrw %d, width %d\n", screen_width, width);
+
+	/*
+	 * field 0 = even field = bottom field
+	 * field 1 = odd field = top field
+	 */
+	*offset1 = 0;
+	if (field_offset)
+		*offset0 = *offset1 + field_offset * screen_width * ps;
+	else
+		*offset0 = *offset1;
+	*row_inc = pixinc(1 + (y_predecim * screen_width - width * x_predecim) +
+			(fieldmode ? screen_width : 0), ps);
+	if (color_mode == OMAP_DSS_COLOR_YUV2 ||
+		color_mode == OMAP_DSS_COLOR_UYVY)
+		*pix_inc = pixinc(x_predecim, 2 * ps);
+	else
+		*pix_inc = pixinc(x_predecim, ps);
+}
+
 /*
  * This function is used to avoid synclosts in OMAP3, because of some
  * undocumented horizontal position and timing related limitations.
@@ -2122,7 +2173,12 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	row_inc = 0;
 	pix_inc = 0;
 
-	if (oi->rotation_type == OMAP_DSS_ROT_DMA)
+	if (oi->rotation_type == OMAP_DSS_ROT_TILER)
+		calc_tiler_rotation_offset(oi->screen_width, in_width,
+				oi->color_mode, fieldmode, field_offset,
+				&offset0, &offset1, &row_inc, &pix_inc,
+				x_predecim, y_predecim);
+	else if (oi->rotation_type == OMAP_DSS_ROT_DMA)
 		calc_dma_rotation_offset(oi->rotation, oi->mirror,
 				oi->screen_width, in_width, frame_height,
 				oi->color_mode, fieldmode, field_offset,
@@ -2140,6 +2196,8 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 
 	dispc_ovl_set_color_mode(plane, oi->color_mode);
 
+	dispc_ovl_configure_burst_type(plane, oi->rotation_type);
+
 	dispc_ovl_set_ba0(plane, oi->paddr + offset0);
 	dispc_ovl_set_ba1(plane, oi->paddr + offset1);
 
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 2627441..9387097 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -52,6 +52,8 @@ struct omap_dss_features {
 	const char * const *clksrc_names;
 	const struct dss_param_range *dss_params;
 
+	const enum omap_dss_rotation_type supported_rotation_types;
+
 	const u32 buffer_size_unit;
 	const u32 burst_size_unit;
 };
@@ -405,6 +407,7 @@ static const enum dss_feat_id omap4430_es1_0_dss_feat_list[] = {
 	FEAT_FIR_COEF_V,
 	FEAT_ALPHA_FREE_ZORDER,
 	FEAT_FIFO_MERGE,
+	FEAT_BURST_2D,
 };
 
 static const enum dss_feat_id omap4430_es2_0_1_2_dss_feat_list[] = {
@@ -422,6 +425,7 @@ static const enum dss_feat_id omap4430_es2_0_1_2_dss_feat_list[] = {
 	FEAT_FIR_COEF_V,
 	FEAT_ALPHA_FREE_ZORDER,
 	FEAT_FIFO_MERGE,
+	FEAT_BURST_2D,
 };
 
 static const enum dss_feat_id omap4_dss_feat_list[] = {
@@ -440,6 +444,7 @@ static const enum dss_feat_id omap4_dss_feat_list[] = {
 	FEAT_FIR_COEF_V,
 	FEAT_ALPHA_FREE_ZORDER,
 	FEAT_FIFO_MERGE,
+	FEAT_BURST_2D,
 };
 
 /* OMAP2 DSS Features */
@@ -457,6 +462,7 @@ static const struct omap_dss_features omap2_dss_features = {
 	.overlay_caps = omap2_dss_overlay_caps,
 	.clksrc_names = omap2_dss_clk_source_names,
 	.dss_params = omap2_dss_param_range,
+	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_VRFB,
 	.buffer_size_unit = 1,
 	.burst_size_unit = 8,
 };
@@ -476,6 +482,7 @@ static const struct omap_dss_features omap3430_dss_features = {
 	.overlay_caps = omap3430_dss_overlay_caps,
 	.clksrc_names = omap3_dss_clk_source_names,
 	.dss_params = omap3_dss_param_range,
+	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_VRFB,
 	.buffer_size_unit = 1,
 	.burst_size_unit = 8,
 };
@@ -494,6 +501,7 @@ static const struct omap_dss_features omap3630_dss_features = {
 	.overlay_caps = omap3630_dss_overlay_caps,
 	.clksrc_names = omap3_dss_clk_source_names,
 	.dss_params = omap3_dss_param_range,
+	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_VRFB,
 	.buffer_size_unit = 1,
 	.burst_size_unit = 8,
 };
@@ -514,6 +522,7 @@ static const struct omap_dss_features omap4430_es1_0_dss_features  = {
 	.overlay_caps = omap4_dss_overlay_caps,
 	.clksrc_names = omap4_dss_clk_source_names,
 	.dss_params = omap4_dss_param_range,
+	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_TILER,
 	.buffer_size_unit = 16,
 	.burst_size_unit = 16,
 };
@@ -533,6 +542,7 @@ static const struct omap_dss_features omap4430_es2_0_1_2_dss_features = {
 	.overlay_caps = omap4_dss_overlay_caps,
 	.clksrc_names = omap4_dss_clk_source_names,
 	.dss_params = omap4_dss_param_range,
+	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_TILER,
 	.buffer_size_unit = 16,
 	.burst_size_unit = 16,
 };
@@ -552,6 +562,7 @@ static const struct omap_dss_features omap4_dss_features = {
 	.overlay_caps = omap4_dss_overlay_caps,
 	.clksrc_names = omap4_dss_clk_source_names,
 	.dss_params = omap4_dss_param_range,
+	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_TILER,
 	.buffer_size_unit = 16,
 	.burst_size_unit = 16,
 };
@@ -672,6 +683,11 @@ void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end)
 	*end = omap_current_dss_features->reg_fields[id].end;
 }
 
+bool dss_feat_rotation_type_supported(enum omap_dss_rotation_type rot_type)
+{
+	return omap_current_dss_features->supported_rotation_types & rot_type;
+}
+
 void dss_features_init(void)
 {
 	if (cpu_is_omap24xx())
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 3736367..bdf469f 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -62,6 +62,7 @@ enum dss_feat_id {
 	FEAT_FIFO_MERGE,
 	/* An unknown HW bug causing the normal FIFO thresholds not to work */
 	FEAT_OMAP3_DSI_FIFO_BUG,
+	FEAT_BURST_2D,
 };
 
 /* DSS register field id */
@@ -110,6 +111,8 @@ const char *dss_feat_get_clk_source_name(enum omap_dss_clk_source id);
 u32 dss_feat_get_buffer_size_unit(void);	/* in bytes */
 u32 dss_feat_get_burst_size_unit(void);		/* in bytes */
 
+bool dss_feat_rotation_type_supported(enum omap_dss_rotation_type rot_type);
+
 bool dss_has_feature(enum dss_feat_id id);
 void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end);
 void dss_features_init(void);
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 0da5eb6..b0ba60f 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -628,6 +628,12 @@ int dss_ovl_simple_check(struct omap_overlay *ovl,
 		return -EINVAL;
 	}
 
+	if (dss_feat_rotation_type_supported(info->rotation_type) == 0) {
+		DSSERR("check_overlay: rotation type %d not supported\n",
+				info->rotation_type);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index bb30242..c8e59b4 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -175,8 +175,9 @@ enum omap_dss_overlay_managers {
 };
 
 enum omap_dss_rotation_type {
-	OMAP_DSS_ROT_DMA = 0,
-	OMAP_DSS_ROT_VRFB = 1,
+	OMAP_DSS_ROT_DMA	= 1 << 0,
+	OMAP_DSS_ROT_VRFB	= 1 << 1,
+	OMAP_DSS_ROT_TILER	= 1 << 2,
 };
 
 /* clockwise rotation angle */
-- 
1.7.9.5

