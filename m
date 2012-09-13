From: Archit Taneja <archit@ti.com>
Subject: [PATCH 04/21] OMAPDSS: DISPC: Rename misc functions from dispc_ovl_* to dispc_plane_*
Date: Thu, 13 Sep 2012 17:44:48 +0530
Message-ID: <1347538505-25359-5-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43580 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757857Ab2IMMPP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 08:15:15 -0400
In-Reply-To: <1347538505-25359-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Writeback pipeline has similar registers compared to graphics and video pipes
for setting base addresses, color conversion, row inc, pix inc etc. Rename these
functions from dispc_ovl_* to dispc_plane_*. The actual registers are kept as
DISPC_OVL_* only to prevent too much change.

All functions which are common to overlays and writeback are to be named as
dispc_plane_*, functions which are specific to overlays are to be named as
dispc_ovl_*, and writeback as dispc_wb_*.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   67 ++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 44e86ad..9ecdd44 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -683,34 +683,35 @@ static void _dispc_setup_color_conv_coef(void)
 }
 
 
-static void dispc_ovl_set_ba0(enum omap_plane plane, u32 paddr)
+static void dispc_plane_set_ba0(enum omap_plane plane, u32 paddr)
 {
 	dispc_write_reg(DISPC_OVL_BA0(plane), paddr);
 }
 
-static void dispc_ovl_set_ba1(enum omap_plane plane, u32 paddr)
+static void dispc_plane_set_ba1(enum omap_plane plane, u32 paddr)
 {
 	dispc_write_reg(DISPC_OVL_BA1(plane), paddr);
 }
 
-static void dispc_ovl_set_ba0_uv(enum omap_plane plane, u32 paddr)
+static void dispc_plane_set_ba0_uv(enum omap_plane plane, u32 paddr)
 {
 	dispc_write_reg(DISPC_OVL_BA0_UV(plane), paddr);
 }
 
-static void dispc_ovl_set_ba1_uv(enum omap_plane plane, u32 paddr)
+static void dispc_plane_set_ba1_uv(enum omap_plane plane, u32 paddr)
 {
 	dispc_write_reg(DISPC_OVL_BA1_UV(plane), paddr);
 }
 
-static void dispc_ovl_set_pos(enum omap_plane plane, int x, int y)
+static void dispc_plane_set_pos(enum omap_plane plane, int x, int y)
 {
 	u32 val = FLD_VAL(y, 26, 16) | FLD_VAL(x, 10, 0);
 
 	dispc_write_reg(DISPC_OVL_POSITION(plane), val);
 }
 
-static void dispc_ovl_set_pic_size(enum omap_plane plane, int width, int height)
+static void dispc_plane_set_pic_size(enum omap_plane plane, int width,
+		int height)
 {
 	u32 val = FLD_VAL(height - 1, 26, 16) | FLD_VAL(width - 1, 10, 0);
 
@@ -720,7 +721,8 @@ static void dispc_ovl_set_pic_size(enum omap_plane plane, int width, int height)
 		dispc_write_reg(DISPC_OVL_PICTURE_SIZE(plane), val);
 }
 
-static void dispc_ovl_set_vid_size(enum omap_plane plane, int width, int height)
+static void dispc_plane_set_vid_size(enum omap_plane plane, int width,
+		int height)
 {
 	u32 val;
 
@@ -731,7 +733,7 @@ static void dispc_ovl_set_vid_size(enum omap_plane plane, int width, int height)
 	dispc_write_reg(DISPC_OVL_SIZE(plane), val);
 }
 
-static void dispc_ovl_set_zorder(enum omap_plane plane, u8 zorder)
+static void dispc_plane_set_zorder(enum omap_plane plane, u8 zorder)
 {
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
 
@@ -752,7 +754,7 @@ static void dispc_ovl_enable_zorder_planes(void)
 		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(i), 1, 25, 25);
 }
 
-static void dispc_ovl_set_pre_mult_alpha(enum omap_plane plane, bool enable)
+static void dispc_plane_set_pre_mult_alpha(enum omap_plane plane, bool enable)
 {
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
 
@@ -762,7 +764,8 @@ static void dispc_ovl_set_pre_mult_alpha(enum omap_plane plane, bool enable)
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable ? 1 : 0, 28, 28);
 }
 
-static void dispc_ovl_setup_global_alpha(enum omap_plane plane, u8 global_alpha)
+static void dispc_plane_setup_global_alpha(enum omap_plane plane,
+		u8 global_alpha)
 {
 	static const unsigned shifts[] = { 0, 8, 16, 24, };
 	int shift;
@@ -775,17 +778,17 @@ static void dispc_ovl_setup_global_alpha(enum omap_plane plane, u8 global_alpha)
 	REG_FLD_MOD(DISPC_GLOBAL_ALPHA, global_alpha, shift + 7, shift);
 }
 
-static void dispc_ovl_set_pix_inc(enum omap_plane plane, s32 inc)
+static void dispc_plane_set_pix_inc(enum omap_plane plane, s32 inc)
 {
 	dispc_write_reg(DISPC_OVL_PIXEL_INC(plane), inc);
 }
 
-static void dispc_ovl_set_row_inc(enum omap_plane plane, s32 inc)
+static void dispc_plane_set_row_inc(enum omap_plane plane, s32 inc)
 {
 	dispc_write_reg(DISPC_OVL_ROW_INC(plane), inc);
 }
 
-static void dispc_ovl_set_color_mode(enum omap_plane plane,
+static void dispc_plane_set_color_mode(enum omap_plane plane,
 		enum omap_color_mode color_mode)
 {
 	u32 m = 0;
@@ -1045,7 +1048,7 @@ static void dispc_mgr_set_cpr_coef(enum omap_channel channel,
 	dispc_write_reg(DISPC_CPR_COEF_B(channel), coef_b);
 }
 
-static void dispc_ovl_set_vid_color_conv(enum omap_plane plane, bool enable)
+static void dispc_plane_set_vid_color_conv(enum omap_plane plane, bool enable)
 {
 	u32 val;
 
@@ -1056,7 +1059,7 @@ static void dispc_ovl_set_vid_color_conv(enum omap_plane plane, bool enable)
 	dispc_write_reg(DISPC_OVL_ATTRIBUTES(plane), val);
 }
 
-static void dispc_ovl_enable_replication(enum omap_plane plane, bool enable)
+static void dispc_plane_enable_replication(enum omap_plane plane, bool enable)
 {
 	static const unsigned shifts[] = { 5, 10, 10, 10 };
 	int shift;
@@ -1530,7 +1533,7 @@ static void dispc_plane_set_scaling(enum omap_plane plane,
 		rotation);
 }
 
-static void dispc_ovl_set_rotation_attrs(enum omap_plane plane, u8 rotation,
+static void dispc_plane_set_rotation_attrs(enum omap_plane plane, u8 rotation,
 		bool mirroring, enum omap_color_mode color_mode)
 {
 	bool row_repeat = false;
@@ -2369,45 +2372,45 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 	DSSDBG("offset0 %u, offset1 %u, row_inc %d, pix_inc %d\n",
 			offset0, offset1, row_inc, pix_inc);
 
-	dispc_ovl_set_color_mode(plane, oi->color_mode);
+	dispc_plane_set_color_mode(plane, oi->color_mode);
 
 	dispc_plane_configure_burst_type(plane, oi->rotation_type);
 
-	dispc_ovl_set_ba0(plane, oi->paddr + offset0);
-	dispc_ovl_set_ba1(plane, oi->paddr + offset1);
+	dispc_plane_set_ba0(plane, oi->paddr + offset0);
+	dispc_plane_set_ba1(plane, oi->paddr + offset1);
 
 	if (OMAP_DSS_COLOR_NV12 == oi->color_mode) {
-		dispc_ovl_set_ba0_uv(plane, oi->p_uv_addr + offset0);
-		dispc_ovl_set_ba1_uv(plane, oi->p_uv_addr + offset1);
+		dispc_plane_set_ba0_uv(plane, oi->p_uv_addr + offset0);
+		dispc_plane_set_ba1_uv(plane, oi->p_uv_addr + offset1);
 	}
 
 
-	dispc_ovl_set_row_inc(plane, row_inc);
-	dispc_ovl_set_pix_inc(plane, pix_inc);
+	dispc_plane_set_row_inc(plane, row_inc);
+	dispc_plane_set_pix_inc(plane, pix_inc);
 
 	DSSDBG("%d,%d %dx%d -> %dx%d\n", oi->pos_x, oi->pos_y, in_width,
 			in_height, out_width, out_height);
 
-	dispc_ovl_set_pos(plane, oi->pos_x, pos_y);
+	dispc_plane_set_pos(plane, oi->pos_x, pos_y);
 
-	dispc_ovl_set_pic_size(plane, in_width, in_height);
+	dispc_plane_set_pic_size(plane, in_width, in_height);
 
 	if (ovl->caps & OMAP_DSS_OVL_CAP_SCALE) {
 		dispc_plane_set_scaling(plane, in_width, in_height, out_width,
 				   out_height, ilace, five_taps, fieldmode,
 				   oi->color_mode, oi->rotation);
-		dispc_ovl_set_vid_size(plane, out_width, out_height);
-		dispc_ovl_set_vid_color_conv(plane, cconv);
+		dispc_plane_set_vid_size(plane, out_width, out_height);
+		dispc_plane_set_vid_color_conv(plane, cconv);
 	}
 
-	dispc_ovl_set_rotation_attrs(plane, oi->rotation, oi->mirror,
+	dispc_plane_set_rotation_attrs(plane, oi->rotation, oi->mirror,
 			oi->color_mode);
 
-	dispc_ovl_set_zorder(plane, oi->zorder);
-	dispc_ovl_set_pre_mult_alpha(plane, oi->pre_mult_alpha);
-	dispc_ovl_setup_global_alpha(plane, oi->global_alpha);
+	dispc_plane_set_zorder(plane, oi->zorder);
+	dispc_plane_set_pre_mult_alpha(plane, oi->pre_mult_alpha);
+	dispc_plane_setup_global_alpha(plane, oi->global_alpha);
 
-	dispc_ovl_enable_replication(plane, replication);
+	dispc_plane_enable_replication(plane, replication);
 
 	return 0;
 }
-- 
1.7.9.5

