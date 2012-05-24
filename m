From: Andy Gross <andy.gross@ti.com>
Subject: [PATCH] staging: omapdrm: fix crash when freeing bad fb
Date: Thu, 24 May 2012 11:44:22 -0500
Message-ID: <1337877862-5055-1-git-send-email-andy.gross@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57254 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670Ab2EXQo2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 May 2012 12:44:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: greg@kroah.com, rob@ti.com, Andy Gross <andy.gross@ti.com>

During unload, don't cleanup the framebuffer if it is not valid.

Signed-off-by: Andy Gross <andy.gross@ti.com>
---
 drivers/staging/omapdrm/omap_fbdev.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_fbdev.c b/drivers/staging/omapdrm/omap_fbdev.c
index 11acd4c..8c6ed3b 100644
--- a/drivers/staging/omapdrm/omap_fbdev.c
+++ b/drivers/staging/omapdrm/omap_fbdev.c
@@ -208,7 +208,8 @@ static int omap_fbdev_create(struct drm_fb_helper *helper,
 	 */
 	ret = omap_gem_get_paddr(fbdev->bo, &paddr, true);
 	if (ret) {
-		dev_err(dev->dev, "could not map (paddr)!\n");
+		dev_err(dev->dev,
+			"could not map (paddr)!  Skipping framebuffer alloc\n");
 		ret = -ENOMEM;
 		goto fail;
 	}
@@ -388,8 +389,11 @@ void omap_fbdev_free(struct drm_device *dev)
 
 	fbi = helper->fbdev;
 
-	unregister_framebuffer(fbi);
-	framebuffer_release(fbi);
+	/* only cleanup framebuffer if it is present */
+	if (fbi) {
+		unregister_framebuffer(fbi);
+		framebuffer_release(fbi);
+	}
 
 	drm_fb_helper_fini(helper);
 
-- 
1.7.5.4

