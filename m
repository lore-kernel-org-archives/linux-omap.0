From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/21] drm/omap: check CRTC color format earlier
Date: Thu, 26 Feb 2015 15:20:14 +0200
Message-ID: <1424956829-22892-7-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38311 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932279AbbBZNVI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2015 08:21:08 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

When setting a color format to a DRM plane, the DRM core checks whether
the format is supported by the HW. However, it seems that when setting
the color format of a CRTC (i.e. a root plane), there's no checking
done. This causes omapdrm to configure omapdss with the bad color
format, which omapdss then rejects.

While the above is ok, the error message is a bit confusing, and the
configuring of omapdss happens asynchronously from the ioctl that does
the color format change.

This patch adds a color format check to omap_plane_mode_set() which
causes the ioctl to return an error for invalid color format. This means
that the userspace will get to know of the wrong setting, instead of the
current behavior where the error is not seen by the userspace.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_plane.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_plane.c b/drivers/gpu/drm/omapdrm/omap_plane.c
index 1f4f2b866379..bedd6f7af0f1 100644
--- a/drivers/gpu/drm/omapdrm/omap_plane.c
+++ b/drivers/gpu/drm/omapdrm/omap_plane.c
@@ -207,6 +207,24 @@ int omap_plane_mode_set(struct drm_plane *plane,
 {
 	struct omap_plane *omap_plane = to_omap_plane(plane);
 	struct omap_drm_window *win = &omap_plane->win;
+	int i;
+
+	/*
+	 * Check whether this plane supports the fb pixel format.
+	 * I don't think this should really be needed, but it looks like the
+	 * drm core only checks the format for planes, not for the crtc. So
+	 * when setting the format for crtc, without this check we would
+	 * get an error later when trying to program the color format into the
+	 * HW.
+	 */
+	for (i = 0; i < plane->format_count; i++)
+		if (fb->pixel_format == plane->format_types[i])
+			break;
+	if (i == plane->format_count) {
+		DBG("Invalid pixel format %s",
+			      drm_get_format_name(fb->pixel_format));
+		return -EINVAL;
+	}
 
 	win->crtc_x = crtc_x;
 	win->crtc_y = crtc_y;
-- 
2.3.0

