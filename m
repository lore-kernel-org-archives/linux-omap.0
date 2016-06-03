From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 11/27] omapfb: connector-hdmi: Remove legacy boot support
Date: Fri, 3 Jun 2016 14:03:13 +0300
Message-ID: <20160603110329.9953-12-peter.ujfalusi@ti.com>
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
 .../fbdev/omap2/omapfb/displays/connector-hdmi.c   | 42 ++++------------------
 include/video/omap-panel-data.h                    | 10 ------
 2 files changed, 6 insertions(+), 46 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c b/drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c
index 6ee4129bc0c0..231b8588a59f 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c
@@ -18,7 +18,6 @@
 #include <drm/drm_edid.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-data.h>
 
 static const struct omap_video_timings hdmic_default_timings = {
 	.x_res		= 640,
@@ -206,30 +205,6 @@ static struct omap_dss_driver hdmic_driver = {
 	.set_hdmi_infoframe	= hdmic_set_infoframe,
 };
 
-static int hdmic_probe_pdata(struct platform_device *pdev)
-{
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
-	struct connector_hdmi_platform_data *pdata;
-	struct omap_dss_device *in, *dssdev;
-
-	pdata = dev_get_platdata(&pdev->dev);
-
-	ddata->hpd_gpio = -ENODEV;
-
-	in = omap_dss_find_output(pdata->source);
-	if (in == NULL) {
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
 static int hdmic_probe_of(struct platform_device *pdev)
 {
 	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
@@ -261,6 +236,9 @@ static int hdmic_probe(struct platform_device *pdev)
 	struct omap_dss_device *dssdev;
 	int r;
 
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
 	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
@@ -268,17 +246,9 @@ static int hdmic_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ddata);
 	ddata->dev = &pdev->dev;
 
-	if (dev_get_platdata(&pdev->dev)) {
-		r = hdmic_probe_pdata(pdev);
-		if (r)
-			return r;
-	} else if (pdev->dev.of_node) {
-		r = hdmic_probe_of(pdev);
-		if (r)
-			return r;
-	} else {
-		return -ENODEV;
-	}
+	r = hdmic_probe_of(pdev);
+	if (r)
+		return r;
 
 	if (gpio_is_valid(ddata->hpd_gpio)) {
 		r = devm_gpio_request_one(&pdev->dev, ddata->hpd_gpio,
diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index e7b0e889d6d0..c0836b118f67 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -59,16 +59,6 @@ struct connector_dvi_platform_data {
 };
 
 /**
- * connector_hdmi platform data
- * @name: name for this display entity
- * @source: name of the display entity used as a video source
- */
-struct connector_hdmi_platform_data {
-	const char *name;
-	const char *source;
-};
-
-/**
  * connector_atv platform data
  * @name: name for this display entity
  * @source: name of the display entity used as a video source
-- 
2.8.3
