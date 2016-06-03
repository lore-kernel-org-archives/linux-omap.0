From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 12/27] omapfb: connector-dvi: Remove legacy boot support
Date: Fri, 3 Jun 2016 14:03:14 +0300
Message-ID: <20160603110329.9953-13-peter.ujfalusi@ti.com>
References: <20160603110329.9953-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160603110329.9953-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

The panel is not used by any legacy board files so the legacy (pdata) boot
support can be dropped.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../fbdev/omap2/omapfb/displays/connector-dvi.c    | 58 +++-------------------
 include/video/omap-panel-data.h                    | 12 -----
 2 files changed, 6 insertions(+), 64 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c b/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c
index d811e6dcaef7..f2abbec7602a 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c
@@ -17,7 +17,6 @@
 #include <drm/drm_edid.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-data.h>
 
 static const struct omap_video_timings dvic_default_timings = {
 	.x_res		= 640,
@@ -236,46 +235,6 @@ static struct omap_dss_driver dvic_driver = {
 	.detect		= dvic_detect,
 };
 
-static int dvic_probe_pdata(struct platform_device *pdev)
-{
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
-	struct connector_dvi_platform_data *pdata;
-	struct omap_dss_device *in, *dssdev;
-	int i2c_bus_num;
-
-	pdata = dev_get_platdata(&pdev->dev);
-	i2c_bus_num = pdata->i2c_bus_num;
-
-	if (i2c_bus_num != -1) {
-		struct i2c_adapter *adapter;
-
-		adapter = i2c_get_adapter(i2c_bus_num);
-		if (!adapter) {
-			dev_err(&pdev->dev,
-					"Failed to get I2C adapter, bus %d\n",
-					i2c_bus_num);
-			return -EPROBE_DEFER;
-		}
-
-		ddata->i2c_adapter = adapter;
-	}
-
-	in = omap_dss_find_output(pdata->source);
-	if (in == NULL) {
-		i2c_put_adapter(ddata->i2c_adapter);
-
-		dev_err(&pdev->dev, "Failed to find video source\n");
-		return -EPROBE_DEFER;
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
 static int dvic_probe_of(struct platform_device *pdev)
 {
 	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
@@ -313,23 +272,18 @@ static int dvic_probe(struct platform_device *pdev)
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
-		r = dvic_probe_pdata(pdev);
-		if (r)
-			return r;
-	} else if (pdev->dev.of_node) {
-		r = dvic_probe_of(pdev);
-		if (r)
-			return r;
-	} else {
-		return -ENODEV;
-	}
+	r = dvic_probe_of(pdev);
+	if (r)
+		return r;
 
 	ddata->timings = dvic_default_timings;
 
diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index c0836b118f67..4d0b8832ae11 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -47,18 +47,6 @@ struct encoder_tfp410_platform_data {
 
 
 /**
- * connector_dvi platform data
- * @name: name for this display entity
- * @source: name of the display entity used as a video source
- * @i2c_bus_num: i2c bus number to be used for reading EDID
- */
-struct connector_dvi_platform_data {
-	const char *name;
-	const char *source;
-	int i2c_bus_num;
-};
-
-/**
  * connector_atv platform data
  * @name: name for this display entity
  * @source: name of the display entity used as a video source
-- 
2.8.3
