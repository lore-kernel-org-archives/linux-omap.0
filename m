From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/14] OMAPDSS: DSI: use new clock calculation code
Date: Fri, 8 Mar 2013 13:52:47 +0200
Message-ID: <1362743569-10289-13-git-send-email-tomi.valkeinen@ti.com>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44146 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933944Ab3CHLx3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Mar 2013 06:53:29 -0500
In-Reply-To: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new clock calculation code in the DSI driver.

The new code does not need DSI video mode parameters from the panel
driver, like the old code does. Instead the new code is given the normal
video timings, and a few DSI parameters, which are used to create DSI
video timings.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |    7 +-
 drivers/video/omap2/dss/dsi.c             |  504 ++++++++++++++++++++++++++++-
 include/video/omapdss.h                   |   20 +-
 3 files changed, 513 insertions(+), 18 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index eb86cba..2fc923d 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -787,6 +787,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
 	dssdev->panel.timings.x_res = 864;
 	dssdev->panel.timings.y_res = 480;
+	dssdev->panel.timings.pixel_clock = DIV_ROUND_UP(864 * 480 * 60, 1000);
 	dssdev->panel.dsi_pix_fmt = OMAP_DSS_DSI_FMT_RGB888;
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
 		OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
@@ -923,8 +924,10 @@ static int taal_power_on(struct omap_dss_device *dssdev)
 		.mode = OMAP_DSS_DSI_CMD_MODE,
 		.pixel_format = OMAP_DSS_DSI_FMT_RGB888,
 		.timings = &dssdev->panel.timings,
-		.hs_clk = 216000000,
-		.lp_clk = 10000000,
+		.hs_clk_min = 150000000,
+		.hs_clk_max = 300000000,
+		.lp_clk_min = 7000000,
+		.lp_clk_max = 10000000,
 	};
 
 	r = omapdss_dsi_configure_pins(dssdev, &td->pin_config);
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index c8d5574..593022b 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -255,6 +255,24 @@ struct dsi_isr_tables {
 	struct dsi_isr_data isr_table_cio[DSI_MAX_NR_ISRS];
 };
 
+struct dsi_clk_calc_ctx {
+	struct platform_device *dsidev;
+
+	/* inputs */
+
+	const struct omap_dss_dsi_config *config;
+
+	unsigned long req_pck_min, req_pck_nom, req_pck_max;
+
+	/* outputs */
+
+	struct dsi_clock_info dsi_cinfo;
+	struct dispc_clock_info dispc_cinfo;
+
+	struct omap_video_timings dispc_vm;
+	struct omap_dss_dsi_videomode_timings dsi_vm;
+};
+
 struct dsi_data {
 	struct platform_device *pdev;
 	void __iomem	*base;
@@ -1201,6 +1219,25 @@ static unsigned long dsi_fclk_rate(struct platform_device *dsidev)
 	return r;
 }
 
+static int dsi_lp_clock_calc(struct dsi_clock_info *cinfo,
+		unsigned long lp_clk_min, unsigned long lp_clk_max)
+{
+	unsigned long dsi_fclk = cinfo->dsi_pll_hsdiv_dsi_clk;
+	unsigned lp_clk_div;
+	unsigned long lp_clk;
+
+	lp_clk_div = DIV_ROUND_UP(dsi_fclk, lp_clk_max * 2);
+	lp_clk = dsi_fclk / 2 / lp_clk_div;
+
+	if (lp_clk < lp_clk_min || lp_clk > lp_clk_max)
+		return -EINVAL;
+
+	cinfo->lp_clk_div = lp_clk_div;
+	cinfo->lp_clk = lp_clk;
+
+	return 0;
+}
+
 static int dsi_set_lp_clk_divisor(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
@@ -1577,8 +1614,7 @@ found:
 	return 0;
 }
 
-static void dsi_pll_calc_dsi_fck(struct platform_device *dsidev,
-		struct dsi_clock_info *cinfo)
+static void dsi_pll_calc_dsi_fck(struct dsi_clock_info *cinfo)
 {
 	unsigned long max_dsi_fck;
 
@@ -4369,7 +4405,7 @@ static int dsi_set_clocks(struct omap_dss_device *dssdev,
 		goto err;
 
 	/* Calculate PLL's DSI clock */
-	dsi_pll_calc_dsi_fck(dsidev, &cinfo);
+	dsi_pll_calc_dsi_fck(&cinfo);
 
 	/* Calculate PLL's DISPC clock and pck & lck divs */
 	pck = cinfo.clkin4ddr / 16 * (dsi->num_lanes_used - 1) * 8 / bpp;
@@ -4693,13 +4729,6 @@ static int dsi_display_init_dispc(struct platform_device *dsidev,
 			OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC);
 
 	if (dsi->mode == OMAP_DSS_DSI_CMD_MODE) {
-		dsi->timings.hsw = 1;
-		dsi->timings.hfp = 1;
-		dsi->timings.hbp = 1;
-		dsi->timings.vsw = 1;
-		dsi->timings.vfp = 0;
-		dsi->timings.vbp = 0;
-
 		r = dss_mgr_register_framedone_handler(mgr,
 				dsi_framedone_irq_callback, dsidev);
 		if (r) {
@@ -4941,24 +4970,473 @@ int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable)
 }
 EXPORT_SYMBOL(omapdss_dsi_enable_te);
 
+#ifdef PRINT_VERBOSE_VM_TIMINGS
+static void print_dsi_vm(const char *str,
+		const struct omap_dss_dsi_videomode_timings *t)
+{
+	unsigned long byteclk = t->hsclk / 4;
+	int bl, wc, pps, tot;
+
+	wc = DIV_ROUND_UP(t->hact * t->bitspp, 8);
+	pps = DIV_ROUND_UP(wc + 6, t->ndl); /* pixel packet size */
+	bl = t->hss + t->hsa + t->hse + t->hbp + t->hfp;
+	tot = bl + pps;
+
+#define TO_DSI_T(x) ((u32)div64_u64((u64)x * 1000000000llu, byteclk))
+
+	pr_debug("%s bck %lu, %u/%u/%u/%u/%u/%u = %u+%u = %u, "
+			"%u/%u/%u/%u/%u/%u = %u + %u = %u\n",
+			str,
+			byteclk,
+			t->hss, t->hsa, t->hse, t->hbp, pps, t->hfp,
+			bl, pps, tot,
+			TO_DSI_T(t->hss),
+			TO_DSI_T(t->hsa),
+			TO_DSI_T(t->hse),
+			TO_DSI_T(t->hbp),
+			TO_DSI_T(pps),
+			TO_DSI_T(t->hfp),
+
+			TO_DSI_T(bl),
+			TO_DSI_T(pps),
+
+			TO_DSI_T(tot));
+#undef TO_DSI_T
+}
+
+static void print_dispc_vm(const char *str, const struct omap_video_timings *t)
+{
+	unsigned long pck = t->pixel_clock * 1000;
+	int hact, bl, tot;
+
+	hact = t->x_res;
+	bl = t->hsw + t->hbp + t->hfp;
+	tot = hact + bl;
+
+#define TO_DISPC_T(x) ((u32)div64_u64((u64)x * 1000000000llu, pck))
+
+	pr_debug("%s pck %lu, %u/%u/%u/%u = %u+%u = %u, "
+			"%u/%u/%u/%u = %u + %u = %u\n",
+			str,
+			pck,
+			t->hsw, t->hbp, hact, t->hfp,
+			bl, hact, tot,
+			TO_DISPC_T(t->hsw),
+			TO_DISPC_T(t->hbp),
+			TO_DISPC_T(hact),
+			TO_DISPC_T(t->hfp),
+			TO_DISPC_T(bl),
+			TO_DISPC_T(hact),
+			TO_DISPC_T(tot));
+#undef TO_DISPC_T
+}
+
+/* note: this is not quite accurate */
+static void print_dsi_dispc_vm(const char *str,
+		const struct omap_dss_dsi_videomode_timings *t)
+{
+	struct omap_video_timings vm = { 0 };
+	unsigned long byteclk = t->hsclk / 4;
+	unsigned long pck;
+	u64 dsi_tput;
+	int dsi_hact, dsi_htot;
+
+	dsi_tput = (u64)byteclk * t->ndl * 8;
+	pck = (u32)div64_u64(dsi_tput, t->bitspp);
+	dsi_hact = DIV_ROUND_UP(DIV_ROUND_UP(t->hact * t->bitspp, 8) + 6, t->ndl);
+	dsi_htot = t->hss + t->hsa + t->hse + t->hbp + dsi_hact + t->hfp;
+
+	vm.pixel_clock = pck / 1000;
+	vm.hsw = div64_u64((u64)(t->hsa + t->hse) * pck, byteclk);
+	vm.hbp = div64_u64((u64)t->hbp * pck, byteclk);
+	vm.hfp = div64_u64((u64)t->hfp * pck, byteclk);
+	vm.x_res = t->hact;
+
+	print_dispc_vm(str, &vm);
+}
+#endif /* PRINT_VERBOSE_VM_TIMINGS */
+
+static bool dsi_cm_calc_dispc_cb(int lckd, int pckd, unsigned long lck,
+		unsigned long pck, void *data)
+{
+	struct dsi_clk_calc_ctx *ctx = data;
+	struct omap_video_timings *t = &ctx->dispc_vm;
+
+	ctx->dispc_cinfo.lck_div = lckd;
+	ctx->dispc_cinfo.pck_div = pckd;
+	ctx->dispc_cinfo.lck = lck;
+	ctx->dispc_cinfo.pck = pck;
+
+	*t = *ctx->config->timings;
+	t->pixel_clock = pck / 1000;
+	t->x_res = ctx->config->timings->x_res;
+	t->y_res = ctx->config->timings->y_res;
+	t->hsw = t->hfp = t->hbp = t->vsw = 1;
+	t->vfp = t->vbp = 0;
+
+	return true;
+}
+
+static bool dsi_cm_calc_hsdiv_cb(int regm_dispc, unsigned long dispc,
+		void *data)
+{
+	struct dsi_clk_calc_ctx *ctx = data;
+
+	ctx->dsi_cinfo.regm_dispc = regm_dispc;
+	ctx->dsi_cinfo.dsi_pll_hsdiv_dispc_clk = dispc;
+
+	return dispc_div_calc(dispc, ctx->req_pck_min, ctx->req_pck_max,
+			dsi_cm_calc_dispc_cb, ctx);
+}
+
+static bool dsi_cm_calc_pll_cb(int regn, int regm, unsigned long fint,
+		unsigned long pll, void *data)
+{
+	struct dsi_clk_calc_ctx *ctx = data;
+
+	ctx->dsi_cinfo.regn = regn;
+	ctx->dsi_cinfo.regm = regm;
+	ctx->dsi_cinfo.fint = fint;
+	ctx->dsi_cinfo.clkin4ddr = pll;
+
+	return dsi_hsdiv_calc(ctx->dsidev, pll, ctx->req_pck_min,
+			dsi_cm_calc_hsdiv_cb, ctx);
+}
+
+static bool dsi_cm_calc(struct dsi_data *dsi,
+		const struct omap_dss_dsi_config *cfg,
+		struct dsi_clk_calc_ctx *ctx)
+{
+	unsigned long clkin;
+	int bitspp, ndl;
+	unsigned long pll_min, pll_max;
+	unsigned long pck, txbyteclk;
+
+	clkin = clk_get_rate(dsi->sys_clk);
+	bitspp = dsi_get_pixel_size(cfg->pixel_format);
+	ndl = dsi->num_lanes_used - 1;
+
+	/*
+	 * Here we should calculate minimum txbyteclk to be able to send the
+	 * frame in time, and also to handle TE. That's not very simple, though,
+	 * especially as we go to LP between each pixel packet due to HW
+	 * "feature". So let's just estimate very roughly and multiply by 1.5.
+	 */
+	pck = cfg->timings->pixel_clock * 1000;
+	pck = pck * 3 / 2;
+	txbyteclk = pck * bitspp / 8 / ndl;
+
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->dsidev = dsi->pdev;
+	ctx->config = cfg;
+	ctx->req_pck_min = pck;
+	ctx->req_pck_nom = pck;
+	ctx->req_pck_max = pck * 3 / 2;
+	ctx->dsi_cinfo.clkin = clkin;
+
+	pll_min = max(cfg->hs_clk_min * 4, txbyteclk * 4 * 4);
+	pll_max = cfg->hs_clk_max * 4;
+
+	return dsi_pll_calc(dsi->pdev, clkin,
+			pll_min, pll_max,
+			dsi_cm_calc_pll_cb, ctx);
+}
+
+static bool dsi_vm_calc_blanking(struct dsi_clk_calc_ctx *ctx)
+{
+	struct dsi_data *dsi = dsi_get_dsidrv_data(ctx->dsidev);
+	const struct omap_dss_dsi_config *cfg = ctx->config;
+	int bitspp = dsi_get_pixel_size(cfg->pixel_format);
+	int ndl = dsi->num_lanes_used - 1;
+	unsigned long hsclk = ctx->dsi_cinfo.clkin4ddr / 4;
+	unsigned long byteclk = hsclk / 4;
+
+	unsigned long dispc_pck, req_pck_min, req_pck_nom, req_pck_max;
+	int xres;
+	int panel_htot, panel_hbl; /* pixels */
+	int dispc_htot, dispc_hbl; /* pixels */
+	int dsi_htot, dsi_hact, dsi_hbl, hss, hse; /* byteclks */
+	const struct omap_video_timings *req_vm;
+	struct omap_video_timings *dispc_vm;
+	struct omap_dss_dsi_videomode_timings *dsi_vm;
+	u64 dsi_tput, dispc_tput;
+
+	dsi_tput = (u64)byteclk * ndl * 8;
+
+	req_vm = cfg->timings;
+	req_pck_min = ctx->req_pck_min;
+	req_pck_max = ctx->req_pck_max;
+	req_pck_nom = ctx->req_pck_nom;
+
+	dispc_pck = ctx->dispc_cinfo.pck;
+	dispc_tput = (u64)dispc_pck * bitspp;
+
+	xres = req_vm->x_res;
+
+	panel_hbl = req_vm->hfp + req_vm->hbp + req_vm->hsw;
+	panel_htot = xres + panel_hbl;
+
+	dsi_hact = DIV_ROUND_UP(DIV_ROUND_UP(xres * bitspp, 8) + 6, ndl);
+
+	/*
+	 * When there are no line buffers, DISPC and DSI must have the
+	 * same tput. Otherwise DISPC tput needs to be higher than DSI's.
+	 */
+	if (dsi->line_buffer_size < xres * bitspp / 8) {
+		if (dispc_tput != dsi_tput)
+			return false;
+	} else {
+		if (dispc_tput < dsi_tput)
+			return false;
+	}
+
+	/* DSI tput must be over the min requirement */
+	if (dsi_tput < (u64)bitspp * req_pck_min)
+		return false;
+
+	/* When non-burst mode, DSI tput must be below max requirement. */
+	if (cfg->trans_mode != OMAP_DSS_DSI_BURST_MODE) {
+		if (dsi_tput > (u64)bitspp * req_pck_max)
+			return false;
+	}
+
+	hss = DIV_ROUND_UP(4, ndl);
+
+	if (cfg->trans_mode == OMAP_DSS_DSI_PULSE_MODE) {
+		if (ndl == 3 && req_vm->hsw == 0)
+			hse = 1;
+		else
+			hse = DIV_ROUND_UP(4, ndl);
+	} else {
+		hse = 0;
+	}
+
+	/* DSI htot to match the panel's nominal pck */
+	dsi_htot = div64_u64((u64)panel_htot * byteclk, req_pck_nom);
+
+	/* fail if there would be no time for blanking */
+	if (dsi_htot < hss + hse + dsi_hact)
+		return false;
+
+	/* total DSI blanking needed to achieve panel's TL */
+	dsi_hbl = dsi_htot - dsi_hact;
+
+	/* DISPC htot to match the DSI TL */
+	dispc_htot = div64_u64((u64)dsi_htot * dispc_pck, byteclk);
+
+	/* verify that the DSI and DISPC TLs are the same */
+	if ((u64)dsi_htot * dispc_pck != (u64)dispc_htot * byteclk)
+		return false;
+
+	dispc_hbl = dispc_htot - xres;
+
+	/* setup DSI videomode */
+
+	dsi_vm = &ctx->dsi_vm;
+	memset(dsi_vm, 0, sizeof(*dsi_vm));
+
+	dsi_vm->hsclk = hsclk;
+
+	dsi_vm->ndl = ndl;
+	dsi_vm->bitspp = bitspp;
+	dsi_vm->hact = xres;
+	dsi_vm->vact = req_vm->y_res;
+
+	dsi_vm->hss = hss;
+	if (cfg->trans_mode != OMAP_DSS_DSI_PULSE_MODE)
+		dsi_vm->hsa = 0;
+	else if (ndl == 3 && req_vm->hsw == 0)
+		dsi_vm->hsa = 0;
+	else
+		dsi_vm->hsa = div64_u64((u64)req_vm->hsw * byteclk, req_pck_nom)
+			- hse;
+
+	dsi_vm->hse = hse;
+	dsi_vm->hbp = div64_u64((u64)req_vm->hbp * byteclk, req_pck_nom);
+	dsi_vm->hfp = dsi_hbl - (hss + dsi_vm->hsa + hse + dsi_vm->hbp);
+
+	dsi_vm->vsa = req_vm->vsw;
+	dsi_vm->vbp = req_vm->vbp;
+	dsi_vm->vfp = req_vm->vfp;
+
+	dsi_vm->trans_mode = cfg->trans_mode;
+
+	dsi_vm->blanking_mode = 0;
+	dsi_vm->hsa_blanking_mode = 1;
+	dsi_vm->hfp_blanking_mode = 1;
+	dsi_vm->hbp_blanking_mode = 1;
+
+	dsi_vm->ddr_clk_always_on = cfg->ddr_clk_always_on;
+	dsi_vm->window_sync = 4;
+
+	/* setup DISPC videomode */
+
+	dispc_vm = &ctx->dispc_vm;
+	*dispc_vm = *req_vm;
+	dispc_vm->pixel_clock = dispc_pck / 1000;
+
+	if (cfg->trans_mode == OMAP_DSS_DSI_PULSE_MODE)
+		dispc_vm->hsw = div64_u64((u64)req_vm->hsw * dispc_pck,
+				req_pck_nom);
+	else
+		dispc_vm->hsw = 1;
+	dispc_vm->hbp = div64_u64((u64)req_vm->hbp * dispc_pck, req_pck_nom);
+	dispc_vm->hfp = dispc_hbl - dispc_vm->hsw - dispc_vm->hbp;
+
+	return true;
+}
+
+
+static bool dsi_vm_calc_dispc_cb(int lckd, int pckd, unsigned long lck,
+		unsigned long pck, void *data)
+{
+	struct dsi_clk_calc_ctx *ctx = data;
+
+	ctx->dispc_cinfo.lck_div = lckd;
+	ctx->dispc_cinfo.pck_div = pckd;
+	ctx->dispc_cinfo.lck = lck;
+	ctx->dispc_cinfo.pck = pck;
+
+	if (dsi_vm_calc_blanking(ctx) == false)
+		return false;
+
+#ifdef PRINT_VERBOSE_VM_TIMINGS
+	print_dispc_vm("dispc", &ctx->dispc_vm);
+	print_dsi_vm("dsi  ", &ctx->dsi_vm);
+	print_dispc_vm("req  ", ctx->config->timings);
+	print_dsi_dispc_vm("act  ", &ctx->dsi_vm);
+#endif
+
+	return true;
+}
+
+static bool dsi_vm_calc_hsdiv_cb(int regm_dispc, unsigned long dispc,
+		void *data)
+{
+	struct dsi_clk_calc_ctx *ctx = data;
+	unsigned long pck_max;
+
+	ctx->dsi_cinfo.regm_dispc = regm_dispc;
+	ctx->dsi_cinfo.dsi_pll_hsdiv_dispc_clk = dispc;
+
+	/*
+	 * In burst mode we can let the dispc pck be arbitrarily high, but it
+	 * limits our scaling abilities. So for now, don't aim too high.
+	 */
+
+	if (ctx->config->trans_mode == OMAP_DSS_DSI_BURST_MODE)
+		pck_max = ctx->req_pck_max + 10000000;
+	else
+		pck_max = ctx->req_pck_max;
+
+	return dispc_div_calc(dispc, ctx->req_pck_min, pck_max,
+			dsi_vm_calc_dispc_cb, ctx);
+}
+
+static bool dsi_vm_calc_pll_cb(int regn, int regm, unsigned long fint,
+		unsigned long pll, void *data)
+{
+	struct dsi_clk_calc_ctx *ctx = data;
+
+	ctx->dsi_cinfo.regn = regn;
+	ctx->dsi_cinfo.regm = regm;
+	ctx->dsi_cinfo.fint = fint;
+	ctx->dsi_cinfo.clkin4ddr = pll;
+
+	return dsi_hsdiv_calc(ctx->dsidev, pll, ctx->req_pck_min,
+			dsi_vm_calc_hsdiv_cb, ctx);
+}
+
+static bool dsi_vm_calc(struct dsi_data *dsi,
+		const struct omap_dss_dsi_config *cfg,
+		struct dsi_clk_calc_ctx *ctx)
+{
+	const struct omap_video_timings *t = cfg->timings;
+	unsigned long clkin;
+	unsigned long pll_min;
+	unsigned long pll_max;
+	int ndl = dsi->num_lanes_used - 1;
+	int bitspp = dsi_get_pixel_size(cfg->pixel_format);
+	unsigned long byteclk_min;
+
+	clkin = clk_get_rate(dsi->sys_clk);
+
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->dsidev = dsi->pdev;
+	ctx->config = cfg;
+
+	ctx->dsi_cinfo.clkin = clkin;
+
+	/* these limits should come from the panel driver */
+	ctx->req_pck_min = t->pixel_clock * 1000 - 1000;
+	ctx->req_pck_nom = t->pixel_clock * 1000;
+	ctx->req_pck_max = t->pixel_clock * 1000 + 1000;
+
+	byteclk_min = div64_u64((u64)ctx->req_pck_min * bitspp, ndl * 8);
+	pll_min = max(cfg->hs_clk_min * 4, byteclk_min * 4 * 4);
+
+	if (cfg->trans_mode == OMAP_DSS_DSI_BURST_MODE) {
+		pll_max = cfg->hs_clk_max * 4;
+	} else {
+		unsigned long byteclk_max;
+		byteclk_max = div64_u64((u64)ctx->req_pck_max * bitspp,
+				ndl * 8);
+
+		pll_max = byteclk_max * 4 * 4;
+	}
+
+	return dsi_pll_calc(dsi->pdev, clkin,
+			pll_min, pll_max,
+			dsi_vm_calc_pll_cb, ctx);
+}
+
 int omapdss_dsi_set_config(struct omap_dss_device *dssdev,
 		const struct omap_dss_dsi_config *config)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct dsi_clk_calc_ctx ctx;
+	bool ok;
+	int r;
 
 	mutex_lock(&dsi->lock);
 
-	dsi->timings = *config->timings;
-	dsi->vm_timings = *config->vm_timings;
 	dsi->pix_fmt = config->pixel_format;
 	dsi->mode = config->mode;
 
-	dsi_set_clocks(dssdev, config->hs_clk, config->lp_clk);
+	if (config->mode == OMAP_DSS_DSI_VIDEO_MODE)
+		ok = dsi_vm_calc(dsi, config, &ctx);
+	else
+		ok = dsi_cm_calc(dsi, config, &ctx);
+
+	if (!ok) {
+		DSSERR("failed to find suitable DSI clock settings\n");
+		r = -EINVAL;
+		goto err;
+	}
+
+	dsi_pll_calc_dsi_fck(&ctx.dsi_cinfo);
+
+	r = dsi_lp_clock_calc(&ctx.dsi_cinfo, config->lp_clk_min,
+			config->lp_clk_max);
+	if (r) {
+		DSSERR("failed to find suitable DSI LP clock settings\n");
+		goto err;
+	}
+
+	dsi->user_dsi_cinfo = ctx.dsi_cinfo;
+	dsi->user_dispc_cinfo = ctx.dispc_cinfo;
+
+	dsi->timings = ctx.dispc_vm;
+	dsi->vm_timings = ctx.dsi_vm;
 
 	mutex_unlock(&dsi->lock);
 
 	return 0;
+err:
+	mutex_unlock(&dsi->lock);
+
+	return r;
 }
 EXPORT_SYMBOL(omapdss_dsi_set_config);
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 161011e..cbaf60f 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -267,9 +267,21 @@ enum omap_dss_dsi_trans_mode {
 };
 
 struct omap_dss_dsi_videomode_timings {
+	unsigned long hsclk;
+
+	unsigned ndl;
+	unsigned bitspp;
+
+	/* pixels */
+	u16 hact;
+	/* lines */
+	u16 vact;
+
 	/* DSI video mode blanking data */
 	/* Unit: byte clock cycles */
+	u16 hss;
 	u16 hsa;
+	u16 hse;
 	u16 hfp;
 	u16 hbp;
 	/* Unit: line clocks */
@@ -293,10 +305,12 @@ struct omap_dss_dsi_config {
 	enum omap_dss_dsi_mode mode;
 	enum omap_dss_dsi_pixel_format pixel_format;
 	const struct omap_video_timings *timings;
-	const struct omap_dss_dsi_videomode_timings *vm_timings;
 
-	unsigned long hs_clk;
-	unsigned long lp_clk;
+	unsigned long hs_clk_min, hs_clk_max;
+	unsigned long lp_clk_min, lp_clk_max;
+
+	bool ddr_clk_always_on;
+	enum omap_dss_dsi_trans_mode trans_mode;
 };
 
 void dsi_bus_lock(struct omap_dss_device *dssdev);
-- 
1.7.10.4

