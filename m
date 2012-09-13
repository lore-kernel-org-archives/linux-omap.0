From: Archit Taneja <archit@ti.com>
Subject: [PATCH 02/21] OMAPDSS: DISPC: Rename scalar related functions from dispc_ovl_* to dispc_plane_*
Date: Thu, 13 Sep 2012 17:44:46 +0530
Message-ID: <1347538505-25359-3-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39469 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757860Ab2IMMPJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 08:15:09 -0400
In-Reply-To: <1347538505-25359-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Writeback pipeline has an identical scalar block as in video pipelines. Rename
the scalar related function from dispc_ovl_* to dispc_plane_*. The actual
registers are kept as DISPC_OVL_* only to prevent too much change.

All functions which are common to overlays and writeback are to be named as
dispc_plane_*, functions which are specific to overlays are to be named as
dispc_ovl_*, and writeback as dispc_wb_*.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c       |   92 ++++++++++++++++++---------------
 drivers/video/omap2/dss/dispc.h       |    2 +-
 drivers/video/omap2/dss/dispc_coefs.c |    2 +-
 3 files changed, 51 insertions(+), 45 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index cd3d532..eae9da4 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -560,29 +560,33 @@ void dispc_mgr_go(enum omap_channel channel)
 	mgr_fld_write(channel, DISPC_MGR_FLD_GO, 1);
 }
 
-static void dispc_ovl_write_firh_reg(enum omap_plane plane, int reg, u32 value)
+static void dispc_plane_write_firh_reg(enum omap_plane plane, int reg,
+		u32 value)
 {
 	dispc_write_reg(DISPC_OVL_FIR_COEF_H(plane, reg), value);
 }
 
-static void dispc_ovl_write_firhv_reg(enum omap_plane plane, int reg, u32 value)
+static void dispc_plane_write_firhv_reg(enum omap_plane plane, int reg,
+		u32 value)
 {
 	dispc_write_reg(DISPC_OVL_FIR_COEF_HV(plane, reg), value);
 }
 
-static void dispc_ovl_write_firv_reg(enum omap_plane plane, int reg, u32 value)
+static void dispc_plane_write_firv_reg(enum omap_plane plane, int reg,
+		u32 value)
 {
 	dispc_write_reg(DISPC_OVL_FIR_COEF_V(plane, reg), value);
 }
 
-static void dispc_ovl_write_firh2_reg(enum omap_plane plane, int reg, u32 value)
+static void dispc_plane_write_firh2_reg(enum omap_plane plane, int reg,
+		u32 value)
 {
 	BUG_ON(plane == OMAP_DSS_GFX);
 
 	dispc_write_reg(DISPC_OVL_FIR_COEF_H2(plane, reg), value);
 }
 
-static void dispc_ovl_write_firhv2_reg(enum omap_plane plane, int reg,
+static void dispc_plane_write_firhv2_reg(enum omap_plane plane, int reg,
 		u32 value)
 {
 	BUG_ON(plane == OMAP_DSS_GFX);
@@ -590,22 +594,23 @@ static void dispc_ovl_write_firhv2_reg(enum omap_plane plane, int reg,
 	dispc_write_reg(DISPC_OVL_FIR_COEF_HV2(plane, reg), value);
 }
 
-static void dispc_ovl_write_firv2_reg(enum omap_plane plane, int reg, u32 value)
+static void dispc_plane_write_firv2_reg(enum omap_plane plane, int reg,
+		u32 value)
 {
 	BUG_ON(plane == OMAP_DSS_GFX);
 
 	dispc_write_reg(DISPC_OVL_FIR_COEF_V2(plane, reg), value);
 }
 
-static void dispc_ovl_set_scale_coef(enum omap_plane plane, int fir_hinc,
-				int fir_vinc, int five_taps,
-				enum omap_color_component color_comp)
+static void dispc_plane_set_scale_coef(enum omap_plane plane, int fir_hinc,
+		int fir_vinc, int five_taps,
+		enum omap_color_component color_comp)
 {
 	const struct dispc_coef *h_coef, *v_coef;
 	int i;
 
-	h_coef = dispc_ovl_get_scale_coef(fir_hinc, true);
-	v_coef = dispc_ovl_get_scale_coef(fir_vinc, five_taps);
+	h_coef = dispc_plane_get_scale_coef(fir_hinc, true);
+	v_coef = dispc_plane_get_scale_coef(fir_vinc, five_taps);
 
 	for (i = 0; i < 8; i++) {
 		u32 h, hv;
@@ -620,11 +625,11 @@ static void dispc_ovl_set_scale_coef(enum omap_plane plane, int fir_hinc,
 			| FLD_VAL(v_coef[i].hc3_vc2, 31, 24);
 
 		if (color_comp == DISPC_COLOR_COMPONENT_RGB_Y) {
-			dispc_ovl_write_firh_reg(plane, i, h);
-			dispc_ovl_write_firhv_reg(plane, i, hv);
+			dispc_plane_write_firh_reg(plane, i, h);
+			dispc_plane_write_firhv_reg(plane, i, hv);
 		} else {
-			dispc_ovl_write_firh2_reg(plane, i, h);
-			dispc_ovl_write_firhv2_reg(plane, i, hv);
+			dispc_plane_write_firh2_reg(plane, i, h);
+			dispc_plane_write_firhv2_reg(plane, i, hv);
 		}
 
 	}
@@ -635,9 +640,9 @@ static void dispc_ovl_set_scale_coef(enum omap_plane plane, int fir_hinc,
 			v = FLD_VAL(v_coef[i].hc0_vc00, 7, 0)
 				| FLD_VAL(v_coef[i].hc4_vc22, 15, 8);
 			if (color_comp == DISPC_COLOR_COMPONENT_RGB_Y)
-				dispc_ovl_write_firv_reg(plane, i, v);
+				dispc_plane_write_firv_reg(plane, i, v);
 			else
-				dispc_ovl_write_firv2_reg(plane, i, v);
+				dispc_plane_write_firv2_reg(plane, i, v);
 		}
 	}
 }
@@ -1208,9 +1213,8 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
 	}
 }
 
-static void dispc_ovl_set_fir(enum omap_plane plane,
-				int hinc, int vinc,
-				enum omap_color_component color_comp)
+static void dispc_plane_set_fir(enum omap_plane plane, int hinc, int vinc,
+		enum omap_color_component color_comp)
 {
 	u32 val;
 
@@ -1231,7 +1235,8 @@ static void dispc_ovl_set_fir(enum omap_plane plane,
 	}
 }
 
-static void dispc_ovl_set_vid_accu0(enum omap_plane plane, int haccu, int vaccu)
+static void dispc_plane_set_vid_accu0(enum omap_plane plane, int haccu,
+		int vaccu)
 {
 	u32 val;
 	u8 hor_start, hor_end, vert_start, vert_end;
@@ -1245,7 +1250,8 @@ static void dispc_ovl_set_vid_accu0(enum omap_plane plane, int haccu, int vaccu)
 	dispc_write_reg(DISPC_OVL_ACCU0(plane), val);
 }
 
-static void dispc_ovl_set_vid_accu1(enum omap_plane plane, int haccu, int vaccu)
+static void dispc_plane_set_vid_accu1(enum omap_plane plane, int haccu,
+		int vaccu)
 {
 	u32 val;
 	u8 hor_start, hor_end, vert_start, vert_end;
@@ -1259,7 +1265,7 @@ static void dispc_ovl_set_vid_accu1(enum omap_plane plane, int haccu, int vaccu)
 	dispc_write_reg(DISPC_OVL_ACCU1(plane), val);
 }
 
-static void dispc_ovl_set_vid_accu2_0(enum omap_plane plane, int haccu,
+static void dispc_plane_set_vid_accu2_0(enum omap_plane plane, int haccu,
 		int vaccu)
 {
 	u32 val;
@@ -1268,7 +1274,7 @@ static void dispc_ovl_set_vid_accu2_0(enum omap_plane plane, int haccu,
 	dispc_write_reg(DISPC_OVL_ACCU2_0(plane), val);
 }
 
-static void dispc_ovl_set_vid_accu2_1(enum omap_plane plane, int haccu,
+static void dispc_plane_set_vid_accu2_1(enum omap_plane plane, int haccu,
 		int vaccu)
 {
 	u32 val;
@@ -1277,7 +1283,7 @@ static void dispc_ovl_set_vid_accu2_1(enum omap_plane plane, int haccu,
 	dispc_write_reg(DISPC_OVL_ACCU2_1(plane), val);
 }
 
-static void dispc_ovl_set_scale_param(enum omap_plane plane,
+static void dispc_plane_set_scale_param(enum omap_plane plane,
 		u16 orig_width, u16 orig_height,
 		u16 out_width, u16 out_height,
 		bool five_taps, u8 rotation,
@@ -1288,12 +1294,12 @@ static void dispc_ovl_set_scale_param(enum omap_plane plane,
 	fir_hinc = 1024 * orig_width / out_width;
 	fir_vinc = 1024 * orig_height / out_height;
 
-	dispc_ovl_set_scale_coef(plane, fir_hinc, fir_vinc, five_taps,
+	dispc_plane_set_scale_coef(plane, fir_hinc, fir_vinc, five_taps,
 				color_comp);
-	dispc_ovl_set_fir(plane, fir_hinc, fir_vinc, color_comp);
+	dispc_plane_set_fir(plane, fir_hinc, fir_vinc, color_comp);
 }
 
-static void dispc_ovl_set_accu_uv(enum omap_plane plane,
+static void dispc_plane_set_accu_uv(enum omap_plane plane,
 		u16 orig_width,	u16 orig_height, u16 out_width, u16 out_height,
 		bool ilace, enum omap_color_mode color_mode, u8 rotation)
 {
@@ -1377,11 +1383,11 @@ static void dispc_ovl_set_accu_uv(enum omap_plane plane,
 	v_accu2_0 = (accu_val->v0_m * chroma_vinc / accu_val->v0_n) % 1024;
 	v_accu2_1 = (accu_val->v1_m * chroma_vinc / accu_val->v1_n) % 1024;
 
-	dispc_ovl_set_vid_accu2_0(plane, h_accu2_0, v_accu2_0);
-	dispc_ovl_set_vid_accu2_1(plane, h_accu2_1, v_accu2_1);
+	dispc_plane_set_vid_accu2_0(plane, h_accu2_0, v_accu2_0);
+	dispc_plane_set_vid_accu2_1(plane, h_accu2_1, v_accu2_1);
 }
 
-static void dispc_ovl_set_scaling_common(enum omap_plane plane,
+static void dispc_plane_set_scaling_common(enum omap_plane plane,
 		u16 orig_width, u16 orig_height,
 		u16 out_width, u16 out_height,
 		bool ilace, bool five_taps,
@@ -1392,7 +1398,7 @@ static void dispc_ovl_set_scaling_common(enum omap_plane plane,
 	int accu1 = 0;
 	u32 l;
 
-	dispc_ovl_set_scale_param(plane, orig_width, orig_height,
+	dispc_plane_set_scale_param(plane, orig_width, orig_height,
 				out_width, out_height, five_taps,
 				rotation, DISPC_COLOR_COMPONENT_RGB_Y);
 	l = dispc_read_reg(DISPC_OVL_ATTRIBUTES(plane));
@@ -1431,11 +1437,11 @@ static void dispc_ovl_set_scaling_common(enum omap_plane plane,
 		}
 	}
 
-	dispc_ovl_set_vid_accu0(plane, 0, accu0);
-	dispc_ovl_set_vid_accu1(plane, 0, accu1);
+	dispc_plane_set_vid_accu0(plane, 0, accu0);
+	dispc_plane_set_vid_accu1(plane, 0, accu1);
 }
 
-static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
+static void dispc_plane_set_scaling_uv(enum omap_plane plane,
 		u16 orig_width, u16 orig_height,
 		u16 out_width, u16 out_height,
 		bool ilace, bool five_taps,
@@ -1455,7 +1461,7 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 		return;
 	}
 
-	dispc_ovl_set_accu_uv(plane, orig_width, orig_height, out_width,
+	dispc_plane_set_accu_uv(plane, orig_width, orig_height, out_width,
 			out_height, ilace, color_mode, rotation);
 
 	switch (color_mode) {
@@ -1488,7 +1494,7 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 	if (out_height != orig_height)
 		scale_y = true;
 
-	dispc_ovl_set_scale_param(plane, orig_width, orig_height,
+	dispc_plane_set_scale_param(plane, orig_width, orig_height,
 			out_width, out_height, five_taps,
 				rotation, DISPC_COLOR_COMPONENT_UV);
 
@@ -1500,7 +1506,7 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), scale_y ? 1 : 0, 6, 6);
 }
 
-static void dispc_ovl_set_scaling(enum omap_plane plane,
+static void dispc_plane_set_scaling(enum omap_plane plane,
 		u16 orig_width, u16 orig_height,
 		u16 out_width, u16 out_height,
 		bool ilace, bool five_taps,
@@ -1509,14 +1515,14 @@ static void dispc_ovl_set_scaling(enum omap_plane plane,
 {
 	BUG_ON(plane == OMAP_DSS_GFX);
 
-	dispc_ovl_set_scaling_common(plane,
+	dispc_plane_set_scaling_common(plane,
 			orig_width, orig_height,
 			out_width, out_height,
 			ilace, five_taps,
 			fieldmode, color_mode,
 			rotation);
 
-	dispc_ovl_set_scaling_uv(plane,
+	dispc_plane_set_scaling_uv(plane,
 		orig_width, orig_height,
 		out_width, out_height,
 		ilace, five_taps,
@@ -2190,7 +2196,7 @@ static int dispc_ovl_calc_scaling_44xx(enum omap_channel channel,
 	return 0;
 }
 
-static int dispc_ovl_calc_scaling(enum omap_plane plane,
+static int dispc_plane_calc_scaling(enum omap_plane plane,
 		enum omap_channel channel,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
@@ -2305,7 +2311,7 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 	if (!dss_feat_color_mode_supported(plane, oi->color_mode))
 		return -EINVAL;
 
-	r = dispc_ovl_calc_scaling(plane, channel, mgr_timings, in_width,
+	r = dispc_plane_calc_scaling(plane, channel, mgr_timings, in_width,
 			in_height, out_width, out_height, oi->color_mode,
 			&five_taps, &x_predecim, &y_predecim, oi->pos_x);
 	if (r)
@@ -2387,7 +2393,7 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 	dispc_ovl_set_pic_size(plane, in_width, in_height);
 
 	if (ovl->caps & OMAP_DSS_OVL_CAP_SCALE) {
-		dispc_ovl_set_scaling(plane, in_width, in_height, out_width,
+		dispc_plane_set_scaling(plane, in_width, in_height, out_width,
 				   out_height, ilace, five_taps, fieldmode,
 				   oi->color_mode, oi->rotation);
 		dispc_ovl_set_vid_size(plane, out_width, out_height);
diff --git a/drivers/video/omap2/dss/dispc.h b/drivers/video/omap2/dss/dispc.h
index 42e56cc..84cc472 100644
--- a/drivers/video/omap2/dss/dispc.h
+++ b/drivers/video/omap2/dss/dispc.h
@@ -109,7 +109,7 @@ struct dispc_coef {
 	s8 hc0_vc00;
 };
 
-const struct dispc_coef *dispc_ovl_get_scale_coef(int inc, int five_taps);
+const struct dispc_coef *dispc_plane_get_scale_coef(int inc, int five_taps);
 
 /* DISPC manager/channel specific registers */
 static inline u16 DISPC_DEFAULT_COLOR(enum omap_channel channel)
diff --git a/drivers/video/omap2/dss/dispc_coefs.c b/drivers/video/omap2/dss/dispc_coefs.c
index 038c15b..21d8c82 100644
--- a/drivers/video/omap2/dss/dispc_coefs.c
+++ b/drivers/video/omap2/dss/dispc_coefs.c
@@ -286,7 +286,7 @@ static const struct dispc_coef coef5_M32[8] = {
 	{   5,  29,  48,  36,  10 },
 };
 
-const struct dispc_coef *dispc_ovl_get_scale_coef(int inc, int five_taps)
+const struct dispc_coef *dispc_plane_get_scale_coef(int inc, int five_taps)
 {
 	int i;
 	static const struct {
-- 
1.7.9.5

