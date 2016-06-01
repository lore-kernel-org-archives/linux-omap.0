From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 06/27] omapfb: panel-dsi-cm: Remove legacy boot support
Date: Wed, 1 Jun 2016 11:35:28 +0300
Message-ID: <20160601083549.10549-7-peter.ujfalusi@ti.com>
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
 .../fbdev/omap2/omapfb/displays/panel-dsi-cm.c     | 52 +++-------------------
 include/video/omap-panel-data.h                    | 27 -----------
 2 files changed, 6 insertions(+), 73 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
index 3414c2609320..a4eac6962b76 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
@@ -26,7 +26,6 @@
 #include <linux/of_gpio.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-data.h>
 #include <video/mipi_display.h>
 
 /* DSI Virtual channel. Hardcoded for now. */
@@ -1127,40 +1126,6 @@ static struct omap_dss_driver dsicm_ops = {
 	.memory_read	= dsicm_memory_read,
 };
 
-static int dsicm_probe_pdata(struct platform_device *pdev)
-{
-	const struct panel_dsicm_platform_data *pdata;
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
-	struct omap_dss_device *dssdev, *in;
-
-	pdata = dev_get_platdata(&pdev->dev);
-
-	in = omap_dss_find_output(pdata->source);
-	if (in == NULL) {
-		dev_err(&pdev->dev, "failed to find video source\n");
-		return -EPROBE_DEFER;
-	}
-	ddata->in = in;
-
-	ddata->reset_gpio = pdata->reset_gpio;
-
-	if (pdata->use_ext_te)
-		ddata->ext_te_gpio = pdata->ext_te_gpio;
-	else
-		ddata->ext_te_gpio = -1;
-
-	ddata->ulps_timeout = pdata->ulps_timeout;
-
-	ddata->use_dsi_backlight = pdata->use_dsi_backlight;
-
-	ddata->pin_config = pdata->pin_config;
-
-	dssdev = &ddata->dssdev;
-	dssdev->name = pdata->name;
-
-	return 0;
-}
-
 static int dsicm_probe_of(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
@@ -1207,6 +1172,9 @@ static int dsicm_probe(struct platform_device *pdev)
 
 	dev_dbg(dev, "probe\n");
 
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
 	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
 		return -ENOMEM;
@@ -1214,17 +1182,9 @@ static int dsicm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ddata);
 	ddata->pdev = pdev;
 
-	if (dev_get_platdata(dev)) {
-		r = dsicm_probe_pdata(pdev);
-		if (r)
-			return r;
-	} else if (pdev->dev.of_node) {
-		r = dsicm_probe_of(pdev);
-		if (r)
-			return r;
-	} else {
-		return -ENODEV;
-	}
+	r = dsicm_probe_of(pdev);
+	if (r)
+		return r;
 
 	ddata->timings.x_res = 864;
 	ddata->timings.y_res = 480;
diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index 74486bcc754e..e7b0e889d6d0 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -105,33 +105,6 @@ struct panel_dpi_platform_data {
 };
 
 /**
- * panel_dsicm platform data
- * @name: name for this display entity
- * @source: name of the display entity used as a video source
- * @reset_gpio: gpio to reset the panel (or -1)
- * @use_ext_te: use external TE GPIO
- * @ext_te_gpio: external TE GPIO
- * @ulps_timeout: time to wait before entering ULPS, 0 = disabled (ms)
- * @use_dsi_backlight: true if panel uses DSI command to control backlight
- * @pin_config: DSI pin configuration
- */
-struct panel_dsicm_platform_data {
-	const char *name;
-	const char *source;
-
-	int reset_gpio;
-
-	bool use_ext_te;
-	int ext_te_gpio;
-
-	unsigned ulps_timeout;
-
-	bool use_dsi_backlight;
-
-	struct omap_dsi_pin_config pin_config;
-};
-
-/**
  * panel_acx565akm platform data
  * @name: name for this display entity
  * @source: name of the display entity used as a video source
-- 
2.8.3
