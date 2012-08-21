From: Archit Taneja <archit@ti.com>
Subject: [PATCH 10/23] OMAPDSS: DPI: Pass outputs from panel driver to DPI interface driver
Date: Tue, 21 Aug 2012 11:28:17 +0530
Message-ID: <1345528711-27801-11-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60122 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753286Ab2HUGAv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 02:00:51 -0400
In-Reply-To: <1345528711-27801-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com, Archit Taneja <archit@ti.com>

With outputs introduces as new entities, we can now pass output pointer to
functions used to configure the connected interface. These functions currently
pass the omap_dss_device pointer, and extract output information via
omap_dss_device. This is unnecessary, and it doesn't make sense for interface
related functions to get the panel's/device's pointer, it should receive a
pointer related to the connected interface, which in our case is the output
entity.

With the addition of outputs. There is a possibility that an omap_dss_device
isn't connected to an output yet. Ensure that panel drivers call the interface
functions only if outputs are non NULL.

Modify DPI functions to pass omap_dss_output pointer instead of omap_dss_device
pointer. Modify the panel drivers to call the updated functions.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c   |   27 ++++++---
 .../omap2/displays/panel-lgphilips-lb035q02.c      |   16 +++--
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |   15 +++--
 drivers/video/omap2/displays/panel-picodlp.c       |   15 +++--
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   16 +++--
 drivers/video/omap2/displays/panel-tfp410.c        |   17 ++++--
 .../video/omap2/displays/panel-tpo-td043mtea1.c    |   29 ++++++---
 drivers/video/omap2/dss/dpi.c                      |   64 ++++++++++----------
 include/video/omapdss.h                            |   12 ++--
 9 files changed, 133 insertions(+), 78 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 88295c5..76ee8df 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -561,14 +561,18 @@ static int generic_dpi_panel_power_on(struct omap_dss_device *dssdev)
 	struct panel_generic_dpi_data *panel_data = get_panel_data(dssdev);
 	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
 	struct panel_config *panel_config = drv_data->panel_config;
+	struct omap_dss_output *out = dssdev->output;
+
+	if (out == NULL)
+		return -ENODEV;
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
-	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
-	omapdss_dpi_set_data_lines(dssdev, dssdev->phy.dpi.data_lines);
+	omapdss_dpi_set_timings(out, &dssdev->panel.timings);
+	omapdss_dpi_set_data_lines(out, dssdev->phy.dpi.data_lines);
 
-	r = omapdss_dpi_display_enable(dssdev);
+	r = omapdss_dpi_display_enable(out);
 	if (r)
 		goto err0;
 
@@ -584,7 +588,7 @@ static int generic_dpi_panel_power_on(struct omap_dss_device *dssdev)
 
 	return 0;
 err1:
-	omapdss_dpi_display_disable(dssdev);
+	omapdss_dpi_display_disable(out);
 err0:
 	return r;
 }
@@ -594,6 +598,7 @@ static void generic_dpi_panel_power_off(struct omap_dss_device *dssdev)
 	struct panel_generic_dpi_data *panel_data = get_panel_data(dssdev);
 	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
 	struct panel_config *panel_config = drv_data->panel_config;
+	struct omap_dss_output *out = dssdev->output;
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return;
@@ -605,7 +610,7 @@ static void generic_dpi_panel_power_off(struct omap_dss_device *dssdev)
 	if (panel_config->power_off_delay)
 		msleep(panel_config->power_off_delay);
 
-	omapdss_dpi_display_disable(dssdev);
+	omapdss_dpi_display_disable(out);
 }
 
 static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
@@ -726,10 +731,14 @@ static void generic_dpi_panel_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
 	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
+	struct omap_dss_output *out = dssdev->output;
+
+	if (out == NULL)
+		return;
 
 	mutex_lock(&drv_data->lock);
 
-	omapdss_dpi_set_timings(dssdev, timings);
+	omapdss_dpi_set_timings(out, timings);
 
 	dssdev->panel.timings = *timings;
 
@@ -752,11 +761,15 @@ static int generic_dpi_panel_check_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
 	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
+	if (out == NULL)
+		return -ENODEV;
+
 	mutex_lock(&drv_data->lock);
 
-	r = dpi_check_timings(dssdev, timings);
+	r = dpi_check_timings(out, timings);
 
 	mutex_unlock(&drv_data->lock);
 
diff --git a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
index 90c1cab..2764c32 100644
--- a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
@@ -50,15 +50,19 @@ static struct omap_video_timings lb035q02_timings = {
 
 static int lb035q02_panel_power_on(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
+	if (out == NULL)
+		return -ENODEV;
+
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
-	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
-	omapdss_dpi_set_data_lines(dssdev, dssdev->phy.dpi.data_lines);
+	omapdss_dpi_set_timings(out, &dssdev->panel.timings);
+	omapdss_dpi_set_data_lines(out, dssdev->phy.dpi.data_lines);
 
-	r = omapdss_dpi_display_enable(dssdev);
+	r = omapdss_dpi_display_enable(out);
 	if (r)
 		goto err0;
 
@@ -70,20 +74,22 @@ static int lb035q02_panel_power_on(struct omap_dss_device *dssdev)
 
 	return 0;
 err1:
-	omapdss_dpi_display_disable(dssdev);
+	omapdss_dpi_display_disable(out);
 err0:
 	return r;
 }
 
 static void lb035q02_panel_power_off(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
+
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return;
 
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
 
-	omapdss_dpi_display_disable(dssdev);
+	omapdss_dpi_display_disable(out);
 }
 
 static int lb035q02_panel_probe(struct omap_dss_device *dssdev)
diff --git a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
index 908fd26..906bc48 100644
--- a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
+++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
@@ -171,14 +171,18 @@ static int nec_8048_panel_power_on(struct omap_dss_device *dssdev)
 	int r;
 	struct nec_8048_data *necd = dev_get_drvdata(&dssdev->dev);
 	struct backlight_device *bl = necd->bl;
+	struct omap_dss_output *out = dssdev->output;
+
+	if (out == NULL)
+		return -ENODEV;
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
-	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
-	omapdss_dpi_set_data_lines(dssdev, dssdev->phy.dpi.data_lines);
+	omapdss_dpi_set_timings(out, &dssdev->panel.timings);
+	omapdss_dpi_set_data_lines(out, dssdev->phy.dpi.data_lines);
 
-	r = omapdss_dpi_display_enable(dssdev);
+	r = omapdss_dpi_display_enable(out);
 	if (r)
 		goto err0;
 
@@ -194,7 +198,7 @@ static int nec_8048_panel_power_on(struct omap_dss_device *dssdev)
 
 	return 0;
 err1:
-	omapdss_dpi_display_disable(dssdev);
+	omapdss_dpi_display_disable(out);
 err0:
 	return r;
 }
@@ -203,6 +207,7 @@ static void nec_8048_panel_power_off(struct omap_dss_device *dssdev)
 {
 	struct nec_8048_data *necd = dev_get_drvdata(&dssdev->dev);
 	struct backlight_device *bl = necd->bl;
+	struct omap_dss_output *out = dssdev->output;
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return;
@@ -213,7 +218,7 @@ static void nec_8048_panel_power_off(struct omap_dss_device *dssdev)
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
 
-	omapdss_dpi_display_disable(dssdev);
+	omapdss_dpi_display_disable(out);
 }
 
 static int nec_8048_panel_enable(struct omap_dss_device *dssdev)
diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
index 9df8764..2bd4f7b 100644
--- a/drivers/video/omap2/displays/panel-picodlp.c
+++ b/drivers/video/omap2/displays/panel-picodlp.c
@@ -352,6 +352,10 @@ static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
 	int r, trial = 100;
 	struct picodlp_data *picod = dev_get_drvdata(&dssdev->dev);
 	struct picodlp_panel_data *picodlp_pdata = get_panel_data(dssdev);
+	struct omap_dss_output *out = dssdev->output;
+
+	if (out == NULL)
+		return -ENODEV;
 
 	if (dssdev->platform_enable) {
 		r = dssdev->platform_enable(dssdev);
@@ -378,10 +382,10 @@ static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
 	 */
 	msleep(1000);
 
-	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
-	omapdss_dpi_set_data_lines(dssdev, dssdev->phy.dpi.data_lines);
+	omapdss_dpi_set_timings(out, &dssdev->panel.timings);
+	omapdss_dpi_set_data_lines(out, dssdev->phy.dpi.data_lines);
 
-	r = omapdss_dpi_display_enable(dssdev);
+	r = omapdss_dpi_display_enable(out);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to enable DPI\n");
 		goto err1;
@@ -395,7 +399,7 @@ static int picodlp_panel_power_on(struct omap_dss_device *dssdev)
 
 	return r;
 err:
-	omapdss_dpi_display_disable(dssdev);
+	omapdss_dpi_display_disable(out);
 err1:
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
@@ -406,8 +410,9 @@ err1:
 static void picodlp_panel_power_off(struct omap_dss_device *dssdev)
 {
 	struct picodlp_panel_data *picodlp_pdata = get_panel_data(dssdev);
+	struct omap_dss_output *out = dssdev->output;
 
-	omapdss_dpi_display_disable(dssdev);
+	omapdss_dpi_display_disable(out);
 
 	gpio_set_value(picodlp_pdata->emu_done_gpio, 0);
 	gpio_set_value(picodlp_pdata->pwrgood_gpio, 0);
diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
index 1ec3b27..dffd85a 100644
--- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
@@ -137,15 +137,19 @@ static void __exit sharp_ls_panel_remove(struct omap_dss_device *dssdev)
 
 static int sharp_ls_power_on(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
 	int r = 0;
 
+	if (out == NULL)
+		return -ENODEV;
+
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
-	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
-	omapdss_dpi_set_data_lines(dssdev, dssdev->phy.dpi.data_lines);
+	omapdss_dpi_set_timings(out, &dssdev->panel.timings);
+	omapdss_dpi_set_data_lines(out, dssdev->phy.dpi.data_lines);
 
-	r = omapdss_dpi_display_enable(dssdev);
+	r = omapdss_dpi_display_enable(out);
 	if (r)
 		goto err0;
 
@@ -160,13 +164,15 @@ static int sharp_ls_power_on(struct omap_dss_device *dssdev)
 
 	return 0;
 err1:
-	omapdss_dpi_display_disable(dssdev);
+	omapdss_dpi_display_disable(out);
 err0:
 	return r;
 }
 
 static void sharp_ls_power_off(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
+
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return;
 
@@ -177,7 +183,7 @@ static void sharp_ls_power_off(struct omap_dss_device *dssdev)
 
 	msleep(100);
 
-	omapdss_dpi_display_disable(dssdev);
+	omapdss_dpi_display_disable(out);
 }
 
 static int sharp_ls_panel_enable(struct omap_dss_device *dssdev)
diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
index 4be9a59..88a1507 100644
--- a/drivers/video/omap2/displays/panel-tfp410.c
+++ b/drivers/video/omap2/displays/panel-tfp410.c
@@ -60,15 +60,19 @@ struct panel_drv_data {
 static int tfp410_power_on(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
+	if (out == NULL)
+		return -ENODEV;
+
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
-	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
-	omapdss_dpi_set_data_lines(dssdev, dssdev->phy.dpi.data_lines);
+	omapdss_dpi_set_timings(out, &dssdev->panel.timings);
+	omapdss_dpi_set_data_lines(out, dssdev->phy.dpi.data_lines);
 
-	r = omapdss_dpi_display_enable(dssdev);
+	r = omapdss_dpi_display_enable(out);
 	if (r)
 		goto err0;
 
@@ -83,6 +87,7 @@ err0:
 static void tfp410_power_off(struct omap_dss_device *dssdev)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
+	struct omap_dss_output *out = dssdev->output;
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return;
@@ -90,7 +95,7 @@ static void tfp410_power_off(struct omap_dss_device *dssdev)
 	if (gpio_is_valid(ddata->pd_gpio))
 		gpio_set_value_cansleep(ddata->pd_gpio, 0);
 
-	omapdss_dpi_display_disable(dssdev);
+	omapdss_dpi_display_disable(out);
 }
 
 static int tfp410_probe(struct omap_dss_device *dssdev)
@@ -234,7 +239,7 @@ static void tfp410_set_timings(struct omap_dss_device *dssdev,
 	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
 
 	mutex_lock(&ddata->lock);
-	omapdss_dpi_set_timings(dssdev, timings);
+	omapdss_dpi_set_timings(dssdev->output, timings);
 	dssdev->panel.timings = *timings;
 	mutex_unlock(&ddata->lock);
 }
@@ -256,7 +261,7 @@ static int tfp410_check_timings(struct omap_dss_device *dssdev,
 	int r;
 
 	mutex_lock(&ddata->lock);
-	r = dpi_check_timings(dssdev, timings);
+	r = dpi_check_timings(dssdev->output, timings);
 	mutex_unlock(&ddata->lock);
 
 	return r;
diff --git a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
index b5e6dbc..792e9ff 100644
--- a/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/omap2/displays/panel-tpo-td043mtea1.c
@@ -331,16 +331,20 @@ static void tpo_td043_power_off(struct tpo_td043_device *tpo_td043)
 
 static int tpo_td043_enable_dss(struct omap_dss_device *dssdev)
 {
+	struct omap_dss_output *out = dssdev->output;
 	struct tpo_td043_device *tpo_td043 = dev_get_drvdata(&dssdev->dev);
 	int r;
 
+	if (out == NULL)
+		return -ENODEV;
+
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
-	omapdss_dpi_set_timings(dssdev, &dssdev->panel.timings);
-	omapdss_dpi_set_data_lines(dssdev, dssdev->phy.dpi.data_lines);
+	omapdss_dpi_set_timings(out, &dssdev->panel.timings);
+	omapdss_dpi_set_data_lines(out, dssdev->phy.dpi.data_lines);
 
-	r = omapdss_dpi_display_enable(dssdev);
+	r = omapdss_dpi_display_enable(out);
 	if (r)
 		goto err0;
 
@@ -364,7 +368,7 @@ static int tpo_td043_enable_dss(struct omap_dss_device *dssdev)
 
 	return 0;
 err1:
-	omapdss_dpi_display_disable(dssdev);
+	omapdss_dpi_display_disable(out);
 err0:
 	return r;
 }
@@ -372,6 +376,7 @@ err0:
 static void tpo_td043_disable_dss(struct omap_dss_device *dssdev)
 {
 	struct tpo_td043_device *tpo_td043 = dev_get_drvdata(&dssdev->dev);
+	struct omap_dss_output *out = dssdev->output;
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return;
@@ -379,7 +384,7 @@ static void tpo_td043_disable_dss(struct omap_dss_device *dssdev)
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
 
-	omapdss_dpi_display_disable(dssdev);
+	omapdss_dpi_display_disable(out);
 
 	if (!tpo_td043->spi_suspended)
 		tpo_td043_power_off(tpo_td043);
@@ -483,7 +488,12 @@ static void tpo_td043_remove(struct omap_dss_device *dssdev)
 static void tpo_td043_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
-	omapdss_dpi_set_timings(dssdev, timings);
+	struct omap_dss_output *out = dssdev->output;
+
+	if (out == NULL)
+		return;
+
+	omapdss_dpi_set_timings(out, timings);
 
 	dssdev->panel.timings = *timings;
 }
@@ -491,7 +501,12 @@ static void tpo_td043_set_timings(struct omap_dss_device *dssdev,
 static int tpo_td043_check_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
-	return dpi_check_timings(dssdev, timings);
+	struct omap_dss_output *out = dssdev->output;
+
+	if (out == NULL)
+		return -ENODEV;
+
+	return dpi_check_timings(out, timings);
 }
 
 static struct omap_dss_driver tpo_td043_driver = {
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 4eca2e7..6506e40 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -70,7 +70,7 @@ static bool dpi_use_dsi_pll(struct omap_dss_device *dssdev)
 		return false;
 }
 
-static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
+static int dpi_set_dsi_clk(struct omap_dss_output *out,
 		unsigned long pck_req, unsigned long *fck, int *lck_div,
 		int *pck_div)
 {
@@ -87,7 +87,7 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
 	if (r)
 		return r;
 
-	dss_select_dispc_clk_source(dssdev->clocks.dispc.dispc_fclk_src);
+	dss_select_dispc_clk_source(out->device->clocks.dispc.dispc_fclk_src);
 
 	dpi.mgr_config.clock_info = dispc_cinfo;
 
@@ -98,7 +98,7 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
 	return 0;
 }
 
-static int dpi_set_dispc_clk(struct omap_dss_device *dssdev,
+static int dpi_set_dispc_clk(struct omap_dss_output *out,
 		unsigned long pck_req, unsigned long *fck, int *lck_div,
 		int *pck_div)
 {
@@ -123,7 +123,7 @@ static int dpi_set_dispc_clk(struct omap_dss_device *dssdev,
 	return 0;
 }
 
-static int dpi_set_mode(struct omap_dss_device *dssdev)
+static int dpi_set_mode(struct omap_dss_output *out)
 {
 	struct omap_video_timings *t = &dpi.timings;
 	int lck_div = 0, pck_div = 0;
@@ -131,11 +131,11 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
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
@@ -150,12 +150,12 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
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
 
@@ -166,10 +166,10 @@ static void dpi_config_lcd_manager(struct omap_dss_device *dssdev)
 
 	dpi.mgr_config.lcden_sig_polarity = 0;
 
-	dss_mgr_set_lcd_config(dssdev->manager, &dpi.mgr_config);
+	dss_mgr_set_lcd_config(out->manager, &dpi.mgr_config);
 }
 
-int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
+int omapdss_dpi_display_enable(struct omap_dss_output *out)
 {
 	int r;
 
@@ -181,13 +181,13 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 		goto err_no_reg;
 	}
 
-	if (dssdev->manager == NULL) {
+	if (out->manager == NULL) {
 		DSSERR("failed to enable display: no manager\n");
 		r = -ENODEV;
 		goto err_no_mgr;
 	}
 
-	r = omap_dss_start_device(dssdev);
+	r = omap_dss_start_device(out->device);
 	if (r) {
 		DSSERR("failed to start device\n");
 		goto err_start_dev;
@@ -203,7 +203,7 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_get_dispc;
 
-	if (dpi_use_dsi_pll(dssdev)) {
+	if (dpi_use_dsi_pll(out->device)) {
 		r = dsi_runtime_get(dpi.dsidev);
 		if (r)
 			goto err_get_dsi;
@@ -213,15 +213,15 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
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
 
@@ -231,10 +231,10 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 
 err_mgr_enable:
 err_set_mode:
-	if (dpi_use_dsi_pll(dssdev))
+	if (dpi_use_dsi_pll(out->device))
 		dsi_pll_uninit(dpi.dsidev, true);
 err_dsi_pll_init:
-	if (dpi_use_dsi_pll(dssdev))
+	if (dpi_use_dsi_pll(out->device))
 		dsi_runtime_put(dpi.dsidev);
 err_get_dsi:
 	dispc_runtime_put();
@@ -242,7 +242,7 @@ err_get_dispc:
 	if (cpu_is_omap34xx())
 		regulator_disable(dpi.vdds_dsi_reg);
 err_reg_enable:
-	omap_dss_stop_device(dssdev);
+	omap_dss_stop_device(out->device);
 err_start_dev:
 err_no_mgr:
 err_no_reg:
@@ -251,13 +251,13 @@ err_no_reg:
 }
 EXPORT_SYMBOL(omapdss_dpi_display_enable);
 
-void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
+void omapdss_dpi_display_disable(struct omap_dss_output *out)
 {
 	mutex_lock(&dpi.lock);
 
-	dss_mgr_disable(dssdev->manager);
+	dss_mgr_disable(out->manager);
 
-	if (dpi_use_dsi_pll(dssdev)) {
+	if (dpi_use_dsi_pll(out->device)) {
 		dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 		dsi_pll_uninit(dpi.dsidev, true);
 		dsi_runtime_put(dpi.dsidev);
@@ -268,13 +268,13 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 	if (cpu_is_omap34xx())
 		regulator_disable(dpi.vdds_dsi_reg);
 
-	omap_dss_stop_device(dssdev);
+	omap_dss_stop_device(out->device);
 
 	mutex_unlock(&dpi.lock);
 }
 EXPORT_SYMBOL(omapdss_dpi_display_disable);
 
-void omapdss_dpi_set_timings(struct omap_dss_device *dssdev,
+void omapdss_dpi_set_timings(struct omap_dss_output *out,
 		struct omap_video_timings *timings)
 {
 	int r;
@@ -285,23 +285,23 @@ void omapdss_dpi_set_timings(struct omap_dss_device *dssdev,
 
 	dpi.timings = *timings;
 
-	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
+	if (out->device->state == OMAP_DSS_DISPLAY_ACTIVE) {
 		r = dispc_runtime_get();
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
 }
 EXPORT_SYMBOL(omapdss_dpi_set_timings);
 
-int dpi_check_timings(struct omap_dss_device *dssdev,
+int dpi_check_timings(struct omap_dss_output *out,
 			struct omap_video_timings *timings)
 {
 	int r;
@@ -310,13 +310,13 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 	unsigned long pck;
 	struct dispc_clock_info dispc_cinfo;
 
-	if (dss_mgr_check_timings(dssdev->manager, timings))
+	if (dss_mgr_check_timings(out->manager, timings))
 		return -EINVAL;
 
 	if (timings->pixel_clock == 0)
 		return -EINVAL;
 
-	if (dpi_use_dsi_pll(dssdev)) {
+	if (dpi_use_dsi_pll(out->device)) {
 		struct dsi_clock_info dsi_cinfo;
 		r = dsi_pll_calc_clock_div_pck(dpi.dsidev,
 				timings->pixel_clock * 1000,
@@ -348,7 +348,7 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(dpi_check_timings);
 
-void omapdss_dpi_set_data_lines(struct omap_dss_device *dssdev, int data_lines)
+void omapdss_dpi_set_data_lines(struct omap_dss_output *out, int data_lines)
 {
 	mutex_lock(&dpi.lock);
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 361d41e..da3f070 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -783,13 +783,13 @@ int omapdss_dsi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
 		bool disconnect_lanes, bool enter_ulps);
 
-int omapdss_dpi_display_enable(struct omap_dss_device *dssdev);
-void omapdss_dpi_display_disable(struct omap_dss_device *dssdev);
-void omapdss_dpi_set_timings(struct omap_dss_device *dssdev,
+int omapdss_dpi_display_enable(struct omap_dss_output *out);
+void omapdss_dpi_display_disable(struct omap_dss_output *out);
+void omapdss_dpi_set_timings(struct omap_dss_output *out,
 		struct omap_video_timings *timings);
-int dpi_check_timings(struct omap_dss_device *dssdev,
-			struct omap_video_timings *timings);
-void omapdss_dpi_set_data_lines(struct omap_dss_device *dssdev, int data_lines);
+int dpi_check_timings(struct omap_dss_output *out,
+		struct omap_video_timings *timings);
+void omapdss_dpi_set_data_lines(struct omap_dss_output *out, int data_lines);
 
 int omapdss_sdi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_sdi_display_disable(struct omap_dss_device *dssdev);
-- 
1.7.9.5

