From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/3] OMAP: PM: initial runtime PM core support
Date: Wed, 23 Jun 2010 16:37:02 -0700
Message-ID: <1277336224-24826-2-git-send-email-khilman@deeprootsystems.com>
References: <1277336224-24826-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52071 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753514Ab0FWXhJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 19:37:09 -0400
Received: by pwj8 with SMTP id 8so1604422pwj.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Jun 2010 16:37:09 -0700 (PDT)
In-Reply-To: <1277336224-24826-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Implement the new runtime PM framework as a thin layer on top of the
omap_device API.  Since we don't have an OMAP-specific bus, override
the runtime PM hooks for the platform_bus for the OMAP specific
implementation.

While the runtime PM API has three main states (idle, suspend, resume)
This version treats idle and suspend the same way by implementing both
on top of omap_device_disable(), which follows closely with how driver
are currently using clock enable/disable calls. Longer-termm
pm_runtime_idle() could take other constraints into consideration to
make the decision, but the current

Device driver ->runtime_suspend() hooks are called just before the
device is disabled (via omap_device_idle()), and device driver
->runtime_resume() hooks are called just after device has been
enabled (via omap_device_enable().)

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Makefile |    7 +++-
 arch/arm/mach-omap2/pm_bus.c |   72 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm_bus.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index ea52b03..8ed47ea 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -46,12 +46,17 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o \
+					   pm_bus.o
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
index 0000000..69acaa5
--- /dev/null
+++ b/arch/arm/mach-omap2/pm_bus.c
@@ -0,0 +1,72 @@
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
+int platform_pm_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *odev = to_omap_device(pdev);
+	int r, ret = 0;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	if (dev->driver->pm && dev->driver->pm->runtime_suspend)
+		ret = dev->driver->pm->runtime_suspend(dev);
+	if (!ret && omap_device_is_valid(odev)) {
+		r = omap_device_idle(pdev);
+		WARN_ON(r);
+	}
+
+	return ret;
+};
+
+int platform_pm_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct omap_device *odev = to_omap_device(pdev);
+	int r, ret = 0;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	if (omap_device_is_valid(odev)) {
+		r = omap_device_enable(pdev);
+		WARN_ON(r);
+	}
+
+	if (dev->driver->pm && dev->driver->pm->runtime_resume)
+		ret = dev->driver->pm->runtime_resume(dev);
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
+	ret = pm_runtime_suspend(dev);
+	dev_dbg(dev, "%s [%d]\n", __func__, ret);
+
+	return 0;
+};
+#endif /* CONFIG_PM_RUNTIME */
+
-- 
1.7.0.2

