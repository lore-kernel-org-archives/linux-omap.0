From: Archit Taneja <archit@ti.com>
Subject: [PATCH 09/33] OMAPDSS: lb035q02: handle gpios in panel driver
Date: Wed, 13 Feb 2013 19:52:01 +0530
Message-ID: <1360765345-19312-10-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40206 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755963Ab3BMOXl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:23:41 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The lgphilips panel driver leaves gpio configurations to the platform_enable
and disable calls in the platform's board file. These should happen in the
panel driver itself.

Use the platform data as defined for generic dpi panels to pass gpio information
to the lgphilips driver.

This will help in removing the need for the panel drivers to have platform
related callbacks.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 .../omap2/displays/panel-lgphilips-lb035q02.c      |   38 +++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
index 8effea8..63cd8857 100644
--- a/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/video/omap2/displays/panel-lgphilips-lb035q02.c
@@ -20,8 +20,10 @@
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
 #include <linux/mutex.h>
+#include <linux/gpio.h>
 
 #include <video/omapdss.h>
+#include <video/omap-panel-data.h>
 
 struct lb035q02_data {
 	struct mutex lock;
@@ -48,9 +50,16 @@ static struct omap_video_timings lb035q02_timings = {
 	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_OPPOSITE_EDGES,
 };
 
+static inline struct panel_generic_dpi_data
+*get_panel_data(const struct omap_dss_device *dssdev)
+{
+	return (struct panel_generic_dpi_data *) dssdev->data;
+}
+
 static int lb035q02_panel_power_on(struct omap_dss_device *dssdev)
 {
-	int r;
+	struct panel_generic_dpi_data *panel_data = get_panel_data(dssdev);
+	int r, i;
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
@@ -68,6 +77,11 @@ static int lb035q02_panel_power_on(struct omap_dss_device *dssdev)
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
@@ -77,9 +91,17 @@ err0:
 
 static void lb035q02_panel_power_off(struct omap_dss_device *dssdev)
 {
+	struct panel_generic_dpi_data *panel_data = get_panel_data(dssdev);
+	int i;
+
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return;
 
+	for (i = panel_data->num_gpios - 1; i >= 0; --i) {
+		gpio_set_value_cansleep(panel_data->gpios[i],
+				panel_data->gpio_invert[i] ? 1 : 0);
+	}
+
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
 
@@ -88,7 +110,12 @@ static void lb035q02_panel_power_off(struct omap_dss_device *dssdev)
 
 static int lb035q02_panel_probe(struct omap_dss_device *dssdev)
 {
+	struct panel_generic_dpi_data *panel_data = get_panel_data(dssdev);
 	struct lb035q02_data *ld;
+	int r, i;
+
+	if (!panel_data)
+		return -EINVAL;
 
 	dssdev->panel.timings = lb035q02_timings;
 
@@ -96,6 +123,15 @@ static int lb035q02_panel_probe(struct omap_dss_device *dssdev)
 	if (!ld)
 		return -ENOMEM;
 
+	for (i = 0; i < panel_data->num_gpios; ++i) {
+		r = devm_gpio_request_one(&dssdev->dev, panel_data->gpios[i],
+				panel_data->gpio_invert[i] ?
+				GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW,
+				"panel gpio");
+		if (r)
+			return r;
+	}
+
 	mutex_init(&ld->lock);
 	dev_set_drvdata(&dssdev->dev, ld);
 
-- 
1.7.9.5

