From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 1/2] OMAP2+: PM: initial runtime PM core support
Date: Wed, 15 Sep 2010 17:00:13 -0700
Message-ID: <1284595214-29155-2-git-send-email-khilman@deeprootsystems.com>
References: <1284595214-29155-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63430 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774Ab0IPAAT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 20:00:19 -0400
Received: by iwn5 with SMTP id 5so519491iwn.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Sep 2010 17:00:19 -0700 (PDT)
In-Reply-To: <1284595214-29155-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>

Implement the new runtime PM framework as a thin layer on top of the
omap_device API.  OMAP specific runtime PM methods are registered with
the as custom methods on the platform_bus.

In order to determine if a device is an omap_device, its parent device
is checked.  All omap_devices have a new 'omap_device_parent_ device
as their parent device, so checking for this parent is used to check
for valid omap_devices.  If a device is an omap_device, then the
appropriate omap_device functions are called for it.  If not, only the
generic runtime PM functions are called.

Device driver's ->runtime_idle() hook is called when the runtime PM
usecount reaches zero for that device.  Driver's ->runtime_suspend()
hooks are called just before the device is disabled (via
omap_device_idle()), and device driver ->runtime_resume() hooks are
called just after device has been enabled (via omap_device_enable().)

OMAP4 build support from Rajendra Nayak <rnayak@ti.com>.
OMAP2 build support from Charulatha V <charu@ti.com>

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Charulatha V <charu@ti.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Makefile |   10 +++-
 arch/arm/mach-omap2/pm_bus.c |   85 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm_bus.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 88d3a1e..b48ca60 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -49,14 +49,18 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
 # Power Management
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
-obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o
+obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o pm_bus.o
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
index 0000000..784989f
--- /dev/null
+++ b/arch/arm/mach-omap2/pm_bus.c
@@ -0,0 +1,85 @@
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
+	if (!ret && dev->parent == &omap_device_parent) {
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
+	if (dev->parent == &omap_device_parent) {
+		r = omap_device_enable(pdev);
+		WARN_ON(r);
+	}
+
+	return pm_generic_runtime_resume(dev);
+};
+#else
+#define omap_pm_runtime_suspend NULL
+#define omap_pm_runtime_resume NULL
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

