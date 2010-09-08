From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/2] OMAP2+: PM: initial runtime PM core support
Date: Tue,  7 Sep 2010 17:54:41 -0700
Message-ID: <1283907282-986-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41207 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab0IHAyp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 20:54:45 -0400
Received: by iwn5 with SMTP id 5so5802277iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Sep 2010 17:54:44 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

From: Kevin Hilman <khilman@ti.com>

Implement the new runtime PM framework as a thin layer on top of the
omap_device API.  OMAP specific runtime PM methods are registered with
the as custom methods on the platform_bus.

In order to determine if a device is an omap_device, its parent device
is checked.  All omap_devices have a new 'omap_bus' device as their
parent device, so checking for this parent is used to check for valid
omap_devices.  If a device is an omap_device, then the appropriate
omap_device functions are called for it.  If not, only the generic
runtime PM functions are called.

Device driver's ->runtime_idle() hook is called when the runtime PM
usecount reaches zero for that device.  Driver's ->runtime_suspend()
hooks are called just before the device is disabled (via
omap_device_idle()), and device driver ->runtime_resume() hooks are
called just after device has been enabled (via omap_device_enable().)

OMAP4 build support from Rajendra Nayak <rnayak@ti.com>.

Cc: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
NOTE: this depends on the driver core patch from me:
[PATCH v2] driver core: platform_bus: allow runtime override of dev_pm_ops
which Greg KH has queued now for 2.6.37:
http://marc.info/?l=linux-kernel&m=128276582108006&w=2

 arch/arm/mach-omap2/Makefile |    8 +++-
 arch/arm/mach-omap2/pm_bus.c |   82 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm_bus.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 88d3a1e..ba644c2 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -50,13 +50,17 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o pm_bus.o
+obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o pm_bus.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
 
+ifeq ($(CONFIG_PM_VERBOSE),y)
+CFLAGS_pm_bus.o				+= -DDEBUG
+endif
+
 endif
 
 # PRCM
diff --git a/arch/arm/mach-omap2/pm_bus.c b/arch/arm/mach-omap2/pm_bus.c
new file mode 100644
index 0000000..e85aced
--- /dev/null
+++ b/arch/arm/mach-omap2/pm_bus.c
@@ -0,0 +1,82 @@
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
+#ifdef CONFIG_PM_RUNTIME
+int omap_pm_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	int r, ret = 0;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	ret = pm_generic_runtime_suspend(dev);
+
+	if (!ret && dev->parent == &omap_bus) {
+		r = omap_device_idle(pdev);
+		WARN_ON(r);
+	}
+
+	return ret;
+};
+
+int omap_pm_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	int r;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	if (dev->parent == &omap_bus) {
+		r = omap_device_enable(pdev);
+		WARN_ON(r);
+	}
+
+	return pm_generic_runtime_resume(dev);
+};
+#endif /* CONFIG_PM_RUNTIME */
+
+static int __init omap_pm_runtime_init(void)
+{
+	const struct dev_pm_ops *pm;
+	struct dev_pm_ops *omap_pm;
+
+	pm = platform_bus_get_pm_ops();
+	if (!pm) {
+		pr_err("%s: unable to get dev_pm_ops from platform_bus\n",
+			__func__);
+		return -ENODEV;
+	}
+
+	omap_pm = kmemdup(pm, sizeof(struct dev_pm_ops), GFP_KERNEL);
+	if (!omap_pm) {
+		pr_err("%s: unable to alloc memory for new dev_pm_ops\n",
+			__func__);
+		return -ENOMEM;
+	}
+		
+	omap_pm->runtime_suspend = omap_pm_runtime_suspend;
+	omap_pm->runtime_resume = omap_pm_runtime_resume;
+
+	platform_bus_set_pm_ops(omap_pm);
+
+	return 0;
+}
+core_initcall(omap_pm_runtime_init);
-- 
1.7.2.1

