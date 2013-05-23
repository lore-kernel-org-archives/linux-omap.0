From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH] OMAPDSS: Fix crash with DT boot
Date: Thu, 23 May 2013 12:56:53 +0300
Message-ID: <1369303013-1161-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33508 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757819Ab3EWJ52 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 May 2013 05:57:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

When booting with DT, there's a crash when omapfb is probed. This is
caused by the fact that omapdss+DT is not yet supported, and thus
omapdss is not probed at all. On the other hand, omapfb is always
probed. When omapfb tries to use omapdss, there's a NULL pointer
dereference crash. The same error should most likely happen with omapdrm
and omap_vout also.

To fix this, add an "initialized" state to omapdss. When omapdss has
been probed, it's marked as initialized. omapfb, omapdrm and omap_vout
check this state when they are probed to see that omapdss is actually
there.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c       |  3 +++
 drivers/media/platform/omap/omap_vout.c  |  3 +++
 drivers/video/omap2/dss/core.c           | 20 +++++++++++++++++++-
 drivers/video/omap2/omapfb/omapfb-main.c |  3 +++
 include/video/omapdss.h                  |  1 +
 5 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 079c54c..902074b 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -548,6 +548,9 @@ static void pdev_shutdown(struct platform_device *device)
 
 static int pdev_probe(struct platform_device *device)
 {
+	if (omapdss_is_initialized() == false)
+		return -EPROBE_DEFER;
+
 	DBG("%s", device->name);
 	return drm_platform_init(&omap_drm_driver, device);
 }
diff --git a/drivers/media/platform/omap/omap_vout.c b/drivers/media/platform/omap/omap_vout.c
index 96c4a17..0a489bd 100644
--- a/drivers/media/platform/omap/omap_vout.c
+++ b/drivers/media/platform/omap/omap_vout.c
@@ -2144,6 +2144,9 @@ static int __init omap_vout_probe(struct platform_device *pdev)
 	struct omap_dss_device *def_display;
 	struct omap2video_device *vid_dev = NULL;
 
+	if (omapdss_is_initialized() == false)
+		return -EPROBE_DEFER;
+
 	ret = omapdss_compat_init();
 	if (ret) {
 		dev_err(&pdev->dev, "failed to init dss\n");
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index f8779d4..f49ddb9 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -53,6 +53,8 @@ static char *def_disp_name;
 module_param_named(def_disp, def_disp_name, charp, 0);
 MODULE_PARM_DESC(def_disp, "default display name");
 
+static bool dss_initialized;
+
 const char *omapdss_get_default_display_name(void)
 {
 	return core.default_display_name;
@@ -66,6 +68,12 @@ enum omapdss_version omapdss_get_version(void)
 }
 EXPORT_SYMBOL(omapdss_get_version);
 
+bool omapdss_is_initialized(void)
+{
+	return dss_initialized;
+}
+EXPORT_SYMBOL(omapdss_is_initialized);
+
 struct platform_device *dss_get_core_pdev(void)
 {
 	return core.pdev;
@@ -606,6 +614,8 @@ static int __init omap_dss_init(void)
 		return r;
 	}
 
+	dss_initialized = true;
+
 	return 0;
 }
 
@@ -636,7 +646,15 @@ static int __init omap_dss_init(void)
 
 static int __init omap_dss_init2(void)
 {
-	return omap_dss_register_drivers();
+	int r;
+
+	r = omap_dss_register_drivers();
+	if (r)
+		return r;
+
+	dss_initialized = true;
+
+	return 0;
 }
 
 core_initcall(omap_dss_init);
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 717f13a..bb5f9fe 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2416,6 +2416,9 @@ static int __init omapfb_probe(struct platform_device *pdev)
 
 	DBG("omapfb_probe\n");
 
+	if (omapdss_is_initialized() == false)
+		return -EPROBE_DEFER;
+
 	if (pdev->num_resources != 0) {
 		dev_err(&pdev->dev, "probed for an unknown device\n");
 		r = -ENODEV;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index caefa09..9b52340 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -741,6 +741,7 @@ struct omap_dss_driver {
 };
 
 enum omapdss_version omapdss_get_version(void);
+bool omapdss_is_initialized(void);
 
 int omap_dss_register_driver(struct omap_dss_driver *);
 void omap_dss_unregister_driver(struct omap_dss_driver *);
-- 
1.8.1.2

