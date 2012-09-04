From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH] drm/omap: hold a ref to the bo while waiting for flip
Date: Tue,  4 Sep 2012 17:46:22 -0500
Message-ID: <1346798782-22033-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50987 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757824Ab2IDWq0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Sep 2012 18:46:26 -0400
Received: by yenl14 with SMTP id l14so1502228yen.19
        for <linux-omap@vger.kernel.org>; Tue, 04 Sep 2012 15:46:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

Since the plane hasn't yet taken a reference, we need to hold a
reference while waiting to ensure the backing GEM bo doesn't get
freed from under us.

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/omap_crtc.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_crtc.c b/drivers/staging/omapdrm/omap_crtc.c
index dade3de..732f2ad 100644
--- a/drivers/staging/omapdrm/omap_crtc.c
+++ b/drivers/staging/omapdrm/omap_crtc.c
@@ -155,6 +155,7 @@ static void page_flip_cb(void *arg)
 	struct drm_crtc *crtc = arg;
 	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
 	struct drm_framebuffer *old_fb = omap_crtc->old_fb;
+	struct drm_gem_object *bo;
 
 	omap_crtc->old_fb = NULL;
 
@@ -165,6 +166,9 @@ static void page_flip_cb(void *arg)
 	 * cycle.. for now go for correctness and later figure out speed..
 	 */
 	omap_plane_on_endwin(omap_crtc->plane, vblank_cb, crtc);
+
+	bo = omap_framebuffer_bo(crtc->fb, 0);
+	drm_gem_object_unreference_unlocked(bo);
 }
 
 static int omap_crtc_page_flip_locked(struct drm_crtc *crtc,
@@ -173,6 +177,7 @@ static int omap_crtc_page_flip_locked(struct drm_crtc *crtc,
 {
 	struct drm_device *dev = crtc->dev;
 	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
+	struct drm_gem_object *bo;
 
 	DBG("%d -> %d", crtc->fb ? crtc->fb->base.id : -1, fb->base.id);
 
@@ -185,8 +190,15 @@ static int omap_crtc_page_flip_locked(struct drm_crtc *crtc,
 	omap_crtc->event = event;
 	crtc->fb = fb;
 
-	omap_gem_op_async(omap_framebuffer_bo(fb, 0), OMAP_GEM_READ,
-			page_flip_cb, crtc);
+	/*
+	 * Hold a reference temporarily until the crtc is updated
+	 * and takes the reference to the bo.  This avoids it
+	 * getting freed from under us:
+	 */
+	bo = omap_framebuffer_bo(fb, 0);
+	drm_gem_object_reference(bo);
+
+	omap_gem_op_async(bo, OMAP_GEM_READ, page_flip_cb, crtc);
 
 	return 0;
 }
-- 
1.7.9.5

