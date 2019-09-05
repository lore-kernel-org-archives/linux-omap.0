From: Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [BACKPORT 4.14.y 03/18] drm/omap: panel-dsi-cm: fix driver
Date: Thu,  5 Sep 2019 10:17:44 -0600
Message-ID: <20190905161759.28036-4-mathieu.poirier@linaro.org>
References: <20190905161759.28036-1-mathieu.poirier@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20190905161759.28036-1-mathieu.poirier@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: stable@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

commit e128310ddd379b0fdd21dc41d176c3b3505a0832 upstream

This adds support for get_timings() and check_timings()
to get the driver working and properly initializes the
timing information from DT.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../gpu/drm/omapdrm/displays/panel-dsi-cm.c   | 56 +++++++++++++++++--
 1 file changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 92c556ac22c7..905b71719d65 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -25,6 +25,7 @@
 #include <linux/of_gpio.h>
 
 #include <video/mipi_display.h>
+#include <video/of_display_timing.h>
 
 #include "../dss/omapdss.h"
 
@@ -1099,6 +1100,36 @@ static void dsicm_ulps_work(struct work_struct *work)
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
@@ -1109,6 +1140,9 @@ static struct omap_dss_driver dsicm_ops = {
 	.update		= dsicm_update,
 	.sync		= dsicm_sync,
 
+	.get_timings	= dsicm_get_timings,
+	.check_timings	= dsicm_check_timings,
+
 	.enable_te	= dsicm_enable_te,
 	.get_te		= dsicm_get_te,
 
@@ -1120,7 +1154,8 @@ static int dsicm_probe_of(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
 	struct omap_dss_device *in;
-	int gpio;
+	struct display_timing timing;
+	int gpio, err;
 
 	gpio = of_get_named_gpio(node, "reset-gpios", 0);
 	if (!gpio_is_valid(gpio)) {
@@ -1137,6 +1172,17 @@ static int dsicm_probe_of(struct platform_device *pdev)
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
@@ -1171,14 +1217,14 @@ static int dsicm_probe(struct platform_device *pdev)
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
2.17.1


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
