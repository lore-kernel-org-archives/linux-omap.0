From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv1 02/14] drm/omap: drop incorrect comment
Date: Mon, 24 Jul 2017 19:32:59 +0200
Message-ID: <20170724173311.27170-3-sebastian.reichel@collabora.co.uk>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

The wrappers have been removed in commit 5a35876e2830
(drm: omapdrm: Remove manual update display support)
and will not be reintroduced, since the normal sys
functions properly call the dirty callback.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/gpu/drm/omapdrm/omap_fbdev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
index daf81a0a2899..929a3ef0fba0 100644
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -84,9 +84,6 @@ static struct fb_ops omap_fb_ops = {
 	.owner = THIS_MODULE,
 	DRM_FB_HELPER_DEFAULT_OPS,
 
-	/* Note: to properly handle manual update displays, we wrap the
-	 * basic fbdev ops which write to the framebuffer
-	 */
 	.fb_read = drm_fb_helper_sys_read,
 	.fb_write = drm_fb_helper_sys_write,
 	.fb_fillrect = drm_fb_helper_sys_fillrect,
-- 
2.13.2
