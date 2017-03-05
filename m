From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 01/10] drm: omapdrm: panel-dsi-cm: Fix probe for device tree
Date: Sun,  5 Mar 2017 01:43:00 +0100
Message-ID: <20170305004309.28259-1-sre@kernel.org>
References: <20170304235021.27055-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170304235021.27055-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

Things are a bit whacked right now for panel-dsi-cm:

1. We're missing call to of_get_display_timing() and
   videomode_from_timing()

2. We need to call dsicm_probe_of() after we initialize the
   default values to not overwrite device tree configured
   values

3. We need to implement minimal get_timings() and check_timings()
   for the panel to work

With these changes we get panel-dsi-cm to probe with device tree
configuraion. Note that the dsicm_check_timings adapted from an
earlier patch by Sebastian Reichel <sre@kernel.org>.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Tested-By: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 65 ++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index ac5800c72cb4..ad1058fafe92 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -25,6 +25,7 @@
 #include <linux/of_gpio.h>
 
 #include <video/mipi_display.h>
+#include <video/of_display_timing.h>
 
 #include "../dss/omapdss.h"
 
@@ -379,13 +380,6 @@ static const struct backlight_ops dsicm_bl_ops = {
 	.update_status  = dsicm_bl_update_status,
 };
 
-static void dsicm_get_resolution(struct omap_dss_device *dssdev,
-		u16 *xres, u16 *yres)
-{
-	*xres = dssdev->panel.vm.hactive;
-	*yres = dssdev->panel.vm.vactive;
-}
-
 static ssize_t dsicm_num_errors_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -1106,6 +1100,36 @@ static void dsicm_ulps_work(struct work_struct *work)
 	mutex_unlock(&ddata->lock);
 }
 
+static void dsicm_get_timings(struct omap_dss_device *dssdev,
+			      struct videomode *vm)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+
+	*vm = ddata->vm;
+}
+
+static int dsicm_check_timings(struct omap_dss_device *dssdev,
+			       struct videomode *vm)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+	int ret = 0;
+
+	if (vm->hactive != ddata->vm.hactive)
+		ret = -EINVAL;
+
+	if (vm->vactive != ddata->vm.vactive)
+		ret = -EINVAL;
+
+	if (ret) {
+		dev_warn(dssdev->dev, "wrong resolution: %d x %d",
+			 vm->hactive, vm->vactive);
+		dev_warn(dssdev->dev, "panel resolution: %d x %d",
+			 ddata->vm.hactive, ddata->vm.vactive);
+	}
+
+	return ret;
+}
+
 static struct omap_dss_driver dsicm_ops = {
 	.connect	= dsicm_connect,
 	.disconnect	= dsicm_disconnect,
@@ -1116,7 +1140,10 @@ static struct omap_dss_driver dsicm_ops = {
 	.update		= dsicm_update,
 	.sync		= dsicm_sync,
 
-	.get_resolution	= dsicm_get_resolution,
+	.get_timings	= dsicm_get_timings,
+	.check_timings	= dsicm_check_timings,
+
+	.get_resolution	= omapdss_default_get_resolution,
 	.get_recommended_bpp = omapdss_default_get_recommended_bpp,
 
 	.enable_te	= dsicm_enable_te,
@@ -1130,7 +1157,8 @@ static int dsicm_probe_of(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
 	struct omap_dss_device *in;
-	int gpio;
+	struct display_timing timing;
+	int gpio, err;
 
 	gpio = of_get_named_gpio(node, "reset-gpios", 0);
 	if (!gpio_is_valid(gpio)) {
@@ -1147,6 +1175,17 @@ static int dsicm_probe_of(struct platform_device *pdev)
 		return gpio;
 	}
 
+	err = of_get_display_timing(node, "panel-timing", &timing);
+	if (!err) {
+		videomode_from_timing(&timing, &ddata->vm);
+		if (!ddata->vm.pixelclock)
+			ddata->vm.pixelclock =
+				ddata->vm.hactive * ddata->vm.vactive * 60;
+	} else {
+		dev_warn(&pdev->dev,
+			 "failed to get video timing, using defaults\n");
+	}
+
 	in = omapdss_of_find_source_for_first_ep(node);
 	if (IS_ERR(in)) {
 		dev_err(&pdev->dev, "failed to find video source\n");
@@ -1181,14 +1220,14 @@ static int dsicm_probe(struct platform_device *pdev)
 	if (!pdev->dev.of_node)
 		return -ENODEV;
 
-	r = dsicm_probe_of(pdev);
-	if (r)
-		return r;
-
 	ddata->vm.hactive = 864;
 	ddata->vm.vactive = 480;
 	ddata->vm.pixelclock = 864 * 480 * 60;
 
+	r = dsicm_probe_of(pdev);
+	if (r)
+		return r;
+
 	dssdev = &ddata->dssdev;
 	dssdev->dev = dev;
 	dssdev->driver = &dsicm_ops;
-- 
2.11.0
