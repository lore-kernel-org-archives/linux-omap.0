From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/21] drm/omap: add a comment why locking is missing
Date: Thu, 26 Feb 2015 15:20:13 +0200
Message-ID: <1424956829-22892-6-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34672 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932240AbbBZNVH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 08:21:07 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

unpin_worker() calls omap_framebuffer_unpin() without any locks, which
looks very suspicious. However, both pin and unpin are always called via
the driver's private workqueue, so the access is synchronized that way.

Add a comment to make this clear.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_plane.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_plane.c b/drivers/gpu/drm/omapdrm/omap_plane.c
index ee8e2b3a117e..1f4f2b866379 100644
--- a/drivers/gpu/drm/omapdrm/omap_plane.c
+++ b/drivers/gpu/drm/omapdrm/omap_plane.c
@@ -71,6 +71,10 @@ static void unpin_worker(struct drm_flip_work *work, void *val)
 			container_of(work, struct omap_plane, unpin_work);
 	struct drm_device *dev = omap_plane->base.dev;
 
+	/*
+	 * omap_framebuffer_pin/unpin are always called from priv->wq,
+	 * so there's no need for locking here.
+	 */
 	omap_framebuffer_unpin(val);
 	mutex_lock(&dev->mode_config.mutex);
 	drm_framebuffer_unreference(val);
-- 
2.3.0

