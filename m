From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 1/6] OMAPDSS: DISPC: Remove cpu_is_xxxx checks
Date: Tue, 7 Aug 2012 13:57:42 +0530
Message-ID: <5344e530a125ef5c5dfeb00e54b7d32df6169aa9.1343912532.git.cmahapatra@ti.com>
References: <cover.1343912532.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37667 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466Ab2HGI3v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Aug 2012 04:29:51 -0400
In-Reply-To: <cover.1343912532.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The cpu_is checks have been removed from DISPC providing it a much generic and
cleaner interface. The OMAP version and revision specific functions are
initialized by dispc_ops structure in dss features.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |  386 +++++++++++++++++++-------------
 drivers/video/omap2/dss/dss.h          |   48 ++++
 drivers/video/omap2/dss/dss_features.c |   42 ++++
 drivers/video/omap2/dss/dss_features.h |    2 +
 4 files changed, 317 insertions(+), 161 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 5b289c5..ad63302 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -101,6 +101,8 @@ static struct {
 	bool		ctx_valid;
 	u32		ctx[DISPC_SZ_REGS / sizeof(u32)];
 
+	const struct dispc_ops *ops;
+
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
 	spinlock_t irq_stats_lock;
 	struct dispc_irq_stats irq_stats;
@@ -1939,7 +1941,18 @@ static unsigned long calc_core_clk_five_taps(enum omap_channel channel,
 	return core_clk;
 }
 
-static unsigned long calc_core_clk(enum omap_channel channel, u16 width,
+unsigned long calc_core_clk_24xx(enum omap_channel channel, u16 width,
+		u16 height, u16 out_width, u16 out_height)
+{
+	unsigned long pclk = dispc_mgr_pclk_rate(channel);
+
+	if (height > out_height && width > out_width)
+		return pclk * 4;
+	else
+		return pclk * 2;
+}
+
+unsigned long calc_core_clk_34xx(enum omap_channel channel, u16 width,
 		u16 height, u16 out_width, u16 out_height)
 {
 	unsigned int hf, vf;
@@ -1958,25 +1971,163 @@ static unsigned long calc_core_clk(enum omap_channel channel, u16 width,
 		hf = 2;
 	else
 		hf = 1;
-
 	if (height > out_height)
 		vf = 2;
 	else
 		vf = 1;
 
-	if (cpu_is_omap24xx()) {
-		if (vf > 1 && hf > 1)
-			return pclk * 4;
-		else
-			return pclk * 2;
-	} else if (cpu_is_omap34xx()) {
-		return pclk * vf * hf;
-	} else {
-		if (hf > 1)
-			return DIV_ROUND_UP(pclk, out_width) * width;
-		else
-			return pclk;
+	return pclk * vf * hf;
+}
+
+unsigned long calc_core_clk_44xx(enum omap_channel channel, u16 width,
+		u16 height, u16 out_width, u16 out_height)
+{
+	unsigned long pclk = dispc_mgr_pclk_rate(channel);
+
+	if (width > out_width)
+		return DIV_ROUND_UP(pclk, out_width) * width;
+	else
+		return pclk;
+}
+
+int dispc_ovl_calc_scaling_24xx(enum omap_channel channel,
+		const struct omap_video_timings *mgr_timings,
+		u16 width, u16 height, u16 out_width, u16 out_height,
+		enum omap_color_mode color_mode, bool *five_taps,
+		int *x_predecim, int *y_predecim, int *decim_x, int *decim_y,
+		u16 pos_x, unsigned long *core_clk)
+{
+	int error;
+	u16 in_width, in_height;
+	int min_factor = min(*decim_x, *decim_y);
+	const int maxsinglelinewidth =
+			dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
+	*five_taps = false;
+
+	do {
+		in_height = DIV_ROUND_UP(height, *decim_y);
+		in_width = DIV_ROUND_UP(width, *decim_x);
+		*core_clk = dispc.ops->calc_core_clk(channel, in_width,
+				in_height, out_width, out_height);
+		error = (in_width > maxsinglelinewidth || !*core_clk ||
+			*core_clk > dispc_core_clk_rate());
+		if (error) {
+			if (*decim_x == *decim_y) {
+				*decim_x = min_factor;
+				++*decim_y;
+			} else {
+				swap(*decim_x, *decim_y);
+				if (*decim_x < *decim_y)
+					++*decim_x;
+			}
+		}
+	} while (*decim_x <= *x_predecim && *decim_y <= *y_predecim && error);
+
+	if (in_width > maxsinglelinewidth) {
+		DSSERR("Cannot scale max input width exceeded");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int dispc_ovl_calc_scaling_34xx(enum omap_channel channel,
+		const struct omap_video_timings *mgr_timings,
+		u16 width, u16 height, u16 out_width, u16 out_height,
+		enum omap_color_mode color_mode, bool *five_taps,
+		int *x_predecim, int *y_predecim, int *decim_x, int *decim_y,
+		u16 pos_x, unsigned long *core_clk)
+{
+	int error;
+	u16 in_width, in_height;
+	int min_factor = min(*decim_x, *decim_y);
+	const int maxsinglelinewidth =
+			dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
+
+	do {
+		in_height = DIV_ROUND_UP(height, *decim_y);
+		in_width = DIV_ROUND_UP(width, *decim_x);
+		*core_clk = calc_core_clk_five_taps(channel, mgr_timings,
+			in_width, in_height, out_width, out_height, color_mode);
+
+		error = check_horiz_timing_omap3(channel, mgr_timings, pos_x,
+			in_width, in_height, out_width, out_height);
+
+		if (in_width > maxsinglelinewidth)
+			if (in_height > out_height &&
+						in_height < out_height * 2)
+				*five_taps = false;
+		if (!*five_taps)
+			*core_clk = dispc.ops->calc_core_clk(channel, in_width,
+					in_height, out_width, out_height);
+
+		error = (error || in_width > maxsinglelinewidth * 2 ||
+			(in_width > maxsinglelinewidth && *five_taps) ||
+			!*core_clk || *core_clk > dispc_core_clk_rate());
+		if (error) {
+			if (*decim_x == *decim_y) {
+				*decim_x = min_factor;
+				++*decim_y;
+			} else {
+				swap(*decim_x, *decim_y);
+				if (*decim_x < *decim_y)
+					++*decim_x;
+			}
+		}
+	} while (*decim_x <= *x_predecim && *decim_y <= *y_predecim && error);
+
+	if (check_horiz_timing_omap3(channel, mgr_timings, pos_x, width, height,
+		out_width, out_height)){
+			DSSERR("horizontal timing too tight\n");
+			return -EINVAL;
+	}
+
+	if (in_width > (maxsinglelinewidth * 2)) {
+		DSSERR("Cannot setup scaling");
+		DSSERR("width exceeds maximum width possible");
+		return -EINVAL;
+	}
+
+	if (in_width > maxsinglelinewidth && *five_taps) {
+		DSSERR("cannot setup scaling with five taps");
+		return -EINVAL;
 	}
+	return 0;
+}
+
+int dispc_ovl_calc_scaling_44xx(enum omap_channel channel,
+		const struct omap_video_timings *mgr_timings,
+		u16 width, u16 height, u16 out_width, u16 out_height,
+		enum omap_color_mode color_mode, bool *five_taps,
+		int *x_predecim, int *y_predecim, int *decim_x, int *decim_y,
+		u16 pos_x, unsigned long *core_clk)
+{
+	u16 in_width, in_width_max;
+	int decim_x_min = *decim_x;
+	u16 in_height = DIV_ROUND_UP(height, *decim_y);
+	const int maxsinglelinewidth =
+				dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
+
+	in_width_max = dispc_core_clk_rate() /
+			DIV_ROUND_UP(dispc_mgr_pclk_rate(channel), out_width);
+	*decim_x = DIV_ROUND_UP(width, in_width_max);
+
+	*decim_x = *decim_x > decim_x_min ? *decim_x : decim_x_min;
+	if (*decim_x > *x_predecim)
+		return -EINVAL;
+
+	do {
+		in_width = DIV_ROUND_UP(width, *decim_x);
+	} while (*decim_x <= *x_predecim &&
+			in_width > maxsinglelinewidth && ++*decim_x);
+
+	if (in_width > maxsinglelinewidth) {
+		DSSERR("Cannot scale width exceeds max line width");
+		return -EINVAL;
+	}
+
+	*core_clk = dispc.ops->calc_core_clk(channel, in_width, in_height,
+				out_width, out_height);
+	return 0;
 }
 
 static int dispc_ovl_calc_scaling(enum omap_plane plane,
@@ -1988,12 +2139,9 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 {
 	struct omap_overlay *ovl = omap_dss_get_overlay(plane);
 	const int maxdownscale = dss_feat_get_param_max(FEAT_PARAM_DOWNSCALE);
-	const int maxsinglelinewidth =
-				dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
 	const int max_decim_limit = 16;
 	unsigned long core_clk = 0;
-	int decim_x, decim_y, error, min_factor;
-	u16 in_width, in_height, in_width_max = 0;
+	int decim_x, decim_y, ret;
 
 	if (width == out_width && height == out_height)
 		return 0;
@@ -2017,118 +2165,17 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
 	decim_x = DIV_ROUND_UP(DIV_ROUND_UP(width, out_width), maxdownscale);
 	decim_y = DIV_ROUND_UP(DIV_ROUND_UP(height, out_height), maxdownscale);
 
-	min_factor = min(decim_x, decim_y);
-
 	if (decim_x > *x_predecim || out_width > width * 8)
 		return -EINVAL;
 
 	if (decim_y > *y_predecim || out_height > height * 8)
 		return -EINVAL;
 
-	if (cpu_is_omap24xx()) {
-		*five_taps = false;
-
-		do {
-			in_height = DIV_ROUND_UP(height, decim_y);
-			in_width = DIV_ROUND_UP(width, decim_x);
-			core_clk = calc_core_clk(channel, in_width, in_height,
-					out_width, out_height);
-			error = (in_width > maxsinglelinewidth || !core_clk ||
-				core_clk > dispc_core_clk_rate());
-			if (error) {
-				if (decim_x == decim_y) {
-					decim_x = min_factor;
-					decim_y++;
-				} else {
-					swap(decim_x, decim_y);
-					if (decim_x < decim_y)
-						decim_x++;
-				}
-			}
-		} while (decim_x <= *x_predecim && decim_y <= *y_predecim &&
-				error);
-
-		if (in_width > maxsinglelinewidth) {
-			DSSERR("Cannot scale max input width exceeded");
-			return -EINVAL;
-		}
-	} else if (cpu_is_omap34xx()) {
-
-		do {
-			in_height = DIV_ROUND_UP(height, decim_y);
-			in_width = DIV_ROUND_UP(width, decim_x);
-			core_clk = calc_core_clk_five_taps(channel, mgr_timings,
-				in_width, in_height, out_width, out_height,
-				color_mode);
-
-			error = check_horiz_timing_omap3(channel, mgr_timings,
-				pos_x, in_width, in_height, out_width,
-				out_height);
-
-			if (in_width > maxsinglelinewidth)
-				if (in_height > out_height &&
-					in_height < out_height * 2)
-					*five_taps = false;
-			if (!*five_taps)
-				core_clk = calc_core_clk(channel, in_width,
-					in_height, out_width, out_height);
-			error = (error || in_width > maxsinglelinewidth * 2 ||
-				(in_width > maxsinglelinewidth && *five_taps) ||
-				!core_clk || core_clk > dispc_core_clk_rate());
-			if (error) {
-				if (decim_x == decim_y) {
-					decim_x = min_factor;
-					decim_y++;
-				} else {
-					swap(decim_x, decim_y);
-					if (decim_x < decim_y)
-						decim_x++;
-				}
-			}
-		} while (decim_x <= *x_predecim && decim_y <= *y_predecim
-			&& error);
-
-		if (check_horiz_timing_omap3(channel, mgr_timings, pos_x, width,
-			height, out_width, out_height)){
-				DSSERR("horizontal timing too tight\n");
-				return -EINVAL;
-		}
-
-		if (in_width > (maxsinglelinewidth * 2)) {
-			DSSERR("Cannot setup scaling");
-			DSSERR("width exceeds maximum width possible");
-			return -EINVAL;
-		}
-
-		if (in_width > maxsinglelinewidth && *five_taps) {
-			DSSERR("cannot setup scaling with five taps");
-			return -EINVAL;
-		}
-	} else {
-		int decim_x_min = decim_x;
-		in_height = DIV_ROUND_UP(height, decim_y);
-		in_width_max = dispc_core_clk_rate() /
-				DIV_ROUND_UP(dispc_mgr_pclk_rate(channel),
-						out_width);
-		decim_x = DIV_ROUND_UP(width, in_width_max);
-
-		decim_x = decim_x > decim_x_min ? decim_x : decim_x_min;
-		if (decim_x > *x_predecim)
-			return -EINVAL;
-
-		do {
-			in_width = DIV_ROUND_UP(width, decim_x);
-		} while (decim_x <= *x_predecim &&
-				in_width > maxsinglelinewidth && decim_x++);
-
-		if (in_width > maxsinglelinewidth) {
-			DSSERR("Cannot scale width exceeds max line width");
-			return -EINVAL;
-		}
-
-		core_clk = calc_core_clk(channel, in_width, in_height,
-				out_width, out_height);
-	}
+	ret = dispc.ops->calc_scaling(channel, mgr_timings, width, height,
+		out_width, out_height, color_mode, five_taps, x_predecim,
+		y_predecim, &decim_x, &decim_y, pos_x, &core_clk);
+	if (ret)
+		return ret;
 
 	DSSDBG("required core clk rate = %lu Hz\n", core_clk);
 	DSSDBG("current core clk rate = %lu Hz\n", dispc_core_clk_rate());
@@ -2601,27 +2648,28 @@ static bool _dispc_mgr_size_ok(u16 width, u16 height)
 		height <= dss_feat_get_param_max(FEAT_PARAM_MGR_HEIGHT);
 }
 
-static bool _dispc_lcd_timings_ok(int hsw, int hfp, int hbp,
+bool _dispc_lcd_timings_ok_24xx(int hsw, int hfp, int hbp,
 		int vsw, int vfp, int vbp)
 {
-	if (cpu_is_omap24xx() || omap_rev() < OMAP3430_REV_ES3_0) {
-		if (hsw < 1 || hsw > 64 ||
-				hfp < 1 || hfp > 256 ||
-				hbp < 1 || hbp > 256 ||
-				vsw < 1 || vsw > 64 ||
-				vfp < 0 || vfp > 255 ||
-				vbp < 0 || vbp > 255)
-			return false;
-	} else {
-		if (hsw < 1 || hsw > 256 ||
-				hfp < 1 || hfp > 4096 ||
-				hbp < 1 || hbp > 4096 ||
-				vsw < 1 || vsw > 256 ||
-				vfp < 0 || vfp > 4095 ||
-				vbp < 0 || vbp > 4095)
-			return false;
-	}
-
+	if (hsw < 1 || hsw > 64 ||
+			hfp < 1 || hfp > 256 ||
+			hbp < 1 || hbp > 256 ||
+			vsw < 1 || vsw > 64  ||
+			vfp < 0 || vfp > 255 ||
+			vbp < 0 || vbp > 255)
+		return false;
+	return true;
+}
+bool _dispc_lcd_timings_ok_44xx(int hsw, int hfp, int hbp,
+		int vsw, int vfp, int vbp)
+{
+	if (hsw < 1 || hsw > 256 ||
+			hfp < 1  || hfp > 4096 ||
+			hbp < 1  || hbp > 4096 ||
+			vsw < 1  || vsw > 256  ||
+			vfp < 0  || vfp > 4095 ||
+			vbp < 0  || vbp > 4095)
+		return false;
 	return true;
 }
 
@@ -2633,7 +2681,8 @@ bool dispc_mgr_timings_ok(enum omap_channel channel,
 	timings_ok = _dispc_mgr_size_ok(timings->x_res, timings->y_res);
 
 	if (dss_mgr_is_lcd(channel))
-		timings_ok =  timings_ok && _dispc_lcd_timings_ok(timings->hsw,
+		timings_ok =  timings_ok &&
+			dispc.ops->lcd_timings_ok(timings->hsw,
 						timings->hfp, timings->hbp,
 						timings->vsw, timings->vfp,
 						timings->vbp);
@@ -2641,6 +2690,34 @@ bool dispc_mgr_timings_ok(enum omap_channel channel,
 	return timings_ok;
 }
 
+void _dispc_mgr_set_lcd_timings_hv_24xx(enum omap_channel channel, int hsw,
+		int hfp, int hbp, int vsw, int vfp, int vbp)
+{
+	u32 timing_h, timing_v;
+
+	timing_h = FLD_VAL(hsw-1, 5, 0) | FLD_VAL(hfp-1, 15, 8) |
+			FLD_VAL(hbp-1, 27, 20);
+	timing_v = FLD_VAL(vsw-1, 5, 0) | FLD_VAL(vfp, 15, 8) |
+			FLD_VAL(vbp, 27, 20);
+
+	dispc_write_reg(DISPC_TIMING_H(channel), timing_h);
+	dispc_write_reg(DISPC_TIMING_V(channel), timing_v);
+}
+
+void _dispc_mgr_set_lcd_timings_hv_44xx(enum omap_channel channel, int hsw,
+		int hfp, int hbp, int vsw, int vfp, int vbp)
+{
+	u32 timing_h, timing_v;
+
+	timing_h = FLD_VAL(hsw-1, 7, 0) | FLD_VAL(hfp-1, 19, 8) |
+			FLD_VAL(hbp-1, 31, 20);
+	timing_v = FLD_VAL(vsw-1, 7, 0) | FLD_VAL(vfp, 19, 8) |
+			FLD_VAL(vbp, 31, 20);
+
+	dispc_write_reg(DISPC_TIMING_H(channel), timing_h);
+	dispc_write_reg(DISPC_TIMING_V(channel), timing_v);
+}
+
 static void _dispc_mgr_set_lcd_timings(enum omap_channel channel, int hsw,
 		int hfp, int hbp, int vsw, int vfp, int vbp,
 		enum omap_dss_signal_level vsync_level,
@@ -2650,25 +2727,10 @@ static void _dispc_mgr_set_lcd_timings(enum omap_channel channel, int hsw,
 		enum omap_dss_signal_edge sync_pclk_edge)
 
 {
-	u32 timing_h, timing_v, l;
+	u32 l;
 	bool onoff, rf, ipc;
 
-	if (cpu_is_omap24xx() || omap_rev() < OMAP3430_REV_ES3_0) {
-		timing_h = FLD_VAL(hsw-1, 5, 0) | FLD_VAL(hfp-1, 15, 8) |
-			FLD_VAL(hbp-1, 27, 20);
-
-		timing_v = FLD_VAL(vsw-1, 5, 0) | FLD_VAL(vfp, 15, 8) |
-			FLD_VAL(vbp, 27, 20);
-	} else {
-		timing_h = FLD_VAL(hsw-1, 7, 0) | FLD_VAL(hfp-1, 19, 8) |
-			FLD_VAL(hbp-1, 31, 20);
-
-		timing_v = FLD_VAL(vsw-1, 7, 0) | FLD_VAL(vfp, 19, 8) |
-			FLD_VAL(vbp, 31, 20);
-	}
-
-	dispc_write_reg(DISPC_TIMING_H(channel), timing_h);
-	dispc_write_reg(DISPC_TIMING_V(channel), timing_v);
+	dispc.ops->set_lcd_timings_hv(channel, hsw, hfp, hbp, vsw, vfp, vbp);
 
 	switch (data_pclk_edge) {
 	case OMAPDSS_DRIVE_SIG_RISING_EDGE:
@@ -3725,6 +3787,8 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
 
 	dispc.dss_clk = clk;
 
+	dispc_init_ops(dispc.ops);
+
 	pm_runtime_enable(&pdev->dev);
 
 	r = dispc_runtime_get();
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index f67afe7..d87b885 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -171,6 +171,21 @@ struct dss_lcd_mgr_config {
 	int lcden_sig_polarity;
 };
 
+struct dispc_ops {
+	int (*calc_scaling) (enum omap_channel channel,
+		const struct omap_video_timings *mgr_timings,
+		u16 width, u16 height, u16 out_width, u16 out_height,
+		enum omap_color_mode color_mode, bool *five_taps,
+		int *x_predecim, int *y_predecim, int *decim_x, int *decim_y,
+		u16 pos_x, unsigned long *core_clk);
+	unsigned long (*calc_core_clk) (enum omap_channel channel,
+		u16 width, u16 height, u16 out_width, u16 out_height);
+	bool (*lcd_timings_ok) (int hsw, int hfp, int hbp,
+			int vsw, int vfp, int vbp);
+	void (*set_lcd_timings_hv) (enum omap_channel channel, int hsw, int hfp,
+			int hbp, int vsw, int vfp, int vbp);
+};
+
 struct seq_file;
 struct platform_device;
 
@@ -457,6 +472,39 @@ int dispc_mgr_get_clock_div(enum omap_channel channel,
 void dispc_mgr_setup(enum omap_channel channel,
 		struct omap_overlay_manager_info *info);
 
+int dispc_ovl_calc_scaling_24xx(enum omap_channel channel,
+	const struct omap_video_timings *mgr_timings, u16 width, u16 height,
+	u16 out_width, u16 out_height, enum omap_color_mode color_mode,
+	bool *five_taps, int *x_predecim, int *y_predecim, int *decim_x,
+	int *decim_y, u16 pos_x, unsigned long *core_clk);
+int dispc_ovl_calc_scaling_34xx(enum omap_channel channel,
+	const struct omap_video_timings *mgr_timings, u16 width, u16 height,
+	u16 out_width, u16 out_height,  enum omap_color_mode color_mode,
+	bool *five_taps, int *x_predecim, int *y_predecim, int *decim_x,
+	int *decim_y, u16 pos_x, unsigned long *core_clk);
+int dispc_ovl_calc_scaling_44xx(enum omap_channel channel,
+	const struct omap_video_timings *mgr_timings, u16 width, u16 height,
+	u16 out_width, u16 out_height,  enum omap_color_mode color_mode,
+	bool *five_taps, int *x_predecim, int *y_predecim, int *decim_x,
+	int *decim_y, u16 pos_x, unsigned long *core_clk);
+
+unsigned long calc_core_clk_24xx(enum omap_channel channel, u16 width,
+		u16 height, u16 out_width, u16 out_height);
+unsigned long calc_core_clk_34xx(enum omap_channel channel, u16 width,
+		u16 height, u16 out_width, u16 out_height);
+unsigned long calc_core_clk_44xx(enum omap_channel channel, u16 width,
+		u16 height, u16 out_width, u16 out_height);
+
+bool _dispc_lcd_timings_ok_24xx(int hsw, int hfp, int hbp,
+		int vsw, int vfp, int vbp);
+bool _dispc_lcd_timings_ok_44xx(int hsw, int hfp, int hbp,
+		int vsw, int vfp, int vbp);
+
+void _dispc_mgr_set_lcd_timings_hv_24xx(enum omap_channel channel, int hsw,
+		int hfp, int hbp, int vsw, int vfp, int vbp);
+void _dispc_mgr_set_lcd_timings_hv_44xx(enum omap_channel channel, int hsw,
+		int hfp, int hbp, int vsw, int vfp, int vbp);
+
 /* VENC */
 #ifdef CONFIG_OMAP2_DSS_VENC
 int venc_init_platform_driver(void) __init;
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 9387097..b8d5095 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -567,6 +567,48 @@ static const struct omap_dss_features omap4_dss_features = {
 	.burst_size_unit = 16,
 };
 
+static const struct dispc_ops omap2_dispc_ops = {
+	.calc_scaling		=	dispc_ovl_calc_scaling_24xx,
+	.calc_core_clk		=	calc_core_clk_24xx,
+	.lcd_timings_ok		=	_dispc_lcd_timings_ok_24xx,
+	.set_lcd_timings_hv	=	_dispc_mgr_set_lcd_timings_hv_24xx,
+};
+
+static const struct dispc_ops omap3_2_1_dispc_ops = {
+	.calc_scaling		=	dispc_ovl_calc_scaling_34xx,
+	.calc_core_clk		=	calc_core_clk_34xx,
+	.lcd_timings_ok		=	_dispc_lcd_timings_ok_24xx,
+	.set_lcd_timings_hv	=	_dispc_mgr_set_lcd_timings_hv_24xx,
+};
+
+static const struct dispc_ops omap3_3_0_dispc_ops = {
+	.calc_scaling		=	dispc_ovl_calc_scaling_34xx,
+	.calc_core_clk		=	calc_core_clk_34xx,
+	.lcd_timings_ok		=	_dispc_lcd_timings_ok_44xx,
+	.set_lcd_timings_hv	=	_dispc_mgr_set_lcd_timings_hv_44xx,
+};
+
+static const struct dispc_ops omap4_dispc_ops = {
+	.calc_scaling		=	dispc_ovl_calc_scaling_44xx,
+	.calc_core_clk		=	calc_core_clk_44xx,
+	.lcd_timings_ok		=	_dispc_lcd_timings_ok_44xx,
+	.set_lcd_timings_hv	=	_dispc_mgr_set_lcd_timings_hv_44xx,
+};
+
+void dispc_init_ops(const struct dispc_ops *ops)
+{
+	if (cpu_is_omap24xx()) {
+		ops = &omap2_dispc_ops;
+	} else if (cpu_is_omap34xx()) {
+		if (omap_rev() < OMAP3430_REV_ES3_0)
+			ops = &omap3_2_1_dispc_ops;
+		else
+			ops = &omap3_3_0_dispc_ops;
+	} else {
+		ops = &omap4_dispc_ops;
+	}
+}
+
 #if defined(CONFIG_OMAP4_DSS_HDMI)
 /* HDMI OMAP4 Functions*/
 static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 996ffcb..d03777a 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -120,4 +120,6 @@ void dss_features_init(void);
 #if defined(CONFIG_OMAP4_DSS_HDMI)
 void dss_init_hdmi_ip_ops(struct hdmi_ip_data *ip_data);
 #endif
+
+void dispc_init_ops(const struct dispc_ops *ops);
 #endif
-- 
1.7.10

