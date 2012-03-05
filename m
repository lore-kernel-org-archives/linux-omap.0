From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH 02/10] staging: drm/omap: add a workqueue
Date: Mon,  5 Mar 2012 10:48:32 -0600
Message-ID: <1330966120-28582-3-git-send-email-rob.clark@linaro.org>
References: <1330966120-28582-1-git-send-email-rob.clark@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59920 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755877Ab2CEQtF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 11:49:05 -0500
Received: by mail-yw0-f46.google.com with SMTP id m54so1741570yhm.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 08:49:05 -0800 (PST)
In-Reply-To: <1330966120-28582-1-git-send-email-rob.clark@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Greg KH <greg@kroah.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Andy Gross <andy.gross@ti.com>, Rob Clark <rob@ti.com>

From: Rob Clark <rob@ti.com>

Add a workqueue for omapdrm driver, which is needed for at least a
couple things currently: (1) moving omap_gem_roll() to a non-atomic
context, (2) synchronizing page flips w/ DSS scanout related irq's
(in particular not unmapping previous buffer until DSS finishes
scanout).

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/omap_drv.c |    8 ++++++++
 drivers/staging/omapdrm/omap_drv.h |    2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_drv.c b/drivers/staging/omapdrm/omap_drv.c
index 3bbea9a..7417e1f 100644
--- a/drivers/staging/omapdrm/omap_drv.c
+++ b/drivers/staging/omapdrm/omap_drv.c
@@ -570,6 +570,9 @@ static int dev_load(struct drm_device *dev, unsigned long flags)
 
 	dev->dev_private = priv;
 
+	priv->wq = alloc_workqueue("omapdrm",
+			WQ_UNBOUND | WQ_NON_REENTRANT, 1);
+
 	omap_gem_init(dev);
 
 	ret = omap_modeset_init(dev);
@@ -598,6 +601,8 @@ static int dev_load(struct drm_device *dev, unsigned long flags)
 
 static int dev_unload(struct drm_device *dev)
 {
+	struct omap_drm_private *priv = dev->dev_private;
+
 	DBG("unload: dev=%p", dev);
 
 	drm_vblank_cleanup(dev);
@@ -607,6 +612,9 @@ static int dev_unload(struct drm_device *dev)
 	omap_modeset_free(dev);
 	omap_gem_deinit(dev);
 
+	flush_workqueue(priv->wq);
+	destroy_workqueue(priv->wq);
+
 	kfree(dev->dev_private);
 	dev->dev_private = NULL;
 
diff --git a/drivers/staging/omapdrm/omap_drv.h b/drivers/staging/omapdrm/omap_drv.h
index d924c95..a84547c 100644
--- a/drivers/staging/omapdrm/omap_drv.h
+++ b/drivers/staging/omapdrm/omap_drv.h
@@ -51,6 +51,8 @@ struct omap_drm_private {
 
 	struct drm_fb_helper *fbdev;
 
+	struct workqueue_struct *wq;
+
 	bool has_dmm;
 };
 
-- 
1.7.5.4

