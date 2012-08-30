From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 23/23] OMAPDSS: Remove old way of setting manager and device links
Date: Thu, 30 Aug 2012 17:10:45 +0530
Message-ID: <1346326845-16583-24-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
 <1346326845-16583-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34317 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754772Ab2H3Lnk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 07:43:40 -0400
In-Reply-To: <1346326845-16583-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Now that an omap_dss_output can be used to link between managers and devices, we
can remove the old way of setting manager and device links. This involves
removing the device and manager pointers from omap_overlay_manager and
omap_dss_device respectively, and removing the set_device/unset_device ops from
omap_overlay_manager.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c   |   64 -------------------------------------
 drivers/video/omap2/dss/manager.c |    2 --
 include/video/omapdss.h           |    5 ---
 3 files changed, 71 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index d584f0c..0ae70ab 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1247,70 +1247,6 @@ void dss_mgr_get_info(struct omap_overlay_manager *mgr,
 	spin_unlock_irqrestore(&data_lock, flags);
 }
 
-int dss_mgr_set_device(struct omap_overlay_manager *mgr,
-		struct omap_dss_device *dssdev)
-{
-	int r;
-
-	mutex_lock(&apply_lock);
-
-	if (dssdev->manager) {
-		DSSERR("display '%s' already has a manager '%s'\n",
-			       dssdev->name, dssdev->manager->name);
-		r = -EINVAL;
-		goto err;
-	}
-
-	if ((mgr->supported_displays & dssdev->type) == 0) {
-		DSSERR("display '%s' does not support manager '%s'\n",
-			       dssdev->name, mgr->name);
-		r = -EINVAL;
-		goto err;
-	}
-
-	dssdev->manager = mgr;
-	mgr->device = dssdev;
-
-	mutex_unlock(&apply_lock);
-
-	return 0;
-err:
-	mutex_unlock(&apply_lock);
-	return r;
-}
-
-int dss_mgr_unset_device(struct omap_overlay_manager *mgr)
-{
-	int r;
-
-	mutex_lock(&apply_lock);
-
-	if (!mgr->device) {
-		DSSERR("failed to unset display, display not set.\n");
-		r = -EINVAL;
-		goto err;
-	}
-
-	/*
-	 * Don't allow currently enabled displays to have the overlay manager
-	 * pulled out from underneath them
-	 */
-	if (mgr->device->state != OMAP_DSS_DISPLAY_DISABLED) {
-		r = -EINVAL;
-		goto err;
-	}
-
-	mgr->device->manager = NULL;
-	mgr->device = NULL;
-
-	mutex_unlock(&apply_lock);
-
-	return 0;
-err:
-	mutex_unlock(&apply_lock);
-	return r;
-}
-
 int dss_mgr_set_output(struct omap_overlay_manager *mgr,
 		struct omap_dss_output *output)
 {
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index d14ffc5..953f5ee 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -570,8 +570,6 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 			break;
 		}
 
-		mgr->set_device = &dss_mgr_set_device;
-		mgr->unset_device = &dss_mgr_unset_device;
 		mgr->set_output = &dss_mgr_set_output;
 		mgr->unset_output = &dss_mgr_unset_output;
 		mgr->apply = &omap_dss_mgr_apply;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 0e73ef8..4ff43e6 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -466,7 +466,6 @@ struct omap_overlay_manager {
 	enum omap_dss_output_id supported_outputs;
 
 	/* dynamic fields */
-	struct omap_dss_device *device;
 	struct omap_dss_output *output;
 
 	/*
@@ -480,9 +479,6 @@ struct omap_overlay_manager {
 	 * interrupt context
 	 */
 
-	int (*set_device)(struct omap_overlay_manager *mgr,
-		struct omap_dss_device *dssdev);
-	int (*unset_device)(struct omap_overlay_manager *mgr);
 	int (*set_output)(struct omap_overlay_manager *mgr,
 		struct omap_dss_output *output);
 	int (*unset_output)(struct omap_overlay_manager *mgr);
@@ -634,7 +630,6 @@ struct omap_dss_device {
 
 	enum omap_display_caps caps;
 
-	struct omap_overlay_manager *manager;
 	struct omap_dss_output *output;
 
 	enum omap_dss_display_state state;
-- 
1.7.9.5

