From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP1: PM: add simple runtime PM layer to manage clocks
Date: Thu, 17 Jun 2010 16:08:07 -0700
Message-ID: <1276816087-2924-1-git-send-email-khilman@deeprootsystems.com>
References: <1274994799-30297-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53936 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932941Ab0FQXIL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 19:08:11 -0400
Received: by pwi1 with SMTP id 1so187373pwi.19
        for <linux-omap@vger.kernel.org>; Thu, 17 Jun 2010 16:08:10 -0700 (PDT)
In-Reply-To: <1274994799-30297-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

On OMAP1, we do not have omap_device + omap_hwmod to manage the
device-specific idle, enable and shutdown.  Instead, just
enable/disable device clocks automatically at the runtime PM level.

This allows drivers to not have any OMAP1 specific clock management
and allows them to simply use the runtime PM API to manage clocks.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
This patch applies on top of the initial runtime PM support series:

  [PATCH 0/4] runtime PM support at the bus level

posted to linux-omap on May 27th.  It is also now included in
my pm-wip/runtime branch in my git tree.

 arch/arm/mach-omap1/Makefile |    2 +-
 arch/arm/mach-omap1/pm_bus.c |   77 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap1/pm_bus.c

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index ea231c7..fd4df71 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_OMAP_MPU_TIMER)	+= time.o
 obj-$(CONFIG_OMAP_32K_TIMER)	+= timer32k.o
 
 # Power Management
-obj-$(CONFIG_PM) += pm.o sleep.o
+obj-$(CONFIG_PM) += pm.o sleep.o pm_bus.o
 
 # DSP
 obj-$(CONFIG_OMAP_MBOX_FWK)	+= mailbox_mach.o
diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bus.c
new file mode 100644
index 0000000..46a34fc
--- /dev/null
+++ b/arch/arm/mach-omap1/pm_bus.c
@@ -0,0 +1,77 @@
+/*
+ * Runtime PM support code for OMAP1
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
+	struct clk *iclk, *fclk;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	if (dev->driver->pm && dev->driver->pm->runtime_suspend)
+		ret = dev->driver->pm->runtime_suspend(dev);
+
+	fclk = clk_get(dev, "fck");
+	if (!IS_ERR(fclk)) {
+		clk_disable(fclk);
+		clk_put(fclk);
+	}
+
+	iclk = clk_get(dev, "ick");
+	if (!IS_ERR(iclk)) {
+		clk_disable(iclk);
+		clk_put(iclk);
+	}
+
+	return 0;
+};
+
+int platform_pm_runtime_resume(struct device *dev)
+{
+	int r, ret = 0;
+	struct clk *iclk, *fclk;
+
+	iclk = clk_get(dev, "fck");
+	if (!IS_ERR(iclk)) {
+		clk_enable(iclk);
+		clk_put(iclk);
+	}
+
+	fclk = clk_get(dev, "fck");
+	if (!IS_ERR(fclk)) {
+		clk_enable(fclk);
+		clk_put(fclk);
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
+	ret = pm_runtime_suspend(dev);
+	dev_dbg(dev, "%s [%d]\n", __func__, ret);
+
+	return 0;
+};
+#endif /* CONFIG_PM_RUNTIME */
-- 
1.7.0.2

