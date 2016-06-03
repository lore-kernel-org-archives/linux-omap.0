From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 09/27] omapfb: panel-lgphilips-lb035q02: Remove legacy boot support
Date: Fri, 3 Jun 2016 13:53:03 +0300
Message-ID: <20160603105321.7980-10-peter.ujfalusi@ti.com>
References: <20160603105321.7980-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160603105321.7980-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

The panel is not used by any legacy board files so the legacy (pdata) boot
support can be dropped.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../omapfb/displays/panel-lgphilips-lb035q02.c     | 56 +++-------------------
 include/video/omap-panel-data.h                    | 18 -------
 2 files changed, 6 insertions(+), 68 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c
index 18eb60e9c9ec..6d5207c7b22c 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c
@@ -17,7 +17,6 @@
 #include <linux/gpio.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-data.h>
 
 static struct omap_video_timings lb035q02_timings = {
 	.x_res = 320,
@@ -240,44 +239,6 @@ static struct omap_dss_driver lb035q02_ops = {
 	.get_resolution	= omapdss_default_get_resolution,
 };
 
-static int lb035q02_probe_pdata(struct spi_device *spi)
-{
-	const struct panel_lb035q02_platform_data *pdata;
-	struct panel_drv_data *ddata = dev_get_drvdata(&spi->dev);
-	struct omap_dss_device *dssdev, *in;
-	int r;
-
-	pdata = dev_get_platdata(&spi->dev);
-
-	in = omap_dss_find_output(pdata->source);
-	if (in == NULL) {
-		dev_err(&spi->dev, "failed to find video source '%s'\n",
-				pdata->source);
-		return -EPROBE_DEFER;
-	}
-
-	ddata->in = in;
-
-	ddata->data_lines = pdata->data_lines;
-
-	dssdev = &ddata->dssdev;
-	dssdev->name = pdata->name;
-
-	r = devm_gpio_request_one(&spi->dev, pdata->enable_gpio,
-					GPIOF_OUT_INIT_LOW, "panel enable");
-	if (r)
-		goto err_gpio;
-
-	ddata->enable_gpio = gpio_to_desc(pdata->enable_gpio);
-
-	ddata->backlight_gpio = pdata->backlight_gpio;
-
-	return 0;
-err_gpio:
-	omap_dss_put_device(ddata->in);
-	return r;
-}
-
 static int lb035q02_probe_of(struct spi_device *spi)
 {
 	struct device_node *node = spi->dev.of_node;
@@ -312,6 +273,9 @@ static int lb035q02_panel_spi_probe(struct spi_device *spi)
 	struct omap_dss_device *dssdev;
 	int r;
 
+	if (!spi->dev.of_node)
+		return -ENODEV;
+
 	ddata = devm_kzalloc(&spi->dev, sizeof(*ddata), GFP_KERNEL);
 	if (ddata == NULL)
 		return -ENOMEM;
@@ -320,17 +284,9 @@ static int lb035q02_panel_spi_probe(struct spi_device *spi)
 
 	ddata->spi = spi;
 
-	if (dev_get_platdata(&spi->dev)) {
-		r = lb035q02_probe_pdata(spi);
-		if (r)
-			return r;
-	} else if (spi->dev.of_node) {
-		r = lb035q02_probe_of(spi);
-		if (r)
-			return r;
-	} else {
-		return -ENODEV;
-	}
+	r = lb035q02_probe_of(spi);
+	if (r)
+		return r;
 
 	if (gpio_is_valid(ddata->backlight_gpio)) {
 		r = devm_gpio_request_one(&spi->dev, ddata->backlight_gpio,
diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index 085b4171eb25..74486bcc754e 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -147,22 +147,4 @@ struct panel_acx565akm_platform_data {
 	int datapairs;
 };
 
-/**
- * panel_lb035q02 platform data
- * @name: name for this display entity
- * @source: name of the display entity used as a video source
- * @data_lines: number of DPI datalines
- * @backlight_gpio: gpio to enable/disable the backlight (or -1)
- * @enable_gpio: gpio to enable/disable the panel (or -1)
- */
-struct panel_lb035q02_platform_data {
-	const char *name;
-	const char *source;
-
-	int data_lines;
-
-	int backlight_gpio;
-	int enable_gpio;
-};
-
 #endif /* __OMAP_PANEL_DATA_H */
-- 
2.8.3
