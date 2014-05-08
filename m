From: Archit Taneja <archit@ti.com>
Subject: [RFC 4/6] omapdss: DPI: support multiple DPI instances
Date: Thu, 8 May 2014 14:45:15 +0530
Message-ID: <1399540517-17883-4-git-send-email-archit@ti.com>
References: <1399540517-17883-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44873 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbaEHJQe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2014 05:16:34 -0400
In-Reply-To: <1399540517-17883-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

SoCs containing DSS until now had only one DPI instance. DRA7x has 3 DPI
instances.

In order to support multiple instances, we allocate a driver data
struct(dpi_data) for each instance. This is somewhat similar to how DSI driver
was changed to support multiple instances.

One difference is that there are no platform devices for each instance when DT
is used. In the DT case, we store the dpi_data pointer in the DPI port's
(of the type struct device_node) data pointer. In the non DT case, we still
have dummy platform devices, and the device's private data pointer is used to
store the DPI instance's dpi_data.

When an encoder/panel driver calls a dpi op, we get dpi_data using the function
dpi_get_data_from_dssdev. This function iterates through the ports under DSS
device node, and returns the port which has reg-id matching the reg-id specified
in omap_dss_device.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c | 282 +++++++++++++++++++++++++-----------
 1 file changed, 200 insertions(+), 82 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index 6593c8b..b891e17 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -37,7 +37,7 @@
 #include "dss.h"
 #include "dss_features.h"
 
-static struct {
+struct dpi_data {
 	struct platform_device *pdev;
 
 	struct regulator *vdds_dsi_reg;
@@ -52,7 +52,45 @@ static struct {
 	struct omap_dss_device output;
 
 	bool port_initialized;
-} dpi;
+};
+
+static struct dpi_data *dpi_get_data_from_dssdev(struct omap_dss_device *dssdev)
+{
+	struct device_node *parent = dssdev->dev->of_node;
+	struct device_node *port;
+
+	/* non DT */
+	if (!parent) {
+		struct omap_dss_device *out = dssdev->src;
+
+		return dev_get_drvdata(out->dev);
+	}
+
+	port = omapdss_of_get_next_port(parent, NULL);
+	if (!port)
+		return NULL;
+
+	do {
+		int r;
+		u32 reg;
+
+		r = of_property_read_u32(port, "reg", &reg);
+		if (r)
+			reg = 0;
+
+		if (reg == dssdev->reg)
+			return port->data;
+
+	} while ((port = omapdss_of_get_next_port(parent, port)) != NULL);
+
+	return NULL;
+}
+
+/* use only for non DT mode */
+static struct dpi_data *dpi_get_data_from_pdev(struct platform_device *pdev)
+{
+	return dev_get_drvdata(&pdev->dev);
+}
 
 static struct platform_device *dpi_get_dsidev(enum omap_channel channel)
 {
@@ -197,15 +235,16 @@ static bool dpi_calc_dss_cb(unsigned long fck, void *data)
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
@@ -213,7 +252,7 @@ static bool dpi_dsi_clk_calc(unsigned long pck, struct dpi_clk_calc_ctx *ctx)
 	pll_min = 0;
 	pll_max = 0;
 
-	return dsi_pll_calc(dpi.dsidev, clkin,
+	return dsi_pll_calc(dpi->dsidev, clkin,
 			pll_min, pll_max,
 			dpi_calc_pll_cb, ctx);
 }
@@ -249,7 +288,7 @@ static bool dpi_dss_clk_calc(unsigned long pck, struct dpi_clk_calc_ctx *ctx)
 
 
 
-static int dpi_set_dsi_clk(enum omap_channel channel,
+static int dpi_set_dsi_clk(struct dpi_data *dpi, enum omap_channel channel,
 		unsigned long pck_req, unsigned long *fck, int *lck_div,
 		int *pck_div)
 {
@@ -257,18 +296,18 @@ static int dpi_set_dsi_clk(enum omap_channel channel,
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
@@ -277,8 +316,8 @@ static int dpi_set_dsi_clk(enum omap_channel channel,
 	return 0;
 }
 
-static int dpi_set_dispc_clk(unsigned long pck_req, unsigned long *fck,
-		int *lck_div, int *pck_div)
+static int dpi_set_dispc_clk(struct dpi_data *dpi, unsigned long pck_req,
+		unsigned long *fck, int *lck_div, int *pck_div)
 {
 	struct dpi_clk_calc_ctx ctx;
 	int r;
@@ -292,7 +331,7 @@ static int dpi_set_dispc_clk(unsigned long pck_req, unsigned long *fck,
 	if (r)
 		return r;
 
-	dpi.mgr_config.clock_info = ctx.dispc_cinfo;
+	dpi->mgr_config.clock_info = ctx.dispc_cinfo;
 
 	*fck = ctx.fck;
 	*lck_div = ctx.dispc_cinfo.lck_div;
@@ -301,19 +340,21 @@ static int dpi_set_dispc_clk(unsigned long pck_req, unsigned long *fck,
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
@@ -332,28 +373,32 @@ static int dpi_set_mode(struct omap_overlay_manager *mgr)
 	return 0;
 }
 
-static void dpi_config_lcd_manager(struct omap_overlay_manager *mgr)
+static void dpi_config_lcd_manager(struct dpi_data *dpi)
 {
-	dpi.mgr_config.io_pad_mode = DSS_IO_PAD_MODE_BYPASS;
+	struct omap_dss_device *out = &dpi->output;
+	struct omap_overlay_manager *mgr = out->manager;
 
-	dpi.mgr_config.stallmode = false;
-	dpi.mgr_config.fifohandcheck = false;
+	dpi->mgr_config.io_pad_mode = DSS_IO_PAD_MODE_BYPASS;
 
-	dpi.mgr_config.video_port_width = dpi.data_lines;
+	dpi->mgr_config.stallmode = false;
+	dpi->mgr_config.fifohandcheck = false;
 
-	dpi.mgr_config.lcden_sig_polarity = 0;
+	dpi->mgr_config.video_port_width = dpi->data_lines;
 
-	dss_mgr_set_lcd_config(mgr, &dpi.mgr_config);
+	dpi->mgr_config.lcden_sig_polarity = 0;
+
+	dss_mgr_set_lcd_config(mgr, &dpi->mgr_config);
 }
 
 static int dpi_display_enable(struct omap_dss_device *dssdev)
 {
-	struct omap_dss_device *out = &dpi.output;
+	struct dpi_data *dpi = dpi_get_data_from_dssdev(dssdev);
+	struct omap_dss_device *out = &dpi->output;
 	int r;
 
-	mutex_lock(&dpi.lock);
+	mutex_lock(&dpi->lock);
 
-	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI) && !dpi.vdds_dsi_reg) {
+	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI) && !dpi->vdds_dsi_reg) {
 		DSSERR("no VDSS_DSI regulator\n");
 		r = -ENODEV;
 		goto err_no_reg;
@@ -366,7 +411,7 @@ static int dpi_display_enable(struct omap_dss_device *dssdev)
 	}
 
 	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI)) {
-		r = regulator_enable(dpi.vdds_dsi_reg);
+		r = regulator_enable(dpi->vdds_dsi_reg);
 		if (r)
 			goto err_reg_enable;
 	}
@@ -379,21 +424,21 @@ static int dpi_display_enable(struct omap_dss_device *dssdev)
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
 
@@ -401,78 +446,84 @@ static int dpi_display_enable(struct omap_dss_device *dssdev)
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
+	struct dpi_data *dpi = dpi_get_data_from_dssdev(dssdev);
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
+	struct dpi_data *dpi = dpi_get_data_from_dssdev(dssdev);
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
+	struct dpi_data *dpi = dpi_get_data_from_dssdev(dssdev);
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
+	struct dpi_data *dpi = dpi_get_data_from_dssdev(dssdev);
+	struct omap_overlay_manager *mgr = dpi->output.manager;
 	int lck_div, pck_div;
 	unsigned long fck;
 	unsigned long pck;
@@ -485,8 +536,8 @@ static int dpi_check_timings(struct omap_dss_device *dssdev,
 	if (timings->pixelclock == 0)
 		return -EINVAL;
 
-	if (dpi.dsidev) {
-		ok = dpi_dsi_clk_calc(timings->pixelclock, &ctx);
+	if (dpi->dsidev) {
+		ok = dpi_dsi_clk_calc(dpi, timings->pixelclock, &ctx);
 		if (!ok)
 			return -EINVAL;
 
@@ -511,11 +562,13 @@ static int dpi_check_timings(struct omap_dss_device *dssdev,
 
 static void dpi_set_data_lines(struct omap_dss_device *dssdev, int data_lines)
 {
-	mutex_lock(&dpi.lock);
+	struct dpi_data *dpi = dpi_get_data_from_dssdev(dssdev);
 
-	dpi.data_lines = data_lines;
+	mutex_lock(&dpi->lock);
 
-	mutex_unlock(&dpi.lock);
+	dpi->data_lines = data_lines;
+
+	mutex_unlock(&dpi->lock);
 }
 
 static int dpi_verify_dsi_pll(struct platform_device *dsidev)
@@ -540,36 +593,36 @@ static int dpi_verify_dsi_pll(struct platform_device *dsidev)
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
 
@@ -578,7 +631,7 @@ static void dpi_init_pll(void)
 		return;
 	}
 
-	dpi.dsidev = dsidev;
+	dpi->dsidev = dsidev;
 }
 
 /*
@@ -614,14 +667,15 @@ static enum omap_channel dpi_get_channel(void)
 static int dpi_connect(struct omap_dss_device *dssdev,
 		struct omap_dss_device *dst)
 {
+	struct dpi_data *dpi = dpi_get_data_from_dssdev(dssdev);
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
@@ -672,7 +726,8 @@ static const struct omapdss_dpi_ops dpi_ops = {
 
 static void dpi_init_output(struct platform_device *pdev)
 {
-	struct omap_dss_device *out = &dpi.output;
+	struct dpi_data *dpi = dpi_get_data_from_pdev(pdev);
+	struct omap_dss_device *out = &dpi->output;
 
 	out->dev = &pdev->dev;
 	out->id = OMAP_DSS_OUTPUT_DPI;
@@ -685,18 +740,72 @@ static void dpi_init_output(struct platform_device *pdev)
 	omapdss_register_output(out);
 }
 
+static void dpi_init_output_port(struct platform_device *pdev,
+		struct device_node *port)
+{
+	struct dpi_data *dpi = port->data;
+	struct omap_dss_device *out = &dpi->output;
+	int r;
+	u32 reg;
+
+	r = of_property_read_u32(port, "reg", &reg);
+	if (r)
+		reg = 0;
+
+	switch (reg) {
+	case 2:
+		out->name = "dpi.2";
+		break;
+	case 1:
+		out->name = "dpi.1";
+		break;
+	case 0:
+	default:
+		out->name = "dpi.0";
+		break;
+	}
+
+	out->dev = &pdev->dev;
+	out->id = OMAP_DSS_OUTPUT_DPI;
+	out->output_type = OMAP_DISPLAY_TYPE_DPI;
+	out->dispc_channel = dpi_get_channel();
+	out->ops.dpi = &dpi_ops;
+	out->reg = reg;
+	out->owner = THIS_MODULE;
+
+	omapdss_register_output(out);
+}
+
 static void __exit dpi_uninit_output(struct platform_device *pdev)
 {
-	struct omap_dss_device *out = &dpi.output;
+	struct dpi_data *dpi = dpi_get_data_from_pdev(pdev);
+	struct omap_dss_device *out = &dpi->output;
+
+	omapdss_unregister_output(out);
+}
+
+static void dpi_uninit_output_port(struct platform_device *pdev,
+		struct device_node *port)
+{
+	struct dpi_data *dpi = port->data;
+	struct omap_dss_device *out = &dpi->output;
 
 	omapdss_unregister_output(out);
 }
 
 static int omap_dpi_probe(struct platform_device *pdev)
 {
-	dpi.pdev = pdev;
+	struct dpi_data *dpi;
+
+	dpi = devm_kzalloc(&pdev->dev, sizeof(*dpi), GFP_KERNEL);
+	if (!dpi)
+		return -ENOMEM;
+
+	dpi->pdev = pdev;
+
+	dev_set_drvdata(&pdev->dev, dpi);
 
-	mutex_init(&dpi.lock);
+	mutex_init(&dpi->lock);
 
 	dpi_init_output(pdev);
 
@@ -731,10 +840,15 @@ void __exit dpi_uninit_platform_driver(void)
 
 int __init dpi_init_port(struct platform_device *pdev, struct device_node *port)
 {
+	struct dpi_data *dpi;
 	struct device_node *ep;
 	u32 datalines;
 	int r;
 
+	dpi = devm_kzalloc(&pdev->dev, sizeof(*dpi), GFP_KERNEL);
+	if (!dpi)
+		return -ENOMEM;
+
 	ep = omapdss_of_get_next_endpoint(port, NULL);
 	if (!ep)
 		return 0;
@@ -745,17 +859,19 @@ int __init dpi_init_port(struct platform_device *pdev, struct device_node *port)
 		goto err_datalines;
 	}
 
-	dpi.data_lines = datalines;
-
 	of_node_put(ep);
 
-	dpi.pdev = pdev;
+	dpi->data_lines = datalines;
 
-	mutex_init(&dpi.lock);
+	port->data = dpi;
 
-	dpi_init_output(pdev);
+	dpi->pdev = pdev;
 
-	dpi.port_initialized = true;
+	mutex_init(&dpi->lock);
+
+	dpi_init_output_port(pdev, port);
+
+	dpi->port_initialized = true;
 
 	return 0;
 
@@ -767,8 +883,10 @@ err_datalines:
 
 void dpi_uninit_port(struct platform_device *pdev, struct device_node *port)
 {
-	if (!dpi.port_initialized)
+	struct dpi_data *dpi = port->data;
+
+	if (!dpi->port_initialized)
 		return;
 
-	dpi_uninit_output(dpi.pdev);
+	dpi_uninit_output_port(pdev, port);
 }
-- 
1.8.3.2

