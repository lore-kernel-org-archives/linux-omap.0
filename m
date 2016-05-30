From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 03/26] omapfb: panel-tpo-td043mtea1: Remove legacy boot support
Date: Mon, 30 May 2016 14:42:35 +0300
Message-ID: <20160530114258.30879-4-peter.ujfalusi@ti.com>
References: <20160530114258.30879-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160530114258.30879-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

The panel is not used by any legacy board files so the legacy (pdata) boot
support can be dropped.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../omap2/omapfb/displays/panel-tpo-td043mtea1.c   | 44 +++-------------------
 include/video/omap-panel-data.h                    | 16 --------
 2 files changed, 6 insertions(+), 54 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
index 68e3b68a2920..f49e60da5bd3 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
@@ -20,7 +20,6 @@
 #include <linux/of_gpio.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-data.h>
 
 #define TPO_R02_MODE(x)		((x) & 7)
 #define TPO_R02_MODE_800x480	7
@@ -465,32 +464,6 @@ static struct omap_dss_driver tpo_td043_ops = {
 };
 
 
-static int tpo_td043_probe_pdata(struct spi_device *spi)
-{
-	const struct panel_tpo_td043mtea1_platform_data *pdata;
-	struct panel_drv_data *ddata = dev_get_drvdata(&spi->dev);
-	struct omap_dss_device *dssdev, *in;
-
-	pdata = dev_get_platdata(&spi->dev);
-
-	ddata->nreset_gpio = pdata->nreset_gpio;
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
 static int tpo_td043_probe_of(struct spi_device *spi)
 {
 	struct device_node *node = spi->dev.of_node;
@@ -524,6 +497,9 @@ static int tpo_td043_probe(struct spi_device *spi)
 
 	dev_dbg(&spi->dev, "%s\n", __func__);
 
+	if (!spi->dev.of_node)
+		return -ENODEV;
+
 	spi->bits_per_word = 16;
 	spi->mode = SPI_MODE_0;
 
@@ -541,17 +517,9 @@ static int tpo_td043_probe(struct spi_device *spi)
 
 	ddata->spi = spi;
 
-	if (dev_get_platdata(&spi->dev)) {
-		r = tpo_td043_probe_pdata(spi);
-		if (r)
-			return r;
-	} else if (spi->dev.of_node) {
-		r = tpo_td043_probe_of(spi);
-		if (r)
-			return r;
-	} else {
-		return -ENODEV;
-	}
+	r = tpo_td043_probe_of(spi);
+	if (r)
+		return r;
 
 	ddata->mode = TPO_R02_MODE_800x480;
 	memcpy(ddata->gamma, tpo_td043_def_gamma, sizeof(ddata->gamma));
diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index a0c95cd1ed11..34ee7509752f 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -189,20 +189,4 @@ struct panel_sharp_ls037v7dw01_platform_data {
 	int ud_gpio;
 };
 
-/**
- * panel-tpo-td043mtea1 platform data
- * @name: name for this display entity
- * @source: name of the display entity used as a video source
- * @data_lines: number of DPI datalines
- * @nreset_gpio: reset signal
- */
-struct panel_tpo_td043mtea1_platform_data {
-	const char *name;
-	const char *source;
-
-	int data_lines;
-
-	int nreset_gpio;
-};
-
 #endif /* __OMAP_PANEL_DATA_H */
-- 
2.8.3
