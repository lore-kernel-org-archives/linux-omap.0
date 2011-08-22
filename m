From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/10] OMAP: DSS2: DISPC: rename overlay related funcs
Date: Mon, 22 Aug 2011 11:27:49 +0300
Message-ID: <1314001671-18123-9-git-send-email-tomi.valkeinen@ti.com>
References: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:48516 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756693Ab1HVI2X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:28:23 -0400
In-Reply-To: <1314001671-18123-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Rename dispc's overlay related functions as follows:

- Remove prepending underscores, which were originally used to inform
  that the clocks needs to be enabled. This meaning is no longer valid.
- Prepend the functions with dispc_ovl_*
- Remove "plane" from the name, e.g. dispc_set_plane_ba0 ->
  dispc_ovl_set_ba0

The idea is to group overlay related functions so that it can be deduced
from the function name that it writes to overlay spesific registers.

All dispc_ovl_* functions have enum omap_plane as the first parameter.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |  150 +++++++++++++++++++------------------
 drivers/video/omap2/dss/dss.h     |   14 ++--
 drivers/video/omap2/dss/manager.c |   18 ++--
 drivers/video/omap2/dss/overlay.c |    2 +-
 4 files changed, 94 insertions(+), 90 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 2cc6237..7ab3d58 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -480,43 +480,44 @@ void dispc_go(enum omap_channel channel)
 		REG_FLD_MOD(DISPC_CONTROL, 1, bit, bit);
 }
 
-static void _dispc_write_firh_reg(enum omap_plane plane, int reg, u32 value)
+static void dispc_ovl_write_firh_reg(enum omap_plane plane, int reg, u32 value)
 {
 	dispc_write_reg(DISPC_OVL_FIR_COEF_H(plane, reg), value);
 }
 
-static void _dispc_write_firhv_reg(enum omap_plane plane, int reg, u32 value)
+static void dispc_ovl_write_firhv_reg(enum omap_plane plane, int reg, u32 value)
 {
 	dispc_write_reg(DISPC_OVL_FIR_COEF_HV(plane, reg), value);
 }
 
-static void _dispc_write_firv_reg(enum omap_plane plane, int reg, u32 value)
+static void dispc_ovl_write_firv_reg(enum omap_plane plane, int reg, u32 value)
 {
 	dispc_write_reg(DISPC_OVL_FIR_COEF_V(plane, reg), value);
 }
 
-static void _dispc_write_firh2_reg(enum omap_plane plane, int reg, u32 value)
+static void dispc_ovl_write_firh2_reg(enum omap_plane plane, int reg, u32 value)
 {
 	BUG_ON(plane == OMAP_DSS_GFX);
 
 	dispc_write_reg(DISPC_OVL_FIR_COEF_H2(plane, reg), value);
 }
 
-static void _dispc_write_firhv2_reg(enum omap_plane plane, int reg, u32 value)
+static void dispc_ovl_write_firhv2_reg(enum omap_plane plane, int reg,
+		u32 value)
 {
 	BUG_ON(plane == OMAP_DSS_GFX);
 
 	dispc_write_reg(DISPC_OVL_FIR_COEF_HV2(plane, reg), value);
 }
 
-static void _dispc_write_firv2_reg(enum omap_plane plane, int reg, u32 value)
+static void dispc_ovl_write_firv2_reg(enum omap_plane plane, int reg, u32 value)
 {
 	BUG_ON(plane == OMAP_DSS_GFX);
 
 	dispc_write_reg(DISPC_OVL_FIR_COEF_V2(plane, reg), value);
 }
 
-static void _dispc_set_scale_coef(enum omap_plane plane, int hscaleup,
+static void dispc_ovl_set_scale_coef(enum omap_plane plane, int hscaleup,
 				  int vscaleup, int five_taps,
 				  enum omap_color_component color_comp)
 {
@@ -617,11 +618,11 @@ static void _dispc_set_scale_coef(enum omap_plane plane, int hscaleup,
 			| FLD_VAL(v_coef[i].vc2, 31, 24);
 
 		if (color_comp == DISPC_COLOR_COMPONENT_RGB_Y) {
-			_dispc_write_firh_reg(plane, i, h);
-			_dispc_write_firhv_reg(plane, i, hv);
+			dispc_ovl_write_firh_reg(plane, i, h);
+			dispc_ovl_write_firhv_reg(plane, i, hv);
 		} else {
-			_dispc_write_firh2_reg(plane, i, h);
-			_dispc_write_firhv2_reg(plane, i, hv);
+			dispc_ovl_write_firh2_reg(plane, i, h);
+			dispc_ovl_write_firhv2_reg(plane, i, hv);
 		}
 
 	}
@@ -632,9 +633,9 @@ static void _dispc_set_scale_coef(enum omap_plane plane, int hscaleup,
 			v = FLD_VAL(v_coef[i].vc00, 7, 0)
 				| FLD_VAL(v_coef[i].vc22, 15, 8);
 			if (color_comp == DISPC_COLOR_COMPONENT_RGB_Y)
-				_dispc_write_firv_reg(plane, i, v);
+				dispc_ovl_write_firv_reg(plane, i, v);
 			else
-				_dispc_write_firv2_reg(plane, i, v);
+				dispc_ovl_write_firv2_reg(plane, i, v);
 		}
 	}
 }
@@ -675,34 +676,34 @@ static void _dispc_setup_color_conv_coef(void)
 }
 
 
-static void _dispc_set_plane_ba0(enum omap_plane plane, u32 paddr)
+static void dispc_ovl_set_ba0(enum omap_plane plane, u32 paddr)
 {
 	dispc_write_reg(DISPC_OVL_BA0(plane), paddr);
 }
 
-static void _dispc_set_plane_ba1(enum omap_plane plane, u32 paddr)
+static void dispc_ovl_set_ba1(enum omap_plane plane, u32 paddr)
 {
 	dispc_write_reg(DISPC_OVL_BA1(plane), paddr);
 }
 
-static void _dispc_set_plane_ba0_uv(enum omap_plane plane, u32 paddr)
+static void dispc_ovl_set_ba0_uv(enum omap_plane plane, u32 paddr)
 {
 	dispc_write_reg(DISPC_OVL_BA0_UV(plane), paddr);
 }
 
-static void _dispc_set_plane_ba1_uv(enum omap_plane plane, u32 paddr)
+static void dispc_ovl_set_ba1_uv(enum omap_plane plane, u32 paddr)
 {
 	dispc_write_reg(DISPC_OVL_BA1_UV(plane), paddr);
 }
 
-static void _dispc_set_plane_pos(enum omap_plane plane, int x, int y)
+static void dispc_ovl_set_pos(enum omap_plane plane, int x, int y)
 {
 	u32 val = FLD_VAL(y, 26, 16) | FLD_VAL(x, 10, 0);
 
 	dispc_write_reg(DISPC_OVL_POSITION(plane), val);
 }
 
-static void _dispc_set_pic_size(enum omap_plane plane, int width, int height)
+static void dispc_ovl_set_pic_size(enum omap_plane plane, int width, int height)
 {
 	u32 val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
 
@@ -712,7 +713,7 @@ static void _dispc_set_pic_size(enum omap_plane plane, int width, int height)
 		dispc_write_reg(DISPC_OVL_PICTURE_SIZE(plane), val);
 }
 
-static void _dispc_set_vid_size(enum omap_plane plane, int width, int height)
+static void dispc_ovl_set_vid_size(enum omap_plane plane, int width, int height)
 {
 	u32 val;
 
@@ -723,7 +724,7 @@ static void _dispc_set_vid_size(enum omap_plane plane, int width, int height)
 	dispc_write_reg(DISPC_OVL_SIZE(plane), val);
 }
 
-static void _dispc_set_pre_mult_alpha(enum omap_plane plane, bool enable)
+static void dispc_ovl_set_pre_mult_alpha(enum omap_plane plane, bool enable)
 {
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
 
@@ -733,7 +734,7 @@ static void _dispc_set_pre_mult_alpha(enum omap_plane plane, bool enable)
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable ? 1 : 0, 28, 28);
 }
 
-static void _dispc_setup_global_alpha(enum omap_plane plane, u8 global_alpha)
+static void dispc_ovl_setup_global_alpha(enum omap_plane plane, u8 global_alpha)
 {
 	static const unsigned shifts[] = { 0, 8, 16, };
 	int shift;
@@ -746,17 +747,17 @@ static void _dispc_setup_global_alpha(enum omap_plane plane, u8 global_alpha)
 	REG_FLD_MOD(DISPC_GLOBAL_ALPHA, global_alpha, shift + 7, shift);
 }
 
-static void _dispc_set_pix_inc(enum omap_plane plane, s32 inc)
+static void dispc_ovl_set_pix_inc(enum omap_plane plane, s32 inc)
 {
 	dispc_write_reg(DISPC_OVL_PIXEL_INC(plane), inc);
 }
 
-static void _dispc_set_row_inc(enum omap_plane plane, s32 inc)
+static void dispc_ovl_set_row_inc(enum omap_plane plane, s32 inc)
 {
 	dispc_write_reg(DISPC_OVL_ROW_INC(plane), inc);
 }
 
-static void _dispc_set_color_mode(enum omap_plane plane,
+static void dispc_ovl_set_color_mode(enum omap_plane plane,
 		enum omap_color_mode color_mode)
 {
 	u32 m = 0;
@@ -837,7 +838,7 @@ static void _dispc_set_color_mode(enum omap_plane plane,
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), m, 4, 1);
 }
 
-void dispc_set_channel_out(enum omap_plane plane,
+void dispc_ovl_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel)
 {
 	int shift;
@@ -884,7 +885,7 @@ void dispc_set_channel_out(enum omap_plane plane,
 	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), val);
 }
 
-static void dispc_set_burst_size(enum omap_plane plane,
+static void dispc_ovl_set_burst_size(enum omap_plane plane,
 		enum omap_burst_size burst_size)
 {
 	static const unsigned shifts[] = { 6, 14, 14, };
@@ -901,10 +902,10 @@ static void dispc_configure_burst_sizes(void)
 
 	/* Configure burst size always to maximum size */
 	for (i = 0; i < omap_dss_get_num_overlays(); ++i)
-		dispc_set_burst_size(i, burst_size);
+		dispc_ovl_set_burst_size(i, burst_size);
 }
 
-u32 dispc_get_burst_size(enum omap_plane plane)
+u32 dispc_ovl_get_burst_size(enum omap_plane plane)
 {
 	unsigned unit = dss_feat_get_burst_size_unit();
 	/* burst multiplier is always x8 (see dispc_configure_burst_sizes()) */
@@ -959,7 +960,7 @@ void dispc_set_cpr_coef(enum omap_channel channel,
 	dispc_write_reg(DISPC_CPR_COEF_B(channel), coef_b);
 }
 
-static void _dispc_set_vid_color_conv(enum omap_plane plane, bool enable)
+static void dispc_ovl_set_vid_color_conv(enum omap_plane plane, bool enable)
 {
 	u32 val;
 
@@ -970,7 +971,7 @@ static void _dispc_set_vid_color_conv(enum omap_plane plane, bool enable)
 	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), val);
 }
 
-void dispc_enable_replication(enum omap_plane plane, bool enable)
+void dispc_ovl_enable_replication(enum omap_plane plane, bool enable)
 {
 	static const unsigned shifts[] = { 5, 10, 10 };
 	int shift;
@@ -1013,12 +1014,12 @@ static void dispc_read_plane_fifo_sizes(void)
 	}
 }
 
-u32 dispc_get_plane_fifo_size(enum omap_plane plane)
+u32 dispc_ovl_get_fifo_size(enum omap_plane plane)
 {
 	return dispc.fifo_size[plane];
 }
 
-void dispc_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
+void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
 {
 	u8 hi_start, hi_end, lo_start, lo_end;
 	u32 unit;
@@ -1053,7 +1054,7 @@ void dispc_enable_fifomerge(bool enable)
 	REG_FLD_MOD(DISPC_CONFIG, enable ? 1 : 0, 14, 14);
 }
 
-static void _dispc_set_fir(enum omap_plane plane,
+static void dispc_ovl_set_fir(enum omap_plane plane,
 				int hinc, int vinc,
 				enum omap_color_component color_comp)
 {
@@ -1076,7 +1077,7 @@ static void _dispc_set_fir(enum omap_plane plane,
 	}
 }
 
-static void _dispc_set_vid_accu0(enum omap_plane plane, int haccu, int vaccu)
+static void dispc_ovl_set_vid_accu0(enum omap_plane plane, int haccu, int vaccu)
 {
 	u32 val;
 	u8 hor_start, hor_end, vert_start, vert_end;
@@ -1090,7 +1091,7 @@ static void _dispc_set_vid_accu0(enum omap_plane plane, int haccu, int vaccu)
 	dispc_write_reg(DISPC_OVL_ACCU0(plane), val);
 }
 
-static void _dispc_set_vid_accu1(enum omap_plane plane, int haccu, int vaccu)
+static void dispc_ovl_set_vid_accu1(enum omap_plane plane, int haccu, int vaccu)
 {
 	u32 val;
 	u8 hor_start, hor_end, vert_start, vert_end;
@@ -1104,7 +1105,8 @@ static void _dispc_set_vid_accu1(enum omap_plane plane, int haccu, int vaccu)
 	dispc_write_reg(DISPC_OVL_ACCU1(plane), val);
 }
 
-static void _dispc_set_vid_accu2_0(enum omap_plane plane, int haccu, int vaccu)
+static void dispc_ovl_set_vid_accu2_0(enum omap_plane plane, int haccu,
+		int vaccu)
 {
 	u32 val;
 
@@ -1112,7 +1114,8 @@ static void _dispc_set_vid_accu2_0(enum omap_plane plane, int haccu, int vaccu)
 	dispc_write_reg(DISPC_OVL_ACCU2_0(plane), val);
 }
 
-static void _dispc_set_vid_accu2_1(enum omap_plane plane, int haccu, int vaccu)
+static void dispc_ovl_set_vid_accu2_1(enum omap_plane plane, int haccu,
+		int vaccu)
 {
 	u32 val;
 
@@ -1120,7 +1123,7 @@ static void _dispc_set_vid_accu2_1(enum omap_plane plane, int haccu, int vaccu)
 	dispc_write_reg(DISPC_OVL_ACCU2_1(plane), val);
 }
 
-static void _dispc_set_scale_param(enum omap_plane plane,
+static void dispc_ovl_set_scale_param(enum omap_plane plane,
 		u16 orig_width, u16 orig_height,
 		u16 out_width, u16 out_height,
 		bool five_taps, u8 rotation,
@@ -1132,15 +1135,16 @@ static void _dispc_set_scale_param(enum omap_plane plane,
 	hscaleup = orig_width <= out_width;
 	vscaleup = orig_height <= out_height;
 
-	_dispc_set_scale_coef(plane, hscaleup, vscaleup, five_taps, color_comp);
+	dispc_ovl_set_scale_coef(plane, hscaleup, vscaleup, five_taps,
+			color_comp);
 
 	fir_hinc = 1024 * orig_width / out_width;
 	fir_vinc = 1024 * orig_height / out_height;
 
-	_dispc_set_fir(plane, fir_hinc, fir_vinc, color_comp);
+	dispc_ovl_set_fir(plane, fir_hinc, fir_vinc, color_comp);
 }
 
-static void _dispc_set_scaling_common(enum omap_plane plane,
+static void dispc_ovl_set_scaling_common(enum omap_plane plane,
 		u16 orig_width, u16 orig_height,
 		u16 out_width, u16 out_height,
 		bool ilace, bool five_taps,
@@ -1151,7 +1155,7 @@ static void _dispc_set_scaling_common(enum omap_plane plane,
 	int accu1 = 0;
 	u32 l;
 
-	_dispc_set_scale_param(plane, orig_width, orig_height,
+	dispc_ovl_set_scale_param(plane, orig_width, orig_height,
 				out_width, out_height, five_taps,
 				rotation, DISPC_COLOR_COMPONENT_RGB_Y);
 	l = dispc_read_reg(DISPC_OVL_ATTRIBUTES(plane));
@@ -1190,11 +1194,11 @@ static void _dispc_set_scaling_common(enum omap_plane plane,
 		}
 	}
 
-	_dispc_set_vid_accu0(plane, 0, accu0);
-	_dispc_set_vid_accu1(plane, 0, accu1);
+	dispc_ovl_set_vid_accu0(plane, 0, accu0);
+	dispc_ovl_set_vid_accu1(plane, 0, accu1);
 }
 
-static void _dispc_set_scaling_uv(enum omap_plane plane,
+static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 		u16 orig_width, u16 orig_height,
 		u16 out_width, u16 out_height,
 		bool ilace, bool five_taps,
@@ -1242,7 +1246,7 @@ static void _dispc_set_scaling_uv(enum omap_plane plane,
 	if (out_height != orig_height)
 		scale_y = true;
 
-	_dispc_set_scale_param(plane, orig_width, orig_height,
+	dispc_ovl_set_scale_param(plane, orig_width, orig_height,
 			out_width, out_height, five_taps,
 				rotation, DISPC_COLOR_COMPONENT_UV);
 
@@ -1253,11 +1257,11 @@ static void _dispc_set_scaling_uv(enum omap_plane plane,
 	/* set V scaling */
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), scale_y ? 1 : 0, 6, 6);
 
-	_dispc_set_vid_accu2_0(plane, 0x80, 0);
-	_dispc_set_vid_accu2_1(plane, 0x80, 0);
+	dispc_ovl_set_vid_accu2_0(plane, 0x80, 0);
+	dispc_ovl_set_vid_accu2_1(plane, 0x80, 0);
 }
 
-static void _dispc_set_scaling(enum omap_plane plane,
+static void dispc_ovl_set_scaling(enum omap_plane plane,
 		u16 orig_width, u16 orig_height,
 		u16 out_width, u16 out_height,
 		bool ilace, bool five_taps,
@@ -1266,14 +1270,14 @@ static void _dispc_set_scaling(enum omap_plane plane,
 {
 	BUG_ON(plane == OMAP_DSS_GFX);
 
-	_dispc_set_scaling_common(plane,
+	dispc_ovl_set_scaling_common(plane,
 			orig_width, orig_height,
 			out_width, out_height,
 			ilace, five_taps,
 			fieldmode, color_mode,
 			rotation);
 
-	_dispc_set_scaling_uv(plane,
+	dispc_ovl_set_scaling_uv(plane,
 		orig_width, orig_height,
 		out_width, out_height,
 		ilace, five_taps,
@@ -1281,7 +1285,7 @@ static void _dispc_set_scaling(enum omap_plane plane,
 		rotation);
 }
 
-static void _dispc_set_rotation_attrs(enum omap_plane plane, u8 rotation,
+static void dispc_ovl_set_rotation_attrs(enum omap_plane plane, u8 rotation,
 		bool mirroring, enum omap_color_mode color_mode)
 {
 	bool row_repeat = false;
@@ -1670,7 +1674,7 @@ static unsigned long calc_fclk(enum omap_channel channel, u16 width,
 	return dispc_pclk_rate(channel) * vf * hf;
 }
 
-int dispc_setup_plane(enum omap_plane plane,
+int dispc_ovl_setup(enum omap_plane plane,
 		u32 paddr, u16 screen_width,
 		u16 pos_x, u16 pos_y,
 		u16 width, u16 height,
@@ -1692,7 +1696,7 @@ int dispc_setup_plane(enum omap_plane plane,
 	u16 frame_height = height;
 	unsigned int field_offset = 0;
 
-	DSSDBG("dispc_setup_plane %d, pa %x, sw %d, %d,%d, %dx%d -> "
+	DSSDBG("dispc_ovl_setup %d, pa %x, sw %d, %d,%d, %dx%d -> "
 	       "%dx%d, ilace %d, cmode %x, rot %d, mir %d chan %d\n",
 	       plane, paddr, screen_width, pos_x, pos_y,
 	       width, height,
@@ -1807,45 +1811,45 @@ int dispc_setup_plane(enum omap_plane plane,
 	DSSDBG("offset0 %u, offset1 %u, row_inc %d, pix_inc %d\n",
 			offset0, offset1, row_inc, pix_inc);
 
-	_dispc_set_color_mode(plane, color_mode);
+	dispc_ovl_set_color_mode(plane, color_mode);
 
-	_dispc_set_plane_ba0(plane, paddr + offset0);
-	_dispc_set_plane_ba1(plane, paddr + offset1);
+	dispc_ovl_set_ba0(plane, paddr + offset0);
+	dispc_ovl_set_ba1(plane, paddr + offset1);
 
 	if (OMAP_DSS_COLOR_NV12 == color_mode) {
-		_dispc_set_plane_ba0_uv(plane, puv_addr + offset0);
-		_dispc_set_plane_ba1_uv(plane, puv_addr + offset1);
+		dispc_ovl_set_ba0_uv(plane, puv_addr + offset0);
+		dispc_ovl_set_ba1_uv(plane, puv_addr + offset1);
 	}
 
 
-	_dispc_set_row_inc(plane, row_inc);
-	_dispc_set_pix_inc(plane, pix_inc);
+	dispc_ovl_set_row_inc(plane, row_inc);
+	dispc_ovl_set_pix_inc(plane, pix_inc);
 
 	DSSDBG("%d,%d %dx%d -> %dx%d\n", pos_x, pos_y, width, height,
 			out_width, out_height);
 
-	_dispc_set_plane_pos(plane, pos_x, pos_y);
+	dispc_ovl_set_pos(plane, pos_x, pos_y);
 
-	_dispc_set_pic_size(plane, width, height);
+	dispc_ovl_set_pic_size(plane, width, height);
 
 	if (plane != OMAP_DSS_GFX) {
-		_dispc_set_scaling(plane, width, height,
+		dispc_ovl_set_scaling(plane, width, height,
 				   out_width, out_height,
 				   ilace, five_taps, fieldmode,
 				   color_mode, rotation);
-		_dispc_set_vid_size(plane, out_width, out_height);
-		_dispc_set_vid_color_conv(plane, cconv);
+		dispc_ovl_set_vid_size(plane, out_width, out_height);
+		dispc_ovl_set_vid_color_conv(plane, cconv);
 	}
 
-	_dispc_set_rotation_attrs(plane, rotation, mirror, color_mode);
+	dispc_ovl_set_rotation_attrs(plane, rotation, mirror, color_mode);
 
-	_dispc_set_pre_mult_alpha(plane, pre_mult_alpha);
-	_dispc_setup_global_alpha(plane, global_alpha);
+	dispc_ovl_set_pre_mult_alpha(plane, pre_mult_alpha);
+	dispc_ovl_setup_global_alpha(plane, global_alpha);
 
 	return 0;
 }
 
-int dispc_enable_plane(enum omap_plane plane, bool enable)
+int dispc_ovl_enable(enum omap_plane plane, bool enable)
 {
 	DSSDBG("dispc_enable_plane %d, %d\n", plane, enable);
 
@@ -3053,7 +3057,7 @@ static void dispc_error_worker(struct work_struct *work)
 		if ((1 << bit) & errors) {
 			DSSERR("FIFO UNDERFLOW on %s, disabling the overlay\n",
 					ovl->name);
-			dispc_enable_plane(ovl->id, false);
+			dispc_ovl_enable(ovl->id, false);
 			dispc_go(ovl->manager->id);
 			mdelay(50);
 		}
@@ -3083,7 +3087,7 @@ static void dispc_error_worker(struct work_struct *work)
 
 				if (ovl->id != OMAP_DSS_GFX &&
 						ovl->manager == mgr)
-					dispc_enable_plane(ovl->id, false);
+					dispc_ovl_enable(ovl->id, false);
 			}
 
 			dispc_go(mgr->id);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index c9b50af..f2e9eed 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -387,19 +387,19 @@ void dispc_enable_fifohandcheck(enum omap_channel channel, bool enable);
 
 void dispc_set_lcd_size(enum omap_channel channel, u16 width, u16 height);
 void dispc_set_digit_size(u16 width, u16 height);
-u32 dispc_get_plane_fifo_size(enum omap_plane plane);
-void dispc_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
+u32 dispc_ovl_get_fifo_size(enum omap_plane plane);
+void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high);
 void dispc_enable_fifomerge(bool enable);
-u32 dispc_get_burst_size(enum omap_plane plane);
+u32 dispc_ovl_get_burst_size(enum omap_plane plane);
 void dispc_enable_cpr(enum omap_channel channel, bool enable);
 void dispc_set_cpr_coef(enum omap_channel channel,
 		struct omap_dss_cpr_coefs *coefs);
 
-void dispc_set_channel_out(enum omap_plane plane,
+void dispc_ovl_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel_out);
 
 void dispc_enable_gamma_table(bool enable);
-int dispc_setup_plane(enum omap_plane plane,
+int dispc_ovl_setup(enum omap_plane plane,
 		      u32 paddr, u16 screen_width,
 		      u16 pos_x, u16 pos_y,
 		      u16 width, u16 height,
@@ -416,8 +416,8 @@ bool dispc_go_busy(enum omap_channel channel);
 void dispc_go(enum omap_channel channel);
 void dispc_enable_channel(enum omap_channel channel, bool enable);
 bool dispc_is_channel_enabled(enum omap_channel channel);
-int dispc_enable_plane(enum omap_plane plane, bool enable);
-void dispc_enable_replication(enum omap_plane plane, bool enable);
+int dispc_ovl_enable(enum omap_plane plane, bool enable);
+void dispc_ovl_enable_replication(enum omap_plane plane, bool enable);
 
 void dispc_set_parallel_interface_mode(enum omap_channel channel,
 		enum omap_parallel_interface_mode mode);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 2e5d728..b9bdf22 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -823,7 +823,7 @@ static int configure_overlay(enum omap_plane plane)
 	oi = &c->info;
 
 	if (!c->enabled) {
-		dispc_enable_plane(plane, 0);
+		dispc_ovl_enable(plane, 0);
 		return 0;
 	}
 
@@ -851,7 +851,7 @@ static int configure_overlay(enum omap_plane plane)
 		/* If the overlay is outside the update region, disable it */
 		if (!rectangle_intersects(mc->x, mc->y, mc->w, mc->h,
 					x, y, outw, outh)) {
-			dispc_enable_plane(plane, 0);
+			dispc_ovl_enable(plane, 0);
 			return 0;
 		}
 
@@ -929,7 +929,7 @@ static int configure_overlay(enum omap_plane plane)
 		}
 	}
 
-	r = dispc_setup_plane(plane,
+	r = dispc_ovl_setup(plane,
 			paddr,
 			oi->screen_width,
 			x, y,
@@ -948,15 +948,15 @@ static int configure_overlay(enum omap_plane plane)
 	if (r) {
 		/* this shouldn't happen */
 		DSSERR("dispc_setup_plane failed for ovl %d\n", plane);
-		dispc_enable_plane(plane, 0);
+		dispc_ovl_enable(plane, 0);
 		return r;
 	}
 
-	dispc_enable_replication(plane, c->replication);
+	dispc_ovl_enable_replication(plane, c->replication);
 
-	dispc_set_fifo_threshold(plane, c->fifo_low, c->fifo_high);
+	dispc_ovl_set_fifo_threshold(plane, c->fifo_low, c->fifo_high);
 
-	dispc_enable_plane(plane, 1);
+	dispc_ovl_enable(plane, 1);
 
 	return 0;
 }
@@ -1432,11 +1432,11 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 		dssdev = ovl->manager->device;
 
-		size = dispc_get_plane_fifo_size(ovl->id);
+		size = dispc_ovl_get_fifo_size(ovl->id);
 		if (use_fifomerge)
 			size *= 3;
 
-		burst_size = dispc_get_burst_size(ovl->id);
+		burst_size = dispc_ovl_get_burst_size(ovl->id);
 
 		switch (dssdev->type) {
 		case OMAP_DISPLAY_TYPE_DPI:
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index b2a5685..82a5617 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -517,7 +517,7 @@ static int omap_dss_set_manager(struct omap_overlay *ovl,
 	 * Userspace workaround for this is to update the LCD after disabling
 	 * the overlay, but before moving the overlay to TV.
 	 */
-	dispc_set_channel_out(ovl->id, mgr->id);
+	dispc_ovl_set_channel_out(ovl->id, mgr->id);
 
 	return 0;
 }
-- 
1.7.4.1

