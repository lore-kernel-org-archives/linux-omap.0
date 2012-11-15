From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 27/32] OMAPDSS: move display sysfs init to compat layer
Date: Thu, 15 Nov 2012 17:58:35 +0200
Message-ID: <1352995120-3288-28-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56277 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768212Ab2KOP74 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 10:59:56 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Move creation of the sysfs files for displays to the compat layer.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c   |   14 ++++++++++++++
 drivers/video/omap2/dss/display.c |    8 --------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 51124ab..b24ed758 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1561,6 +1561,7 @@ static int compat_refcnt;
 int omapdss_compat_init(void)
 {
 	struct platform_device *pdev = dss_get_core_pdev();
+	struct omap_dss_device *dssdev = NULL;
 	int i, r;
 
 	mutex_lock(&apply_lock);
@@ -1606,6 +1607,13 @@ int omapdss_compat_init(void)
 	if (r)
 		goto err_mgr_ops;
 
+	for_each_dss_dev(dssdev) {
+		r = display_init_sysfs(pdev, dssdev);
+		/* XXX uninit sysfs files on error */
+		if (r)
+			goto err_disp_sysfs;
+	}
+
 	dispc_runtime_get();
 
 	r = dss_dispc_initialize_irq();
@@ -1621,6 +1629,8 @@ out:
 
 err_init_irq:
 	dispc_runtime_put();
+
+err_disp_sysfs:
 	dss_uninstall_mgr_ops();
 
 err_mgr_ops:
@@ -1638,6 +1648,7 @@ EXPORT_SYMBOL(omapdss_compat_init);
 void omapdss_compat_uninit(void)
 {
 	struct platform_device *pdev = dss_get_core_pdev();
+	struct omap_dss_device *dssdev = NULL;
 
 	mutex_lock(&apply_lock);
 
@@ -1646,6 +1657,9 @@ void omapdss_compat_uninit(void)
 
 	dss_dispc_uninitialize_irq();
 
+	for_each_dss_dev(dssdev)
+		display_uninit_sysfs(pdev, dssdev);
+
 	dss_uninstall_mgr_ops();
 
 	dss_uninit_overlay_managers(pdev);
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 008e9ee..b7383b4 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -90,20 +90,12 @@ int dss_init_device(struct platform_device *pdev,
 		return r;
 	}
 
-	r = display_init_sysfs(pdev, dssdev);
-	if (r) {
-		omapdss_output_unset_device(dssdev->output);
-		return r;
-	}
-
 	return 0;
 }
 
 void dss_uninit_device(struct platform_device *pdev,
 		struct omap_dss_device *dssdev)
 {
-	display_uninit_sysfs(pdev, dssdev);
-
 	if (dssdev->output)
 		omapdss_output_unset_device(dssdev->output);
 }
-- 
1.7.10.4

