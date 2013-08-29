From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/15] OMAPDSS: DPI: remove code related to old panel model
Date: Thu, 29 Aug 2013 16:31:52 +0300
Message-ID: <1377783120-14001-8-git-send-email-tomi.valkeinen@ti.com>
References: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48892 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754403Ab3H2NcT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:32:19 -0400
In-Reply-To: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that the old panel drivers have been removed, we can remove the
old-model API and related code from the DSS encoder drivers.

This patch removes the code from the DPI driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c | 107 ++++--------------------------------------
 include/video/omapdss.h       |   8 ----
 2 files changed, 9 insertions(+), 106 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 89c7a6e..b268d04 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -345,7 +345,7 @@ static void dpi_config_lcd_manager(struct omap_overlay_manager *mgr)
 	dss_mgr_set_lcd_config(mgr, &dpi.mgr_config);
 }
 
-int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
+static int dpi_display_enable(struct omap_dss_device *dssdev)
 {
 	struct omap_dss_device *out = &dpi.output;
 	int r;
@@ -423,9 +423,8 @@ err_no_reg:
 	mutex_unlock(&dpi.lock);
 	return r;
 }
-EXPORT_SYMBOL(omapdss_dpi_display_enable);
 
-void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
+static void dpi_display_disable(struct omap_dss_device *dssdev)
 {
 	struct omap_overlay_manager *mgr = dpi.output.manager;
 
@@ -446,9 +445,8 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 
 	mutex_unlock(&dpi.lock);
 }
-EXPORT_SYMBOL(omapdss_dpi_display_disable);
 
-void omapdss_dpi_set_timings(struct omap_dss_device *dssdev,
+static void dpi_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
 	DSSDBG("dpi_set_timings\n");
@@ -459,7 +457,6 @@ void omapdss_dpi_set_timings(struct omap_dss_device *dssdev,
 
 	mutex_unlock(&dpi.lock);
 }
-EXPORT_SYMBOL(omapdss_dpi_set_timings);
 
 static void dpi_get_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
@@ -471,7 +468,7 @@ static void dpi_get_timings(struct omap_dss_device *dssdev,
 	mutex_unlock(&dpi.lock);
 }
 
-int dpi_check_timings(struct omap_dss_device *dssdev,
+static int dpi_check_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
 {
 	struct omap_overlay_manager *mgr = dpi.output.manager;
@@ -510,9 +507,8 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 
 	return 0;
 }
-EXPORT_SYMBOL(dpi_check_timings);
 
-void omapdss_dpi_set_data_lines(struct omap_dss_device *dssdev, int data_lines)
+static void dpi_set_data_lines(struct omap_dss_device *dssdev, int data_lines)
 {
 	mutex_lock(&dpi.lock);
 
@@ -520,7 +516,6 @@ void omapdss_dpi_set_data_lines(struct omap_dss_device *dssdev, int data_lines)
 
 	mutex_unlock(&dpi.lock);
 }
-EXPORT_SYMBOL(omapdss_dpi_set_data_lines);
 
 static int dpi_verify_dsi_pll(struct platform_device *dsidev)
 {
@@ -614,76 +609,6 @@ static enum omap_channel dpi_get_channel(void)
 	}
 }
 
-static struct omap_dss_device *dpi_find_dssdev(struct platform_device *pdev)
-{
-	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
-	const char *def_disp_name = omapdss_get_default_display_name();
-	struct omap_dss_device *def_dssdev;
-	int i;
-
-	def_dssdev = NULL;
-
-	for (i = 0; i < pdata->num_devices; ++i) {
-		struct omap_dss_device *dssdev = pdata->devices[i];
-
-		if (dssdev->type != OMAP_DISPLAY_TYPE_DPI)
-			continue;
-
-		if (def_dssdev == NULL)
-			def_dssdev = dssdev;
-
-		if (def_disp_name != NULL &&
-				strcmp(dssdev->name, def_disp_name) == 0) {
-			def_dssdev = dssdev;
-			break;
-		}
-	}
-
-	return def_dssdev;
-}
-
-static int dpi_probe_pdata(struct platform_device *dpidev)
-{
-	struct omap_dss_device *plat_dssdev;
-	struct omap_dss_device *dssdev;
-	int r;
-
-	plat_dssdev = dpi_find_dssdev(dpidev);
-
-	if (!plat_dssdev)
-		return 0;
-
-	r = dpi_init_regulator();
-	if (r)
-		return r;
-
-	dpi_init_pll();
-
-	dssdev = dss_alloc_and_init_device(&dpidev->dev);
-	if (!dssdev)
-		return -ENOMEM;
-
-	dss_copy_device_pdata(dssdev, plat_dssdev);
-
-	r = omapdss_output_set_device(&dpi.output, dssdev);
-	if (r) {
-		DSSERR("failed to connect output to new device: %s\n",
-				dssdev->name);
-		dss_put_device(dssdev);
-		return r;
-	}
-
-	r = dss_add_device(dssdev);
-	if (r) {
-		DSSERR("device %s register failed: %d\n", dssdev->name, r);
-		omapdss_output_unset_device(&dpi.output);
-		dss_put_device(dssdev);
-		return r;
-	}
-
-	return 0;
-}
-
 static int dpi_connect(struct omap_dss_device *dssdev,
 		struct omap_dss_device *dst)
 {
@@ -733,14 +658,14 @@ static const struct omapdss_dpi_ops dpi_ops = {
 	.connect = dpi_connect,
 	.disconnect = dpi_disconnect,
 
-	.enable = omapdss_dpi_display_enable,
-	.disable = omapdss_dpi_display_disable,
+	.enable = dpi_display_enable,
+	.disable = dpi_display_disable,
 
 	.check_timings = dpi_check_timings,
-	.set_timings = omapdss_dpi_set_timings,
+	.set_timings = dpi_set_timings,
 	.get_timings = dpi_get_timings,
 
-	.set_data_lines = omapdss_dpi_set_data_lines,
+	.set_data_lines = dpi_set_data_lines,
 };
 
 static void dpi_init_output(struct platform_device *pdev)
@@ -767,31 +692,17 @@ static void __exit dpi_uninit_output(struct platform_device *pdev)
 
 static int omap_dpi_probe(struct platform_device *pdev)
 {
-	int r;
-
 	dpi.pdev = pdev;
 
 	mutex_init(&dpi.lock);
 
 	dpi_init_output(pdev);
 
-	if (pdev->dev.platform_data) {
-		r = dpi_probe_pdata(pdev);
-		if (r)
-			goto err_probe;
-	}
-
 	return 0;
-
-err_probe:
-	dpi_uninit_output(pdev);
-	return r;
 }
 
 static int __exit omap_dpi_remove(struct platform_device *pdev)
 {
-	dss_unregister_child_devices(&pdev->dev);
-
 	dpi_uninit_output(pdev);
 
 	return 0;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 3b68dc2..1199e3b 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -1038,14 +1038,6 @@ int omapdss_dsi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
 		bool disconnect_lanes, bool enter_ulps);
 
-int omapdss_dpi_display_enable(struct omap_dss_device *dssdev);
-void omapdss_dpi_display_disable(struct omap_dss_device *dssdev);
-void omapdss_dpi_set_timings(struct omap_dss_device *dssdev,
-		struct omap_video_timings *timings);
-int dpi_check_timings(struct omap_dss_device *dssdev,
-			struct omap_video_timings *timings);
-void omapdss_dpi_set_data_lines(struct omap_dss_device *dssdev, int data_lines);
-
 int omapdss_sdi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_sdi_display_disable(struct omap_dss_device *dssdev);
 void omapdss_sdi_set_timings(struct omap_dss_device *dssdev,
-- 
1.8.1.2

