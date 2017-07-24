From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv1 06/14] drm/omap: add support for manually updated displays
Date: Mon, 24 Jul 2017 19:33:03 +0200
Message-ID: <20170724173311.27170-7-sebastian.reichel@collabora.co.uk>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

This adds the required infrastructure for manually
updated displays, such as DSI command mode panels.

While those panels often support partial updates
we currently always do a full refresh. Display
will be refreshed when something calls the dirty
callback, such as libdrm's drmModeDirtyFB().

This is currently being implemented for the kernel
console and for Xorg. Weston currently does not
implement this and is known not to work on manually
updated displays.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 110 +++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/omapdrm/omap_drv.h  |   1 +
 drivers/gpu/drm/omapdrm/omap_fb.c   |  20 +++++++
 3 files changed, 123 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 404652ad8a6d..35a40271d1cb 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -42,6 +42,7 @@ struct omap_crtc {
 	bool pending;
 	wait_queue_head_t pending_wait;
 	struct drm_pending_vblank_event *event;
+	struct delayed_work update_work;
 
 	void (*framedone_handler)(void *);
 	void *framedone_handler_data;
@@ -133,6 +134,28 @@ static void omap_crtc_dss_disconnect(enum omap_channel channel,
 
 static void omap_crtc_dss_start_update(enum omap_channel channel)
 {
+	struct omap_crtc *omap_crtc = omap_crtcs[channel];
+	struct omap_drm_private *priv = omap_crtc->base.dev->dev_private;
+
+	priv->dispc_ops->mgr_enable(channel, true);
+}
+
+static bool omap_crtc_is_manually_updated(struct drm_crtc *crtc)
+{
+	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
+	bool result = false;
+
+	drm_connector_list_iter_begin(crtc->dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		if (connector->state->crtc != crtc)
+			continue;
+		result = omap_connector_get_manually_updated(connector);
+		break;
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	return result;
 }
 
 /* Called only from the encoder enable/disable and suspend/resume handlers. */
@@ -144,12 +167,17 @@ static void omap_crtc_set_enabled(struct drm_crtc *crtc, bool enable)
 	enum omap_channel channel = omap_crtc->channel;
 	struct omap_irq_wait *wait;
 	u32 framedone_irq, vsync_irq;
+	bool is_manual = omap_crtc_is_manually_updated(crtc);
+	enum omap_display_type type = omap_crtc_output[channel]->output_type;
 	int ret;
 
 	if (WARN_ON(omap_crtc->enabled == enable))
 		return;
 
-	if (omap_crtc_output[channel]->output_type == OMAP_DISPLAY_TYPE_HDMI) {
+	if (is_manual)
+		omap_irq_enable_framedone(crtc, enable);
+
+	if (is_manual || type == OMAP_DISPLAY_TYPE_HDMI) {
 		priv->dispc_ops->mgr_enable(channel, enable);
 		omap_crtc->enabled = enable;
 		return;
@@ -200,7 +228,6 @@ static void omap_crtc_set_enabled(struct drm_crtc *crtc, bool enable)
 	}
 }
 
-
 static int omap_crtc_dss_enable(enum omap_channel channel)
 {
 	struct omap_crtc *omap_crtc = omap_crtcs[channel];
@@ -360,6 +387,53 @@ void omap_crtc_framedone_irq(struct drm_crtc *crtc, uint32_t irqstatus)
 	wake_up(&omap_crtc->pending_wait);
 }
 
+void omap_crtc_flush(struct drm_crtc *crtc)
+{
+	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
+
+	if (!omap_crtc_is_manually_updated(crtc))
+		return;
+
+	if (!delayed_work_pending(&omap_crtc->update_work))
+		schedule_delayed_work(&omap_crtc->update_work, 0);
+}
+
+static void omap_crtc_manual_display_update(struct work_struct *data)
+{
+	struct omap_crtc *omap_crtc =
+			container_of(data, struct omap_crtc, update_work.work);
+	struct omap_dss_device *dssdev = omap_crtc_output[omap_crtc->channel];
+	struct drm_device *dev = omap_crtc->base.dev;
+	struct omap_dss_driver *dssdrv;
+	int ret, width, height;
+
+	if (!dssdev || !dssdev->dst) {
+		dev_err_once(dev->dev, "missing dssdev!");
+		return;
+	}
+
+	dssdev = dssdev->dst;
+	dssdrv = dssdev->driver;
+
+	if (!dssdrv || !dssdrv->update) {
+		dev_err_once(dev->dev, "incorrect dssdrv!");
+		return;
+	}
+
+	if (dssdrv->sync)
+		dssdrv->sync(dssdev);
+
+	width = dssdev->panel.vm.hactive;
+	height = dssdev->panel.vm.vactive;
+	ret = dssdrv->update(dssdev, 0, 0, width, height);
+	if (ret < 0) {
+		spin_lock_irq(&dev->event_lock);
+		omap_crtc->pending = false;
+		spin_unlock_irq(&dev->event_lock);
+		wake_up(&omap_crtc->pending_wait);
+	}
+}
+
 static void omap_crtc_write_crtc_properties(struct drm_crtc *crtc)
 {
 	struct omap_drm_private *priv = crtc->dev->dev_private;
@@ -411,6 +485,10 @@ static void omap_crtc_enable(struct drm_crtc *crtc)
 
 	DBG("%s", omap_crtc->name);
 
+	/* manual updated display will not trigger vsync irq */
+	if (omap_crtc_is_manually_updated(crtc))
+		return;
+
 	spin_lock_irq(&crtc->dev->event_lock);
 	drm_crtc_vblank_on(crtc);
 	ret = drm_crtc_vblank_get(crtc);
@@ -423,6 +501,7 @@ static void omap_crtc_enable(struct drm_crtc *crtc)
 static void omap_crtc_disable(struct drm_crtc *crtc)
 {
 	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
+	struct drm_device *dev = crtc->dev;
 
 	DBG("%s", omap_crtc->name);
 
@@ -433,6 +512,11 @@ static void omap_crtc_disable(struct drm_crtc *crtc)
 	}
 	spin_unlock_irq(&crtc->dev->event_lock);
 
+	cancel_delayed_work(&omap_crtc->update_work);
+
+	if (!omap_crtc_wait_pending(crtc))
+		dev_warn(dev->dev, "manual display update did not finish!");
+
 	drm_crtc_vblank_off(crtc);
 }
 
@@ -535,13 +619,20 @@ static void omap_crtc_atomic_flush(struct drm_crtc *crtc,
 
 	DBG("%s: GO", omap_crtc->name);
 
-	ret = drm_crtc_vblank_get(crtc);
-	WARN_ON(ret != 0);
+	if (!omap_crtc_is_manually_updated(crtc)) {
+		ret = drm_crtc_vblank_get(crtc);
+		WARN_ON(ret != 0);
 
-	spin_lock_irq(&crtc->dev->event_lock);
-	priv->dispc_ops->mgr_go(omap_crtc->channel);
-	omap_crtc_arm_event(crtc);
-	spin_unlock_irq(&crtc->dev->event_lock);
+		spin_lock_irq(&crtc->dev->event_lock);
+		priv->dispc_ops->mgr_go(omap_crtc->channel);
+		omap_crtc_arm_event(crtc);
+		spin_unlock_irq(&crtc->dev->event_lock);
+	} else {
+		spin_lock_irq(&crtc->dev->event_lock);
+		omap_crtc_flush(crtc);
+		omap_crtc_arm_event(crtc);
+		spin_unlock_irq(&crtc->dev->event_lock);
+	}
 }
 
 static bool omap_crtc_is_plane_prop(struct drm_crtc *crtc,
@@ -677,6 +768,9 @@ struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 	omap_crtc->channel = channel;
 	omap_crtc->name = channel_names[channel];
 
+	INIT_DELAYED_WORK(&omap_crtc->update_work,
+			  omap_crtc_manual_display_update);
+
 	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
 					&omap_crtc_funcs, NULL);
 	if (ret < 0) {
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index f6c48f254c9b..3cb9f9afba16 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -126,6 +126,7 @@ int omap_crtc_wait_pending(struct drm_crtc *crtc);
 void omap_crtc_error_irq(struct drm_crtc *crtc, uint32_t irqstatus);
 void omap_crtc_vblank_irq(struct drm_crtc *crtc);
 void omap_crtc_framedone_irq(struct drm_crtc *crtc, uint32_t irqstatus);
+void omap_crtc_flush(struct drm_crtc *crtc);
 
 struct drm_plane *omap_plane_init(struct drm_device *dev,
 		int idx, enum drm_plane_type type,
diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
index ddf7a457951b..423709132223 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -97,8 +97,28 @@ static void omap_framebuffer_destroy(struct drm_framebuffer *fb)
 	kfree(omap_fb);
 }
 
+static int omap_framebuffer_dirty(struct drm_framebuffer *fb,
+				  struct drm_file *file_priv,
+				  unsigned flags, unsigned color,
+				  struct drm_clip_rect *clips,
+				  unsigned num_clips)
+{
+	struct drm_connector *connector = NULL;
+
+	drm_modeset_lock_all(fb->dev);
+
+	while ((connector = omap_framebuffer_get_next_connector(fb, connector)))
+		if (connector->encoder && connector->encoder->crtc)
+			omap_crtc_flush(connector->encoder->crtc);
+
+	drm_modeset_unlock_all(fb->dev);
+
+	return 0;
+}
+
 static const struct drm_framebuffer_funcs omap_framebuffer_funcs = {
 	.create_handle = omap_framebuffer_create_handle,
+	.dirty = omap_framebuffer_dirty,
 	.destroy = omap_framebuffer_destroy,
 };
 
-- 
2.13.2
