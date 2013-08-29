From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/15] OMAPDSS: SDI: remove code related to old panel model
Date: Thu, 29 Aug 2013 16:31:55 +0300
Message-ID: <1377783120-14001-11-git-send-email-tomi.valkeinen@ti.com>
References: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48899 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754636Ab3H2NcX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Aug 2013 09:32:23 -0400
In-Reply-To: <1377783120-14001-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that the old panel drivers have been removed, we can remove the
old-model API and related code from the DSS encoder drivers.

This patch removes the code from the SDI driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/sdi.c | 105 ++++--------------------------------------
 include/video/omapdss.h       |   6 ---
 2 files changed, 8 insertions(+), 103 deletions(-)

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 82b64e3..b327688 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -124,7 +124,7 @@ static void sdi_config_lcd_manager(struct omap_dss_device *dssdev)
 	dss_mgr_set_lcd_config(mgr, &sdi.mgr_config);
 }
 
-int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
+static int sdi_display_enable(struct omap_dss_device *dssdev)
 {
 	struct omap_dss_device *out = &sdi.output;
 	struct omap_video_timings *t = &sdi.timings;
@@ -211,9 +211,8 @@ err_get_dispc:
 err_reg_enable:
 	return r;
 }
-EXPORT_SYMBOL(omapdss_sdi_display_enable);
 
-void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
+static void sdi_display_disable(struct omap_dss_device *dssdev)
 {
 	struct omap_overlay_manager *mgr = sdi.output.manager;
 
@@ -225,14 +224,12 @@ void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
 
 	regulator_disable(sdi.vdds_sdi_reg);
 }
-EXPORT_SYMBOL(omapdss_sdi_display_disable);
 
-void omapdss_sdi_set_timings(struct omap_dss_device *dssdev,
+static void sdi_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
 	sdi.timings = *timings;
 }
-EXPORT_SYMBOL(omapdss_sdi_set_timings);
 
 static void sdi_get_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
@@ -254,11 +251,10 @@ static int sdi_check_timings(struct omap_dss_device *dssdev,
 	return 0;
 }
 
-void omapdss_sdi_set_datapairs(struct omap_dss_device *dssdev, int datapairs)
+static void sdi_set_datapairs(struct omap_dss_device *dssdev, int datapairs)
 {
 	sdi.datapairs = datapairs;
 }
-EXPORT_SYMBOL(omapdss_sdi_set_datapairs);
 
 static int sdi_init_regulator(void)
 {
@@ -278,77 +274,6 @@ static int sdi_init_regulator(void)
 	return 0;
 }
 
-static struct omap_dss_device *sdi_find_dssdev(struct platform_device *pdev)
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
-		if (dssdev->type != OMAP_DISPLAY_TYPE_SDI)
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
-static int sdi_probe_pdata(struct platform_device *sdidev)
-{
-	struct omap_dss_device *plat_dssdev;
-	struct omap_dss_device *dssdev;
-	int r;
-
-	plat_dssdev = sdi_find_dssdev(sdidev);
-
-	if (!plat_dssdev)
-		return 0;
-
-	dssdev = dss_alloc_and_init_device(&sdidev->dev);
-	if (!dssdev)
-		return -ENOMEM;
-
-	dss_copy_device_pdata(dssdev, plat_dssdev);
-
-	r = sdi_init_regulator();
-	if (r) {
-		DSSERR("device %s init failed: %d\n", dssdev->name, r);
-		dss_put_device(dssdev);
-		return r;
-	}
-
-	r = omapdss_output_set_device(&sdi.output, dssdev);
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
-		omapdss_output_unset_device(&sdi.output);
-		dss_put_device(dssdev);
-		return r;
-	}
-
-	return 0;
-}
-
 static int sdi_connect(struct omap_dss_device *dssdev,
 		struct omap_dss_device *dst)
 {
@@ -396,14 +321,14 @@ static const struct omapdss_sdi_ops sdi_ops = {
 	.connect = sdi_connect,
 	.disconnect = sdi_disconnect,
 
-	.enable = omapdss_sdi_display_enable,
-	.disable = omapdss_sdi_display_disable,
+	.enable = sdi_display_enable,
+	.disable = sdi_display_disable,
 
 	.check_timings = sdi_check_timings,
-	.set_timings = omapdss_sdi_set_timings,
+	.set_timings = sdi_set_timings,
 	.get_timings = sdi_get_timings,
 
-	.set_datapairs = omapdss_sdi_set_datapairs,
+	.set_datapairs = sdi_set_datapairs,
 };
 
 static void sdi_init_output(struct platform_device *pdev)
@@ -430,29 +355,15 @@ static void __exit sdi_uninit_output(struct platform_device *pdev)
 
 static int omap_sdi_probe(struct platform_device *pdev)
 {
-	int r;
-
 	sdi.pdev = pdev;
 
 	sdi_init_output(pdev);
 
-	if (pdev->dev.platform_data) {
-		r = sdi_probe_pdata(pdev);
-		if (r)
-			goto err_probe;
-	}
-
 	return 0;
-
-err_probe:
-	sdi_uninit_output(pdev);
-	return r;
 }
 
 static int __exit omap_sdi_remove(struct platform_device *pdev)
 {
-	dss_unregister_child_devices(&pdev->dev);
-
 	sdi_uninit_output(pdev);
 
 	return 0;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 6d7297f..3395804 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -987,12 +987,6 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 #define to_dss_driver(x) container_of((x), struct omap_dss_driver, driver)
 #define to_dss_device(x) container_of((x), struct omap_dss_device, old_dev)
 
-int omapdss_sdi_display_enable(struct omap_dss_device *dssdev);
-void omapdss_sdi_display_disable(struct omap_dss_device *dssdev);
-void omapdss_sdi_set_timings(struct omap_dss_device *dssdev,
-		struct omap_video_timings *timings);
-void omapdss_sdi_set_datapairs(struct omap_dss_device *dssdev, int datapairs);
-
 int omapdss_rfbi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_rfbi_display_disable(struct omap_dss_device *dssdev);
 int omap_rfbi_update(struct omap_dss_device *dssdev, void (*callback)(void *),
-- 
1.8.1.2

