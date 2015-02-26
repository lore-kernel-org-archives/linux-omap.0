From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/21] drm/omap: fix error handling in omap_framebuffer_create()
Date: Thu, 26 Feb 2015 15:20:16 +0200
Message-ID: <1424956829-22892-9-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38320 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932314AbbBZNVL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2015 08:21:11 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

When an error happens in omap_framebuffer_create(),
omap_framebuffer_create() calls omap_framebuffer_destroy() if the fb
struct has been allocated. However, that crashes, as
omap_framebuffer_destroy(), which calls drm_framebuffer_cleanup(),
should only be called after drm_framebuffer_init()

Fix this by just calling kfree() for the allocated fb when an error
happens.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_fb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
index 58f2af32ede8..2975096abdf5 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -420,7 +420,7 @@ struct drm_framebuffer *omap_framebuffer_create(struct drm_device *dev,
 struct drm_framebuffer *omap_framebuffer_init(struct drm_device *dev,
 		struct drm_mode_fb_cmd2 *mode_cmd, struct drm_gem_object **bos)
 {
-	struct omap_framebuffer *omap_fb;
+	struct omap_framebuffer *omap_fb = NULL;
 	struct drm_framebuffer *fb = NULL;
 	const struct format *format = NULL;
 	int ret, i, n = drm_format_num_planes(mode_cmd->pixel_format);
@@ -491,8 +491,7 @@ struct drm_framebuffer *omap_framebuffer_init(struct drm_device *dev,
 	return fb;
 
 fail:
-	if (fb)
-		omap_framebuffer_destroy(fb);
+	kfree(omap_fb);
 
 	return ERR_PTR(ret);
 }
-- 
2.3.0

