From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 07/18] OMAPDSS: DIPSC: Relax scaling limitations when in memory to memory mode
Date: Tue, 25 Sep 2012 11:49:42 +0530
Message-ID: <1348553993-8083-8-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
 <1348553993-8083-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41902 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172Ab2IYGUS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 02:20:18 -0400
In-Reply-To: <1348553993-8083-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The scalers of overlays and writeback do not have any constraints on downscale
ratio when operating in memory to memory mode.

This is because in memory to memory mode, we aren't connected to a display which
needs data output at the rate of pixel clock. The scalers can perform as much
downscaling as needed, the rate at which the scaler outputs is adjusted
accordingly.

Relax constraints related to downscaling based on whether the input overlays are
connected to writeback in memory to memory mode. We pass a mem_to_mem boolean
parameter to dispc_ovl_setup() from APPLY. This is currently set to false, this
will later be configured to the correct value based on whether the overlay is
connected to writeback or not. Do the same later for writeback when writeback is
configured.

In the scaling calculation code, we calculate the minimum amount of core clock we
need to achieve the required downscaling. If we are in memory to memory mode, we
set this to a very small value(1 in this case), this value would always be
lesser than the actual DISPC core clock value, and hence the scaling checks
would succeed.

We take care that pixel clock isn't calculated for writeback and the overlays
connected to it when in memory to memory mode. A pixel clock in such cases
doesn't make sense.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |    2 +-
 drivers/video/omap2/dss/dispc.c |   60 ++++++++++++++++++++++++++-------------
 drivers/video/omap2/dss/dss.h   |    3 +-
 3 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 2b1fa85..19d66f4 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -584,7 +584,7 @@ static void dss_ovl_write_regs(struct omap_overlay *ovl)
 
 	replication = dss_ovl_use_replication(mp->lcd_config, oi->color_mode);
 
-	r = dispc_ovl_setup(ovl->id, oi, replication, &mp->timings);
+	r = dispc_ovl_setup(ovl->id, oi, replication, &mp->timings, false);
 	if (r) {
 		/*
 		 * We can't do much here, as this function can be called from
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index edb31fd..ba65ebd 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -91,9 +91,10 @@ struct dispc_features {
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
 		int *x_predecim, int *y_predecim, int *decim_x, int *decim_y,
-		u16 pos_x, unsigned long *core_clk);
+		u16 pos_x, unsigned long *core_clk, bool mem_to_mem);
 	unsigned long (*calc_core_clk) (enum omap_plane plane,
-		u16 width, u16 height, u16 out_width, u16 out_height);
+		u16 width, u16 height, u16 out_width, u16 out_height,
+		bool mem_to_mem);
 	u8 num_fifos;
 
 	/* swap GFX & WB fifos */
@@ -2012,7 +2013,7 @@ static unsigned long calc_core_clk_five_taps(enum omap_plane plane,
 }
 
 static unsigned long calc_core_clk_24xx(enum omap_plane plane, u16 width,
-		u16 height, u16 out_width, u16 out_height)
+		u16 height, u16 out_width, u16 out_height, bool mem_to_mem)
 {
 	unsigned long pclk = dispc_plane_pclk_rate(plane);
 
@@ -2023,7 +2024,7 @@ static unsigned long calc_core_clk_24xx(enum omap_plane plane, u16 width,
 }
 
 static unsigned long calc_core_clk_34xx(enum omap_plane plane, u16 width,
-		u16 height, u16 out_width, u16 out_height)
+		u16 height, u16 out_width, u16 out_height, bool mem_to_mem)
 {
 	unsigned int hf, vf;
 	unsigned long pclk = dispc_plane_pclk_rate(plane);
@@ -2050,9 +2051,20 @@ static unsigned long calc_core_clk_34xx(enum omap_plane plane, u16 width,
 }
 
 static unsigned long calc_core_clk_44xx(enum omap_plane plane, u16 width,
-		u16 height, u16 out_width, u16 out_height)
+		u16 height, u16 out_width, u16 out_height, bool mem_to_mem)
 {
-	unsigned long pclk = dispc_plane_pclk_rate(plane);
+	unsigned long pclk;
+
+	/*
+	 * If the overlay/writeback is in mem to mem mode, there are no
+	 * downscaling limitations with respect to pixel clock, return 1 as
+	 * required core clock to represent that we have sufficient enough
+	 * core clock to do maximum downscaling
+	 */
+	if (mem_to_mem)
+		return 1;
+
+	pclk = dispc_plane_pclk_rate(plane);
 
 	if (width > out_width)
 		return DIV_ROUND_UP(pclk, out_width) * width;
@@ -2065,7 +2077,7 @@ static int dispc_ovl_calc_scaling_24xx(enum omap_plane plane,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
 		int *x_predecim, int *y_predecim, int *decim_x, int *decim_y,
-		u16 pos_x, unsigned long *core_clk)
+		u16 pos_x, unsigned long *core_clk, bool mem_to_mem)
 {
 	int error;
 	u16 in_width, in_height;
@@ -2079,7 +2091,7 @@ static int dispc_ovl_calc_scaling_24xx(enum omap_plane plane,
 		in_height = DIV_ROUND_UP(height, *decim_y);
 		in_width = DIV_ROUND_UP(width, *decim_x);
 		*core_clk = dispc.feat->calc_core_clk(plane, in_width,
-				in_height, out_width, out_height);
+				in_height, out_width, out_height, mem_to_mem);
 		error = (in_width > maxsinglelinewidth || !*core_clk ||
 			*core_clk > dispc_core_clk_rate());
 		if (error) {
@@ -2106,7 +2118,7 @@ static int dispc_ovl_calc_scaling_34xx(enum omap_plane plane,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
 		int *x_predecim, int *y_predecim, int *decim_x, int *decim_y,
-		u16 pos_x, unsigned long *core_clk)
+		u16 pos_x, unsigned long *core_clk, bool mem_to_mem)
 {
 	int error;
 	u16 in_width, in_height;
@@ -2130,7 +2142,8 @@ static int dispc_ovl_calc_scaling_34xx(enum omap_plane plane,
 				*five_taps = false;
 		if (!*five_taps)
 			*core_clk = dispc.feat->calc_core_clk(plane, in_width,
-					in_height, out_width, out_height);
+					in_height, out_width, out_height,
+					mem_to_mem);
 
 		error = (error || in_width > maxsinglelinewidth * 2 ||
 			(in_width > maxsinglelinewidth && *five_taps) ||
@@ -2171,7 +2184,7 @@ static int dispc_ovl_calc_scaling_44xx(enum omap_plane plane,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
 		int *x_predecim, int *y_predecim, int *decim_x, int *decim_y,
-		u16 pos_x, unsigned long *core_clk)
+		u16 pos_x, unsigned long *core_clk, bool mem_to_mem)
 {
 	u16 in_width, in_width_max;
 	int decim_x_min = *decim_x;
@@ -2179,8 +2192,13 @@ static int dispc_ovl_calc_scaling_44xx(enum omap_plane plane,
 	const int maxsinglelinewidth =
 				dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
 	unsigned long pclk = dispc_plane_pclk_rate(plane);
+	const int maxdownscale = dss_feat_get_param_max(FEAT_PARAM_DOWNSCALE);
 
-	in_width_max = dispc_core_clk_rate() / DIV_ROUND_UP(pclk, out_width);
+	if (mem_to_mem)
+		in_width_max = DIV_ROUND_UP(out_width, maxdownscale);
+	else
+		in_width_max = dispc_core_clk_rate() /
+					DIV_ROUND_UP(pclk, out_width);
 
 	*decim_x = DIV_ROUND_UP(width, in_width_max);
 
@@ -2199,7 +2217,7 @@ static int dispc_ovl_calc_scaling_44xx(enum omap_plane plane,
 	}
 
 	*core_clk = dispc.feat->calc_core_clk(plane, in_width, in_height,
-				out_width, out_height);
+				out_width, out_height, mem_to_mem);
 	return 0;
 }
 
@@ -2208,7 +2226,7 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
-		int *x_predecim, int *y_predecim, u16 pos_x)
+		int *x_predecim, int *y_predecim, u16 pos_x, bool mem_to_mem)
 {
 	const int maxdownscale = dss_feat_get_param_max(FEAT_PARAM_DOWNSCALE);
 	const int max_decim_limit = 16;
@@ -2245,7 +2263,8 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 
 	ret = dispc.feat->calc_scaling(plane, mgr_timings, width, height,
 		out_width, out_height, color_mode, five_taps,
-		x_predecim, y_predecim, &decim_x, &decim_y, pos_x, &core_clk);
+		x_predecim, y_predecim, &decim_x, &decim_y, pos_x, &core_clk,
+		mem_to_mem);
 	if (ret)
 		return ret;
 
@@ -2271,7 +2290,8 @@ static int dispc_ovl_setup_common(enum omap_plane plane,
 		u16 out_width, u16 out_height, enum omap_color_mode color_mode,
 		u8 rotation, bool mirror, u8 zorder, u8 pre_mult_alpha,
 		u8 global_alpha, enum omap_dss_rotation_type rotation_type,
-		bool replication, const struct omap_video_timings *mgr_timings)
+		bool replication, const struct omap_video_timings *mgr_timings,
+		bool mem_to_mem)
 {
 	bool five_taps = true;
 	bool fieldmode = 0;
@@ -2311,7 +2331,8 @@ static int dispc_ovl_setup_common(enum omap_plane plane,
 
 	r = dispc_ovl_calc_scaling(plane, caps, mgr_timings, in_width,
 			in_height, out_width, out_height, color_mode,
-			&five_taps, &x_predecim, &y_predecim, pos_x);
+			&five_taps, &x_predecim, &y_predecim, pos_x,
+			mem_to_mem);
 	if (r)
 		return r;
 
@@ -2409,7 +2430,8 @@ static int dispc_ovl_setup_common(enum omap_plane plane,
 }
 
 int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
-		bool replication, const struct omap_video_timings *mgr_timings)
+		bool replication, const struct omap_video_timings *mgr_timings,
+		bool mem_to_mem)
 {
 	int r;
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
@@ -2427,7 +2449,7 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 		oi->screen_width, oi->pos_x, oi->pos_y, oi->width, oi->height,
 		oi->out_width, oi->out_height, oi->color_mode, oi->rotation,
 		oi->mirror, oi->zorder, oi->pre_mult_alpha, oi->global_alpha,
-		oi->rotation_type, replication, mgr_timings);
+		oi->rotation_type, replication, mgr_timings, mem_to_mem);
 
 	return r;
 }
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 43210b8..04a1eda 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -441,7 +441,8 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
 		u32 *fifo_low, u32 *fifo_high, bool use_fifomerge,
 		bool manual_update);
 int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
-		bool replication, const struct omap_video_timings *mgr_timings);
+		bool replication, const struct omap_video_timings *mgr_timings,
+		bool mem_to_mem);
 int dispc_ovl_enable(enum omap_plane plane, bool enable);
 void dispc_ovl_set_channel_out(enum omap_plane plane,
 		enum omap_channel channel);
-- 
1.7.9.5

