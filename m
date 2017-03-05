From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 06/10] drm: omapdrm: crtc: add support for manual updated displays
Date: Sun,  5 Mar 2017 01:43:05 +0100
Message-ID: <20170305004309.28259-6-sre@kernel.org>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170305004309.28259-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Sebastian Reichel <sre@kernel.org>
[tony@atomide.com: rebased and fixed up to work with droid 4]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/gpu/drm/omapdrm/omap_connector.c | 12 ------
 drivers/gpu/drm/omapdrm/omap_crtc.c      | 65 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/omapdrm/omap_drv.h       |  2 +-
 drivers/gpu/drm/omapdrm/omap_fb.c        |  2 +-
 4 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index b09d8989b789..5ab672cac0b2 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -212,18 +212,6 @@ static const struct drm_connector_helper_funcs omap_connector_helper_funcs = {
 	.mode_valid = omap_connector_mode_valid,
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
diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 03351ca2ee41..432ad6023f27 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -43,6 +43,7 @@ struct omap_crtc {
 	bool pending;
 	wait_queue_head_t pending_wait;
 	struct drm_pending_vblank_event *event;
+	struct delayed_work update_work;
 
 	void (*framedone_handler)(void *);
 	void *framedone_handler_data;
@@ -138,6 +139,7 @@ static void omap_crtc_dss_disconnect(enum omap_channel channel,
 
 static void omap_crtc_dss_start_update(enum omap_channel channel)
 {
+	dispc_mgr_enable(channel, true);
 }
 
 /* Called only from the encoder enable/disable and suspend/resume handlers. */
@@ -347,6 +349,60 @@ void omap_crtc_vblank_irq(struct drm_crtc *crtc)
 	DBG("%s: apply done", omap_crtc->name);
 }
 
+void omap_crtc_flush(struct drm_crtc *crtc,
+		int x, int y, int w, int h)
+{
+	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
+
+	if (!omap_crtc->manually_updated)
+		return;
+
+	if (!delayed_work_pending(&omap_crtc->update_work))
+		schedule_delayed_work(&omap_crtc->update_work, 0);
+}
+
+static void omap_crtc_manual_display_update(struct work_struct *data)
+{
+	struct omap_crtc *omap_crtc = container_of(data, struct omap_crtc,
+					update_work.work);
+	struct drm_crtc *crtc = &omap_crtc->base;
+	struct omap_dss_device *dssdev = omap_crtc_output[omap_crtc->channel];
+	struct omap_dss_driver *dssdrv;
+	int ret;
+
+	if (!dssdev || !dssdev->dst) {
+		dev_err_once(omap_crtc->base.dev->dev, "missing dssdev!\n");
+		return;
+	}
+
+	dssdev = dssdev->dst;
+	dssdrv = dssdev->driver;
+
+	if (!dssdrv)
+		return;
+
+	if (!dssdrv || !dssdrv->update)
+		return;
+
+	/*
+	 * REVISIT: Testing and setting omap_crtc->pending here will cause all
+	 * kind of warnings at least on droid 4. Maybe we should be testing
+	 * something else here instead of omap_crtc->pending?
+	 */
+
+	if (dssdrv->sync)
+		dssdrv->sync(dssdev);
+
+	ret = dssdrv->update(dssdev, 0, 0,
+			     dssdev->panel.vm.vactive, dssdev->panel.vm.hactive);
+	if (ret < 0) {
+		spin_lock_irq(&crtc->dev->event_lock);
+		omap_crtc->pending = false;
+		spin_unlock_irq(&crtc->dev->event_lock);
+		wake_up(&omap_crtc->pending_wait);
+	}
+}
+
 /* -----------------------------------------------------------------------------
  * CRTC Functions
  */
@@ -395,9 +451,15 @@ static void omap_crtc_enable(struct drm_crtc *crtc)
 static void omap_crtc_disable(struct drm_crtc *crtc)
 {
 	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
+	struct drm_device *dev = crtc->dev;
 
 	DBG("%s", omap_crtc->name);
 
+	cancel_delayed_work(&omap_crtc->update_work);
+
+	if (!omap_crtc_wait_pending(crtc))
+		dev_warn(dev->dev, "manual display update did not finish!");
+
 	drm_crtc_vblank_off(crtc);
 }
 
@@ -469,6 +531,7 @@ static void omap_crtc_atomic_flush(struct drm_crtc *crtc,
 	}
 
 	spin_lock_irq(&crtc->dev->event_lock);
+	dispc_mgr_enable(omap_crtc->channel, true);
 	dispc_mgr_go(omap_crtc->channel);
 
 	WARN_ON(omap_crtc->pending);
@@ -597,6 +660,8 @@ struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 	omap_crtc->channel = channel;
 	omap_crtc->name = channel_names[channel];
 
+	INIT_DELAYED_WORK(&omap_crtc->update_work, omap_crtc_manual_display_update);
+
 	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
 					&omap_crtc_funcs, NULL);
 	if (ret < 0) {
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index 5a0106239be2..ee8901dc0381 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -157,7 +157,7 @@ struct drm_encoder *omap_connector_attached_encoder(
 		struct drm_connector *connector);
 bool omap_connector_get_hdmi_mode(struct drm_connector *connector);
 bool omap_connector_get_manually_updated(struct drm_connector *connector);
-void omap_connector_flush(struct drm_connector *connector,
+void omap_crtc_flush(struct drm_crtc *crtc,
 		int x, int y, int w, int h);
 
 uint32_t omap_framebuffer_get_formats(uint32_t *pixel_formats,
diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
index b6ae28fe3257..5bf05916de03 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -356,7 +356,7 @@ void omap_framebuffer_flush(struct drm_framebuffer *fb,
 			int cw = w + (x - crtc->x) - cx;
 			int ch = h + (y - crtc->y) - cy;
 
-			omap_connector_flush(connector, cx, cy, cw, ch);
+			omap_crtc_flush(crtc, cx, cy, cw, ch);
 		}
 	}
 }
-- 
2.11.0
