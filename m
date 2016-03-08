From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 07/23] drm: omapdrm: crtc: switch pending variable to atomic bitset
Date: Tue,  8 Mar 2016 17:39:39 +0100
Message-ID: <1457455195-1938-8-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Having the pending variable available as atomic bit helps
with the later addition of manually updated display support.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 2ed0754ed19e..5ef27664bcfa 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -28,6 +28,11 @@
 
 #define to_omap_crtc(x) container_of(x, struct omap_crtc, base)
 
+enum omap_crtc_state {
+	crtc_enabled	= 0,
+	crtc_pending	= 1
+};
+
 struct omap_crtc {
 	struct drm_crtc base;
 
@@ -49,7 +54,7 @@ struct omap_crtc {
 
 	bool ignore_digit_sync_lost;
 
-	bool pending;
+	unsigned long state;
 	wait_queue_head_t pending_wait;
 };
 
@@ -81,7 +86,7 @@ int omap_crtc_wait_pending(struct drm_crtc *crtc)
 	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
 
 	return wait_event_timeout(omap_crtc->pending_wait,
-				  !omap_crtc->pending,
+				  !test_bit(crtc_pending, &omap_crtc->state),
 				  msecs_to_jiffies(50));
 }
 
@@ -311,10 +316,8 @@ static void omap_crtc_vblank_irq(struct omap_drm_irq *irq, uint32_t irqstatus)
 
 	__omap_irq_unregister(dev, &omap_crtc->vblank_irq);
 
-	rmb();
-	WARN_ON(!omap_crtc->pending);
-	omap_crtc->pending = false;
-	wmb();
+	if (!test_and_clear_bit(crtc_pending, &omap_crtc->state))
+		dev_warn(dev->dev, "pending bit was not set in vblank irq");
 
 	/* wake up userspace */
 	omap_crtc_complete_page_flip(&omap_crtc->base);
@@ -351,13 +354,12 @@ static bool omap_crtc_mode_fixup(struct drm_crtc *crtc,
 static void omap_crtc_enable(struct drm_crtc *crtc)
 {
 	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
+	struct drm_device *dev = crtc->dev;
 
 	DBG("%s", omap_crtc->name);
 
-	rmb();
-	WARN_ON(omap_crtc->pending);
-	omap_crtc->pending = true;
-	wmb();
+	if (test_and_set_bit(crtc_pending, &omap_crtc->state))
+		dev_warn(dev->dev, "crtc enable while pending bit set!");
 
 	omap_irq_register(crtc->dev, &omap_crtc->vblank_irq);
 
@@ -397,6 +399,7 @@ static void omap_crtc_atomic_flush(struct drm_crtc *crtc,
                                   struct drm_crtc_state *old_crtc_state)
 {
 	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
+	struct drm_device *dev = crtc->dev;
 
 	WARN_ON(omap_crtc->vblank_irq.registered);
 
@@ -404,10 +407,8 @@ static void omap_crtc_atomic_flush(struct drm_crtc *crtc,
 
 		DBG("%s: GO", omap_crtc->name);
 
-		rmb();
-		WARN_ON(omap_crtc->pending);
-		omap_crtc->pending = true;
-		wmb();
+		if (test_and_set_bit(crtc_pending, &omap_crtc->state))
+			dev_warn(dev->dev, "atomic flush while pending bit set!");
 
 		dispc_mgr_go(omap_crtc->channel);
 		omap_irq_register(crtc->dev, &omap_crtc->vblank_irq);
@@ -509,6 +510,8 @@ struct drm_crtc *omap_crtc_init(struct drm_device *dev,
 
 	init_waitqueue_head(&omap_crtc->pending_wait);
 
+	omap_crtc->state = 0;
+
 	omap_crtc->channel = channel;
 	omap_crtc->name = channel_names[channel];
 
-- 
2.7.0
