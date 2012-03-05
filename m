From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH 04/10] staging: drm/omap: some minor fb cleanups
Date: Mon,  5 Mar 2012 10:48:34 -0600
Message-ID: <1330966120-28582-5-git-send-email-rob.clark@linaro.org>
References: <1330966120-28582-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58192 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756476Ab2CEQtM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 11:49:12 -0500
Received: by mail-yx0-f174.google.com with SMTP id l12so1739759yen.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 08:49:12 -0800 (PST)
In-Reply-To: <1330966120-28582-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

Now that 'struct drm_plane' has a pixel_format field, use that.  And
fix a minor typo.

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/omap_fb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_fb.c b/drivers/staging/omapdrm/omap_fb.c
index 116a8ff..08e2e35 100644
--- a/drivers/staging/omapdrm/omap_fb.c
+++ b/drivers/staging/omapdrm/omap_fb.c
@@ -101,7 +101,7 @@ static int omap_framebuffer_create_handle(struct drm_framebuffer *fb,
 static void omap_framebuffer_destroy(struct drm_framebuffer *fb)
 {
 	struct omap_framebuffer *omap_fb = to_omap_framebuffer(fb);
-	int i, n = drm_format_num_planes(omap_fb->format->pixel_format);
+	int i, n = drm_format_num_planes(fb->pixel_format);
 
 	DBG("destroy: FB ID: %d (%p)", fb->base.id, fb);
 
@@ -204,7 +204,7 @@ void omap_framebuffer_update_scanout(struct drm_framebuffer *fb, int x, int y,
 struct drm_gem_object *omap_framebuffer_bo(struct drm_framebuffer *fb, int p)
 {
 	struct omap_framebuffer *omap_fb = to_omap_framebuffer(fb);
-	if (p >= drm_format_num_planes(omap_fb->format->pixel_format))
+	if (p >= drm_format_num_planes(fb->pixel_format))
 		return NULL;
 	return omap_fb->planes[p].bo;
 }
@@ -351,8 +351,8 @@ struct drm_framebuffer *omap_framebuffer_init(struct drm_device *dev,
 
 		plane->bo     = bos[i];
 		plane->offset = mode_cmd->offsets[i];
-		plane->pitch  = mode_cmd->pitches[i];
-		plane->paddr  = pitch;
+		plane->pitch  = pitch;
+		plane->paddr  = 0;
 	}
 
 	drm_helper_mode_fill_fb_struct(fb, mode_cmd);
-- 
1.7.5.4

