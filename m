From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/21] drm/omap: page_flip: return -EBUSY if flip pending
Date: Thu, 26 Feb 2015 15:20:10 +0200
Message-ID: <1424956829-22892-3-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33254 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753796AbbBZNVC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 08:21:02 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

The DRM documentation says:

"If a page flip is already pending, the page_flip operation must return
-EBUSY."

Currently omapdrm returns -EINVAL instead. Fix omapdrm by returning
-EBUSY.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index b0566a1ca28f..af4b230b5269 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -361,7 +361,7 @@ static int omap_crtc_page_flip_locked(struct drm_crtc *crtc,
 	if (omap_crtc->old_fb) {
 		spin_unlock_irqrestore(&dev->event_lock, flags);
 		dev_err(dev->dev, "already a pending flip\n");
-		return -EINVAL;
+		return -EBUSY;
 	}
 
 	omap_crtc->event = event;
-- 
2.3.0

