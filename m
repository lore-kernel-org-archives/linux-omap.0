From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/26] OMAPDSS: implement display sysfs without dss bus
Date: Tue, 26 Mar 2013 15:33:40 +0200
Message-ID: <1364304836-18134-11-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55864 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934336Ab3CZNep (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 09:34:45 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We aim to remove the custom omapdss bus totally, as it's quite a strange
construct and won't be compatible with common display framework. One
problem on the road is that we have sysfs files for each display, and
they depend on the omapdss bus.

This patch creates the display sysfs files independent of the omapdss
bus. This gives us backwards compatibility without using the omapdss bus
for the sysfs files.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c         |   15 ++--
 drivers/video/omap2/dss/core.c          |   28 -------
 drivers/video/omap2/dss/display-sysfs.c |  125 ++++++++++++++++++-------------
 drivers/video/omap2/dss/dss.h           |    6 +-
 4 files changed, 79 insertions(+), 95 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index a4b356a..44f94b8 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1569,7 +1569,6 @@ static DEFINE_MUTEX(compat_init_lock);
 int omapdss_compat_init(void)
 {
 	struct platform_device *pdev = dss_get_core_pdev();
-	struct omap_dss_device *dssdev = NULL;
 	int i, r;
 
 	mutex_lock(&compat_init_lock);
@@ -1615,12 +1614,9 @@ int omapdss_compat_init(void)
 	if (r)
 		goto err_mgr_ops;
 
-	for_each_dss_dev(dssdev) {
-		r = display_init_sysfs(pdev, dssdev);
-		/* XXX uninit sysfs files on error */
-		if (r)
-			goto err_disp_sysfs;
-	}
+	r = display_init_sysfs(pdev);
+	if (r)
+		goto err_disp_sysfs;
 
 	dispc_runtime_get();
 
@@ -1637,6 +1633,7 @@ out:
 
 err_init_irq:
 	dispc_runtime_put();
+	display_uninit_sysfs(pdev);
 
 err_disp_sysfs:
 	dss_uninstall_mgr_ops();
@@ -1656,7 +1653,6 @@ EXPORT_SYMBOL(omapdss_compat_init);
 void omapdss_compat_uninit(void)
 {
 	struct platform_device *pdev = dss_get_core_pdev();
-	struct omap_dss_device *dssdev = NULL;
 
 	mutex_lock(&compat_init_lock);
 
@@ -1665,8 +1661,7 @@ void omapdss_compat_uninit(void)
 
 	dss_dispc_uninitialize_irq();
 
-	for_each_dss_dev(dssdev)
-		display_uninit_sysfs(pdev, dssdev);
+	display_uninit_sysfs(pdev);
 
 	dss_uninstall_mgr_ops();
 
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 5bdd442..054e980 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -287,37 +287,9 @@ static int dss_bus_match(struct device *dev, struct device_driver *driver)
 	return strcmp(dssdev->driver_name, driver->name) == 0;
 }
 
-static ssize_t device_name_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			dssdev->name ?
-			dssdev->name : "");
-}
-
-static struct device_attribute default_dev_attrs[] = {
-	__ATTR(name, S_IRUGO, device_name_show, NULL),
-	__ATTR_NULL,
-};
-
-static ssize_t driver_name_show(struct device_driver *drv, char *buf)
-{
-	struct omap_dss_driver *dssdrv = to_dss_driver(drv);
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			dssdrv->driver.name ?
-			dssdrv->driver.name : "");
-}
-static struct driver_attribute default_drv_attrs[] = {
-	__ATTR(name, S_IRUGO, driver_name_show, NULL),
-	__ATTR_NULL,
-};
-
 static struct bus_type dss_bus_type = {
 	.name = "omapdss",
 	.match = dss_bus_match,
-	.dev_attrs = default_dev_attrs,
-	.drv_attrs = default_drv_attrs,
 };
 
 static void dss_bus_release(struct device *dev)
diff --git a/drivers/video/omap2/dss/display-sysfs.c b/drivers/video/omap2/dss/display-sysfs.c
index 18211a9..537921b 100644
--- a/drivers/video/omap2/dss/display-sysfs.c
+++ b/drivers/video/omap2/dss/display-sysfs.c
@@ -22,17 +22,40 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/jiffies.h>
 #include <linux/platform_device.h>
+#include <linux/sysfs.h>
 
 #include <video/omapdss.h>
 #include "dss.h"
-#include "dss_features.h"
+
+static struct omap_dss_device *to_dss_device_sysfs(struct device *dev)
+{
+	struct omap_dss_device *dssdev = NULL;
+
+	for_each_dss_dev(dssdev) {
+		if (&dssdev->dev == dev) {
+			omap_dss_put_device(dssdev);
+			return dssdev;
+		}
+	}
+
+	return NULL;
+}
+
+static ssize_t display_name_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_device *dssdev = to_dss_device_sysfs(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			dssdev->name ?
+			dssdev->name : "");
+}
 
 static ssize_t display_enabled_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_device *dssdev = to_dss_device_sysfs(dev);
 	bool enabled = dssdev->state != OMAP_DSS_DISPLAY_DISABLED;
 
 	return snprintf(buf, PAGE_SIZE, "%d\n", enabled);
@@ -42,7 +65,7 @@ static ssize_t display_enabled_store(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf, size_t size)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_device *dssdev = to_dss_device_sysfs(dev);
 	int r;
 	bool enabled;
 
@@ -66,7 +89,7 @@ static ssize_t display_enabled_store(struct device *dev,
 static ssize_t display_tear_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_device *dssdev = to_dss_device_sysfs(dev);
 	return snprintf(buf, PAGE_SIZE, "%d\n",
 			dssdev->driver->get_te ?
 			dssdev->driver->get_te(dssdev) : 0);
@@ -75,7 +98,7 @@ static ssize_t display_tear_show(struct device *dev,
 static ssize_t display_tear_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t size)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_device *dssdev = to_dss_device_sysfs(dev);
 	int r;
 	bool te;
 
@@ -96,7 +119,7 @@ static ssize_t display_tear_store(struct device *dev,
 static ssize_t display_timings_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_device *dssdev = to_dss_device_sysfs(dev);
 	struct omap_video_timings t;
 
 	if (!dssdev->driver->get_timings)
@@ -113,7 +136,7 @@ static ssize_t display_timings_show(struct device *dev,
 static ssize_t display_timings_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t size)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_device *dssdev = to_dss_device_sysfs(dev);
 	struct omap_video_timings t = dssdev->panel.timings;
 	int r, found;
 
@@ -152,7 +175,7 @@ static ssize_t display_timings_store(struct device *dev,
 static ssize_t display_rotate_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_device *dssdev = to_dss_device_sysfs(dev);
 	int rotate;
 	if (!dssdev->driver->get_rotate)
 		return -ENOENT;
@@ -163,7 +186,7 @@ static ssize_t display_rotate_show(struct device *dev,
 static ssize_t display_rotate_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t size)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_device *dssdev = to_dss_device_sysfs(dev);
 	int rot, r;
 
 	if (!dssdev->driver->set_rotate || !dssdev->driver->get_rotate)
@@ -183,7 +206,7 @@ static ssize_t display_rotate_store(struct device *dev,
 static ssize_t display_mirror_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_device *dssdev = to_dss_device_sysfs(dev);
 	int mirror;
 	if (!dssdev->driver->get_mirror)
 		return -ENOENT;
@@ -194,7 +217,7 @@ static ssize_t display_mirror_show(struct device *dev,
 static ssize_t display_mirror_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t size)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_device *dssdev = to_dss_device_sysfs(dev);
 	int r;
 	bool mirror;
 
@@ -215,7 +238,7 @@ static ssize_t display_mirror_store(struct device *dev,
 static ssize_t display_wss_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_device *dssdev = to_dss_device_sysfs(dev);
 	unsigned int wss;
 
 	if (!dssdev->driver->get_wss)
@@ -229,7 +252,7 @@ static ssize_t display_wss_show(struct device *dev,
 static ssize_t display_wss_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t size)
 {
-	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_dss_device *dssdev = to_dss_device_sysfs(dev);
 	u32 wss;
 	int r;
 
@@ -250,6 +273,7 @@ static ssize_t display_wss_store(struct device *dev,
 	return size;
 }
 
+static DEVICE_ATTR(name, S_IRUGO, display_name_show, NULL);
 static DEVICE_ATTR(enabled, S_IRUGO|S_IWUSR,
 		display_enabled_show, display_enabled_store);
 static DEVICE_ATTR(tear_elim, S_IRUGO|S_IWUSR,
@@ -263,59 +287,54 @@ static DEVICE_ATTR(mirror, S_IRUGO|S_IWUSR,
 static DEVICE_ATTR(wss, S_IRUGO|S_IWUSR,
 		display_wss_show, display_wss_store);
 
-static struct device_attribute *display_sysfs_attrs[] = {
-	&dev_attr_enabled,
-	&dev_attr_tear_elim,
-	&dev_attr_timings,
-	&dev_attr_rotate,
-	&dev_attr_mirror,
-	&dev_attr_wss,
+static const struct attribute *display_sysfs_attrs[] = {
+	&dev_attr_name.attr,
+	&dev_attr_enabled.attr,
+	&dev_attr_tear_elim.attr,
+	&dev_attr_timings.attr,
+	&dev_attr_rotate.attr,
+	&dev_attr_mirror.attr,
+	&dev_attr_wss.attr,
 	NULL
 };
 
-int display_init_sysfs(struct platform_device *pdev,
-		struct omap_dss_device *dssdev)
+int display_init_sysfs(struct platform_device *pdev)
 {
-	struct device_attribute *attr;
-	int i, r;
+	struct omap_dss_device *dssdev = NULL;
+	int r;
 
-	/* create device sysfs files */
-	i = 0;
-	while ((attr = display_sysfs_attrs[i++]) != NULL) {
-		r = device_create_file(&dssdev->dev, attr);
-		if (r) {
-			for (i = i - 2; i >= 0; i--) {
-				attr = display_sysfs_attrs[i];
-				device_remove_file(&dssdev->dev, attr);
-			}
+	for_each_dss_dev(dssdev) {
+		struct kobject *kobj = &dssdev->dev.kobj;
 
-			DSSERR("failed to create sysfs file\n");
-			return r;
+		r = sysfs_create_files(kobj, display_sysfs_attrs);
+		if (r) {
+			DSSERR("failed to create sysfs files\n");
+			goto err;
 		}
-	}
 
-	/* create display? sysfs links */
-	r = sysfs_create_link(&pdev->dev.kobj, &dssdev->dev.kobj,
-			dev_name(&dssdev->dev));
-	if (r) {
-		while ((attr = display_sysfs_attrs[i++]) != NULL)
-			device_remove_file(&dssdev->dev, attr);
+		r = sysfs_create_link(&pdev->dev.kobj, kobj, dssdev->alias);
+		if (r) {
+			sysfs_remove_files(kobj, display_sysfs_attrs);
 
-		DSSERR("failed to create sysfs display link\n");
-		return r;
+			DSSERR("failed to create sysfs display link\n");
+			goto err;
+		}
 	}
 
 	return 0;
+
+err:
+	display_uninit_sysfs(pdev);
+
+	return r;
 }
 
-void display_uninit_sysfs(struct platform_device *pdev,
-		struct omap_dss_device *dssdev)
+void display_uninit_sysfs(struct platform_device *pdev)
 {
-	struct device_attribute *attr;
-	int i = 0;
+	struct omap_dss_device *dssdev = NULL;
 
-	sysfs_remove_link(&pdev->dev.kobj, dev_name(&dssdev->dev));
-
-	while ((attr = display_sysfs_attrs[i++]) != NULL)
-		device_remove_file(&dssdev->dev, attr);
+	for_each_dss_dev(dssdev) {
+		sysfs_remove_link(&pdev->dev.kobj, dssdev->alias);
+		sysfs_remove_files(&dssdev->dev.kobj, display_sysfs_attrs);
+	}
 }
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 5252423..d603a40 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -188,10 +188,8 @@ int dss_suspend_all_devices(void);
 int dss_resume_all_devices(void);
 void dss_disable_all_devices(void);
 
-int display_init_sysfs(struct platform_device *pdev,
-		struct omap_dss_device *dssdev);
-void display_uninit_sysfs(struct platform_device *pdev,
-		struct omap_dss_device *dssdev);
+int display_init_sysfs(struct platform_device *pdev);
+void display_uninit_sysfs(struct platform_device *pdev);
 
 /* manager */
 int dss_init_overlay_managers(struct platform_device *pdev);
-- 
1.7.10.4

