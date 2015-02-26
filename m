From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 21/21] drm/omap: keep ref to old_fb
Date: Thu, 26 Feb 2015 15:20:29 +0200
Message-ID: <1424956829-22892-22-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38356 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbbBZNVd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2015 08:21:33 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

We store the fb being page-flipped to 'old_fb' field, but we don't
increase the ref count of the fb when doing that. While I am not
sure if it can cause problem in practice, it's still safer to keep a ref
when storing a pointer to a fb.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_crtc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 4b06c039e9af..faa20fbc2ad9 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -301,6 +301,7 @@ static void vblank_cb(void *arg)
 	struct drm_device *dev = crtc->dev;
 	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
 	unsigned long flags;
+	struct drm_framebuffer *fb;
 
 	spin_lock_irqsave(&dev->event_lock, flags);
 
@@ -308,10 +309,15 @@ static void vblank_cb(void *arg)
 	if (omap_crtc->event)
 		drm_send_vblank_event(dev, omap_crtc->pipe, omap_crtc->event);
 
+	fb = omap_crtc->old_fb;
+
 	omap_crtc->event = NULL;
 	omap_crtc->old_fb = NULL;
 
 	spin_unlock_irqrestore(&dev->event_lock, flags);
+
+	if (fb)
+		drm_framebuffer_unreference(fb);
 }
 
 static void page_flip_worker(struct work_struct *work)
@@ -368,6 +374,7 @@ static int omap_crtc_page_flip_locked(struct drm_crtc *crtc,
 
 	omap_crtc->event = event;
 	omap_crtc->old_fb = primary->fb = fb;
+	drm_framebuffer_reference(omap_crtc->old_fb);
 
 	spin_unlock_irqrestore(&dev->event_lock, flags);
 
-- 
2.3.0

