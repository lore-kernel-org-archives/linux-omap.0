From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 5/5] OMAPDSS: Displays: Add locking in generic DPI panel driver
Date: Thu, 9 Aug 2012 14:37:10 +0530
Message-ID: <1344503230-18550-6-git-send-email-archit@ti.com>
References: <1344503230-18550-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51787 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755770Ab2HIJJH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Aug 2012 05:09:07 -0400
In-Reply-To: <1344503230-18550-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The generic DPI panel driver doesn't currently have locking to ensure that
the display states and the driver data is maintained correctly. Add mutex
locking to take care of this. Add a new get_timings driver op to override the
default get_timings op. The new driver op contains locking to ensure the correct
panel timings are seen when a DSS2 user calls device->driver->get_timings.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |   69 +++++++++++++++++++---
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index bc5af25..69e78a5 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -545,6 +545,8 @@ struct panel_drv_data {
 	struct omap_dss_device *dssdev;
 
 	struct panel_config *panel_config;
+
+	struct mutex lock;
 };
 
 static inline struct panel_generic_dpi_data
@@ -634,6 +636,8 @@ static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
 	drv_data->dssdev = dssdev;
 	drv_data->panel_config = panel_config;
 
+	mutex_init(&drv_data->lock);
+
 	dev_set_drvdata(&dssdev->dev, drv_data);
 
 	return 0;
@@ -652,56 +656,106 @@ static void __exit generic_dpi_panel_remove(struct omap_dss_device *dssdev)
 
 static int generic_dpi_panel_enable(struct omap_dss_device *dssdev)
 {
-	int r = 0;
+	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
+	int r;
+
+	mutex_lock(&drv_data->lock);
 
 	r = generic_dpi_panel_power_on(dssdev);
 	if (r)
-		return r;
+		goto err;
 
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+err:
+	mutex_unlock(&drv_data->lock);
 
-	return 0;
+	return r;
 }
 
 static void generic_dpi_panel_disable(struct omap_dss_device *dssdev)
 {
+	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
+
+	mutex_lock(&drv_data->lock);
+
 	generic_dpi_panel_power_off(dssdev);
 
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+
+	mutex_unlock(&drv_data->lock);
 }
 
 static int generic_dpi_panel_suspend(struct omap_dss_device *dssdev)
 {
+	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
+
+	mutex_lock(&drv_data->lock);
+
 	generic_dpi_panel_power_off(dssdev);
 
 	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
 
+	mutex_unlock(&drv_data->lock);
+
 	return 0;
 }
 
 static int generic_dpi_panel_resume(struct omap_dss_device *dssdev)
 {
-	int r = 0;
+	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
+	int r;
+
+	mutex_lock(&drv_data->lock);
 
 	r = generic_dpi_panel_power_on(dssdev);
 	if (r)
-		return r;
+		goto err;
 
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
-	return 0;
+err:
+	mutex_unlock(&drv_data->lock);
+
+	return r;
 }
 
 static void generic_dpi_panel_set_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
+	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
+
+	mutex_lock(&drv_data->lock);
+
 	dpi_set_timings(dssdev, timings);
+
+	mutex_unlock(&drv_data->lock);
+}
+
+static void generic_dpi_panel_get_timings(struct omap_dss_device *dssdev,
+		struct omap_video_timings *timings)
+{
+	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
+
+	mutex_lock(&drv_data->lock);
+
+	*timings = dssdev->panel.timings;
+
+	mutex_unlock(&drv_data->lock);
 }
 
 static int generic_dpi_panel_check_timings(struct omap_dss_device *dssdev,
 		struct omap_video_timings *timings)
 {
-	return dpi_check_timings(dssdev, timings);
+	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
+	int r;
+
+	mutex_lock(&drv_data->lock);
+
+	r = dpi_check_timings(dssdev, timings);
+
+	mutex_unlock(&drv_data->lock);
+
+	return r;
 }
 
 static struct omap_dss_driver dpi_driver = {
@@ -714,6 +768,7 @@ static struct omap_dss_driver dpi_driver = {
 	.resume		= generic_dpi_panel_resume,
 
 	.set_timings	= generic_dpi_panel_set_timings,
+	.get_timings	= generic_dpi_panel_get_timings,
 	.check_timings	= generic_dpi_panel_check_timings,
 
 	.driver         = {
-- 
1.7.9.5

