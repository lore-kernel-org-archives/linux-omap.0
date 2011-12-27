From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 28/29] OMAPDSS: MANAGER: Add writeback as a sysfs attribute
Date: Tue, 27 Dec 2011 18:07:11 +0530
Message-ID: <1324989432-3625-29-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58094 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753752Ab1L0MkU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Dec 2011 07:40:20 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Add writeback as a sysfs attribute. This can be used to show and store the dummy
writeback panel that the manager can connect to.

Add checks so that in the store functions so that a display store cant set a
writeback device and vice versa.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/manager.c |   38 +++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index fb7c1e6..a064656 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -129,6 +129,41 @@ static ssize_t manager_display_store(struct omap_overlay_manager *mgr,
 	if (r)
 		return r;
 
+	if (dssdev->wbdev) {
+		r = -EINVAL;
+		return r;
+	}
+
+	r = dss_mgr_set_output(mgr, dssdev);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static ssize_t manager_writeback_show(struct omap_overlay_manager *mgr, char *buf)
+{
+	struct omap_dss_device *wb_device = mgr->get_writeback(mgr);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", wb_device ?
+			wb_device->name : "<none>");
+}
+
+static ssize_t manager_writeback_store(struct omap_overlay_manager *mgr,
+		const char *buf, size_t size)
+{
+	int r;
+	struct omap_dss_device *dssdev;
+
+	r = dss_find_device_buf(&dssdev, buf, size);
+	if (r)
+		return r;
+
+	if (!dssdev->wbdev) {
+		r = -EINVAL;
+		return r;
+	}
+
 	r = dss_mgr_set_output(mgr, dssdev);
 	if (r)
 		return r;
@@ -452,6 +487,8 @@ struct manager_attribute {
 static MANAGER_ATTR(name, S_IRUGO, manager_name_show, NULL);
 static MANAGER_ATTR(display, S_IRUGO|S_IWUSR,
 		manager_display_show, manager_display_store);
+static MANAGER_ATTR(writeback, S_IRUGO|S_IWUSR,
+		manager_writeback_show, manager_writeback_store);
 static MANAGER_ATTR(default_color, S_IRUGO|S_IWUSR,
 		manager_default_color_show, manager_default_color_store);
 static MANAGER_ATTR(trans_key_type, S_IRUGO|S_IWUSR,
@@ -475,6 +512,7 @@ static MANAGER_ATTR(cpr_coef, S_IRUGO|S_IWUSR,
 static struct attribute *manager_sysfs_attrs[] = {
 	&manager_attr_name.attr,
 	&manager_attr_display.attr,
+	&manager_attr_writeback.attr,
 	&manager_attr_default_color.attr,
 	&manager_attr_trans_key_type.attr,
 	&manager_attr_trans_key_value.attr,
-- 
1.7.4.1

