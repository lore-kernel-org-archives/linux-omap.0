From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv3 1/8] drm/omap: add framedone interrupt support
Date: Fri, 30 Mar 2018 19:18:15 +0200
Message-ID: <20180330171822.25896-2-sebastian.reichel@collabora.co.uk>
References: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180330171822.25896-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

This prepares framedone interrupt handling for
manual display update support.

Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 48 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/omapdrm/omap_crtc.h |  1 +
 drivers/gpu/drm/omapdrm/omap_irq.c  | 25 +++++++++++++++++++
 drivers/gpu/drm/omapdrm/omap_irq.h  |  1 +
 4 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 6c4d40b824e4..b893985e4efb 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -51,6 +51,9 @@ struct omap_crtc {
 	bool pending;
 	wait_queue_head_t pending_wait;
 	struct drm_pending_vblank_event *event;
+
+	void (*framedone_handler)(void *);
+	void *framedone_handler_data;
 };
 
 /* -----------------------------------------------------------------------------
@@ -256,6 +259,17 @@ static int omap_crtc_dss_register_framedone(
 		struct omap_drm_private *priv, enum omap_channel channel,
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
 
@@ -263,6 +277,16 @@ static void omap_crtc_dss_unregister_framedone(
 		struct omap_drm_private *priv, enum omap_channel channel,
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
@@ -330,6 +354,30 @@ void omap_crtc_vblank_irq(struct drm_crtc *crtc)
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
diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.h b/drivers/gpu/drm/omapdrm/omap_crtc.h
index eaab2d7f0324..c748adc91665 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.h
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.h
@@ -39,5 +39,6 @@ struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 int omap_crtc_wait_pending(struct drm_crtc *crtc);
 void omap_crtc_error_irq(struct drm_crtc *crtc, u32 irqstatus);
 void omap_crtc_vblank_irq(struct drm_crtc *crtc);
+void omap_crtc_framedone_irq(struct drm_crtc *crtc, uint32_t irqstatus);
 
 #endif /* __OMAPDRM_CRTC_H__ */
diff --git a/drivers/gpu/drm/omapdrm/omap_irq.c b/drivers/gpu/drm/omapdrm/omap_irq.c
index c85115049f86..0171e5e74aac 100644
--- a/drivers/gpu/drm/omapdrm/omap_irq.c
+++ b/drivers/gpu/drm/omapdrm/omap_irq.c
@@ -85,6 +85,28 @@ int omap_irq_wait(struct drm_device *dev, struct omap_irq_wait *wait,
 	return ret == 0 ? -1 : 0;
 }
 
+int omap_irq_enable_framedone(struct drm_crtc *crtc, bool enable)
+{
+	struct drm_device *dev = crtc->dev;
+	struct omap_drm_private *priv = dev->dev_private;
+	unsigned long flags;
+	enum omap_channel channel = omap_crtc_channel(crtc);
+	int framedone_irq =
+		priv->dispc_ops->mgr_get_framedone_irq(priv->dispc, channel);
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
@@ -217,6 +239,9 @@ static irqreturn_t omap_irq_handler(int irq, void *arg)
 
 		if (irqstatus & priv->dispc_ops->mgr_get_sync_lost_irq(priv->dispc, channel))
 			omap_crtc_error_irq(crtc, irqstatus);
+
+		if (irqstatus & priv->dispc_ops->mgr_get_framedone_irq(priv->dispc, channel))
+			omap_crtc_framedone_irq(crtc, irqstatus);
 	}
 
 	omap_irq_ocp_error_handler(dev, irqstatus);
diff --git a/drivers/gpu/drm/omapdrm/omap_irq.h b/drivers/gpu/drm/omapdrm/omap_irq.h
index 9d5441468eca..02abb4ed9813 100644
--- a/drivers/gpu/drm/omapdrm/omap_irq.h
+++ b/drivers/gpu/drm/omapdrm/omap_irq.h
@@ -27,6 +27,7 @@ struct drm_device;
 struct omap_irq_wait;
 
 int omap_irq_enable_vblank(struct drm_crtc *crtc);
+int omap_irq_enable_framedone(struct drm_crtc *crtc, bool enable);
 void omap_irq_disable_vblank(struct drm_crtc *crtc);
 void omap_drm_irq_uninstall(struct drm_device *dev);
 int omap_drm_irq_install(struct drm_device *dev);
-- 
2.16.2
