From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFC 2/2] OMAP: PM: initial runtime PM support
Date: Wed,  3 Feb 2010 16:19:11 -0800
Message-ID: <1265242751-12199-3-git-send-email-khilman@deeprootsystems.com>
References: <1265242751-12199-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f201.google.com ([209.85.223.201]:63014 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758000Ab0BDATS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 19:19:18 -0500
Received: by mail-iw0-f201.google.com with SMTP id 39so2324202iwn.1
        for <linux-omap@vger.kernel.org>; Wed, 03 Feb 2010 16:19:17 -0800 (PST)
In-Reply-To: <1265242751-12199-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Implement the new runtime PM framework as a thin layer on top of the
omap_device API.  Since we don't have an OMAP-specific bus, override
the runtime PM hooks for the platform_bus for the OMAP specific
implementation.

While the runtime PM API has three main states (idle, suspend, resume)
This version treats idle and suspend the same way by implementing both
on top of omap_device_disable().

Device driver ->runtime_suspend() hooks are called just before the
device is disabled (via omap_device_idle()), and device driver
->runtime_resume() hooks are called just after device has been
enabled, but ONLY IF device has lost context due to an off-mode
transition.

To convert other device drivers, simply change clk_disable() calls to
pm_runtime_put_sync() and clk_enable() calls to pm_runtime_get_sync().

NOTE: the bus notifier stuff is currently there for debug purposes.
      In the future, we may want to use the notifiers to do some
      automatic enable/disabling of devices.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Makefile     |    6 ++
 arch/arm/mach-omap2/pm_runtime.c |  119 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm_runtime.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index dba44a1..16ba8fc 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -55,6 +55,12 @@ obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
 
+# Runtime PM support
+obj-$(CONFIG_PM_RUNTIME)		+= pm_runtime.o
+ifeq ($(CONFIG_PM_VERBOSE),y)
+CFLAGS_pm_runtime.o                     += -DDEBUG
+endif
+
 endif
 
 # PRCM
diff --git a/arch/arm/mach-omap2/pm_runtime.c b/arch/arm/mach-omap2/pm_runtime.c
new file mode 100644
index 0000000..4bd1b9a
--- /dev/null
+++ b/arch/arm/mach-omap2/pm_runtime.c
@@ -0,0 +1,119 @@
+/*
+ * Runtime PM support code for OMAP
+ *
+ * Author: Kevin Hilman, Deep Root Systems, LLC
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <linux/platform_device.h>
+#include <linux/mutex.h>
+
+#include <plat/omap_device.h>
+#include <plat/omap-pm.h>
+
+int platform_pm_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *odev = to_omap_device(pdev);
+	int ret = 0;
+
+	if (WARN_ON(!omap_device_is_valid(odev)))
+		return -ENODEV;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	if (dev->driver->pm && dev->driver->pm->runtime_suspend)
+		ret = dev->driver->pm->runtime_suspend(dev);
+	if (!ret)
+		omap_device_idle(pdev);
+
+	return ret;
+};
+
+int platform_pm_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *odev = to_omap_device(pdev);
+	int ret = 0;
+
+	if (WARN_ON(!omap_device_is_valid(odev)))
+		return -ENODEV;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	omap_device_enable(pdev);
+
+	/*
+	 * TODO: only call drivers runtime_resume hook if
+	 *       device has lost context.
+	 */
+	if (dev->driver->pm && dev->driver->pm->runtime_resume)
+		if (omap_device_has_lost_context(pdev))
+			ret = dev->driver->pm->runtime_resume(dev);
+
+	return ret;
+};
+
+int platform_pm_runtime_idle(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *odev = to_omap_device(pdev);
+	int ret;
+
+	if (WARN_ON(!omap_device_is_valid(odev)))
+		return -ENODEV;
+
+	ret = pm_runtime_suspend(dev);
+	dev_dbg(dev, "%s [%d] \n", __func__, ret);
+
+	return 0;
+};
+
+static int platform_bus_notify(struct notifier_block *nb,
+			       unsigned long action, void *data)
+{
+	struct device *dev = data;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *odev = to_omap_device(pdev);
+
+	if (!omap_device_is_valid(odev))
+		return -ENODEV;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		dev_dbg(dev, "BUS_NOTIFY_ADD_DEVICE");
+		break;
+	case BUS_NOTIFY_BOUND_DRIVER:
+		dev_dbg(dev, "BUS_NOTIFY_BOUND_DRIVER");
+		break;
+	case BUS_NOTIFY_UNBOUND_DRIVER:
+		dev_dbg(dev, "BUS_NOTIFY_UNBOUND_DRIVER");
+		break;
+	case BUS_NOTIFY_DEL_DEVICE:
+		dev_dbg(dev, "BUS_NOTIFY_DEL_DEVICE");
+		break;
+	default:
+		dev_dbg(dev, "Unknown");
+	}
+
+	return 0;
+}
+
+static struct notifier_block platform_bus_notifier = {
+	.notifier_call = platform_bus_notify
+};
+
+static int __init omap_pm_runtime_init(void)
+{
+	bus_register_notifier(&platform_bus_type, &platform_bus_notifier);
+	return 0;
+}
+core_initcall(omap_pm_runtime_init);
-- 
1.6.6

