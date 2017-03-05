From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 02/10] drm: omapdrm: panel-dsi-cm: add regulator support
Date: Sun,  5 Mar 2017 01:43:01 +0100
Message-ID: <20170305004309.28259-2-sre@kernel.org>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170305004309.28259-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The N950's display requires two regulators.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 55 +++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index ad1058fafe92..8d13123708ae 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -23,6 +23,7 @@
 #include <linux/workqueue.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
+#include <linux/regulator/consumer.h>
 
 #include <video/mipi_display.h>
 #include <video/of_display_timing.h>
@@ -60,6 +61,9 @@ struct panel_drv_data {
 	int reset_gpio;
 	int ext_te_gpio;
 
+	struct regulator *vpnl;
+	struct regulator *vddi;
+
 	bool use_dsi_backlight;
 
 	struct omap_dsi_pin_config pin_config;
@@ -590,25 +594,43 @@ static int dsicm_power_on(struct panel_drv_data *ddata)
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
@@ -666,6 +688,12 @@ static int dsicm_power_on(struct panel_drv_data *ddata)
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
@@ -689,6 +717,11 @@ static void dsicm_power_off(struct panel_drv_data *ddata)
 
 	in->ops.dsi->disable(in, true, false);
 
+	if (ddata->vddi)
+		regulator_disable(ddata->vddi);
+	if (ddata->vpnl)
+		regulator_disable(ddata->vpnl);
+
 	ddata->enabled = 0;
 }
 
@@ -1192,6 +1225,22 @@ static int dsicm_probe_of(struct platform_device *pdev)
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
2.11.0
