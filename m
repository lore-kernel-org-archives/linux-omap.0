From: Archit Taneja <archit@ti.com>
Subject: [PATCH] drm/omap: Take a fb reference in omap_plane_update()
Date: Tue, 9 Apr 2013 17:56:02 +0530
Message-ID: <1365510362-18379-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45896 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759154Ab3DIM1E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 08:27:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: robdclark@gmail.com
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>

When userspace calls SET_PLANE ioctl, drm core takes a reference of the fb and
passes control to the update_plane op defined by the drm driver.

In omapdrm, we have a worker thread which queues framebuffers objects received
from update_plane and displays them at the appropriate time.

It is possible that the framebuffer is destoryed by userspace between the time
of calling the ioctl and apply-worker being scheduled. If this happens, the
apply-worker holds a pointer to a framebuffer which is already destroyed.

Take an extra refernece/unreference of the fb in omap_plane_update() to prevent
this from happening. A reference is taken of the fb passed to update_plane(),
the previous framebuffer (held by plane->fb) is unreferenced. This will prevent
drm from destroying the framebuffer till the time it's unreferenced by the
apply-worker.

This is in addition to the exisitng reference/unreference in update_pin(),
which is taken for the scanout of the plane's current framebuffer, and an
unreference the previous framebuffer.

Signed-off-by: Archit Taneja <archit@ti.com>
Cc: Rob Clark <robdclark@gmail.com>
---
 drivers/gpu/drm/omapdrm/omap_plane.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_plane.c b/drivers/gpu/drm/omapdrm/omap_plane.c
index 2882cda..8d225d7 100644
--- a/drivers/gpu/drm/omapdrm/omap_plane.c
+++ b/drivers/gpu/drm/omapdrm/omap_plane.c
@@ -247,6 +247,12 @@ static int omap_plane_update(struct drm_plane *plane,
 {
 	struct omap_plane *omap_plane = to_omap_plane(plane);
 	omap_plane->enabled = true;
+
+	if (plane->fb)
+		drm_framebuffer_unreference(plane->fb);
+
+	drm_framebuffer_reference(fb);
+
 	return omap_plane_mode_set(plane, crtc, fb,
 			crtc_x, crtc_y, crtc_w, crtc_h,
 			src_x, src_y, src_w, src_h,
-- 
1.7.10.4

