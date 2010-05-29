From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 3/9] OMAP2/3/4 : Dual mode timer device registration.
Date: Sat, 29 May 2010 20:07:05 +0530
Message-ID: <1275143831-7629-4-git-send-email-thara@ti.com>
References: <1275143831-7629-1-git-send-email-thara@ti.com>
 <1275143831-7629-2-git-send-email-thara@ti.com>
 <1275143831-7629-3-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38920 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756994Ab0E2OhY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 May 2010 10:37:24 -0400
In-Reply-To: <1275143831-7629-3-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch converts OMAP2/OMAP3/OMAP4 dual mode timers into
platform devices using omap hwmod, omap device and runtime pm frameworks.
This patch also allows GPTIMER1 and GPTIMER2 to be registered as
early devices. This will allow GPTIMER1 to be registered as
system timer very early on in the system boot up sequence.
Later during normal plaform_device_register these are converted
to normal platform device.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/Makefile   |    3 +-
 arch/arm/mach-omap2/dmtimers.c |  296 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/dmtimers.h |   57 ++++++++
 arch/arm/mach-omap2/timer-gp.c |    2 -
 4 files changed, 355 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-omap2/dmtimers.c
 create mode 100644 arch/arm/mach-omap2/dmtimers.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index dd3a24a..9299e4f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,7 +3,8 @@
 #
 
 # Common support
-obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
+obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o \
+	dmtimers.o
 
 omap-2-3-common				= irq.o sdrc.o
 hwmod-common				= omap_hwmod.o \
diff --git a/arch/arm/mach-omap2/dmtimers.c b/arch/arm/mach-omap2/dmtimers.c
new file mode 100644
index 0000000..6a2caf3
--- /dev/null
+++ b/arch/arm/mach-omap2/dmtimers.c
@@ -0,0 +1,296 @@
+/**
+ * OMAP2 Dual-Mode Timers
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Thara Gopinath <thara@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
+
+#include <mach/irqs.h>
+#include <plat/dmtimer.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
+
+#include "dmtimers.h"
+
+#define NO_EARLY_TIMERS			2
+#define OMAP2_DM_TIMER_COUNT		12
+#define OMAP3PLUS_DM_TIMER_COUNT	11
+
+static char *omap2_dm_source_names[] __initdata = {
+	"sys_ck",
+	"func_32k_ck",
+	"alt_ck",
+	NULL
+};
+static struct clk *omap2_dm_source_clocks[3];
+
+static char *omap3_dm_source_names[] __initdata = {
+	"sys_ck",
+	"omap_32k_fck",
+	NULL
+};
+static struct clk *omap3_dm_source_clocks[2];
+
+static char *omap4_dm_source_names[] __initdata = {
+	"sys_ck",
+	"sys_32k_ck",
+	NULL
+};
+static struct clk *omap4_dm_source_clocks[2];
+
+static struct clk **omap_dm_source_clocks;
+
+static void omap2_dm_timer_enable(struct platform_device *pdev)
+{
+
+	if (pm_runtime_get_sync(&pdev->dev))
+		dev_warn(&pdev->dev, "%s: Unable to enable the timer\n",
+			__func__);
+#ifndef CONFIG_PM_RUNTIME
+	if (omap_device_enable(pdev))
+		dev_warn(&pdev->dev, "%s: Unable to enable the timer\n",
+			__func__);
+#endif
+}
+
+static void omap2_dm_timer_disable(struct platform_device *pdev)
+{
+
+	if (pm_runtime_put_sync(&pdev->dev))
+		dev_warn(&pdev->dev, "%s: Unable to disable the timer\n",
+			__func__);
+#ifndef CONFIG_PM_RUNTIME
+	if (omap_device_idle(pdev))
+		dev_warn(&pdev->dev, "%s: Unable to disable the timer\n",
+			__func__);
+#endif
+}
+
+static int omap2_dm_timer_set_src(struct platform_device *pdev,
+					struct clk *timer_clk, int source)
+{
+	int ret;
+
+	if (IS_ERR(timer_clk)) {
+		dev_warn(&pdev->dev, "%s: Not able get the clock pointer\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	clk_disable(timer_clk);
+	ret = clk_set_parent(timer_clk, omap_dm_source_clocks[source]);
+	if (ret)
+		dev_warn(&pdev->dev, "%s: Not able to change the"
+			"fclk source\n", __func__);
+
+	clk_enable(timer_clk);
+	/*
+	 * When the functional clock disappears, too quick writes seem
+	 * to cause an abort. XXX Is this still necessary?
+	 */
+	__delay(150000);
+	return ret;
+}
+
+static int omap2_dm_timer_set_clk(struct platform_device *pdev, int source)
+{
+	struct clk *timer_clk = clk_get(&pdev->dev, "fck");
+
+	return omap2_dm_timer_set_src(pdev, timer_clk, source);
+}
+
+static struct clk *omap2_dm_timer_get_fclk(struct platform_device *pdev)
+{
+	return clk_get(&pdev->dev, "fck");
+}
+
+/* API's to be used by early timer devices */
+static void __init omap2_dm_early_timer_enable(struct platform_device *pdev)
+{
+	if (omap_device_enable(pdev))
+		dev_warn(&pdev->dev, "%s: Unable to enable the timer\n",
+			__func__);
+}
+
+static void __init omap2_dm_early_timer_disable(struct platform_device *pdev)
+{
+	if (omap_device_idle(pdev))
+		dev_warn(&pdev->dev, "%s: Unable to disable the timer\n",
+			__func__);
+}
+
+static int __init omap2_dm_early_timer_set_clk(struct platform_device *pdev,
+					int source)
+{
+	struct omap_device *odev = to_omap_device(pdev);
+
+	return omap2_dm_timer_set_src(pdev, odev->hwmods[0]->_clk, source);
+}
+
+static struct clk __init *omap2_dm_early_timer_get_fclk
+				(struct platform_device *pdev)
+{
+	struct omap_device *odev = to_omap_device(pdev);
+
+	return odev->hwmods[0]->_clk;
+}
+
+/* One time initializations */
+static void __init omap2_dm_timer_setup(void)
+{
+	static int is_initialized;
+	char **src_clk_name;
+	int i;
+
+	/*
+	 * Check if setup has already been done as part of early init.
+	 * If yes avoid doing it again.
+	 */
+	if (is_initialized)
+		return;
+
+	if (cpu_is_omap24xx()) {
+		src_clk_name = omap2_dm_source_names;
+		omap_dm_source_clocks = omap2_dm_source_clocks;
+	} else if (cpu_is_omap34xx()) {
+		src_clk_name = omap3_dm_source_names;
+		omap_dm_source_clocks = omap3_dm_source_clocks;
+	} else if (cpu_is_omap44xx()) {
+		src_clk_name = omap4_dm_source_names;
+		omap_dm_source_clocks = omap4_dm_source_clocks;
+	} else {
+		pr_err("%s: Chip support not yet added\n", __func__);
+		return;
+	}
+
+	/* Initialize the dmtimer src clocks */
+	for (i = 0; src_clk_name[i] != NULL; i++)
+			omap_dm_source_clocks[i] =
+				clk_get(NULL, src_clk_name[i]);
+
+	/* Number of dmtimers in the system */
+	if (cpu_is_omap24xx())
+		omap_dm_timer_count = OMAP2_DM_TIMER_COUNT;
+	else
+		omap_dm_timer_count = OMAP3PLUS_DM_TIMER_COUNT;
+
+	is_initialized = 1;
+}
+
+struct omap_device_pm_latency omap2_dmtimer_latency[] = {
+	{
+	.deactivate_func = omap_device_idle_hwmods,
+	.activate_func   = omap_device_enable_hwmods,
+	.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+
+	},
+};
+
+int __init omap2_get_early_timer_count(void)
+{
+	return NO_EARLY_TIMERS;
+}
+
+void __init omap2_dm_timer_early_init(void)
+{
+	int i = 0;
+	char *name = "dmtimer";
+	do {
+		struct omap_device *od;
+		struct omap_hwmod *oh;
+		int hw_mod_name_len = 16;
+		char oh_name[hw_mod_name_len];
+		struct omap_dm_timer_plat_info *pdata;
+
+		snprintf(oh_name, hw_mod_name_len, "timer%d", i + 1);
+		oh = omap_hwmod_lookup(oh_name);
+		if (!oh)
+			break;
+
+		pdata = kzalloc(sizeof(struct omap_dm_timer_plat_info),
+				GFP_KERNEL);
+		if (!pdata) {
+			pr_err("%s: Unable to allocate pdata for %s:%s\n",
+				__func__, name, oh->name);
+			return;
+		}
+
+		pdata->omap_dm_clk_enable = omap2_dm_early_timer_enable;
+		pdata->omap_dm_clk_disable = omap2_dm_early_timer_disable;
+		pdata->omap_dm_set_source_clk = omap2_dm_early_timer_set_clk;
+		pdata->omap_dm_get_timer_clk = omap2_dm_early_timer_get_fclk;
+
+		od = omap_device_build(name, i, oh, pdata, sizeof(*pdata),
+				omap2_dmtimer_latency,
+				ARRAY_SIZE(omap2_dmtimer_latency), 1);
+		if (IS_ERR(od)) {
+			pr_err("%s: Cant build omap_device for %s:%s.\n",
+				__func__, name, oh->name);
+			kfree(pdata);
+		}
+		i++;
+	} while (i < NO_EARLY_TIMERS);
+
+	omap2_dm_timer_setup();
+	return;
+}
+
+static int __init omap2_dm_timer_init_dev(struct omap_hwmod *oh, void *user)
+{
+	struct omap_device *od;
+	struct omap_dm_timer_plat_info *pdata;
+	static int i;
+	char *name = "dmtimer";
+
+	pdata = kzalloc(sizeof(struct omap_dm_timer_plat_info), GFP_KERNEL);
+	if (!pdata) {
+		pr_err("%s: Unable to allocate pdata for %s:%s\n",
+			__func__, name, oh->name);
+		return -ENOMEM;
+	}
+
+	pdata->omap_dm_clk_enable = omap2_dm_timer_enable;
+	pdata->omap_dm_clk_disable = omap2_dm_timer_disable;
+	pdata->omap_dm_set_source_clk = omap2_dm_timer_set_clk;
+	pdata->omap_dm_get_timer_clk = omap2_dm_timer_get_fclk;
+
+	od = omap_device_build(name, i, oh, pdata, sizeof(*pdata),
+			omap2_dmtimer_latency,
+			ARRAY_SIZE(omap2_dmtimer_latency), 0);
+	if (IS_ERR(od)) {
+		pr_err("%s: Cant build omap_device for %s:%s.\n",
+			__func__, name, oh->name);
+		kfree(pdata);
+		i++;
+		return 0;
+	}
+	pm_runtime_enable(&(od->pdev.dev));
+	i++;
+	return 0;
+}
+
+static int __init omap2_dm_timer_init(void)
+{
+	int ret;
+
+	omap2_dm_timer_setup();
+
+	ret = omap_hwmod_for_each_by_class("timer_1ms",
+			omap2_dm_timer_init_dev, NULL);
+
+	ret |= omap_hwmod_for_each_by_class("timer",
+			omap2_dm_timer_init_dev, NULL);
+	return ret;
+}
+arch_initcall(omap2_dm_timer_init);
diff --git a/arch/arm/mach-omap2/dmtimers.h b/arch/arm/mach-omap2/dmtimers.h
new file mode 100644
index 0000000..dbc2b9d
--- /dev/null
+++ b/arch/arm/mach-omap2/dmtimers.h
@@ -0,0 +1,57 @@
+/**
+ * OMAP2 Dual-Mode Timers
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Thara Gopinath <thara@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARCH_DMTIMERS_H
+#define __ASM_ARCH_DMTIMERS_H
+
+#define OMAP2420_GPTIMER1_BASE		0x48028000
+#define OMAP2430_GPTIMER1_BASE		0x49018000
+#define OMAP24XX_GPTIMER2_BASE          0x4802a000
+#define OMAP24XX_GPTIMER3_BASE          0x48078000
+#define OMAP24XX_GPTIMER4_BASE          0x4807a000
+#define OMAP24XX_GPTIMER5_BASE          0x4807c000
+#define OMAP24XX_GPTIMER6_BASE          0x4807e000
+#define OMAP24XX_GPTIMER7_BASE          0x48080000
+#define OMAP24XX_GPTIMER8_BASE          0x48082000
+#define OMAP24XX_GPTIMER9_BASE          0x48084000
+#define OMAP24XX_GPTIMER10_BASE         0x48086000
+#define OMAP24XX_GPTIMER11_BASE         0x48088000
+#define OMAP24XX_GPTIMER12_BASE         0x4808a000
+
+#define OMAP34XX_GPTIMER1_BASE		0x48318000
+#define OMAP34XX_GPTIMER2_BASE		0x49032000
+#define OMAP34XX_GPTIMER3_BASE		0x49034000
+#define OMAP34XX_GPTIMER4_BASE		0x49036000
+#define OMAP34XX_GPTIMER5_BASE		0x49038000
+#define OMAP34XX_GPTIMER6_BASE		0x4903A000
+#define OMAP34XX_GPTIMER7_BASE		0x4903C000
+#define OMAP34XX_GPTIMER8_BASE		0x4903E000
+#define OMAP34XX_GPTIMER9_BASE		0x49040000
+#define OMAP34XX_GPTIMER10_BASE		0x48086000
+#define OMAP34XX_GPTIMER11_BASE		0x48088000
+#define OMAP34XX_GPTIMER12_BASE		0x48304000
+
+#define OMAP44XX_GPTIMER1_BASE		0x4a318000
+#define OMAP44XX_GPTIMER2_BASE          0x48032000
+#define OMAP44XX_GPTIMER3_BASE          0x48034000
+#define OMAP44XX_GPTIMER4_BASE          0x48036000
+#define OMAP44XX_GPTIMER5_BASE          0x40138000
+#define OMAP44XX_GPTIMER6_BASE          0x4013a000
+#define OMAP44XX_GPTIMER7_BASE          0x4013a000
+#define OMAP44XX_GPTIMER8_BASE          0x4013e000
+#define OMAP44XX_GPTIMER9_BASE          0x4803e000
+#define OMAP44XX_GPTIMER10_BASE         0x48086000
+#define OMAP44XX_GPTIMER11_BASE         0x48088000
+#define OMAP44XX_GPTIMER12_BASE         0x4a320000
+
+void __init omap2_dm_timer_early_init(void);
+int __init omap2_get_early_timer_count(void);
+#endif
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 74fbed8..d5f2ba7 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -231,8 +231,6 @@ static void __init omap2_gp_timer_init(void)
 	twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
 	BUG_ON(!twd_base);
 #endif
-	omap_dm_timer_init();
-
 	omap2_gp_clockevent_init();
 	omap2_gp_clocksource_init();
 }
-- 
1.7.0.rc1.33.g07cf0f

