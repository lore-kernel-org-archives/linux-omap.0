From: Archit Taneja <archit@ti.com>
Subject: [PATCH 16/33] OMAPDSS: acx565akm panel: handle gpios in panel driver
Date: Wed, 13 Feb 2013 19:52:08 +0530
Message-ID: <1360765345-19312-17-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60100 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757028Ab3BMOYD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:24:03 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The acx565akm panel driver leaves gpio configurations to the platform_enable
and disable calls in the platform's board file. These should happen in the panel
driver itself.

Create a platform data struct for the panel, this contains the reset gpio number
used by the panel driver, this struct will be passed to the panel driver as
platform data. The driver will request and configure the reset gpio rather than
leaving it to platform callbacks in board files.

This will help in removing the need for the panel drivers to have platform
related callbacks.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-acx565akm.c |   48 ++++++++++++++++--------
 include/video/omap-panel-data.h                |    8 ++++
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-acx565akm.c b/drivers/video/omap2/displays/panel-acx565akm.c
index a8fb26b..d7f69c0 100644
--- a/drivers/video/omap2/displays/panel-acx565akm.c
+++ b/drivers/video/omap2/displays/panel-acx565akm.c
@@ -29,8 +29,10 @@
 #include <linux/sched.h>
 #include <linux/backlight.h>
 #include <linux/fb.h>
+#include <linux/gpio.h>
 
 #include <video/omapdss.h>
+#include <video/omap-panel-data.h>
 
 #define MIPID_CMD_READ_DISP_ID		0x04
 #define MIPID_CMD_READ_RED		0x06
@@ -494,21 +496,38 @@ static struct omap_video_timings acx_panel_timings = {
 	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
 };
 
+static struct panel_acx565akm_data *get_panel_data(struct omap_dss_device *dssdev)
+{
+	return (struct panel_acx565akm_data *) dssdev->data;
+}
+
 static int acx_panel_probe(struct omap_dss_device *dssdev)
 {
 	int r;
 	struct acx565akm_device *md = &acx_dev;
+	struct panel_acx565akm_data *panel_data = get_panel_data(dssdev);
 	struct backlight_device *bldev;
 	int max_brightness, brightness;
 	struct backlight_properties props;
 
 	dev_dbg(&dssdev->dev, "%s\n", __func__);
 
+	if (!panel_data)
+		return -EINVAL;
+
 	/* FIXME AC bias ? */
 	dssdev->panel.timings = acx_panel_timings;
 
-	if (dssdev->platform_enable)
-		dssdev->platform_enable(dssdev);
+	if (gpio_is_valid(panel_data->reset_gpio)) {
+		r = devm_gpio_request_one(&dssdev->dev, panel_data->reset_gpio,
+				GPIOF_OUT_INIT_LOW, "lcd reset");
+		if (r)
+			return r;
+	}
+
+	if (gpio_is_valid(panel_data->reset_gpio))
+		gpio_set_value(panel_data->reset_gpio, 1);
+
 	/*
 	 * After reset we have to wait 5 msec before the first
 	 * command can be sent.
@@ -520,8 +539,9 @@ static int acx_panel_probe(struct omap_dss_device *dssdev)
 	r = panel_detect(md);
 	if (r) {
 		dev_err(&dssdev->dev, "%s panel detect error\n", __func__);
-		if (!md->enabled && dssdev->platform_disable)
-			dssdev->platform_disable(dssdev);
+		if (!md->enabled && gpio_is_valid(panel_data->reset_gpio))
+			gpio_set_value(panel_data->reset_gpio, 0);
+
 		return r;
 	}
 
@@ -530,8 +550,8 @@ static int acx_panel_probe(struct omap_dss_device *dssdev)
 	mutex_unlock(&acx_dev.mutex);
 
 	if (!md->enabled) {
-		if (dssdev->platform_disable)
-			dssdev->platform_disable(dssdev);
+		if (gpio_is_valid(panel_data->reset_gpio))
+			gpio_set_value(panel_data->reset_gpio, 0);
 	}
 
 	/*------- Backlight control --------*/
@@ -584,6 +604,7 @@ static void acx_panel_remove(struct omap_dss_device *dssdev)
 static int acx_panel_power_on(struct omap_dss_device *dssdev)
 {
 	struct acx565akm_device *md = &acx_dev;
+	struct panel_acx565akm_data *panel_data = get_panel_data(dssdev);
 	int r;
 
 	dev_dbg(&dssdev->dev, "%s\n", __func__);
@@ -605,11 +626,8 @@ static int acx_panel_power_on(struct omap_dss_device *dssdev)
 	/*FIXME tweak me */
 	msleep(50);
 
-	if (dssdev->platform_enable) {
-		r = dssdev->platform_enable(dssdev);
-		if (r)
-			goto fail;
-	}
+	if (gpio_is_valid(panel_data->reset_gpio))
+		gpio_set_value(panel_data->reset_gpio, 1);
 
 	if (md->enabled) {
 		dev_dbg(&md->spi->dev, "panel already enabled\n");
@@ -638,8 +656,7 @@ static int acx_panel_power_on(struct omap_dss_device *dssdev)
 	mutex_unlock(&md->mutex);
 
 	return acx565akm_bl_update_status(md->bl_dev);
-fail:
-	omapdss_sdi_display_disable(dssdev);
+
 fail_unlock:
 	mutex_unlock(&md->mutex);
 	return r;
@@ -648,6 +665,7 @@ fail_unlock:
 static void acx_panel_power_off(struct omap_dss_device *dssdev)
 {
 	struct acx565akm_device *md = &acx_dev;
+	struct panel_acx565akm_data *panel_data = get_panel_data(dssdev);
 
 	dev_dbg(&dssdev->dev, "%s\n", __func__);
 
@@ -671,8 +689,8 @@ static void acx_panel_power_off(struct omap_dss_device *dssdev)
 	 */
 	msleep(50);
 
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
+	if (gpio_is_valid(panel_data->reset_gpio))
+		gpio_set_value(panel_data->reset_gpio, 0);
 
 	/* FIXME need to tweak this delay */
 	msleep(100);
diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index 86da8d3..6faf0c7 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -117,4 +117,12 @@ struct panel_sharp_ls037v7dw01_data {
 	int ud_gpio;
 };
 
+/**
+ * acx565akm panel driver configuration data
+ * @reset_gpio: reset signal
+ */
+struct panel_acx565akm_data {
+	int reset_gpio;
+};
+
 #endif /* __OMAP_PANEL_DATA_H */
-- 
1.7.9.5

