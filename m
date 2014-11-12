From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/22] OMAPDSS: DSI: use common DSS PLL support
Date: Wed, 12 Nov 2014 13:52:15 +0200
Message-ID: <1415793144-11723-14-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41992 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbaKLLxE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2014 06:53:04 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that we have the common DSS PLL support, change DSI to use it. This
results in quite a lot of changes, but almost all of them are trivial
name changes.

The functions to calculate and program the PLL settings can be removed
from dsi.c, as the common PLL API contains the same functionality.

We also need to create struct dss_pll_hw entries for PLL hardware
features for different OMAP platforms, instead of using the
dss_features.c as the old code does.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c |  20 +-
 drivers/video/fbdev/omap2/dss/dpi.c   |  82 ++---
 drivers/video/fbdev/omap2/dss/dsi.c   | 566 ++++++++++++----------------------
 drivers/video/fbdev/omap2/dss/dss.h   |  76 -----
 4 files changed, 255 insertions(+), 489 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 0e9a74bb9fc2..0729c08ac75a 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -3028,7 +3028,7 @@ static void dispc_mgr_get_lcd_divisor(enum omap_channel channel, int *lck_div,
 
 unsigned long dispc_fclk_rate(void)
 {
-	struct platform_device *dsidev;
+	struct dss_pll *pll;
 	unsigned long r = 0;
 
 	switch (dss_get_dispc_clk_source()) {
@@ -3036,12 +3036,12 @@ unsigned long dispc_fclk_rate(void)
 		r = dss_get_dispc_clk_rate();
 		break;
 	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
-		dsidev = dsi_get_dsidev_from_id(0);
-		r = dsi_get_pll_hsdiv_dispc_rate(dsidev);
+		pll = dss_pll_find("dsi0");
+		r = pll->cinfo.clkout[0];
 		break;
 	case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
-		dsidev = dsi_get_dsidev_from_id(1);
-		r = dsi_get_pll_hsdiv_dispc_rate(dsidev);
+		pll = dss_pll_find("dsi1");
+		r = pll->cinfo.clkout[0];
 		break;
 	default:
 		BUG();
@@ -3053,7 +3053,7 @@ unsigned long dispc_fclk_rate(void)
 
 unsigned long dispc_mgr_lclk_rate(enum omap_channel channel)
 {
-	struct platform_device *dsidev;
+	struct dss_pll *pll;
 	int lcd;
 	unsigned long r;
 	u32 l;
@@ -3068,12 +3068,12 @@ unsigned long dispc_mgr_lclk_rate(enum omap_channel channel)
 			r = dss_get_dispc_clk_rate();
 			break;
 		case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
-			dsidev = dsi_get_dsidev_from_id(0);
-			r = dsi_get_pll_hsdiv_dispc_rate(dsidev);
+			pll = dss_pll_find("dsi0");
+			r = pll->cinfo.clkout[0];
 			break;
 		case OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC:
-			dsidev = dsi_get_dsidev_from_id(1);
-			r = dsi_get_pll_hsdiv_dispc_rate(dsidev);
+			pll = dss_pll_find("dsi1");
+			r = pll->cinfo.clkout[0];
 			break;
 		default:
 			BUG();
diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index 81dd5e61e75e..2edf5caa002f 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -31,6 +31,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/string.h>
 #include <linux/of.h>
+#include <linux/clk.h>
 
 #include <video/omapdss.h>
 
@@ -43,7 +44,7 @@ struct dpi_data {
 	struct platform_device *pdev;
 
 	struct regulator *vdds_dsi_reg;
-	struct platform_device *dsidev;
+	struct dss_pll *pll;
 
 	struct mutex lock;
 
@@ -67,7 +68,7 @@ static struct dpi_data *dpi_get_data_from_pdev(struct platform_device *pdev)
 	return dev_get_drvdata(&pdev->dev);
 }
 
-static struct platform_device *dpi_get_dsidev(enum omap_channel channel)
+static struct dss_pll *dpi_get_pll(enum omap_channel channel)
 {
 	/*
 	 * XXX we can't currently use DSI PLL for DPI with OMAP3, as the DSI PLL
@@ -88,9 +89,9 @@ static struct platform_device *dpi_get_dsidev(enum omap_channel channel)
 	case OMAPDSS_VER_OMAP4:
 		switch (channel) {
 		case OMAP_DSS_CHANNEL_LCD:
-			return dsi_get_dsidev_from_id(0);
+			return dss_pll_find("dsi0");
 		case OMAP_DSS_CHANNEL_LCD2:
-			return dsi_get_dsidev_from_id(1);
+			return dss_pll_find("dsi1");
 		default:
 			return NULL;
 		}
@@ -98,9 +99,9 @@ static struct platform_device *dpi_get_dsidev(enum omap_channel channel)
 	case OMAPDSS_VER_OMAP5:
 		switch (channel) {
 		case OMAP_DSS_CHANNEL_LCD:
-			return dsi_get_dsidev_from_id(0);
+			return dss_pll_find("dsi0");
 		case OMAP_DSS_CHANNEL_LCD3:
-			return dsi_get_dsidev_from_id(1);
+			return dss_pll_find("dsi1");
 		default:
 			return NULL;
 		}
@@ -127,7 +128,7 @@ static enum omap_dss_clk_source dpi_get_alt_clk_src(enum omap_channel channel)
 }
 
 struct dpi_clk_calc_ctx {
-	struct platform_device *dsidev;
+	struct dss_pll *pll;
 
 	/* inputs */
 
@@ -135,7 +136,7 @@ struct dpi_clk_calc_ctx {
 
 	/* outputs */
 
-	struct dsi_clock_info dsi_cinfo;
+	struct dss_pll_clock_info dsi_cinfo;
 	unsigned long fck;
 	struct dispc_clock_info dispc_cinfo;
 };
@@ -167,7 +168,7 @@ static bool dpi_calc_dispc_cb(int lckd, int pckd, unsigned long lck,
 }
 
 
-static bool dpi_calc_hsdiv_cb(int regm_dispc, unsigned long dispc,
+static bool dpi_calc_hsdiv_cb(int m_dispc, unsigned long dispc,
 		void *data)
 {
 	struct dpi_clk_calc_ctx *ctx = data;
@@ -177,10 +178,10 @@ static bool dpi_calc_hsdiv_cb(int regm_dispc, unsigned long dispc,
 	 * shifted. So skip all odd dividers when the pixel clock is on the
 	 * higher side.
 	 */
-	if (regm_dispc > 1 && regm_dispc % 2 != 0 && ctx->pck_min >= 100000000)
+	if (m_dispc > 1 && m_dispc % 2 != 0 && ctx->pck_min >= 100000000)
 		return false;
 
-	ctx->dsi_cinfo.regm_hsdiv[HSDIV_DISPC] = regm_dispc;
+	ctx->dsi_cinfo.mX[HSDIV_DISPC] = m_dispc;
 	ctx->dsi_cinfo.clkout[HSDIV_DISPC] = dispc;
 
 	return dispc_div_calc(dispc, ctx->pck_min, ctx->pck_max,
@@ -188,19 +189,20 @@ static bool dpi_calc_hsdiv_cb(int regm_dispc, unsigned long dispc,
 }
 
 
-static bool dpi_calc_pll_cb(int regn, int regm, unsigned long fint,
-		unsigned long pll,
+static bool dpi_calc_pll_cb(int n, int m, unsigned long fint,
+		unsigned long clkdco,
 		void *data)
 {
 	struct dpi_clk_calc_ctx *ctx = data;
 
-	ctx->dsi_cinfo.regn = regn;
-	ctx->dsi_cinfo.regm = regm;
+	ctx->dsi_cinfo.n = n;
+	ctx->dsi_cinfo.m = m;
 	ctx->dsi_cinfo.fint = fint;
-	ctx->dsi_cinfo.clkdco = pll;
+	ctx->dsi_cinfo.clkdco = clkdco;
 
-	return dsi_hsdiv_calc(ctx->dsidev, pll, ctx->pck_min,
-			dpi_calc_hsdiv_cb, ctx);
+	return dss_pll_hsdiv_calc(ctx->pll, clkdco,
+		ctx->pck_min, dss_feat_get_param_max(FEAT_PARAM_DSS_FCK),
+		dpi_calc_hsdiv_cb, ctx);
 }
 
 static bool dpi_calc_dss_cb(unsigned long fck, void *data)
@@ -219,17 +221,17 @@ static bool dpi_dsi_clk_calc(struct dpi_data *dpi, unsigned long pck,
 	unsigned long clkin;
 	unsigned long pll_min, pll_max;
 
-	clkin = dsi_get_pll_clkin(dpi->dsidev);
-
 	memset(ctx, 0, sizeof(*ctx));
-	ctx->dsidev = dpi->dsidev;
+	ctx->pll = dpi->pll;
 	ctx->pck_min = pck - 1000;
 	ctx->pck_max = pck + 1000;
 
 	pll_min = 0;
 	pll_max = 0;
 
-	return dsi_pll_calc(dpi->dsidev, clkin,
+	clkin = clk_get_rate(ctx->pll->clkin);
+
+	return dss_pll_calc(ctx->pll, clkin,
 			pll_min, pll_max,
 			dpi_calc_pll_cb, ctx);
 }
@@ -277,7 +279,7 @@ static int dpi_set_dsi_clk(struct dpi_data *dpi, enum omap_channel channel,
 	if (!ok)
 		return -EINVAL;
 
-	r = dsi_pll_set_clock_div(dpi->dsidev, &ctx.dsi_cinfo);
+	r = dss_pll_set_config(dpi->pll, &ctx.dsi_cinfo);
 	if (r)
 		return r;
 
@@ -327,7 +329,7 @@ static int dpi_set_mode(struct dpi_data *dpi)
 	unsigned long pck;
 	int r = 0;
 
-	if (dpi->dsidev)
+	if (dpi->pll)
 		r = dpi_set_dsi_clk(dpi, mgr->id, t->pixelclock, &fck,
 				&lck_div, &pck_div);
 	else
@@ -401,8 +403,8 @@ static int dpi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_src_sel;
 
-	if (dpi->dsidev) {
-		r = dsi_pll_init(dpi->dsidev);
+	if (dpi->pll) {
+		r = dss_pll_enable(dpi->pll);
 		if (r)
 			goto err_dsi_pll_init;
 	}
@@ -425,8 +427,8 @@ static int dpi_display_enable(struct omap_dss_device *dssdev)
 
 err_mgr_enable:
 err_set_mode:
-	if (dpi->dsidev)
-		dsi_pll_uninit(dpi->dsidev, true);
+	if (dpi->pll)
+		dss_pll_disable(dpi->pll);
 err_dsi_pll_init:
 err_src_sel:
 	dispc_runtime_put();
@@ -449,9 +451,9 @@ static void dpi_display_disable(struct omap_dss_device *dssdev)
 
 	dss_mgr_disable(mgr);
 
-	if (dpi->dsidev) {
+	if (dpi->pll) {
 		dss_select_lcd_clk_source(mgr->id, OMAP_DSS_CLK_SRC_FCK);
-		dsi_pll_uninit(dpi->dsidev, true);
+		dss_pll_disable(dpi->pll);
 	}
 
 	dispc_runtime_put();
@@ -505,7 +507,7 @@ static int dpi_check_timings(struct omap_dss_device *dssdev,
 	if (timings->pixelclock == 0)
 		return -EINVAL;
 
-	if (dpi->dsidev) {
+	if (dpi->pll) {
 		ok = dpi_dsi_clk_calc(dpi, timings->pixelclock, &ctx);
 		if (!ok)
 			return -EINVAL;
@@ -540,17 +542,17 @@ static void dpi_set_data_lines(struct omap_dss_device *dssdev, int data_lines)
 	mutex_unlock(&dpi->lock);
 }
 
-static int dpi_verify_dsi_pll(struct platform_device *dsidev)
+static int dpi_verify_dsi_pll(struct dss_pll *pll)
 {
 	int r;
 
 	/* do initial setup with the PLL to see if it is operational */
 
-	r = dsi_pll_init(dsidev);
+	r = dss_pll_enable(pll);
 	if (r)
 		return r;
 
-	dsi_pll_uninit(dsidev, true);
+	dss_pll_disable(pll);
 
 	return 0;
 }
@@ -579,21 +581,21 @@ static int dpi_init_regulator(struct dpi_data *dpi)
 
 static void dpi_init_pll(struct dpi_data *dpi)
 {
-	struct platform_device *dsidev;
+	struct dss_pll *pll;
 
-	if (dpi->dsidev)
+	if (dpi->pll)
 		return;
 
-	dsidev = dpi_get_dsidev(dpi->output.dispc_channel);
-	if (!dsidev)
+	pll = dpi_get_pll(dpi->output.dispc_channel);
+	if (!pll)
 		return;
 
-	if (dpi_verify_dsi_pll(dsidev)) {
+	if (dpi_verify_dsi_pll(pll)) {
 		DSSWARN("DSI PLL not operational\n");
 		return;
 	}
 
-	dpi->dsidev = dsidev;
+	dpi->pll = pll;
 }
 
 /*
diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index e8415b5e877e..73af35159468 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -275,6 +275,7 @@ struct dsi_isr_tables {
 
 struct dsi_clk_calc_ctx {
 	struct platform_device *dsidev;
+	struct dss_pll *pll;
 
 	/* inputs */
 
@@ -284,7 +285,7 @@ struct dsi_clk_calc_ctx {
 
 	/* outputs */
 
-	struct dsi_clock_info dsi_cinfo;
+	struct dss_pll_clock_info dsi_cinfo;
 	struct dispc_clock_info dispc_cinfo;
 
 	struct omap_video_timings dispc_vm;
@@ -309,16 +310,15 @@ struct dsi_data {
 	bool is_enabled;
 
 	struct clk *dss_clk;
-	struct clk *sys_clk;
 
 	struct dispc_clock_info user_dispc_cinfo;
-	struct dsi_clock_info user_dsi_cinfo;
-
-	struct dsi_clock_info current_cinfo;
+	struct dss_pll_clock_info user_dsi_cinfo;
 
 	struct dsi_lp_clock_info user_lp_cinfo;
 	struct dsi_lp_clock_info current_lp_cinfo;
 
+	struct dss_pll pll;
+
 	bool vdds_dsi_enabled;
 	struct regulator *vdds_dsi_reg;
 
@@ -357,7 +357,7 @@ struct dsi_data {
 
 	unsigned long cache_req_pck;
 	unsigned long cache_clk_freq;
-	struct dsi_clock_info cache_cinfo;
+	struct dss_pll_clock_info cache_cinfo;
 
 	u32		errors;
 	spinlock_t	errors_lock;
@@ -372,11 +372,6 @@ struct dsi_data {
 	spinlock_t irq_stats_lock;
 	struct dsi_irq_stats irq_stats;
 #endif
-	/* DSI PLL Parameter Ranges */
-	unsigned long regm_max, regn_max;
-	unsigned long  regm_hsdiv_max;
-	unsigned long  fint_min, fint_max;
-	unsigned long lpdiv_max;
 
 	unsigned num_lanes_supported;
 	unsigned line_buffer_size;
@@ -422,7 +417,7 @@ static inline struct platform_device *dsi_get_dsidev_from_dssdev(struct omap_dss
 	return to_platform_device(dssdev->dev);
 }
 
-struct platform_device *dsi_get_dsidev_from_id(int module)
+static struct platform_device *dsi_get_dsidev_from_id(int module)
 {
 	struct omap_dss_device *out;
 	enum omap_dss_output_id	id;
@@ -1198,18 +1193,6 @@ static int dsi_regulator_init(struct platform_device *dsidev)
 	return 0;
 }
 
-/* source clock for DSI PLL. this could also be PCLKFREE */
-static inline void dsi_enable_pll_clock(struct platform_device *dsidev,
-		bool enable)
-{
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-
-	if (enable)
-		clk_prepare_enable(dsi->sys_clk);
-	else
-		clk_disable_unprepare(dsi->sys_clk);
-}
-
 static void _dsi_print_reset_status(struct platform_device *dsidev)
 {
 	u32 l;
@@ -1261,25 +1244,25 @@ static inline int dsi_if_enable(struct platform_device *dsidev, bool enable)
 	return 0;
 }
 
-unsigned long dsi_get_pll_hsdiv_dispc_rate(struct platform_device *dsidev)
+static unsigned long dsi_get_pll_hsdiv_dispc_rate(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
-	return dsi->current_cinfo.clkout[HSDIV_DISPC];
+	return dsi->pll.cinfo.clkout[HSDIV_DISPC];
 }
 
 static unsigned long dsi_get_pll_hsdiv_dsi_rate(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
-	return dsi->current_cinfo.clkout[HSDIV_DSI];
+	return dsi->pll.cinfo.clkout[HSDIV_DSI];
 }
 
 static unsigned long dsi_get_txbyteclkhs(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
-	return dsi->current_cinfo.clkdco / 16;
+	return dsi->pll.cinfo.clkdco / 16;
 }
 
 static unsigned long dsi_fclk_rate(struct platform_device *dsidev)
@@ -1323,10 +1306,12 @@ static int dsi_set_lp_clk_divisor(struct platform_device *dsidev)
 	unsigned long dsi_fclk;
 	unsigned lp_clk_div;
 	unsigned long lp_clk;
+	unsigned lpdiv_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_LPDIV);
+
 
 	lp_clk_div = dsi->user_lp_cinfo.lp_clk_div;
 
-	if (lp_clk_div == 0 || lp_clk_div > dsi->lpdiv_max)
+	if (lp_clk_div == 0 || lp_clk_div > lpdiv_max)
 		return -EINVAL;
 
 	dsi_fclk = dsi_fclk_rate(dsidev);
@@ -1396,276 +1381,21 @@ static int dsi_pll_power(struct platform_device *dsidev,
 	return 0;
 }
 
-unsigned long dsi_get_pll_clkin(struct platform_device *dsidev)
-{
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	return clk_get_rate(dsi->sys_clk);
-}
-
-bool dsi_hsdiv_calc(struct platform_device *dsidev, unsigned long pll,
-		unsigned long out_min, dsi_hsdiv_calc_func func, void *data)
-{
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	int regm, regm_start, regm_stop;
-	unsigned long out_max;
-	unsigned long out;
-
-	out_min = out_min ? out_min : 1;
-	out_max = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
-
-	regm_start = max(DIV_ROUND_UP(pll, out_max), 1ul);
-	regm_stop = min(pll / out_min, dsi->regm_hsdiv_max);
-
-	for (regm = regm_start; regm <= regm_stop; ++regm) {
-		out = pll / regm;
-
-		if (func(regm, out, data))
-			return true;
-	}
-
-	return false;
-}
-
-bool dsi_pll_calc(struct platform_device *dsidev, unsigned long clkin,
-		unsigned long pll_min, unsigned long pll_max,
-		dsi_pll_calc_func func, void *data)
-{
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	int regn, regn_start, regn_stop;
-	int regm, regm_start, regm_stop;
-	unsigned long fint, pll;
-	const unsigned long pll_hw_max = 1800000000;
-	unsigned long fint_hw_min, fint_hw_max;
-
-	fint_hw_min = dsi->fint_min;
-	fint_hw_max = dsi->fint_max;
-
-	regn_start = max(DIV_ROUND_UP(clkin, fint_hw_max), 1ul);
-	regn_stop = min(clkin / fint_hw_min, dsi->regn_max);
-
-	pll_max = pll_max ? pll_max : ULONG_MAX;
-
-	for (regn = regn_start; regn <= regn_stop; ++regn) {
-		fint = clkin / regn;
-
-		regm_start = max(DIV_ROUND_UP(DIV_ROUND_UP(pll_min, fint), 2),
-				1ul);
-		regm_stop = min3(pll_max / fint / 2,
-				pll_hw_max / fint / 2,
-				dsi->regm_max);
-
-		for (regm = regm_start; regm <= regm_stop; ++regm) {
-			pll = 2 * regm * fint;
-
-			if (func(regn, regm, fint, pll, data))
-				return true;
-		}
-	}
-
-	return false;
-}
-
-/* calculate clock rates using dividers in cinfo */
-static int dsi_calc_clock_rates(struct platform_device *dsidev,
-		struct dsi_clock_info *cinfo)
-{
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-
-	if (cinfo->regn == 0 || cinfo->regn > dsi->regn_max)
-		return -EINVAL;
-
-	if (cinfo->regm == 0 || cinfo->regm > dsi->regm_max)
-		return -EINVAL;
-
-	if (cinfo->regm_hsdiv[HSDIV_DISPC] > dsi->regm_hsdiv_max)
-		return -EINVAL;
-
-	if (cinfo->regm_hsdiv[HSDIV_DSI] > dsi->regm_hsdiv_max)
-		return -EINVAL;
-
-	cinfo->fint = clk_get_rate(dsi->sys_clk) / cinfo->regn;
-
-	if (cinfo->fint > dsi->fint_max || cinfo->fint < dsi->fint_min)
-		return -EINVAL;
-
-	cinfo->clkdco = 2 * cinfo->regm * cinfo->fint;
 
-	if (cinfo->clkdco > 1800 * 1000 * 1000)
-		return -EINVAL;
-
-	if (cinfo->regm_hsdiv[HSDIV_DISPC])
-		cinfo->clkout[HSDIV_DISPC] =
-			cinfo->clkdco / cinfo->regm_hsdiv[HSDIV_DISPC];
-	else
-		cinfo->clkout[HSDIV_DISPC] = 0;
-
-	if (cinfo->regm_hsdiv[HSDIV_DSI])
-		cinfo->clkout[HSDIV_DSI] =
-			cinfo->clkdco / cinfo->regm_hsdiv[HSDIV_DSI];
-	else
-		cinfo->clkout[HSDIV_DSI] = 0;
-
-	return 0;
-}
-
-static void dsi_pll_calc_dsi_fck(struct dsi_clock_info *cinfo)
+static void dsi_pll_calc_dsi_fck(struct dss_pll_clock_info *cinfo)
 {
 	unsigned long max_dsi_fck;
 
 	max_dsi_fck = dss_feat_get_param_max(FEAT_PARAM_DSI_FCK);
 
-	cinfo->regm_hsdiv[HSDIV_DSI] = DIV_ROUND_UP(cinfo->clkdco, max_dsi_fck);
-	cinfo->clkout[HSDIV_DSI] = cinfo->clkdco / cinfo->regm_hsdiv[HSDIV_DSI];
+	cinfo->mX[HSDIV_DSI] = DIV_ROUND_UP(cinfo->clkdco, max_dsi_fck);
+	cinfo->clkout[HSDIV_DSI] = cinfo->clkdco / cinfo->mX[HSDIV_DSI];
 }
 
-static int dsi_wait_hsdiv_ack(struct platform_device *dsidev, u32 hsdiv_ack_mask)
+static int dsi_pll_enable(struct dss_pll *pll)
 {
-	int t = 100;
-
-	while (t-- > 0) {
-		u32 v = dsi_read_reg(dsidev, DSI_PLL_STATUS);
-		v &= hsdiv_ack_mask;
-		if (v == hsdiv_ack_mask)
-			return 0;
-	}
-
-	return -ETIMEDOUT;
-}
-
-int dsi_pll_set_clock_div(struct platform_device *dsidev,
-		struct dsi_clock_info *cinfo)
-{
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	int r = 0;
-	u32 l;
-	int f = 0;
-	u8 regn_start, regn_end, regm_start, regm_end;
-	u8 regm_dispc_start, regm_dispc_end, regm_dsi_start, regm_dsi_end;
-
-	DSSDBG("DSI PLL clock config starts");
-
-	dsi->current_cinfo = *cinfo;
-
-	DSSDBG("DSI Fint %ld\n", cinfo->fint);
-
-	DSSDBG("clkin rate %ld\n", clk_get_rate(dsi->sys_clk));
-
-	/* DSIPHY == CLKIN4DDR */
-	DSSDBG("CLKIN4DDR = 2 * %d / %d * %lu = %lu\n",
-			cinfo->regm,
-			cinfo->regn,
-			clk_get_rate(dsi->sys_clk),
-			cinfo->clkdco);
-
-	DSSDBG("Data rate on 1 DSI lane %ld Mbps\n",
-			cinfo->clkdco / 1000 / 1000 / 2);
-
-	DSSDBG("Clock lane freq %ld Hz\n", cinfo->clkdco / 4);
-
-	DSSDBG("regm_dispc = %d, %s (%s) = %lu\n", cinfo->regm_hsdiv[HSDIV_DISPC],
-		dss_get_generic_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC),
-		dss_feat_get_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC),
-		cinfo->clkout[HSDIV_DISPC]);
-	DSSDBG("regm_dsi = %d, %s (%s) = %lu\n", cinfo->regm_hsdiv[HSDIV_DSI],
-		dss_get_generic_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI),
-		dss_feat_get_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI),
-		cinfo->clkout[HSDIV_DSI]);
-
-	dss_feat_get_reg_field(FEAT_REG_DSIPLL_REGN, &regn_start, &regn_end);
-	dss_feat_get_reg_field(FEAT_REG_DSIPLL_REGM, &regm_start, &regm_end);
-	dss_feat_get_reg_field(FEAT_REG_DSIPLL_REGM_DISPC, &regm_dispc_start,
-			&regm_dispc_end);
-	dss_feat_get_reg_field(FEAT_REG_DSIPLL_REGM_DSI, &regm_dsi_start,
-			&regm_dsi_end);
-
-	/* DSI_PLL_AUTOMODE = manual */
-	REG_FLD_MOD(dsidev, DSI_PLL_CONTROL, 0, 0, 0);
-
-	l = dsi_read_reg(dsidev, DSI_PLL_CONFIGURATION1);
-	l = FLD_MOD(l, 1, 0, 0);		/* DSI_PLL_STOPMODE */
-	/* DSI_PLL_REGN */
-	l = FLD_MOD(l, cinfo->regn - 1, regn_start, regn_end);
-	/* DSI_PLL_REGM */
-	l = FLD_MOD(l, cinfo->regm, regm_start, regm_end);
-	/* DSI_CLOCK_DIV */
-	l = FLD_MOD(l, cinfo->regm_hsdiv[HSDIV_DISPC] > 0 ? cinfo->regm_hsdiv[HSDIV_DISPC] - 1 : 0,
-			regm_dispc_start, regm_dispc_end);
-	/* DSIPROTO_CLOCK_DIV */
-	l = FLD_MOD(l, cinfo->regm_hsdiv[HSDIV_DSI] > 0 ? cinfo->regm_hsdiv[HSDIV_DSI] - 1 : 0,
-			regm_dsi_start, regm_dsi_end);
-	dsi_write_reg(dsidev, DSI_PLL_CONFIGURATION1, l);
-
-	BUG_ON(cinfo->fint < dsi->fint_min || cinfo->fint > dsi->fint_max);
-
-	l = dsi_read_reg(dsidev, DSI_PLL_CONFIGURATION2);
-
-	if (dss_has_feature(FEAT_DSI_PLL_FREQSEL)) {
-		f = cinfo->fint < 1000000 ? 0x3 :
-			cinfo->fint < 1250000 ? 0x4 :
-			cinfo->fint < 1500000 ? 0x5 :
-			cinfo->fint < 1750000 ? 0x6 :
-			0x7;
-
-		l = FLD_MOD(l, f, 4, 1);	/* DSI_PLL_FREQSEL */
-	} else if (dss_has_feature(FEAT_DSI_PLL_SELFREQDCO)) {
-		f = cinfo->clkdco < 1000000000 ? 0x2 : 0x4;
-
-		l = FLD_MOD(l, f, 3, 1);	/* PLL_SELFREQDCO */
-	}
-
-	l = FLD_MOD(l, 1, 13, 13);		/* DSI_PLL_REFEN */
-	l = FLD_MOD(l, 0, 14, 14);		/* DSIPHY_CLKINEN */
-	l = FLD_MOD(l, 1, 20, 20);		/* DSI_HSDIVBYPASS */
-	if (dss_has_feature(FEAT_DSI_PLL_REFSEL))
-		l = FLD_MOD(l, 3, 22, 21);	/* REF_SYSCLK = sysclk */
-	dsi_write_reg(dsidev, DSI_PLL_CONFIGURATION2, l);
-
-	REG_FLD_MOD(dsidev, DSI_PLL_GO, 1, 0, 0);	/* DSI_PLL_GO */
-
-	if (wait_for_bit_change(dsidev, DSI_PLL_GO, 0, 0) != 0) {
-		DSSERR("dsi pll go bit not going down.\n");
-		r = -EIO;
-		goto err;
-	}
-
-	if (wait_for_bit_change(dsidev, DSI_PLL_STATUS, 1, 1) != 1) {
-		DSSERR("cannot lock PLL\n");
-		r = -EIO;
-		goto err;
-	}
-
-	l = dsi_read_reg(dsidev, DSI_PLL_CONFIGURATION2);
-	l = FLD_MOD(l, 0, 0, 0);	/* DSI_PLL_IDLE */
-	l = FLD_MOD(l, 0, 5, 5);	/* DSI_PLL_PLLLPMODE */
-	l = FLD_MOD(l, 0, 6, 6);	/* DSI_PLL_LOWCURRSTBY */
-	l = FLD_MOD(l, 0, 7, 7);	/* DSI_PLL_TIGHTPHASELOCK */
-	l = FLD_MOD(l, 0, 8, 8);	/* DSI_PLL_DRIFTGUARDEN */
-	l = FLD_MOD(l, 0, 10, 9);	/* DSI_PLL_LOCKSEL */
-	l = FLD_MOD(l, 1, 13, 13);	/* DSI_PLL_REFEN */
-	l = FLD_MOD(l, 1, 14, 14);	/* DSIPHY_CLKINEN */
-	l = FLD_MOD(l, 0, 15, 15);	/* DSI_BYPASSEN */
-	l = FLD_MOD(l, 1, 16, 16);	/* DSS_CLOCK_EN */
-	l = FLD_MOD(l, 0, 17, 17);	/* DSS_CLOCK_PWDN */
-	l = FLD_MOD(l, 1, 18, 18);	/* DSI_PROTO_CLOCK_EN */
-	l = FLD_MOD(l, 0, 19, 19);	/* DSI_PROTO_CLOCK_PWDN */
-	l = FLD_MOD(l, 0, 20, 20);	/* DSI_HSDIVBYPASS */
-	dsi_write_reg(dsidev, DSI_PLL_CONFIGURATION2, l);
-
-	r = dsi_wait_hsdiv_ack(dsidev, BIT(7) | BIT(8));
-	if (r) {
-		DSSERR("failed to enable HSDIV clocks: %d\n", r);
-		goto err;
-	}
-
-
-	DSSDBG("PLL config done\n");
-err:
-	return r;
-}
-
-int dsi_pll_init(struct platform_device *dsidev)
-{
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct dsi_data *dsi = container_of(pll, struct dsi_data, pll);
+	struct platform_device *dsidev = dsi->pdev;
 	int r = 0;
 
 	DSSDBG("PLL init\n");
@@ -1678,7 +1408,6 @@ int dsi_pll_init(struct platform_device *dsidev)
 	if (r)
 		return r;
 
-	dsi_enable_pll_clock(dsidev, 1);
 	/*
 	 * Note: SCP CLK is not required on OMAP3, but it is required on OMAP4.
 	 */
@@ -1720,12 +1449,11 @@ err1:
 	}
 err0:
 	dsi_disable_scp_clk(dsidev);
-	dsi_enable_pll_clock(dsidev, 0);
 	dsi_runtime_put(dsidev);
 	return r;
 }
 
-void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes)
+static void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
@@ -1737,19 +1465,27 @@ void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes)
 	}
 
 	dsi_disable_scp_clk(dsidev);
-	dsi_enable_pll_clock(dsidev, 0);
 	dsi_runtime_put(dsidev);
 
 	DSSDBG("PLL uninit done\n");
 }
 
+static void dsi_pll_disable(struct dss_pll *pll)
+{
+	struct dsi_data *dsi = container_of(pll, struct dsi_data, pll);
+	struct platform_device *dsidev = dsi->pdev;
+
+	dsi_pll_uninit(dsidev, true);
+}
+
 static void dsi_dump_dsidev_clocks(struct platform_device *dsidev,
 		struct seq_file *s)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct dsi_clock_info *cinfo = &dsi->current_cinfo;
+	struct dss_pll_clock_info *cinfo = &dsi->pll.cinfo;
 	enum omap_dss_clk_source dispc_clk_src, dsi_clk_src;
 	int dsi_module = dsi->module_id;
+	struct dss_pll *pll = &dsi->pll;
 
 	dispc_clk_src = dss_get_dispc_clk_source();
 	dsi_clk_src = dss_get_dsi_clk_source(dsi_module);
@@ -1759,28 +1495,28 @@ static void dsi_dump_dsidev_clocks(struct platform_device *dsidev,
 
 	seq_printf(s,	"- DSI%d PLL -\n", dsi_module + 1);
 
-	seq_printf(s,	"dsi pll clkin\t%lu\n", clk_get_rate(dsi->sys_clk));
+	seq_printf(s,	"dsi pll clkin\t%lu\n", clk_get_rate(pll->clkin));
 
-	seq_printf(s,	"Fint\t\t%-16luregn %u\n", cinfo->fint, cinfo->regn);
+	seq_printf(s,	"Fint\t\t%-16lun %u\n", cinfo->fint, cinfo->n);
 
-	seq_printf(s,	"CLKIN4DDR\t%-16luregm %u\n",
-			cinfo->clkdco, cinfo->regm);
+	seq_printf(s,	"CLKIN4DDR\t%-16lum %u\n",
+			cinfo->clkdco, cinfo->m);
 
-	seq_printf(s,	"DSI_PLL_HSDIV_DISPC (%s)\t%-16luregm_dispc %u\t(%s)\n",
+	seq_printf(s,	"DSI_PLL_HSDIV_DISPC (%s)\t%-16lum_dispc %u\t(%s)\n",
 			dss_feat_get_clk_source_name(dsi_module == 0 ?
 				OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC :
 				OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC),
 			cinfo->clkout[HSDIV_DISPC],
-			cinfo->regm_hsdiv[HSDIV_DISPC],
+			cinfo->mX[HSDIV_DISPC],
 			dispc_clk_src == OMAP_DSS_CLK_SRC_FCK ?
 			"off" : "on");
 
-	seq_printf(s,	"DSI_PLL_HSDIV_DSI (%s)\t%-16luregm_dsi %u\t(%s)\n",
+	seq_printf(s,	"DSI_PLL_HSDIV_DSI (%s)\t%-16lum_dsi %u\t(%s)\n",
 			dss_feat_get_clk_source_name(dsi_module == 0 ?
 				OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI :
 				OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI),
 			cinfo->clkout[HSDIV_DSI],
-			cinfo->regm_hsdiv[HSDIV_DSI],
+			cinfo->mX[HSDIV_DSI],
 			dsi_clk_src == OMAP_DSS_CLK_SRC_FCK ?
 			"off" : "on");
 
@@ -2132,7 +1868,7 @@ static inline unsigned ns2ddr(struct platform_device *dsidev, unsigned ns)
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	/* convert time in ns to ddr ticks, rounding up */
-	unsigned long ddr_clk = dsi->current_cinfo.clkdco / 4;
+	unsigned long ddr_clk = dsi->pll.cinfo.clkdco / 4;
 	return (ns * (ddr_clk / 1000 / 1000) + 999) / 1000;
 }
 
@@ -2140,7 +1876,7 @@ static inline unsigned ddr2ns(struct platform_device *dsidev, unsigned ddr)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
-	unsigned long ddr_clk = dsi->current_cinfo.clkdco / 4;
+	unsigned long ddr_clk = dsi->pll.cinfo.clkdco / 4;
 	return ddr * 1000 * 1000 / (ddr_clk / 1000);
 }
 
@@ -3730,7 +3466,7 @@ static void dsi_config_cmd_mode_interleaving(struct platform_device *dsidev)
 	struct omap_video_timings *timings = &dsi->timings;
 	int bpp = dsi_get_pixel_size(dsi->pix_fmt);
 	int ndl = dsi->num_lanes_used - 1;
-	int dsi_fclk_hsdiv = dsi->user_dsi_cinfo.regm_hsdiv[HSDIV_DSI] + 1;
+	int dsi_fclk_hsdiv = dsi->user_dsi_cinfo.mX[HSDIV_DSI] + 1;
 	int hsa_interleave_hs = 0, hsa_interleave_lp = 0;
 	int hfp_interleave_hs = 0, hfp_interleave_lp = 0;
 	int hbp_interleave_hs = 0, hbp_interleave_lp = 0;
@@ -4441,18 +4177,12 @@ static void dsi_display_uninit_dispc(struct platform_device *dsidev,
 static int dsi_configure_dsi_clocks(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct dsi_clock_info cinfo;
+	struct dss_pll_clock_info cinfo;
 	int r;
 
 	cinfo = dsi->user_dsi_cinfo;
 
-	r = dsi_calc_clock_rates(dsidev, &cinfo);
-	if (r) {
-		DSSERR("Failed to calc dsi clocks\n");
-		return r;
-	}
-
-	r = dsi_pll_set_clock_div(dsidev, &cinfo);
+	r = dss_pll_set_config(&dsi->pll, &cinfo);
 	if (r) {
 		DSSERR("Failed to set dsi clocks\n");
 		return r;
@@ -4466,7 +4196,7 @@ static int dsi_display_init_dsi(struct platform_device *dsidev)
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int r;
 
-	r = dsi_pll_init(dsidev);
+	r = dss_pll_enable(&dsi->pll);
 	if (r)
 		goto err0;
 
@@ -4510,7 +4240,7 @@ err3:
 err2:
 	dss_select_dsi_clk_source(dsi->module_id, OMAP_DSS_CLK_SRC_FCK);
 err1:
-	dsi_pll_uninit(dsidev, true);
+	dss_pll_disable(&dsi->pll);
 err0:
 	return r;
 }
@@ -4551,8 +4281,6 @@ static int dsi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_get_dsi;
 
-	dsi_enable_pll_clock(dsidev, 1);
-
 	_dsi_initialize_irq(dsidev);
 
 	r = dsi_display_init_dsi(dsidev);
@@ -4564,7 +4292,6 @@ static int dsi_display_enable(struct omap_dss_device *dssdev)
 	return 0;
 
 err_init_dsi:
-	dsi_enable_pll_clock(dsidev, 0);
 	dsi_runtime_put(dsidev);
 err_get_dsi:
 	mutex_unlock(&dsi->lock);
@@ -4592,7 +4319,6 @@ static void dsi_display_disable(struct omap_dss_device *dssdev,
 	dsi_display_uninit_dsi(dsidev, disconnect_lanes, enter_ulps);
 
 	dsi_runtime_put(dsidev);
-	dsi_enable_pll_clock(dsidev, 0);
 
 	mutex_unlock(&dsi->lock);
 }
@@ -4713,29 +4439,30 @@ static bool dsi_cm_calc_dispc_cb(int lckd, int pckd, unsigned long lck,
 	return true;
 }
 
-static bool dsi_cm_calc_hsdiv_cb(int regm_dispc, unsigned long dispc,
+static bool dsi_cm_calc_hsdiv_cb(int m_dispc, unsigned long dispc,
 		void *data)
 {
 	struct dsi_clk_calc_ctx *ctx = data;
 
-	ctx->dsi_cinfo.regm_hsdiv[HSDIV_DISPC] = regm_dispc;
+	ctx->dsi_cinfo.mX[HSDIV_DISPC] = m_dispc;
 	ctx->dsi_cinfo.clkout[HSDIV_DISPC] = dispc;
 
 	return dispc_div_calc(dispc, ctx->req_pck_min, ctx->req_pck_max,
 			dsi_cm_calc_dispc_cb, ctx);
 }
 
-static bool dsi_cm_calc_pll_cb(int regn, int regm, unsigned long fint,
-		unsigned long pll, void *data)
+static bool dsi_cm_calc_pll_cb(int n, int m, unsigned long fint,
+		unsigned long clkdco, void *data)
 {
 	struct dsi_clk_calc_ctx *ctx = data;
 
-	ctx->dsi_cinfo.regn = regn;
-	ctx->dsi_cinfo.regm = regm;
+	ctx->dsi_cinfo.n = n;
+	ctx->dsi_cinfo.m = m;
 	ctx->dsi_cinfo.fint = fint;
-	ctx->dsi_cinfo.clkdco = pll;
+	ctx->dsi_cinfo.clkdco = clkdco;
 
-	return dsi_hsdiv_calc(ctx->dsidev, pll, ctx->req_pck_min,
+	return dss_pll_hsdiv_calc(ctx->pll, clkdco, ctx->req_pck_min,
+			dss_feat_get_param_max(FEAT_PARAM_DSS_FCK),
 			dsi_cm_calc_hsdiv_cb, ctx);
 }
 
@@ -4748,7 +4475,7 @@ static bool dsi_cm_calc(struct dsi_data *dsi,
 	unsigned long pll_min, pll_max;
 	unsigned long pck, txbyteclk;
 
-	clkin = clk_get_rate(dsi->sys_clk);
+	clkin = clk_get_rate(dsi->pll.clkin);
 	bitspp = dsi_get_pixel_size(cfg->pixel_format);
 	ndl = dsi->num_lanes_used - 1;
 
@@ -4764,6 +4491,7 @@ static bool dsi_cm_calc(struct dsi_data *dsi,
 
 	memset(ctx, 0, sizeof(*ctx));
 	ctx->dsidev = dsi->pdev;
+	ctx->pll = &dsi->pll;
 	ctx->config = cfg;
 	ctx->req_pck_min = pck;
 	ctx->req_pck_nom = pck;
@@ -4772,7 +4500,7 @@ static bool dsi_cm_calc(struct dsi_data *dsi,
 	pll_min = max(cfg->hs_clk_min * 4, txbyteclk * 4 * 4);
 	pll_max = cfg->hs_clk_max * 4;
 
-	return dsi_pll_calc(dsi->pdev, clkin,
+	return dss_pll_calc(ctx->pll, clkin,
 			pll_min, pll_max,
 			dsi_cm_calc_pll_cb, ctx);
 }
@@ -4998,13 +4726,13 @@ static bool dsi_vm_calc_dispc_cb(int lckd, int pckd, unsigned long lck,
 	return true;
 }
 
-static bool dsi_vm_calc_hsdiv_cb(int regm_dispc, unsigned long dispc,
+static bool dsi_vm_calc_hsdiv_cb(int m_dispc, unsigned long dispc,
 		void *data)
 {
 	struct dsi_clk_calc_ctx *ctx = data;
 	unsigned long pck_max;
 
-	ctx->dsi_cinfo.regm_hsdiv[HSDIV_DISPC] = regm_dispc;
+	ctx->dsi_cinfo.mX[HSDIV_DISPC] = m_dispc;
 	ctx->dsi_cinfo.clkout[HSDIV_DISPC] = dispc;
 
 	/*
@@ -5021,17 +4749,18 @@ static bool dsi_vm_calc_hsdiv_cb(int regm_dispc, unsigned long dispc,
 			dsi_vm_calc_dispc_cb, ctx);
 }
 
-static bool dsi_vm_calc_pll_cb(int regn, int regm, unsigned long fint,
-		unsigned long pll, void *data)
+static bool dsi_vm_calc_pll_cb(int n, int m, unsigned long fint,
+		unsigned long clkdco, void *data)
 {
 	struct dsi_clk_calc_ctx *ctx = data;
 
-	ctx->dsi_cinfo.regn = regn;
-	ctx->dsi_cinfo.regm = regm;
+	ctx->dsi_cinfo.n = n;
+	ctx->dsi_cinfo.m = m;
 	ctx->dsi_cinfo.fint = fint;
-	ctx->dsi_cinfo.clkdco = pll;
+	ctx->dsi_cinfo.clkdco = clkdco;
 
-	return dsi_hsdiv_calc(ctx->dsidev, pll, ctx->req_pck_min,
+	return dss_pll_hsdiv_calc(ctx->pll, clkdco, ctx->req_pck_min,
+			dss_feat_get_param_max(FEAT_PARAM_DSS_FCK),
 			dsi_vm_calc_hsdiv_cb, ctx);
 }
 
@@ -5047,10 +4776,11 @@ static bool dsi_vm_calc(struct dsi_data *dsi,
 	int bitspp = dsi_get_pixel_size(cfg->pixel_format);
 	unsigned long byteclk_min;
 
-	clkin = clk_get_rate(dsi->sys_clk);
+	clkin = clk_get_rate(dsi->pll.clkin);
 
 	memset(ctx, 0, sizeof(*ctx));
 	ctx->dsidev = dsi->pdev;
+	ctx->pll = &dsi->pll;
 	ctx->config = cfg;
 
 	/* these limits should come from the panel driver */
@@ -5071,7 +4801,7 @@ static bool dsi_vm_calc(struct dsi_data *dsi,
 		pll_max = byteclk_max * 4 * 4;
 	}
 
-	return dsi_pll_calc(dsi->pdev, clkin,
+	return dss_pll_calc(ctx->pll, clkin,
 			pll_min, pll_max,
 			dsi_vm_calc_pll_cb, ctx);
 }
@@ -5232,19 +4962,6 @@ static void dsi_release_vc(struct omap_dss_device *dssdev, int channel)
 }
 
 
-static void dsi_calc_clock_param_ranges(struct platform_device *dsidev)
-{
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-
-	dsi->regn_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGN);
-	dsi->regm_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGM);
-	dsi->regm_hsdiv_max =
-		dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGM_HSDIV);
-	dsi->fint_min = dss_feat_get_param_min(FEAT_PARAM_DSIPLL_FINT);
-	dsi->fint_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_FINT);
-	dsi->lpdiv_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_LPDIV);
-}
-
 static int dsi_get_clocks(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
@@ -5258,14 +4975,6 @@ static int dsi_get_clocks(struct platform_device *dsidev)
 
 	dsi->dss_clk = clk;
 
-	clk = devm_clk_get(&dsidev->dev, "sys_clk");
-	if (IS_ERR(clk)) {
-		DSSERR("can't get sys_clk\n");
-		return PTR_ERR(clk);
-	}
-
-	dsi->sys_clk = clk;
-
 	return 0;
 }
 
@@ -5434,6 +5143,135 @@ err:
 	return r;
 }
 
+static const struct dss_pll_ops dsi_pll_ops = {
+	.enable = dsi_pll_enable,
+	.disable = dsi_pll_disable,
+	.set_config = dss_pll_write_config_type_a,
+};
+
+static const struct dss_pll_hw dss_omap3_dsi_pll_hw = {
+	.n_max = (1 << 7) - 1,
+	.m_max = (1 << 11) - 1,
+	.mX_max = (1 << 4) - 1,
+	.fint_min = 750000,
+	.fint_max = 2100000,
+	.clkdco_low = 1000000000,
+	.clkdco_max = 1800000000,
+
+	.n_msb = 7,
+	.n_lsb = 1,
+	.m_msb = 18,
+	.m_lsb = 8,
+
+	.mX_msb[0] = 22,
+	.mX_lsb[0] = 19,
+	.mX_msb[1] = 26,
+	.mX_lsb[1] = 23,
+
+	.has_stopmode = true,
+	.has_freqsel = true,
+	.has_selfreqdco = false,
+	.has_refsel = false,
+};
+
+static const struct dss_pll_hw dss_omap4_dsi_pll_hw = {
+	.n_max = (1 << 8) - 1,
+	.m_max = (1 << 12) - 1,
+	.mX_max = (1 << 5) - 1,
+	.fint_min = 500000,
+	.fint_max = 2500000,
+	.clkdco_low = 1000000000,
+	.clkdco_max = 1800000000,
+
+	.n_msb = 8,
+	.n_lsb = 1,
+	.m_msb = 20,
+	.m_lsb = 9,
+
+	.mX_msb[0] = 25,
+	.mX_lsb[0] = 21,
+	.mX_msb[1] = 30,
+	.mX_lsb[1] = 26,
+
+	.has_stopmode = true,
+	.has_freqsel = false,
+	.has_selfreqdco = false,
+	.has_refsel = false,
+};
+
+static const struct dss_pll_hw dss_omap5_dsi_pll_hw = {
+	.n_max = (1 << 8) - 1,
+	.m_max = (1 << 12) - 1,
+	.mX_max = (1 << 5) - 1,
+	.fint_min = 150000,
+	.fint_max = 52000000,
+	.clkdco_low = 1000000000,
+	.clkdco_max = 1800000000,
+
+	.n_msb = 8,
+	.n_lsb = 1,
+	.m_msb = 20,
+	.m_lsb = 9,
+
+	.mX_msb[0] = 25,
+	.mX_lsb[0] = 21,
+	.mX_msb[1] = 30,
+	.mX_lsb[1] = 26,
+
+	.has_stopmode = true,
+	.has_freqsel = false,
+	.has_selfreqdco = true,
+	.has_refsel = true,
+};
+
+static int dsi_init_pll_data(struct platform_device *dsidev)
+{
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct dss_pll *pll = &dsi->pll;
+	struct clk *clk;
+	int r;
+
+	clk = devm_clk_get(&dsidev->dev, "sys_clk");
+	if (IS_ERR(clk)) {
+		DSSERR("can't get sys_clk\n");
+		return PTR_ERR(clk);
+	}
+
+	pll->name = dsi->module_id == 0 ? "dsi0" : "dsi1";
+	pll->clkin = clk;
+	pll->base = dsi->pll_base;
+
+	switch (omapdss_get_version()) {
+	case OMAPDSS_VER_OMAP34xx_ES1:
+	case OMAPDSS_VER_OMAP34xx_ES3:
+	case OMAPDSS_VER_OMAP3630:
+	case OMAPDSS_VER_AM35xx:
+		pll->hw = &dss_omap3_dsi_pll_hw;
+		break;
+
+	case OMAPDSS_VER_OMAP4430_ES1:
+	case OMAPDSS_VER_OMAP4430_ES2:
+	case OMAPDSS_VER_OMAP4:
+		pll->hw = &dss_omap4_dsi_pll_hw;
+		break;
+
+	case OMAPDSS_VER_OMAP5:
+		pll->hw = &dss_omap5_dsi_pll_hw;
+		break;
+
+	default:
+		return -ENODEV;
+	}
+
+	pll->ops = &dsi_pll_ops;
+
+	r = dss_pll_register(pll);
+	if (r)
+		return r;
+
+	return 0;
+}
+
 /* DSI1 HW IP initialisation */
 static int omap_dsihw_probe(struct platform_device *dsidev)
 {
@@ -5579,12 +5417,12 @@ static int omap_dsihw_probe(struct platform_device *dsidev)
 		dsi->vc[i].vc_id = 0;
 	}
 
-	dsi_calc_clock_param_ranges(dsidev);
-
 	r = dsi_get_clocks(dsidev);
 	if (r)
 		return r;
 
+	dsi_init_pll_data(dsidev);
+
 	pm_runtime_enable(&dsidev->dev);
 
 	r = dsi_runtime_get(dsidev);
@@ -5653,6 +5491,8 @@ static int __exit omap_dsihw_remove(struct platform_device *dsidev)
 
 	WARN_ON(dsi->scp_clk_refcount > 0);
 
+	dss_pll_unregister(&dsi->pll);
+
 	dsi_uninit_output(dsidev);
 
 	pm_runtime_disable(&dsidev->dev);
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index 8563e2bc702c..14fb0c23f4a2 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -173,18 +173,6 @@ struct dispc_clock_info {
 	u16 pck_div;
 };
 
-struct dsi_clock_info {
-	/* rates that we get with dividers below */
-	unsigned long fint;
-	unsigned long clkdco;
-	unsigned long clkout[4];
-
-	/* dividers */
-	u16 regn;
-	u16 regm;
-	u16 regm_hsdiv[4];
-};
-
 struct dss_lcd_mgr_config {
 	enum dss_io_pad_mode io_pad_mode;
 
@@ -318,11 +306,6 @@ static inline void __exit sdi_uninit_port(struct device_node *port)
 
 /* DSI */
 
-typedef bool (*dsi_pll_calc_func)(int regn, int regm, unsigned long fint,
-		unsigned long pll, void *data);
-typedef bool (*dsi_hsdiv_calc_func)(int regm_dispc, unsigned long dispc,
-		void *data);
-
 #ifdef CONFIG_OMAP2_DSS_DSI
 
 struct dentry;
@@ -336,71 +319,12 @@ void dsi_dump_clocks(struct seq_file *s);
 void dsi_irq_handler(void);
 u8 dsi_get_pixel_size(enum omap_dss_dsi_pixel_format fmt);
 
-unsigned long dsi_get_pll_clkin(struct platform_device *dsidev);
-
-bool dsi_hsdiv_calc(struct platform_device *dsidev, unsigned long pll,
-		unsigned long out_min, dsi_hsdiv_calc_func func, void *data);
-bool dsi_pll_calc(struct platform_device *dsidev, unsigned long clkin,
-		unsigned long pll_min, unsigned long pll_max,
-		dsi_pll_calc_func func, void *data);
-
-unsigned long dsi_get_pll_hsdiv_dispc_rate(struct platform_device *dsidev);
-int dsi_pll_set_clock_div(struct platform_device *dsidev,
-		struct dsi_clock_info *cinfo);
-int dsi_pll_init(struct platform_device *dsidev);
-void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes);
-struct platform_device *dsi_get_dsidev_from_id(int module);
 #else
 static inline u8 dsi_get_pixel_size(enum omap_dss_dsi_pixel_format fmt)
 {
 	WARN("%s: DSI not compiled in, returning pixel_size as 0\n", __func__);
 	return 0;
 }
-static inline unsigned long dsi_get_pll_hsdiv_dispc_rate(struct platform_device *dsidev)
-{
-	WARN("%s: DSI not compiled in, returning rate as 0\n", __func__);
-	return 0;
-}
-static inline int dsi_pll_set_clock_div(struct platform_device *dsidev,
-		struct dsi_clock_info *cinfo)
-{
-	WARN("%s: DSI not compiled in\n", __func__);
-	return -ENODEV;
-}
-static inline int dsi_pll_init(struct platform_device *dsidev)
-{
-	WARN("%s: DSI not compiled in\n", __func__);
-	return -ENODEV;
-}
-static inline void dsi_pll_uninit(struct platform_device *dsidev,
-		bool disconnect_lanes)
-{
-}
-static inline struct platform_device *dsi_get_dsidev_from_id(int module)
-{
-	return NULL;
-}
-
-static inline unsigned long dsi_get_pll_clkin(struct platform_device *dsidev)
-{
-	return 0;
-}
-
-static inline bool dsi_hsdiv_calc(struct platform_device *dsidev,
-		unsigned long pll, unsigned long out_min,
-		dsi_hsdiv_calc_func func, void *data)
-{
-	return false;
-}
-
-static inline bool dsi_pll_calc(struct platform_device *dsidev,
-		unsigned long clkin,
-		unsigned long pll_min, unsigned long pll_max,
-		dsi_pll_calc_func func, void *data)
-{
-	return false;
-}
-
 #endif
 
 /* DPI */
-- 
2.1.3

