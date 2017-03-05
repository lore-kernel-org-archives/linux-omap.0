From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCHv2 09/10] drm: omapdrm: crtc: get manual mode displays working
Date: Sun,  5 Mar 2017 01:43:08 +0100
Message-ID: <20170305004309.28259-9-sre@kernel.org>
References: <20170304235021.27055-1-sre@kernel.org>
 <20170305004309.28259-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170305004309.28259-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

With manual mode displays we need to flush the panel manually.

Let's add flushing so we get Tomi's fbtest, kmstest, kmstest --flip,
and X and wayland working.

Signed-off-by: Tony Lindgren <tony@atomide.com>
[On Nokia N950]
Tested-By: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 4601533215d6..e07b0a0be4bf 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -97,6 +97,11 @@ bool omap_crtc_is_manual_updated(struct drm_crtc *crtc)
 	return omap_crtc->manually_updated;
 }
 
+static void omap_crtc_manual_needs_flush(struct drm_crtc *crtc)
+{
+	omap_crtc_flush(crtc, 0, 0, 0, 0);
+}
+
 /* -----------------------------------------------------------------------------
  * DSS Manager Functions
  */
@@ -139,7 +144,11 @@ static void omap_crtc_dss_disconnect(enum omap_channel channel,
 
 static void omap_crtc_dss_start_update(enum omap_channel channel)
 {
+	struct omap_crtc *omap_crtc = omap_crtcs[channel];
+	struct drm_crtc *crtc = &omap_crtc->base;
+
 	dispc_mgr_enable(channel, true);
+	omap_crtc_manual_needs_flush(crtc);
 }
 
 /* Called only from the encoder enable/disable and suspend/resume handlers. */
@@ -155,11 +164,12 @@ static void omap_crtc_set_enabled(struct drm_crtc *crtc, bool enable)
 	if (WARN_ON(omap_crtc->enabled == enable))
 		return;
 
-	if (omap_crtc_output[channel]->output_type == OMAP_DISPLAY_TYPE_HDMI) {
-		dispc_mgr_enable(channel, enable);
-		omap_crtc->enabled = enable;
+	dispc_mgr_enable(channel, enable);
+	omap_crtc->enabled = enable;
+	omap_crtc_manual_needs_flush(crtc);
+
+	if (omap_crtc_output[channel]->output_type == OMAP_DISPLAY_TYPE_HDMI)
 		return;
-	}
 
 	if (omap_crtc->channel == OMAP_DSS_CHANNEL_DIGIT) {
 		/*
@@ -190,9 +200,6 @@ static void omap_crtc_set_enabled(struct drm_crtc *crtc, bool enable)
 			wait = omap_irq_wait_init(dev, vsync_irq, 2);
 	}
 
-	dispc_mgr_enable(channel, enable);
-	omap_crtc->enabled = enable;
-
 	ret = omap_irq_wait(dev, wait, msecs_to_jiffies(100));
 	if (ret) {
 		dev_err(dev->dev, "%s: timeout waiting for %s\n",
@@ -554,6 +561,7 @@ static void omap_crtc_atomic_flush(struct drm_crtc *crtc,
 		ret = drm_crtc_vblank_get(crtc);
 		WARN_ON(ret != 0);
 	}
+	omap_crtc_flush(&omap_crtc->base, 0, 0, 0, 0);
 
 	spin_lock_irq(&crtc->dev->event_lock);
 	dispc_mgr_enable(omap_crtc->channel, true);
-- 
2.11.0
