From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 11/14] OMAPDSS: DPI: use new clock calculation code
Date: Fri, 8 Mar 2013 13:52:46 +0200
Message-ID: <1362743569-10289-12-git-send-email-tomi.valkeinen@ti.com>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33558 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933917Ab3CHLx2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:53:28 -0500
In-Reply-To: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new clock calculation code in the DPI driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c |  212 +++++++++++++++++++++++++++++++++--------
 1 file changed, 172 insertions(+), 40 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 775214c..c7363b1 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -91,31 +91,170 @@ static enum omap_dss_clk_source dpi_get_alt_clk_src(enum omap_channel channel)
 	}
 }
 
+struct dpi_clk_calc_ctx {
+	struct platform_device *dsidev;
+
+	/* inputs */
+
+	unsigned long pck_min, pck_max;
+
+	/* outputs */
+
+	struct dsi_clock_info dsi_cinfo;
+	struct dss_clock_info dss_cinfo;
+	struct dispc_clock_info dispc_cinfo;
+};
+
+static bool dpi_calc_dispc_cb(int lckd, int pckd, unsigned long lck,
+		unsigned long pck, void *data)
+{
+	struct dpi_clk_calc_ctx *ctx = data;
+
+	/*
+	 * Odd dividers give us uneven duty cycle, causing problem when level
+	 * shifted. So skip all odd dividers when the pixel clock is on the
+	 * higher side.
+	 */
+	if (ctx->pck_min >= 1000000) {
+		if (lckd > 1 && lckd % 2 != 0)
+			return false;
+
+		if (pckd > 1 && pckd % 2 != 0)
+			return false;
+	}
+
+	ctx->dispc_cinfo.lck_div = lckd;
+	ctx->dispc_cinfo.pck_div = pckd;
+	ctx->dispc_cinfo.lck = lck;
+	ctx->dispc_cinfo.pck = pck;
+
+	return true;
+}
+
+
+static bool dpi_calc_hsdiv_cb(int regm_dispc, unsigned long dispc,
+		void *data)
+{
+	struct dpi_clk_calc_ctx *ctx = data;
+
+	/*
+	 * Odd dividers give us uneven duty cycle, causing problem when level
+	 * shifted. So skip all odd dividers when the pixel clock is on the
+	 * higher side.
+	 */
+	if (regm_dispc > 1 && regm_dispc % 2 != 0 && ctx->pck_min >= 1000000)
+		return false;
+
+	ctx->dsi_cinfo.regm_dispc = regm_dispc;
+	ctx->dsi_cinfo.dsi_pll_hsdiv_dispc_clk = dispc;
+
+	return dispc_div_calc(dispc, ctx->pck_min, ctx->pck_max,
+			dpi_calc_dispc_cb, ctx);
+}
+
+
+static bool dpi_calc_pll_cb(int regn, int regm, unsigned long fint,
+		unsigned long pll,
+		void *data)
+{
+	struct dpi_clk_calc_ctx *ctx = data;
+
+	ctx->dsi_cinfo.regn = regn;
+	ctx->dsi_cinfo.regm = regm;
+	ctx->dsi_cinfo.fint = fint;
+	ctx->dsi_cinfo.clkin4ddr = pll;
+
+	return dsi_hsdiv_calc(ctx->dsidev, pll, ctx->pck_min,
+			dpi_calc_hsdiv_cb, ctx);
+}
+
+static bool dpi_calc_dss_cb(int fckd, unsigned long fck, void *data)
+{
+	struct dpi_clk_calc_ctx *ctx = data;
+
+	ctx->dss_cinfo.fck = fck;
+	ctx->dss_cinfo.fck_div = fckd;
+
+	return dispc_div_calc(fck, ctx->pck_min, ctx->pck_max,
+			dpi_calc_dispc_cb, ctx);
+}
+
+static bool dpi_dsi_clk_calc(unsigned long pck, struct dpi_clk_calc_ctx *ctx)
+{
+	unsigned long clkin;
+	unsigned long pll_min, pll_max;
+
+	clkin = dsi_get_pll_clkin(dpi.dsidev);
+
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->dsidev = dpi.dsidev;
+	ctx->pck_min = pck - 1000;
+	ctx->pck_max = pck + 1000;
+	ctx->dsi_cinfo.clkin = clkin;
+
+	pll_min = 0;
+	pll_max = 0;
+
+	return dsi_pll_calc(dpi.dsidev, clkin,
+			pll_min, pll_max,
+			dpi_calc_pll_cb, ctx);
+}
+
+static bool dpi_dss_clk_calc(unsigned long pck, struct dpi_clk_calc_ctx *ctx)
+{
+	int i;
+
+	/*
+	 * DSS fck gives us very few possibilities, so finding a good pixel
+	 * clock may not be possible. We try multiple times to find the clock,
+	 * each time widening the pixel clock range we look for, up to
+	 * +/- 1MHz.
+	 */
+
+	for (i = 0; i < 10; ++i) {
+		bool ok;
+
+		memset(ctx, 0, sizeof(*ctx));
+		if (pck > 1000 * i * i * i)
+			ctx->pck_min = max(pck - 1000 * i * i * i, 0lu);
+		else
+			ctx->pck_min = 0;
+		ctx->pck_max = pck + 1000 * i * i * i;
+
+		ok = dss_div_calc(ctx->pck_min, dpi_calc_dss_cb, ctx);
+		if (ok)
+			return ok;
+	}
+
+	return false;
+}
+
+
+
 static int dpi_set_dsi_clk(enum omap_channel channel,
 		unsigned long pck_req, unsigned long *fck, int *lck_div,
 		int *pck_div)
 {
-	struct dsi_clock_info dsi_cinfo;
-	struct dispc_clock_info dispc_cinfo;
+	struct dpi_clk_calc_ctx ctx;
 	int r;
+	bool ok;
 
-	r = dsi_pll_calc_clock_div_pck(dpi.dsidev, pck_req, &dsi_cinfo,
-			&dispc_cinfo);
-	if (r)
-		return r;
+	ok = dpi_dsi_clk_calc(pck_req, &ctx);
+	if (!ok)
+		return -EINVAL;
 
-	r = dsi_pll_set_clock_div(dpi.dsidev, &dsi_cinfo);
+	r = dsi_pll_set_clock_div(dpi.dsidev, &ctx.dsi_cinfo);
 	if (r)
 		return r;
 
 	dss_select_lcd_clk_source(channel,
 			dpi_get_alt_clk_src(channel));
 
-	dpi.mgr_config.clock_info = dispc_cinfo;
+	dpi.mgr_config.clock_info = ctx.dispc_cinfo;
 
-	*fck = dsi_cinfo.dsi_pll_hsdiv_dispc_clk;
-	*lck_div = dispc_cinfo.lck_div;
-	*pck_div = dispc_cinfo.pck_div;
+	*fck = ctx.dsi_cinfo.dsi_pll_hsdiv_dispc_clk;
+	*lck_div = ctx.dispc_cinfo.lck_div;
+	*pck_div = ctx.dispc_cinfo.pck_div;
 
 	return 0;
 }
@@ -123,23 +262,23 @@ static int dpi_set_dsi_clk(enum omap_channel channel,
 static int dpi_set_dispc_clk(unsigned long pck_req, unsigned long *fck,
 		int *lck_div, int *pck_div)
 {
-	struct dss_clock_info dss_cinfo;
-	struct dispc_clock_info dispc_cinfo;
+	struct dpi_clk_calc_ctx ctx;
 	int r;
+	bool ok;
 
-	r = dss_calc_clock_div(pck_req, &dss_cinfo, &dispc_cinfo);
-	if (r)
-		return r;
+	ok = dpi_dss_clk_calc(pck_req, &ctx);
+	if (!ok)
+		return -EINVAL;
 
-	r = dss_set_clock_div(&dss_cinfo);
+	r = dss_set_clock_div(&ctx.dss_cinfo);
 	if (r)
 		return r;
 
-	dpi.mgr_config.clock_info = dispc_cinfo;
+	dpi.mgr_config.clock_info = ctx.dispc_cinfo;
 
-	*fck = dss_cinfo.fck;
-	*lck_div = dispc_cinfo.lck_div;
-	*pck_div = dispc_cinfo.pck_div;
+	*fck = ctx.dss_cinfo.fck;
+	*lck_div = ctx.dispc_cinfo.lck_div;
+	*pck_div = ctx.dispc_cinfo.pck_div;
 
 	return 0;
 }
@@ -319,12 +458,12 @@ EXPORT_SYMBOL(omapdss_dpi_set_timings);
 int dpi_check_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
 {
-	int r;
 	struct omap_overlay_manager *mgr = dpi.output.manager;
 	int lck_div, pck_div;
 	unsigned long fck;
 	unsigned long pck;
-	struct dispc_clock_info dispc_cinfo;
+	struct dpi_clk_calc_ctx ctx;
+	bool ok;
 
 	if (mgr && !dispc_mgr_timings_ok(mgr->id, timings))
 		return -EINVAL;
@@ -333,28 +472,21 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 		return -EINVAL;
 
 	if (dpi.dsidev) {
-		struct dsi_clock_info dsi_cinfo;
-		r = dsi_pll_calc_clock_div_pck(dpi.dsidev,
-				timings->pixel_clock * 1000,
-				&dsi_cinfo, &dispc_cinfo);
+		ok = dpi_dsi_clk_calc(timings->pixel_clock * 1000, &ctx);
+		if (!ok)
+			return -EINVAL;
 
-		if (r)
-			return r;
-
-		fck = dsi_cinfo.dsi_pll_hsdiv_dispc_clk;
+		fck = ctx.dsi_cinfo.dsi_pll_hsdiv_dispc_clk;
 	} else {
-		struct dss_clock_info dss_cinfo;
-		r = dss_calc_clock_div(timings->pixel_clock * 1000,
-				&dss_cinfo, &dispc_cinfo);
-
-		if (r)
-			return r;
+		ok = dpi_dss_clk_calc(timings->pixel_clock * 1000, &ctx);
+		if (!ok)
+			return -EINVAL;
 
-		fck = dss_cinfo.fck;
+		fck = ctx.dss_cinfo.fck;
 	}
 
-	lck_div = dispc_cinfo.lck_div;
-	pck_div = dispc_cinfo.pck_div;
+	lck_div = ctx.dispc_cinfo.lck_div;
+	pck_div = ctx.dispc_cinfo.pck_div;
 
 	pck = fck / lck_div / pck_div / 1000;
 
-- 
1.7.10.4

