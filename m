From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 17/23] drm: omapdrm: panel-dsi-cm: add regulator support
Date: Tue,  8 Mar 2016 17:39:49 +0100
Message-ID: <1457455195-1938-18-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The N950's display requires two regulators.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 57 +++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 3414c2609320..768e92d1ec8b 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -24,6 +24,7 @@
 #include <linux/workqueue.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
+#include <linux/regulator/consumer.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-data.h>
@@ -60,6 +61,9 @@ struct panel_drv_data {
 	int reset_gpio;
 	int ext_te_gpio;
 
+	struct regulator *vpnl;
+	struct regulator *vddi;
+
 	bool use_dsi_backlight;
 
 	struct omap_dsi_pin_config pin_config;
@@ -597,25 +601,43 @@ static int dsicm_power_on(struct panel_drv_data *ddata)
 		.lp_clk_max = 10000000,
 	};
 
+	if (ddata->vpnl) {
+		r = regulator_enable(ddata->vpnl);
+		if (r) {
+			dev_err(&ddata->pdev->dev,
+				"failed to enable VPNL: %d\n", r);
+			goto err0;
+		}
+	}
+
+	if (ddata->vddi) {
+		r = regulator_enable(ddata->vddi);
+		if (r) {
+			dev_err(&ddata->pdev->dev,
+				"failed to enable VDDI: %d\n", r);
+			goto err1;
+		}
+	}
+
 	if (ddata->pin_config.num_pins > 0) {
 		r = in->ops.dsi->configure_pins(in, &ddata->pin_config);
 		if (r) {
 			dev_err(&ddata->pdev->dev,
 				"failed to configure DSI pins\n");
-			goto err0;
+			goto err2;
 		}
 	}
 
 	r = in->ops.dsi->set_config(in, &dsi_config);
 	if (r) {
 		dev_err(&ddata->pdev->dev, "failed to configure DSI\n");
-		goto err0;
+		goto err2;
 	}
 
 	r = in->ops.dsi->enable(in);
 	if (r) {
 		dev_err(&ddata->pdev->dev, "failed to enable DSI\n");
-		goto err0;
+		goto err2;
 	}
 
 	dsicm_hw_reset(ddata);
@@ -673,6 +695,12 @@ err:
 	dsicm_hw_reset(ddata);
 
 	in->ops.dsi->disable(in, true, false);
+err2:
+	if (ddata->vddi)
+		regulator_disable(ddata->vddi);
+err1:
+	if (ddata->vpnl)
+		regulator_disable(ddata->vpnl);
 err0:
 	return r;
 }
@@ -696,6 +724,11 @@ static void dsicm_power_off(struct panel_drv_data *ddata)
 
 	in->ops.dsi->disable(in, true, false);
 
+	if (ddata->vddi)
+		regulator_disable(ddata->vddi);
+	if (ddata->vpnl)
+		regulator_disable(ddata->vpnl);
+
 	ddata->enabled = 0;
 }
 
@@ -1166,7 +1199,7 @@ static int dsicm_probe_of(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
 	struct omap_dss_device *in;
-	int gpio;
+	int gpio, err;
 
 	gpio = of_get_named_gpio(node, "reset-gpios", 0);
 	if (!gpio_is_valid(gpio)) {
@@ -1189,6 +1222,22 @@ static int dsicm_probe_of(struct platform_device *pdev)
 		return PTR_ERR(in);
 	}
 
+	ddata->vpnl = devm_regulator_get_optional(&pdev->dev, "vpnl");
+	if (IS_ERR(ddata->vpnl)) {
+		err = PTR_ERR(ddata->vpnl);
+		if (err == -EPROBE_DEFER)
+			return err;
+		ddata->vpnl = NULL;
+	}
+
+	ddata->vddi = devm_regulator_get_optional(&pdev->dev, "vddi");
+	if (IS_ERR(ddata->vddi)) {
+		err = PTR_ERR(ddata->vddi);
+		if (err == -EPROBE_DEFER)
+			return err;
+		ddata->vddi = NULL;
+	}
+
 	ddata->in = in;
 
 	/* TODO: ulps, backlight */
-- 
2.7.0
