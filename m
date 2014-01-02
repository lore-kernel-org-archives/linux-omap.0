From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 4/4] drm/omap: fix: change dev_unload order
Date: Thu, 2 Jan 2014 14:49:54 +0530
Message-ID: <1388654394-5708-5-git-send-email-archit@ti.com>
References: <1388654394-5708-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32896 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395AbaABJUO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Jan 2014 04:20:14 -0500
In-Reply-To: <1388654394-5708-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, robdclark@gmail.com
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@ti.com, Archit Taneja <archit@ti.com>

The current dev_unload order uninits the irqs too early.

In the current sequence, it's possible that a crtc queues work(apply_worker)
to display a buffer, which registers to omap_crtc_apply_irq to notfiy the
completion of the configuration we applied.

Calling drm_vblank_cleanup and omap_drm_irq_uninstall here causes the crtc's
apply handler to never get called, which results in an incorrect state of the
apply_irq.registered parameter.

This condition occurs where there is no mode set via omapdrm, and dev_lastclose
tries to set a default fb mode via drm_fb_helper_restore_fbdev_mode. The apply
work scheduled by restore_fbdev_mode is very close in time to the disabling of
the irq handler, and hence leads to a race condition. We move the irq cleanup
at the end of the unload sequence to prevent this.

Also, the call to flush_workqueue is removed since it's called internally by
destroy_workqueue.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index fca5667..c57e99c 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -517,16 +517,16 @@ static int dev_unload(struct drm_device *dev)
 	DBG("unload: dev=%p", dev);
 
 	drm_kms_helper_poll_fini(dev);
-	drm_vblank_cleanup(dev);
-	omap_drm_irq_uninstall(dev);
 
 	omap_fbdev_free(dev);
 	omap_modeset_free(dev);
 	omap_gem_deinit(dev);
 
-	flush_workqueue(priv->wq);
 	destroy_workqueue(priv->wq);
 
+	drm_vblank_cleanup(dev);
+	omap_drm_irq_uninstall(dev);
+
 	kfree(dev->dev_private);
 	dev->dev_private = NULL;
 
-- 
1.8.3.2

