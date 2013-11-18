From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/7] OMAPDSS: remove struct dss_clock_info
Date: Mon, 18 Nov 2013 14:38:59 +0200
Message-ID: <1384778344-8226-3-git-send-email-tomi.valkeinen@ti.com>
References: <1384778344-8226-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45007 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421Ab3KRMjT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Nov 2013 07:39:19 -0500
In-Reply-To: <1384778344-8226-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Remove struct dss_clock_info, as it is not usable in a case where DSS
fclk comes from a dedicated PLL. Instead, just use the fclk rate in
place of dss_clock_info, as that is all that's needed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c | 13 +++++-----
 drivers/video/omap2/dss/dss.c | 59 ++++++++++---------------------------------
 drivers/video/omap2/dss/dss.h | 13 ++--------
 drivers/video/omap2/dss/sdi.c | 19 +++++++-------
 4 files changed, 30 insertions(+), 74 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index bd48cde..16acddd 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -117,7 +117,7 @@ struct dpi_clk_calc_ctx {
 	/* outputs */
 
 	struct dsi_clock_info dsi_cinfo;
-	struct dss_clock_info dss_cinfo;
+	unsigned long long fck;
 	struct dispc_clock_info dispc_cinfo;
 };
 
@@ -184,12 +184,11 @@ static bool dpi_calc_pll_cb(int regn, int regm, unsigned long fint,
 			dpi_calc_hsdiv_cb, ctx);
 }
 
-static bool dpi_calc_dss_cb(int fckd, unsigned long fck, void *data)
+static bool dpi_calc_dss_cb(unsigned long fck, void *data)
 {
 	struct dpi_clk_calc_ctx *ctx = data;
 
-	ctx->dss_cinfo.fck = fck;
-	ctx->dss_cinfo.fck_div = fckd;
+	ctx->fck = fck;
 
 	return dispc_div_calc(fck, ctx->pck_min, ctx->pck_max,
 			dpi_calc_dispc_cb, ctx);
@@ -286,13 +285,13 @@ static int dpi_set_dispc_clk(unsigned long pck_req, unsigned long *fck,
 	if (!ok)
 		return -EINVAL;
 
-	r = dss_set_clock_div(&ctx.dss_cinfo);
+	r = dss_set_fck_rate(ctx.fck);
 	if (r)
 		return r;
 
 	dpi.mgr_config.clock_info = ctx.dispc_cinfo;
 
-	*fck = ctx.dss_cinfo.fck;
+	*fck = ctx.fck;
 	*lck_div = ctx.dispc_cinfo.lck_div;
 	*pck_div = ctx.dispc_cinfo.pck_div;
 
@@ -495,7 +494,7 @@ static int dpi_check_timings(struct omap_dss_device *dssdev,
 		if (!ok)
 			return -EINVAL;
 
-		fck = ctx.dss_cinfo.fck;
+		fck = ctx.fck;
 	}
 
 	lck_div = ctx.dispc_cinfo.lck_div;
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index e59577a..c37d934 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -81,7 +81,6 @@ static struct {
 
 	unsigned long	cache_req_pck;
 	unsigned long	cache_prate;
-	struct dss_clock_info cache_dss_cinfo;
 	struct dispc_clock_info cache_dispc_cinfo;
 
 	enum omap_dss_clk_source dsi_clk_source[MAX_NUM_DSI];
@@ -451,29 +450,6 @@ enum omap_dss_clk_source dss_get_lcd_clk_source(enum omap_channel channel)
 	}
 }
 
-/* calculate clock rates using dividers in cinfo */
-int dss_calc_clock_rates(struct dss_clock_info *cinfo)
-{
-	if (dss.dpll4_m4_ck) {
-		unsigned long prate;
-
-		if (cinfo->fck_div > dss.feat->fck_div_max ||
-				cinfo->fck_div == 0)
-			return -EINVAL;
-
-		prate = clk_get_rate(clk_get_parent(dss.dpll4_m4_ck));
-
-		cinfo->fck = prate / cinfo->fck_div *
-			dss.feat->dss_fck_multiplier;
-	} else {
-		if (cinfo->fck_div != 0)
-			return -EINVAL;
-		cinfo->fck = clk_get_rate(dss.dss_clk);
-	}
-
-	return 0;
-}
-
 bool dss_div_calc(unsigned long fck_min, dss_div_calc_func func, void *data)
 {
 	int fckd, fckd_start, fckd_stop;
@@ -485,8 +461,7 @@ bool dss_div_calc(unsigned long fck_min, dss_div_calc_func func, void *data)
 
 	if (dss.dpll4_m4_ck == NULL) {
 		fck = clk_get_rate(dss.dss_clk);
-		fckd = 1;
-		return func(fckd, fck, data);
+		return func(fck, data);
 	}
 
 	fck_hw_max = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
@@ -503,38 +478,35 @@ bool dss_div_calc(unsigned long fck_min, dss_div_calc_func func, void *data)
 	for (fckd = fckd_start; fckd >= fckd_stop; --fckd) {
 		fck = prate / fckd * m;
 
-		if (func(fckd, fck, data))
+		if (func(fck, data))
 			return true;
 	}
 
 	return false;
 }
 
-int dss_set_clock_div(struct dss_clock_info *cinfo)
+int dss_set_fck_rate(unsigned long rate)
 {
+	DSSDBG("set fck to %lu\n", rate);
+
 	if (dss.dpll4_m4_ck) {
 		unsigned long prate;
+		unsigned m;
 		int r;
 
 		prate = clk_get_rate(clk_get_parent(dss.dpll4_m4_ck));
-		DSSDBG("dpll4_m4 = %ld\n", prate);
+		m = dss.feat->dss_fck_multiplier;
 
-		r = clk_set_rate(dss.dpll4_m4_ck,
-				DIV_ROUND_UP(prate, cinfo->fck_div));
+		r = clk_set_rate(dss.dpll4_m4_ck, rate * m);
 		if (r)
 			return r;
-	} else {
-		if (cinfo->fck_div != 0)
-			return -EINVAL;
 	}
 
 	dss.dss_clk_rate = clk_get_rate(dss.dss_clk);
 
-	WARN_ONCE(dss.dss_clk_rate != cinfo->fck,
+	WARN_ONCE(dss.dss_clk_rate != rate,
 			"clk rate mismatch: %lu != %lu", dss.dss_clk_rate,
-			cinfo->fck);
-
-	DSSDBG("fck = %ld (%d)\n", cinfo->fck, cinfo->fck_div);
+			rate);
 
 	return 0;
 }
@@ -555,8 +527,8 @@ unsigned long dss_get_dispc_clk_rate(void)
 static int dss_setup_default_clock(void)
 {
 	unsigned long max_dss_fck, prate;
+	unsigned long fck;
 	unsigned fck_div;
-	struct dss_clock_info dss_cinfo = { 0 };
 	int r;
 
 	if (dss.dpll4_m4_ck == NULL)
@@ -568,14 +540,9 @@ static int dss_setup_default_clock(void)
 
 	fck_div = DIV_ROUND_UP(prate * dss.feat->dss_fck_multiplier,
 			max_dss_fck);
+	fck = prate / fck_div * dss.feat->dss_fck_multiplier;
 
-	dss_cinfo.fck_div = fck_div;
-
-	r = dss_calc_clock_rates(&dss_cinfo);
-	if (r)
-		return r;
-
-	r = dss_set_clock_div(&dss_cinfo);
+	r = dss_set_fck_rate(fck);
 	if (r)
 		return r;
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index e172531..ead1960 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -100,14 +100,6 @@ enum dss_writeback_channel {
 	DSS_WB_LCD3_MGR =	7,
 };
 
-struct dss_clock_info {
-	/* rates that we get with dividers below */
-	unsigned long fck;
-
-	/* dividers */
-	u16 fck_div;
-};
-
 struct dispc_clock_info {
 	/* rates that we get with dividers below */
 	unsigned long lck;
@@ -251,10 +243,9 @@ void dss_set_venc_output(enum omap_dss_venc_type type);
 void dss_set_dac_pwrdn_bgz(bool enable);
 
 unsigned long dss_get_dpll4_rate(void);
-int dss_calc_clock_rates(struct dss_clock_info *cinfo);
-int dss_set_clock_div(struct dss_clock_info *cinfo);
+int dss_set_fck_rate(unsigned long rate);
 
-typedef bool (*dss_div_calc_func)(int fckd, unsigned long fck, void *data);
+typedef bool (*dss_div_calc_func)(unsigned long fck, void *data);
 bool dss_div_calc(unsigned long fck_min, dss_div_calc_func func, void *data);
 
 /* SDI */
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index ccc569a..221fd34 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -46,7 +46,7 @@ static struct {
 struct sdi_clk_calc_ctx {
 	unsigned long pck_min, pck_max;
 
-	struct dss_clock_info dss_cinfo;
+	unsigned long long fck;
 	struct dispc_clock_info dispc_cinfo;
 };
 
@@ -63,19 +63,18 @@ static bool dpi_calc_dispc_cb(int lckd, int pckd, unsigned long lck,
 	return true;
 }
 
-static bool dpi_calc_dss_cb(int fckd, unsigned long fck, void *data)
+static bool dpi_calc_dss_cb(unsigned long fck, void *data)
 {
 	struct sdi_clk_calc_ctx *ctx = data;
 
-	ctx->dss_cinfo.fck = fck;
-	ctx->dss_cinfo.fck_div = fckd;
+	ctx->fck = fck;
 
 	return dispc_div_calc(fck, ctx->pck_min, ctx->pck_max,
 			dpi_calc_dispc_cb, ctx);
 }
 
 static int sdi_calc_clock_div(unsigned long pclk,
-		struct dss_clock_info *dss_cinfo,
+		unsigned long *fck,
 		struct dispc_clock_info *dispc_cinfo)
 {
 	int i;
@@ -100,7 +99,7 @@ static int sdi_calc_clock_div(unsigned long pclk,
 
 		ok = dss_div_calc(ctx.pck_min, dpi_calc_dss_cb, &ctx);
 		if (ok) {
-			*dss_cinfo = ctx.dss_cinfo;
+			*fck = ctx.fck;
 			*dispc_cinfo = ctx.dispc_cinfo;
 			return 0;
 		}
@@ -128,7 +127,7 @@ static int sdi_display_enable(struct omap_dss_device *dssdev)
 {
 	struct omap_dss_device *out = &sdi.output;
 	struct omap_video_timings *t = &sdi.timings;
-	struct dss_clock_info dss_cinfo;
+	unsigned long fck;
 	struct dispc_clock_info dispc_cinfo;
 	unsigned long pck;
 	int r;
@@ -150,13 +149,13 @@ static int sdi_display_enable(struct omap_dss_device *dssdev)
 	t->data_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
 	t->sync_pclk_edge = OMAPDSS_DRIVE_SIG_RISING_EDGE;
 
-	r = sdi_calc_clock_div(t->pixel_clock * 1000, &dss_cinfo, &dispc_cinfo);
+	r = sdi_calc_clock_div(t->pixel_clock * 1000, &fck, &dispc_cinfo);
 	if (r)
 		goto err_calc_clock_div;
 
 	sdi.mgr_config.clock_info = dispc_cinfo;
 
-	pck = dss_cinfo.fck / dispc_cinfo.lck_div / dispc_cinfo.pck_div / 1000;
+	pck = fck / dispc_cinfo.lck_div / dispc_cinfo.pck_div / 1000;
 
 	if (pck != t->pixel_clock) {
 		DSSWARN("Could not find exact pixel clock. Requested %d kHz, "
@@ -169,7 +168,7 @@ static int sdi_display_enable(struct omap_dss_device *dssdev)
 
 	dss_mgr_set_timings(out->manager, t);
 
-	r = dss_set_clock_div(&dss_cinfo);
+	r = dss_set_fck_rate(fck);
 	if (r)
 		goto err_set_dss_clock_div;
 
-- 
1.8.3.2

