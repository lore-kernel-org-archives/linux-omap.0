From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 14/23] drm: omapdrm: crtc: save framedone callback from dss
Date: Tue,  8 Mar 2016 17:39:46 +0100
Message-ID: <1457455195-1938-15-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Save the framedone callback supplied by dss for later
usage.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 094e89a2fa94..3ce7143e5a5f 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -57,6 +57,9 @@ struct omap_crtc {
 
 	unsigned long state;
 	wait_queue_head_t pending_wait;
+
+	void (*framedone_handler)(void *);
+	void *framedone_handler_data;
 };
 
 /* -----------------------------------------------------------------------------
@@ -263,6 +266,17 @@ static int omap_crtc_dss_register_framedone(
 		struct omap_overlay_manager *mgr,
 		void (*handler)(void *), void *data)
 {
+	struct omap_crtc *omap_crtc = omap_crtcs[mgr->id];
+	struct drm_device *dev = omap_crtc->base.dev;
+
+	if (omap_crtc->framedone_handler)
+		return -EBUSY;
+
+	dev_dbg(dev->dev, "register framedone %s", omap_crtc->name);
+
+	omap_crtc->framedone_handler = handler;
+	omap_crtc->framedone_handler_data = data;
+
 	return 0;
 }
 
@@ -270,6 +284,16 @@ static void omap_crtc_dss_unregister_framedone(
 		struct omap_overlay_manager *mgr,
 		void (*handler)(void *), void *data)
 {
+	struct omap_crtc *omap_crtc = omap_crtcs[mgr->id];
+	struct drm_device *dev = omap_crtc->base.dev;
+
+	dev_dbg(dev->dev, "unregister framedone %s", omap_crtc->name);
+
+	WARN_ON(omap_crtc->framedone_handler != handler);
+	WARN_ON(omap_crtc->framedone_handler_data != data);
+
+	omap_crtc->framedone_handler = NULL;
+	omap_crtc->framedone_handler_data = NULL;
 }
 
 static const struct dss_mgr_ops mgr_ops = {
-- 
2.7.0
