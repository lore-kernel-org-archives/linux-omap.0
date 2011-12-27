From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 08/29] OMAPDSS: APPLY: Modify manager unset device op
Date: Tue, 27 Dec 2011 18:06:51 +0530
Message-ID: <1324989432-3625-9-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45073 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621Ab1L0Miv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Dec 2011 07:38:51 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Modify manager's unset_device op so that it can be used to unset any one of the
devices connected to the overlay manager output.

The unset_device function now takes a pointer to omap_dss_device struct which
needs to be unset. The function ignores it for now, but since there can be two
devices connected to a manager now, it will be used later to unset either the
display or writeback device.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c   |    3 ++-
 drivers/video/omap2/dss/display.c |    2 +-
 drivers/video/omap2/dss/dss.h     |    3 ++-
 drivers/video/omap2/dss/manager.c |    7 +++++--
 drivers/video/omap2/dss/overlay.c |    9 ++++++---
 include/video/omapdss.h           |    3 ++-
 6 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index ff0baeb..4624f86 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1310,7 +1310,8 @@ err:
 	return r;
 }
 
-int dss_mgr_unset_device(struct omap_overlay_manager *mgr)
+int dss_mgr_unset_device(struct omap_overlay_manager *mgr,
+		struct omap_dss_device *dssdev)
 {
 	int r;
 	struct omap_dss_device *curr_dssdev;
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index a712bad..03d7fb0 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -432,7 +432,7 @@ void dss_uninit_device(struct platform_device *pdev,
 		device_remove_file(&dssdev->dev, attr);
 
 	if (dssdev->manager)
-		dssdev->manager->unset_device(dssdev->manager);
+		dssdev->manager->unset_device(dssdev->manager, dssdev);
 }
 
 static int dss_suspend_device(struct device *dev, void *data)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index bb25d96..b4b60fc 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -178,7 +178,8 @@ void dss_mgr_get_info(struct omap_overlay_manager *mgr,
 		struct omap_overlay_manager_info *info);
 int dss_mgr_set_device(struct omap_overlay_manager *mgr,
 		struct omap_dss_device *dssdev);
-int dss_mgr_unset_device(struct omap_overlay_manager *mgr);
+int dss_mgr_unset_device(struct omap_overlay_manager *mgr,
+		struct omap_dss_device *dssdev);
 
 bool dss_ovl_is_enabled(struct omap_overlay *ovl);
 int dss_ovl_enable(struct omap_overlay *ovl);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 4962f7b..f4fd3d8 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -55,6 +55,7 @@ static ssize_t manager_display_store(struct omap_overlay_manager *mgr,
 	int r = 0;
 	size_t len = size;
 	struct omap_dss_device *dssdev = NULL;
+	struct omap_dss_device *curr_display;
 
 	int match(struct omap_dss_device *dssdev, void *data)
 	{
@@ -74,8 +75,10 @@ static ssize_t manager_display_store(struct omap_overlay_manager *mgr,
 	if (dssdev)
 		DSSDBG("display %s found\n", dssdev->name);
 
-	if (mgr->get_display(mgr)) {
-		r = mgr->unset_device(mgr);
+	curr_display = mgr->get_display(mgr);
+
+	if (curr_display) {
+		r = mgr->unset_device(mgr, curr_display);
 		if (r) {
 			DSSERR("failed to unset display\n");
 			goto put_device;
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index c72275e..dc0cc52 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -538,7 +538,8 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
 	if (dssdev->channel == OMAP_DSS_CHANNEL_LCD2) {
 		if (!lcd2_mgr->output->device || force) {
 			if (lcd2_mgr->output->device)
-				lcd2_mgr->unset_device(lcd2_mgr);
+				lcd2_mgr->unset_device(lcd2_mgr,
+					lcd2_mgr->output->device);
 			lcd2_mgr->set_device(lcd2_mgr, dssdev);
 			mgr = lcd2_mgr;
 		}
@@ -546,7 +547,8 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
 			&& dssdev->type != OMAP_DISPLAY_TYPE_HDMI) {
 		if (!lcd_mgr->output->device || force) {
 			if (lcd_mgr->output->device)
-				lcd_mgr->unset_device(lcd_mgr);
+				lcd_mgr->unset_device(lcd_mgr,
+					lcd_mgr->output->device);
 			lcd_mgr->set_device(lcd_mgr, dssdev);
 			mgr = lcd_mgr;
 		}
@@ -556,7 +558,8 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
 			|| dssdev->type == OMAP_DISPLAY_TYPE_HDMI) {
 		if (!tv_mgr->output->device || force) {
 			if (tv_mgr->output->device)
-				tv_mgr->unset_device(tv_mgr);
+				tv_mgr->unset_device(tv_mgr,
+					tv_mgr->output->device);
 			tv_mgr->set_device(tv_mgr, dssdev);
 			mgr = tv_mgr;
 		}
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 01092e4..d19a7d3 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -456,7 +456,8 @@ struct omap_overlay_manager {
 
 	int (*set_device)(struct omap_overlay_manager *mgr,
 		struct omap_dss_device *dssdev);
-	int (*unset_device)(struct omap_overlay_manager *mgr);
+	int (*unset_device)(struct omap_overlay_manager *mgr,
+		struct omap_dss_device *dssdev);
 
 	int (*set_manager_info)(struct omap_overlay_manager *mgr,
 			struct omap_overlay_manager_info *info);
-- 
1.7.4.1

