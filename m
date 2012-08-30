From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 10/23] OMAPDSS: DPI: Pass omap_dss_output within the driver
Date: Thu, 30 Aug 2012 17:10:32 +0530
Message-ID: <1346326845-16583-11-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
 <1346326845-16583-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41022 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754292Ab2H3Lm6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 07:42:58 -0400
In-Reply-To: <1346326845-16583-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

When a panel driver calls a DPI function, it passes the omap_dss_device
pointer, this pointer currently propagates within the DPI driver to configure
the interface.

Extract the omap_dss_output pointer from omap_dss_device received from the panel
driver, pass the output pointer to DPI functions local to the driver to
configure the interface, these functions no longer need omap_dss_device since
the driver now maintains a copy of output parameters.

Replace dssdev->manager references with out->manager references as only these
will be valid later.

With the addition of outputs. There is a possibility that an omap_dss_device
isn't connected to an output, or a manager isn't connected to an output yet.
Ensure that the DPI interface functions proceed only if the output is non NULL.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dpi.c |   55 +++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 9a7aee5..cb17adb 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -73,7 +73,7 @@ static bool dpi_use_dsi_pll(struct omap_dss_device *dssdev)
 		return false;
 }
 
-static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
+static int dpi_set_dsi_clk(struct omap_dss_output *out,
 		unsigned long pck_req, unsigned long *fck, int *lck_div,
 		int *pck_div)
 {
@@ -90,7 +90,7 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
 	if (r)
 		return r;
 
-	dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);
+	dss_select_dispc_clk_source(out->device->clocks.dispc.dispc_fclk_src);
 
 	dpi.mgr_config.clock_info = dispc_cinfo;
 
@@ -101,7 +101,7 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
 	return 0;
 }
 
-static int dpi_set_dispc_clk(struct omap_dss_device *dssdev,
+static int dpi_set_dispc_clk(struct omap_dss_output *out,
 		unsigned long pck_req, unsigned long *fck, int *lck_div,
 		int *pck_div)
 {
@@ -126,7 +126,7 @@ static int dpi_set_dispc_clk(struct omap_dss_device *dssdev,
 	return 0;
 }
 
-static int dpi_set_mode(struct omap_dss_device *dssdev)
+static int dpi_set_mode(struct omap_dss_output *out)
 {
 	struct omap_video_timings *t = &dpi.timings;
 	int lck_div = 0, pck_div = 0;
@@ -134,11 +134,11 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 	unsigned long pck;
 	int r = 0;
 
-	if (dpi_use_dsi_pll(dssdev))
-		r = dpi_set_dsi_clk(dssdev, t->pixel_clock * 1000, &fck,
+	if (dpi_use_dsi_pll(out->device))
+		r = dpi_set_dsi_clk(out, t->pixel_clock * 1000, &fck,
 				&lck_div, &pck_div);
 	else
-		r = dpi_set_dispc_clk(dssdev, t->pixel_clock * 1000, &fck,
+		r = dpi_set_dispc_clk(out, t->pixel_clock * 1000, &fck,
 				&lck_div, &pck_div);
 	if (r)
 		return r;
@@ -153,12 +153,12 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 		t->pixel_clock = pck;
 	}
 
-	dss_mgr_set_timings(dssdev->manager, t);
+	dss_mgr_set_timings(out->manager, t);
 
 	return 0;
 }
 
-static void dpi_config_lcd_manager(struct omap_dss_device *dssdev)
+static void dpi_config_lcd_manager(struct omap_dss_output *out)
 {
 	dpi.mgr_config.io_pad_mode = DSS_IO_PAD_MODE_BYPASS;
 
@@ -169,11 +169,12 @@ static void dpi_config_lcd_manager(struct omap_dss_device *dssdev)
 
 	dpi.mgr_config.lcden_sig_polarity = 0;
 
-	dss_mgr_set_lcd_config(dssdev->manager, &dpi.mgr_config);
+	dss_mgr_set_lcd_config(out->manager, &dpi.mgr_config);
 }
 
 int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
 	mutex_lock(&dpi.lock);
@@ -184,10 +185,10 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 		goto err_no_reg;
 	}
 
-	if (dssdev->manager == NULL) {
-		DSSERR("failed to enable display: no manager\n");
+	if (out == NULL || out->manager == NULL) {
+		DSSERR("failed to enable display: no output/manager\n");
 		r = -ENODEV;
-		goto err_no_mgr;
+		goto err_no_out_mgr;
 	}
 
 	r = omap_dss_start_device(dssdev);
@@ -216,15 +217,15 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 			goto err_dsi_pll_init;
 	}
 
-	r = dpi_set_mode(dssdev);
+	r = dpi_set_mode(out);
 	if (r)
 		goto err_set_mode;
 
-	dpi_config_lcd_manager(dssdev);
+	dpi_config_lcd_manager(out);
 
 	mdelay(2);
 
-	r = dss_mgr_enable(dssdev->manager);
+	r = dss_mgr_enable(out->manager);
 	if (r)
 		goto err_mgr_enable;
 
@@ -247,7 +248,7 @@ err_get_dispc:
 err_reg_enable:
 	omap_dss_stop_device(dssdev);
 err_start_dev:
-err_no_mgr:
+err_no_out_mgr:
 err_no_reg:
 	mutex_unlock(&dpi.lock);
 	return r;
@@ -256,9 +257,11 @@ EXPORT_SYMBOL(omapdss_dpi_display_enable);
 
 void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
+
 	mutex_lock(&dpi.lock);
 
-	dss_mgr_disable(dssdev->manager);
+	dss_mgr_disable(out->manager);
 
 	if (dpi_use_dsi_pll(dssdev)) {
 		dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
@@ -280,10 +283,16 @@ EXPORT_SYMBOL(omapdss_dpi_display_disable);
 void omapdss_dpi_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
 	DSSDBG("dpi_set_timings\n");
 
+	if (out == NULL) {
+		DSSERR("No output connected to %s\n", dssdev->name);
+		return;
+	}
+
 	mutex_lock(&dpi.lock);
 
 	dpi.timings = *timings;
@@ -293,11 +302,11 @@ void omapdss_dpi_set_timings(struct omap_dss_device *dssdev,
 		if (r)
 			return;
 
-		dpi_set_mode(dssdev);
+		dpi_set_mode(out);
 
 		dispc_runtime_put();
 	} else {
-		dss_mgr_set_timings(dssdev->manager, timings);
+		dss_mgr_set_timings(out->manager, timings);
 	}
 
 	mutex_unlock(&dpi.lock);
@@ -312,8 +321,12 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 	unsigned long fck;
 	unsigned long pck;
 	struct dispc_clock_info dispc_cinfo;
+	struct omap_dss_output *out = dssdev->output;
+
+	if (out == NULL)
+		return -ENODEV;
 
-	if (dss_mgr_check_timings(dssdev->manager, timings))
+	if (dss_mgr_check_timings(out->manager, timings))
 		return -EINVAL;
 
 	if (timings->pixel_clock == 0)
-- 
1.7.9.5

