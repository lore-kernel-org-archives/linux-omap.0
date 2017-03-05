From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 08/10] drm: omapdrm: crtc: handle framedone directly
Date: Sun,  5 Mar 2017 01:43:07 +0100
Message-ID: <20170305004309.28259-8-sre@kernel.org>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170305004309.28259-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

We can handle framedone interrupt directly simlar to commit
e0519af75d6e ("drm: omapdrm: Handle CRTC error IRQs directly").

By default we just print a warning on framedone and do nothing.
Any manually refreshed displays can register a callback.

Signed-off-by: Tony Lindgren <tony@atomide.com>
[Drop REVISIT comment for omap3, patch works on N950]
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/omapdrm/omap_drv.h  |  1 +
 drivers/gpu/drm/omapdrm/omap_irq.c  |  7 ++++++-
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 432ad6023f27..4601533215d6 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -349,6 +349,31 @@ void omap_crtc_vblank_irq(struct drm_crtc *crtc)
 	DBG("%s: apply done", omap_crtc->name);
 }
 
+void omap_crtc_framedone_irq(struct drm_crtc *crtc, uint32_t irqstatus)
+{
+	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
+
+	if (!omap_crtc->framedone_handler) {
+		dev_warn(omap_crtc->base.dev->dev, "no framedone handler?\n");
+
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
 void omap_crtc_flush(struct drm_crtc *crtc,
 		int x, int y, int w, int h)
 {
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index 71b5c5e25ee4..9586551960e9 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -138,6 +138,7 @@ struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 		struct drm_plane *plane, enum omap_channel channel, int id);
 int omap_crtc_wait_pending(struct drm_crtc *crtc);
 void omap_crtc_error_irq(struct drm_crtc *crtc, uint32_t irqstatus);
+void omap_crtc_framedone_irq(struct drm_crtc *crtc, uint32_t irqstatus);
 void omap_crtc_vblank_irq(struct drm_crtc *crtc);
 bool omap_crtc_is_manual_updated(struct drm_crtc *crtc);
 
diff --git a/drivers/gpu/drm/omapdrm/omap_irq.c b/drivers/gpu/drm/omapdrm/omap_irq.c
index 9adfa7c99695..fb39601721f6 100644
--- a/drivers/gpu/drm/omapdrm/omap_irq.c
+++ b/drivers/gpu/drm/omapdrm/omap_irq.c
@@ -215,6 +215,9 @@ static irqreturn_t omap_irq_handler(int irq, void *arg)
 
 		if (irqstatus & dispc_mgr_get_sync_lost_irq(channel))
 			omap_crtc_error_irq(crtc, irqstatus);
+
+		if (irqstatus & dispc_mgr_get_framedone_irq(channel))
+			omap_crtc_framedone_irq(crtc, irqstatus);
 	}
 
 	omap_irq_ocp_error_handler(irqstatus);
@@ -264,8 +267,10 @@ int omap_drm_irq_install(struct drm_device *dev)
 			priv->irq_mask |= omap_underflow_irqs[i];
 	}
 
-	for (i = 0; i < num_mgrs; ++i)
+	for (i = 0; i < num_mgrs; ++i) {
 		priv->irq_mask |= dispc_mgr_get_sync_lost_irq(i);
+		priv->irq_mask |= dispc_mgr_get_framedone_irq(i);
+	}
 
 	dispc_runtime_get();
 	dispc_clear_irqstatus(0xffffffff);
-- 
2.11.0
