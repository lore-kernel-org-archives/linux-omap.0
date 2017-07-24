From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv1 05/14] drm/omap: add manual update detection helper
Date: Mon, 24 Jul 2017 19:33:02 +0200
Message-ID: <20170724173311.27170-6-sebastian.reichel@collabora.co.uk>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

In preparation for manually updated display support, such as DSI
command mode panels, this adds a simple helper to see if a connector
is manually updated.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/gpu/drm/omapdrm/omap_connector.c | 8 ++++++++
 drivers/gpu/drm/omapdrm/omap_drv.h       | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index c24b6b783e9a..5e941305ab1b 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -42,6 +42,14 @@ bool omap_connector_get_hdmi_mode(struct drm_connector *connector)
 	return omap_connector->hdmi_mode;
 }
 
+bool omap_connector_get_manually_updated(struct drm_connector *connector)
+{
+	struct omap_connector *omap_connector = to_omap_connector(connector);
+
+	return !!(omap_connector->dssdev->caps &
+		  OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE);
+}
+
 static enum drm_connector_status omap_connector_detect(
 		struct drm_connector *connector, bool force)
 {
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index 22f3d94994d2..f6c48f254c9b 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -142,6 +142,7 @@ struct drm_connector *omap_connector_init(struct drm_device *dev,
 struct drm_encoder *omap_connector_attached_encoder(
 		struct drm_connector *connector);
 bool omap_connector_get_hdmi_mode(struct drm_connector *connector);
+bool omap_connector_get_manually_updated(struct drm_connector *connector);
 
 struct drm_framebuffer *omap_framebuffer_create(struct drm_device *dev,
 		struct drm_file *file, const struct drm_mode_fb_cmd2 *mode_cmd);
-- 
2.13.2
