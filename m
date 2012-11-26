From: Andy Green <andy.green@linaro.org>
Subject: [RFC PATCH 1/5] drivers : introduce device_path api
Date: Mon, 26 Nov 2012 12:45:34 +0000
Message-ID: <20121126124534.18106.44137.stgit@build.warmcat.com>
References: <20121126123427.18106.4112.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:41656 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349Ab2KZMpj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Nov 2012 07:45:39 -0500
In-Reply-To: <20121126123427.18106.4112.stgit@build.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stern@rowland.harvard.edu
Cc: linux-omap@vger.kernel.org, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, balbi@ti.com, rogerq@ti.com

This adds a small optional API into drivers/base which deals with generating,
matching and registration of wildcard device paths.

>From a struct device * you can generate a string like

 /platform/usbhs_omap/ehci-omap.0/usb1/1-1

which enapsulates the path of the device's connection to the board.

These can be used to match up other assets, for example struct regulators,
that have been registed elsewhere with a device instance that is probed
asynchronously from the other board assets.

If your device is on a bus, as it probably is, the device path will feature
redundant bus indexes that do not contain information about the connectivity.

For example if more than one driver can generate devices on the same bus,
then the ordering of device probing will change the path, despite the
connectivity remains the same.

For that reason, to get a deterministic path for matching, wildcards are
allowed.  If your target device has the path

 /platform/usbhs_omap/ehci-omap.0/usb1/1-1

generated, in the asset you wish to match with it you can instead use

/platform/usbhs_omap/ehci-omap.0/usb*/*-1

in order to only leave the useful, invariant parts of the path to match
against.

To avoid having to adapt every kind of "search by string" api to also use
the wildcards, the api takes the approach you can register your wildcard,
and if a matching path is generated for a device, the wildcard itself is
handed back as the device path instead.

So if your board code or a (not yet done) DT binding registers this wildcard

 /platform/usbhs_omap/ehci-omap.0/usb*

and the usb hub driver asks to generate its device path

	device_path_generate(dev, name, sizeof name);

that is actually

 /platform/usbhs_omap/ehci-omap.0/usb1

then what will be returned is

 /platform/usbhs_omap/ehci-omap.0/usb*

providing the same literal string for ehci-omap.0 hub no matter how many\
usb buses have been registered before.

This wildcard string can then be matched to regulators or other string-
searchable assets intended for the device on that hardware path.

Signed-off-by: Andy Green <andy.green@linaro.org>
---
 drivers/base/Kconfig   |    6 ++
 drivers/base/Makefile  |    2 +
 drivers/base/core.c    |    2 +
 drivers/base/path.c    |  181 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |   12 +++
 5 files changed, 203 insertions(+)
 create mode 100644 drivers/base/path.c

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index b34b5cd..3324a55 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -282,4 +282,10 @@ config CMA_AREAS
 
 endif
 
+config DEVICEPATH
+	bool "Device path api"
+	default n
+	help
+	  Include dynamicly probed path matching API
+
 endmenu
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 5aa2d70..b8d5723 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -22,5 +22,7 @@ obj-$(CONFIG_SYS_HYPERVISOR) += hypervisor.o
 obj-$(CONFIG_REGMAP)	+= regmap/
 obj-$(CONFIG_SOC_BUS) += soc.o
 
+obj-$(CONFIG_DEVICEPATH) += path.o
+
 ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index abea76c..cc0ba02 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1368,6 +1368,8 @@ int __init devices_init(void)
 	if (!sysfs_dev_char_kobj)
 		goto char_kobj_err;
 
+	device_path_init();
+
 	return 0;
 
  char_kobj_err:
diff --git a/drivers/base/path.c b/drivers/base/path.c
new file mode 100644
index 0000000..384e792
--- /dev/null
+++ b/drivers/base/path.c
@@ -0,0 +1,181 @@
+/*
+ * drivers/base/path.c - device_path apis for matching dynamic / variable
+ *  device paths on buses like usb / mmc to wildcard constants from
+ *  platform or DT
+ *
+ * Copyright (c) 2012 Linaro, LTD
+ * Author: Andy Green <andy.green@linaro.org>
+ *
+ * This file is released under the GPLv2
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+#include <linux/export.h>
+#include <linux/slab.h>
+
+struct device_path {
+	char *path;
+	struct list_head list;
+};
+
+struct device_path list;
+DEFINE_MUTEX(lock);
+
+static int device_path_compare_wildcard(const char *awc, const char *b)
+{
+	while (*awc && *b) {
+		if (*awc == '*') {
+			awc++;
+			/* wildcard disallowed from extening past / */
+			while (*b && *b != *awc && *b != '/')
+				b++;
+		}
+		if (*awc != *b)
+			return -ENOENT;
+		if (!*awc)
+			return 0;
+		awc++;
+		b++;
+	}
+
+	if (!*awc && !*b)
+		return 0;
+
+	return -ENOENT;
+}
+
+static const char *device_path_find_wildcard(const char *device_path)
+{
+	struct device_path *dp;
+
+	mutex_lock(&lock);
+	list_for_each_entry(dp, &list.list, list) {
+		if (device_path_compare_wildcard(dp->path, device_path) == 0) {
+			mutex_unlock(&lock);
+			return dp->path;
+		}
+	}
+
+	mutex_unlock(&lock);
+	return NULL;
+}
+
+static int _device_path_generate(struct device *device, char *name, int len)
+{
+	int n = 0;
+	int l;
+
+	if (!device)
+		return -ENODEV;
+
+	if (device->parent) {
+		n = _device_path_generate(device->parent, name, len);
+		if (n < 0)
+			return n;
+	}
+
+	l = strlen(dev_name(device));
+
+	if ((len - n) < l + 3)
+		return -E2BIG;
+
+	name[n++] = '/';
+	strcpy(&name[n], dev_name(device));
+
+	return n + l;
+}
+
+int device_path_generate(struct device *device, char *name, int len)
+{
+	int n;
+	const char *match;
+
+	n = _device_path_generate(device, name, len);
+	if (n < 0)
+		return n;
+
+	/*
+	 * if any registered wildcard matches, report that instead
+	 */
+	match = device_path_find_wildcard(name);
+	if (!match)
+		return 0;
+
+	n = strlen(match);
+	if (n >= len - 1)
+		return -E2BIG;
+
+	memcpy(name, match, n);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(device_path_generate);
+
+int device_path_register_wildcard_path(const char *wildcard_devpath)
+{
+	struct device_path *dp;
+	int ret = -ENOMEM;
+
+	if (strchr(wildcard_devpath, '*') == NULL)
+		return 0;
+
+	mutex_lock(&lock);
+	dp = kmalloc(sizeof(struct device_path), GFP_KERNEL);
+	if (!dp)
+		goto bail;
+
+	dp->path = kmalloc(strlen(wildcard_devpath) + 1, GFP_KERNEL);
+	if (!dp->path) {
+		kfree(dp);
+		goto bail;
+	}
+
+	strcpy(dp->path, wildcard_devpath);
+	list_add(&dp->list, &list.list);
+	ret = 0;
+
+bail:
+	mutex_unlock(&lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(device_path_register_wildcard_path);
+
+static void device_path_free(struct device_path *dp)
+{
+	kfree(dp->path);
+	kfree(dp);
+}
+
+int device_path_unregister_wildcard_path(const char *wildcard_devpath)
+{
+	struct device_path *dp;
+	struct list_head *pos, *q;
+
+	mutex_lock(&lock);
+	list_for_each_safe(pos, q, &list.list) {
+		dp = list_entry(pos, struct device_path, list);
+		if (strcmp(dp->path, wildcard_devpath) == 0) {
+			list_del(pos);
+			device_path_free(dp);
+			mutex_unlock(&lock);
+			return 0;
+		}
+	}
+
+	mutex_unlock(&lock);
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(device_path_unregister_wildcard_path);
+
+void __init device_path_init(void)
+{
+	INIT_LIST_HEAD(&list.list);
+	mutex_init(&lock);
+}
+EXPORT_SYMBOL_GPL(device_path_init);
diff --git a/include/linux/device.h b/include/linux/device.h
index 86ef6ab..ecaf3aa 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -875,6 +875,18 @@ extern int (*platform_notify)(struct device *dev);
 
 extern int (*platform_notify_remove)(struct device *dev);
 
+/*
+ * optional device path api
+ */
+#ifdef CONFIG_DEVICEPATH
+#define MAX_DEV_PATH_SIZE 512
+extern int device_path_generate(struct device *device, char *name, int len);
+extern int device_path_unregister_wildcard_path(const char *wildcard_devpath);
+extern int device_path_register_wildcard_path(const char *wildcard_devpath);
+extern void device_path_init(void);
+#else
+static inline void device_path_init(void) { ; }
+#endif
 
 /*
  * get_device - atomically increment the reference count for the device.

