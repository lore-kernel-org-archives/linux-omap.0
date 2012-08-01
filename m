From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH] staging: drm/omap: remove reclaim_buffers callback
Date: Wed, 1 Aug 2012 18:50:34 +0530
Message-ID: <1343827234-15565-1-git-send-email-cmahapatra@ti.com>
References: <1343813558-28347-1-git-send-email-cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55675 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752285Ab2HANWC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 1 Aug 2012 09:22:02 -0400
In-Reply-To: <1343813558-28347-1-git-send-email-cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: greg@kroah.com
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, rob@ti.com, tomi.valkeinen@ti.com, sumit.semwal@ti.com, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The reclaim_buffers callback has already been removed by Daniel Vetter
<daniel.vetter@ffwll.ch> with his patch "drm: kill reclaim_buffers callback"
(b0071efe82). As a result the kernel compilation fails with omapdrm support
and so the callback for reclaim_buffers is being removed from omapdrm.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/staging/omapdrm/omap_drv.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/omapdrm/omap_drv.c b/drivers/staging/omapdrm/omap_drv.c
index 342645a..b8e79eb 100644
--- a/drivers/staging/omapdrm/omap_drv.c
+++ b/drivers/staging/omapdrm/omap_drv.c
@@ -778,7 +778,6 @@ static struct drm_driver omap_drm_driver = {
 		.irq_postinstall = dev_irq_postinstall,
 		.irq_uninstall = dev_irq_uninstall,
 		.irq_handler = dev_irq_handler,
-		.reclaim_buffers = drm_core_reclaim_buffers,
 #ifdef CONFIG_DEBUG_FS
 		.debugfs_init = omap_debugfs_init,
 		.debugfs_cleanup = omap_debugfs_cleanup,
-- 
1.7.10

