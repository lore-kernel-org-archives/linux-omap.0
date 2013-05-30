From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/32] OMAPDSS: split overlay manager creation
Date: Thu, 30 May 2013 12:34:31 +0300
Message-ID: <1369906493-27538-11-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41383 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030321Ab3E3Jff (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:35:35 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Split the function that creates overlay manager structs into two: one
that creates just the structs, and one that creates the sysfs files for
the manager.

This will help us use the overlay manager structs with omapdrm in the
following patches, while still leaving the sysfs files out.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c         |  9 ++++++---
 drivers/video/omap2/dss/dss.h           |  6 ++++--
 drivers/video/omap2/dss/manager-sysfs.c |  2 ++
 drivers/video/omap2/dss/manager.c       | 29 ++++++++++++++++++++++-------
 4 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index b84bd99..74d1d00 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1577,7 +1577,8 @@ int omapdss_compat_init(void)
 
 	apply_init_priv();
 
-	dss_init_overlay_managers(pdev);
+	dss_init_overlay_managers();
+	dss_init_overlay_managers_sysfs(pdev);
 	dss_init_overlays(pdev);
 
 	for (i = 0; i < omap_dss_get_num_overlay_managers(); i++) {
@@ -1640,7 +1641,8 @@ err_disp_sysfs:
 	dss_uninstall_mgr_ops();
 
 err_mgr_ops:
-	dss_uninit_overlay_managers(pdev);
+	dss_uninit_overlay_managers_sysfs(pdev);
+	dss_uninit_overlay_managers();
 	dss_uninit_overlays(pdev);
 
 	compat_refcnt--;
@@ -1668,7 +1670,8 @@ void omapdss_compat_uninit(void)
 
 	dss_uninstall_mgr_ops();
 
-	dss_uninit_overlay_managers(pdev);
+	dss_uninit_overlay_managers_sysfs(pdev);
+	dss_uninit_overlay_managers();
 	dss_uninit_overlays(pdev);
 out:
 	mutex_unlock(&compat_init_lock);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 8475893..7964d3b 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -194,8 +194,10 @@ void display_uninit_sysfs(struct platform_device *pdev,
 		struct omap_dss_device *dssdev);
 
 /* manager */
-int dss_init_overlay_managers(struct platform_device *pdev);
-void dss_uninit_overlay_managers(struct platform_device *pdev);
+int dss_init_overlay_managers(void);
+void dss_uninit_overlay_managers(void);
+int dss_init_overlay_managers_sysfs(struct platform_device *pdev);
+void dss_uninit_overlay_managers_sysfs(struct platform_device *pdev);
 int dss_mgr_simple_check(struct omap_overlay_manager *mgr,
 		const struct omap_overlay_manager_info *info);
 int dss_mgr_check_timings(struct omap_overlay_manager *mgr,
diff --git a/drivers/video/omap2/dss/manager-sysfs.c b/drivers/video/omap2/dss/manager-sysfs.c
index 5104681..72784b3 100644
--- a/drivers/video/omap2/dss/manager-sysfs.c
+++ b/drivers/video/omap2/dss/manager-sysfs.c
@@ -511,4 +511,6 @@ void dss_manager_kobj_uninit(struct omap_overlay_manager *mgr)
 {
 	kobject_del(&mgr->kobj);
 	kobject_put(&mgr->kobj);
+
+	memset(&mgr->kobj, 0, sizeof(mgr->kobj));
 }
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 2551eaa..1aac9b4 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -36,9 +36,9 @@
 static int num_managers;
 static struct omap_overlay_manager *managers;
 
-int dss_init_overlay_managers(struct platform_device *pdev)
+int dss_init_overlay_managers(void)
 {
-	int i, r;
+	int i;
 
 	num_managers = dss_feat_get_num_mgrs();
 
@@ -76,6 +76,17 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 			dss_feat_get_supported_outputs(mgr->id);
 
 		INIT_LIST_HEAD(&mgr->overlays);
+	}
+
+	return 0;
+}
+
+int dss_init_overlay_managers_sysfs(struct platform_device *pdev)
+{
+	int i, r;
+
+	for (i = 0; i < num_managers; ++i) {
+		struct omap_overlay_manager *mgr = &managers[i];
 
 		r = dss_manager_kobj_init(mgr, pdev);
 		if (r)
@@ -85,18 +96,22 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 	return 0;
 }
 
-void dss_uninit_overlay_managers(struct platform_device *pdev)
+void dss_uninit_overlay_managers(void)
+{
+	kfree(managers);
+	managers = NULL;
+	num_managers = 0;
+}
+
+void dss_uninit_overlay_managers_sysfs(struct platform_device *pdev)
 {
 	int i;
 
 	for (i = 0; i < num_managers; ++i) {
 		struct omap_overlay_manager *mgr = &managers[i];
+
 		dss_manager_kobj_uninit(mgr);
 	}
-
-	kfree(managers);
-	managers = NULL;
-	num_managers = 0;
 }
 
 int omap_dss_get_num_overlay_managers(void)
-- 
1.8.1.2

