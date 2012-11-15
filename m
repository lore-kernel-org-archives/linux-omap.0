From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 17/32] OMAPDSS: move ovl & ovl-mgr init to apply.c
Date: Thu, 15 Nov 2012 17:58:25 +0200
Message-ID: <1352995120-3288-18-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50123 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768267Ab2KOP7i (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 10:59:38 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Overlay and overlay_manager structs will only be needed in the compat
mode.

This patch moves initialization of overlay and overlay_manager structs
to apply.c, so that they are handled in omapdss_compat_init().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |    9 +++++++++
 drivers/video/omap2/dss/core.c  |    6 ------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 816de17..97e9b32 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1468,6 +1468,8 @@ static int compat_refcnt;
 
 int omapdss_compat_init(void)
 {
+	struct platform_device *pdev = dss_get_core_pdev();
+
 	mutex_lock(&apply_lock);
 
 	if (compat_refcnt++ > 0)
@@ -1475,6 +1477,9 @@ int omapdss_compat_init(void)
 
 	apply_init_priv();
 
+	dss_init_overlay_managers(pdev);
+	dss_init_overlays(pdev);
+
 out:
 	mutex_unlock(&apply_lock);
 
@@ -1484,11 +1489,15 @@ EXPORT_SYMBOL(omapdss_compat_init);
 
 void omapdss_compat_uninit(void)
 {
+	struct platform_device *pdev = dss_get_core_pdev();
+
 	mutex_lock(&apply_lock);
 
 	if (--compat_refcnt > 0)
 		goto out;
 
+	dss_uninit_overlay_managers(pdev);
+	dss_uninit_overlays(pdev);
 out:
 	mutex_unlock(&apply_lock);
 }
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 346638e..cf2c619 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -249,9 +249,6 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 
 	omapdss_compat_init();
 
-	dss_init_overlay_managers(pdev);
-	dss_init_overlays(pdev);
-
 	r = dss_initialize_debugfs();
 	if (r)
 		goto err_debugfs;
@@ -276,9 +273,6 @@ static int omap_dss_remove(struct platform_device *pdev)
 
 	dss_uninitialize_debugfs();
 
-	dss_uninit_overlays(pdev);
-	dss_uninit_overlay_managers(pdev);
-
 	omapdss_compat_uninit();
 
 	return 0;
-- 
1.7.10.4

