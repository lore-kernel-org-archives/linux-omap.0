From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/3] omap4: suspend: Add basic system suspend support
Date: Tue,  6 Jul 2010 20:27:55 +0530
Message-ID: <1278428275-8605-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57782 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab0GFO6I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 10:58:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This patch adds support for basic suspend doing a CPUx wfi
for OMAP4. All powerdomains are for now are kept programmed
in ON state.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Makefile |    1 +
 arch/arm/mach-omap2/pm44xx.c |  135 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 136 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/pm44xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 0efcc94..3cb1b51 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -49,6 +49,7 @@ ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
new file mode 100644
index 0000000..54544b4
--- /dev/null
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -0,0 +1,135 @@
+/*
+ * OMAP4 Power Management Routines
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Rajendra Nayak <rnayak@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/pm.h>
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#include <plat/powerdomain.h>
+#include <mach/omap4-common.h>
+
+struct power_state {
+	struct powerdomain *pwrdm;
+	u32 next_state;
+#ifdef CONFIG_SUSPEND
+	u32 saved_state;
+#endif
+	struct list_head node;
+};
+
+static LIST_HEAD(pwrst_list);
+
+#ifdef CONFIG_SUSPEND
+static int omap4_pm_prepare(void)
+{
+	disable_hlt();
+	return 0;
+}
+
+static int omap4_pm_suspend(void)
+{
+	do_wfi();
+	return 0;
+}
+
+static int omap4_pm_enter(suspend_state_t suspend_state)
+{
+	int ret = 0;
+
+	switch (suspend_state) {
+	case PM_SUSPEND_STANDBY:
+	case PM_SUSPEND_MEM:
+		ret = omap4_pm_suspend();
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static void omap4_pm_finish(void)
+{
+	enable_hlt();
+	return;
+}
+
+static int omap4_pm_begin(suspend_state_t state)
+{
+	return 0;
+}
+
+static void omap4_pm_end(void)
+{
+	return;
+}
+
+static struct platform_suspend_ops omap_pm_ops = {
+	.begin		= omap4_pm_begin,
+	.end		= omap4_pm_end,
+	.prepare	= omap4_pm_prepare,
+	.enter		= omap4_pm_enter,
+	.finish		= omap4_pm_finish,
+	.valid		= suspend_valid_only_mem,
+};
+#endif /* CONFIG_SUSPEND */
+
+static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
+{
+	struct power_state *pwrst;
+
+	if (!pwrdm->pwrsts)
+		return 0;
+
+	pwrst = kmalloc(sizeof(struct power_state), GFP_ATOMIC);
+	if (!pwrst)
+		return -ENOMEM;
+	pwrst->pwrdm = pwrdm;
+	pwrst->next_state = PWRDM_POWER_ON;
+	list_add(&pwrst->node, &pwrst_list);
+
+	return pwrdm_set_next_pwrst(pwrst->pwrdm, pwrst->next_state);
+}
+
+/**
+ * omap4_pm_init - Init routine for OMAP4 PM
+ *
+ * Initializes all powerdomain and clockdomain target states
+ * and all PRCM settings.
+ */
+static int __init omap4_pm_init(void)
+{
+	int ret;
+
+	if (!cpu_is_omap44xx())
+		return -ENODEV;
+
+	pr_err("Power Management for TI OMAP4.\n");
+
+#ifdef CONFIG_PM
+	ret = pwrdm_for_each(pwrdms_setup, NULL);
+	if (ret) {
+		pr_err("Failed to setup powerdomains\n");
+		goto err2;
+	}
+#endif
+
+#ifdef CONFIG_SUSPEND
+	suspend_set_ops(&omap_pm_ops);
+#endif /* CONFIG_SUSPEND */
+
+err2:
+	return ret;
+}
+late_initcall(omap4_pm_init);
-- 
1.6.0.4

