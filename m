From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 16/32] OMAPDSS: add omapdss_compat_init()
Date: Thu, 15 Nov 2012 17:58:24 +0200
Message-ID: <1352995120-3288-17-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56256 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768251Ab2KOP7g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 10:59:36 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add two new exported functions, omapdss_compat_init and
omapdss_compat_uninit, which are to be used by omapfb, omap_vout to
enable compatibility mode for omapdss. The functions are called by
omapdss internally for now, and moved to other drivers later.

The compatibility mode is implemented fully in the following patches.
For now, enabling compat mode only sets up the private data in apply.c.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   32 +++++++++++++++++++++++++++++++-
 drivers/video/omap2/dss/core.c  |    4 +++-
 drivers/video/omap2/dss/dss.h   |    1 -
 include/video/omapdss.h         |    3 +++
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 4a5cc5c..816de17 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -18,6 +18,7 @@
 #define DSS_SUBSYS_NAME "APPLY"
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/jiffies.h>
@@ -131,7 +132,7 @@ static struct mgr_priv_data *get_mgr_priv(struct omap_overlay_manager *mgr)
 	return &dss_data.mgr_priv_data_array[mgr->id];
 }
 
-void dss_apply_init(void)
+static void apply_init_priv(void)
 {
 	const int num_ovls = dss_feat_get_num_ovls();
 	struct mgr_priv_data *mp;
@@ -1463,3 +1464,32 @@ err:
 	return r;
 }
 
+static int compat_refcnt;
+
+int omapdss_compat_init(void)
+{
+	mutex_lock(&apply_lock);
+
+	if (compat_refcnt++ > 0)
+		goto out;
+
+	apply_init_priv();
+
+out:
+	mutex_unlock(&apply_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(omapdss_compat_init);
+
+void omapdss_compat_uninit(void)
+{
+	mutex_lock(&apply_lock);
+
+	if (--compat_refcnt > 0)
+		goto out;
+
+out:
+	mutex_unlock(&apply_lock);
+}
+EXPORT_SYMBOL(omapdss_compat_uninit);
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 8c30831..346638e 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -247,7 +247,7 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 
 	dss_features_init(omapdss_get_version());
 
-	dss_apply_init();
+	omapdss_compat_init();
 
 	dss_init_overlay_managers(pdev);
 	dss_init_overlays(pdev);
@@ -279,6 +279,8 @@ static int omap_dss_remove(struct platform_device *pdev)
 	dss_uninit_overlays(pdev);
 	dss_uninit_overlay_managers(pdev);
 
+	omapdss_compat_uninit();
+
 	return 0;
 }
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 9ee3c88..9cbcd8e 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -179,7 +179,6 @@ void dss_copy_device_pdata(struct omap_dss_device *dst,
 		const struct omap_dss_device *src);
 
 /* apply */
-void dss_apply_init(void);
 int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr);
 int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl);
 void dss_mgr_start_update(struct omap_overlay_manager *mgr);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index b1248c2..a940236 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -836,4 +836,7 @@ void omapdss_rfbi_set_data_lines(struct omap_dss_device *dssdev,
 void omapdss_rfbi_set_interface_timings(struct omap_dss_device *dssdev,
 		struct rfbi_timings *timings);
 
+int omapdss_compat_init(void);
+void omapdss_compat_uninit(void);
+
 #endif
-- 
1.7.10.4

