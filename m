From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH] drm/omap: fix issue w/ fb attached to multiple CRTCs
Date: Fri, 12 Oct 2012 18:58:02 -0500
Message-ID: <1350086282-12463-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:46457 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437Ab2JLX7Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Oct 2012 19:59:16 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3374903obb.19
        for <linux-omap@vger.kernel.org>; Fri, 12 Oct 2012 16:59:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

When the fb is detached from one CRTC/plane, paddr was set back to
zero.  But really we don't want to do this because the fb could still
be attached to other CRTC/plane(s).  This originally worked like this
to catch cases of freeing a pinned fb (but with the refcnt'ing this
should no longer be needed).  Also, there is checking in the GEM code
for freeing a pinned GEM object, so this extra level of checking is
redundant.

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/omap_fb.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_fb.c b/drivers/staging/omapdrm/omap_fb.c
index 446801d..75d2ff1 100644
--- a/drivers/staging/omapdrm/omap_fb.c
+++ b/drivers/staging/omapdrm/omap_fb.c
@@ -253,6 +253,7 @@ int omap_framebuffer_replace(struct drm_framebuffer *a,
 	int ret = 0, i, na, nb;
 	struct omap_framebuffer *ofba = to_omap_framebuffer(a);
 	struct omap_framebuffer *ofbb = to_omap_framebuffer(b);
+	uint32_t pinned_mask = 0;
 
 	na = a ? drm_format_num_planes(a->pixel_format) : 0;
 	nb = b ? drm_format_num_planes(b->pixel_format) : 0;
@@ -263,25 +264,24 @@ int omap_framebuffer_replace(struct drm_framebuffer *a,
 		pa = (i < na) ? &ofba->planes[i] : NULL;
 		pb = (i < nb) ? &ofbb->planes[i] : NULL;
 
-		if (pa) {
+		if (pa)
 			unpin(arg, pa->bo);
-			pa->paddr = 0;
-		}
 
 		if (pb && !ret) {
 			ret = omap_gem_get_paddr(pb->bo, &pb->paddr, true);
-			if (!ret)
+			if (!ret) {
 				omap_gem_dma_sync(pb->bo, DMA_TO_DEVICE);
+				pinned_mask |= (1 << i);
+			}
 		}
 	}
 
 	if (ret) {
 		/* something went wrong.. unpin what has been pinned */
 		for (i = 0; i < nb; i++) {
-			struct plane *pb = &ofba->planes[i];
-			if (pb->paddr) {
+			if (pinned_mask & (1 << i)) {
+				struct plane *pb = &ofba->planes[i];
 				unpin(arg, pb->bo);
-				pb->paddr = 0;
 			}
 		}
 	}
-- 
1.7.9.5

