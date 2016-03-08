From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 19/23] drm: omapdrm: panel-dsi-cm: improve DT support
Date: Tue,  8 Mar 2016 17:39:51 +0100
Message-ID: <1457455195-1938-20-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Introduce new DT properties, so that it's possible
to use different panels with the driver.

 * resolution-x (default: 864)
 * resolution-y (default: 480)
 * has-dsi-backlight (default: no backlight)

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 8316b6c2d8aa..4c1e76da68cd 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -1240,7 +1240,12 @@ static int dsicm_probe_of(struct platform_device *pdev)
 
 	ddata->in = in;
 
-	/* TODO: ulps, backlight */
+	ddata->use_dsi_backlight = of_property_read_bool(node, "has-dsi-backlight");
+
+	of_property_read_u32(node, "resolution-x", (u32*) &ddata->timings.x_res);
+	of_property_read_u32(node, "resolution-y", (u32*) &ddata->timings.y_res);
+
+	ddata->timings.pixelclock = ddata->timings.x_res * ddata->timings.y_res * 60;
 
 	return 0;
 }
@@ -1263,6 +1268,12 @@ static int dsicm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ddata);
 	ddata->pdev = pdev;
 
+	/* setup defaults */
+	ddata->ulps_timeout = 500;
+	ddata->timings.x_res = 864;
+	ddata->timings.y_res = 480;
+	ddata->timings.pixelclock = 864 * 480 * 60;
+
 	if (dev_get_platdata(dev)) {
 		r = dsicm_probe_pdata(pdev);
 		if (r)
@@ -1275,10 +1286,6 @@ static int dsicm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	ddata->timings.x_res = 864;
-	ddata->timings.y_res = 480;
-	ddata->timings.pixelclock = 864 * 480 * 60;
-
 	dssdev = &ddata->dssdev;
 	dssdev->dev = dev;
 	dssdev->driver = &dsicm_ops;
-- 
2.7.0
