From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 04/10] drm: omapdrm: crtc: save framedone callback from dss
Date: Sun,  5 Mar 2017 01:43:03 +0100
Message-ID: <20170305004309.28259-4-sre@kernel.org>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170305004309.28259-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Save the framedone callback supplied by dss for later
usage.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index b68c70eb395f..76a411fe957a 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -42,6 +42,9 @@ struct omap_crtc {
 	bool pending;
 	wait_queue_head_t pending_wait;
 	struct drm_pending_vblank_event *event;
+
+	void (*framedone_handler)(void *);
+	void *framedone_handler_data;
 };
 
 /* -----------------------------------------------------------------------------
@@ -241,6 +244,17 @@ static int omap_crtc_dss_register_framedone(
 		enum omap_channel channel,
 		void (*handler)(void *), void *data)
 {
+	struct omap_crtc *omap_crtc = omap_crtcs[channel];
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
 
@@ -248,6 +262,16 @@ static void omap_crtc_dss_unregister_framedone(
 		enum omap_channel channel,
 		void (*handler)(void *), void *data)
 {
+	struct omap_crtc *omap_crtc = omap_crtcs[channel];
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
2.11.0
