From: Archit Taneja <archit@ti.com>
Subject: [PATCH 09/21] OMAPDSS: DISPC: Calculate scaling limits in a more generic way
Date: Thu, 13 Sep 2012 17:44:53 +0530
Message-ID: <1347538505-25359-10-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52129 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757950Ab2IMMPa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 08:15:30 -0400
In-Reply-To: <1347538505-25359-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Scaling calculations for an overlay are done by comparing pixel clock of the
connected overlay manager and the core clock of DISPC. The pixel clock is the
output rate of the scalar. The scalar block needs to provide pixels at this rate
since the manager is connected to a panel, which has real time constraints.

In the case of writeback in memory to memory mode, the output of the scalar
blocks aren't connected to a display, and hence there isn't a pixel clock which
causes downscaling limitations.

Make the input to scaling calculations a bit more generic by passing the scalar
output rate rather than passing pixel clock of the overlay manager connected to
the pipeline, as we now have use cases where the scalar's output may not go to
a manager connected to a panel.

This also helps us in replacing omap_channel arguments with output_rate, making
dispc_plane_setup more pipeline specific.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  126 ++++++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 54 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index e6d8b77..58cb06c 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -86,13 +86,13 @@ struct dispc_features {
 	u16 sw_max;
 	u16 vp_max;
 	u16 hp_max;
-	int (*calc_scaling) (enum omap_channel channel,
+	int (*calc_scaling) (enum omap_plane plane, unsigned long out_rate,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
 		int *x_predecim, int *y_predecim, int *decim_x, int *decim_y,
 		u16 pos_x, unsigned long *core_clk);
-	unsigned long (*calc_core_clk) (enum omap_channel channel,
+	unsigned long (*calc_core_clk) (unsigned long out_rate,
 		u16 width, u16 height, u16 out_width, u16 out_height);
 	u8 num_fifos;
 
@@ -236,6 +236,8 @@ static const struct {
 };
 
 static void _omap_dispc_set_irqs(void);
+static unsigned long dispc_plane_output_rate(enum omap_plane plane);
+static unsigned long dispc_plane_lclk_rate(enum omap_plane plane);
 
 static inline void dispc_write_reg(const u16 idx, u32 val)
 {
@@ -1925,29 +1927,25 @@ static void calc_tiler_rotation_offset(u16 screen_width, u16 width,
  * This function is used to avoid synclosts in OMAP3, because of some
  * undocumented horizontal position and timing related limitations.
  */
-static int check_horiz_timing_omap3(enum omap_channel channel,
-		const struct omap_video_timings *t, u16 pos_x,
-		u16 width, u16 height, u16 out_width, u16 out_height)
+static int check_horiz_timing_omap3(enum omap_plane plane,
+		unsigned long out_rate, const struct omap_video_timings *t,
+		u16 pos_x, u16 width, u16 height, u16 out_width, u16 out_height)
 {
 	int DS = DIV_ROUND_UP(height, out_height);
-	unsigned long nonactive, lclk, pclk;
+	unsigned long nonactive;
+	unsigned long lclk_rate = dispc_plane_lclk_rate(plane);
 	static const u8 limits[3] = { 8, 10, 20 };
 	u64 val, blank;
 	int i;
 
 	nonactive = t->x_res + t->hfp + t->hsw + t->hbp - out_width;
-	pclk = dispc_mgr_pclk_rate(channel);
-	if (dss_mgr_is_lcd(channel))
-		lclk = dispc_mgr_lclk_rate(channel);
-	else
-		lclk = dispc_fclk_rate();
 
 	i = 0;
 	if (out_height < height)
 		i++;
 	if (out_width < width)
 		i++;
-	blank = div_u64((u64)(t->hbp + t->hsw + t->hfp) * lclk, pclk);
+	blank = div_u64((u64)(t->hbp + t->hsw + t->hfp) * lclk_rate, out_rate);
 	DSSDBG("blanking period + ppl = %llu (limit = %u)\n", blank, limits[i]);
 	if (blank <= limits[i])
 		return -EINVAL;
@@ -1957,7 +1955,7 @@ static int check_horiz_timing_omap3(enum omap_channel channel,
 	 * So, atleast DS-2 lines must have already been fetched by DISPC
 	 * during nonactive - pos_x period.
 	 */
-	val = div_u64((u64)(nonactive - pos_x) * lclk, pclk);
+	val = div_u64((u64)(nonactive - pos_x) * lclk_rate, out_rate);
 	DSSDBG("(nonactive - pos_x) * pcd = %llu max(0, DS - 2) * width = %d\n",
 		val, max(0, DS - 2) * width);
 	if (val < max(0, DS - 2) * width)
@@ -1968,7 +1966,7 @@ static int check_horiz_timing_omap3(enum omap_channel channel,
 	 * only one line can be loaded during the active period. So, atleast
 	 * DS - 1 lines should be loaded during nonactive period.
 	 */
-	val =  div_u64((u64)nonactive * lclk, pclk);
+	val =  div_u64((u64)nonactive * lclk_rate, out_rate);
 	DSSDBG("nonactive * pcd  = %llu, max(0, DS - 1) * width = %d\n",
 		val, max(0, DS - 1) * width);
 	if (val < max(0, DS - 1) * width)
@@ -1977,21 +1975,21 @@ static int check_horiz_timing_omap3(enum omap_channel channel,
 	return 0;
 }
 
-static unsigned long calc_core_clk_five_taps(enum omap_channel channel,
+static unsigned long calc_core_clk_five_taps(unsigned long out_rate,
 		const struct omap_video_timings *mgr_timings, u16 width,
 		u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode)
 {
 	u32 core_clk = 0;
-	u64 tmp, pclk = dispc_mgr_pclk_rate(channel);
+	u64 tmp;
 
 	if (height <= out_height && width <= out_width)
-		return (unsigned long) pclk;
+		return (unsigned long) out_rate;
 
 	if (height > out_height) {
 		unsigned int ppl = mgr_timings->x_res;
 
-		tmp = pclk * height * out_width;
+		tmp = out_rate * height * out_width;
 		do_div(tmp, 2 * out_height * ppl);
 		core_clk = tmp;
 
@@ -1999,14 +1997,14 @@ static unsigned long calc_core_clk_five_taps(enum omap_channel channel,
 			if (ppl == out_width)
 				return 0;
 
-			tmp = pclk * (height - 2 * out_height) * out_width;
+			tmp = out_rate * (height - 2 * out_height) * out_width;
 			do_div(tmp, 2 * out_height * (ppl - out_width));
 			core_clk = max_t(u32, core_clk, tmp);
 		}
 	}
 
 	if (width > out_width) {
-		tmp = pclk * width;
+		tmp = out_rate * width;
 		do_div(tmp, out_width);
 		core_clk = max_t(u32, core_clk, tmp);
 
@@ -2017,22 +2015,19 @@ static unsigned long calc_core_clk_five_taps(enum omap_channel channel,
 	return core_clk;
 }
 
-static unsigned long calc_core_clk_24xx(enum omap_channel channel, u16 width,
+static unsigned long calc_core_clk_24xx(unsigned long out_rate, u16 width,
 		u16 height, u16 out_width, u16 out_height)
 {
-	unsigned long pclk = dispc_mgr_pclk_rate(channel);
-
 	if (height > out_height && width > out_width)
-		return pclk * 4;
+		return out_rate * 4;
 	else
-		return pclk * 2;
+		return out_rate * 2;
 }
 
-static unsigned long calc_core_clk_34xx(enum omap_channel channel, u16 width,
+static unsigned long calc_core_clk_34xx(unsigned long out_rate, u16 width,
 		u16 height, u16 out_width, u16 out_height)
 {
 	unsigned int hf, vf;
-	unsigned long pclk = dispc_mgr_pclk_rate(channel);
 
 	/*
 	 * FIXME how to determine the 'A' factor
@@ -2052,21 +2047,20 @@ static unsigned long calc_core_clk_34xx(enum omap_channel channel, u16 width,
 	else
 		vf = 1;
 
-	return pclk * vf * hf;
+	return out_rate * vf * hf;
 }
 
-static unsigned long calc_core_clk_44xx(enum omap_channel channel, u16 width,
+static unsigned long calc_core_clk_44xx(unsigned long out_rate, u16 width,
 		u16 height, u16 out_width, u16 out_height)
 {
-	unsigned long pclk = dispc_mgr_pclk_rate(channel);
-
 	if (width > out_width)
-		return DIV_ROUND_UP(pclk, out_width) * width;
+		return DIV_ROUND_UP(out_rate, out_width) * width;
 	else
-		return pclk;
+		return out_rate;
 }
 
-static int dispc_ovl_calc_scaling_24xx(enum omap_channel channel,
+static int dispc_ovl_calc_scaling_24xx(enum omap_plane plane,
+		unsigned long out_rate,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
@@ -2083,7 +2077,7 @@ static int dispc_ovl_calc_scaling_24xx(enum omap_channel channel,
 	do {
 		in_height = DIV_ROUND_UP(height, *decim_y);
 		in_width = DIV_ROUND_UP(width, *decim_x);
-		*core_clk = dispc.feat->calc_core_clk(channel, in_width,
+		*core_clk = dispc.feat->calc_core_clk(out_rate, in_width,
 				in_height, out_width, out_height);
 		error = (in_width > maxsinglelinewidth || !*core_clk ||
 			*core_clk > dispc_core_clk_rate());
@@ -2106,7 +2100,8 @@ static int dispc_ovl_calc_scaling_24xx(enum omap_channel channel,
 	return 0;
 }
 
-static int dispc_ovl_calc_scaling_34xx(enum omap_channel channel,
+static int dispc_ovl_calc_scaling_34xx(enum omap_plane plane,
+		unsigned long out_rate,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
@@ -2122,19 +2117,21 @@ static int dispc_ovl_calc_scaling_34xx(enum omap_channel channel,
 	do {
 		in_height = DIV_ROUND_UP(height, *decim_y);
 		in_width = DIV_ROUND_UP(width, *decim_x);
-		*core_clk = calc_core_clk_five_taps(channel, mgr_timings,
+		*core_clk = calc_core_clk_five_taps(out_rate, mgr_timings,
 			in_width, in_height, out_width, out_height, color_mode);
 
-		error = check_horiz_timing_omap3(channel, mgr_timings, pos_x,
-			in_width, in_height, out_width, out_height);
+		error = check_horiz_timing_omap3(plane, out_rate, mgr_timings,
+				pos_x, in_width, in_height, out_width,
+				out_height);
 
 		if (in_width > maxsinglelinewidth)
 			if (in_height > out_height &&
 						in_height < out_height * 2)
 				*five_taps = false;
 		if (!*five_taps)
-			*core_clk = dispc.feat->calc_core_clk(channel, in_width,
-					in_height, out_width, out_height);
+			*core_clk = dispc.feat->calc_core_clk(out_rate,
+					in_width, in_height, out_width,
+					out_height);
 
 		error = (error || in_width > maxsinglelinewidth * 2 ||
 			(in_width > maxsinglelinewidth && *five_taps) ||
@@ -2151,8 +2148,8 @@ static int dispc_ovl_calc_scaling_34xx(enum omap_channel channel,
 		}
 	} while (*decim_x <= *x_predecim && *decim_y <= *y_predecim && error);
 
-	if (check_horiz_timing_omap3(channel, mgr_timings, pos_x, width, height,
-		out_width, out_height)){
+	if (check_horiz_timing_omap3(plane, out_rate, mgr_timings, pos_x, width,
+		height, out_width, out_height)){
 			DSSERR("horizontal timing too tight\n");
 			return -EINVAL;
 	}
@@ -2170,7 +2167,8 @@ static int dispc_ovl_calc_scaling_34xx(enum omap_channel channel,
 	return 0;
 }
 
-static int dispc_ovl_calc_scaling_44xx(enum omap_channel channel,
+static int dispc_ovl_calc_scaling_44xx(enum omap_plane plane,
+		unsigned long out_rate,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
@@ -2184,7 +2182,7 @@ static int dispc_ovl_calc_scaling_44xx(enum omap_channel channel,
 				dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
 
 	in_width_max = dispc_core_clk_rate() /
-			DIV_ROUND_UP(dispc_mgr_pclk_rate(channel), out_width);
+			DIV_ROUND_UP(out_rate, out_width);
 	*decim_x = DIV_ROUND_UP(width, in_width_max);
 
 	*decim_x = *decim_x > decim_x_min ? *decim_x : decim_x_min;
@@ -2201,13 +2199,13 @@ static int dispc_ovl_calc_scaling_44xx(enum omap_channel channel,
 		return -EINVAL;
 	}
 
-	*core_clk = dispc.feat->calc_core_clk(channel, in_width, in_height,
+	*core_clk = dispc.feat->calc_core_clk(out_rate, in_width, in_height,
 				out_width, out_height);
 	return 0;
 }
 
 static int dispc_plane_calc_scaling(enum omap_plane plane,
-		enum omap_overlay_caps caps, enum omap_channel channel,
+		enum omap_overlay_caps caps, unsigned long out_rate,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
 		enum omap_color_mode color_mode, bool *five_taps,
@@ -2246,9 +2244,9 @@ static int dispc_plane_calc_scaling(enum omap_plane plane,
 	if (decim_y > *y_predecim || out_height > height * 8)
 		return -EINVAL;
 
-	ret = dispc.feat->calc_scaling(channel, mgr_timings, width, height,
-		out_width, out_height, color_mode, five_taps, x_predecim,
-		y_predecim, &decim_x, &decim_y, pos_x, &core_clk);
+	ret = dispc.feat->calc_scaling(plane, out_rate, mgr_timings, width,
+		height, out_width, out_height, color_mode, five_taps,
+		x_predecim, y_predecim, &decim_x, &decim_y, pos_x, &core_clk);
 	if (ret)
 		return ret;
 
@@ -2268,8 +2266,8 @@ static int dispc_plane_calc_scaling(enum omap_plane plane,
 	return 0;
 }
 
-static int dispc_plane_setup(enum omap_plane plane, enum omap_channel channel,
-		enum omap_overlay_caps caps, u32 paddr, u32 p_uv_addr,
+static int dispc_plane_setup(enum omap_plane plane, enum omap_overlay_caps caps,
+		unsigned long out_rate, u32 paddr, u32 p_uv_addr,
 		u16 screen_width, int pos_x, int pos_y, u16 width, u16 height,
 		u16 out_width, u16 out_height, enum omap_color_mode color_mode,
 		u8 rotation, bool mirror, u8 zorder, u8 pre_mult_alpha,
@@ -2312,7 +2310,7 @@ static int dispc_plane_setup(enum omap_plane plane, enum omap_channel channel,
 	if (!dss_feat_color_mode_supported(plane, color_mode))
 		return -EINVAL;
 
-	r = dispc_plane_calc_scaling(plane, caps, channel, mgr_timings,
+	r = dispc_plane_calc_scaling(plane, caps, out_rate, mgr_timings,
 			in_width, in_height, out_width, out_height,
 			color_mode, &five_taps, &x_predecim, &y_predecim,
 			pos_x);
@@ -2419,6 +2417,7 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 	int r;
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
 	enum omap_channel channel;
+	unsigned long out_rate;
 
 	channel = dispc_ovl_get_channel_out(plane);
 
@@ -2428,7 +2427,9 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 		oi->pos_y, oi->width, oi->height, oi->out_width, oi->out_height,
 		oi->color_mode, oi->rotation, oi->mirror, channel, replication);
 
-	r = dispc_plane_setup(plane, channel, ovl->caps, oi->paddr,
+	out_rate = dispc_plane_output_rate(plane);
+
+	r = dispc_plane_setup(plane, ovl->caps, out_rate, oi->paddr,
 		oi->p_uv_addr, oi->screen_width, oi->pos_x, oi->pos_y,
 		oi->width, oi->height, oi->out_width, oi->out_height,
 		oi->color_mode, oi->rotation, oi->mirror, oi->zorder,
@@ -2993,6 +2994,23 @@ unsigned long dispc_core_clk_rate(void)
 	return fclk / lcd;
 }
 
+static unsigned long dispc_plane_output_rate(enum omap_plane plane)
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

