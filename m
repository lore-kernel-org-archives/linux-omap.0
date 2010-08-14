From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv2 6/13] dmtimer: hwmod: OMAP2PLUS: device registration
Date: Sat, 14 Aug 2010 21:07:18 +0530
Message-ID: <1281800238-15135-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45256 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932645Ab0HNEiE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Aug 2010 00:38:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Partha Basak <p-basak2@ti.com>, Rajendra Nayak <rnayak@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

From: Thara Gopinath <thara@ti.com>

This patch converts dmtimers into platform devices using omap hwmod,
omap device and runtime pm frameworks. It also allows GPTIMER1 and
GPTIMER2 and GPTIMER10 to be registered as early devices. This allows
any one of the these three to be registered as system timer very early
during system boot sequence. Later during normal plaform_device_register
these are converted to normal platform device.

comments incorporated:
(1) registration of devices through automatic learning from hwmod database
(2) enabling functionality both with and without pm_runtime
(3) extract device id from hwmod structure's name field.
(4) free platform data at the end of successful platform device registration

Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile   |    2 +-
 arch/arm/mach-omap2/dmtimer.c  |  403 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/dmtimer.h  |   19 ++
 arch/arm/mach-omap2/io.c       |    2 +
 arch/arm/mach-omap2/timer-gp.c |    1 -
 5 files changed, 425 insertions(+), 2 deletions(-)
 create mode 100755 arch/arm/mach-omap2/dmtimer.c
 create mode 100755 arch/arm/mach-omap2/dmtimer.h
 mode change 100644 => 100755 arch/arm/mach-omap2/io.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 9b44773..c54f6e8 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o
+obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o dmtimer.o
 
 omap-2-3-common				= irq.o sdrc.o
 hwmod-common				= omap_hwmod.o \
diff --git a/arch/arm/mach-omap2/dmtimer.c b/arch/arm/mach-omap2/dmtimer.c
new file mode 100755
index 0000000..2c40a9b
--- /dev/null
+++ b/arch/arm/mach-omap2/dmtimer.c
@@ -0,0 +1,403 @@
+/**
+ * linux/arch/arm/mach-omap2/dmtimer.c
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Thara Gopinath <thara@ti.com>
+ * Tarun Kanti DebBarma <tarun.kanti@ti.com>
+ * - Highlander ip support on omap4
+ * - hwmod support
+ *
+ * OMAP2 Dual-Mode Timers
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#include <mach/irqs.h>
+#include <plat/dmtimer.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
+#include <linux/pm_runtime.h>
+
+static int early_timer_count __initdata;
+static int is_early_init __initdata = 1;
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
+	"sys_clkin_ck",
+	"sys_32k_ck",
+	"syc_clk_div_ck",
+	NULL
+};
+static struct clk *omap4_dm_source_clocks[3];
+
+static struct clk **omap_dm_source_clocks;
+
+static void omap2_dm_timer_enable(struct platform_device *pdev)
+{
+	if (!pdev) {
+		dev_err(&pdev->dev, "%s: invalid pdev\n", __func__);
+		return;
+	}
+	pm_runtime_get_sync(&pdev->dev);
+}
+
+static void omap2_dm_timer_disable(struct platform_device *pdev)
+{
+	if (!pdev) {
+		dev_err(&pdev->dev, "%s: invalid pdev\n", __func__);
+		return;
+	}
+	pm_runtime_put_sync(&pdev->dev);
+}
+
+static void omap2_dm_early_timer_enable(struct platform_device *pdev)
+{
+#ifdef CONFIG_PM_RUNTIME
+	/* when pm_runtime is enabled, it is still inactive at this point
+	 * that is why this call is needed as it is not enabled by default
+	 */
+	if (omap_device_enable(pdev))
+		dev_warn(&pdev->dev, "%s: Unable to enable the timer%d\n",
+			__func__, pdev->id);
+#endif
+}
+
+static void omap2_dm_early_timer_disable(struct platform_device *pdev)
+{
+#ifdef CONFIG_PM_RUNTIME
+	/* when pm_runtime is enabled, it is still inactive at this point
+	 * that is why this call is needed as it is not enabled by default
+	 */
+	if (omap_device_idle(pdev))
+		dev_warn(&pdev->dev, "%s: Unable to disable the timer%d\n",
+			__func__, pdev->id);
+#endif
+}
+
+/**
+* omap2_dm_timer_set_src - change the timer input clock source
+* @pdev: timer platform device pointer
+* @timer_clk: current clock source
+* @source: array index of parent clock source
+**/
+static int omap2_dm_timer_set_src(struct platform_device *pdev,
+			struct clk *timer_clk, int source)
+{
+	int ret;
+
+	if (IS_ERR(timer_clk)) {
+		dev_warn(&pdev->dev, "%s: Not able get the clock pointer\n",
+			__func__);
+		return -EINVAL;
+	}
+
+#ifndef CONFIG_PM_RUNTIME
+	clk_disable(timer_clk); /* enabled in hwmod */
+#else
+	if (unlikely(is_early_init))
+		omap_device_idle(pdev);
+	else
+		pm_runtime_put_sync(&pdev->dev);
+#endif
+
+	ret = clk_set_parent(timer_clk, omap_dm_source_clocks[source]);
+	if (ret)
+		dev_warn(&pdev->dev, "%s: Not able to change "
+			"fclk source\n", __func__);
+
+#ifndef CONFIG_PM_RUNTIME
+	clk_enable(timer_clk);
+#else
+	if (unlikely(is_early_init))
+		omap_device_enable(pdev);
+	else
+		pm_runtime_get_sync(&pdev->dev);
+#endif
+
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
+struct clk *omap2_dm_timer_get_fclk(struct platform_device *pdev)
+{
+	return clk_get(&pdev->dev, "fck");
+}
+
+static int omap2_dm_early_timer_set_clk
+			(struct platform_device *pdev, int source)
+{
+	struct omap_device *odev = to_omap_device(pdev);
+
+	dev_dbg(&pdev->dev, "%s:+\n", __func__);
+	return omap2_dm_timer_set_src(pdev,
+			omap_hwmod_get_clk(odev->hwmods[0]),
+			source);
+}
+
+static struct clk *omap2_dm_early_timer_get_fclk
+				(struct platform_device *pdev)
+{
+	struct omap_device *odev = to_omap_device(pdev);
+
+	dev_dbg(&pdev->dev, "%s:+\n", __func__);
+	return omap_hwmod_get_clk(odev->hwmods[0]);
+}
+
+/**
+* omap2_dm_timer_setup - acquire clock structure associated with
+* current omap platform
+*
+* timers in different omap platform support different types of clocks
+* as input source. there is a static array of struct clk * as its
+* elements which are initialized to point to respective clk structure.
+* the clk structures are obtained using clk_get() which fetches the
+* clock pointer from a omap platform specific static clock array.
+* these clk* elements are finally used while changing the input clock
+* source of the timers.
+**/
+static void __init omap2_dm_timer_setup(void)
+{
+	int i;
+	char **clock_source_names;
+
+	if (cpu_is_omap24xx()) {
+		clock_source_names = omap2_dm_source_names;
+		omap_dm_source_clocks = omap2_dm_source_clocks;
+	} else if (cpu_is_omap34xx()) {
+		clock_source_names = omap3_dm_source_names;
+		omap_dm_source_clocks = omap3_dm_source_clocks;
+	} else if (cpu_is_omap44xx()) {
+		clock_source_names = omap4_dm_source_names;
+		omap_dm_source_clocks = omap4_dm_source_clocks;
+	} else {
+		pr_err("%s: Chip support not yet added\n", __func__);
+		return;
+	}
+
+	/* Initialize the dmtimer src clocks */
+	for (i = 0; clock_source_names[i] != NULL; i++)
+			omap_dm_source_clocks[i] =
+				clk_get(NULL, clock_source_names[i]);
+}
+
+struct omap_device_pm_latency omap2_dmtimer_latency[] = {
+	{
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+/**
+* omap_dm_timer_early_init - build and register early timer device
+* with an associated timer hwmod
+* @oh: timer hwmod pointer to be used to build timer device
+* @user: parameter that can be passed from calling hwmod API
+*
+* early init is called in the last part of omap2_init_common_hw
+* for each early timer class using omap_hwmod_for_each_by_class.
+* it registers each of the timer devices present in the system.
+* at the end of function call memory is allocated for omap_device
+* and hwmod for early timer and the device is registered to the
+* framework ready to be probed by the driver.
+**/
+static int __init omap_dm_timer_early_init(struct omap_hwmod *oh, void *user)
+{
+	int id;
+	int ret = 0;
+	char *name = "dmtimer";
+	struct omap_dmtimer_platform_data *pdata;
+	struct omap_device *od;
+
+	if (!oh) {
+		pr_err("%s:Could not find [%s]\n", __func__, oh->name);
+		return -EINVAL;
+	}
+
+	pr_debug("%s:%s\n", __func__, oh->name);
+
+	pdata = kzalloc(sizeof(struct omap_dmtimer_platform_data),
+			GFP_KERNEL);
+	if (!pdata) {
+		pr_err("%s: No memory for [%s]\n", __func__, oh->name);
+		return -ENOMEM;
+	}
+	/* hook timer enable/disable functions */
+	pdata->omap_dm_clk_enable = omap2_dm_early_timer_enable;
+	pdata->omap_dm_clk_disable = omap2_dm_early_timer_disable;
+
+	/* hook clock set/get functions */
+	pdata->omap_dm_set_source_clk = omap2_dm_early_timer_set_clk;
+	pdata->omap_dm_get_timer_clk = omap2_dm_early_timer_get_fclk;
+
+	/* read timer ip version */
+	pdata->timer_ip_type = oh->class->rev;
+
+	/*
+	* extract the id from name
+	* this is not the best implementation, but the cleanest with
+	* the existing constraints: (1) early timers are not sequential,
+	* 1/2/10 (2) export APIs use id's to identify corresponding
+	* timers (3) non-early timers initialization have to track the
+	* id's already used by early timers.
+	*
+	* well, the ideal solution would have been to have an 'id' field
+	* in struct omap_hwmod {}. otherwise, we have to have devattr
+	* for all timers.
+	*/
+	sscanf(oh->name, "timer%2d", &id);
+
+	od = omap_device_build(name, id - 1, oh, pdata, sizeof(*pdata),
+			omap2_dmtimer_latency,
+			ARRAY_SIZE(omap2_dmtimer_latency), 1);
+
+	if (IS_ERR(od)) {
+		pr_err("%s: Cant build omap_device for %s:%s.\n",
+			__func__, name, oh->name);
+		ret = -EINVAL;
+	} else
+		early_timer_count++;
+	/*
+	* pdata can be freed because omap_device_build
+	* creates its own memory pool
+	*/
+	kfree(pdata);
+
+	return ret;
+}
+
+/**
+* omap2_dm_timer_init - build and register timer device with an
+* associated timer hwmod
+* @oh: timer hwmod pointer to be used to build timer device
+* @user: parameter that can be passed from calling hwmod API
+*
+* called by omap_hwmod_for_each_by_class to register each of the timer
+* devices present in the system. the number of timer devices is known
+* by parsing through the hwmod database for a given class name. at the
+* end of function call memory is allocated for omap_device and hwmod
+* for timer and the device is registered to the framework ready to be
+* proved by the driver.
+**/
+static int __init omap2_dm_timer_init(struct omap_hwmod *oh, void *user)
+{
+	int id;
+	int ret = 0;
+	char *name = "dmtimer";
+	struct omap_device *od;
+	struct omap_dmtimer_platform_data *pdata;
+
+	if (!oh) {
+		pr_err("%s:NULL hwmod pointer (oh)\n", __func__);
+		return -EINVAL;
+	}
+	pr_debug("%s:%s\n", __func__, oh->name);
+
+	pdata = kzalloc(sizeof(struct omap_dmtimer_platform_data), GFP_KERNEL);
+	if (!pdata) {
+		pr_err("%s:No memory for [%s]\n",  __func__, oh->name);
+		return -ENOMEM;
+	}
+	/* hook timer enable/disable functions */
+	pdata->omap_dm_clk_enable = omap2_dm_timer_enable;
+	pdata->omap_dm_clk_disable = omap2_dm_timer_disable;
+
+	/* hook clock set/get functions */
+	pdata->omap_dm_set_source_clk = omap2_dm_timer_set_clk;
+	pdata->omap_dm_get_timer_clk = omap2_dm_timer_get_fclk;
+
+	/* read timer ip version */
+	pdata->timer_ip_type = oh->class->rev;
+
+	/*
+	* extract the id from name
+	* this may not the best implementation, but the cleanest with
+	* the existing constraints: (1) early timers are not sequential,
+	* 1/2/10 (2) export APIs use id's to identify corresponding
+	* timers (3) non-early timers initialization have to track the
+	* id's already used by early timers.
+	*
+	* well, the ideal solution would have been to have an 'id' field
+	* in struct omap_hwmod {}. otherwise we have to have devattr for
+	* all timers.
+	*/
+	sscanf(oh->name, "timer%2d", &id);
+
+	od = omap_device_build(name, id - 1, oh,
+			pdata, sizeof(*pdata),
+			omap2_dmtimer_latency,
+			ARRAY_SIZE(omap2_dmtimer_latency), 0);
+
+	if (IS_ERR(od)) {
+		pr_err("%s: Cant build omap_device for %s:%s.\n",
+			__func__, name, oh->name);
+		ret =  -EINVAL;
+	}
+	/*
+	* pdata can be freed because omap_device_build
+	* creates its own memory pool
+	*/
+	kfree(pdata);
+	return ret;
+}
+
+/**
+* omap2_dm_timer_early_init - top level early timer initialization
+* called in the last part of omap2_init_common_hw
+*
+* uses dedicated hwmod api to parse through hwmod database for
+* given class name and then build and register the timer device.
+* at the end driver is registered and early probe initiated.
+**/
+void __init omap2_dm_timer_early_init(void)
+{
+	omap_hwmod_for_each_by_class("timer_1ms",
+				omap_dm_timer_early_init, NULL);
+	omap2_dm_timer_setup();
+	early_platform_driver_register_all("earlytimer");
+	early_platform_driver_probe("earlytimer", early_timer_count + 1, 0);
+}
+
+/**
+* omap_timer_init - top level timer device initialization
+*
+* uses dedicated hwmod api to parse through hwmod database for
+* given class names and then build and register the timer device.
+**/
+static int __init omap_timer_init(void)
+{
+	/* disable early init flag */
+	is_early_init = 0;
+
+	/* register all timers again */
+	omap_hwmod_for_each_by_class("timer_1ms", omap2_dm_timer_init, NULL);
+	omap_hwmod_for_each_by_class("timer", omap2_dm_timer_init, NULL);
+	return 0;
+}
+arch_initcall(omap_timer_init);
diff --git a/arch/arm/mach-omap2/dmtimer.h b/arch/arm/mach-omap2/dmtimer.h
new file mode 100755
index 0000000..527e1b7
--- /dev/null
+++ b/arch/arm/mach-omap2/dmtimer.h
@@ -0,0 +1,19 @@
+/**
+ * linux/arch/arm/mach-omap2/dmtimers.h
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Thara Gopinath <thara@ti.com>
+ * Tarun Kanti DebBarma <tarun.kanti@ti.com>
+ *
+ * OMAP2 Dual-Mode Timers
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARCH_DMTIMERS_H
+#define __ASM_ARCH_DMTIMERS_H
+
+void __init omap2_dm_timer_early_init(void);
+
+#endif
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 490d870..68a2e40
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -45,6 +45,7 @@
 #include "clockdomains.h"
 
 #include <plat/omap_hwmod.h>
+#include "dmtimer.h"
 
 /*
  * The machine specific code may provide the extra mapping besides the
@@ -351,4 +352,5 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 		_omap2_init_reprogram_sdrc();
 	}
 	gpmc_init();
+	omap2_dm_timer_early_init();
 }
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 74fbed8..c2d8a0d 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -231,7 +231,6 @@ static void __init omap2_gp_timer_init(void)
 	twd_base = ioremap(OMAP44XX_LOCAL_TWD_BASE, SZ_256);
 	BUG_ON(!twd_base);
 #endif
-	omap_dm_timer_init();
 
 	omap2_gp_clockevent_init();
 	omap2_gp_clocksource_init();
-- 
1.6.0.4

