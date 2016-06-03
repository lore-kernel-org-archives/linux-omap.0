From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 13/27] omapfb: encoder-tfp410: Remove legacy boot support
Date: Fri, 3 Jun 2016 13:53:07 +0300
Message-ID: <20160603105321.7980-14-peter.ujfalusi@ti.com>
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
 .../fbdev/omap2/omapfb/displays/encoder-tfp410.c   | 44 +++-------------------
 include/video/omap-panel-data.h                    | 14 -------
 2 files changed, 6 insertions(+), 52 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tfp410.c b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tfp410.c
index d9048b3df495..778e3b384c2f 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tfp410.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tfp410.c
@@ -16,7 +16,6 @@
 #include <linux/of_gpio.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-data.h>
 
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
@@ -166,32 +165,6 @@ static const struct omapdss_dvi_ops tfp410_dvi_ops = {
 	.get_timings	= tfp410_get_timings,
 };
 
-static int tfp410_probe_pdata(struct platform_device *pdev)
-{
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
-	struct encoder_tfp410_platform_data *pdata;
-	struct omap_dss_device *dssdev, *in;
-
-	pdata = dev_get_platdata(&pdev->dev);
-
-	ddata->pd_gpio = pdata->power_down_gpio;
-
-	ddata->data_lines = pdata->data_lines;
-
-	in = omap_dss_find_output(pdata->source);
-	if (in == NULL) {
-		dev_err(&pdev->dev, "Failed to find video source\n");
-		return -ENODEV;
-	}
-
-	ddata->in = in;
-
-	dssdev = &ddata->dssdev;
-	dssdev->name = pdata->name;
-
-	return 0;
-}
-
 static int tfp410_probe_of(struct platform_device *pdev)
 {
 	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
@@ -225,23 +198,18 @@ static int tfp410_probe(struct platform_device *pdev)
 	struct omap_dss_device *dssdev;
 	int r;
 
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
 	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, ddata);
 
-	if (dev_get_platdata(&pdev->dev)) {
-		r = tfp410_probe_pdata(pdev);
-		if (r)
-			return r;
-	} else if (pdev->dev.of_node) {
-		r = tfp410_probe_of(pdev);
-		if (r)
-			return r;
-	} else {
-		return -ENODEV;
-	}
+	r = tfp410_probe_of(pdev);
+	if (r)
+		return r;
 
 	if (gpio_is_valid(ddata->pd_gpio)) {
 		r = devm_gpio_request_one(&pdev->dev, ddata->pd_gpio,
diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index 4d0b8832ae11..a64e9ba12b0d 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -33,20 +33,6 @@
 struct omap_dss_device;
 
 /**
- * encoder_tfp410 platform data
- * @name: name for this display entity
- * @power_down_gpio: gpio number for PD pin (or -1 if not available)
- * @data_lines: number of DPI datalines
- */
-struct encoder_tfp410_platform_data {
-	const char *name;
-	const char *source;
-	int power_down_gpio;
-	int data_lines;
-};
-
-
-/**
  * connector_atv platform data
  * @name: name for this display entity
  * @source: name of the display entity used as a video source
-- 
2.8.3
