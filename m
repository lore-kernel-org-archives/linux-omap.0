From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv3 7/8] drm/omap: panel-dsi-cm: add rotation support
Date: Fri, 30 Mar 2018 19:18:21 +0200
Message-ID: <20180330171822.25896-8-sebastian.reichel@collabora.co.uk>
References: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

From: Sebastian Reichel <sre@kernel.org>

Add support to inform the DRM subsystem about the orientation
the display has been mounted to the casing.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 428de90fced1..21a828f88d30 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -68,6 +68,7 @@ struct panel_drv_data {
 
 	int width_mm;
 	int height_mm;
+	int rotation;
 
 	struct omap_dsi_pin_config pin_config;
 
@@ -1210,6 +1211,14 @@ static void dsicm_get_size(struct omap_dss_device *dssdev,
 	*height = ddata->height_mm;
 }
 
+static void dsicm_get_rotation(struct omap_dss_device *dssdev,
+			       int *rotation)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+
+	*rotation = ddata->rotation;
+}
+
 static struct omap_dss_driver dsicm_ops = {
 	.connect	= dsicm_connect,
 	.disconnect	= dsicm_disconnect,
@@ -1223,6 +1232,7 @@ static struct omap_dss_driver dsicm_ops = {
 	.get_timings	= dsicm_get_timings,
 	.check_timings	= dsicm_check_timings,
 	.get_size	= dsicm_get_size,
+	.get_rotation   = dsicm_get_rotation,
 
 	.enable_te	= dsicm_enable_te,
 	.get_te		= dsicm_get_te,
@@ -1270,6 +1280,9 @@ static int dsicm_probe_of(struct platform_device *pdev)
 	ddata->height_mm = 0;
 	of_property_read_u32(node, "height-mm", &ddata->height_mm);
 
+	ddata->rotation = -1;
+	of_property_read_u32(node, "rotation", &ddata->rotation);
+
 	ddata->vpnl = devm_regulator_get_optional(&pdev->dev, "vpnl");
 	if (IS_ERR(ddata->vpnl)) {
 		err = PTR_ERR(ddata->vpnl);
-- 
2.16.2
