From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/17] OMAPDSS: split manager sysfs code
Date: Wed,  5 Sep 2012 11:25:48 +0300
Message-ID: <1346833555-31258-11-git-send-email-tomi.valkeinen@ti.com>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:49276 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758086Ab2IEI0c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 04:26:32 -0400
Received: by lagy9 with SMTP id y9so139396lag.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 01:26:29 -0700 (PDT)
In-Reply-To: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, archit@ti.com
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Separate sysfs code for managers to a separate file. This is a bit
cleaner, and will allow us later to easily switch off the sysfs support
via Kconfig option.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/Makefile        |    2 +-
 drivers/video/omap2/dss/dss.h           |    4 +
 drivers/video/omap2/dss/manager-sysfs.c |  499 +++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/manager.c       |  462 +---------------------------
 4 files changed, 506 insertions(+), 461 deletions(-)
 create mode 100644 drivers/video/omap2/dss/manager-sysfs.c

diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index 927d5ce..00a6eb5 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -1,6 +1,6 @@
 obj-$(CONFIG_OMAP2_DSS) += omapdss.o
 omapdss-y := core.o dss.o dss_features.o dispc.o dispc_coefs.o display.o \
-	manager.o overlay.o overlay-sysfs.o apply.o
+	manager.o manager-sysfs.o overlay.o overlay-sysfs.o apply.o
 omapdss-$(CONFIG_OMAP2_DSS_DPI) += dpi.o
 omapdss-$(CONFIG_OMAP2_DSS_RFBI) += rfbi.o
 omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o venc_panel.o
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 11b053e..5e9fd769 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -254,6 +254,10 @@ static inline bool dss_mgr_is_lcd(enum omap_channel id)
 		return false;
 }
 
+int dss_manager_kobj_init(struct omap_overlay_manager *mgr,
+		struct platform_device *pdev);
+void dss_manager_kobj_uninit(struct omap_overlay_manager *mgr);
+
 /* overlay */
 void dss_init_overlays(struct platform_device *pdev);
 void dss_uninit_overlays(struct platform_device *pdev);
diff --git a/drivers/video/omap2/dss/manager-sysfs.c b/drivers/video/omap2/dss/manager-sysfs.c
new file mode 100644
index 0000000..9b875fb
--- /dev/null
+++ b/drivers/video/omap2/dss/manager-sysfs.c
@@ -0,0 +1,499 @@
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
+#define DSS_SUBSYS_NAME "MANAGER"
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/jiffies.h>
+
+#include <video/omapdss.h>
+
+#include "dss.h"
+#include "dss_features.h"
+
+static ssize_t manager_name_show(struct omap_overlay_manager *mgr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n", mgr->name);
+}
+
+static ssize_t manager_display_show(struct omap_overlay_manager *mgr, char *buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			mgr->device ? mgr->device->name : "<none>");
+}
+
+static ssize_t manager_display_store(struct omap_overlay_manager *mgr,
+		const char *buf, size_t size)
+{
+	int r = 0;
+	size_t len = size;
+	struct omap_dss_device *dssdev = NULL;
+
+	int match(struct omap_dss_device *dssdev, void *data)
+	{
+		const char *str = data;
+		return sysfs_streq(dssdev->name, str);
+	}
+
+	if (buf[size-1] == '\n')
+		--len;
+
+	if (len > 0)
+		dssdev = omap_dss_find_device((void *)buf, match);
+
+	if (len > 0 && dssdev == NULL)
+		return -EINVAL;
+
+	if (dssdev)
+		DSSDBG("display %s found\n", dssdev->name);
+
+	if (mgr->device) {
+		r = mgr->unset_device(mgr);
+		if (r) {
+			DSSERR("failed to unset display\n");
+			goto put_device;
+		}
+	}
+
+	if (dssdev) {
+		r = mgr->set_device(mgr, dssdev);
+		if (r) {
+			DSSERR("failed to set manager\n");
+			goto put_device;
+		}
+
+		r = mgr->apply(mgr);
+		if (r) {
+			DSSERR("failed to apply dispc config\n");
+			goto put_device;
+		}
+	}
+
+put_device:
+	if (dssdev)
+		omap_dss_put_device(dssdev);
+
+	return r ? r : size;
+}
+
+static ssize_t manager_default_color_show(struct omap_overlay_manager *mgr,
+					  char *buf)
+{
+	struct omap_overlay_manager_info info;
+
+	mgr->get_manager_info(mgr, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%#x\n", info.default_color);
+}
+
+static ssize_t manager_default_color_store(struct omap_overlay_manager *mgr,
+					   const char *buf, size_t size)
+{
+	struct omap_overlay_manager_info info;
+	u32 color;
+	int r;
+
+	r = kstrtouint(buf, 0, &color);
+	if (r)
+		return r;
+
+	mgr->get_manager_info(mgr, &info);
+
+	info.default_color = color;
+
+	r = mgr->set_manager_info(mgr, &info);
+	if (r)
+		return r;
+
+	r = mgr->apply(mgr);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static const char *trans_key_type_str[] = {
+	"gfx-destination",
+	"video-source",
+};
+
+static ssize_t manager_trans_key_type_show(struct omap_overlay_manager *mgr,
+					   char *buf)
+{
+	enum omap_dss_trans_key_type key_type;
+	struct omap_overlay_manager_info info;
+
+	mgr->get_manager_info(mgr, &info);
+
+	key_type = info.trans_key_type;
+	BUG_ON(key_type >= ARRAY_SIZE(trans_key_type_str));
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", trans_key_type_str[key_type]);
+}
+
+static ssize_t manager_trans_key_type_store(struct omap_overlay_manager *mgr,
+					    const char *buf, size_t size)
+{
+	enum omap_dss_trans_key_type key_type;
+	struct omap_overlay_manager_info info;
+	int r;
+
+	for (key_type = OMAP_DSS_COLOR_KEY_GFX_DST;
+			key_type < ARRAY_SIZE(trans_key_type_str); key_type++) {
+		if (sysfs_streq(buf, trans_key_type_str[key_type]))
+			break;
+	}
+
+	if (key_type == ARRAY_SIZE(trans_key_type_str))
+		return -EINVAL;
+
+	mgr->get_manager_info(mgr, &info);
+
+	info.trans_key_type = key_type;
+
+	r = mgr->set_manager_info(mgr, &info);
+	if (r)
+		return r;
+
+	r = mgr->apply(mgr);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static ssize_t manager_trans_key_value_show(struct omap_overlay_manager *mgr,
+					    char *buf)
+{
+	struct omap_overlay_manager_info info;
+
+	mgr->get_manager_info(mgr, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%#x\n", info.trans_key);
+}
+
+static ssize_t manager_trans_key_value_store(struct omap_overlay_manager *mgr,
+					     const char *buf, size_t size)
+{
+	struct omap_overlay_manager_info info;
+	u32 key_value;
+	int r;
+
+	r = kstrtouint(buf, 0, &key_value);
+	if (r)
+		return r;
+
+	mgr->get_manager_info(mgr, &info);
+
+	info.trans_key = key_value;
+
+	r = mgr->set_manager_info(mgr, &info);
+	if (r)
+		return r;
+
+	r = mgr->apply(mgr);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static ssize_t manager_trans_key_enabled_show(struct omap_overlay_manager *mgr,
+					      char *buf)
+{
+	struct omap_overlay_manager_info info;
+
+	mgr->get_manager_info(mgr, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", info.trans_enabled);
+}
+
+static ssize_t manager_trans_key_enabled_store(struct omap_overlay_manager *mgr,
+					       const char *buf, size_t size)
+{
+	struct omap_overlay_manager_info info;
+	bool enable;
+	int r;
+
+	r = strtobool(buf, &enable);
+	if (r)
+		return r;
+
+	mgr->get_manager_info(mgr, &info);
+
+	info.trans_enabled = enable;
+
+	r = mgr->set_manager_info(mgr, &info);
+	if (r)
+		return r;
+
+	r = mgr->apply(mgr);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static ssize_t manager_alpha_blending_enabled_show(
+		struct omap_overlay_manager *mgr, char *buf)
+{
+	struct omap_overlay_manager_info info;
+
+	mgr->get_manager_info(mgr, &info);
+
+	WARN_ON(!dss_has_feature(FEAT_ALPHA_FIXED_ZORDER));
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+		info.partial_alpha_enabled);
+}
+
+static ssize_t manager_alpha_blending_enabled_store(
+		struct omap_overlay_manager *mgr,
+		const char *buf, size_t size)
+{
+	struct omap_overlay_manager_info info;
+	bool enable;
+	int r;
+
+	WARN_ON(!dss_has_feature(FEAT_ALPHA_FIXED_ZORDER));
+
+	r = strtobool(buf, &enable);
+	if (r)
+		return r;
+
+	mgr->get_manager_info(mgr, &info);
+
+	info.partial_alpha_enabled = enable;
+
+	r = mgr->set_manager_info(mgr, &info);
+	if (r)
+		return r;
+
+	r = mgr->apply(mgr);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static ssize_t manager_cpr_enable_show(struct omap_overlay_manager *mgr,
+		char *buf)
+{
+	struct omap_overlay_manager_info info;
+
+	mgr->get_manager_info(mgr, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", info.cpr_enable);
+}
+
+static ssize_t manager_cpr_enable_store(struct omap_overlay_manager *mgr,
+		const char *buf, size_t size)
+{
+	struct omap_overlay_manager_info info;
+	int r;
+	bool enable;
+
+	if (!dss_has_feature(FEAT_CPR))
+		return -ENODEV;
+
+	r = strtobool(buf, &enable);
+	if (r)
+		return r;
+
+	mgr->get_manager_info(mgr, &info);
+
+	if (info.cpr_enable == enable)
+		return size;
+
+	info.cpr_enable = enable;
+
+	r = mgr->set_manager_info(mgr, &info);
+	if (r)
+		return r;
+
+	r = mgr->apply(mgr);
+	if (r)
+		return r;
+
+	return size;
+}
+
+static ssize_t manager_cpr_coef_show(struct omap_overlay_manager *mgr,
+		char *buf)
+{
+	struct omap_overlay_manager_info info;
+
+	mgr->get_manager_info(mgr, &info);
+
+	return snprintf(buf, PAGE_SIZE,
+			"%d %d %d %d %d %d %d %d %d\n",
+			info.cpr_coefs.rr,
+			info.cpr_coefs.rg,
+			info.cpr_coefs.rb,
+			info.cpr_coefs.gr,
+			info.cpr_coefs.gg,
+			info.cpr_coefs.gb,
+			info.cpr_coefs.br,
+			info.cpr_coefs.bg,
+			info.cpr_coefs.bb);
+}
+
+static ssize_t manager_cpr_coef_store(struct omap_overlay_manager *mgr,
+		const char *buf, size_t size)
+{
+	struct omap_overlay_manager_info info;
+	struct omap_dss_cpr_coefs coefs;
+	int r, i;
+	s16 *arr;
+
+	if (!dss_has_feature(FEAT_CPR))
+		return -ENODEV;
+
+	if (sscanf(buf, "%hd %hd %hd %hd %hd %hd %hd %hd %hd",
+				&coefs.rr, &coefs.rg, &coefs.rb,
+				&coefs.gr, &coefs.gg, &coefs.gb,
+				&coefs.br, &coefs.bg, &coefs.bb) != 9)
+		return -EINVAL;
+
+	arr = (s16[]){ coefs.rr, coefs.rg, coefs.rb,
+		coefs.gr, coefs.gg, coefs.gb,
+		coefs.br, coefs.bg, coefs.bb };
+
+	for (i = 0; i < 9; ++i) {
+		if (arr[i] < -512 || arr[i] > 511)
+			return -EINVAL;
+	}
+
+	mgr->get_manager_info(mgr, &info);
+
+	info.cpr_coefs = coefs;
+
+	r = mgr->set_manager_info(mgr, &info);
+	if (r)
+		return r;
+
+	r = mgr->apply(mgr);
+	if (r)
+		return r;
+
+	return size;
+}
+
+struct manager_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct omap_overlay_manager *, char *);
+	ssize_t	(*store)(struct omap_overlay_manager *, const char *, size_t);
+};
+
+#define MANAGER_ATTR(_name, _mode, _show, _store) \
+	struct manager_attribute manager_attr_##_name = \
+	__ATTR(_name, _mode, _show, _store)
+
+static MANAGER_ATTR(name, S_IRUGO, manager_name_show, NULL);
+static MANAGER_ATTR(display, S_IRUGO|S_IWUSR,
+		manager_display_show, manager_display_store);
+static MANAGER_ATTR(default_color, S_IRUGO|S_IWUSR,
+		manager_default_color_show, manager_default_color_store);
+static MANAGER_ATTR(trans_key_type, S_IRUGO|S_IWUSR,
+		manager_trans_key_type_show, manager_trans_key_type_store);
+static MANAGER_ATTR(trans_key_value, S_IRUGO|S_IWUSR,
+		manager_trans_key_value_show, manager_trans_key_value_store);
+static MANAGER_ATTR(trans_key_enabled, S_IRUGO|S_IWUSR,
+		manager_trans_key_enabled_show,
+		manager_trans_key_enabled_store);
+static MANAGER_ATTR(alpha_blending_enabled, S_IRUGO|S_IWUSR,
+		manager_alpha_blending_enabled_show,
+		manager_alpha_blending_enabled_store);
+static MANAGER_ATTR(cpr_enable, S_IRUGO|S_IWUSR,
+		manager_cpr_enable_show,
+		manager_cpr_enable_store);
+static MANAGER_ATTR(cpr_coef, S_IRUGO|S_IWUSR,
+		manager_cpr_coef_show,
+		manager_cpr_coef_store);
+
+
+static struct attribute *manager_sysfs_attrs[] = {
+	&manager_attr_name.attr,
+	&manager_attr_display.attr,
+	&manager_attr_default_color.attr,
+	&manager_attr_trans_key_type.attr,
+	&manager_attr_trans_key_value.attr,
+	&manager_attr_trans_key_enabled.attr,
+	&manager_attr_alpha_blending_enabled.attr,
+	&manager_attr_cpr_enable.attr,
+	&manager_attr_cpr_coef.attr,
+	NULL
+};
+
+static ssize_t manager_attr_show(struct kobject *kobj, struct attribute *attr,
+		char *buf)
+{
+	struct omap_overlay_manager *manager;
+	struct manager_attribute *manager_attr;
+
+	manager = container_of(kobj, struct omap_overlay_manager, kobj);
+	manager_attr = container_of(attr, struct manager_attribute, attr);
+
+	if (!manager_attr->show)
+		return -ENOENT;
+
+	return manager_attr->show(manager, buf);
+}
+
+static ssize_t manager_attr_store(struct kobject *kobj, struct attribute *attr,
+		const char *buf, size_t size)
+{
+	struct omap_overlay_manager *manager;
+	struct manager_attribute *manager_attr;
+
+	manager = container_of(kobj, struct omap_overlay_manager, kobj);
+	manager_attr = container_of(attr, struct manager_attribute, attr);
+
+	if (!manager_attr->store)
+		return -ENOENT;
+
+	return manager_attr->store(manager, buf, size);
+}
+
+static const struct sysfs_ops manager_sysfs_ops = {
+	.show = manager_attr_show,
+	.store = manager_attr_store,
+};
+
+static struct kobj_type manager_ktype = {
+	.sysfs_ops = &manager_sysfs_ops,
+	.default_attrs = manager_sysfs_attrs,
+};
+
+int dss_manager_kobj_init(struct omap_overlay_manager *mgr,
+		struct platform_device *pdev)
+{
+	return kobject_init_and_add(&mgr->kobj, &manager_ktype,
+			&pdev->dev.kobj, "manager%d", mgr->id);
+}
+
+void dss_manager_kobj_uninit(struct omap_overlay_manager *mgr)
+{
+	kobject_del(&mgr->kobj);
+	kobject_put(&mgr->kobj);
+}
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 53710fa..383314f 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -36,460 +36,6 @@
 static int num_managers;
 static struct omap_overlay_manager *managers;
 
-static ssize_t manager_name_show(struct omap_overlay_manager *mgr, char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%s\n", mgr->name);
-}
-
-static ssize_t manager_display_show(struct omap_overlay_manager *mgr, char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			mgr->device ? mgr->device->name : "<none>");
-}
-
-static ssize_t manager_display_store(struct omap_overlay_manager *mgr,
-		const char *buf, size_t size)
-{
-	int r = 0;
-	size_t len = size;
-	struct omap_dss_device *dssdev = NULL;
-
-	int match(struct omap_dss_device *dssdev, void *data)
-	{
-		const char *str = data;
-		return sysfs_streq(dssdev->name, str);
-	}
-
-	if (buf[size-1] == '\n')
-		--len;
-
-	if (len > 0)
-		dssdev = omap_dss_find_device((void *)buf, match);
-
-	if (len > 0 && dssdev == NULL)
-		return -EINVAL;
-
-	if (dssdev)
-		DSSDBG("display %s found\n", dssdev->name);
-
-	if (mgr->device) {
-		r = mgr->unset_device(mgr);
-		if (r) {
-			DSSERR("failed to unset display\n");
-			goto put_device;
-		}
-	}
-
-	if (dssdev) {
-		r = mgr->set_device(mgr, dssdev);
-		if (r) {
-			DSSERR("failed to set manager\n");
-			goto put_device;
-		}
-
-		r = mgr->apply(mgr);
-		if (r) {
-			DSSERR("failed to apply dispc config\n");
-			goto put_device;
-		}
-	}
-
-put_device:
-	if (dssdev)
-		omap_dss_put_device(dssdev);
-
-	return r ? r : size;
-}
-
-static ssize_t manager_default_color_show(struct omap_overlay_manager *mgr,
-					  char *buf)
-{
-	struct omap_overlay_manager_info info;
-
-	mgr->get_manager_info(mgr, &info);
-
-	return snprintf(buf, PAGE_SIZE, "%#x\n", info.default_color);
-}
-
-static ssize_t manager_default_color_store(struct omap_overlay_manager *mgr,
-					   const char *buf, size_t size)
-{
-	struct omap_overlay_manager_info info;
-	u32 color;
-	int r;
-
-	r = kstrtouint(buf, 0, &color);
-	if (r)
-		return r;
-
-	mgr->get_manager_info(mgr, &info);
-
-	info.default_color = color;
-
-	r = mgr->set_manager_info(mgr, &info);
-	if (r)
-		return r;
-
-	r = mgr->apply(mgr);
-	if (r)
-		return r;
-
-	return size;
-}
-
-static const char *trans_key_type_str[] = {
-	"gfx-destination",
-	"video-source",
-};
-
-static ssize_t manager_trans_key_type_show(struct omap_overlay_manager *mgr,
-					   char *buf)
-{
-	enum omap_dss_trans_key_type key_type;
-	struct omap_overlay_manager_info info;
-
-	mgr->get_manager_info(mgr, &info);
-
-	key_type = info.trans_key_type;
-	BUG_ON(key_type >= ARRAY_SIZE(trans_key_type_str));
-
-	return snprintf(buf, PAGE_SIZE, "%s\n", trans_key_type_str[key_type]);
-}
-
-static ssize_t manager_trans_key_type_store(struct omap_overlay_manager *mgr,
-					    const char *buf, size_t size)
-{
-	enum omap_dss_trans_key_type key_type;
-	struct omap_overlay_manager_info info;
-	int r;
-
-	for (key_type = OMAP_DSS_COLOR_KEY_GFX_DST;
-			key_type < ARRAY_SIZE(trans_key_type_str); key_type++) {
-		if (sysfs_streq(buf, trans_key_type_str[key_type]))
-			break;
-	}
-
-	if (key_type == ARRAY_SIZE(trans_key_type_str))
-		return -EINVAL;
-
-	mgr->get_manager_info(mgr, &info);
-
-	info.trans_key_type = key_type;
-
-	r = mgr->set_manager_info(mgr, &info);
-	if (r)
-		return r;
-
-	r = mgr->apply(mgr);
-	if (r)
-		return r;
-
-	return size;
-}
-
-static ssize_t manager_trans_key_value_show(struct omap_overlay_manager *mgr,
-					    char *buf)
-{
-	struct omap_overlay_manager_info info;
-
-	mgr->get_manager_info(mgr, &info);
-
-	return snprintf(buf, PAGE_SIZE, "%#x\n", info.trans_key);
-}
-
-static ssize_t manager_trans_key_value_store(struct omap_overlay_manager *mgr,
-					     const char *buf, size_t size)
-{
-	struct omap_overlay_manager_info info;
-	u32 key_value;
-	int r;
-
-	r = kstrtouint(buf, 0, &key_value);
-	if (r)
-		return r;
-
-	mgr->get_manager_info(mgr, &info);
-
-	info.trans_key = key_value;
-
-	r = mgr->set_manager_info(mgr, &info);
-	if (r)
-		return r;
-
-	r = mgr->apply(mgr);
-	if (r)
-		return r;
-
-	return size;
-}
-
-static ssize_t manager_trans_key_enabled_show(struct omap_overlay_manager *mgr,
-					      char *buf)
-{
-	struct omap_overlay_manager_info info;
-
-	mgr->get_manager_info(mgr, &info);
-
-	return snprintf(buf, PAGE_SIZE, "%d\n", info.trans_enabled);
-}
-
-static ssize_t manager_trans_key_enabled_store(struct omap_overlay_manager *mgr,
-					       const char *buf, size_t size)
-{
-	struct omap_overlay_manager_info info;
-	bool enable;
-	int r;
-
-	r = strtobool(buf, &enable);
-	if (r)
-		return r;
-
-	mgr->get_manager_info(mgr, &info);
-
-	info.trans_enabled = enable;
-
-	r = mgr->set_manager_info(mgr, &info);
-	if (r)
-		return r;
-
-	r = mgr->apply(mgr);
-	if (r)
-		return r;
-
-	return size;
-}
-
-static ssize_t manager_alpha_blending_enabled_show(
-		struct omap_overlay_manager *mgr, char *buf)
-{
-	struct omap_overlay_manager_info info;
-
-	mgr->get_manager_info(mgr, &info);
-
-	WARN_ON(!dss_has_feature(FEAT_ALPHA_FIXED_ZORDER));
-
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-		info.partial_alpha_enabled);
-}
-
-static ssize_t manager_alpha_blending_enabled_store(
-		struct omap_overlay_manager *mgr,
-		const char *buf, size_t size)
-{
-	struct omap_overlay_manager_info info;
-	bool enable;
-	int r;
-
-	WARN_ON(!dss_has_feature(FEAT_ALPHA_FIXED_ZORDER));
-
-	r = strtobool(buf, &enable);
-	if (r)
-		return r;
-
-	mgr->get_manager_info(mgr, &info);
-
-	info.partial_alpha_enabled = enable;
-
-	r = mgr->set_manager_info(mgr, &info);
-	if (r)
-		return r;
-
-	r = mgr->apply(mgr);
-	if (r)
-		return r;
-
-	return size;
-}
-
-static ssize_t manager_cpr_enable_show(struct omap_overlay_manager *mgr,
-		char *buf)
-{
-	struct omap_overlay_manager_info info;
-
-	mgr->get_manager_info(mgr, &info);
-
-	return snprintf(buf, PAGE_SIZE, "%d\n", info.cpr_enable);
-}
-
-static ssize_t manager_cpr_enable_store(struct omap_overlay_manager *mgr,
-		const char *buf, size_t size)
-{
-	struct omap_overlay_manager_info info;
-	int r;
-	bool enable;
-
-	if (!dss_has_feature(FEAT_CPR))
-		return -ENODEV;
-
-	r = strtobool(buf, &enable);
-	if (r)
-		return r;
-
-	mgr->get_manager_info(mgr, &info);
-
-	if (info.cpr_enable == enable)
-		return size;
-
-	info.cpr_enable = enable;
-
-	r = mgr->set_manager_info(mgr, &info);
-	if (r)
-		return r;
-
-	r = mgr->apply(mgr);
-	if (r)
-		return r;
-
-	return size;
-}
-
-static ssize_t manager_cpr_coef_show(struct omap_overlay_manager *mgr,
-		char *buf)
-{
-	struct omap_overlay_manager_info info;
-
-	mgr->get_manager_info(mgr, &info);
-
-	return snprintf(buf, PAGE_SIZE,
-			"%d %d %d %d %d %d %d %d %d\n",
-			info.cpr_coefs.rr,
-			info.cpr_coefs.rg,
-			info.cpr_coefs.rb,
-			info.cpr_coefs.gr,
-			info.cpr_coefs.gg,
-			info.cpr_coefs.gb,
-			info.cpr_coefs.br,
-			info.cpr_coefs.bg,
-			info.cpr_coefs.bb);
-}
-
-static ssize_t manager_cpr_coef_store(struct omap_overlay_manager *mgr,
-		const char *buf, size_t size)
-{
-	struct omap_overlay_manager_info info;
-	struct omap_dss_cpr_coefs coefs;
-	int r, i;
-	s16 *arr;
-
-	if (!dss_has_feature(FEAT_CPR))
-		return -ENODEV;
-
-	if (sscanf(buf, "%hd %hd %hd %hd %hd %hd %hd %hd %hd",
-				&coefs.rr, &coefs.rg, &coefs.rb,
-				&coefs.gr, &coefs.gg, &coefs.gb,
-				&coefs.br, &coefs.bg, &coefs.bb) != 9)
-		return -EINVAL;
-
-	arr = (s16[]){ coefs.rr, coefs.rg, coefs.rb,
-		coefs.gr, coefs.gg, coefs.gb,
-		coefs.br, coefs.bg, coefs.bb };
-
-	for (i = 0; i < 9; ++i) {
-		if (arr[i] < -512 || arr[i] > 511)
-			return -EINVAL;
-	}
-
-	mgr->get_manager_info(mgr, &info);
-
-	info.cpr_coefs = coefs;
-
-	r = mgr->set_manager_info(mgr, &info);
-	if (r)
-		return r;
-
-	r = mgr->apply(mgr);
-	if (r)
-		return r;
-
-	return size;
-}
-
-struct manager_attribute {
-	struct attribute attr;
-	ssize_t (*show)(struct omap_overlay_manager *, char *);
-	ssize_t	(*store)(struct omap_overlay_manager *, const char *, size_t);
-};
-
-#define MANAGER_ATTR(_name, _mode, _show, _store) \
-	struct manager_attribute manager_attr_##_name = \
-	__ATTR(_name, _mode, _show, _store)
-
-static MANAGER_ATTR(name, S_IRUGO, manager_name_show, NULL);
-static MANAGER_ATTR(display, S_IRUGO|S_IWUSR,
-		manager_display_show, manager_display_store);
-static MANAGER_ATTR(default_color, S_IRUGO|S_IWUSR,
-		manager_default_color_show, manager_default_color_store);
-static MANAGER_ATTR(trans_key_type, S_IRUGO|S_IWUSR,
-		manager_trans_key_type_show, manager_trans_key_type_store);
-static MANAGER_ATTR(trans_key_value, S_IRUGO|S_IWUSR,
-		manager_trans_key_value_show, manager_trans_key_value_store);
-static MANAGER_ATTR(trans_key_enabled, S_IRUGO|S_IWUSR,
-		manager_trans_key_enabled_show,
-		manager_trans_key_enabled_store);
-static MANAGER_ATTR(alpha_blending_enabled, S_IRUGO|S_IWUSR,
-		manager_alpha_blending_enabled_show,
-		manager_alpha_blending_enabled_store);
-static MANAGER_ATTR(cpr_enable, S_IRUGO|S_IWUSR,
-		manager_cpr_enable_show,
-		manager_cpr_enable_store);
-static MANAGER_ATTR(cpr_coef, S_IRUGO|S_IWUSR,
-		manager_cpr_coef_show,
-		manager_cpr_coef_store);
-
-
-static struct attribute *manager_sysfs_attrs[] = {
-	&manager_attr_name.attr,
-	&manager_attr_display.attr,
-	&manager_attr_default_color.attr,
-	&manager_attr_trans_key_type.attr,
-	&manager_attr_trans_key_value.attr,
-	&manager_attr_trans_key_enabled.attr,
-	&manager_attr_alpha_blending_enabled.attr,
-	&manager_attr_cpr_enable.attr,
-	&manager_attr_cpr_coef.attr,
-	NULL
-};
-
-static ssize_t manager_attr_show(struct kobject *kobj, struct attribute *attr,
-		char *buf)
-{
-	struct omap_overlay_manager *manager;
-	struct manager_attribute *manager_attr;
-
-	manager = container_of(kobj, struct omap_overlay_manager, kobj);
-	manager_attr = container_of(attr, struct manager_attribute, attr);
-
-	if (!manager_attr->show)
-		return -ENOENT;
-
-	return manager_attr->show(manager, buf);
-}
-
-static ssize_t manager_attr_store(struct kobject *kobj, struct attribute *attr,
-		const char *buf, size_t size)
-{
-	struct omap_overlay_manager *manager;
-	struct manager_attribute *manager_attr;
-
-	manager = container_of(kobj, struct omap_overlay_manager, kobj);
-	manager_attr = container_of(attr, struct manager_attribute, attr);
-
-	if (!manager_attr->store)
-		return -ENOENT;
-
-	return manager_attr->store(manager, buf, size);
-}
-
-static const struct sysfs_ops manager_sysfs_ops = {
-	.show = manager_attr_show,
-	.store = manager_attr_store,
-};
-
-static struct kobj_type manager_ktype = {
-	.sysfs_ops = &manager_sysfs_ops,
-	.default_attrs = manager_sysfs_attrs,
-};
-
 static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
 {
 	unsigned long timeout = msecs_to_jiffies(500);
@@ -561,9 +107,7 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 
 		INIT_LIST_HEAD(&mgr->overlays);
 
-		r = kobject_init_and_add(&mgr->kobj, &manager_ktype,
-				&pdev->dev.kobj, "manager%d", i);
-
+		r = dss_manager_kobj_init(mgr, pdev);
 		if (r)
 			DSSERR("failed to create sysfs file\n");
 	}
@@ -577,9 +121,7 @@ void dss_uninit_overlay_managers(struct platform_device *pdev)
 
 	for (i = 0; i < num_managers; ++i) {
 		struct omap_overlay_manager *mgr = &managers[i];
-
-		kobject_del(&mgr->kobj);
-		kobject_put(&mgr->kobj);
+		dss_manager_kobj_uninit(mgr);
 	}
 
 	kfree(managers);
-- 
1.7.9.5

