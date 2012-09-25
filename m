From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 06/18] OMAPDSS: DISPC: Don't pass channel out when configuring overlays
Date: Tue, 25 Sep 2012 11:49:41 +0530
Message-ID: <1348553993-8083-7-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
 <1348553993-8083-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48589 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753161Ab2IYGUP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 02:20:15 -0400
In-Reply-To: <1348553993-8083-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

dispc_ovl_setup_common() is to be used by both overlays and writeback. We pass
channel out to figure out what manager the overlay is connected to, to determine
the pixel clock rate. This is used to decide the scaling limitations for that
overlay.

writeback doesn't have a channel out, it has a channel in field which tells
where writeback gets its input from. These are 2 different fields, and this
prevents us reusing the overlay configuration code for writeback.

To overcome this, we now pass omap_plane to overlay related functions rather
than passing channel out. We create helper functions which can derive pclk/lclk
from the omap_plane id.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  115 ++++++++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 49 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 782de44..edb31fd 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -86,13 +86,13 @@ struct dispc_features {
 	u16 sw_max;
 	u16 vp_max;
 	u16 hp_max;
-	int (*calc_scaling) (enum omap_channel channel,
+	int (*calc_scaling) (enum omap_plane plane,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
 		int *x_predecim, int *y_predecim, int *decim_x, int *decim_y,
 		u16 pos_x, unsigned long *core_clk);
-	unsigned long (*calc_core_clk) (enum omap_channel channel,
+	unsigned long (*calc_core_clk) (enum omap_plane plane,
 		u16 width, u16 height, u16 out_width, u16 out_height);
 	u8 num_fifos;
 
@@ -236,6 +236,8 @@ static const struct {
 };
 
 static void _omap_dispc_set_irqs(void);
+static unsigned long dispc_plane_pclk_rate(enum omap_plane plane);
+static unsigned long dispc_plane_lclk_rate(enum omap_plane plane);
 
 static inline void dispc_write_reg(const u16 idx, u32 val)
 {
@@ -1919,22 +1921,19 @@ static void calc_tiler_rotation_offset(u16 screen_width, u16 width,
  * This function is used to avoid synclosts in OMAP3, because of some
  * undocumented horizontal position and timing related limitations.
  */
-static int check_horiz_timing_omap3(enum omap_channel channel,
+static int check_horiz_timing_omap3(enum omap_plane plane,
 		const struct omap_video_timings *t, u16 pos_x,
 		u16 width, u16 height, u16 out_width, u16 out_height)
 {
 	int DS = DIV_ROUND_UP(height, out_height);
-	unsigned long nonactive, lclk, pclk;
+	unsigned long nonactive;
 	static const u8 limits[3] = { 8, 10, 20 };
 	u64 val, blank;
+	unsigned long pclk = dispc_plane_pclk_rate(plane);
+	unsigned long lclk = dispc_plane_lclk_rate(plane);
 	int i;
 
 	nonactive = t->x_res + t->hfp + t->hsw + t->hbp - out_width;
-	pclk = dispc_mgr_pclk_rate(channel);
-	if (dss_mgr_is_lcd(channel))
-		lclk = dispc_mgr_lclk_rate(channel);
-	else
-		lclk = dispc_fclk_rate();
 
 	i = 0;
 	if (out_height < height)
@@ -1971,13 +1970,14 @@ static int check_horiz_timing_omap3(enum omap_channel channel,
 	return 0;
 }
 
-static unsigned long calc_core_clk_five_taps(enum omap_channel channel,
+static unsigned long calc_core_clk_five_taps(enum omap_plane plane,
 		const struct omap_video_timings *mgr_timings, u16 width,
 		u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode)
 {
 	u32 core_clk = 0;
-	u64 tmp, pclk = dispc_mgr_pclk_rate(channel);
+	u64 tmp;
+	unsigned long pclk = dispc_plane_pclk_rate(plane);
 
 	if (height <= out_height && width <= out_width)
 		return (unsigned long) pclk;
@@ -2011,10 +2011,10 @@ static unsigned long calc_core_clk_five_taps(enum omap_channel channel,
 	return core_clk;
 }
 
-static unsigned long calc_core_clk_24xx(enum omap_channel channel, u16 width,
+static unsigned long calc_core_clk_24xx(enum omap_plane plane, u16 width,
 		u16 height, u16 out_width, u16 out_height)
 {
-	unsigned long pclk = dispc_mgr_pclk_rate(channel);
+	unsigned long pclk = dispc_plane_pclk_rate(plane);
 
 	if (height > out_height && width > out_width)
 		return pclk * 4;
@@ -2022,11 +2022,11 @@ static unsigned long calc_core_clk_24xx(enum omap_channel channel, u16 width,
 		return pclk * 2;
 }
 
-static unsigned long calc_core_clk_34xx(enum omap_channel channel, u16 width,
+static unsigned long calc_core_clk_34xx(enum omap_plane plane, u16 width,
 		u16 height, u16 out_width, u16 out_height)
 {
 	unsigned int hf, vf;
-	unsigned long pclk = dispc_mgr_pclk_rate(channel);
+	unsigned long pclk = dispc_plane_pclk_rate(plane);
 
 	/*
 	 * FIXME how to determine the 'A' factor
@@ -2049,10 +2049,10 @@ static unsigned long calc_core_clk_34xx(enum omap_channel channel, u16 width,
 	return pclk * vf * hf;
 }
 
-static unsigned long calc_core_clk_44xx(enum omap_channel channel, u16 width,
+static unsigned long calc_core_clk_44xx(enum omap_plane plane, u16 width,
 		u16 height, u16 out_width, u16 out_height)
 {
-	unsigned long pclk = dispc_mgr_pclk_rate(channel);
+	unsigned long pclk = dispc_plane_pclk_rate(plane);
 
 	if (width > out_width)
 		return DIV_ROUND_UP(pclk, out_width) * width;
@@ -2060,7 +2060,7 @@ static unsigned long calc_core_clk_44xx(enum omap_channel channel, u16 width,
 		return pclk;
 }
 
-static int dispc_ovl_calc_scaling_24xx(enum omap_channel channel,
+static int dispc_ovl_calc_scaling_24xx(enum omap_plane plane,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
@@ -2072,12 +2072,13 @@ static int dispc_ovl_calc_scaling_24xx(enum omap_channel channel,
 	int min_factor = min(*decim_x, *decim_y);
 	const int maxsinglelinewidth =
 			dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
+
 	*five_taps = false;
 
 	do {
 		in_height = DIV_ROUND_UP(height, *decim_y);
 		in_width = DIV_ROUND_UP(width, *decim_x);
-		*core_clk = dispc.feat->calc_core_clk(channel, in_width,
+		*core_clk = dispc.feat->calc_core_clk(plane, in_width,
 				in_height, out_width, out_height);
 		error = (in_width > maxsinglelinewidth || !*core_clk ||
 			*core_clk > dispc_core_clk_rate());
@@ -2100,7 +2101,7 @@ static int dispc_ovl_calc_scaling_24xx(enum omap_channel channel,
 	return 0;
 }
 
-static int dispc_ovl_calc_scaling_34xx(enum omap_channel channel,
+static int dispc_ovl_calc_scaling_34xx(enum omap_plane plane,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
@@ -2116,18 +2117,19 @@ static int dispc_ovl_calc_scaling_34xx(enum omap_channel channel,
 	do {
 		in_height = DIV_ROUND_UP(height, *decim_y);
 		in_width = DIV_ROUND_UP(width, *decim_x);
-		*core_clk = calc_core_clk_five_taps(channel, mgr_timings,
+		*core_clk = calc_core_clk_five_taps(plane, mgr_timings,
 			in_width, in_height, out_width, out_height, color_mode);
 
-		error = check_horiz_timing_omap3(channel, mgr_timings, pos_x,
-			in_width, in_height, out_width, out_height);
+		error = check_horiz_timing_omap3(plane, mgr_timings,
+				pos_x, in_width, in_height, out_width,
+				out_height);
 
 		if (in_width > maxsinglelinewidth)
 			if (in_height > out_height &&
 						in_height < out_height * 2)
 				*five_taps = false;
 		if (!*five_taps)
-			*core_clk = dispc.feat->calc_core_clk(channel, in_width,
+			*core_clk = dispc.feat->calc_core_clk(plane, in_width,
 					in_height, out_width, out_height);
 
 		error = (error || in_width > maxsinglelinewidth * 2 ||
@@ -2145,7 +2147,7 @@ static int dispc_ovl_calc_scaling_34xx(enum omap_channel channel,
 		}
 	} while (*decim_x <= *x_predecim && *decim_y <= *y_predecim && error);
 
-	if (check_horiz_timing_omap3(channel, mgr_timings, pos_x, width, height,
+	if (check_horiz_timing_omap3(plane, mgr_timings, pos_x, width, height,
 		out_width, out_height)){
 			DSSERR("horizontal timing too tight\n");
 			return -EINVAL;
@@ -2164,7 +2166,7 @@ static int dispc_ovl_calc_scaling_34xx(enum omap_channel channel,
 	return 0;
 }
 
-static int dispc_ovl_calc_scaling_44xx(enum omap_channel channel,
+static int dispc_ovl_calc_scaling_44xx(enum omap_plane plane,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
@@ -2176,9 +2178,10 @@ static int dispc_ovl_calc_scaling_44xx(enum omap_channel channel,
 	u16 in_height = DIV_ROUND_UP(height, *decim_y);
 	const int maxsinglelinewidth =
 				dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
+	unsigned long pclk = dispc_plane_pclk_rate(plane);
+
+	in_width_max = dispc_core_clk_rate() / DIV_ROUND_UP(pclk, out_width);
 
-	in_width_max = dispc_core_clk_rate() /
-			DIV_ROUND_UP(dispc_mgr_pclk_rate(channel), out_width);
 	*decim_x = DIV_ROUND_UP(width, in_width_max);
 
 	*decim_x = *decim_x > decim_x_min ? *decim_x : decim_x_min;
@@ -2195,13 +2198,13 @@ static int dispc_ovl_calc_scaling_44xx(enum omap_channel channel,
 		return -EINVAL;
 	}
 
-	*core_clk = dispc.feat->calc_core_clk(channel, in_width, in_height,
+	*core_clk = dispc.feat->calc_core_clk(plane, in_width, in_height,
 				out_width, out_height);
 	return 0;
 }
 
 static int dispc_ovl_calc_scaling(enum omap_plane plane,
-		enum omap_overlay_caps caps, enum omap_channel channel,
+		enum omap_overlay_caps caps,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
@@ -2240,9 +2243,9 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 	if (decim_y > *y_predecim || out_height > height * 8)
 		return -EINVAL;
 
-	ret = dispc.feat->calc_scaling(channel, mgr_timings, width, height,
-		out_width, out_height, color_mode, five_taps, x_predecim,
-		y_predecim, &decim_x, &decim_y, pos_x, &core_clk);
+	ret = dispc.feat->calc_scaling(plane, mgr_timings, width, height,
+		out_width, out_height, color_mode, five_taps,
+		x_predecim, y_predecim, &decim_x, &decim_y, pos_x, &core_clk);
 	if (ret)
 		return ret;
 
@@ -2263,12 +2266,11 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 }
 
 static int dispc_ovl_setup_common(enum omap_plane plane,
-		enum omap_channel channel, enum omap_overlay_caps caps,
-		u32 paddr, u32 p_uv_addr, u16 screen_width, int pos_x,
-		int pos_y, u16 width, u16 height, u16 out_width, u16 out_height,
-		enum omap_color_mode color_mode, u8 rotation, bool mirror,
-		u8 zorder, u8 pre_mult_alpha, u8 global_alpha,
-		enum omap_dss_rotation_type rotation_type,
+		enum omap_overlay_caps caps, u32 paddr, u32 p_uv_addr,
+		u16 screen_width, int pos_x, int pos_y, u16 width, u16 height,
+		u16 out_width, u16 out_height, enum omap_color_mode color_mode,
+		u8 rotation, bool mirror, u8 zorder, u8 pre_mult_alpha,
+		u8 global_alpha, enum omap_dss_rotation_type rotation_type,
 		bool replication, const struct omap_video_timings *mgr_timings)
 {
 	bool five_taps = true;
@@ -2307,10 +2309,9 @@ static int dispc_ovl_setup_common(enum omap_plane plane,
 	if (!dss_feat_color_mode_supported(plane, color_mode))
 		return -EINVAL;
 
-	r = dispc_ovl_calc_scaling(plane, caps, channel, mgr_timings,
-			in_width, in_height, out_width, out_height,
-			color_mode, &five_taps, &x_predecim, &y_predecim,
-			pos_x);
+	r = dispc_ovl_calc_scaling(plane, caps, mgr_timings, in_width,
+			in_height, out_width, out_height, color_mode,
+			&five_taps, &x_predecim, &y_predecim, pos_x);
 	if (r)
 		return r;
 
@@ -2422,12 +2423,11 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 		oi->pos_y, oi->width, oi->height, oi->out_width, oi->out_height,
 		oi->color_mode, oi->rotation, oi->mirror, channel, replication);
 
-	r = dispc_ovl_setup_common(plane, channel, ovl->caps, oi->paddr,
-		oi->p_uv_addr, oi->screen_width, oi->pos_x, oi->pos_y,
-		oi->width, oi->height, oi->out_width, oi->out_height,
-		oi->color_mode, oi->rotation, oi->mirror, oi->zorder,
-		oi->pre_mult_alpha, oi->global_alpha, oi->rotation_type,
-		replication, mgr_timings);
+	r = dispc_ovl_setup_common(plane, ovl->caps, oi->paddr, oi->p_uv_addr,
+		oi->screen_width, oi->pos_x, oi->pos_y, oi->width, oi->height,
+		oi->out_width, oi->out_height, oi->color_mode, oi->rotation,
+		oi->mirror, oi->zorder, oi->pre_mult_alpha, oi->global_alpha,
+		oi->rotation_type, replication, mgr_timings);
 
 	return r;
 }
@@ -2987,6 +2987,23 @@ unsigned long dispc_core_clk_rate(void)
 	return fclk / lcd;
 }
 
+static unsigned long dispc_plane_pclk_rate(enum omap_plane plane)
+{
+	enum omap_channel channel = dispc_ovl_get_channel_out(plane);
+
+	return dispc_mgr_pclk_rate(channel);
+}
+
+static unsigned long dispc_plane_lclk_rate(enum omap_plane plane)
+{
+	enum omap_channel channel = dispc_ovl_get_channel_out(plane);
+
+	if (dss_mgr_is_lcd(channel))
+		return dispc_mgr_lclk_rate(channel);
+	else
+		return dispc_fclk_rate();
+
+}
 static void dispc_dump_clocks_channel(struct seq_file *s, enum omap_channel channel)
 {
 	int lcd, pcd;
-- 
1.7.9.5

