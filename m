From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/3] OMAP: DSS2: Taal: remove external backlight support
Date: Thu, 15 Sep 2011 10:17:33 +0300
Message-ID: <1316071055-21494-2-git-send-email-tomi.valkeinen@ti.com>
References: <1316071055-21494-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:59203 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754316Ab1IOHRu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Sep 2011 03:17:50 -0400
Received: by bkbzu17 with SMTP id zu17so2159744bkb.38
        for <linux-omap@vger.kernel.org>; Thu, 15 Sep 2011 00:17:48 -0700 (PDT)
In-Reply-To: <1316071055-21494-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Taal panel driver supports two kinds of backlight control: 1) using DSI
commands sent to the panel to control the backlight, 2) calling function
pointers going to the board file to control the backlight.

The second option is a bit hacky, and will no longer be needed when the
PWM driver supports the backlight features. After that we can use the
standard PWM backlight driver.

This patch removes the second backlight control mechanism, and adds a
boolean field, use_dsi_backlight, to nokia_dsi_panel_data which the
board file can use to inform whether the panel driver should use DSI
commands to control the backlight.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |   76 +++++++++++-----------------
 include/video/omap-panel-nokia-dsi.h      |    8 +--
 2 files changed, 32 insertions(+), 52 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index ddc696d..7f91002 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -208,8 +208,6 @@ struct taal_data {
 
 	struct delayed_work te_timeout_work;
 
-	bool use_dsi_bl;
-
 	bool cabc_broken;
 	unsigned cabc_mode;
 
@@ -541,7 +539,6 @@ static int taal_bl_update_status(struct backlight_device *dev)
 {
 	struct omap_dss_device *dssdev = dev_get_drvdata(&dev->dev);
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
-	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	int r;
 	int level;
 
@@ -555,23 +552,16 @@ static int taal_bl_update_status(struct backlight_device *dev)
 
 	mutex_lock(&td->lock);
 
-	if (td->use_dsi_bl) {
-		if (td->enabled) {
-			dsi_bus_lock(dssdev);
+	if (td->enabled) {
+		dsi_bus_lock(dssdev);
 
-			r = taal_wake_up(dssdev);
-			if (!r)
-				r = taal_dcs_write_1(td, DCS_BRIGHTNESS, level);
+		r = taal_wake_up(dssdev);
+		if (!r)
+			r = taal_dcs_write_1(td, DCS_BRIGHTNESS, level);
 
-			dsi_bus_unlock(dssdev);
-		} else {
-			r = 0;
-		}
+		dsi_bus_unlock(dssdev);
 	} else {
-		if (!panel_data->set_backlight)
-			r = -EINVAL;
-		else
-			r = panel_data->set_backlight(dssdev, level);
+		r = 0;
 	}
 
 	mutex_unlock(&td->lock);
@@ -950,7 +940,7 @@ static int taal_probe(struct omap_dss_device *dssdev)
 {
 	struct backlight_properties props;
 	struct taal_data *td;
-	struct backlight_device *bldev;
+	struct backlight_device *bldev = NULL;
 	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	struct panel_config *panel_config = NULL;
 	int r, i;
@@ -1011,35 +1001,26 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
 	taal_hw_reset(dssdev);
 
-	/* if no platform set_backlight() defined, presume DSI backlight
-	 * control */
-	memset(&props, 0, sizeof(struct backlight_properties));
-	if (!panel_data->set_backlight)
-		td->use_dsi_bl = true;
-
-	if (td->use_dsi_bl)
+	if (panel_data->use_dsi_backlight) {
+		memset(&props, 0, sizeof(struct backlight_properties));
 		props.max_brightness = 255;
-	else
-		props.max_brightness = 127;
-
-	props.type = BACKLIGHT_RAW;
-	bldev = backlight_device_register(dev_name(&dssdev->dev), &dssdev->dev,
-					dssdev, &taal_bl_ops, &props);
-	if (IS_ERR(bldev)) {
-		r = PTR_ERR(bldev);
-		goto err_bl;
-	}
 
-	td->bldev = bldev;
+		props.type = BACKLIGHT_RAW;
+		bldev = backlight_device_register(dev_name(&dssdev->dev),
+				&dssdev->dev, dssdev, &taal_bl_ops, &props);
+		if (IS_ERR(bldev)) {
+			r = PTR_ERR(bldev);
+			goto err_bl;
+		}
+
+		td->bldev = bldev;
 
-	bldev->props.fb_blank = FB_BLANK_UNBLANK;
-	bldev->props.power = FB_BLANK_UNBLANK;
-	if (td->use_dsi_bl)
+		bldev->props.fb_blank = FB_BLANK_UNBLANK;
+		bldev->props.power = FB_BLANK_UNBLANK;
 		bldev->props.brightness = 255;
-	else
-		bldev->props.brightness = 127;
 
-	taal_bl_update_status(bldev);
+		taal_bl_update_status(bldev);
+	}
 
 	if (panel_data->use_ext_te) {
 		int gpio = panel_data->ext_te_gpio;
@@ -1097,7 +1078,8 @@ err_irq:
 	if (panel_data->use_ext_te)
 		gpio_free(panel_data->ext_te_gpio);
 err_gpio:
-	backlight_device_unregister(bldev);
+	if (bldev != NULL)
+		backlight_device_unregister(bldev);
 err_bl:
 	destroy_workqueue(td->workqueue);
 err_wq:
@@ -1126,9 +1108,11 @@ static void __exit taal_remove(struct omap_dss_device *dssdev)
 	}
 
 	bldev = td->bldev;
-	bldev->props.power = FB_BLANK_POWERDOWN;
-	taal_bl_update_status(bldev);
-	backlight_device_unregister(bldev);
+	if (bldev != NULL) {
+		bldev->props.power = FB_BLANK_POWERDOWN;
+		taal_bl_update_status(bldev);
+		backlight_device_unregister(bldev);
+	}
 
 	taal_cancel_ulps_work(dssdev);
 	taal_cancel_esd_work(dssdev);
diff --git a/include/video/omap-panel-nokia-dsi.h b/include/video/omap-panel-nokia-dsi.h
index 921ae93..7dc71f9 100644
--- a/include/video/omap-panel-nokia-dsi.h
+++ b/include/video/omap-panel-nokia-dsi.h
@@ -10,9 +10,7 @@ struct omap_dss_device;
  * @ext_te_gpio: external TE GPIO
  * @esd_interval: interval of ESD checks, 0 = disabled (ms)
  * @ulps_timeout: time to wait before entering ULPS, 0 = disabled (ms)
- * @max_backlight_level: maximum backlight level
- * @set_backlight: pointer to backlight set function
- * @get_backlight: pointer to backlight get function
+ * @use_dsi_backlight: true if panel uses DSI command to control backlight
  */
 struct nokia_dsi_panel_data {
 	const char *name;
@@ -25,9 +23,7 @@ struct nokia_dsi_panel_data {
 	unsigned esd_interval;
 	unsigned ulps_timeout;
 
-	int max_backlight_level;
-	int (*set_backlight)(struct omap_dss_device *dssdev, int level);
-	int (*get_backlight)(struct omap_dss_device *dssdev);
+	bool use_dsi_backlight;
 };
 
 #endif /* __OMAP_NOKIA_DSI_PANEL_H */
-- 
1.7.4.1

