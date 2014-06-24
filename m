From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 15/15] drm/omap: Add infoframe & dvi/hdmi mode support
Date: Tue, 24 Jun 2014 13:04:00 +0300
Message-ID: <1403604240-16738-16-git-send-email-tomi.valkeinen@ti.com>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57847 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753478AbaFXKEd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 06:04:33 -0400
In-Reply-To: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rob Clark <robdclark@gmail.com>

Make the omapdrm driver use the new HDMI ops when possible.

omapdrm will call set_hdmi_mode (when available) to tell the encoder
driver whether the monitor is a DVI or HDMI monitor, and if it's an HDMI
monitor, omapdrm will call set_hdmi_infoframe to to set the AVI
infoframe.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/omapdrm/omap_connector.c | 12 ++++++++++++
 drivers/gpu/drm/omapdrm/omap_drv.h       |  1 +
 drivers/gpu/drm/omapdrm/omap_encoder.c   | 27 +++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index 86f4ead0441d..19492cd31f10 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -32,8 +32,16 @@ struct omap_connector {
 	struct drm_connector base;
 	struct omap_dss_device *dssdev;
 	struct drm_encoder *encoder;
+	bool hdmi_mode;
 };
 
+bool omap_connector_get_hdmi_mode(struct drm_connector *connector)
+{
+	struct omap_connector *omap_connector = to_omap_connector(connector);
+
+	return omap_connector->hdmi_mode;
+}
+
 void copy_timings_omap_to_drm(struct drm_display_mode *mode,
 		struct omap_video_timings *timings)
 {
@@ -162,10 +170,14 @@ static int omap_connector_get_modes(struct drm_connector *connector)
 			drm_mode_connector_update_edid_property(
 					connector, edid);
 			n = drm_add_edid_modes(connector, edid);
+
+			omap_connector->hdmi_mode =
+				drm_detect_hdmi_monitor(edid);
 		} else {
 			drm_mode_connector_update_edid_property(
 					connector, NULL);
 		}
+
 		kfree(edid);
 	} else {
 		struct drm_display_mode *mode = drm_mode_create(dev);
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index 284b80fc3c54..c204c1e7ce87 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -194,6 +194,7 @@ struct drm_encoder *omap_connector_attached_encoder(
 		struct drm_connector *connector);
 void omap_connector_flush(struct drm_connector *connector,
 		int x, int y, int w, int h);
+bool omap_connector_get_hdmi_mode(struct drm_connector *connector);
 
 void copy_timings_omap_to_drm(struct drm_display_mode *mode,
 		struct omap_video_timings *timings);
diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/omapdrm/omap_encoder.c
index 5290a88c681d..7445fb1491ae 100644
--- a/drivers/gpu/drm/omapdrm/omap_encoder.c
+++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
@@ -17,6 +17,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <drm/drm_edid.h>
+
 #include "omap_drv.h"
 
 #include "drm_crtc.h"
@@ -89,6 +91,31 @@ static void omap_encoder_mode_set(struct drm_encoder *encoder,
 				struct drm_display_mode *mode,
 				struct drm_display_mode *adjusted_mode)
 {
+	struct drm_device *dev = encoder->dev;
+	struct omap_encoder *omap_encoder = to_omap_encoder(encoder);
+	struct omap_dss_device *dssdev = omap_encoder->dssdev;
+	struct drm_connector *connector;
+	bool hdmi_mode;
+	int r;
+
+	hdmi_mode = false;
+	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+		if (connector->encoder == encoder) {
+			hdmi_mode = omap_connector_get_hdmi_mode(connector);
+			break;
+		}
+	}
+
+	if (dssdev->driver->set_hdmi_mode)
+		dssdev->driver->set_hdmi_mode(dssdev, hdmi_mode);
+
+	if (hdmi_mode && dssdev->driver->set_hdmi_infoframe) {
+		struct hdmi_avi_infoframe avi;
+
+		r = drm_hdmi_avi_infoframe_from_display_mode(&avi, adjusted_mode);
+		if (r == 0)
+			dssdev->driver->set_hdmi_infoframe(dssdev, &avi);
+	}
 }
 
 static void omap_encoder_prepare(struct drm_encoder *encoder)
-- 
1.9.1

