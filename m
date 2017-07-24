From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv1 10/14] drm/omap: panel-dsi-cm: add physical size support
Date: Mon, 24 Jul 2017 19:33:07 +0200
Message-ID: <20170724173311.27170-11-sebastian.reichel@collabora.co.uk>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Add support to load physical size information from DT using
the properties defined by the common panel binding.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 95c28f518239..b50b1e81b2f5 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -66,6 +66,9 @@ struct panel_drv_data {
 
 	bool use_dsi_backlight;
 
+	int width_mm;
+	int height_mm;
+
 	struct omap_dsi_pin_config pin_config;
 
 	/* runtime variables */
@@ -1163,6 +1166,15 @@ static int dsicm_check_timings(struct omap_dss_device *dssdev,
 	return ret;
 }
 
+static void dsicm_get_size(struct omap_dss_device *dssdev,
+			  unsigned int *width, unsigned int *height)
+{
+	struct panel_drv_data *ddata = to_panel_data(dssdev);
+
+	*width = ddata->width_mm;
+	*height = ddata->height_mm;
+}
+
 static struct omap_dss_driver dsicm_ops = {
 	.connect	= dsicm_connect,
 	.disconnect	= dsicm_disconnect,
@@ -1175,6 +1187,7 @@ static struct omap_dss_driver dsicm_ops = {
 
 	.get_timings	= dsicm_get_timings,
 	.check_timings	= dsicm_check_timings,
+	.get_size	= dsicm_get_size,
 
 	.enable_te	= dsicm_enable_te,
 	.get_te		= dsicm_get_te,
@@ -1216,6 +1229,12 @@ static int dsicm_probe_of(struct platform_device *pdev)
 			 "failed to get video timing, using defaults\n");
 	}
 
+	ddata->width_mm = 0;
+	of_property_read_u32(node, "width-mm", &ddata->width_mm);
+
+	ddata->height_mm = 0;
+	of_property_read_u32(node, "height-mm", &ddata->height_mm);
+
 	in = omapdss_of_find_source_for_first_ep(node);
 	if (IS_ERR(in)) {
 		dev_err(&pdev->dev, "failed to find video source\n");
-- 
2.13.2
