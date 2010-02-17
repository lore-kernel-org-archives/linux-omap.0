From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 1/4] OMAP: DSS2: remove sub-panel system
Date: Wed, 17 Feb 2010 13:57:16 +0200
Message-ID: <1266407839-14713-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:65100 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873Ab0BQLy1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 06:54:27 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

The system to allow panel drivers to exists as attached to ctrl drivers
did never work very well. It is not useed, and this patch removes it to
make the driver cleaner.

For now, controller drivers need to include also the panel driver code. In
the future a proper mechanism for this should be developed, perhaps by
creating busses for controllers.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/include/plat/display.h |    3 --
 drivers/video/omap2/dss/core.c            |   35 ++--------------------------
 drivers/video/omap2/dss/display.c         |   32 +------------------------
 3 files changed, 5 insertions(+), 65 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index 8c3688b..0022f6c 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -431,14 +431,11 @@ struct omap_dss_device {
 		enum omap_panel_config config;
 
 		u8 recommended_bpp;
-
-		struct omap_dss_device *ctrl;
 	} panel;
 
 	struct {
 		u8 pixel_size;
 		struct rfbi_timings rfbi_timings;
-		struct omap_dss_device *panel;
 	} ctrl;
 
 	int reset_gpio;
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 72547df..967cbda 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -771,11 +771,8 @@ static int dss_driver_probe(struct device *dev)
 
 	dss_init_device(core.pdev, dssdev);
 
-	/* skip this if the device is behind a ctrl */
-	if (!dssdev->panel.ctrl) {
-		force = pdata->default_device == dssdev;
-		dss_recheck_connections(dssdev, force);
-	}
+	force = pdata->default_device == dssdev;
+	dss_recheck_connections(dssdev, force);
 
 	r = dssdrv->probe(dssdev);
 
@@ -861,8 +858,6 @@ static void omap_dss_dev_release(struct device *dev)
 int omap_dss_register_device(struct omap_dss_device *dssdev)
 {
 	static int dev_num;
-	static int panel_num;
-	int r;
 
 	WARN_ON(!dssdev->driver_name);
 
@@ -871,36 +866,12 @@ int omap_dss_register_device(struct omap_dss_device *dssdev)
 	dssdev->dev.parent = &dss_bus;
 	dssdev->dev.release = omap_dss_dev_release;
 	dev_set_name(&dssdev->dev, "display%d", dev_num++);
-	r = device_register(&dssdev->dev);
-	if (r)
-		return r;
-
-	if (dssdev->ctrl.panel) {
-		struct omap_dss_device *panel = dssdev->ctrl.panel;
-
-		panel->panel.ctrl = dssdev;
-
-		reset_device(&panel->dev, 1);
-		panel->dev.bus = &dss_bus_type;
-		panel->dev.parent = &dssdev->dev;
-		panel->dev.release = omap_dss_dev_release;
-		dev_set_name(&panel->dev, "panel%d", panel_num++);
-		r = device_register(&panel->dev);
-		if (r)
-			return r;
-	}
-
-	return 0;
+	return device_register(&dssdev->dev);
 }
 
 void omap_dss_unregister_device(struct omap_dss_device *dssdev)
 {
 	device_unregister(&dssdev->dev);
-
-	if (dssdev->ctrl.panel) {
-		struct omap_dss_device *panel = dssdev->ctrl.panel;
-		device_unregister(&panel->dev);
-	}
 }
 
 /* BUS */
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 3b92b84..3f345b8 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -591,10 +591,6 @@ struct omap_dss_device *omap_dss_get_next_device(struct omap_dss_device *from)
 
 	int match(struct device *dev, void *data)
 	{
-		/* skip panels connected to controllers */
-		if (to_dss_device(dev)->panel.ctrl)
-			return 0;
-
 		return 1;
 	}
 
@@ -626,45 +622,21 @@ EXPORT_SYMBOL(omap_dss_find_device);
 
 int omap_dss_start_device(struct omap_dss_device *dssdev)
 {
-	int r;
-
 	if (!dssdev->driver) {
 		DSSDBG("no driver\n");
-		r = -ENODEV;
-		goto err0;
-	}
-
-	if (dssdev->ctrl.panel && !dssdev->ctrl.panel->driver) {
-		DSSDBG("no panel driver\n");
-		r = -ENODEV;
-		goto err0;
+		return -ENODEV;
 	}
 
 	if (!try_module_get(dssdev->dev.driver->owner)) {
-		r = -ENODEV;
-		goto err0;
-	}
-
-	if (dssdev->ctrl.panel) {
-		if (!try_module_get(dssdev->ctrl.panel->dev.driver->owner)) {
-			r = -ENODEV;
-			goto err1;
-		}
+		return -ENODEV;
 	}
 
 	return 0;
-err1:
-	module_put(dssdev->dev.driver->owner);
-err0:
-	return r;
 }
 EXPORT_SYMBOL(omap_dss_start_device);
 
 void omap_dss_stop_device(struct omap_dss_device *dssdev)
 {
-	if (dssdev->ctrl.panel)
-		module_put(dssdev->ctrl.panel->dev.driver->owner);
-
 	module_put(dssdev->dev.driver->owner);
 }
 EXPORT_SYMBOL(omap_dss_stop_device);
-- 
1.6.5

