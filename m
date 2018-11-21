From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv5 4/6] drm/omap: fix incorrect union usage
Date: Wed, 21 Nov 2018 17:09:14 +0100
Message-ID: <20181121160916.22017-5-sebastian.reichel@collabora.com>
References: <20181121160916.22017-1-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121160916.22017-1-sebastian.reichel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-omap@vger.kernel.org

The DSI encoder sets dssdev->ops->dsi.set_config, which is stored at the
same offset as dssdev->ops->hdmi.set_hdmi_mode. The code in omap_encoder
only checks if dssdev->ops->hdmi.set_hdmi_mode is NULL. Due to the way
union works, it won't be NULL if dsi.set_config is set. This means
dsi_set_config will be called with config=hdmi_mode=false=NULL parameter
resulting in a NULL dereference. Also the dereference happens while
console is locked, so kernel hangs without any debug output without
"fb.lockless_register_fb=1" parameter.

This restructures the code, so that the HDMI mode is only configured
for HDMI output types. The new function also has a safe-guard directly
before accessing the union, that can be optimized away by the compiler
when the function is inlined and HDMI type has already been checked.

Fixes: 83910ad3f51fb ("drm/omap: Move most omap_dss_driver operations to omap_dss_device_ops")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/omapdrm/omap_encoder.c | 62 +++++++++++++++-----------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/omapdrm/omap_encoder.c
index 32bbe3a80e7d..f356821cd078 100644
--- a/drivers/gpu/drm/omapdrm/omap_encoder.c
+++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
@@ -52,17 +52,48 @@ static const struct drm_encoder_funcs omap_encoder_funcs = {
 	.destroy = omap_encoder_destroy,
 };
 
+static void omap_encoder_hdmi_mode_set(struct drm_encoder *encoder,
+				       struct drm_display_mode *adjusted_mode)
+{
+	struct drm_device *dev = encoder->dev;
+	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
+	struct omap_dss_device *dssdev = omap_encoder->output;
+	struct drm_connector *connector;
+	bool hdmi_mode;
+
+	hdmi_mode = false;
+	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+		if (connector->encoder == encoder) {
+			hdmi_mode = omap_connector_get_hdmi_mode(connector);
+			break;
+		}
+	}
+
+	/* safe-guard for accessing dssdev->ops->hdmi union */
+	if (dssdev->output_type != OMAP_DISPLAY_TYPE_HDMI)
+		return;
+
+	if (dssdev->ops->hdmi.set_hdmi_mode)
+		dssdev->ops->hdmi.set_hdmi_mode(dssdev, hdmi_mode);
+
+	if (hdmi_mode && dssdev->ops->hdmi.set_infoframe) {
+		struct hdmi_avi_infoframe avi;
+		int r;
+
+		r = drm_hdmi_avi_infoframe_from_display_mode(&avi, adjusted_mode,
+							     false);
+		if (r == 0)
+			dssdev->ops->hdmi.set_infoframe(dssdev, &avi);
+	}
+}
+
 static void omap_encoder_mode_set(struct drm_encoder *encoder,
 				  struct drm_display_mode *mode,
 				  struct drm_display_mode *adjusted_mode)
 {
-	struct drm_device *dev = encoder->dev;
 	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
-	struct drm_connector *connector;
 	struct omap_dss_device *dssdev;
 	struct videomode vm = { 0 };
-	bool hdmi_mode;
-	int r;
 
 	drm_display_mode_to_videomode(adjusted_mode, &vm);
 
@@ -112,27 +143,8 @@ static void omap_encoder_mode_set(struct drm_encoder *encoder,
 	}
 
 	/* Set the HDMI mode and HDMI infoframe if applicable. */
-	hdmi_mode = false;
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
-		if (connector->encoder == encoder) {
-			hdmi_mode = omap_connector_get_hdmi_mode(connector);
-			break;
-		}
-	}
-
-	dssdev = omap_encoder->output;
-
-	if (dssdev->ops->hdmi.set_hdmi_mode)
-		dssdev->ops->hdmi.set_hdmi_mode(dssdev, hdmi_mode);
-
-	if (hdmi_mode && dssdev->ops->hdmi.set_infoframe) {
-		struct hdmi_avi_infoframe avi;
-
-		r = drm_hdmi_avi_infoframe_from_display_mode(&avi, adjusted_mode,
-							     false);
-		if (r == 0)
-			dssdev->ops->hdmi.set_infoframe(dssdev, &avi);
-	}
+	if (omap_encoder->output->output_type == OMAP_DISPLAY_TYPE_HDMI)
+		omap_encoder_hdmi_mode_set(encoder, adjusted_mode);
 }
 
 static void omap_encoder_disable(struct drm_encoder *encoder)
-- 
2.19.1
