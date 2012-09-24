From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH] OMAPDSS: DISPC: Add predecimation limit for TILER based rotations
Date: Mon, 24 Sep 2012 12:08:27 +0530
Message-ID: <1348468707-5142-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46696 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752246Ab2IXGkm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Sep 2012 02:40:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

In OMAP4 and OMAP5 when TILER 2D burst mode is used, a maximum of one line can
be skipped as per the respective TRMs. The MBlockStride OCP signal, which is
sum of ROWINC and image width in memory, is only 17 bits wide. In 2D mode TILER
supports 8192, 16384, 32768 and 65536 values of MBlockStride. In case when 2 or
more lines are skipped the ROWINC value exceeds 65536 resulting in OCP errors.
So, maximum vertical predecimation achievable is 2.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index d512c38..61f8369 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2195,7 +2195,8 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
-		int *x_predecim, int *y_predecim, u16 pos_x)
+		int *x_predecim, int *y_predecim, u16 pos_x,
+		enum omap_dss_rotation_type rotation_type)
 {
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
 	const int maxdownscale = dss_feat_get_param_max(FEAT_PARAM_DOWNSCALE);
@@ -2210,7 +2211,8 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 		return -EINVAL;
 
 	*x_predecim = max_decim_limit;
-	*y_predecim = max_decim_limit;
+	*y_predecim = (rotation_type == OMAP_DSS_ROT_TILER &&
+			dss_has_feature(FEAT_BURST_2D)) ? 2 : max_decim_limit;
 
 	if (color_mode == OMAP_DSS_COLOR_CLUT1 ||
 	    color_mode == OMAP_DSS_COLOR_CLUT2 ||
@@ -2306,7 +2308,8 @@ int dispc_ovl_setup(enum omap_plane plane, struct omap_overlay_info *oi,
 
 	r = dispc_ovl_calc_scaling(plane, channel, mgr_timings, in_width,
 			in_height, out_width, out_height, oi->color_mode,
-			&five_taps, &x_predecim, &y_predecim, oi->pos_x);
+			&five_taps, &x_predecim, &y_predecim, oi->pos_x,
+			oi->rotation_type);
 	if (r)
 		return r;
 
-- 
1.7.10

