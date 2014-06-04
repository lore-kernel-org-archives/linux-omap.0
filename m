From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 1/7] OMAPDSS: DPI: Use DPI driver data
Date: Wed, 4 Jun 2014 12:10:57 +0530
Message-ID: <1401864063-19196-2-git-send-email-archit@ti.com>
References: <1401096492-1405-1-git-send-email-archit@ti.com>
 <1401864063-19196-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36224 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbaFDGm1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 4 Jun 2014 02:42:27 -0400
In-Reply-To: <1401864063-19196-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

DPI related data is currently a static global struct parameter. It is accessed
directly by functions in the driver.

This method won't work if we want the driver to support multiple DPI instances.
Create struct dpi_data, and pass it's pointer to functions which need to use it.

We still have a static instance defined for dpi_data, which is accessed by top
level DPI ops. This will be removed when the driver dynamically allocates
dpi_data for each DPI instance.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c | 187 +++++++++++++++++++++---------------
 1 file changed, 107 insertions(+), 80 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index 9368972..945d988 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -37,7 +37,7 @@
 #include "dss.h"
 #include "dss_features.h"
 
-static struct {
+struct dpi_data {
 	struct platform_device *pdev;
 
 	struct regulator *vdds_dsi_reg;
@@ -52,7 +52,9 @@ static struct {
 	struct omap_dss_device output;
 
 	bool port_initialized;
-} dpi;
+};
+
+static struct dpi_data dpi;
 
 static struct platform_device *dpi_get_dsidev(enum omap_channel channel)
 {
@@ -200,15 +202,16 @@ static bool dpi_calc_dss_cb(unsigned long fck, void *data)
 			dpi_calc_dispc_cb, ctx);
 }
 
-static bool dpi_dsi_clk_calc(unsigned long pck, struct dpi_clk_calc_ctx *ctx)
+static bool dpi_dsi_clk_calc(struct dpi_data *dpi, unsigned long pck,
+		struct dpi_clk_calc_ctx *ctx)
 {
 	unsigned long clkin;
 	unsigned long pll_min, pll_max;
 
-	clkin = dsi_get_pll_clkin(dpi.dsidev);
+	clkin = dsi_get_pll_clkin(dpi->dsidev);
 
 	memset(ctx, 0, sizeof(*ctx));
-	ctx->dsidev = dpi.dsidev;
+	ctx->dsidev = dpi->dsidev;
 	ctx->pck_min = pck - 1000;
 	ctx->pck_max = pck + 1000;
 	ctx->dsi_cinfo.clkin = clkin;
@@ -216,7 +219,7 @@ static bool dpi_dsi_clk_calc(unsigned long pck, struct dpi_clk_calc_ctx *ctx)
 	pll_min = 0;
 	pll_max = 0;
 
-	return dsi_pll_calc(dpi.dsidev, clkin,
+	return dsi_pll_calc(dpi->dsidev, clkin,
 			pll_min, pll_max,
 			dpi_calc_pll_cb, ctx);
 }
@@ -252,7 +255,7 @@ static bool dpi_dss_clk_calc(unsigned long pck, struct dpi_clk_calc_ctx *ctx)
 
 
 
-static int dpi_set_dsi_clk(enum omap_channel channel,
+static int dpi_set_dsi_clk(struct dpi_data *dpi, enum omap_channel channel,
 		unsigned long pck_req, unsigned long *fck, int *lck_div,
 		int *pck_div)
 {
@@ -260,18 +263,18 @@ static int dpi_set_dsi_clk(enum omap_channel channel,
 	int r;
 	bool ok;
 
-	ok = dpi_dsi_clk_calc(pck_req, &ctx);
+	ok = dpi_dsi_clk_calc(dpi, pck_req, &ctx);
 	if (!ok)
 		return -EINVAL;
 
-	r = dsi_pll_set_clock_div(dpi.dsidev, &ctx.dsi_cinfo);
+	r = dsi_pll_set_clock_div(dpi->dsidev, &ctx.dsi_cinfo);
 	if (r)
 		return r;
 
 	dss_select_lcd_clk_source(channel,
 			dpi_get_alt_clk_src(channel));
 
-	dpi.mgr_config.clock_info = ctx.dispc_cinfo;
+	dpi->mgr_config.clock_info = ctx.dispc_cinfo;
 
 	*fck = ctx.dsi_cinfo.dsi_pll_hsdiv_dispc_clk;
 	*lck_div = ctx.dispc_cinfo.lck_div;
@@ -280,8 +283,8 @@ static int dpi_set_dsi_clk(enum omap_channel channel,
 	return 0;
 }
 
-static int dpi_set_dispc_clk(unsigned long pck_req, unsigned long *fck,
-		int *lck_div, int *pck_div)
+static int dpi_set_dispc_clk(struct dpi_data *dpi, unsigned long pck_req,
+		unsigned long *fck, int *lck_div, int *pck_div)
 {
 	struct dpi_clk_calc_ctx ctx;
 	int r;
@@ -295,7 +298,7 @@ static int dpi_set_dispc_clk(unsigned long pck_req, unsigned long *fck,
 	if (r)
 		return r;
 
-	dpi.mgr_config.clock_info = ctx.dispc_cinfo;
+	dpi->mgr_config.clock_info = ctx.dispc_cinfo;
 
 	*fck = ctx.fck;
 	*lck_div = ctx.dispc_cinfo.lck_div;
@@ -304,19 +307,21 @@ static int dpi_set_dispc_clk(unsigned long pck_req, unsigned long *fck,
 	return 0;
 }
 
-static int dpi_set_mode(struct omap_overlay_manager *mgr)
+static int dpi_set_mode(struct dpi_data *dpi)
 {
-	struct omap_video_timings *t = &dpi.timings;
+	struct omap_dss_device *out = &dpi->output;
+	struct omap_overlay_manager *mgr = out->manager;
+	struct omap_video_timings *t = &dpi->timings;
 	int lck_div = 0, pck_div = 0;
 	unsigned long fck = 0;
 	unsigned long pck;
 	int r = 0;
 
-	if (dpi.dsidev)
-		r = dpi_set_dsi_clk(mgr->id, t->pixelclock, &fck,
+	if (dpi->dsidev)
+		r = dpi_set_dsi_clk(dpi, mgr->id, t->pixelclock, &fck,
 				&lck_div, &pck_div);
 	else
-		r = dpi_set_dispc_clk(t->pixelclock, &fck,
+		r = dpi_set_dispc_clk(dpi, t->pixelclock, &fck,
 				&lck_div, &pck_div);
 	if (r)
 		return r;
@@ -335,28 +340,32 @@ static int dpi_set_mode(struct omap_overlay_manager *mgr)
 	return 0;
 }
 
-static void dpi_config_lcd_manager(struct omap_overlay_manager *mgr)
+static void dpi_config_lcd_manager(struct dpi_data *dpi)
 {
-	dpi.mgr_config.io_pad_mode = DSS_IO_PAD_MODE_BYPASS;
+	struct omap_dss_device *out = &dpi->output;
+	struct omap_overlay_manager *mgr = out->manager;
+
+	dpi->mgr_config.io_pad_mode = DSS_IO_PAD_MODE_BYPASS;
 
-	dpi.mgr_config.stallmode = false;
-	dpi.mgr_config.fifohandcheck = false;
+	dpi->mgr_config.stallmode = false;
+	dpi->mgr_config.fifohandcheck = false;
 
-	dpi.mgr_config.video_port_width = dpi.data_lines;
+	dpi->mgr_config.video_port_width = dpi->data_lines;
 
-	dpi.mgr_config.lcden_sig_polarity = 0;
+	dpi->mgr_config.lcden_sig_polarity = 0;
 
-	dss_mgr_set_lcd_config(mgr, &dpi.mgr_config);
+	dss_mgr_set_lcd_config(mgr, &dpi->mgr_config);
 }
 
 static int dpi_display_enable(struct omap_dss_device *dssdev)
 {
-	struct omap_dss_device *out = &dpi.output;
+	struct dpi_data *dpi = &dpi;
+	struct omap_dss_device *out = &dpi->output;
 	int r;
 
-	mutex_lock(&dpi.lock);
+	mutex_lock(&dpi->lock);
 
-	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI) && !dpi.vdds_dsi_reg) {
+	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI) && !dpi->vdds_dsi_reg) {
 		DSSERR("no VDSS_DSI regulator\n");
 		r = -ENODEV;
 		goto err_no_reg;
@@ -369,7 +378,7 @@ static int dpi_display_enable(struct omap_dss_device *dssdev)
 	}
 
 	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI)) {
-		r = regulator_enable(dpi.vdds_dsi_reg);
+		r = regulator_enable(dpi->vdds_dsi_reg);
 		if (r)
 			goto err_reg_enable;
 	}
@@ -382,21 +391,21 @@ static int dpi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_src_sel;
 
-	if (dpi.dsidev) {
-		r = dsi_runtime_get(dpi.dsidev);
+	if (dpi->dsidev) {
+		r = dsi_runtime_get(dpi->dsidev);
 		if (r)
 			goto err_get_dsi;
 
-		r = dsi_pll_init(dpi.dsidev, 0, 1);
+		r = dsi_pll_init(dpi->dsidev, 0, 1);
 		if (r)
 			goto err_dsi_pll_init;
 	}
 
-	r = dpi_set_mode(out->manager);
+	r = dpi_set_mode(dpi);
 	if (r)
 		goto err_set_mode;
 
-	dpi_config_lcd_manager(out->manager);
+	dpi_config_lcd_manager(dpi);
 
 	mdelay(2);
 
@@ -404,78 +413,84 @@ static int dpi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_mgr_enable;
 
-	mutex_unlock(&dpi.lock);
+	mutex_unlock(&dpi->lock);
 
 	return 0;
 
 err_mgr_enable:
 err_set_mode:
-	if (dpi.dsidev)
-		dsi_pll_uninit(dpi.dsidev, true);
+	if (dpi->dsidev)
+		dsi_pll_uninit(dpi->dsidev, true);
 err_dsi_pll_init:
-	if (dpi.dsidev)
-		dsi_runtime_put(dpi.dsidev);
+	if (dpi->dsidev)
+		dsi_runtime_put(dpi->dsidev);
 err_get_dsi:
 err_src_sel:
 	dispc_runtime_put();
 err_get_dispc:
 	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI))
-		regulator_disable(dpi.vdds_dsi_reg);
+		regulator_disable(dpi->vdds_dsi_reg);
 err_reg_enable:
 err_no_out_mgr:
 err_no_reg:
-	mutex_unlock(&dpi.lock);
+	mutex_unlock(&dpi->lock);
 	return r;
 }
 
 static void dpi_display_disable(struct omap_dss_device *dssdev)
 {
-	struct omap_overlay_manager *mgr = dpi.output.manager;
+	struct dpi_data *dpi = &dpi;
+	struct omap_overlay_manager *mgr = dpi->output.manager;
 
-	mutex_lock(&dpi.lock);
+	mutex_lock(&dpi->lock);
 
 	dss_mgr_disable(mgr);
 
-	if (dpi.dsidev) {
+	if (dpi->dsidev) {
 		dss_select_lcd_clk_source(mgr->id, OMAP_DSS_CLK_SRC_FCK);
-		dsi_pll_uninit(dpi.dsidev, true);
-		dsi_runtime_put(dpi.dsidev);
+		dsi_pll_uninit(dpi->dsidev, true);
+		dsi_runtime_put(dpi->dsidev);
 	}
 
 	dispc_runtime_put();
 
 	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI))
-		regulator_disable(dpi.vdds_dsi_reg);
+		regulator_disable(dpi->vdds_dsi_reg);
 
-	mutex_unlock(&dpi.lock);
+	mutex_unlock(&dpi->lock);
 }
 
 static void dpi_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
+	struct dpi_data *dpi = &dpi;
+
 	DSSDBG("dpi_set_timings\n");
 
-	mutex_lock(&dpi.lock);
+	mutex_lock(&dpi->lock);
 
-	dpi.timings = *timings;
+	dpi->timings = *timings;
 
-	mutex_unlock(&dpi.lock);
+	mutex_unlock(&dpi->lock);
 }
 
 static void dpi_get_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
-	mutex_lock(&dpi.lock);
+	struct dpi_data *dpi = &dpi;
+
+	mutex_lock(&dpi->lock);
 
-	*timings = dpi.timings;
+	*timings = dpi->timings;
 
-	mutex_unlock(&dpi.lock);
+	mutex_unlock(&dpi->lock);
 }
 
 static int dpi_check_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
 {
-	struct omap_overlay_manager *mgr = dpi.output.manager;
+	struct dpi_data *dpi = &dpi;
+	struct omap_overlay_manager *mgr = dpi->output.manager;
 	int lck_div, pck_div;
 	unsigned long fck;
 	unsigned long pck;
@@ -488,8 +503,8 @@ static int dpi_check_timings(struct omap_dss_device *dssdev,
 	if (timings->pixelclock == 0)
 		return -EINVAL;
 
-	if (dpi.dsidev) {
-		ok = dpi_dsi_clk_calc(timings->pixelclock, &ctx);
+	if (dpi->dsidev) {
+		ok = dpi_dsi_clk_calc(dpi, timings->pixelclock, &ctx);
 		if (!ok)
 			return -EINVAL;
 
@@ -514,11 +529,13 @@ static int dpi_check_timings(struct omap_dss_device *dssdev,
 
 static void dpi_set_data_lines(struct omap_dss_device *dssdev, int data_lines)
 {
-	mutex_lock(&dpi.lock);
+	struct dpi_data *dpi = &dpi;
 
-	dpi.data_lines = data_lines;
+	mutex_lock(&dpi->lock);
 
-	mutex_unlock(&dpi.lock);
+	dpi->data_lines = data_lines;
+
+	mutex_unlock(&dpi->lock);
 }
 
 static int dpi_verify_dsi_pll(struct platform_device *dsidev)
@@ -543,36 +560,36 @@ static int dpi_verify_dsi_pll(struct platform_device *dsidev)
 	return 0;
 }
 
-static int dpi_init_regulator(void)
+static int dpi_init_regulator(struct dpi_data *dpi)
 {
 	struct regulator *vdds_dsi;
 
 	if (!dss_has_feature(FEAT_DPI_USES_VDDS_DSI))
 		return 0;
 
-	if (dpi.vdds_dsi_reg)
+	if (dpi->vdds_dsi_reg)
 		return 0;
 
-	vdds_dsi = devm_regulator_get(&dpi.pdev->dev, "vdds_dsi");
+	vdds_dsi = devm_regulator_get(&dpi->pdev->dev, "vdds_dsi");
 	if (IS_ERR(vdds_dsi)) {
 		if (PTR_ERR(vdds_dsi) != -EPROBE_DEFER)
 			DSSERR("can't get VDDS_DSI regulator\n");
 		return PTR_ERR(vdds_dsi);
 	}
 
-	dpi.vdds_dsi_reg = vdds_dsi;
+	dpi->vdds_dsi_reg = vdds_dsi;
 
 	return 0;
 }
 
-static void dpi_init_pll(void)
+static void dpi_init_pll(struct dpi_data *dpi)
 {
 	struct platform_device *dsidev;
 
-	if (dpi.dsidev)
+	if (dpi->dsidev)
 		return;
 
-	dsidev = dpi_get_dsidev(dpi.output.dispc_channel);
+	dsidev = dpi_get_dsidev(dpi->output.dispc_channel);
 	if (!dsidev)
 		return;
 
@@ -581,7 +598,7 @@ static void dpi_init_pll(void)
 		return;
 	}
 
-	dpi.dsidev = dsidev;
+	dpi->dsidev = dsidev;
 }
 
 /*
@@ -618,14 +635,15 @@ static enum omap_channel dpi_get_channel(void)
 static int dpi_connect(struct omap_dss_device *dssdev,
 		struct omap_dss_device *dst)
 {
+	struct dpi_data *dpi = &dpi;
 	struct omap_overlay_manager *mgr;
 	int r;
 
-	r = dpi_init_regulator();
+	r = dpi_init_regulator(dpi);
 	if (r)
 		return r;
 
-	dpi_init_pll();
+	dpi_init_pll(dpi);
 
 	mgr = omap_dss_get_overlay_manager(dssdev->dispc_channel);
 	if (!mgr)
@@ -676,7 +694,8 @@ static const struct omapdss_dpi_ops dpi_ops = {
 
 static void dpi_init_output(struct platform_device *pdev)
 {
-	struct omap_dss_device *out = &dpi.output;
+	struct dpi_data *dpi = &dpi;
+	struct omap_dss_device *out = &dpi->output;
 
 	out->dev = &pdev->dev;
 	out->id = OMAP_DSS_OUTPUT_DPI;
@@ -691,16 +710,21 @@ static void dpi_init_output(struct platform_device *pdev)
 
 static void __exit dpi_uninit_output(struct platform_device *pdev)
 {
-	struct omap_dss_device *out = &dpi.output;
+	struct dpi_data *dpi = &dpi;
+	struct omap_dss_device *out = &dpi->output;
 
 	omapdss_unregister_output(out);
 }
 
 static int omap_dpi_probe(struct platform_device *pdev)
 {
-	dpi.pdev = pdev;
+	struct dpi_data *dpi = &dpi;
+
+	dpi->pdev = pdev;
 
-	mutex_init(&dpi.lock);
+	dev_set_drvdata(&pdev->dev, dpi);
+
+	mutex_init(&dpi->lock);
 
 	dpi_init_output(pdev);
 
@@ -735,6 +759,7 @@ void __exit dpi_uninit_platform_driver(void)
 
 int __init dpi_init_port(struct platform_device *pdev, struct device_node *port)
 {
+	struct dpi_data *dpi = &dpi;
 	struct device_node *ep;
 	u32 datalines;
 	int r;
@@ -749,17 +774,17 @@ int __init dpi_init_port(struct platform_device *pdev, struct device_node *port)
 		goto err_datalines;
 	}
 
-	dpi.data_lines = datalines;
+	dpi->data_lines = datalines;
 
 	of_node_put(ep);
 
-	dpi.pdev = pdev;
+	dpi->pdev = pdev;
 
-	mutex_init(&dpi.lock);
+	mutex_init(&dpi->lock);
 
 	dpi_init_output(pdev);
 
-	dpi.port_initialized = true;
+	dpi->port_initialized = true;
 
 	return 0;
 
@@ -771,8 +796,10 @@ err_datalines:
 
 void __exit dpi_uninit_port(void)
 {
-	if (!dpi.port_initialized)
+	struct dpi_data *dpi = &dpi;
+
+	if (!dpi->port_initialized)
 		return;
 
-	dpi_uninit_output(dpi.pdev);
+	dpi_uninit_output(dpi->pdev);
 }
-- 
1.8.3.2

