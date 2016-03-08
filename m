From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 16/23] drm: omapdrm: update manual displays on dirty ioctl
Date: Tue,  8 Mar 2016 17:39:48 +0100
Message-ID: <1457455195-1938-17-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/omap_connector.c | 12 ------------
 drivers/gpu/drm/omapdrm/omap_drv.h       |  2 --
 drivers/gpu/drm/omapdrm/omap_fb.c        |  2 +-
 3 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index 8db36aa4bd00..83f2a9177c14 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -275,18 +275,6 @@ static const struct drm_connector_helper_funcs omap_connector_helper_funcs = {
 	.best_encoder = omap_connector_attached_encoder,
 };
 
-/* flush an area of the framebuffer (in case of manual update display that
- * is not automatically flushed)
- */
-void omap_connector_flush(struct drm_connector *connector,
-		int x, int y, int w, int h)
-{
-	struct omap_connector *omap_connector = to_omap_connector(connector);
-
-	/* TODO: enable when supported in dss */
-	VERB("%s: %d,%d, %dx%d", omap_connector->dssdev->name, x, y, w, h);
-}
-
 /* initialize connector */
 struct drm_connector *omap_connector_init(struct drm_device *dev,
 		int connector_type, struct omap_dss_device *dssdev,
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index e08f4ef1bf3c..e536a8dbb51b 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -172,8 +172,6 @@ struct drm_connector *omap_connector_init(struct drm_device *dev,
 struct drm_encoder *omap_connector_attached_encoder(
 		struct drm_connector *connector);
 bool omap_connector_get_hdmi_mode(struct drm_connector *connector);
-void omap_connector_flush(struct drm_connector *connector,
-		int x, int y, int w, int h);
 void omap_crtc_flush(struct drm_crtc *crtc,
 		int x, int y, int w, int h);
 
diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
index b51d2243f356..ee61a34bab26 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -378,7 +378,7 @@ void omap_framebuffer_flush(struct drm_framebuffer *fb,
 			int cw = w + (x - crtc->x) - cx;
 			int ch = h + (y - crtc->y) - cy;
 
-			omap_connector_flush(connector, cx, cy, cw, ch);
+			omap_crtc_flush(crtc, cx, cy, cw, ch);
 		}
 	}
 }
-- 
2.7.0
