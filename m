From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 32/32] OMAPDSS: use omapdss_compat_init() in other drivers
Date: Thu, 15 Nov 2012 17:58:40 +0200
Message-ID: <1352995120-3288-33-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56292 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768316Ab2KOQAE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 11:00:04 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

omapdss_compat_init() and omapdss_compat_uninit() is called internally
by omapdss. This patch moves the calls to omapfb, omap_vout and omapdrm
drivers. omapdrm driver can later remove the call after non-compat
support has been implemented in omapdrm.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/media/platform/omap/omap_vout.c  |   17 ++++++++++++++---
 drivers/staging/omapdrm/omap_drv.c       |   11 +++++++++++
 drivers/video/omap2/dss/core.c           |    4 ----
 drivers/video/omap2/omapfb/omapfb-main.c |    6 ++++++
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/omap/omap_vout.c b/drivers/media/platform/omap/omap_vout.c
index 3ff94a3..32c596f 100644
--- a/drivers/media/platform/omap/omap_vout.c
+++ b/drivers/media/platform/omap/omap_vout.c
@@ -2186,14 +2186,23 @@ static int __init omap_vout_probe(struct platform_device *pdev)
 	struct omap_dss_device *def_display;
 	struct omap2video_device *vid_dev = NULL;
 
+	ret = omapdss_compat_init();
+	if (ret) {
+		dev_err(&pdev->dev, "failed to init dss\n");
+		return ret;
+	}
+
 	if (pdev->num_resources == 0) {
 		dev_err(&pdev->dev, "probed for an unknown device\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_dss_init;
 	}
 
 	vid_dev = kzalloc(sizeof(struct omap2video_device), GFP_KERNEL);
-	if (vid_dev == NULL)
-		return -ENOMEM;
+	if (vid_dev == NULL) {
+		ret = -ENOMEM;
+		goto err_dss_init;
+	}
 
 	vid_dev->num_displays = 0;
 	for_each_dss_dev(dssdev) {
@@ -2288,6 +2297,8 @@ probe_err1:
 	}
 probe_err0:
 	kfree(vid_dev);
+err_dss_init:
+	omapdss_compat_uninit();
 	return ret;
 }
 
diff --git a/drivers/staging/omapdrm/omap_drv.c b/drivers/staging/omapdrm/omap_drv.c
index ebdb0b6..2bf7259 100644
--- a/drivers/staging/omapdrm/omap_drv.c
+++ b/drivers/staging/omapdrm/omap_drv.c
@@ -572,6 +572,14 @@ static int dev_load(struct drm_device *dev, unsigned long flags)
 
 	dev->dev_private = priv;
 
+	ret = omapdss_compat_init();
+	if (ret) {
+		dev_err(dev->dev, "coult not init omapdss\n");
+		dev->dev_private = NULL;
+		kfree(priv);
+		return ret;
+	}
+
 	priv->wq = alloc_ordered_workqueue("omapdrm", 0);
 
 	INIT_LIST_HEAD(&priv->obj_list);
@@ -583,6 +591,7 @@ static int dev_load(struct drm_device *dev, unsigned long flags)
 		dev_err(dev->dev, "omap_modeset_init failed: ret=%d\n", ret);
 		dev->dev_private = NULL;
 		kfree(priv);
+		omapdss_compat_uninit();
 		return ret;
 	}
 
@@ -618,6 +627,8 @@ static int dev_unload(struct drm_device *dev)
 	flush_workqueue(priv->wq);
 	destroy_workqueue(priv->wq);
 
+	omapdss_compat_uninit();
+
 	kfree(dev->dev_private);
 	dev->dev_private = NULL;
 
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index cf2c619..3d33426 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -247,8 +247,6 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 
 	dss_features_init(omapdss_get_version());
 
-	omapdss_compat_init();
-
 	r = dss_initialize_debugfs();
 	if (r)
 		goto err_debugfs;
@@ -273,8 +271,6 @@ static int omap_dss_remove(struct platform_device *pdev)
 
 	dss_uninitialize_debugfs();
 
-	omapdss_compat_uninit();
-
 	return 0;
 }
 
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index be9096c..898470a 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2436,6 +2436,9 @@ static int __init omapfb_probe(struct platform_device *pdev)
 				"ignoring the module parameter vrfb=y\n");
 	}
 
+	r = omapdss_compat_init();
+	if (r)
+		goto err0;
 
 	mutex_init(&fbdev->mtx);
 
@@ -2559,6 +2562,7 @@ static int __init omapfb_probe(struct platform_device *pdev)
 
 cleanup:
 	omapfb_free_resources(fbdev);
+	omapdss_compat_uninit();
 err0:
 	dev_err(&pdev->dev, "failed to setup omapfb\n");
 	return r;
@@ -2574,6 +2578,8 @@ static int __exit omapfb_remove(struct platform_device *pdev)
 
 	omapfb_free_resources(fbdev);
 
+	omapdss_compat_uninit();
+
 	return 0;
 }
 
-- 
1.7.10.4

