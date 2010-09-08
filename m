From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/2] OMAP1: PM: add simple runtime PM layer to manage clocks
Date: Tue,  7 Sep 2010 17:54:42 -0700
Message-ID: <1283907282-986-2-git-send-email-khilman@deeprootsystems.com>
References: <1283907282-986-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39402 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab0IHAyt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 20:54:49 -0400
Received: by yxp4 with SMTP id 4so2087375yxp.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Sep 2010 17:54:48 -0700 (PDT)
In-Reply-To: <1283907282-986-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-arm-kernel@lists.infradead.org, Manjunatha GK <manjugk@ti.com>

From: Kevin Hilman <khilman@ti.com>

On OMAP1, we do not have omap_device + omap_hwmod to manage the
device-specific idle, enable and shutdown.  Instead, just
enable/disable device clocks automatically at the runtime PM level.

This allows drivers to not have any OMAP1 specific clock management
and allows them to simply use the runtime PM API to manage clocks.

OMAP1 compile fixes Manjunatha GK <manjugk@ti.com>

Cc: Manjunatha GK <manjugk@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap1/Makefile |    2 +-
 arch/arm/mach-omap1/pm_bus.c |   98 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap1/pm_bus.c

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index facfaeb..9a304d8 100644
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
index 0000000..c831348
--- /dev/null
+++ b/arch/arm/mach-omap1/pm_bus.c
@@ -0,0 +1,98 @@
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
+#include <linux/clk.h>
+#include <linux/err.h>
+
+#include <plat/omap_device.h>
+#include <plat/omap-pm.h>
+
+#ifdef CONFIG_PM_RUNTIME
+static int omap1_pm_runtime_suspend(struct device *dev)
+{
+	struct clk *iclk, *fclk;
+	int ret = 0;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	ret = pm_generic_runtime_suspend(dev);
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
+static int omap1_pm_runtime_resume(struct device *dev)
+{
+	int ret = 0;
+	struct clk *iclk, *fclk;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	iclk = clk_get(dev, "ick");
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
+	return pm_generic_runtime_resume(dev);
+};
+
+static int __init omap1_pm_runtime_init(void)
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
+	omap_pm->runtime_suspend = omap1_pm_runtime_suspend;
+	omap_pm->runtime_resume = omap1_pm_runtime_resume;
+
+	platform_bus_set_pm_ops(omap_pm);
+
+	return 0;
+}
+core_initcall(omap1_pm_runtime_init);
+#endif /* CONFIG_PM_RUNTIME */
-- 
1.7.2.1

