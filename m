From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv3 6/8] drm/omap: add support for rotation hints from display drivers
Date: Fri, 30 Mar 2018 19:18:20 +0200
Message-ID: <20180330171822.25896-7-sebastian.reichel@collabora.co.uk>
References: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

This adds support for setting DRM panel orientation property
based on rotation information from the display driver.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/gpu/drm/omapdrm/dss/omapdss.h    |  2 ++
 drivers/gpu/drm/omapdrm/omap_connector.c | 34 +++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss.h b/drivers/gpu/drm/omapdrm/dss/omapdss.h
index 14d74adb13fb..01a2a6638f70 100644
--- a/drivers/gpu/drm/omapdrm/dss/omapdss.h
+++ b/drivers/gpu/drm/omapdrm/dss/omapdss.h
@@ -554,6 +554,8 @@ struct omap_dss_driver {
 			    struct videomode *vm);
 	void (*get_size)(struct omap_dss_device *dssdev,
 			 unsigned int *width, unsigned int *height);
+	void (*get_rotation)(struct omap_dss_device *dssdev,
+				int *rotation);
 
 	int (*set_wss)(struct omap_dss_device *dssdev, u32 wss);
 	u32 (*get_wss)(struct omap_dss_device *dssdev);
diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index a33b51484b2d..f8ae8bdf9211 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -249,6 +249,8 @@ struct drm_connector *omap_connector_init(struct drm_device *dev,
 	struct drm_connector *connector = NULL;
 	struct omap_connector *omap_connector;
 	bool hpd_supported = false;
+	int rotation = -1;
+	int ret;
 
 	DBG("%s", dssdev->name);
 
@@ -267,7 +269,7 @@ struct drm_connector *omap_connector_init(struct drm_device *dev,
 	drm_connector_helper_add(connector, &omap_connector_helper_funcs);
 
 	if (dssdev->driver->register_hpd_cb) {
-		int ret = dssdev->driver->register_hpd_cb(dssdev,
+		ret = dssdev->driver->register_hpd_cb(dssdev,
 							  omap_connector_hpd_cb,
 							  omap_connector);
 		if (!ret)
@@ -288,6 +290,36 @@ struct drm_connector *omap_connector_init(struct drm_device *dev,
 	connector->interlace_allowed = 1;
 	connector->doublescan_allowed = 0;
 
+	if (dssdev->driver->get_rotation)
+		dssdev->driver->get_rotation(dssdev, &rotation);
+
+	switch (rotation) {
+	case 0:
+		connector->display_info.panel_orientation =
+			DRM_MODE_PANEL_ORIENTATION_NORMAL;
+		break;
+	case 90:
+		connector->display_info.panel_orientation =
+			DRM_MODE_PANEL_ORIENTATION_RIGHT_UP;
+		break;
+	case 180:
+		connector->display_info.panel_orientation =
+			DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP;
+		break;
+	case 270:
+		connector->display_info.panel_orientation =
+			DRM_MODE_PANEL_ORIENTATION_LEFT_UP;
+		break;
+	default:
+		connector->display_info.panel_orientation =
+			DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
+		break;
+	}
+
+	ret = drm_connector_init_panel_orientation_property(connector, 0, 0);
+	if (ret)
+		DBG("%s: Failed to init orientation property (%d)", dssdev->name, ret);
+
 	return connector;
 
 fail:
-- 
2.16.2
