From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 08/27] omapfb: panel-sharp-ls037v7dw01: Remove legacy boot support
Date: Fri, 3 Jun 2016 13:53:02 +0300
Message-ID: <20160603105321.7980-9-peter.ujfalusi@ti.com>
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
 .../omapfb/displays/panel-sharp-ls037v7dw01.c      | 81 ++--------------------
 include/video/omap-panel-data.h                    | 24 -------
 2 files changed, 6 insertions(+), 99 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c
index 1954ec913ce5..a1e590155a26 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c
@@ -18,7 +18,6 @@
 #include <linux/slab.h>
 #include <linux/regulator/consumer.h>
 #include <video/omapdss.h>
-#include <video/omap-panel-data.h>
 
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
@@ -197,69 +196,6 @@ static struct omap_dss_driver sharp_ls_ops = {
 	.get_resolution	= omapdss_default_get_resolution,
 };
 
-static int sharp_ls_get_gpio(struct device *dev, int gpio, unsigned long flags,
-		  char *desc, struct gpio_desc **gpiod)
-{
-	int r;
-
-	r = devm_gpio_request_one(dev, gpio, flags, desc);
-	if (r) {
-		*gpiod = NULL;
-		return r == -ENOENT ? 0 : r;
-	}
-
-	*gpiod = gpio_to_desc(gpio);
-
-	return 0;
-}
-
-static int sharp_ls_probe_pdata(struct platform_device *pdev)
-{
-	const struct panel_sharp_ls037v7dw01_platform_data *pdata;
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
-	struct omap_dss_device *dssdev, *in;
-	int r;
-
-	pdata = dev_get_platdata(&pdev->dev);
-
-	in = omap_dss_find_output(pdata->source);
-	if (in == NULL) {
-		dev_err(&pdev->dev, "failed to find video source '%s'\n",
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
-	r = sharp_ls_get_gpio(&pdev->dev, pdata->mo_gpio, GPIOF_OUT_INIT_LOW,
-		"lcd MO", &ddata->mo_gpio);
-	if (r)
-		return r;
-	r = sharp_ls_get_gpio(&pdev->dev, pdata->lr_gpio, GPIOF_OUT_INIT_HIGH,
-		"lcd LR", &ddata->lr_gpio);
-	if (r)
-		return r;
-	r = sharp_ls_get_gpio(&pdev->dev, pdata->ud_gpio, GPIOF_OUT_INIT_HIGH,
-		"lcd UD", &ddata->ud_gpio);
-	if (r)
-		return r;
-	r = sharp_ls_get_gpio(&pdev->dev, pdata->resb_gpio, GPIOF_OUT_INIT_LOW,
-		"lcd RESB", &ddata->resb_gpio);
-	if (r)
-		return r;
-	r = sharp_ls_get_gpio(&pdev->dev, pdata->ini_gpio, GPIOF_OUT_INIT_LOW,
-		"lcd INI", &ddata->ini_gpio);
-	if (r)
-		return r;
-
-	return 0;
-}
-
 static  int sharp_ls_get_gpio_of(struct device *dev, int index, int val,
 	const char *desc, struct gpio_desc **gpiod)
 {
@@ -330,23 +266,18 @@ static int sharp_ls_probe(struct platform_device *pdev)
 	struct omap_dss_device *dssdev;
 	int r;
 
+	if (!pdev->dev.of_node)
+		return -ENODEV;
+
 	ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
 	if (ddata == NULL)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, ddata);
 
-	if (dev_get_platdata(&pdev->dev)) {
-		r = sharp_ls_probe_pdata(pdev);
-		if (r)
-			return r;
-	} else if (pdev->dev.of_node) {
-		r = sharp_ls_probe_of(pdev);
-		if (r)
-			return r;
-	} else {
-		return -ENODEV;
-	}
+	r = sharp_ls_probe_of(pdev);
+	if (r)
+		return r;
 
 	ddata->videomode = sharp_ls_timings;
 
diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index 34ee7509752f..085b4171eb25 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -165,28 +165,4 @@ struct panel_lb035q02_platform_data {
 	int enable_gpio;
 };
 
-/**
- * panel_sharp_ls037v7dw01 platform data
- * @name: name for this display entity
- * @source: name of the display entity used as a video source
- * @data_lines: number of DPI datalines
- * @resb_gpio: reset signal GPIO
- * @ini_gpio: power on control GPIO
- * @mo_gpio: selection for resolution(VGA/QVGA) GPIO
- * @lr_gpio: selection for horizontal scanning direction GPIO
- * @ud_gpio: selection for vertical scanning direction GPIO
- */
-struct panel_sharp_ls037v7dw01_platform_data {
-	const char *name;
-	const char *source;
-
-	int data_lines;
-
-	int resb_gpio;
-	int ini_gpio;
-	int mo_gpio;
-	int lr_gpio;
-	int ud_gpio;
-};
-
 #endif /* __OMAP_PANEL_DATA_H */
-- 
2.8.3
