From: Archit Taneja <archit@ti.com>
Subject: [PATCH 04/11] OMAPDSS: n8x0: remove platform backlight calls
Date: Wed, 13 Feb 2013 19:37:07 +0530
Message-ID: <1360764434-18788-5-git-send-email-archit@ti.com>
References: <1360764434-18788-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55796 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933917Ab3BMOIH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 09:08:07 -0500
In-Reply-To: <1360764434-18788-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

The n8x0 panel contains support to call platform backlight functions.
These are not used by any board, and can be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-n8x0.c |   74 -----------------------------
 include/video/omap-panel-n8x0.h           |    2 -
 2 files changed, 76 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-n8x0.c b/drivers/video/omap2/displays/panel-n8x0.c
index dd12947..b750480 100644
--- a/drivers/video/omap2/displays/panel-n8x0.c
+++ b/drivers/video/omap2/displays/panel-n8x0.c
@@ -5,7 +5,6 @@
 #include <linux/slab.h>
 #include <linux/gpio.h>
 #include <linux/spi/spi.h>
-#include <linux/backlight.h>
 #include <linux/fb.h>
 
 #include <video/omapdss.h>
@@ -69,7 +68,6 @@ static struct panel_drv_data {
 
 	struct omap_dss_device *dssdev;
 	struct spi_device *spidev;
-	struct backlight_device *bldev;
 
 	int blizzard_ver;
 } s_drv_data;
@@ -424,55 +422,10 @@ static const struct rfbi_timings n8x0_panel_timings = {
 	.cs_pulse_width = 0,
 };
 
-static int n8x0_bl_update_status(struct backlight_device *dev)
-{
-	struct omap_dss_device *dssdev = dev_get_drvdata(&dev->dev);
-	struct panel_n8x0_data *bdata = get_board_data(dssdev);
-	struct panel_drv_data *ddata = get_drv_data(dssdev);
-	int r;
-	int level;
-
-	mutex_lock(&ddata->lock);
-
-	if (dev->props.fb_blank == FB_BLANK_UNBLANK &&
-			dev->props.power == FB_BLANK_UNBLANK)
-		level = dev->props.brightness;
-	else
-		level = 0;
-
-	dev_dbg(&dssdev->dev, "update brightness to %d\n", level);
-
-	if (!bdata->set_backlight)
-		r = -EINVAL;
-	else
-		r = bdata->set_backlight(dssdev, level);
-
-	mutex_unlock(&ddata->lock);
-
-	return r;
-}
-
-static int n8x0_bl_get_intensity(struct backlight_device *dev)
-{
-	if (dev->props.fb_blank == FB_BLANK_UNBLANK &&
-			dev->props.power == FB_BLANK_UNBLANK)
-		return dev->props.brightness;
-
-	return 0;
-}
-
-static const struct backlight_ops n8x0_bl_ops = {
-	.get_brightness = n8x0_bl_get_intensity,
-	.update_status  = n8x0_bl_update_status,
-};
-
 static int n8x0_panel_probe(struct omap_dss_device *dssdev)
 {
 	struct panel_n8x0_data *bdata = get_board_data(dssdev);
 	struct panel_drv_data *ddata;
-	struct backlight_device *bldev;
-	struct backlight_properties props;
-	int r;
 
 	dev_dbg(&dssdev->dev, "probe\n");
 
@@ -491,40 +444,13 @@ static int n8x0_panel_probe(struct omap_dss_device *dssdev)
 	dssdev->ctrl.rfbi_timings = n8x0_panel_timings;
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
 
-	memset(&props, 0, sizeof(props));
-	props.max_brightness = 127;
-	props.type = BACKLIGHT_PLATFORM;
-	bldev = backlight_device_register(dev_name(&dssdev->dev), &dssdev->dev,
-			dssdev, &n8x0_bl_ops, &props);
-	if (IS_ERR(bldev)) {
-		r = PTR_ERR(bldev);
-		dev_err(&dssdev->dev, "register backlight failed\n");
-		return r;
-	}
-
-	ddata->bldev = bldev;
-
-	bldev->props.fb_blank = FB_BLANK_UNBLANK;
-	bldev->props.power = FB_BLANK_UNBLANK;
-	bldev->props.brightness = 127;
-
-	n8x0_bl_update_status(bldev);
-
 	return 0;
 }
 
 static void n8x0_panel_remove(struct omap_dss_device *dssdev)
 {
-	struct panel_drv_data *ddata = get_drv_data(dssdev);
-	struct backlight_device *bldev;
-
 	dev_dbg(&dssdev->dev, "remove\n");
 
-	bldev = ddata->bldev;
-	bldev->props.power = FB_BLANK_POWERDOWN;
-	n8x0_bl_update_status(bldev);
-	backlight_device_unregister(bldev);
-
 	dev_set_drvdata(&dssdev->dev, NULL);
 }
 
diff --git a/include/video/omap-panel-n8x0.h b/include/video/omap-panel-n8x0.h
index 50a1302..9cc69c8 100644
--- a/include/video/omap-panel-n8x0.h
+++ b/include/video/omap-panel-n8x0.h
@@ -8,8 +8,6 @@ struct panel_n8x0_data {
 	void (*platform_disable)(struct omap_dss_device *dssdev);
 	int panel_reset;
 	int ctrl_pwrdown;
-
-	int (*set_backlight)(struct omap_dss_device *dssdev, int level);
 };
 
 #endif
-- 
1.7.9.5

