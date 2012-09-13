From: Archit Taneja <archit@ti.com>
Subject: [PATCH 06/21] OMAPDSS: DISPC: Pass overlay caps as a parameter to dispc plane functions
Date: Thu, 13 Sep 2012 17:44:50 +0530
Message-ID: <1347538505-25359-7-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52116 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757937Ab2IMMPV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 08:15:21 -0400
In-Reply-To: <1347538505-25359-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Currently, the functions below take the omap_plane parameter and derive the
overlay caps within them. Pass the overlay caps as a parameter to the function
to allow these to be used by writeback too.

- dispc_plane_set_zorder()
- dispc_plane_set_pre_mult_alpha()
- dispc_plane_setup_global_alpha()
- dispc_plane_calc_scaling()
- dispc_ovl_setup()

These functions will be used for writeback later, and the caps will help in
deciding if they are to be used for writeback or not. This allows reuse of
overlay caps for writeback.

Using omap_overlay_caps for writeback seems a bit incorrect, but caps is
something already in use by users of OMAPDSS(omapfb/omap_vout), so we use
overlay caps for overlay like features of writeback too.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   40 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index f60fcf4..3a0a576 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -733,11 +733,10 @@ static void dispc_plane_set_output_size(enum omap_plane plane, int width,
 	dispc_write_reg(DISPC_OVL_SIZE(plane), val);
 }
 
-static void dispc_plane_set_zorder(enum omap_plane plane, u8 zorder)
+static void dispc_plane_set_zorder(enum omap_plane plane,
+		enum omap_overlay_caps caps, u8 zorder)
 {
-	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
-
-	if ((ovl->caps & OMAP_DSS_OVL_CAP_ZORDER) == 0)
+	if ((caps & OMAP_DSS_OVL_CAP_ZORDER) == 0)
 		return;
 
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), zorder, 27, 26);
@@ -754,24 +753,22 @@ static void dispc_ovl_enable_zorder_planes(void)
 		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(i), 1, 25, 25);
 }
 
-static void dispc_plane_set_pre_mult_alpha(enum omap_plane plane, bool enable)
+static void dispc_plane_set_pre_mult_alpha(enum omap_plane plane,
+		enum omap_overlay_caps caps, bool enable)
 {
-	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
-
-	if ((ovl->caps & OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA) == 0)
+	if ((caps & OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA) == 0)
 		return;
 
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable ? 1 : 0, 28, 28);
 }
 
 static void dispc_plane_setup_global_alpha(enum omap_plane plane,
-		u8 global_alpha)
+		enum omap_overlay_caps caps, u8 global_alpha)
 {
 	static const unsigned shifts[] = { 0, 8, 16, 24, };
 	int shift;
-	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
 
-	if ((ovl->caps & OMAP_DSS_OVL_CAP_GLOBAL_ALPHA) == 0)
+	if ((caps & OMAP_DSS_OVL_CAP_GLOBAL_ALPHA) == 0)
 		return;
 
 	shift = shifts[plane];
@@ -2200,13 +2197,12 @@ static int dispc_ovl_calc_scaling_44xx(enum omap_channel channel,
 }
 
 static int dispc_plane_calc_scaling(enum omap_plane plane,
-		enum omap_channel channel,
+		enum omap_overlay_caps caps, enum omap_channel channel,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
 		int *x_predecim, int *y_predecim, u16 pos_x)
 {
-	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
 	const int maxdownscale = dss_feat_get_param_max(FEAT_PARAM_DOWNSCALE);
 	const int max_decim_limit = 16;
 	unsigned long core_clk = 0;
@@ -2215,7 +2211,7 @@ static int dispc_plane_calc_scaling(enum omap_plane plane,
 	if (width == out_width && height == out_height)
 		return 0;
 
-	if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) == 0)
+	if ((caps & OMAP_DSS_OVL_CAP_SCALE) == 0)
 		return -EINVAL;
 
 	*x_predecim = max_decim_limit;
@@ -2266,6 +2262,7 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 		bool replication, const struct omap_video_timings *mgr_timings)
 {
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
+	enum omap_overlay_caps caps = ovl->caps;
 	bool five_taps = true;
 	bool fieldmode = 0;
 	int r, cconv = 0;
@@ -2314,9 +2311,10 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 	if (!dss_feat_color_mode_supported(plane, oi->color_mode))
 		return -EINVAL;
 
-	r = dispc_plane_calc_scaling(plane, channel, mgr_timings, in_width,
-			in_height, out_width, out_height, oi->color_mode,
-			&five_taps, &x_predecim, &y_predecim, oi->pos_x);
+	r = dispc_plane_calc_scaling(plane, caps, channel, mgr_timings,
+			in_width, in_height, out_width, out_height,
+			oi->color_mode, &five_taps, &x_predecim, &y_predecim,
+			oi->pos_x);
 	if (r)
 		return r;
 
@@ -2395,7 +2393,7 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 
 	dispc_plane_set_input_size(plane, in_width, in_height);
 
-	if (ovl->caps & OMAP_DSS_OVL_CAP_SCALE) {
+	if (caps & OMAP_DSS_OVL_CAP_SCALE) {
 		dispc_plane_set_scaling(plane, in_width, in_height, out_width,
 				   out_height, ilace, five_taps, fieldmode,
 				   oi->color_mode, oi->rotation);
@@ -2406,9 +2404,9 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 	dispc_plane_set_rotation_attrs(plane, oi->rotation, oi->mirror,
 			oi->color_mode);
 
-	dispc_plane_set_zorder(plane, oi->zorder);
-	dispc_plane_set_pre_mult_alpha(plane, oi->pre_mult_alpha);
-	dispc_plane_setup_global_alpha(plane, oi->global_alpha);
+	dispc_plane_set_zorder(plane, caps, oi->zorder);
+	dispc_plane_set_pre_mult_alpha(plane, caps, oi->pre_mult_alpha);
+	dispc_plane_setup_global_alpha(plane, caps, oi->global_alpha);
 
 	dispc_plane_enable_replication(plane, replication);
 
-- 
1.7.9.5

