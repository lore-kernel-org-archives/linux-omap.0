From: Archit Taneja <archit@ti.com>
Subject: [PATCH 02/33] OMAPDSS: generic dpi panel: handle gpios in panel driver
Date: Wed, 13 Feb 2013 19:51:54 +0530
Message-ID: <1360765345-19312-3-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60068 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934024Ab3BMOXS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:23:18 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

The generic dpi panel driver leaves gpio configurations to the platform_enable
and disable calls in the platform's board file. These should happen in the
panel driver itself.

Add a generic way of passing gpio information to the generic dpi panel driver
via it's platform_data. This information includes the number of gpios used by
the panel, the gpio number and logic level (active high/low) for each gpio. This
gpio data will be used by the driver to request and configure the gpios required
by the panel.

This will help in removing the need for the panel drivers to have platform
related callbacks.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-generic-dpi.c |   25 ++++++++++++++++++++--
 include/video/omap-panel-data.h                  |    7 ++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index d8d0cd5..4a12db6 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -33,6 +33,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/gpio.h>
 #include <video/omapdss.h>
 
 #include <video/omap-panel-data.h>
@@ -557,7 +558,7 @@ static inline struct panel_generic_dpi_data
 
 static int generic_dpi_panel_power_on(struct omap_dss_device *dssdev)
 {
-	int r;
+	int r, i;
 	struct panel_generic_dpi_data *panel_data = get_panel_data(dssdev);
 	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
 	struct panel_config *panel_config = drv_data->panel_config;
@@ -582,6 +583,11 @@ static int generic_dpi_panel_power_on(struct omap_dss_device *dssdev)
 			goto err1;
 	}
 
+	for (i = 0; i < panel_data->num_gpios; ++i) {
+		gpio_set_value_cansleep(panel_data->gpios[i],
+				panel_data->gpio_invert[i] ? 0 : 1);
+	}
+
 	return 0;
 err1:
 	omapdss_dpi_display_disable(dssdev);
@@ -594,10 +600,16 @@ static void generic_dpi_panel_power_off(struct omap_dss_device *dssdev)
 	struct panel_generic_dpi_data *panel_data = get_panel_data(dssdev);
 	struct panel_drv_data *drv_data = dev_get_drvdata(&dssdev->dev);
 	struct panel_config *panel_config = drv_data->panel_config;
+	int i;
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return;
 
+	for (i = panel_data->num_gpios - 1; i >= 0; --i) {
+		gpio_set_value_cansleep(panel_data->gpios[i],
+				panel_data->gpio_invert[i] ? 1 : 0);
+	}
+
 	if (panel_data->platform_disable)
 		panel_data->platform_disable(dssdev);
 
@@ -613,7 +625,7 @@ static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
 	struct panel_generic_dpi_data *panel_data = get_panel_data(dssdev);
 	struct panel_config *panel_config = NULL;
 	struct panel_drv_data *drv_data = NULL;
-	int i;
+	int i, r;
 
 	dev_dbg(&dssdev->dev, "probe\n");
 
@@ -630,6 +642,15 @@ static int generic_dpi_panel_probe(struct omap_dss_device *dssdev)
 	if (!panel_config)
 		return -EINVAL;
 
+	for (i = 0; i < panel_data->num_gpios; ++i) {
+		r = devm_gpio_request_one(&dssdev->dev, panel_data->gpios[i],
+				panel_data->gpio_invert[i] ?
+				GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW,
+				"panel gpio");
+		if (r)
+			return r;
+	}
+
 	dssdev->panel.timings = panel_config->timings;
 
 	drv_data = devm_kzalloc(&dssdev->dev, sizeof(*drv_data), GFP_KERNEL);
diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index e8e30f9..eec93f1 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -34,11 +34,18 @@ struct omap_dss_device;
  * @name: panel name
  * @platform_enable: platform specific panel enable function
  * @platform_disable: platform specific panel disable function
+ * @num_gpios: number of gpios connected to panel
+ * @gpios: gpio numbers on the platform
+ * @gpio_invert: configure gpio as active high or low
  */
 struct panel_generic_dpi_data {
 	const char *name;
 	int (*platform_enable)(struct omap_dss_device *dssdev);
 	void (*platform_disable)(struct omap_dss_device *dssdev);
+
+	int num_gpios;
+	int gpios[10];
+	bool gpio_invert[10];
 };
 
 /**
-- 
1.7.9.5

