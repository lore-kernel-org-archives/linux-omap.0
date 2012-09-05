From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/17] OMAPDSS: split overlay sysfs code
Date: Wed,  5 Sep 2012 11:25:47 +0300
Message-ID: <1346833555-31258-10-git-send-email-tomi.valkeinen@ti.com>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:57571 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758103Ab2IEI0a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 04:26:30 -0400
Received: by lagy9 with SMTP id y9so139373lag.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 01:26:27 -0700 (PDT)
In-Reply-To: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Separate sysfs code for overlays to a separate file. This is a bit
cleaner, and will allow us later to easily switch off the sysfs support
via Kconfig option.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/Makefile        |    2 +-
 drivers/video/omap2/dss/dss.h           |    3 +
 drivers/video/omap2/dss/overlay-sysfs.c |  456 +++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/overlay.c       |  420 +---------------------------
 4 files changed, 462 insertions(+), 419 deletions(-)
 create mode 100644 drivers/video/omap2/dss/overlay-sysfs.c

diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index 30a48fb..927d5ce 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_OMAP2_DSS) += omapdss.o
 omapdss-y := core.o dss.o dss_features.o dispc.o dispc_coefs.o display.o \
-	manager.o overlay.o apply.o
+	manager.o overlay.o overlay-sysfs.o apply.o
 omapdss-$(CONFIG_OMAP2_DSS_DPI) += dpi.o
 omapdss-$(CONFIG_OMAP2_DSS_RFBI) += rfbi.o
 omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o venc_panel.o
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index d6cca82..11b053e 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -265,6 +265,9 @@ int dss_ovl_check(struct omap_overlay *ovl, struct omap_overlay_info *info,
 		const struct omap_video_timings *mgr_timings);
 bool dss_ovl_use_replication(struct dss_lcd_mgr_config config,
 		enum omap_color_mode mode);
+int dss_overlay_kobj_init(struct omap_overlay *ovl,
+		struct platform_device *pdev);
+void dss_overlay_kobj_uninit(struct omap_overlay *ovl);
 
 /* DSS */
 int dss_init_platform_driver(void) __init;
diff --git a/drivers/video/omap2/dss/overlay-sysfs.c b/drivers/video/omap2/dss/overlay-sysfs.c
new file mode 100644
index 0000000..4cc5dde
--- /dev/null
+++ b/drivers/video/omap2/dss/overlay-sysfs.c
@@ -0,0 +1,456 @@
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
+#define DSS_SUBSYS_NAME "OVERLAY"
+
+#include <linux/module.h>
+#include <linux/err.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
+#include <linux/platform_device.h>
+
+#include <video/omapdss.h>
+
+#include "dss.h"
+#include "dss_features.h"
+
+static ssize_t overlay_name_show(struct omap_overlay *ovl, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n", ovl->name);
+}
+
+static ssize_t overlay_manager_show(struct omap_overlay *ovl, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			ovl->manager ? ovl->manager->name : "<none>");
+}
+
+static ssize_t overlay_manager_store(struct omap_overlay *ovl, const char *buf,
+		size_t size)
+{
+	int i, r;
+	struct omap_overlay_manager *mgr = NULL;
+	struct omap_overlay_manager *old_mgr;
+	int len = size;
+
+	if (buf[size-1] == '\n')
+		--len;
+
+	if (len > 0) {
+		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
+			mgr = omap_dss_get_overlay_manager(i);
+
+			if (sysfs_streq(buf, mgr->name))
+				break;
+
+			mgr = NULL;
+		}
+	}
+
+	if (len > 0 && mgr == NULL)
+		return -EINVAL;
+
+	if (mgr)
+		DSSDBG("manager %s found\n", mgr->name);
+
+	if (mgr == ovl->manager)
+		return size;
+
+	old_mgr = ovl->manager;
+
+	r = dispc_runtime_get();
+	if (r)
+		return r;
+
+	/* detach old manager */
+	if (old_mgr) {
+		r = ovl->unset_manager(ovl);
+		if (r) {
+			DSSERR("detach failed\n");
+			goto err;
+		}
+
+		r = old_mgr->apply(old_mgr);
+		if (r)
+			goto err;
+	}
+
+	if (mgr) {
+		r = ovl->set_manager(ovl, mgr);
+		if (r) {
+			DSSERR("Failed to attach overlay\n");
+			goto err;
+		}
+
+		r = mgr->apply(mgr);
+		if (r)
+			goto err;
+	}
+
+	dispc_runtime_put();
+
+	return size;
+
+err:
+	dispc_runtime_put();
+	return r;
+}
+
+static ssize_t overlay_input_size_show(struct omap_overlay *ovl, char *buf)
+{
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%d,%d\n",
+			info.width, info.height);
+}
+
+static ssize_t overlay_screen_width_show(struct omap_overlay *ovl, char *buf)
+{
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", info.screen_width);
+}
+
+static ssize_t overlay_position_show(struct omap_overlay *ovl, char *buf)
+{
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%d,%d\n",
+			info.pos_x, info.pos_y);
+}
+
+static ssize_t overlay_position_store(struct omap_overlay *ovl,
+		const char *buf, size_t size)
+{
+	int r;
+	char *last;
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	info.pos_x = simple_strtoul(buf, &last, 10);
+	++last;
+	if (last - buf >= size)
+		return -EINVAL;
+
+	info.pos_y = simple_strtoul(last, &last, 10);
+
+	r = ovl->set_overlay_info(ovl, &info);
+	if (r)
+		return r;
+
+	if (ovl->manager) {
+		r = ovl->manager->apply(ovl->manager);
+		if (r)
+			return r;
+	}
+
+	return size;
+}
+
+static ssize_t overlay_output_size_show(struct omap_overlay *ovl, char *buf)
+{
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%d,%d\n",
+			info.out_width, info.out_height);
+}
+
+static ssize_t overlay_output_size_store(struct omap_overlay *ovl,
+		const char *buf, size_t size)
+{
+	int r;
+	char *last;
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	info.out_width = simple_strtoul(buf, &last, 10);
+	++last;
+	if (last - buf >= size)
+		return -EINVAL;
+
+	info.out_height = simple_strtoul(last, &last, 10);
+
+	r = ovl->set_overlay_info(ovl, &info);
+	if (r)
+		return r;
+
+	if (ovl->manager) {
+		r = ovl->manager->apply(ovl->manager);
+		if (r)
+			return r;
+	}
+
+	return size;
+}
+
+static ssize_t overlay_enabled_show(struct omap_overlay *ovl, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%d\n", ovl->is_enabled(ovl));
+}
+
+static ssize_t overlay_enabled_store(struct omap_overlay *ovl, const char *buf,
+		size_t size)
+{
+	int r;
+	bool enable;
+
+	r = strtobool(buf, &enable);
+	if (r)
+		return r;
+
+	if (enable)
+		r = ovl->enable(ovl);
+	else
+		r = ovl->disable(ovl);
+
+	if (r)
+		return r;
+
+	return size;
+}
+
+static ssize_t overlay_global_alpha_show(struct omap_overlay *ovl, char *buf)
+{
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			info.global_alpha);
+}
+
+static ssize_t overlay_global_alpha_store(struct omap_overlay *ovl,
+		const char *buf, size_t size)
+{
+	int r;
+	u8 alpha;
+	struct omap_overlay_info info;
+
+	if ((ovl->caps & OMAP_DSS_OVL_CAP_GLOBAL_ALPHA) == 0)
+		return -ENODEV;
+
+	r = kstrtou8(buf, 0, &alpha);
+	if (r)
+		return r;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	info.global_alpha = alpha;
+
+	r = ovl->set_overlay_info(ovl, &info);
+	if (r)
+		return r;
+
+	if (ovl->manager) {
+		r = ovl->manager->apply(ovl->manager);
+		if (r)
+			return r;
+	}
+
+	return size;
+}
+
+static ssize_t overlay_pre_mult_alpha_show(struct omap_overlay *ovl,
+		char *buf)
+{
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			info.pre_mult_alpha);
+}
+
+static ssize_t overlay_pre_mult_alpha_store(struct omap_overlay *ovl,
+		const char *buf, size_t size)
+{
+	int r;
+	u8 alpha;
+	struct omap_overlay_info info;
+
+	if ((ovl->caps & OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA) == 0)
+		return -ENODEV;
+
+	r = kstrtou8(buf, 0, &alpha);
+	if (r)
+		return r;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	info.pre_mult_alpha = alpha;
+
+	r = ovl->set_overlay_info(ovl, &info);
+	if (r)
+		return r;
+
+	if (ovl->manager) {
+		r = ovl->manager->apply(ovl->manager);
+		if (r)
+			return r;
+	}
+
+	return size;
+}
+
+static ssize_t overlay_zorder_show(struct omap_overlay *ovl, char *buf)
+{
+	struct omap_overlay_info info;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", info.zorder);
+}
+
+static ssize_t overlay_zorder_store(struct omap_overlay *ovl,
+		const char *buf, size_t size)
+{
+	int r;
+	u8 zorder;
+	struct omap_overlay_info info;
+
+	if ((ovl->caps & OMAP_DSS_OVL_CAP_ZORDER) == 0)
+		return -ENODEV;
+
+	r = kstrtou8(buf, 0, &zorder);
+	if (r)
+		return r;
+
+	ovl->get_overlay_info(ovl, &info);
+
+	info.zorder = zorder;
+
+	r = ovl->set_overlay_info(ovl, &info);
+	if (r)
+		return r;
+
+	if (ovl->manager) {
+		r = ovl->manager->apply(ovl->manager);
+		if (r)
+			return r;
+	}
+
+	return size;
+}
+
+struct overlay_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct omap_overlay *, char *);
+	ssize_t	(*store)(struct omap_overlay *, const char *, size_t);
+};
+
+#define OVERLAY_ATTR(_name, _mode, _show, _store) \
+	struct overlay_attribute overlay_attr_##_name = \
+	__ATTR(_name, _mode, _show, _store)
+
+static OVERLAY_ATTR(name, S_IRUGO, overlay_name_show, NULL);
+static OVERLAY_ATTR(manager, S_IRUGO|S_IWUSR,
+		overlay_manager_show, overlay_manager_store);
+static OVERLAY_ATTR(input_size, S_IRUGO, overlay_input_size_show, NULL);
+static OVERLAY_ATTR(screen_width, S_IRUGO, overlay_screen_width_show, NULL);
+static OVERLAY_ATTR(position, S_IRUGO|S_IWUSR,
+		overlay_position_show, overlay_position_store);
+static OVERLAY_ATTR(output_size, S_IRUGO|S_IWUSR,
+		overlay_output_size_show, overlay_output_size_store);
+static OVERLAY_ATTR(enabled, S_IRUGO|S_IWUSR,
+		overlay_enabled_show, overlay_enabled_store);
+static OVERLAY_ATTR(global_alpha, S_IRUGO|S_IWUSR,
+		overlay_global_alpha_show, overlay_global_alpha_store);
+static OVERLAY_ATTR(pre_mult_alpha, S_IRUGO|S_IWUSR,
+		overlay_pre_mult_alpha_show,
+		overlay_pre_mult_alpha_store);
+static OVERLAY_ATTR(zorder, S_IRUGO|S_IWUSR,
+		overlay_zorder_show, overlay_zorder_store);
+
+static struct attribute *overlay_sysfs_attrs[] = {
+	&overlay_attr_name.attr,
+	&overlay_attr_manager.attr,
+	&overlay_attr_input_size.attr,
+	&overlay_attr_screen_width.attr,
+	&overlay_attr_position.attr,
+	&overlay_attr_output_size.attr,
+	&overlay_attr_enabled.attr,
+	&overlay_attr_global_alpha.attr,
+	&overlay_attr_pre_mult_alpha.attr,
+	&overlay_attr_zorder.attr,
+	NULL
+};
+
+static ssize_t overlay_attr_show(struct kobject *kobj, struct attribute *attr,
+		char *buf)
+{
+	struct omap_overlay *overlay;
+	struct overlay_attribute *overlay_attr;
+
+	overlay = container_of(kobj, struct omap_overlay, kobj);
+	overlay_attr = container_of(attr, struct overlay_attribute, attr);
+
+	if (!overlay_attr->show)
+		return -ENOENT;
+
+	return overlay_attr->show(overlay, buf);
+}
+
+static ssize_t overlay_attr_store(struct kobject *kobj, struct attribute *attr,
+		const char *buf, size_t size)
+{
+	struct omap_overlay *overlay;
+	struct overlay_attribute *overlay_attr;
+
+	overlay = container_of(kobj, struct omap_overlay, kobj);
+	overlay_attr = container_of(attr, struct overlay_attribute, attr);
+
+	if (!overlay_attr->store)
+		return -ENOENT;
+
+	return overlay_attr->store(overlay, buf, size);
+}
+
+static const struct sysfs_ops overlay_sysfs_ops = {
+	.show = overlay_attr_show,
+	.store = overlay_attr_store,
+};
+
+static struct kobj_type overlay_ktype = {
+	.sysfs_ops = &overlay_sysfs_ops,
+	.default_attrs = overlay_sysfs_attrs,
+};
+
+int dss_overlay_kobj_init(struct omap_overlay *ovl,
+		struct platform_device *pdev)
+{
+	return kobject_init_and_add(&ovl->kobj, &overlay_ktype,
+			&pdev->dev.kobj, "overlay%d", ovl->id);
+}
+
+void dss_overlay_kobj_uninit(struct omap_overlay *ovl)
+{
+	kobject_del(&ovl->kobj);
+	kobject_put(&ovl->kobj);
+}
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 94e74be..e3d4068 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -26,7 +26,6 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/sysfs.h>
-#include <linux/kobject.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
@@ -39,417 +38,6 @@
 static int num_overlays;
 static struct omap_overlay *overlays;
 
-static ssize_t overlay_name_show(struct omap_overlay *ovl, char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%s\n", ovl->name);
-}
-
-static ssize_t overlay_manager_show(struct omap_overlay *ovl, char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			ovl->manager ? ovl->manager->name : "<none>");
-}
-
-static ssize_t overlay_manager_store(struct omap_overlay *ovl, const char *buf,
-		size_t size)
-{
-	int i, r;
-	struct omap_overlay_manager *mgr = NULL;
-	struct omap_overlay_manager *old_mgr;
-	int len = size;
-
-	if (buf[size-1] == '\n')
-		--len;
-
-	if (len > 0) {
-		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
-			mgr = omap_dss_get_overlay_manager(i);
-
-			if (sysfs_streq(buf, mgr->name))
-				break;
-
-			mgr = NULL;
-		}
-	}
-
-	if (len > 0 && mgr == NULL)
-		return -EINVAL;
-
-	if (mgr)
-		DSSDBG("manager %s found\n", mgr->name);
-
-	if (mgr == ovl->manager)
-		return size;
-
-	old_mgr = ovl->manager;
-
-	r = dispc_runtime_get();
-	if (r)
-		return r;
-
-	/* detach old manager */
-	if (old_mgr) {
-		r = ovl->unset_manager(ovl);
-		if (r) {
-			DSSERR("detach failed\n");
-			goto err;
-		}
-
-		r = old_mgr->apply(old_mgr);
-		if (r)
-			goto err;
-	}
-
-	if (mgr) {
-		r = ovl->set_manager(ovl, mgr);
-		if (r) {
-			DSSERR("Failed to attach overlay\n");
-			goto err;
-		}
-
-		r = mgr->apply(mgr);
-		if (r)
-			goto err;
-	}
-
-	dispc_runtime_put();
-
-	return size;
-
-err:
-	dispc_runtime_put();
-	return r;
-}
-
-static ssize_t overlay_input_size_show(struct omap_overlay *ovl, char *buf)
-{
-	struct omap_overlay_info info;
-
-	ovl->get_overlay_info(ovl, &info);
-
-	return snprintf(buf, PAGE_SIZE, "%d,%d\n",
-			info.width, info.height);
-}
-
-static ssize_t overlay_screen_width_show(struct omap_overlay *ovl, char *buf)
-{
-	struct omap_overlay_info info;
-
-	ovl->get_overlay_info(ovl, &info);
-
-	return snprintf(buf, PAGE_SIZE, "%d\n", info.screen_width);
-}
-
-static ssize_t overlay_position_show(struct omap_overlay *ovl, char *buf)
-{
-	struct omap_overlay_info info;
-
-	ovl->get_overlay_info(ovl, &info);
-
-	return snprintf(buf, PAGE_SIZE, "%d,%d\n",
-			info.pos_x, info.pos_y);
-}
-
-static ssize_t overlay_position_store(struct omap_overlay *ovl,
-		const char *buf, size_t size)
-{
-	int r;
-	char *last;
-	struct omap_overlay_info info;
-
-	ovl->get_overlay_info(ovl, &info);
-
-	info.pos_x = simple_strtoul(buf, &last, 10);
-	++last;
-	if (last - buf >= size)
-		return -EINVAL;
-
-	info.pos_y = simple_strtoul(last, &last, 10);
-
-	r = ovl->set_overlay_info(ovl, &info);
-	if (r)
-		return r;
-
-	if (ovl->manager) {
-		r = ovl->manager->apply(ovl->manager);
-		if (r)
-			return r;
-	}
-
-	return size;
-}
-
-static ssize_t overlay_output_size_show(struct omap_overlay *ovl, char *buf)
-{
-	struct omap_overlay_info info;
-
-	ovl->get_overlay_info(ovl, &info);
-
-	return snprintf(buf, PAGE_SIZE, "%d,%d\n",
-			info.out_width, info.out_height);
-}
-
-static ssize_t overlay_output_size_store(struct omap_overlay *ovl,
-		const char *buf, size_t size)
-{
-	int r;
-	char *last;
-	struct omap_overlay_info info;
-
-	ovl->get_overlay_info(ovl, &info);
-
-	info.out_width = simple_strtoul(buf, &last, 10);
-	++last;
-	if (last - buf >= size)
-		return -EINVAL;
-
-	info.out_height = simple_strtoul(last, &last, 10);
-
-	r = ovl->set_overlay_info(ovl, &info);
-	if (r)
-		return r;
-
-	if (ovl->manager) {
-		r = ovl->manager->apply(ovl->manager);
-		if (r)
-			return r;
-	}
-
-	return size;
-}
-
-static ssize_t overlay_enabled_show(struct omap_overlay *ovl, char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%d\n", ovl->is_enabled(ovl));
-}
-
-static ssize_t overlay_enabled_store(struct omap_overlay *ovl, const char *buf,
-		size_t size)
-{
-	int r;
-	bool enable;
-
-	r = strtobool(buf, &enable);
-	if (r)
-		return r;
-
-	if (enable)
-		r = ovl->enable(ovl);
-	else
-		r = ovl->disable(ovl);
-
-	if (r)
-		return r;
-
-	return size;
-}
-
-static ssize_t overlay_global_alpha_show(struct omap_overlay *ovl, char *buf)
-{
-	struct omap_overlay_info info;
-
-	ovl->get_overlay_info(ovl, &info);
-
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			info.global_alpha);
-}
-
-static ssize_t overlay_global_alpha_store(struct omap_overlay *ovl,
-		const char *buf, size_t size)
-{
-	int r;
-	u8 alpha;
-	struct omap_overlay_info info;
-
-	if ((ovl->caps & OMAP_DSS_OVL_CAP_GLOBAL_ALPHA) == 0)
-		return -ENODEV;
-
-	r = kstrtou8(buf, 0, &alpha);
-	if (r)
-		return r;
-
-	ovl->get_overlay_info(ovl, &info);
-
-	info.global_alpha = alpha;
-
-	r = ovl->set_overlay_info(ovl, &info);
-	if (r)
-		return r;
-
-	if (ovl->manager) {
-		r = ovl->manager->apply(ovl->manager);
-		if (r)
-			return r;
-	}
-
-	return size;
-}
-
-static ssize_t overlay_pre_mult_alpha_show(struct omap_overlay *ovl,
-		char *buf)
-{
-	struct omap_overlay_info info;
-
-	ovl->get_overlay_info(ovl, &info);
-
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			info.pre_mult_alpha);
-}
-
-static ssize_t overlay_pre_mult_alpha_store(struct omap_overlay *ovl,
-		const char *buf, size_t size)
-{
-	int r;
-	u8 alpha;
-	struct omap_overlay_info info;
-
-	if ((ovl->caps & OMAP_DSS_OVL_CAP_PRE_MULT_ALPHA) == 0)
-		return -ENODEV;
-
-	r = kstrtou8(buf, 0, &alpha);
-	if (r)
-		return r;
-
-	ovl->get_overlay_info(ovl, &info);
-
-	info.pre_mult_alpha = alpha;
-
-	r = ovl->set_overlay_info(ovl, &info);
-	if (r)
-		return r;
-
-	if (ovl->manager) {
-		r = ovl->manager->apply(ovl->manager);
-		if (r)
-			return r;
-	}
-
-	return size;
-}
-
-static ssize_t overlay_zorder_show(struct omap_overlay *ovl, char *buf)
-{
-	struct omap_overlay_info info;
-
-	ovl->get_overlay_info(ovl, &info);
-
-	return snprintf(buf, PAGE_SIZE, "%d\n", info.zorder);
-}
-
-static ssize_t overlay_zorder_store(struct omap_overlay *ovl,
-		const char *buf, size_t size)
-{
-	int r;
-	u8 zorder;
-	struct omap_overlay_info info;
-
-	if ((ovl->caps & OMAP_DSS_OVL_CAP_ZORDER) == 0)
-		return -ENODEV;
-
-	r = kstrtou8(buf, 0, &zorder);
-	if (r)
-		return r;
-
-	ovl->get_overlay_info(ovl, &info);
-
-	info.zorder = zorder;
-
-	r = ovl->set_overlay_info(ovl, &info);
-	if (r)
-		return r;
-
-	if (ovl->manager) {
-		r = ovl->manager->apply(ovl->manager);
-		if (r)
-			return r;
-	}
-
-	return size;
-}
-
-struct overlay_attribute {
-	struct attribute attr;
-	ssize_t (*show)(struct omap_overlay *, char *);
-	ssize_t	(*store)(struct omap_overlay *, const char *, size_t);
-};
-
-#define OVERLAY_ATTR(_name, _mode, _show, _store) \
-	struct overlay_attribute overlay_attr_##_name = \
-	__ATTR(_name, _mode, _show, _store)
-
-static OVERLAY_ATTR(name, S_IRUGO, overlay_name_show, NULL);
-static OVERLAY_ATTR(manager, S_IRUGO|S_IWUSR,
-		overlay_manager_show, overlay_manager_store);
-static OVERLAY_ATTR(input_size, S_IRUGO, overlay_input_size_show, NULL);
-static OVERLAY_ATTR(screen_width, S_IRUGO, overlay_screen_width_show, NULL);
-static OVERLAY_ATTR(position, S_IRUGO|S_IWUSR,
-		overlay_position_show, overlay_position_store);
-static OVERLAY_ATTR(output_size, S_IRUGO|S_IWUSR,
-		overlay_output_size_show, overlay_output_size_store);
-static OVERLAY_ATTR(enabled, S_IRUGO|S_IWUSR,
-		overlay_enabled_show, overlay_enabled_store);
-static OVERLAY_ATTR(global_alpha, S_IRUGO|S_IWUSR,
-		overlay_global_alpha_show, overlay_global_alpha_store);
-static OVERLAY_ATTR(pre_mult_alpha, S_IRUGO|S_IWUSR,
-		overlay_pre_mult_alpha_show,
-		overlay_pre_mult_alpha_store);
-static OVERLAY_ATTR(zorder, S_IRUGO|S_IWUSR,
-		overlay_zorder_show, overlay_zorder_store);
-
-static struct attribute *overlay_sysfs_attrs[] = {
-	&overlay_attr_name.attr,
-	&overlay_attr_manager.attr,
-	&overlay_attr_input_size.attr,
-	&overlay_attr_screen_width.attr,
-	&overlay_attr_position.attr,
-	&overlay_attr_output_size.attr,
-	&overlay_attr_enabled.attr,
-	&overlay_attr_global_alpha.attr,
-	&overlay_attr_pre_mult_alpha.attr,
-	&overlay_attr_zorder.attr,
-	NULL
-};
-
-static ssize_t overlay_attr_show(struct kobject *kobj, struct attribute *attr,
-		char *buf)
-{
-	struct omap_overlay *overlay;
-	struct overlay_attribute *overlay_attr;
-
-	overlay = container_of(kobj, struct omap_overlay, kobj);
-	overlay_attr = container_of(attr, struct overlay_attribute, attr);
-
-	if (!overlay_attr->show)
-		return -ENOENT;
-
-	return overlay_attr->show(overlay, buf);
-}
-
-static ssize_t overlay_attr_store(struct kobject *kobj, struct attribute *attr,
-		const char *buf, size_t size)
-{
-	struct omap_overlay *overlay;
-	struct overlay_attribute *overlay_attr;
-
-	overlay = container_of(kobj, struct omap_overlay, kobj);
-	overlay_attr = container_of(attr, struct overlay_attribute, attr);
-
-	if (!overlay_attr->store)
-		return -ENOENT;
-
-	return overlay_attr->store(overlay, buf, size);
-}
-
-static const struct sysfs_ops overlay_sysfs_ops = {
-	.show = overlay_attr_show,
-	.store = overlay_attr_store,
-};
-
-static struct kobj_type overlay_ktype = {
-	.sysfs_ops = &overlay_sysfs_ops,
-	.default_attrs = overlay_sysfs_attrs,
-};
-
 int omap_dss_get_num_overlays(void)
 {
 	return num_overlays;
@@ -511,9 +99,7 @@ void dss_init_overlays(struct platform_device *pdev)
 		ovl->supported_modes =
 			dss_feat_get_supported_color_modes(ovl->id);
 
-		r = kobject_init_and_add(&ovl->kobj, &overlay_ktype,
-				&pdev->dev.kobj, "overlay%d", i);
-
+		r = dss_overlay_kobj_init(ovl, pdev);
 		if (r)
 			DSSERR("failed to create sysfs file\n");
 	}
@@ -594,9 +180,7 @@ void dss_uninit_overlays(struct platform_device *pdev)
 
 	for (i = 0; i < num_overlays; ++i) {
 		struct omap_overlay *ovl = &overlays[i];
-
-		kobject_del(&ovl->kobj);
-		kobject_put(&ovl->kobj);
+		dss_overlay_kobj_uninit(ovl);
 	}
 
 	kfree(overlays);
-- 
1.7.9.5

