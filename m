From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 17/21] drm/omap: only ignore DIGIT SYNC LOST for TV output
Date: Thu, 26 Feb 2015 15:20:25 +0200
Message-ID: <1424956829-22892-18-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34698 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932380AbbBZNV1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 08:21:27 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

We need to ignore DIGIT SYNC LOST error when enabling/disabling TV
output. The code does that, but it ignores the DIGI SYNC LOST when
enabling any output. Normally this does no harm, but it could make us
miss DIGIT SYNC LOST on some rare occasions.

Fix the code to only ignore DIGIT SYNC LOST when enabling/disabling TV.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 2175b9b7c725..4b06c039e9af 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -557,11 +557,13 @@ static void set_enabled(struct drm_crtc *crtc, bool enable)
 	if (dispc_mgr_is_enabled(channel) == enable)
 		return;
 
-	/*
-	 * Digit output produces some sync lost interrupts during the first
-	 * frame when enabling, so we need to ignore those.
-	 */
-	omap_crtc->ignore_digit_sync_lost = true;
+	if (omap_crtc->channel == OMAP_DSS_CHANNEL_DIGIT) {
+		/*
+		 * Digit output produces some sync lost interrupts during the
+		 * first frame when enabling, so we need to ignore those.
+		 */
+		omap_crtc->ignore_digit_sync_lost = true;
+	}
 
 	framedone_irq = dispc_mgr_get_framedone_irq(channel);
 	vsync_irq = dispc_mgr_get_vsync_irq(channel);
@@ -592,9 +594,11 @@ static void set_enabled(struct drm_crtc *crtc, bool enable)
 				omap_crtc->name, enable ? "enable" : "disable");
 	}
 
-	omap_crtc->ignore_digit_sync_lost = false;
-	/* make sure the irq handler sees the value above */
-	mb();
+	if (omap_crtc->channel == OMAP_DSS_CHANNEL_DIGIT) {
+		omap_crtc->ignore_digit_sync_lost = false;
+		/* make sure the irq handler sees the value above */
+		mb();
+	}
 }
 
 static void omap_crtc_pre_apply(struct omap_drm_apply *apply)
-- 
2.3.0

