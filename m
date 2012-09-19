From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 7/8] OMAPDSS: cleanup dss_recheck_connections further
Date: Wed, 19 Sep 2012 11:30:37 +0300
Message-ID: <1348043438-2624-8-git-send-email-tomi.valkeinen@ti.com>
References: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:39375 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754023Ab2ISIbQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 04:31:16 -0400
Received: by lagy9 with SMTP id y9so510675lag.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Sep 2012 01:31:13 -0700 (PDT)
In-Reply-To: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Cleanup dss_recheck_connections, move and rename it to a static
dss_init_connections function inside display.c. Improve the function to
return errors, and implement a matching dss_uninit_connections that can
be used to free the mgr->dssdev link.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c    |    5 ---
 drivers/video/omap2/dss/display.c |   62 +++++++++++++++++++++++++++++++++++--
 drivers/video/omap2/dss/dss.h     |    1 -
 drivers/video/omap2/dss/overlay.c |   32 -------------------
 4 files changed, 60 insertions(+), 40 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 9315ece..c4fd768 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -352,7 +352,6 @@ static int dss_driver_probe(struct device *dev)
 	int r;
 	struct omap_dss_driver *dssdrv = to_dss_driver(dev->driver);
 	struct omap_dss_device *dssdev = to_dss_device(dev);
-	bool force;
 
 	DSSDBG("driver_probe: dev %s/%s, drv %s\n",
 				dev_name(dev), dssdev->driver_name,
@@ -362,10 +361,6 @@ static int dss_driver_probe(struct device *dev)
 	if (r)
 		return r;
 
-	force = core.default_display_name &&
-		strcmp(core.default_display_name, dssdev->name) == 0;
-	dss_recheck_connections(dssdev, force);
-
 	r = dssdrv->probe(dssdev);
 
 	if (r) {
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index f719010..db83ae8 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -320,11 +320,66 @@ void omapdss_default_get_timings(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_default_get_timings);
 
+/*
+ * Connect dssdev to a manager if the manager is free or if force is specified.
+ * Connect all overlays to that manager if they are free or if force is
+ * specified.
+ */
+static int dss_init_connections(struct omap_dss_device *dssdev, bool force)
+{
+	struct omap_overlay_manager *mgr;
+	int i, r;
+
+	WARN_ON(dssdev->manager);
+
+	mgr = omap_dss_get_overlay_manager(dssdev->channel);
+
+	if (mgr->device && !force)
+		return 0;
+
+	if (mgr->device)
+		mgr->unset_device(mgr);
+
+	r = mgr->set_device(mgr, dssdev);
+	if (r) {
+		DSSERR("failed to set initial manager\n");
+		return r;
+	}
+
+	for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+		struct omap_overlay *ovl = omap_dss_get_overlay(i);
+
+		if (!ovl->manager || force) {
+			if (ovl->manager)
+				ovl->unset_manager(ovl);
+
+			r = ovl->set_manager(ovl, mgr);
+			if (r) {
+				DSSERR("failed to set initial overlay\n");
+				return r;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void dss_uninit_connections(struct omap_dss_device *dssdev)
+{
+	if (dssdev->manager)
+		dssdev->manager->unset_device(dssdev->manager);
+}
+
 int dss_init_device(struct platform_device *pdev,
 		struct omap_dss_device *dssdev)
 {
 	struct device_attribute *attr;
 	int i, r;
+	const char *def_disp_name = dss_get_default_display_name();
+	bool force;
+
+	force = def_disp_name && strcmp(def_disp_name, dssdev->name) == 0;
+	dss_init_connections(dssdev, force);
 
 	/* create device sysfs files */
 	i = 0;
@@ -336,6 +391,8 @@ int dss_init_device(struct platform_device *pdev,
 				device_remove_file(&dssdev->dev, attr);
 			}
 
+			dss_uninit_connections(dssdev);
+
 			DSSERR("failed to create sysfs file\n");
 			return r;
 		}
@@ -348,6 +405,8 @@ int dss_init_device(struct platform_device *pdev,
 		while ((attr = display_sysfs_attrs[i++]) != NULL)
 			device_remove_file(&dssdev->dev, attr);
 
+		dss_uninit_connections(dssdev);
+
 		DSSERR("failed to create sysfs display link\n");
 		return r;
 	}
@@ -366,8 +425,7 @@ void dss_uninit_device(struct platform_device *pdev,
 	while ((attr = display_sysfs_attrs[i++]) != NULL)
 		device_remove_file(&dssdev->dev, attr);
 
-	if (dssdev->manager)
-		dssdev->manager->unset_device(dssdev->manager);
+	dss_uninit_connections(dssdev);
 }
 
 static int dss_suspend_device(struct device *dev, void *data)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 98e8273..7a3fea6 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -263,7 +263,6 @@ void dss_manager_kobj_uninit(struct omap_overlay_manager *mgr);
 void dss_init_overlays(struct platform_device *pdev);
 void dss_uninit_overlays(struct platform_device *pdev);
 void dss_overlay_setup_dispc_manager(struct omap_overlay_manager *mgr);
-void dss_recheck_connections(struct omap_dss_device *dssdev, bool force);
 int dss_ovl_simple_check(struct omap_overlay *ovl,
 		const struct omap_overlay_info *info);
 int dss_ovl_check(struct omap_overlay *ovl, struct omap_overlay_info *info,
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 1bf05ef..52455a0 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -105,38 +105,6 @@ void dss_init_overlays(struct platform_device *pdev)
 	}
 }
 
-/* connect overlays to the new device, if not already connected. if force
- * selected, connect always. */
-void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
-{
-	struct omap_overlay_manager *mgr = NULL;
-	int i;
-
-	mgr =  omap_dss_get_overlay_manager(dssdev->channel);
-
-	if (!mgr->device || force) {
-		if (mgr->device)
-			mgr->unset_device(mgr);
-		mgr->set_device(mgr, dssdev);
-	}
-
-	if (mgr) {
-		dispc_runtime_get();
-
-		for (i = 0; i < dss_feat_get_num_ovls(); i++) {
-			struct omap_overlay *ovl;
-			ovl = omap_dss_get_overlay(i);
-			if (!ovl->manager || force) {
-				if (ovl->manager)
-					ovl->unset_manager(ovl);
-				ovl->set_manager(ovl, mgr);
-			}
-		}
-
-		dispc_runtime_put();
-	}
-}
-
 void dss_uninit_overlays(struct platform_device *pdev)
 {
 	int i;
-- 
1.7.9.5

