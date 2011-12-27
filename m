From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 27/29] OMAPDSS: MANAGER: Split manager_display_store into smaller functions
Date: Tue, 27 Dec 2011 18:07:10 +0530
Message-ID: <1324989432-3625-28-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45144 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753752Ab1L0MkQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Dec 2011 07:40:16 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Split manager_display_store() into two function, the first function finds a
device with the same name. The second unsets the current output attached and
sets the one we had searched for.

This is done so that there can be re use between display store and writeback
store sysfs ops.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/manager.c |   46 ++++++++++++++++++++++++++++++------
 1 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index f4fd3d8..fb7c1e6 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -49,13 +49,11 @@ static ssize_t manager_display_show(struct omap_overlay_manager *mgr, char *buf)
 			dssdev->name : "<none>");
 }
 
-static ssize_t manager_display_store(struct omap_overlay_manager *mgr,
+static int dss_find_device_buf(struct omap_dss_device **pdssdev,
 		const char *buf, size_t size)
 {
-	int r = 0;
 	size_t len = size;
 	struct omap_dss_device *dssdev = NULL;
-	struct omap_dss_device *curr_display;
 
 	int match(struct omap_dss_device *dssdev, void *data)
 	{
@@ -73,12 +71,25 @@ static ssize_t manager_display_store(struct omap_overlay_manager *mgr,
 		return -EINVAL;
 
 	if (dssdev)
-		DSSDBG("display %s found\n", dssdev->name);
+		DSSDBG("device %s found\n", dssdev->name);
+
+	*pdssdev = dssdev;
+
+	return 0;
+}
+static int dss_mgr_set_output(struct omap_overlay_manager *mgr,
+		struct omap_dss_device *dssdev)
+{
+	int r;
+	struct omap_dss_device *curr_dssdev;
 
-	curr_display = mgr->get_display(mgr);
+	if (dssdev->wbdev)
+		curr_dssdev = mgr->get_writeback(mgr);
+	else
+		curr_dssdev = mgr->get_display(mgr);
 
-	if (curr_display) {
-		r = mgr->unset_device(mgr, curr_display);
+	if (curr_dssdev) {
+		r = mgr->unset_device(mgr, curr_dssdev);
 		if (r) {
 			DSSERR("failed to unset display\n");
 			goto put_device;
@@ -99,11 +110,30 @@ static ssize_t manager_display_store(struct omap_overlay_manager *mgr,
 		}
 	}
 
+	return 0;
+
 put_device:
 	if (dssdev)
 		omap_dss_put_device(dssdev);
 
-	return r ? r : size;
+	return r;
+}
+
+static ssize_t manager_display_store(struct omap_overlay_manager *mgr,
+		const char *buf, size_t size)
+{
+	int r;
+	struct omap_dss_device *dssdev;
+
+	r = dss_find_device_buf(&dssdev, buf, size);
+	if (r)
+		return r;
+
+	r = dss_mgr_set_output(mgr, dssdev);
+	if (r)
+		return r;
+
+	return size;
 }
 
 static ssize_t manager_default_color_show(struct omap_overlay_manager *mgr,
-- 
1.7.4.1

