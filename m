From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/21] drm/omap: remove dummy PM functions
Date: Thu, 26 Feb 2015 15:20:21 +0200
Message-ID: <1424956829-22892-14-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34691 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932076AbbBZNVU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Feb 2015 08:21:20 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapdrm has dummy functions for platform_device's
suspend/resume/shutdown. The functions don't do anything, and those
platform device functions are deprecated, so remove them from omapdrm.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 87724fa818d0..0ebd1315fff8 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -663,23 +663,6 @@ static struct drm_driver omap_drm_driver = {
 		.patchlevel = DRIVER_PATCHLEVEL,
 };
 
-static int pdev_suspend(struct platform_device *pDevice, pm_message_t state)
-{
-	DBG("");
-	return 0;
-}
-
-static int pdev_resume(struct platform_device *device)
-{
-	DBG("");
-	return 0;
-}
-
-static void pdev_shutdown(struct platform_device *device)
-{
-	DBG("");
-}
-
 static int pdev_probe(struct platform_device *device)
 {
 	int r;
@@ -726,9 +709,6 @@ static struct platform_driver pdev = {
 		},
 		.probe = pdev_probe,
 		.remove = pdev_remove,
-		.suspend = pdev_suspend,
-		.resume = pdev_resume,
-		.shutdown = pdev_shutdown,
 };
 
 static int __init omap_drm_init(void)
-- 
2.3.0

