From: Archit Taneja <archit@ti.com>
Subject: [PATCH 12/33] OMAPDSS: generic dpi panel: remove platform_enable/disable ops from platform_data
Date: Wed, 13 Feb 2013 19:52:04 +0530
Message-ID: <1360765345-19312-13-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56533 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934095Ab3BMOXu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 09:23:50 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The generic dpi panel driver now sets the gpios required to configure the panel.
This was previously done in platform_enable/disable callbacks in board files.

All the board files using generic dpi panel now correctly pass the gpio related
information as platform data, which is needed by the panel driver to configure
the panel. Hence, the platform_enable/disable ops can be safely removed now.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c   |   12 +---
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |   71 +++++++++++++++++---
 include/video/omap-panel-data.h                    |   20 ++++--
 3 files changed, 77 insertions(+), 26 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 4a12db6..64d93b1 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -577,20 +577,13 @@ static int generic_dpi_panel_power_on(struct omap_dss_device *dssdev)
 	if (panel_config->power_on_delay)
 		msleep(panel_config->power_on_delay);
 
-	if (panel_data->platform_enable) {
-		r = panel_data->platform_enable(dssdev);
-		if (r)
-			goto err1;
-	}
-
 	for (i = 0; i < panel_data->num_gpios; ++i) {
 		gpio_set_value_cansleep(panel_data->gpios[i],
 				panel_data->gpio_invert[i] ? 0 : 1);
 	}
 
 	return 0;
-err1:
-	omapdss_dpi_display_disable(dssdev);
+
 err0:
 	return r;
 }
@@ -610,9 +603,6 @@ static void generic_dpi_panel_power_off(struct omap_dss_device *dssdev)
 				panel_data->gpio_invert[i] ? 1 : 0);
 	}
 
-	if (panel_data->platform_disable)
-		panel_data->platform_disable(dssdev);
-
 	/* wait couple of vsyncs after disabling the LCD */
 	if (panel_config->power_off_delay)
 		msleep(panel_config->power_off_delay);
diff --git a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
index eb6bd81..e6d9c9b 100644
--- a/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
@@ -23,11 +23,10 @@
 #include <linux/fb.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/gpio.h>
 
 #include <video/omapdss.h>
-
-struct sharp_data {
-};
+#include <video/omap-panel-data.h>
 
 static struct omap_video_timings sharp_ls_timings = {
 	.x_res = 480,
@@ -50,31 +49,67 @@ static struct omap_video_timings sharp_ls_timings = {
 	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
 };
 
+static inline struct panel_sharp_ls037v7dw01_data
+*get_panel_data(const struct omap_dss_device *dssdev)
+{
+	return (struct panel_sharp_ls037v7dw01_data *) dssdev->data;
+}
 
 static int sharp_ls_panel_probe(struct omap_dss_device *dssdev)
 {
-	struct sharp_data *sd;
+	struct panel_sharp_ls037v7dw01_data *pd = get_panel_data(dssdev);
+	int r;
+
+	if (!pd)
+		return -EINVAL;
 
 	dssdev->panel.timings = sharp_ls_timings;
 
-	sd = kzalloc(sizeof(*sd), GFP_KERNEL);
-	if (!sd)
-		return -ENOMEM;
+	if (gpio_is_valid(pd->mo_gpio)) {
+		r = devm_gpio_request_one(&dssdev->dev, pd->mo_gpio,
+				GPIOF_OUT_INIT_LOW, "lcd MO");
+		if (r)
+			return r;
+	}
+
+	if (gpio_is_valid(pd->lr_gpio)) {
+		r = devm_gpio_request_one(&dssdev->dev, pd->lr_gpio,
+				GPIOF_OUT_INIT_HIGH, "lcd LR");
+		if (r)
+			return r;
+	}
 
-	dev_set_drvdata(&dssdev->dev, sd);
+	if (gpio_is_valid(pd->ud_gpio)) {
+		r = devm_gpio_request_one(&dssdev->dev, pd->ud_gpio,
+				GPIOF_OUT_INIT_HIGH, "lcd UD");
+		if (r)
+			return r;
+	}
+
+	if (gpio_is_valid(pd->resb_gpio)) {
+		r = devm_gpio_request_one(&dssdev->dev, pd->resb_gpio,
+				GPIOF_OUT_INIT_LOW, "lcd RESB");
+		if (r)
+			return r;
+	}
+
+	if (gpio_is_valid(pd->ini_gpio)) {
+		r = devm_gpio_request_one(&dssdev->dev, pd->ini_gpio,
+				GPIOF_OUT_INIT_LOW, "lcd INI");
+		if (r)
+			return r;
+	}
 
 	return 0;
 }
 
 static void __exit sharp_ls_panel_remove(struct omap_dss_device *dssdev)
 {
-	struct sharp_data *sd = dev_get_drvdata(&dssdev->dev);
-
-	kfree(sd);
 }
 
 static int sharp_ls_power_on(struct omap_dss_device *dssdev)
 {
+	struct panel_sharp_ls037v7dw01_data *pd = get_panel_data(dssdev);
 	int r = 0;
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
@@ -96,6 +131,12 @@ static int sharp_ls_power_on(struct omap_dss_device *dssdev)
 			goto err1;
 	}
 
+	if (gpio_is_valid(pd->resb_gpio))
+		gpio_set_value_cansleep(pd->resb_gpio, 1);
+
+	if (gpio_is_valid(pd->ini_gpio))
+		gpio_set_value_cansleep(pd->ini_gpio, 1);
+
 	return 0;
 err1:
 	omapdss_dpi_display_disable(dssdev);
@@ -105,9 +146,17 @@ err0:
 
 static void sharp_ls_power_off(struct omap_dss_device *dssdev)
 {
+	struct panel_sharp_ls037v7dw01_data *pd = get_panel_data(dssdev);
+
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return;
 
+	if (gpio_is_valid(pd->ini_gpio))
+		gpio_set_value_cansleep(pd->ini_gpio, 0);
+
+	if (gpio_is_valid(pd->resb_gpio))
+		gpio_set_value_cansleep(pd->resb_gpio, 0);
+
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
 
diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index eec93f1..86da8d3 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -32,16 +32,12 @@ struct omap_dss_device;
 /**
  * struct panel_generic_dpi_data - panel driver configuration data
  * @name: panel name
- * @platform_enable: platform specific panel enable function
- * @platform_disable: platform specific panel disable function
  * @num_gpios: number of gpios connected to panel
  * @gpios: gpio numbers on the platform
  * @gpio_invert: configure gpio as active high or low
  */
 struct panel_generic_dpi_data {
 	const char *name;
-	int (*platform_enable)(struct omap_dss_device *dssdev);
-	void (*platform_disable)(struct omap_dss_device *dssdev);
 
 	int num_gpios;
 	int gpios[10];
@@ -105,4 +101,20 @@ struct tfp410_platform_data {
 	int power_down_gpio;
 };
 
+/**
+ * sharp ls panel driver configuration data
+ * @resb_gpio: reset signal
+ * @ini_gpio: power on control
+ * @mo_gpio: selection for resolution(VGA/QVGA)
+ * @lr_gpio: selection for horizontal scanning direction
+ * @ud_gpio: selection for vertical scanning direction
+ */
+struct panel_sharp_ls037v7dw01_data {
+	int resb_gpio;
+	int ini_gpio;
+	int mo_gpio;
+	int lr_gpio;
+	int ud_gpio;
+};
+
 #endif /* __OMAP_PANEL_DATA_H */
-- 
1.7.9.5

