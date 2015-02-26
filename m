From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/21] drm/omap: add pin refcounting to omap_framebuffer
Date: Thu, 26 Feb 2015 15:20:12 +0200
Message-ID: <1424956829-22892-5-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33261 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753796AbbBZNVE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 08:21:04 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

omap_framebuffer_pin() and omap_framebuffer_unpin() are currently
broken, as they cannot be called multiple times (i.e. pin, pin, unpin,
unpin), which is what happens in certain cases. This issue causes the
driver to possibly use 0 as an address for a displayed buffer, leading
to OCP error from DSS.

This patch fixes the issue by adding a simple pin_count, used to track
the number of pins.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_fb.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
index 2a5cacdc344b..58f2af32ede8 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -86,6 +86,7 @@ struct plane {
 
 struct omap_framebuffer {
 	struct drm_framebuffer base;
+	int pin_count;
 	const struct format *format;
 	struct plane planes[4];
 };
@@ -261,6 +262,11 @@ int omap_framebuffer_pin(struct drm_framebuffer *fb)
 	struct omap_framebuffer *omap_fb = to_omap_framebuffer(fb);
 	int ret, i, n = drm_format_num_planes(fb->pixel_format);
 
+	if (omap_fb->pin_count > 0) {
+		omap_fb->pin_count++;
+		return 0;
+	}
+
 	for (i = 0; i < n; i++) {
 		struct plane *plane = &omap_fb->planes[i];
 		ret = omap_gem_get_paddr(plane->bo, &plane->paddr, true);
@@ -269,6 +275,8 @@ int omap_framebuffer_pin(struct drm_framebuffer *fb)
 		omap_gem_dma_sync(plane->bo, DMA_TO_DEVICE);
 	}
 
+	omap_fb->pin_count++;
+
 	return 0;
 
 fail:
@@ -287,6 +295,11 @@ int omap_framebuffer_unpin(struct drm_framebuffer *fb)
 	struct omap_framebuffer *omap_fb = to_omap_framebuffer(fb);
 	int ret, i, n = drm_format_num_planes(fb->pixel_format);
 
+	omap_fb->pin_count--;
+
+	if (omap_fb->pin_count > 0)
+		return 0;
+
 	for (i = 0; i < n; i++) {
 		struct plane *plane = &omap_fb->planes[i];
 		ret = omap_gem_put_paddr(plane->bo);
-- 
2.3.0

