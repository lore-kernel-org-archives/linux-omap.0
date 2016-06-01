From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 02/27] omapfb: panel-nec-nl8048hl11: Remove legacy boot support
Date: Wed, 1 Jun 2016 11:35:24 +0300
Message-ID: <20160601083549.10549-3-peter.ujfalusi@ti.com>
References: <20160601083549.10549-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160601083549.10549-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

The panel is not used by any legacy board files so the legacy (pdata) boot
support can be dropped.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../omap2/omapfb/displays/panel-nec-nl8048hl11.c   | 45 +++-------------------
 include/video/omap-panel-data.h                    | 18 ---------
 2 files changed, 6 insertions(+), 57 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.c
index 8a928c9a2fc9..3852cea3c947 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.c
@@ -19,7 +19,6 @@
 #include <linux/of_gpio.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-data.h>
 
 struct panel_drv_data {
 	struct omap_dss_device	dssdev;
@@ -233,33 +232,6 @@ static struct omap_dss_driver nec_8048_ops = {
 };
 
 
-static int nec_8048_probe_pdata(struct spi_device *spi)
-{
-	const struct panel_nec_nl8048hl11_platform_data *pdata;
-	struct panel_drv_data *ddata = dev_get_drvdata(&spi->dev);
-	struct omap_dss_device *dssdev, *in;
-
-	pdata = dev_get_platdata(&spi->dev);
-
-	ddata->qvga_gpio = pdata->qvga_gpio;
-	ddata->res_gpio = pdata->res_gpio;
-
-	in = omap_dss_find_output(pdata->source);
-	if (in == NULL) {
-		dev_err(&spi->dev, "failed to find video source '%s'\n",
-				pdata->source);
-		return -EPROBE_DEFER;
-	}
-	ddata->in = in;
-
-	ddata->data_lines = pdata->data_lines;
-
-	dssdev = &ddata->dssdev;
-	dssdev->name = pdata->name;
-
-	return 0;
-}
-
 static int nec_8048_probe_of(struct spi_device *spi)
 {
 	struct device_node *node = spi->dev.of_node;
@@ -296,6 +268,9 @@ static int nec_8048_probe(struct spi_device *spi)
 
 	dev_dbg(&spi->dev, "%s\n", __func__);
 
+	if (!spi->dev.of_node)
+		return -ENODEV;
+
 	spi->mode = SPI_MODE_0;
 	spi->bits_per_word = 32;
 
@@ -315,17 +290,9 @@ static int nec_8048_probe(struct spi_device *spi)
 
 	ddata->spi = spi;
 
-	if (dev_get_platdata(&spi->dev)) {
-		r = nec_8048_probe_pdata(spi);
-		if (r)
-			return r;
-	} else if (spi->dev.of_node) {
-		r = nec_8048_probe_of(spi);
-		if (r)
-			return r;
-	} else {
-		return -ENODEV;
-	}
+	r = nec_8048_probe_of(spi);
+	if (r)
+		return r;
 
 	if (gpio_is_valid(ddata->qvga_gpio)) {
 		r = devm_gpio_request_one(&spi->dev, ddata->qvga_gpio,
diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index fbdaa4c3ae96..a0c95cd1ed11 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -205,22 +205,4 @@ struct panel_tpo_td043mtea1_platform_data {
 	int nreset_gpio;
 };
 
-/**
- * panel-nec-nl8048hl11 platform data
- * @name: name for this display entity
- * @source: name of the display entity used as a video source
- * @data_lines: number of DPI datalines
- * @res_gpio: reset signal
- * @qvga_gpio: selection for resolution(QVGA/WVGA)
- */
-struct panel_nec_nl8048hl11_platform_data {
-	const char *name;
-	const char *source;
-
-	int data_lines;
-
-	int res_gpio;
-	int qvga_gpio;
-};
-
 #endif /* __OMAP_PANEL_DATA_H */
-- 
2.8.3
