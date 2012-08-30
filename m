From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 05/23] OMAPDSS: Remove manager->device references
Date: Thu, 30 Aug 2012 17:10:27 +0530
Message-ID: <1346326845-16583-6-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
 <1346326845-16583-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34250 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599Ab2H3Lml (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 07:42:41 -0400
In-Reply-To: <1346326845-16583-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

With the introduction of output entities, managers will now connect to outputs.
Create a helper op for managers named get_device. This will abstract away the
information on how to get the device from an overlay manager. The get_device
op currently retrieves the output via a manager->device reference. This will
be later replaced by a manager->output->device reference.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c   |    6 ++++--
 drivers/video/omap2/dss/dispc.c   |   10 +++++++---
 drivers/video/omap2/dss/manager.c |   19 ++++++++++++++-----
 include/video/omapdss.h           |    2 ++
 4 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index d241407..8a05cbc 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1607,7 +1607,8 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 		goto err1;
 	}
 
-	if (ovl->manager == NULL || ovl->manager->device == NULL) {
+	if (ovl->manager == NULL ||
+			ovl->manager->get_device(ovl->manager) == NULL) {
 		r = -EINVAL;
 		goto err1;
 	}
@@ -1676,7 +1677,8 @@ int dss_ovl_disable(struct omap_overlay *ovl)
 		goto err;
 	}
 
-	if (ovl->manager == NULL || ovl->manager->device == NULL) {
+	if (ovl->manager == NULL ||
+			ovl->manager->get_device(ovl->manager) == NULL) {
 		r = -EINVAL;
 		goto err;
 	}
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 0de9a7e..bfd73f5 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3549,7 +3549,7 @@ static void dispc_error_worker(struct work_struct *work)
 		bit = mgr_desc[i].sync_lost_irq;
 
 		if (bit & errors) {
-			struct omap_dss_device *dssdev = mgr->device;
+			struct omap_dss_device *dssdev = mgr->get_device(mgr);
 			bool enable;
 
 			DSSERR("SYNC_LOST on channel %s, restarting the output "
@@ -3580,9 +3580,13 @@ static void dispc_error_worker(struct work_struct *work)
 		DSSERR("OCP_ERR\n");
 		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
 			struct omap_overlay_manager *mgr;
+			struct omap_dss_device *dssdev;
+
 			mgr = omap_dss_get_overlay_manager(i);
-			if (mgr->device && mgr->device->driver)
-				mgr->device->driver->disable(mgr->device);
+			dssdev = mgr->get_device(mgr);
+
+			if (dssdev && dssdev->driver)
+				dssdev->driver->disable(dssdev);
 		}
 	}
 
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index e15fa5f..fd39f66 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -43,8 +43,10 @@ static ssize_t manager_name_show(struct omap_overlay_manager *mgr, char *buf)
 
 static ssize_t manager_display_show(struct omap_overlay_manager *mgr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			mgr->device ? mgr->device->name : "<none>");
+	struct omap_dss_device *dssdev = mgr->get_device(mgr);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", dssdev ?
+			dssdev->name : "<none>");
 }
 
 static ssize_t manager_display_store(struct omap_overlay_manager *mgr,
@@ -72,7 +74,7 @@ static ssize_t manager_display_store(struct omap_overlay_manager *mgr,
 	if (dssdev)
 		DSSDBG("display %s found\n", dssdev->name);
 
-	if (mgr->device) {
+	if (mgr->get_device(mgr)) {
 		r = mgr->unset_device(mgr);
 		if (r) {
 			DSSERR("failed to unset display\n");
@@ -490,9 +492,15 @@ static struct kobj_type manager_ktype = {
 	.default_attrs = manager_sysfs_attrs,
 };
 
+static inline struct omap_dss_device *dss_mgr_get_device(struct omap_overlay_manager *mgr)
+{
+	return mgr->device;
+}
+
 static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
 {
 	unsigned long timeout = msecs_to_jiffies(500);
+	struct omap_dss_device *dssdev = mgr->get_device(mgr);
 	u32 irq;
 	int r;
 
@@ -500,9 +508,9 @@ static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
 	if (r)
 		return r;
 
-	if (mgr->device->type == OMAP_DISPLAY_TYPE_VENC)
+	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC)
 		irq = DISPC_IRQ_EVSYNC_ODD;
-	else if (mgr->device->type == OMAP_DISPLAY_TYPE_HDMI)
+	else if (dssdev->type == OMAP_DISPLAY_TYPE_HDMI)
 		irq = DISPC_IRQ_EVSYNC_EVEN;
 	else
 		irq = dispc_mgr_get_vsync_irq(mgr->id);
@@ -556,6 +564,7 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 		mgr->get_manager_info = &dss_mgr_get_info;
 		mgr->wait_for_go = &dss_mgr_wait_for_go;
 		mgr->wait_for_vsync = &dss_mgr_wait_for_vsync;
+		mgr->get_device = &dss_mgr_get_device;
 
 		mgr->caps = 0;
 		mgr->supported_displays =
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index a3b35f9..29c1440 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -490,6 +490,8 @@ struct omap_overlay_manager {
 	int (*apply)(struct omap_overlay_manager *mgr);
 	int (*wait_for_go)(struct omap_overlay_manager *mgr);
 	int (*wait_for_vsync)(struct omap_overlay_manager *mgr);
+
+	struct omap_dss_device *(*get_device)(struct omap_overlay_manager *mgr);
 };
 
 /* 22 pins means 1 clk lane and 10 data lanes */
-- 
1.7.9.5

