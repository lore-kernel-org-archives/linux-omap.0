From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv1 04/14] drm/omap: add framedone interrupt support
Date: Mon, 24 Jul 2017 19:33:01 +0200
Message-ID: <20170724173311.27170-5-sebastian.reichel@collabora.co.uk>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

This prepares framedone interrupt handling for
manual display update support.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 48 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/omapdrm/omap_drv.h  |  2 ++
 drivers/gpu/drm/omapdrm/omap_irq.c  | 24 +++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index dd0ef40ca469..404652ad8a6d 100644
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
@@ -238,6 +241,17 @@ static int omap_crtc_dss_register_framedone(
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
 
@@ -245,6 +259,16 @@ static void omap_crtc_dss_unregister_framedone(
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
@@ -312,6 +336,30 @@ void omap_crtc_vblank_irq(struct drm_crtc *crtc)
 	DBG("%s: apply done", omap_crtc->name);
 }
 
+void omap_crtc_framedone_irq(struct drm_crtc *crtc, uint32_t irqstatus)
+{
+	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
+
+	if (!omap_crtc->framedone_handler) {
+		dev_warn(omap_crtc->base.dev->dev, "no framedone handler?");
+		return;
+	}
+
+	omap_crtc->framedone_handler(omap_crtc->framedone_handler_data);
+
+	spin_lock(&crtc->dev->event_lock);
+	/* Send the vblank event if one has been requested. */
+	if (omap_crtc->event) {
+		drm_crtc_send_vblank_event(crtc, omap_crtc->event);
+		omap_crtc->event = NULL;
+	}
+	omap_crtc->pending = false;
+	spin_unlock(&crtc->dev->event_lock);
+
+	/* Wake up omap_atomic_complete. */
+	wake_up(&omap_crtc->pending_wait);
+}
+
 static void omap_crtc_write_crtc_properties(struct drm_crtc *crtc)
 {
 	struct omap_drm_private *priv = crtc->dev->dev_private;
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index 4bd1e9070b31..22f3d94994d2 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -97,6 +97,7 @@ void omap_gem_describe_objects(struct list_head *list, struct seq_file *m);
 int omap_gem_resume(struct device *dev);
 #endif
 
+int omap_irq_enable_framedone(struct drm_crtc *crtc, bool enable);
 int omap_irq_enable_vblank(struct drm_crtc *crtc);
 void omap_irq_disable_vblank(struct drm_crtc *crtc);
 void omap_drm_irq_uninstall(struct drm_device *dev);
@@ -124,6 +125,7 @@ struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 int omap_crtc_wait_pending(struct drm_crtc *crtc);
 void omap_crtc_error_irq(struct drm_crtc *crtc, uint32_t irqstatus);
 void omap_crtc_vblank_irq(struct drm_crtc *crtc);
+void omap_crtc_framedone_irq(struct drm_crtc *crtc, uint32_t irqstatus);
 
 struct drm_plane *omap_plane_init(struct drm_device *dev,
 		int idx, enum drm_plane_type type,
diff --git a/drivers/gpu/drm/omapdrm/omap_irq.c b/drivers/gpu/drm/omapdrm/omap_irq.c
index 013b0bba712f..301c0e7a70b7 100644
--- a/drivers/gpu/drm/omapdrm/omap_irq.c
+++ b/drivers/gpu/drm/omapdrm/omap_irq.c
@@ -87,6 +87,27 @@ int omap_irq_wait(struct drm_device *dev, struct omap_irq_wait *wait,
 	return ret == 0 ? -1 : 0;
 }
 
+int omap_irq_enable_framedone(struct drm_crtc *crtc, bool enable)
+{
+	struct drm_device *dev = crtc->dev;
+	struct omap_drm_private *priv = dev->dev_private;
+	unsigned long flags;
+	enum omap_channel channel = omap_crtc_channel(crtc);
+	int framedone_irq = priv->dispc_ops->mgr_get_framedone_irq(channel);
+
+	DBG("dev=%p, crtc=%u, enable=%d", dev, channel, enable);
+
+	spin_lock_irqsave(&priv->wait_lock, flags);
+	if (enable)
+		priv->irq_mask |= framedone_irq;
+	else
+		priv->irq_mask &= ~framedone_irq;
+	omap_irq_update(dev);
+	spin_unlock_irqrestore(&priv->wait_lock, flags);
+
+	return 0;
+}
+
 /**
  * enable_vblank - enable vblank interrupt events
  * @dev: DRM device
@@ -217,6 +238,9 @@ static irqreturn_t omap_irq_handler(int irq, void *arg)
 
 		if (irqstatus & priv->dispc_ops->mgr_get_sync_lost_irq(channel))
 			omap_crtc_error_irq(crtc, irqstatus);
+
+		if (irqstatus & priv->dispc_ops->mgr_get_framedone_irq(channel))
+			omap_crtc_framedone_irq(crtc, irqstatus);
 	}
 
 	omap_irq_ocp_error_handler(dev, irqstatus);
-- 
2.13.2
