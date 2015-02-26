From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 16/21] drm/omap: fix race with error_irq
Date: Thu, 26 Feb 2015 15:20:24 +0200
Message-ID: <1424956829-22892-17-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33290 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753847AbbBZNVZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 08:21:25 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapdrm tries to avoid error floods by unregistering the error irq when
an error happens, and then registering the error irq again later.
However, the code is racy, as it sometimes tries to unregister the error
irq when it's already unregistered, leading to WARN().

Also, the code only registers the error irq again when something is done
on that particular output, i.e. if only TV is used to flip the buffers,
and LCD is showing a same buffer, an error on LCD will cause the LCD
error irq to be unregistered and never registered again.

To fix this, let's keep the error irqs always enabled and trust the
DRM_ERROR_RATELIMITED to limit the flood.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 832fb9e38612..2175b9b7c725 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -74,6 +74,8 @@ struct omap_crtc {
 	 * XXX maybe fold into apply_work??
 	 */
 	struct work_struct page_flip_work;
+
+	bool ignore_digit_sync_lost;
 };
 
 uint32_t pipe2vbl(struct drm_crtc *crtc)
@@ -428,10 +430,14 @@ static void omap_crtc_error_irq(struct omap_drm_irq *irq, uint32_t irqstatus)
 {
 	struct omap_crtc *omap_crtc =
 			container_of(irq, struct omap_crtc, error_irq);
-	struct drm_crtc *crtc = &omap_crtc->base;
+
+	if (omap_crtc->ignore_digit_sync_lost) {
+		irqstatus &= ~DISPC_IRQ_SYNC_LOST_DIGIT;
+		if (!irqstatus)
+			return;
+	}
+
 	DRM_ERROR_RATELIMITED("%s: errors: %08x\n", omap_crtc->name, irqstatus);
-	/* avoid getting in a flood, unregister the irq until next vblank */
-	__omap_irq_unregister(crtc->dev, &omap_crtc->error_irq);
 }
 
 static void omap_crtc_apply_irq(struct omap_drm_irq *irq, uint32_t irqstatus)
@@ -440,9 +446,6 @@ static void omap_crtc_apply_irq(struct omap_drm_irq *irq, uint32_t irqstatus)
 			container_of(irq, struct omap_crtc, apply_irq);
 	struct drm_crtc *crtc = &omap_crtc->base;
 
-	if (!omap_crtc->error_irq.registered)
-		__omap_irq_register(crtc->dev, &omap_crtc->error_irq);
-
 	if (!dispc_mgr_go_busy(omap_crtc->channel)) {
 		struct omap_drm_private *priv =
 				crtc->dev->dev_private;
@@ -558,7 +561,7 @@ static void set_enabled(struct drm_crtc *crtc, bool enable)
 	 * Digit output produces some sync lost interrupts during the first
 	 * frame when enabling, so we need to ignore those.
 	 */
-	omap_irq_unregister(crtc->dev, &omap_crtc->error_irq);
+	omap_crtc->ignore_digit_sync_lost = true;
 
 	framedone_irq = dispc_mgr_get_framedone_irq(channel);
 	vsync_irq = dispc_mgr_get_vsync_irq(channel);
@@ -589,7 +592,9 @@ static void set_enabled(struct drm_crtc *crtc, bool enable)
 				omap_crtc->name, enable ? "enable" : "disable");
 	}
 
-	omap_irq_register(crtc->dev, &omap_crtc->error_irq);
+	omap_crtc->ignore_digit_sync_lost = false;
+	/* make sure the irq handler sees the value above */
+	mb();
 }
 
 static void omap_crtc_pre_apply(struct omap_drm_apply *apply)
-- 
2.3.0

