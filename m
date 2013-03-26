From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 18/26] OMAPDSS: panel-generic-dpi: convert to platform device
Date: Tue, 26 Mar 2013 15:33:48 +0200
Message-ID: <1364304836-18134-19-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55878 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934269Ab3CZNe4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 09:34:56 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Convert panel-generic-dpi driver from omap_dss_driver to a platform
driver. The driver uses the new panel support from omapdss.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |  141 ++++++++++++++--------
 1 file changed, 91 insertions(+), 50 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index c904f42..cc49c48 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -33,10 +33,14 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/platform_device.h>
 #include <video/omapdss.h>
 
 #include <video/omap-panel-generic-dpi.h>
 
+static struct omap_dss_driver generic_dpi_panel_driver;
+#define to_drv_data(x) container_of(x, struct panel_drv_data, dssdev)
+
 struct panel_config {
 	struct omap_video_timings timings;
 
@@ -517,12 +521,16 @@ static struct panel_config generic_dpi_panels[] = {
 };
 
 struct panel_drv_data {
+	struct omap_dss_device dssdev;
 
-	struct omap_dss_device *dssdev;
-
-	struct panel_config *panel_config;
+	const struct panel_config *panel_config;
 
 	struct mutex lock;
+
+	const struct panel_generic_dpi_data *pdata;
+
+	const char *name;
+	int data_lines;
 };
 
 static inline struct panel_generic_dpi_data
@@ -534,9 +542,9 @@ static inline struct panel_generic_dpi_data
 static int generic_dpi_panel_power_on(struct omap_dss_device *dssdev)
 {
 	int r;
-	struct panel_generic_dpi_data *panel_data = get_panel_data(dssdev);
-	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
-	struct panel_config *panel_config = drv_data->panel_config;
+	struct panel_drv_data *drv_data = to_drv_data(dssdev);
+	const struct panel_config *panel_config = drv_data->panel_config;
+	const struct panel_generic_dpi_data *pdata = drv_data->pdata;
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
@@ -552,8 +560,8 @@ static int generic_dpi_panel_power_on(struct omap_dss_device *dssdev)
 	if (panel_config->power_on_delay)
 		msleep(panel_config->power_on_delay);
 
-	if (panel_data->platform_enable) {
-		r = panel_data->platform_enable(dssdev);
+	if (pdata && pdata->platform_enable) {
+		r = pdata->platform_enable(dssdev);
 		if (r)
 			goto err1;
 	}
@@ -567,15 +575,15 @@ err0:
 
 static void generic_dpi_panel_power_off(struct omap_dss_device *dssdev)
 {
-	struct panel_generic_dpi_data *panel_data = get_panel_data(dssdev);
-	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
-	struct panel_config *panel_config = drv_data->panel_config;
+	struct panel_drv_data *drv_data = to_drv_data(dssdev);
+	const struct panel_config *panel_config = drv_data->panel_config;
+	const struct panel_generic_dpi_data *pdata = drv_data->pdata;
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return;
 
-	if (panel_data->platform_disable)
-		panel_data->platform_disable(dssdev);
+	if (pdata && pdata->platform_disable)
+		pdata->platform_disable(dssdev);
 
 	/* wait couple of vsyncs after disabling the LCD */
 	if (panel_config->power_off_delay)
@@ -584,20 +592,16 @@ static void generic_dpi_panel_power_off(struct omap_dss_device *dssdev)
 	omapdss_dpi_display_disable(dssdev);
 }
 
-static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
+static int generic_dpi_panel_probe_pdata(struct platform_device *pdev)
 {
-	struct panel_generic_dpi_data *panel_data = get_panel_data(dssdev);
+	const struct panel_generic_dpi_data *pdata =
+		dev_get_platdata(&pdev->dev);
+	struct panel_drv_data *drv_data = dev_get_drvdata(&pdev->dev);
 	struct panel_config *panel_config = NULL;
-	struct panel_drv_data *drv_data = NULL;
 	int i;
 
-	dev_dbg(&dssdev->dev, "probe\n");
-
-	if (!panel_data || !panel_data->name)
-		return -EINVAL;
-
 	for (i = 0; i < ARRAY_SIZE(generic_dpi_panels); i++) {
-		if (strcmp(panel_data->name, generic_dpi_panels[i].name) == 0) {
+		if (strcmp(pdata->name, generic_dpi_panels[i].name) == 0) {
 			panel_config = &generic_dpi_panels[i];
 			break;
 		}
@@ -606,36 +610,70 @@ static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
 	if (!panel_config)
 		return -EINVAL;
 
-	dssdev->panel.timings = panel_config->timings;
+	drv_data->panel_config = panel_config;
+	drv_data->pdata = pdata;
+	drv_data->name = pdata->display_name;
+	drv_data->data_lines = pdata->data_lines;
 
-	drv_data = kzalloc(sizeof(*drv_data), GFP_KERNEL);
+	return 0;
+}
+
+static int generic_dpi_panel_probe(struct platform_device *pdev)
+{
+	struct panel_drv_data *drv_data;
+	struct omap_dss_device *dssdev;
+	int r;
+
+	dev_dbg(&pdev->dev, "probe\n");
+
+	drv_data = devm_kzalloc(&pdev->dev, sizeof(*drv_data), GFP_KERNEL);
 	if (!drv_data)
 		return -ENOMEM;
 
-	drv_data->dssdev = dssdev;
-	drv_data->panel_config = panel_config;
+	dev_set_drvdata(&pdev->dev, drv_data);
+
+	if (dev_get_platdata(&pdev->dev)) {
+		r = generic_dpi_panel_probe_pdata(pdev);
+		if (r)
+			return r;
+	} else {
+		return -EINVAL;
+	}
 
 	mutex_init(&drv_data->lock);
 
-	dev_set_drvdata(&dssdev->dev, drv_data);
+	dssdev = &drv_data->dssdev;
+	dssdev->driver = &generic_dpi_panel_driver;
+	dssdev->name = drv_data->name;
+	dssdev->phy.dpi.data_lines = drv_data->data_lines;
+	dssdev->panel.timings = drv_data->panel_config->timings;
+	dssdev->panel_dev = &pdev->dev;
+
+	r = omap_dpi_register_panel(dssdev);
+	if (r) {
+		dev_err(&pdev->dev, "Failed to register panel\n");
+		return r;
+	}
 
 	return 0;
 }
 
-static void __exit generic_dpi_panel_remove(struct omap_dss_device *dssdev)
+static int __exit generic_dpi_panel_remove(struct platform_device *pdev)
 {
-	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
+	struct panel_drv_data *drv_data = dev_get_drvdata(&pdev->dev);
 
-	dev_dbg(&dssdev->dev, "remove\n");
+	dev_dbg(&pdev->dev, "remove\n");
 
-	kfree(drv_data);
+	omap_dpi_free_panel(&drv_data->dssdev);
 
-	dev_set_drvdata(&dssdev->dev, NULL);
+	dev_set_drvdata(&pdev->dev, NULL);
+
+	return 0;
 }
 
 static int generic_dpi_panel_enable(struct omap_dss_device *dssdev)
 {
-	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
+	struct panel_drv_data *drv_data = to_drv_data(dssdev);
 	int r;
 
 	mutex_lock(&drv_data->lock);
@@ -653,7 +691,7 @@ err:
 
 static void generic_dpi_panel_disable(struct omap_dss_device *dssdev)
 {
-	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
+	struct panel_drv_data *drv_data = to_drv_data(dssdev);
 
 	mutex_lock(&drv_data->lock);
 
@@ -667,7 +705,7 @@ static void generic_dpi_panel_disable(struct omap_dss_device *dssdev)
 static void generic_dpi_panel_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
-	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
+	struct panel_drv_data *drv_data = to_drv_data(dssdev);
 
 	mutex_lock(&drv_data->lock);
 
@@ -681,7 +719,7 @@ static void generic_dpi_panel_set_timings(struct omap_dss_device *dssdev,
 static void generic_dpi_panel_get_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
-	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
+	struct panel_drv_data *drv_data = to_drv_data(dssdev);
 
 	mutex_lock(&drv_data->lock);
 
@@ -693,7 +731,7 @@ static void generic_dpi_panel_get_timings(struct omap_dss_device *dssdev,
 static int generic_dpi_panel_check_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
-	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
+	struct panel_drv_data *drv_data = to_drv_data(dssdev);
 	int r;
 
 	mutex_lock(&drv_data->lock);
@@ -705,10 +743,7 @@ static int generic_dpi_panel_check_timings(struct omap_dss_device *dssdev,
 	return r;
 }
 
-static struct omap_dss_driver dpi_driver = {
-	.probe		= generic_dpi_panel_probe,
-	.remove		= __exit_p(generic_dpi_panel_remove),
-
+static struct omap_dss_driver generic_dpi_panel_driver = {
 	.enable		= generic_dpi_panel_enable,
 	.disable	= generic_dpi_panel_disable,
 
@@ -716,22 +751,28 @@ static struct omap_dss_driver dpi_driver = {
 	.get_timings	= generic_dpi_panel_get_timings,
 	.check_timings	= generic_dpi_panel_check_timings,
 
-	.driver         = {
-		.name   = "generic_dpi_panel",
-		.owner  = THIS_MODULE,
+	.get_resolution	= omapdss_default_get_resolution,
+};
+
+static struct platform_driver generic_dpi_panel_platform_driver = {
+	.probe	= generic_dpi_panel_probe,
+	.remove	= __exit_p(generic_dpi_panel_remove),
+	.driver	= {
+		.name	= "generic_dpi_panel",
+		.owner	= THIS_MODULE,
 	},
 };
 
-static int __init generic_dpi_panel_drv_init(void)
+static int __init generic_dpi_panel_init(void)
 {
-	return omap_dss_register_driver(&dpi_driver);
+	return platform_driver_register(&generic_dpi_panel_platform_driver);
 }
 
-static void __exit generic_dpi_panel_drv_exit(void)
+static void __exit generic_dpi_panel_exit(void)
 {
-	omap_dss_unregister_driver(&dpi_driver);
+	platform_driver_unregister(&generic_dpi_panel_platform_driver);
 }
 
-module_init(generic_dpi_panel_drv_init);
-module_exit(generic_dpi_panel_drv_exit);
+module_init(generic_dpi_panel_init);
+module_exit(generic_dpi_panel_exit);
 MODULE_LICENSE("GPL");
-- 
1.7.10.4

