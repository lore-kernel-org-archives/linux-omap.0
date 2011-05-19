From: Amber Jain <amber@ti.com>
Subject: [PATCH v2 5/5] OMAP: DSS2: Add support for NV12 format
Date: Thu, 19 May 2011 19:47:54 +0530
Message-ID: <1305814674-21589-6-git-send-email-amber@ti.com>
References: <1305814674-21589-1-git-send-email-amber@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45270 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933280Ab1ESOSO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 10:18:14 -0400
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4JEIES5027211
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 09:18:14 -0500
In-Reply-To: <1305814674-21589-1-git-send-email-amber@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, molnar@ti.com, Amber Jain <amber@ti.com>

Add the support for NV12 color format.
Configure base address for UV component of NV12 color format.
Change the way chroma scaling is handled for YUV formats on OMAP4 by enabling
chroma-resampling for video pipeline and hence using FIR2 register set for
scaling UV.
Changes to _dispc_set_scaling(), because of the reason above, are:
- call _dispc_set_scaling_common() to handle scaling for all color formats
  except for OMAP4 where it only handles scaling for RGB or Y-component
- call _dispc_set_scaling_uv() for special handling required for UV
  component on OMAP4.
- dispc_set_scaling_uv() also resets chroma-resampling bit for RGB color modes.

Contains chroma scaling (_dispc_set_scaling_uv) design and implemented by
Lajos Molnar <molnar@ti.com>

Signed-off-by: Amber Jain <amber@ti.com>
---
Changes from v1:
- updated the commit message to make it more descriptive.

 drivers/video/omap2/dss/dispc.c   |  201 +++++++++++++++++++++++++++++++------
 drivers/video/omap2/dss/dss.h     |    3 +-
 drivers/video/omap2/dss/manager.c |    5 +-
 include/video/omapdss.h           |    1 +
 4 files changed, 176 insertions(+), 34 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index e921e97..80a7d22 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -110,6 +110,18 @@ static struct {
 #endif
 } dispc;
 
+enum omap_color_component {
+	/* used for all color formats for OMAP3 and earlier
+	 * and for RGB and Y color component on OMAP4
+	 */
+	DISPC_COLOR_COMPONENT_RGB_Y		= 1 << 0,
+	/* used for UV component for
+	 * OMAP_DSS_COLOR_YUV2, OMAP_DSS_COLOR_UYVY, OMAP_DSS_COLOR_NV12
+	 * color formats on OMAP4
+	 */
+	DISPC_COLOR_COMPONENT_UV		= 1 << 1,
+};
+
 static void _omap_dispc_set_irqs(void);
 
 static inline void dispc_write_reg(const u16 idx, u32 val)
@@ -574,7 +586,8 @@ static void _dispc_write_firv2_reg(enum omap_plane plane, int reg, u32 value)
 }
 
 static void _dispc_set_scale_coef(enum omap_plane plane, int hscaleup,
-		int vscaleup, int five_taps)
+				  int vscaleup, int five_taps,
+				  enum omap_color_component color_comp)
 {
 	/* Coefficients for horizontal up-sampling */
 	static const struct dispc_h_coef coef_hup[8] = {
@@ -672,8 +685,14 @@ static void _dispc_set_scale_coef(enum omap_plane plane, int hscaleup,
 			| FLD_VAL(v_coef[i].vc1, 23, 16)
 			| FLD_VAL(v_coef[i].vc2, 31, 24);
 
-		_dispc_write_firh_reg(plane, i, h);
-		_dispc_write_firhv_reg(plane, i, hv);
+		if (color_comp == DISPC_COLOR_COMPONENT_RGB_Y) {
+			_dispc_write_firh_reg(plane, i, h);
+			_dispc_write_firhv_reg(plane, i, hv);
+		} else {
+			_dispc_write_firh2_reg(plane, i, h);
+			_dispc_write_firhv2_reg(plane, i, hv);
+		}
+
 	}
 
 	if (five_taps) {
@@ -681,7 +700,10 @@ static void _dispc_set_scale_coef(enum omap_plane plane, int hscaleup,
 			u32 v;
 			v = FLD_VAL(v_coef[i].vc00, 7, 0)
 				| FLD_VAL(v_coef[i].vc22, 15, 8);
-			_dispc_write_firv_reg(plane, i, v);
+			if (color_comp == DISPC_COLOR_COMPONENT_RGB_Y)
+				_dispc_write_firv_reg(plane, i, v);
+			else
+				_dispc_write_firv2_reg(plane, i, v);
 		}
 	}
 }
@@ -1090,18 +1112,27 @@ void dispc_enable_fifomerge(bool enable)
 	enable_clocks(0);
 }
 
-static void _dispc_set_fir(enum omap_plane plane, int hinc, int vinc)
+static void _dispc_set_fir(enum omap_plane plane,
+				int hinc, int vinc,
+				enum omap_color_component color_comp)
 {
 	u32 val;
-	u8 hinc_start, hinc_end, vinc_start, vinc_end;
 
-	dss_feat_get_reg_field(FEAT_REG_FIRHINC, &hinc_start, &hinc_end);
-	dss_feat_get_reg_field(FEAT_REG_FIRVINC, &vinc_start, &vinc_end);
+	if (color_comp == DISPC_COLOR_COMPONENT_RGB_Y) {
+		u8 hinc_start, hinc_end, vinc_start, vinc_end;
 
-	val = FLD_VAL(vinc, vinc_start, vinc_end) |
-			FLD_VAL(hinc, hinc_start, hinc_end);
+		dss_feat_get_reg_field(FEAT_REG_FIRHINC,
+					&hinc_start, &hinc_end);
+		dss_feat_get_reg_field(FEAT_REG_FIRVINC,
+					&vinc_start, &vinc_end);
+		val = FLD_VAL(vinc, vinc_start, vinc_end) |
+				FLD_VAL(hinc, hinc_start, hinc_end);
 
-	dispc_write_reg(DISPC_OVL_FIR(plane), val);
+		dispc_write_reg(DISPC_OVL_FIR(plane), val);
+	} else {
+		val = FLD_VAL(vinc, 28, 16) | FLD_VAL(hinc, 12, 0);
+		dispc_write_reg(DISPC_OVL_FIR2(plane), val);
+	}
 }
 
 static void _dispc_set_vid_accu0(enum omap_plane plane, int haccu, int vaccu)
@@ -1148,31 +1179,40 @@ static void _dispc_set_vid_accu2_1(enum omap_plane plane, int haccu, int vaccu)
 	dispc_write_reg(DISPC_OVL_ACCU2_1(plane), val);
 }
 
-static void _dispc_set_scaling(enum omap_plane plane,
+static void _dispc_set_scale_param(enum omap_plane plane,
 		u16 orig_width, u16 orig_height,
 		u16 out_width, u16 out_height,
-		bool ilace, bool five_taps,
-		bool fieldmode)
+		bool five_taps, u8 rotation,
+		enum omap_color_component color_comp)
 {
-	int fir_hinc;
-	int fir_vinc;
+	int fir_hinc, fir_vinc;
 	int hscaleup, vscaleup;
-	int accu0 = 0;
-	int accu1 = 0;
-	u32 l;
-
-	BUG_ON(plane == OMAP_DSS_GFX);
 
 	hscaleup = orig_width <= out_width;
 	vscaleup = orig_height <= out_height;
 
-	_dispc_set_scale_coef(plane, hscaleup, vscaleup, five_taps);
+	_dispc_set_scale_coef(plane, hscaleup, vscaleup, five_taps, color_comp);
 
 	fir_hinc = 1024 * orig_width / out_width;
 	fir_vinc = 1024 * orig_height / out_height;
 
-	_dispc_set_fir(plane, fir_hinc, fir_vinc);
+	_dispc_set_fir(plane, fir_hinc, fir_vinc, color_comp);
+}
+
+static void _dispc_set_scaling_common(enum omap_plane plane,
+		u16 orig_width, u16 orig_height,
+		u16 out_width, u16 out_height,
+		bool ilace, bool five_taps,
+		bool fieldmode, enum omap_color_mode color_mode,
+		u8 rotation)
+{
+	int accu0 = 0;
+	int accu1 = 0;
+	u32 l;
 
+	_dispc_set_scale_param(plane, orig_width, orig_height,
+				out_width, out_height, five_taps,
+				rotation, DISPC_COLOR_COMPONENT_RGB_Y);
 	l = dispc_read_reg(DISPC_OVL_ATTRIBUTES(plane));
 
 	/* RESIZEENABLE and VERTICALTAPS */
@@ -1184,8 +1224,8 @@ static void _dispc_set_scaling(enum omap_plane plane,
 	/* VRESIZECONF and HRESIZECONF */
 	if (dss_has_feature(FEAT_RESIZECONF)) {
 		l &= ~(0x3 << 7);
-		l |= hscaleup ? 0 : (1 << 7);
-		l |= vscaleup ? 0 : (1 << 8);
+		l |= (orig_width <= out_width) ? 0 : (1 << 7);
+		l |= (orig_height <= out_height) ? 0 : (1 << 8);
 	}
 
 	/* LINEBUFFERSPLIT */
@@ -1202,7 +1242,7 @@ static void _dispc_set_scaling(enum omap_plane plane,
 	 */
 	if (ilace && !fieldmode) {
 		accu1 = 0;
-		accu0 = (fir_vinc / 2) & 0x3ff;
+		accu0 = ((1024 * orig_height / out_height) / 2) & 0x3ff;
 		if (accu0 >= 1024/2) {
 			accu1 = 1024/2;
 			accu0 -= accu1;
@@ -1213,6 +1253,93 @@ static void _dispc_set_scaling(enum omap_plane plane,
 	_dispc_set_vid_accu1(plane, 0, accu1);
 }
 
+static void _dispc_set_scaling_uv(enum omap_plane plane,
+		u16 orig_width, u16 orig_height,
+		u16 out_width, u16 out_height,
+		bool ilace, bool five_taps,
+		bool fieldmode, enum omap_color_mode color_mode,
+		u8 rotation)
+{
+	int scale_x = out_width != orig_width;
+	int scale_y = out_height != orig_height;
+
+	if (!dss_has_feature(FEAT_HANDLE_UV_SEPARATE))
+		return;
+	if ((color_mode != OMAP_DSS_COLOR_YUV2 &&
+			color_mode != OMAP_DSS_COLOR_UYVY &&
+			color_mode != OMAP_DSS_COLOR_NV12)) {
+		/* reset chroma resampling for RGB formats  */
+		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES2(plane), 0, 8, 8);
+		return;
+	}
+	switch (color_mode) {
+	case OMAP_DSS_COLOR_NV12:
+		/* UV is subsampled by 2 vertically*/
+		orig_height >>= 1;
+		/* UV is subsampled by 2 horz.*/
+		orig_width >>= 1;
+		break;
+	case OMAP_DSS_COLOR_YUV2:
+	case OMAP_DSS_COLOR_UYVY:
+		/*For YUV422 with 90/270 rotation,
+		 *we don't upsample chroma
+		 */
+		if (rotation == OMAP_DSS_ROT_0 ||
+			rotation == OMAP_DSS_ROT_180)
+			/* UV is subsampled by 2 hrz*/
+			orig_width >>= 1;
+		/* must use FIR for YUV422 if rotated */
+		if (rotation != OMAP_DSS_ROT_0)
+			scale_x = scale_y = true;
+		break;
+	default:
+		BUG();
+	}
+
+	if (out_width != orig_width)
+		scale_x = true;
+	if (out_height != orig_height)
+		scale_y = true;
+
+	_dispc_set_scale_param(plane, orig_width, orig_height,
+			out_width, out_height, five_taps,
+				rotation, DISPC_COLOR_COMPONENT_UV);
+
+	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES2(plane),
+		(scale_x || scale_y) ? 1 : 0, 8, 8);
+	/* set H scaling */
+	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), scale_x ? 1 : 0, 5, 5);
+	/* set V scaling */
+	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), scale_y ? 1 : 0, 6, 6);
+
+	_dispc_set_vid_accu2_0(plane, 0x80, 0);
+	_dispc_set_vid_accu2_1(plane, 0x80, 0);
+}
+
+static void _dispc_set_scaling(enum omap_plane plane,
+		u16 orig_width, u16 orig_height,
+		u16 out_width, u16 out_height,
+		bool ilace, bool five_taps,
+		bool fieldmode, enum omap_color_mode color_mode,
+		u8 rotation)
+{
+	BUG_ON(plane == OMAP_DSS_GFX);
+
+	_dispc_set_scaling_common(plane,
+			orig_width, orig_height,
+			out_width, out_height,
+			ilace, five_taps,
+			fieldmode, color_mode,
+			rotation);
+
+	_dispc_set_scaling_uv(plane,
+		orig_width, orig_height,
+		out_width, out_height,
+		ilace, five_taps,
+		fieldmode, color_mode,
+		rotation);
+}
+
 static void _dispc_set_rotation_attrs(enum omap_plane plane, u8 rotation,
 		bool mirroring, enum omap_color_mode color_mode)
 {
@@ -1619,7 +1746,7 @@ static int _dispc_setup_plane(enum omap_plane plane,
 		enum omap_dss_rotation_type rotation_type,
 		u8 rotation, int mirror,
 		u8 global_alpha, u8 pre_mult_alpha,
-		enum omap_channel channel)
+		enum omap_channel channel, u32 puv_addr)
 {
 	const int maxdownscale = cpu_is_omap34xx() ? 4 : 2;
 	bool five_taps = 0;
@@ -1668,7 +1795,8 @@ static int _dispc_setup_plane(enum omap_plane plane,
 			return -EINVAL;
 
 		if (color_mode == OMAP_DSS_COLOR_YUV2 ||
-			color_mode == OMAP_DSS_COLOR_UYVY)
+			color_mode == OMAP_DSS_COLOR_UYVY ||
+			color_mode == OMAP_DSS_COLOR_NV12)
 			cconv = 1;
 
 		/* Must use 5-tap filter? */
@@ -1742,6 +1870,12 @@ static int _dispc_setup_plane(enum omap_plane plane,
 	_dispc_set_plane_ba0(plane, paddr + offset0);
 	_dispc_set_plane_ba1(plane, paddr + offset1);
 
+	if (OMAP_DSS_COLOR_NV12 == color_mode) {
+		_dispc_set_plane_ba0_uv(plane, puv_addr + offset0);
+		_dispc_set_plane_ba1_uv(plane, puv_addr + offset1);
+	}
+
+
 	_dispc_set_row_inc(plane, row_inc);
 	_dispc_set_pix_inc(plane, pix_inc);
 
@@ -1755,7 +1889,8 @@ static int _dispc_setup_plane(enum omap_plane plane,
 	if (plane != OMAP_DSS_GFX) {
 		_dispc_set_scaling(plane, width, height,
 				   out_width, out_height,
-				   ilace, five_taps, fieldmode);
+				   ilace, five_taps, fieldmode,
+				   color_mode, rotation);
 		_dispc_set_vid_size(plane, out_width, out_height);
 		_dispc_set_vid_color_conv(plane, cconv);
 	}
@@ -3451,11 +3586,12 @@ int dispc_setup_plane(enum omap_plane plane,
 		       bool ilace,
 		       enum omap_dss_rotation_type rotation_type,
 		       u8 rotation, bool mirror, u8 global_alpha,
-		       u8 pre_mult_alpha, enum omap_channel channel)
+		       u8 pre_mult_alpha, enum omap_channel channel,
+		       u32 puv_addr)
 {
 	int r = 0;
 
-	DSSDBG("dispc_setup_plane %d, pa %x, sw %d, %d,%d, %dx%d -> "
+	DSSDBG("dispc_setup_plane %d, pa %x, sw %d, %d, %d, %dx%d -> "
 	       "%dx%d, ilace %d, cmode %x, rot %d, mir %d chan %d\n",
 	       plane, paddr, screen_width, pos_x, pos_y,
 	       width, height,
@@ -3474,7 +3610,8 @@ int dispc_setup_plane(enum omap_plane plane,
 			   rotation_type,
 			   rotation, mirror,
 			   global_alpha,
-			   pre_mult_alpha, channel);
+			   pre_mult_alpha,
+			   channel, puv_addr);
 
 	enable_clocks(0);
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 6386f6b..8ab6d43 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -421,7 +421,8 @@ int dispc_setup_plane(enum omap_plane plane,
 		      enum omap_dss_rotation_type rotation_type,
 		      u8 rotation, bool mirror,
 		      u8 global_alpha, u8 pre_mult_alpha,
-		      enum omap_channel channel);
+		      enum omap_channel channel,
+		      u32 puv_addr);
 
 bool dispc_go_busy(enum omap_channel channel);
 void dispc_go(enum omap_channel channel);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index b40fe3d..9aeea50 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -393,6 +393,7 @@ struct overlay_cache_data {
 
 	u32 paddr;
 	void __iomem *vaddr;
+	u32 p_uv_addr; /* relevant for NV12 format only */
 	u16 screen_width;
 	u16 width;
 	u16 height;
@@ -861,7 +862,8 @@ static int configure_overlay(enum omap_plane plane)
 			c->mirror,
 			c->global_alpha,
 			c->pre_mult_alpha,
-			c->channel);
+			c->channel,
+			c->p_uv_addr);
 
 	if (r) {
 		/* this shouldn't happen */
@@ -1276,6 +1278,7 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 		oc->paddr = ovl->info.paddr;
 		oc->vaddr = ovl->info.vaddr;
+		oc->p_uv_addr = ovl->info.p_uv_addr;
 		oc->screen_width = ovl->info.screen_width;
 		oc->width = ovl->info.width;
 		oc->height = ovl->info.height;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 5658b4b..892b97f 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -305,6 +305,7 @@ struct omap_overlay_info {
 
 	u32 paddr;
 	void __iomem *vaddr;
+	u32 p_uv_addr;  /* for NV12 format */
 	u16 screen_width;
 	u16 width;
 	u16 height;
-- 
1.7.1

