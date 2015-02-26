From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 07/21] drm/omap: fix operation without fbdev
Date: Thu, 26 Feb 2015 15:20:15 +0200
Message-ID: <1424956829-22892-8-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34679 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932314AbbBZNVJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 08:21:09 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapdrm should work fine even if fbdev is missing. The current driver
crashes in that case, though, as it is missing checks for the fbdev.

Add the checks so that we don't free fbdev or restore fbdev mode when
there's no fbdev.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 95e0356bf047..87724fa818d0 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -518,7 +518,8 @@ static int dev_unload(struct drm_device *dev)
 
 	drm_kms_helper_poll_fini(dev);
 
-	omap_fbdev_free(dev);
+	if (priv->fbdev)
+		omap_fbdev_free(dev);
 
 	/* flush crtcs so the fbs get released */
 	for (i = 0; i < priv->num_crtcs; i++)
@@ -587,9 +588,11 @@ static void dev_lastclose(struct drm_device *dev)
 		}
 	}
 
-	ret = drm_fb_helper_restore_fbdev_mode_unlocked(priv->fbdev);
-	if (ret)
-		DBG("failed to restore crtc mode");
+	if (priv->fbdev) {
+		ret = drm_fb_helper_restore_fbdev_mode_unlocked(priv->fbdev);
+		if (ret)
+			DBG("failed to restore crtc mode");
+	}
 }
 
 static void dev_preclose(struct drm_device *dev, struct drm_file *file)
-- 
2.3.0

