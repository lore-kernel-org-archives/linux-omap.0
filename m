From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 15/29] OMAPDSS: DISPC: Pass overlay caps as a parameter to DISPC overlay related functions
Date: Tue, 27 Dec 2011 18:06:58 +0530
Message-ID: <1324989432-3625-16-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35296 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621Ab1L0MjT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Dec 2011 07:39:19 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Currently, the functions below take the omap_plane parameter and derive the
overlay caps within them. Pass the overlay caps as a parameter to the function
to allow writeback functions to use them too.

- dispc_ovl_set_zorder()
- dispc_ovl_set_pre_mult_alpha()
- dispc_ovl_setup_global_alpha()
- dispc_ovl_calc_scaling()
- dispc_ovl_setup()

These functions will be used for writeback later, and the caps will help in
deciding if they are to be used for writeback or not. This allows reuse of
overlay caps for writeback.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   38 ++++++++++++++++++--------------------
 1 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index dfbb39b..d9e04f0 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -684,11 +684,10 @@ static void dispc_ovl_set_vid_size(enum omap_plane plane, int width, int height)
 	dispc_write_reg(DISPC_OVL_SIZE(plane), val);
 }
 
-static void dispc_ovl_set_zorder(enum omap_plane plane, u8 zorder)
+static void dispc_ovl_set_zorder(enum omap_plane plane,
+		enum omap_overlay_caps caps, u8 zorder)
 {
-	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
-
-	if ((ovl->caps & OMAP_DSS_OVL_CAP_ZORDER) == 0)
+	if ((caps & OMAP_DSS_OVL_CAP_ZORDER) == 0)
 		return;
 
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), zorder, 27, 26);
@@ -705,23 +704,22 @@ static void dispc_ovl_enable_zorder_planes(void)
 		REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(i), 1, 25, 25);
 }
 
-static void dispc_ovl_set_pre_mult_alpha(enum omap_plane plane, bool enable)
+static void dispc_ovl_set_pre_mult_alpha(enum omap_plane plane,
+		enum omap_overlay_caps caps, bool enable)
 {
-	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
-
-	if ((ovl->caps & OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA) == 0)
+	if ((caps & OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA) == 0)
 		return;
 
 	REG_FLD_MOD(DISPC_OVL_ATTRIBUTES(plane), enable ? 1 : 0, 28, 28);
 }
 
-static void dispc_ovl_setup_global_alpha(enum omap_plane plane, u8 global_alpha)
+static void dispc_ovl_setup_global_alpha(enum omap_plane plane,
+		enum omap_overlay_caps caps, u8 global_alpha)
 {
 	static const unsigned shifts[] = { 0, 8, 16, 24, };
 	int shift;
-	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
 
-	if ((ovl->caps & OMAP_DSS_OVL_CAP_GLOBAL_ALPHA) == 0)
+	if ((caps & OMAP_DSS_OVL_CAP_GLOBAL_ALPHA) == 0)
 		return;
 
 	shift = shifts[plane];
@@ -1704,11 +1702,10 @@ static unsigned long calc_fclk(enum omap_channel channel, u16 width,
 }
 
 static int dispc_ovl_calc_scaling(enum omap_plane plane,
-		enum omap_channel channel, u16 width, u16 height,
-		u16 out_width, u16 out_height,
+		enum omap_channel channel, enum omap_overlay_caps caps,
+		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps)
 {
-	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
 	const int maxdownscale = dss_feat_get_param_max(FEAT_PARAM_DOWNSCALE);
 	const int maxsinglelinewidth =
 				dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
@@ -1717,7 +1714,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 	if (width == out_width && height == out_height)
 		return 0;
 
-	if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) == 0)
+	if ((caps & OMAP_DSS_OVL_CAP_SCALE) == 0)
 		return -EINVAL;
 
 	if (out_width < width / maxdownscale ||
@@ -1780,6 +1777,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 		bool ilace, bool replication)
 {
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
+	enum omap_overlay_caps caps = ovl->caps;
 	bool five_taps = true;
 	bool fieldmode = 0;
 	int r, cconv = 0;
@@ -1823,7 +1821,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	if (!dss_feat_color_mode_supported(plane, oi->color_mode))
 		return -EINVAL;
 
-	r = dispc_ovl_calc_scaling(plane, channel, oi->width, oi->height,
+	r = dispc_ovl_calc_scaling(plane, channel, caps, oi->width, oi->height,
 			outw, outh, oi->color_mode,
 			&five_taps);
 	if (r)
@@ -1887,7 +1885,7 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 
 	dispc_ovl_set_pic_size(plane, oi->width, oi->height);
 
-	if (ovl->caps & OMAP_DSS_OVL_CAP_SCALE) {
+	if (caps & OMAP_DSS_OVL_CAP_SCALE) {
 		dispc_ovl_set_scaling(plane, oi->width, oi->height,
 				   outw, outh,
 				   ilace, five_taps, fieldmode,
@@ -1899,9 +1897,9 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 	dispc_ovl_set_rotation_attrs(plane, oi->rotation, oi->mirror,
 			oi->color_mode);
 
-	dispc_ovl_set_zorder(plane, oi->zorder);
-	dispc_ovl_set_pre_mult_alpha(plane, oi->pre_mult_alpha);
-	dispc_ovl_setup_global_alpha(plane, oi->global_alpha);
+	dispc_ovl_set_zorder(plane, caps, oi->zorder);
+	dispc_ovl_set_pre_mult_alpha(plane, caps, oi->pre_mult_alpha);
+	dispc_ovl_setup_global_alpha(plane, caps, oi->global_alpha);
 
 	dispc_ovl_enable_replication(plane, replication);
 
-- 
1.7.4.1

