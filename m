From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 02/29] OMAPDSS: Add writeback to omap_dss_mgr_output
Date: Tue, 27 Dec 2011 18:06:45 +0530
Message-ID: <1324989432-3625-3-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58011 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539Ab1L0Mi2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Dec 2011 07:38:28 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Add a omap_dss_device pointer in omap_dss_mgr_output to represent a writeback
device. The writeback device is a dummy omap_dss_device pointer connected to
the manager. It is a place holder for the actual writeback entity and is used
for compatibility with the existing DSS2 code.

Create helper overlay manager functions get_display() and get_writeback() which
return mgr->output->device and mgr->output->writeback devices. Modify
get_output() to return the display device if both device and writeback pointers
are set. Otherwise, return the omap_dss_device pointer which is set.

If writeback is in use, get_output() returns the display device if we are in
capture mode, and it returns the writeback device if we are in memory to memory
mode. This is beneficial as most checks/configurations for overlays and managers
should be done on the basis of the manager's output display in capture mode, and
the writeback device in case of memory to memory mode.

get_display() should be used when we are interested specifically in the
connected display, the same holds for get_writeback().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/manager.c |   19 +++++++++++++++++--
 include/video/omapdss.h           |    3 +++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 094c96c..4962f7b 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -43,7 +43,7 @@ static ssize_t manager_name_show(struct omap_overlay_manager *mgr, char *buf)
 
 static ssize_t manager_display_show(struct omap_overlay_manager *mgr, char *buf)
 {
-	struct omap_dss_device *dssdev = mgr->get_output(mgr);
+	struct omap_dss_device *dssdev = mgr->get_display(mgr);
 
 	return snprintf(buf, PAGE_SIZE, "%s\n", dssdev ?
 			dssdev->name : "<none>");
@@ -74,7 +74,7 @@ static ssize_t manager_display_store(struct omap_overlay_manager *mgr,
 	if (dssdev)
 		DSSDBG("display %s found\n", dssdev->name);
 
-	if (mgr->get_output(mgr)) {
+	if (mgr->get_display(mgr)) {
 		r = mgr->unset_device(mgr);
 		if (r) {
 			DSSERR("failed to unset display\n");
@@ -494,9 +494,22 @@ static struct kobj_type manager_ktype = {
 
 static inline struct omap_dss_device *dss_mgr_get_output(struct omap_overlay_manager *mgr)
 {
+	if (mgr->output->device)
+		return mgr->output->device;
+
+	return mgr->output->writeback;
+}
+
+static inline struct omap_dss_device *dss_mgr_get_display(struct omap_overlay_manager *mgr)
+{
 	return mgr->output->device;
 }
 
+static inline struct omap_dss_device *dss_mgr_get_writeback(struct omap_overlay_manager *mgr)
+{
+	return mgr->output->writeback;
+}
+
 static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
 {
 	unsigned long timeout = msecs_to_jiffies(500);
@@ -562,6 +575,8 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 		mgr->wait_for_vsync = &dss_mgr_wait_for_vsync;
 
 		mgr->get_output = &dss_mgr_get_output;
+		mgr->get_display = &dss_mgr_get_display;
+		mgr->get_writeback = &dss_mgr_get_writeback;
 
 		mgr->caps = 0;
 		mgr->supported_displays =
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 1b968bb..93a1cd3 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -413,6 +413,7 @@ struct omap_overlay {
 
 struct omap_dss_mgr_output {
 	struct omap_dss_device *device;
+	struct omap_dss_device *writeback;
 };
 
 struct omap_overlay_manager_info {
@@ -466,6 +467,8 @@ struct omap_overlay_manager {
 	int (*wait_for_vsync)(struct omap_overlay_manager *mgr);
 
 	struct omap_dss_device *(*get_output)(struct omap_overlay_manager *mgr);
+	struct omap_dss_device *(*get_display)(struct omap_overlay_manager *mgr);
+	struct omap_dss_device *(*get_writeback)(struct omap_overlay_manager *mgr);
 };
 
 struct omap_dss_device {
-- 
1.7.4.1

