From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 15/21] drm/omap: use DRM_ERROR_RATELIMITED() for error irqs
Date: Thu, 26 Feb 2015 15:20:23 +0200
Message-ID: <1424956829-22892-16-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50962 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753826AbbBZNVX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 08:21:23 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapdrm uses normal DRM_ERROR() print when the HW reports an error. As
we sometimes may get a flood of errors, let's rather use
DRM_ERROR_RATELIMITED().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c  | 2 +-
 drivers/gpu/drm/omapdrm/omap_plane.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index af4b230b5269..832fb9e38612 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -429,7 +429,7 @@ static void omap_crtc_error_irq(struct omap_drm_irq *irq, uint32_t irqstatus)
 	struct omap_crtc *omap_crtc =
 			container_of(irq, struct omap_crtc, error_irq);
 	struct drm_crtc *crtc = &omap_crtc->base;
-	DRM_ERROR("%s: errors: %08x\n", omap_crtc->name, irqstatus);
+	DRM_ERROR_RATELIMITED("%s: errors: %08x\n", omap_crtc->name, irqstatus);
 	/* avoid getting in a flood, unregister the irq until next vblank */
 	__omap_irq_unregister(crtc->dev, &omap_crtc->error_irq);
 }
diff --git a/drivers/gpu/drm/omapdrm/omap_plane.c b/drivers/gpu/drm/omapdrm/omap_plane.c
index 8e94694ba8a3..dc666f6b2bf8 100644
--- a/drivers/gpu/drm/omapdrm/omap_plane.c
+++ b/drivers/gpu/drm/omapdrm/omap_plane.c
@@ -386,7 +386,8 @@ static void omap_plane_error_irq(struct omap_drm_irq *irq, uint32_t irqstatus)
 {
 	struct omap_plane *omap_plane =
 			container_of(irq, struct omap_plane, error_irq);
-	DRM_ERROR("%s: errors: %08x\n", omap_plane->name, irqstatus);
+	DRM_ERROR_RATELIMITED("%s: errors: %08x\n", omap_plane->name,
+		irqstatus);
 }
 
 static const char *plane_names[] = {
-- 
2.3.0

