From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/32] OMAPDSS: DISPC: pass pclk to calc_core_clk()
Date: Thu, 15 Nov 2012 17:58:18 +0200
Message-ID: <1352995120-3288-11-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59119 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768236Ab2KOP70 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 10:59:26 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

In order to make the scaling calculations independent of the current
hardware configuration (e.g. which manager is connected to this output),
we need to change the calc funcs to get all the variables needed for the
calculations via parameters.

This patch changes calc_core_clk() function to get pclk as a parameter.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 8f8d628..3025792 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -93,7 +93,7 @@ struct dispc_features {
 		enum omap_color_mode color_mode, bool *five_taps,
 		int *x_predecim, int *y_predecim, int *decim_x, int *decim_y,
 		u16 pos_x, unsigned long *core_clk, bool mem_to_mem);
-	unsigned long (*calc_core_clk) (enum omap_plane plane,
+	unsigned long (*calc_core_clk) (unsigned long pclk,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		bool mem_to_mem);
 	u8 num_fifos;
@@ -2038,14 +2038,13 @@ static int check_horiz_timing_omap3(enum omap_plane plane,
 	return 0;
 }
 
-static unsigned long calc_core_clk_five_taps(enum omap_plane plane,
+static unsigned long calc_core_clk_five_taps(unsigned long pclk,
 		const struct omap_video_timings *mgr_timings, u16 width,
 		u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode)
 {
 	u32 core_clk = 0;
 	u64 tmp;
-	unsigned long pclk = dispc_plane_pclk_rate(plane);
 
 	if (height <= out_height && width <= out_width)
 		return (unsigned long) pclk;
@@ -2079,22 +2078,19 @@ static unsigned long calc_core_clk_five_taps(enum omap_plane plane,
 	return core_clk;
 }
 
-static unsigned long calc_core_clk_24xx(enum omap_plane plane, u16 width,
+static unsigned long calc_core_clk_24xx(unsigned long pclk, u16 width,
 		u16 height, u16 out_width, u16 out_height, bool mem_to_mem)
 {
-	unsigned long pclk = dispc_plane_pclk_rate(plane);
-
 	if (height > out_height && width > out_width)
 		return pclk * 4;
 	else
 		return pclk * 2;
 }
 
-static unsigned long calc_core_clk_34xx(enum omap_plane plane, u16 width,
+static unsigned long calc_core_clk_34xx(unsigned long pclk, u16 width,
 		u16 height, u16 out_width, u16 out_height, bool mem_to_mem)
 {
 	unsigned int hf, vf;
-	unsigned long pclk = dispc_plane_pclk_rate(plane);
 
 	/*
 	 * FIXME how to determine the 'A' factor
@@ -2117,11 +2113,9 @@ static unsigned long calc_core_clk_34xx(enum omap_plane plane, u16 width,
 	return pclk * vf * hf;
 }
 
-static unsigned long calc_core_clk_44xx(enum omap_plane plane, u16 width,
+static unsigned long calc_core_clk_44xx(unsigned long pclk, u16 width,
 		u16 height, u16 out_width, u16 out_height, bool mem_to_mem)
 {
-	unsigned long pclk;
-
 	/*
 	 * If the overlay/writeback is in mem to mem mode, there are no
 	 * downscaling limitations with respect to pixel clock, return 1 as
@@ -2131,8 +2125,6 @@ static unsigned long calc_core_clk_44xx(enum omap_plane plane, u16 width,
 	if (mem_to_mem)
 		return 1;
 
-	pclk = dispc_plane_pclk_rate(plane);
-
 	if (width > out_width)
 		return DIV_ROUND_UP(pclk, out_width) * width;
 	else
@@ -2151,13 +2143,14 @@ static int dispc_ovl_calc_scaling_24xx(enum omap_plane plane,
 	int min_factor = min(*decim_x, *decim_y);
 	const int maxsinglelinewidth =
 			dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
+	unsigned long pclk = dispc_plane_pclk_rate(plane);
 
 	*five_taps = false;
 
 	do {
 		in_height = DIV_ROUND_UP(height, *decim_y);
 		in_width = DIV_ROUND_UP(width, *decim_x);
-		*core_clk = dispc.feat->calc_core_clk(plane, in_width,
+		*core_clk = dispc.feat->calc_core_clk(pclk, in_width,
 				in_height, out_width, out_height, mem_to_mem);
 		error = (in_width > maxsinglelinewidth || !*core_clk ||
 			*core_clk > dispc_core_clk_rate());
@@ -2192,11 +2185,12 @@ static int dispc_ovl_calc_scaling_34xx(enum omap_plane plane,
 	int min_factor = min(*decim_x, *decim_y);
 	const int maxsinglelinewidth =
 			dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
+	unsigned long pclk = dispc_plane_pclk_rate(plane);
 
 	do {
 		in_height = DIV_ROUND_UP(height, *decim_y);
 		in_width = DIV_ROUND_UP(width, *decim_x);
-		*core_clk = calc_core_clk_five_taps(plane, mgr_timings,
+		*core_clk = calc_core_clk_five_taps(pclk, mgr_timings,
 			in_width, in_height, out_width, out_height, color_mode);
 
 		error = check_horiz_timing_omap3(plane, mgr_timings,
@@ -2208,7 +2202,7 @@ static int dispc_ovl_calc_scaling_34xx(enum omap_plane plane,
 						in_height < out_height * 2)
 				*five_taps = false;
 		if (!*five_taps)
-			*core_clk = dispc.feat->calc_core_clk(plane, in_width,
+			*core_clk = dispc.feat->calc_core_clk(pclk, in_width,
 					in_height, out_width, out_height,
 					mem_to_mem);
 
@@ -2259,12 +2253,11 @@ static int dispc_ovl_calc_scaling_44xx(enum omap_plane plane,
 	const int maxsinglelinewidth =
 				dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
 	const int maxdownscale = dss_feat_get_param_max(FEAT_PARAM_DOWNSCALE);
+	unsigned long pclk = dispc_plane_pclk_rate(plane);
 
 	if (mem_to_mem) {
 		in_width_max = out_width * maxdownscale;
 	} else {
-		unsigned long pclk = dispc_plane_pclk_rate(plane);
-
 		in_width_max = dispc_core_clk_rate() /
 					DIV_ROUND_UP(pclk, out_width);
 	}
@@ -2285,7 +2278,7 @@ static int dispc_ovl_calc_scaling_44xx(enum omap_plane plane,
 		return -EINVAL;
 	}
 
-	*core_clk = dispc.feat->calc_core_clk(plane, in_width, in_height,
+	*core_clk = dispc.feat->calc_core_clk(pclk, in_width, in_height,
 				out_width, out_height, mem_to_mem);
 	return 0;
 }
-- 
1.7.10.4

