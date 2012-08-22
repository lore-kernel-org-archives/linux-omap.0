From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V6 1/6] OMAPDSS: DISPC: Cleanup cpu_is_xxxx checks
Date: Wed, 22 Aug 2012 12:07:42 +0530
Message-ID: <285c8419420dbe97cde4ca559df0023f9d733bc3.1345616887.git.cmahapatra@ti.com>
References: <cover.1345468541.git.cmahapatra@ti.com> <cover.1345616887.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57045 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225Ab2HVGmS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Aug 2012 02:42:18 -0400
In-Reply-To: <cover.1345616887.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

All the cpu_is checks have been moved to dispc_init_features function providing
a much more generic and cleaner interface. The OMAP version and revision
specific functions and data are initialized by dispc_features structure which is
local to dispc.c.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  434 +++++++++++++++++++++++++--------------
 1 file changed, 279 insertions(+), 155 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index ff52702..0de9a7e 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -81,6 +81,23 @@ struct dispc_irq_stats {
 	unsigned irqs[32];
 };
 
+struct dispc_features {
+	u8 sw_start;
+	u8 fp_start;
+	u8 bp_start;
+	u16 sw_max;
+	u16 vp_max;
+	u16 hp_max;
+	int (*calc_scaling) (enum omap_channel channel,
+		const struct omap_video_timings *mgr_timings,
+		u16 width, u16 height, u16 out_width, u16 out_height,
+		enum omap_color_mode color_mode, bool *five_taps,
+		int *x_predecim, int *y_predecim, int *decim_x, int *decim_y,
+		u16 pos_x, unsigned long *core_clk);
+	unsigned long (*calc_core_clk) (enum omap_channel channel,
+		u16 width, u16 height, u16 out_width, u16 out_height);
+};
+
 static struct {
 	struct platform_device *pdev;
 	void __iomem    *base;
@@ -101,6 +118,8 @@ static struct {
 	bool		ctx_valid;
 	u32		ctx[DISPC_SZ_REGS / sizeof(u32)];
 
+	const struct dispc_features *feat;
+
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
 	spinlock_t irq_stats_lock;
 	struct dispc_irq_stats irq_stats;
@@ -1939,7 +1958,18 @@ static unsigned long calc_core_clk_five_taps(enum omap_channel channel,
 	return core_clk;
 }
 
-static unsigned long calc_core_clk(enum omap_channel channel, u16 width,
+static unsigned long calc_core_clk_24xx(enum omap_channel channel, u16 width,
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
+static unsigned long calc_core_clk_34xx(enum omap_channel channel, u16 width,
 		u16 height, u16 out_width, u16 out_height)
 {
 	unsigned int hf, vf;
@@ -1958,25 +1988,163 @@ static unsigned long calc_core_clk(enum omap_channel channel, u16 width,
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
+static unsigned long calc_core_clk_44xx(enum omap_channel channel, u16 width,
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
+static int dispc_ovl_calc_scaling_24xx(enum omap_channel channel,
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
+		*core_clk = dispc.feat->calc_core_clk(channel, in_width,
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
+static int dispc_ovl_calc_scaling_34xx(enum omap_channel channel,
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
+			*core_clk = dispc.feat->calc_core_clk(channel, in_width,
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
+static int dispc_ovl_calc_scaling_44xx(enum omap_channel channel,
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
+	*core_clk = dispc.feat->calc_core_clk(channel, in_width, in_height,
+				out_width, out_height);
+	return 0;
 }
 
 static int dispc_ovl_calc_scaling(enum omap_plane plane,
@@ -1988,12 +2156,9 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
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
@@ -2017,118 +2182,17 @@ static int dispc_ovl_calc_scaling(enum omap_plane plane,
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
+	ret = dispc.feat->calc_scaling(channel, mgr_timings, width, height,
+		out_width, out_height, color_mode, five_taps, x_predecim,
+		y_predecim, &decim_x, &decim_y, pos_x, &core_clk);
+	if (ret)
+		return ret;
 
 	DSSDBG("required core clk rate = %lu Hz\n", core_clk);
 	DSSDBG("current core clk rate = %lu Hz\n", dispc_core_clk_rate());
@@ -2604,24 +2668,13 @@ static bool _dispc_mgr_size_ok(u16 width, u16 height)
 static bool _dispc_lcd_timings_ok(int hsw, int hfp, int hbp,
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
+	if (hsw < 1 || hsw > dispc.feat->sw_max ||
+			hfp < 1 || hfp > dispc.feat->hp_max ||
+			hbp < 1 || hbp > dispc.feat->hp_max ||
+			vsw < 1 || vsw > dispc.feat->sw_max ||
+			vfp < 0 || vfp > dispc.feat->vp_max ||
+			vbp < 0 || vbp > dispc.feat->vp_max)
+		return false;
 	return true;
 }
 
@@ -2653,19 +2706,12 @@ static void _dispc_mgr_set_lcd_timings(enum omap_channel channel, int hsw,
 	u32 timing_h, timing_v, l;
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
+	timing_h = FLD_VAL(hsw-1, dispc.feat->sw_start, 0) |
+			FLD_VAL(hfp-1, dispc.feat->fp_start, 8) |
+			FLD_VAL(hbp-1, dispc.feat->bp_start, 20);
+	timing_v = FLD_VAL(vsw-1, dispc.feat->sw_start, 0) |
+			FLD_VAL(vfp, dispc.feat->fp_start, 8) |
+			FLD_VAL(vbp, dispc.feat->bp_start, 20);
 
 	dispc_write_reg(DISPC_TIMING_H(channel), timing_h);
 	dispc_write_reg(DISPC_TIMING_V(channel), timing_v);
@@ -3671,6 +3717,80 @@ static void _omap_dispc_initial_config(void)
 	dispc_ovl_enable_zorder_planes();
 }
 
+static const struct dispc_features omap24xx_dispc_feats __initconst = {
+	.sw_start		=	5,
+	.fp_start		=	15,
+	.bp_start		=	27,
+	.sw_max			=	64,
+	.vp_max			=	255,
+	.hp_max			=	256,
+	.calc_scaling		=	dispc_ovl_calc_scaling_24xx,
+	.calc_core_clk		=	calc_core_clk_24xx,
+};
+
+static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
+	.sw_start		=	5,
+	.fp_start		=	15,
+	.bp_start		=	27,
+	.sw_max			=	64,
+	.vp_max			=	255,
+	.hp_max			=	256,
+	.calc_scaling		=	dispc_ovl_calc_scaling_34xx,
+	.calc_core_clk		=	calc_core_clk_34xx,
+};
+
+static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
+	.sw_start		=	7,
+	.fp_start		=	19,
+	.bp_start		=	31,
+	.sw_max			=	256,
+	.vp_max			=	4095,
+	.hp_max			=	4096,
+	.calc_scaling		=	dispc_ovl_calc_scaling_34xx,
+	.calc_core_clk		=	calc_core_clk_34xx,
+};
+
+static const struct dispc_features omap44xx_dispc_feats __initconst = {
+	.sw_start		=	7,
+	.fp_start		=	19,
+	.bp_start		=	31,
+	.sw_max			=	256,
+	.vp_max			=	4095,
+	.hp_max			=	4096,
+	.calc_scaling		=	dispc_ovl_calc_scaling_44xx,
+	.calc_core_clk		=	calc_core_clk_44xx,
+};
+
+static int __init dispc_init_features(struct device *dev)
+{
+	const struct dispc_features *src;
+	struct dispc_features *dst;
+
+	dst = devm_kzalloc(dev, sizeof(*dst), GFP_KERNEL);
+	if (!dst) {
+		dev_err(dev, "Failed to allocate DISPC Features\n");
+		return -ENOMEM;
+	}
+
+	if (cpu_is_omap24xx()) {
+		src = &omap24xx_dispc_feats;
+	} else if (cpu_is_omap34xx()) {
+		if (omap_rev() < OMAP3430_REV_ES3_0)
+			src = &omap34xx_rev1_0_dispc_feats;
+		else
+			src = &omap34xx_rev3_0_dispc_feats;
+	} else if (cpu_is_omap44xx()) {
+		src = &omap44xx_dispc_feats;
+	} else {
+		return -ENODEV;
+	}
+
+	memcpy(dst, src, sizeof(*dst));
+	dispc.feat = dst;
+
+	return 0;
+}
+
 /* DISPC HW IP initialisation */
 static int __init omap_dispchw_probe(struct platform_device *pdev)
 {
@@ -3681,6 +3801,10 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
 
 	dispc.pdev = pdev;
 
+	r = dispc_init_features(&dispc.pdev->dev);
+	if (r)
+		return r;
+
 	spin_lock_init(&dispc.irq_lock);
 
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
-- 
1.7.10

