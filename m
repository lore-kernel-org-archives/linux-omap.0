From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/32] OMAPDSS: create display-sysfs.c
Date: Thu, 15 Nov 2012 17:58:22 +0200
Message-ID: <1352995120-3288-15-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59125 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768251Ab2KOP7d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 10:59:33 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Move display sysfs related code from display.c to display-sysfs.c, for
clarity. The sysfs code will only be used for compat mode.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/Makefile        |    3 +-
 drivers/video/omap2/dss/display-sysfs.c |  321 +++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/display.c       |  281 +--------------------------
 drivers/video/omap2/dss/dss.h           |    5 +
 4 files changed, 331 insertions(+), 279 deletions(-)
 create mode 100644 drivers/video/omap2/dss/display-sysfs.c

diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index 4070191..af866d0 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_OMAP2_DSS) += omapdss.o
 omapdss-y := core.o dss.o dss_features.o dispc.o dispc_coefs.o display.o \
-	manager.o manager-sysfs.o overlay.o overlay-sysfs.o output.o apply.o
+	manager.o manager-sysfs.o overlay.o overlay-sysfs.o output.o apply.o \
+	display-sysfs.o
 omapdss-$(CONFIG_OMAP2_DSS_DPI) += dpi.o
 omapdss-$(CONFIG_OMAP2_DSS_RFBI) += rfbi.o
 omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o venc_panel.o
diff --git a/drivers/video/omap2/dss/display-sysfs.c b/drivers/video/omap2/dss/display-sysfs.c
new file mode 100644
index 0000000..18211a9
--- /dev/null
+++ b/drivers/video/omap2/dss/display-sysfs.c
@@ -0,0 +1,321 @@
+/*
+ * Copyright (C) 2009 Nokia Corporation
+ * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
+ *
+ * Some code and ideas taken from drivers/video/omap/ driver
+ * by Imre Deak.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define DSS_SUBSYS_NAME "DISPLAY"
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/jiffies.h>
+#include <linux/platform_device.h>
+
+#include <video/omapdss.h>
+#include "dss.h"
+#include "dss_features.h"
+
+static ssize_t display_enabled_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	bool enabled = dssdev->state != OMAP_DSS_DISPLAY_DISABLED;
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", enabled);
+}
+
+static ssize_t display_enabled_store(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	int r;
+	bool enabled;
+
+	r = strtobool(buf, &enabled);
+	if (r)
+		return r;
+
+	if (enabled != (dssdev->state != OMAP_DSS_DISPLAY_DISABLED)) {
+		if (enabled) {
+			r = dssdev->driver->enable(dssdev);
+			if (r)
+				return r;
+		} else {
+			dssdev->driver->disable(dssdev);
+		}
+	}
+
+	return size;
+}
+
+static ssize_t display_tear_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			dssdev->driver->get_te ?
+			dssdev->driver->get_te(dssdev) : 0);
+}
+
+static ssize_t display_tear_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	int r;
+	bool te;
+
+	if (!dssdev->driver->enable_te || !dssdev->driver->get_te)
+		return -ENOENT;
+
+	r = strtobool(buf, &te);
+	if (r)
+		return r;
+
+	r = dssdev->driver->enable_te(dssdev, te);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static ssize_t display_timings_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_video_timings t;
+
+	if (!dssdev->driver->get_timings)
+		return -ENOENT;
+
+	dssdev->driver->get_timings(dssdev, &t);
+
+	return snprintf(buf, PAGE_SIZE, "%u,%u/%u/%u/%u,%u/%u/%u/%u\n",
+			t.pixel_clock,
+			t.x_res, t.hfp, t.hbp, t.hsw,
+			t.y_res, t.vfp, t.vbp, t.vsw);
+}
+
+static ssize_t display_timings_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	struct omap_video_timings t = dssdev->panel.timings;
+	int r, found;
+
+	if (!dssdev->driver->set_timings || !dssdev->driver->check_timings)
+		return -ENOENT;
+
+	found = 0;
+#ifdef CONFIG_OMAP2_DSS_VENC
+	if (strncmp("pal", buf, 3) == 0) {
+		t = omap_dss_pal_timings;
+		found = 1;
+	} else if (strncmp("ntsc", buf, 4) == 0) {
+		t = omap_dss_ntsc_timings;
+		found = 1;
+	}
+#endif
+	if (!found && sscanf(buf, "%u,%hu/%hu/%hu/%hu,%hu/%hu/%hu/%hu",
+				&t.pixel_clock,
+				&t.x_res, &t.hfp, &t.hbp, &t.hsw,
+				&t.y_res, &t.vfp, &t.vbp, &t.vsw) != 9)
+		return -EINVAL;
+
+	r = dssdev->driver->check_timings(dssdev, &t);
+	if (r)
+		return r;
+
+	dssdev->driver->disable(dssdev);
+	dssdev->driver->set_timings(dssdev, &t);
+	r = dssdev->driver->enable(dssdev);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static ssize_t display_rotate_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	int rotate;
+	if (!dssdev->driver->get_rotate)
+		return -ENOENT;
+	rotate = dssdev->driver->get_rotate(dssdev);
+	return snprintf(buf, PAGE_SIZE, "%u\n", rotate);
+}
+
+static ssize_t display_rotate_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	int rot, r;
+
+	if (!dssdev->driver->set_rotate || !dssdev->driver->get_rotate)
+		return -ENOENT;
+
+	r = kstrtoint(buf, 0, &rot);
+	if (r)
+		return r;
+
+	r = dssdev->driver->set_rotate(dssdev, rot);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static ssize_t display_mirror_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	int mirror;
+	if (!dssdev->driver->get_mirror)
+		return -ENOENT;
+	mirror = dssdev->driver->get_mirror(dssdev);
+	return snprintf(buf, PAGE_SIZE, "%u\n", mirror);
+}
+
+static ssize_t display_mirror_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	int r;
+	bool mirror;
+
+	if (!dssdev->driver->set_mirror || !dssdev->driver->get_mirror)
+		return -ENOENT;
+
+	r = strtobool(buf, &mirror);
+	if (r)
+		return r;
+
+	r = dssdev->driver->set_mirror(dssdev, mirror);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static ssize_t display_wss_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	unsigned int wss;
+
+	if (!dssdev->driver->get_wss)
+		return -ENOENT;
+
+	wss = dssdev->driver->get_wss(dssdev);
+
+	return snprintf(buf, PAGE_SIZE, "0x%05x\n", wss);
+}
+
+static ssize_t display_wss_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct omap_dss_device *dssdev = to_dss_device(dev);
+	u32 wss;
+	int r;
+
+	if (!dssdev->driver->get_wss || !dssdev->driver->set_wss)
+		return -ENOENT;
+
+	r = kstrtou32(buf, 0, &wss);
+	if (r)
+		return r;
+
+	if (wss > 0xfffff)
+		return -EINVAL;
+
+	r = dssdev->driver->set_wss(dssdev, wss);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static DEVICE_ATTR(enabled, S_IRUGO|S_IWUSR,
+		display_enabled_show, display_enabled_store);
+static DEVICE_ATTR(tear_elim, S_IRUGO|S_IWUSR,
+		display_tear_show, display_tear_store);
+static DEVICE_ATTR(timings, S_IRUGO|S_IWUSR,
+		display_timings_show, display_timings_store);
+static DEVICE_ATTR(rotate, S_IRUGO|S_IWUSR,
+		display_rotate_show, display_rotate_store);
+static DEVICE_ATTR(mirror, S_IRUGO|S_IWUSR,
+		display_mirror_show, display_mirror_store);
+static DEVICE_ATTR(wss, S_IRUGO|S_IWUSR,
+		display_wss_show, display_wss_store);
+
+static struct device_attribute *display_sysfs_attrs[] = {
+	&dev_attr_enabled,
+	&dev_attr_tear_elim,
+	&dev_attr_timings,
+	&dev_attr_rotate,
+	&dev_attr_mirror,
+	&dev_attr_wss,
+	NULL
+};
+
+int display_init_sysfs(struct platform_device *pdev,
+		struct omap_dss_device *dssdev)
+{
+	struct device_attribute *attr;
+	int i, r;
+
+	/* create device sysfs files */
+	i = 0;
+	while ((attr = display_sysfs_attrs[i++]) != NULL) {
+		r = device_create_file(&dssdev->dev, attr);
+		if (r) {
+			for (i = i - 2; i >= 0; i--) {
+				attr = display_sysfs_attrs[i];
+				device_remove_file(&dssdev->dev, attr);
+			}
+
+			DSSERR("failed to create sysfs file\n");
+			return r;
+		}
+	}
+
+	/* create display? sysfs links */
+	r = sysfs_create_link(&pdev->dev.kobj, &dssdev->dev.kobj,
+			dev_name(&dssdev->dev));
+	if (r) {
+		while ((attr = display_sysfs_attrs[i++]) != NULL)
+			device_remove_file(&dssdev->dev, attr);
+
+		DSSERR("failed to create sysfs display link\n");
+		return r;
+	}
+
+	return 0;
+}
+
+void display_uninit_sysfs(struct platform_device *pdev,
+		struct omap_dss_device *dssdev)
+{
+	struct device_attribute *attr;
+	int i = 0;
+
+	sysfs_remove_link(&pdev->dev.kobj, dev_name(&dssdev->dev));
+
+	while ((attr = display_sysfs_attrs[i++]) != NULL)
+		device_remove_file(&dssdev->dev, attr);
+}
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 6d33112..008e9ee 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -31,250 +31,6 @@
 #include "dss.h"
 #include "dss_features.h"
 
-static ssize_t display_enabled_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	bool enabled = dssdev->state != OMAP_DSS_DISPLAY_DISABLED;
-
-	return snprintf(buf, PAGE_SIZE, "%d\n", enabled);
-}
-
-static ssize_t display_enabled_store(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf, size_t size)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	int r;
-	bool enabled;
-
-	r = strtobool(buf, &enabled);
-	if (r)
-		return r;
-
-	if (enabled != (dssdev->state != OMAP_DSS_DISPLAY_DISABLED)) {
-		if (enabled) {
-			r = dssdev->driver->enable(dssdev);
-			if (r)
-				return r;
-		} else {
-			dssdev->driver->disable(dssdev);
-		}
-	}
-
-	return size;
-}
-
-static ssize_t display_tear_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			dssdev->driver->get_te ?
-			dssdev->driver->get_te(dssdev) : 0);
-}
-
-static ssize_t display_tear_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t size)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	int r;
-	bool te;
-
-	if (!dssdev->driver->enable_te || !dssdev->driver->get_te)
-		return -ENOENT;
-
-	r = strtobool(buf, &te);
-	if (r)
-		return r;
-
-	r = dssdev->driver->enable_te(dssdev, te);
-	if (r)
-		return r;
-
-	return size;
-}
-
-static ssize_t display_timings_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	struct omap_video_timings t;
-
-	if (!dssdev->driver->get_timings)
-		return -ENOENT;
-
-	dssdev->driver->get_timings(dssdev, &t);
-
-	return snprintf(buf, PAGE_SIZE, "%u,%u/%u/%u/%u,%u/%u/%u/%u\n",
-			t.pixel_clock,
-			t.x_res, t.hfp, t.hbp, t.hsw,
-			t.y_res, t.vfp, t.vbp, t.vsw);
-}
-
-static ssize_t display_timings_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t size)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	struct omap_video_timings t = dssdev->panel.timings;
-	int r, found;
-
-	if (!dssdev->driver->set_timings || !dssdev->driver->check_timings)
-		return -ENOENT;
-
-	found = 0;
-#ifdef CONFIG_OMAP2_DSS_VENC
-	if (strncmp("pal", buf, 3) == 0) {
-		t = omap_dss_pal_timings;
-		found = 1;
-	} else if (strncmp("ntsc", buf, 4) == 0) {
-		t = omap_dss_ntsc_timings;
-		found = 1;
-	}
-#endif
-	if (!found && sscanf(buf, "%u,%hu/%hu/%hu/%hu,%hu/%hu/%hu/%hu",
-				&t.pixel_clock,
-				&t.x_res, &t.hfp, &t.hbp, &t.hsw,
-				&t.y_res, &t.vfp, &t.vbp, &t.vsw) != 9)
-		return -EINVAL;
-
-	r = dssdev->driver->check_timings(dssdev, &t);
-	if (r)
-		return r;
-
-	dssdev->driver->disable(dssdev);
-	dssdev->driver->set_timings(dssdev, &t);
-	r = dssdev->driver->enable(dssdev);
-	if (r)
-		return r;
-
-	return size;
-}
-
-static ssize_t display_rotate_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	int rotate;
-	if (!dssdev->driver->get_rotate)
-		return -ENOENT;
-	rotate = dssdev->driver->get_rotate(dssdev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", rotate);
-}
-
-static ssize_t display_rotate_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t size)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	int rot, r;
-
-	if (!dssdev->driver->set_rotate || !dssdev->driver->get_rotate)
-		return -ENOENT;
-
-	r = kstrtoint(buf, 0, &rot);
-	if (r)
-		return r;
-
-	r = dssdev->driver->set_rotate(dssdev, rot);
-	if (r)
-		return r;
-
-	return size;
-}
-
-static ssize_t display_mirror_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	int mirror;
-	if (!dssdev->driver->get_mirror)
-		return -ENOENT;
-	mirror = dssdev->driver->get_mirror(dssdev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", mirror);
-}
-
-static ssize_t display_mirror_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t size)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	int r;
-	bool mirror;
-
-	if (!dssdev->driver->set_mirror || !dssdev->driver->get_mirror)
-		return -ENOENT;
-
-	r = strtobool(buf, &mirror);
-	if (r)
-		return r;
-
-	r = dssdev->driver->set_mirror(dssdev, mirror);
-	if (r)
-		return r;
-
-	return size;
-}
-
-static ssize_t display_wss_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	unsigned int wss;
-
-	if (!dssdev->driver->get_wss)
-		return -ENOENT;
-
-	wss = dssdev->driver->get_wss(dssdev);
-
-	return snprintf(buf, PAGE_SIZE, "0x%05x\n", wss);
-}
-
-static ssize_t display_wss_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t size)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	u32 wss;
-	int r;
-
-	if (!dssdev->driver->get_wss || !dssdev->driver->set_wss)
-		return -ENOENT;
-
-	r = kstrtou32(buf, 0, &wss);
-	if (r)
-		return r;
-
-	if (wss > 0xfffff)
-		return -EINVAL;
-
-	r = dssdev->driver->set_wss(dssdev, wss);
-	if (r)
-		return r;
-
-	return size;
-}
-
-static DEVICE_ATTR(enabled, S_IRUGO|S_IWUSR,
-		display_enabled_show, display_enabled_store);
-static DEVICE_ATTR(tear_elim, S_IRUGO|S_IWUSR,
-		display_tear_show, display_tear_store);
-static DEVICE_ATTR(timings, S_IRUGO|S_IWUSR,
-		display_timings_show, display_timings_store);
-static DEVICE_ATTR(rotate, S_IRUGO|S_IWUSR,
-		display_rotate_show, display_rotate_store);
-static DEVICE_ATTR(mirror, S_IRUGO|S_IWUSR,
-		display_mirror_show, display_mirror_store);
-static DEVICE_ATTR(wss, S_IRUGO|S_IWUSR,
-		display_wss_show, display_wss_store);
-
-static struct device_attribute *display_sysfs_attrs[] = {
-	&dev_attr_enabled,
-	&dev_attr_tear_elim,
-	&dev_attr_timings,
-	&dev_attr_rotate,
-	&dev_attr_mirror,
-	&dev_attr_wss,
-	NULL
-};
-
 void omapdss_default_get_resolution(struct omap_dss_device *dssdev,
 			u16 *xres, u16 *yres)
 {
@@ -323,9 +79,8 @@ EXPORT_SYMBOL(omapdss_default_get_timings);
 int dss_init_device(struct platform_device *pdev,
 		struct omap_dss_device *dssdev)
 {
-	struct device_attribute *attr;
 	struct omap_dss_output *out;
-	int i, r;
+	int r;
 
 	out = omapdss_get_output_from_dssdev(dssdev);
 
@@ -335,33 +90,9 @@ int dss_init_device(struct platform_device *pdev,
 		return r;
 	}
 
-	/* create device sysfs files */
-	i = 0;
-	while ((attr = display_sysfs_attrs[i++]) != NULL) {
-		r = device_create_file(&dssdev->dev, attr);
-		if (r) {
-			for (i = i - 2; i >= 0; i--) {
-				attr = display_sysfs_attrs[i];
-				device_remove_file(&dssdev->dev, attr);
-			}
-
-			omapdss_output_unset_device(dssdev->output);
-
-			DSSERR("failed to create sysfs file\n");
-			return r;
-		}
-	}
-
-	/* create display? sysfs links */
-	r = sysfs_create_link(&pdev->dev.kobj, &dssdev->dev.kobj,
-			dev_name(&dssdev->dev));
+	r = display_init_sysfs(pdev, dssdev);
 	if (r) {
-		while ((attr = display_sysfs_attrs[i++]) != NULL)
-			device_remove_file(&dssdev->dev, attr);
-
 		omapdss_output_unset_device(dssdev->output);
-
-		DSSERR("failed to create sysfs display link\n");
 		return r;
 	}
 
@@ -371,13 +102,7 @@ int dss_init_device(struct platform_device *pdev,
 void dss_uninit_device(struct platform_device *pdev,
 		struct omap_dss_device *dssdev)
 {
-	struct device_attribute *attr;
-	int i = 0;
-
-	sysfs_remove_link(&pdev->dev.kobj, dev_name(&dssdev->dev));
-
-	while ((attr = display_sysfs_attrs[i++]) != NULL)
-		device_remove_file(&dssdev->dev, attr);
+	display_uninit_sysfs(pdev, dssdev);
 
 	if (dssdev->output)
 		omapdss_output_unset_device(dssdev->output);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 09d0651..6c3cfb33 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -224,6 +224,11 @@ int dss_init_device(struct platform_device *pdev,
 void dss_uninit_device(struct platform_device *pdev,
 		struct omap_dss_device *dssdev);
 
+int display_init_sysfs(struct platform_device *pdev,
+		struct omap_dss_device *dssdev);
+void display_uninit_sysfs(struct platform_device *pdev,
+		struct omap_dss_device *dssdev);
+
 /* manager */
 int dss_init_overlay_managers(struct platform_device *pdev);
 void dss_uninit_overlay_managers(struct platform_device *pdev);
-- 
1.7.10.4

