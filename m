From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/32] OMAPDSS: DISPC: pass pclk & lclk to dispc_ovl_calc_scaling
Date: Thu, 15 Nov 2012 17:58:21 +0200
Message-ID: <1352995120-3288-14-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52173 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768251Ab2KOP7b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 10:59:31 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

In order to make the scaling calculations independent of the current
hardware configuration (e.g. which manager is connected to this output),
we need to change the calc funcs to get all the variables needed for the
calculations via parameters.

This patch changes dispc_ovl_calc_scaling to get pclk and lclk as
parameters.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 155085a..f30cdfc 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2278,7 +2278,7 @@ static int dispc_ovl_calc_scaling_44xx(unsigned long pclk, unsigned long lclk,
 	return 0;
 }
 
-static int dispc_ovl_calc_scaling(enum omap_plane plane,
+static int dispc_ovl_calc_scaling(unsigned long pclk, unsigned long lclk,
 		enum omap_overlay_caps caps,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
@@ -2290,8 +2290,6 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 	const int max_decim_limit = 16;
 	unsigned long core_clk = 0;
 	int decim_x, decim_y, ret;
-	unsigned long pclk = dispc_plane_pclk_rate(plane);
-	unsigned long lclk = dispc_plane_lclk_rate(plane);
 
 	if (width == out_width && height == out_height)
 		return 0;
@@ -2299,7 +2297,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 	if ((caps & OMAP_DSS_OVL_CAP_SCALE) == 0)
 		return -EINVAL;
 
-	if (plane == OMAP_DSS_WB) {
+	if (mem_to_mem) {
 		*x_predecim = *y_predecim = 1;
 	} else {
 		*x_predecim = max_decim_limit;
@@ -2371,6 +2369,8 @@ static int dispc_ovl_setup_common(enum omap_plane plane,
 	u16 in_width = width;
 	int x_predecim = 1, y_predecim = 1;
 	bool ilace = mgr_timings->interlace;
+	unsigned long pclk = dispc_plane_pclk_rate(plane);
+	unsigned long lclk = dispc_plane_lclk_rate(plane);
 
 	if (paddr == 0)
 		return -EINVAL;
@@ -2395,7 +2395,7 @@ static int dispc_ovl_setup_common(enum omap_plane plane,
 	if (!dss_feat_color_mode_supported(plane, color_mode))
 		return -EINVAL;
 
-	r = dispc_ovl_calc_scaling(plane, caps, mgr_timings, in_width,
+	r = dispc_ovl_calc_scaling(pclk, lclk, caps, mgr_timings, in_width,
 			in_height, out_width, out_height, color_mode,
 			&five_taps, &x_predecim, &y_predecim, pos_x,
 			rotation_type, mem_to_mem);
-- 
1.7.10.4

