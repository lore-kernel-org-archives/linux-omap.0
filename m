From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 01/26] omapfb: panel-tpo-td028ttec1: Remove legacy boot support
Date: Mon, 30 May 2016 14:42:33 +0300
Message-ID: <20160530114258.30879-2-peter.ujfalusi@ti.com>
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
 .../omap2/omapfb/displays/panel-tpo-td028ttec1.c   | 43 +++-------------------
 include/video/omap-panel-data.h                    | 13 -------
 2 files changed, 6 insertions(+), 50 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
index 4d657f3ab679..f4dc023868ae 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
@@ -29,7 +29,6 @@
 #include <linux/spi/spi.h>
 #include <linux/gpio.h>
 #include <video/omapdss.h>
-#include <video/omap-panel-data.h>
 
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
@@ -365,31 +364,6 @@ static struct omap_dss_driver td028ttec1_ops = {
 	.check_timings	= td028ttec1_panel_check_timings,
 };
 
-static int td028ttec1_panel_probe_pdata(struct spi_device *spi)
-{
-	const struct panel_tpo_td028ttec1_platform_data *pdata;
-	struct panel_drv_data *ddata = dev_get_drvdata(&spi->dev);
-	struct omap_dss_device *dssdev, *in;
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
-	return 0;
-}
-
 static int td028ttec1_probe_of(struct spi_device *spi)
 {
 	struct device_node *node = spi->dev.of_node;
@@ -415,6 +389,9 @@ static int td028ttec1_panel_probe(struct spi_device *spi)
 
 	dev_dbg(&spi->dev, "%s\n", __func__);
 
+	if (!spi->dev.of_node)
+		return -ENODEV;
+
 	spi->bits_per_word = 9;
 	spi->mode = SPI_MODE_3;
 
@@ -432,17 +409,9 @@ static int td028ttec1_panel_probe(struct spi_device *spi)
 
 	ddata->spi_dev = spi;
 
-	if (dev_get_platdata(&spi->dev)) {
-		r = td028ttec1_panel_probe_pdata(spi);
-		if (r)
-			return r;
-	} else if (spi->dev.of_node) {
-		r = td028ttec1_probe_of(spi);
-		if (r)
-			return r;
-	} else {
-		return -ENODEV;
-	}
+	r = td028ttec1_probe_of(spi);
+	if (r)
+		return r;
 
 	ddata->videomode = td028ttec1_panel_timings;
 
diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index 56830d1dc762..fbdaa4c3ae96 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -223,17 +223,4 @@ struct panel_nec_nl8048hl11_platform_data {
 	int qvga_gpio;
 };
 
-/**
- * panel-tpo-td028ttec1 platform data
- * @name: name for display entity
- * @source: name of the display entity used as a video source
- * @data_lines: number of DPI datalines
- */
-struct panel_tpo_td028ttec1_platform_data {
-	const char *name;
-	const char *source;
-
-	int data_lines;
-};
-
 #endif /* __OMAP_PANEL_DATA_H */
-- 
2.8.3
