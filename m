From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/32] OMAPDSS: DISPC: pass pclk & lclk to calc_scaling
Date: Thu, 15 Nov 2012 17:58:20 +0200
Message-ID: <1352995120-3288-13-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56249 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768236Ab2KOP73 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 10:59:29 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

In order to make the scaling calculations independent of the current
hardware configuration (e.g. which manager is connected to this output),
we need to change the calc funcs to get all the variables needed for the
calculations via parameters.

This patch changes calc_scaling to get pclk and lclk as parameters.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index cd3dec6..155085a 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -87,7 +87,7 @@ struct dispc_features {
 	u16 sw_max;
 	u16 vp_max;
 	u16 hp_max;
-	int (*calc_scaling) (enum omap_plane plane,
+	int (*calc_scaling) (unsigned long pclk, unsigned long lclk,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
@@ -2129,7 +2129,7 @@ static unsigned long calc_core_clk_44xx(unsigned long pclk, u16 width,
 		return pclk;
 }
 
-static int dispc_ovl_calc_scaling_24xx(enum omap_plane plane,
+static int dispc_ovl_calc_scaling_24xx(unsigned long pclk, unsigned long lclk,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
@@ -2141,7 +2141,6 @@ static int dispc_ovl_calc_scaling_24xx(enum omap_plane plane,
 	int min_factor = min(*decim_x, *decim_y);
 	const int maxsinglelinewidth =
 			dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
-	unsigned long pclk = dispc_plane_pclk_rate(plane);
 
 	*five_taps = false;
 
@@ -2171,7 +2170,7 @@ static int dispc_ovl_calc_scaling_24xx(enum omap_plane plane,
 	return 0;
 }
 
-static int dispc_ovl_calc_scaling_34xx(enum omap_plane plane,
+static int dispc_ovl_calc_scaling_34xx(unsigned long pclk, unsigned long lclk,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
@@ -2183,8 +2182,6 @@ static int dispc_ovl_calc_scaling_34xx(enum omap_plane plane,
 	int min_factor = min(*decim_x, *decim_y);
 	const int maxsinglelinewidth =
 			dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
-	unsigned long pclk = dispc_plane_pclk_rate(plane);
-	unsigned long lclk = dispc_plane_lclk_rate(plane);
 
 	do {
 		in_height = DIV_ROUND_UP(height, *decim_y);
@@ -2239,7 +2236,7 @@ static int dispc_ovl_calc_scaling_34xx(enum omap_plane plane,
 	return 0;
 }
 
-static int dispc_ovl_calc_scaling_44xx(enum omap_plane plane,
+static int dispc_ovl_calc_scaling_44xx(unsigned long pclk, unsigned long lclk,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
@@ -2252,7 +2249,6 @@ static int dispc_ovl_calc_scaling_44xx(enum omap_plane plane,
 	const int maxsinglelinewidth =
 				dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
 	const int maxdownscale = dss_feat_get_param_max(FEAT_PARAM_DOWNSCALE);
-	unsigned long pclk = dispc_plane_pclk_rate(plane);
 
 	if (mem_to_mem) {
 		in_width_max = out_width * maxdownscale;
@@ -2294,6 +2290,8 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 	const int max_decim_limit = 16;
 	unsigned long core_clk = 0;
 	int decim_x, decim_y, ret;
+	unsigned long pclk = dispc_plane_pclk_rate(plane);
+	unsigned long lclk = dispc_plane_lclk_rate(plane);
 
 	if (width == out_width && height == out_height)
 		return 0;
@@ -2329,7 +2327,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 	if (decim_y > *y_predecim || out_height > height * 8)
 		return -EINVAL;
 
-	ret = dispc.feat->calc_scaling(plane, mgr_timings, width, height,
+	ret = dispc.feat->calc_scaling(pclk, lclk, mgr_timings, width, height,
 		out_width, out_height, color_mode, five_taps,
 		x_predecim, y_predecim, &decim_x, &decim_y, pos_x, &core_clk,
 		mem_to_mem);
-- 
1.7.10.4

