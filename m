From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/21] OMAPDSS: panel-dvi: add PD gpio handling
Date: Wed,  7 Mar 2012 14:44:30 +0200
Message-ID: <1331124290-6285-2-git-send-email-tomi.valkeinen@ti.com>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:33379 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752336Ab2CGMpL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 07:45:11 -0500
Received: by mail-lpp01m010-f54.google.com with SMTP id v3so10221923lag.13
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 04:45:09 -0800 (PST)
In-Reply-To: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The driver for the DVI framer should handle the power-down signal of the
framer, instead of the current way of handling it in the board files.

This patch adds power_down_gpio into the device's platform data, and
adds the necessary code in the driver to request and handle the GPIO.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-dvi.c |   31 ++++++++++++++++++++++++++++++
 include/video/omap-panel-dvi.h           |    2 +
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-dvi.c b/drivers/video/omap2/displays/panel-dvi.c
index 03eb14a..876b798 100644
--- a/drivers/video/omap2/displays/panel-dvi.c
+++ b/drivers/video/omap2/displays/panel-dvi.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <video/omapdss.h>
 #include <linux/i2c.h>
+#include <linux/gpio.h>
 #include <drm/drm_edid.h>
 
 #include <video/omap-panel-dvi.h>
@@ -44,6 +45,8 @@ struct panel_drv_data {
 	struct omap_dss_device *dssdev;
 
 	struct mutex lock;
+
+	int pd_gpio;
 };
 
 static inline struct panel_dvi_platform_data
@@ -54,6 +57,7 @@ static inline struct panel_dvi_platform_data
 
 static int panel_dvi_power_on(struct omap_dss_device *dssdev)
 {
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
 	struct panel_dvi_platform_data *pdata = get_pdata(dssdev);
 	int r;
 
@@ -70,6 +74,9 @@ static int panel_dvi_power_on(struct omap_dss_device *dssdev)
 			goto err1;
 	}
 
+	if (gpio_is_valid(ddata->pd_gpio))
+		gpio_set_value(ddata->pd_gpio, 1);
+
 	return 0;
 err1:
 	omapdss_dpi_display_disable(dssdev);
@@ -79,11 +86,15 @@ err0:
 
 static void panel_dvi_power_off(struct omap_dss_device *dssdev)
 {
+	struct panel_drv_data *ddata = dev_get_drvdata(&dssdev->dev);
 	struct panel_dvi_platform_data *pdata = get_pdata(dssdev);
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return;
 
+	if (gpio_is_valid(ddata->pd_gpio))
+		gpio_set_value(ddata->pd_gpio, 0);
+
 	if (pdata->platform_disable)
 		pdata->platform_disable(dssdev);
 
@@ -92,7 +103,9 @@ static void panel_dvi_power_off(struct omap_dss_device *dssdev)
 
 static int panel_dvi_probe(struct omap_dss_device *dssdev)
 {
+	struct panel_dvi_platform_data *pdata = get_pdata(dssdev);
 	struct panel_drv_data *ddata;
+	int r;
 
 	ddata = kzalloc(sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
@@ -104,6 +117,21 @@ static int panel_dvi_probe(struct omap_dss_device *dssdev)
 	ddata->dssdev = dssdev;
 	mutex_init(&ddata->lock);
 
+	if (pdata)
+		ddata->pd_gpio = pdata->power_down_gpio;
+	else
+		ddata->pd_gpio = -1;
+
+	if (gpio_is_valid(ddata->pd_gpio)) {
+		r = gpio_request_one(ddata->pd_gpio, GPIOF_OUT_INIT_LOW,
+				"tfp410 pd");
+		if (r) {
+			dev_err(&dssdev->dev, "Failed to request PD GPIO %d\n",
+					ddata->pd_gpio);
+			ddata->pd_gpio = -1;
+		}
+	}
+
 	dev_set_drvdata(&dssdev->dev, ddata);
 
 	return 0;
@@ -115,6 +143,9 @@ static void __exit panel_dvi_remove(struct omap_dss_device *dssdev)
 
 	mutex_lock(&ddata->lock);
 
+	if (gpio_is_valid(ddata->pd_gpio))
+		gpio_free(ddata->pd_gpio);
+
 	dev_set_drvdata(&dssdev->dev, NULL);
 
 	mutex_unlock(&ddata->lock);
diff --git a/include/video/omap-panel-dvi.h b/include/video/omap-panel-dvi.h
index 87ad567b..4ad41fc 100644
--- a/include/video/omap-panel-dvi.h
+++ b/include/video/omap-panel-dvi.h
@@ -27,11 +27,13 @@ struct omap_dss_device;
  * @platform_enable: platform specific panel enable function
  * @platform_disable: platform specific panel disable function
  * @i2c_bus_num: i2c bus id for the panel
+ * @power_down_gpio: gpio number for PD pin (or -1 if not available)
  */
 struct panel_dvi_platform_data {
 	int (*platform_enable)(struct omap_dss_device *dssdev);
 	void (*platform_disable)(struct omap_dss_device *dssdev);
 	u16 i2c_bus_num;
+	int power_down_gpio;
 };
 
 #endif /* __OMAP_PANEL_DVI_H */
-- 
1.7.4.1

