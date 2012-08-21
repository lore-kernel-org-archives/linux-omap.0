From: Archit Taneja <archit@ti.com>
Subject: [PATCH 13/23] OMAPDSS: SDI: Pass outputs from panel driver to SDI interface driver
Date: Tue, 21 Aug 2012 11:28:20 +0530
Message-ID: <1345528711-27801-14-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34819 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293Ab2HUGBD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Aug 2012 02:01:03 -0400
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

Modify SDI functions to pass omap_dss_output pointer instead of omap_dss_device
pointer. Modify the panel drivers to call the updated functions.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-acx565akm.c |   22 ++++++++++-----
 drivers/video/omap2/dss/sdi.c                  |   34 ++++++++++++------------
 include/video/omapdss.h                        |    8 +++---
 3 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-acx565akm.c b/drivers/video/omap2/displays/panel-acx565akm.c
index c835aa7..c517b29 100644
--- a/drivers/video/omap2/displays/panel-acx565akm.c
+++ b/drivers/video/omap2/displays/panel-acx565akm.c
@@ -591,19 +591,23 @@ static void acx_panel_remove(struct omap_dss_device *dssdev)
 static int acx_panel_power_on(struct omap_dss_device *dssdev)
 {
 	struct acx565akm_device *md = &acx_dev;
+	struct omap_dss_output *out = dssdev->output;
 	int r;
 
 	dev_dbg(&dssdev->dev, "%s\n", __func__);
 
+	if (out == NULL)
+		return -ENODEV;
+
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
 	mutex_lock(&md->mutex);
 
-	omapdss_sdi_set_timings(dssdev, &dssdev->panel.timings);
-	omapdss_sdi_set_datapairs(dssdev, dssdev->phy.sdi.datapairs);
+	omapdss_sdi_set_timings(out, &dssdev->panel.timings);
+	omapdss_sdi_set_datapairs(out, dssdev->phy.sdi.datapairs);
 
-	r = omapdss_sdi_display_enable(dssdev);
+	r = omapdss_sdi_display_enable(out);
 	if (r) {
 		pr_err("%s sdi enable failed\n", __func__);
 		goto fail_unlock;
@@ -646,7 +650,7 @@ static int acx_panel_power_on(struct omap_dss_device *dssdev)
 
 	return acx565akm_bl_update_status(md->bl_dev);
 fail:
-	omapdss_sdi_display_disable(dssdev);
+	omapdss_sdi_display_disable(out);
 fail_unlock:
 	mutex_unlock(&md->mutex);
 	return r;
@@ -655,6 +659,7 @@ fail_unlock:
 static void acx_panel_power_off(struct omap_dss_device *dssdev)
 {
 	struct acx565akm_device *md = &acx_dev;
+	struct omap_dss_output *out = dssdev->output;
 
 	dev_dbg(&dssdev->dev, "%s\n", __func__);
 
@@ -684,7 +689,7 @@ static void acx_panel_power_off(struct omap_dss_device *dssdev)
 	/* FIXME need to tweak this delay */
 	msleep(100);
 
-	omapdss_sdi_display_disable(dssdev);
+	omapdss_sdi_display_disable(out);
 
 	mutex_unlock(&md->mutex);
 }
@@ -734,7 +739,12 @@ static int acx_panel_resume(struct omap_dss_device *dssdev)
 static void acx_panel_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
-	omapdss_sdi_set_timings(dssdev, timings);
+	struct omap_dss_output *out = dssdev->output;
+
+	if (out == NULL)
+		return;
+
+	omapdss_sdi_set_timings(out, timings);
 
 	dssdev->panel.timings = *timings;
 }
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index a5632d0..4f669be 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -38,7 +38,7 @@ static struct {
 	int datapairs;
 } sdi;
 
-static void sdi_config_lcd_manager(struct omap_dss_device *dssdev)
+static void sdi_config_lcd_manager(struct omap_dss_output *out)
 {
 	sdi.mgr_config.io_pad_mode = DSS_IO_PAD_MODE_BYPASS;
 
@@ -48,10 +48,10 @@ static void sdi_config_lcd_manager(struct omap_dss_device *dssdev)
 	sdi.mgr_config.video_port_width = 24;
 	sdi.mgr_config.lcden_sig_polarity = 1;
 
-	dss_mgr_set_lcd_config(dssdev->manager, &sdi.mgr_config);
+	dss_mgr_set_lcd_config(out->manager, &sdi.mgr_config);
 }
 
-int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
+int omapdss_sdi_display_enable(struct omap_dss_output *out)
 {
 	struct omap_video_timings *t = &sdi.timings;
 	struct dss_clock_info dss_cinfo;
@@ -59,12 +59,12 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	unsigned long pck;
 	int r;
 
-	if (dssdev->manager == NULL) {
+	if (out->manager == NULL) {
 		DSSERR("failed to enable display: no manager\n");
 		return -ENODEV;
 	}
 
-	r = omap_dss_start_device(dssdev);
+	r = omap_dss_start_device(out->device);
 	if (r) {
 		DSSERR("failed to start device\n");
 		goto err_start_dev;
@@ -98,14 +98,13 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 		t->pixel_clock = pck;
 	}
 
-
-	dss_mgr_set_timings(dssdev->manager, t);
+	dss_mgr_set_timings(out->manager, t);
 
 	r = dss_set_clock_div(&dss_cinfo);
 	if (r)
 		goto err_set_dss_clock_div;
 
-	sdi_config_lcd_manager(dssdev);
+	sdi_config_lcd_manager(out);
 
 	dss_sdi_init(sdi.datapairs);
 
@@ -114,7 +113,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 		goto err_sdi_enable;
 	mdelay(2);
 
-	r = dss_mgr_enable(dssdev->manager);
+	r = dss_mgr_enable(out->manager);
 	if (r)
 		goto err_mgr_enable;
 
@@ -129,15 +128,15 @@ err_calc_clock_div:
 err_get_dispc:
 	regulator_disable(sdi.vdds_sdi_reg);
 err_reg_enable:
-	omap_dss_stop_device(dssdev);
+	omap_dss_stop_device(out->device);
 err_start_dev:
 	return r;
 }
 EXPORT_SYMBOL(omapdss_sdi_display_enable);
 
-void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
+void omapdss_sdi_display_disable(struct omap_dss_output *out)
 {
-	dss_mgr_disable(dssdev->manager);
+	dss_mgr_disable(out->manager);
 
 	dss_sdi_disable();
 
@@ -145,28 +144,29 @@ void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
 
 	regulator_disable(sdi.vdds_sdi_reg);
 
-	omap_dss_stop_device(dssdev);
+	omap_dss_stop_device(out->device);
 }
 EXPORT_SYMBOL(omapdss_sdi_display_disable);
 
-void omapdss_sdi_set_timings(struct omap_dss_device *dssdev,
+void omapdss_sdi_set_timings(struct omap_dss_output *out,
 		struct omap_video_timings *timings)
 {
 	int r;
+	struct omap_dss_device *dssdev = out->device;
 
 	sdi.timings = *timings;
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
-		omapdss_sdi_display_disable(dssdev);
+		omapdss_sdi_display_disable(out);
 
-		r = omapdss_sdi_display_enable(dssdev);
+		r = omapdss_sdi_display_enable(out);
 		if (r)
 			DSSERR("failed to set new timings\n");
 	}
 }
 EXPORT_SYMBOL(omapdss_sdi_set_timings);
 
-void omapdss_sdi_set_datapairs(struct omap_dss_device *dssdev, int datapairs)
+void omapdss_sdi_set_datapairs(struct omap_dss_output *out, int datapairs)
 {
 	sdi.datapairs = datapairs;
 }
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index f8902f9..cf881c0 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -792,11 +792,11 @@ int dpi_check_timings(struct omap_dss_output *out,
 		struct omap_video_timings *timings);
 void omapdss_dpi_set_data_lines(struct omap_dss_output *out, int data_lines);
 
-int omapdss_sdi_display_enable(struct omap_dss_device *dssdev);
-void omapdss_sdi_display_disable(struct omap_dss_device *dssdev);
-void omapdss_sdi_set_timings(struct omap_dss_device *dssdev,
+int omapdss_sdi_display_enable(struct omap_dss_output *out);
+void omapdss_sdi_display_disable(struct omap_dss_output *out);
+void omapdss_sdi_set_timings(struct omap_dss_output *out,
 		struct omap_video_timings *timings);
-void omapdss_sdi_set_datapairs(struct omap_dss_device *dssdev, int datapairs);
+void omapdss_sdi_set_datapairs(struct omap_dss_output *out, int datapairs);
 
 int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_rfbi_display_disable(struct omap_dss_device *dssdev);
-- 
1.7.9.5

