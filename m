From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv3 12/17] OMAP2/3/4: dmtimers: convert to platform devices
Date: Tue, 21 Sep 2010 14:25:07 +0530
Message-ID: <1285059307-26591-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48455 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751094Ab0ITVyO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Sep 2010 17:54:14 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Partha Basak <p-basak2@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

From: Thara Gopinath <thara@ti.com>

This patch adds routines to converts dmtimers to platform devices.
The device data is obtained from hwmod database of respective 
platform and is registered to device model after successful binding
to driver. It also provides provision to access timers during early
boot when pm_runtime framework is not completely up and running.

Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile  |    2 +-
 arch/arm/mach-omap2/dmtimer.c |  288 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 289 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/dmtimer.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 3949fba..f9625f8 100644
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
new file mode 100644
index 0000000..9cc21c0
--- /dev/null
+++ b/arch/arm/mach-omap2/dmtimer.c
@@ -0,0 +1,288 @@
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
+
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
+static int early_timer_count __initdata = 1;
+
+/**
+ * omap2_dm_timer_set_src - change the timer input clock source
+ * @pdev:	timer platform device pointer
+ * @timer_clk:	current clock source
+ * @source:	array index of parent clock source
+ */
+static int omap2_dm_timer_set_src(struct platform_device *pdev, int source)
+{
+	int ret;
+	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
+	struct clk *timer_clk = clk_get(&pdev->dev, "fck");
+
+	if (IS_ERR(timer_clk)) {
+		dev_warn(&pdev->dev, "%s: Not able get the clock pointer\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	ret = clk_set_parent(timer_clk, pdata->source_clocks[source]);
+	if (ret)
+		dev_warn(&pdev->dev, "%s: Not able to change "
+			"fclk source\n", __func__);
+
+	return ret;
+}
+
+/**
+ * omap2_dm_timer_setup - acquire clock structure associated with
+ * current omap platform
+ * @clk_name:	array of clock source names
+ * @clk_src:	array of struct clk associated with each clk_name's
+ *
+ * timers in different omap platform support different types of clocks
+ * as input source. there is a static array of struct clk * as its
+ * elements which are initialized to point to respective clk structure.
+ * the clk structures are obtained using clk_get() which fetches the
+ * clock pointer from a omap platform specific static clock array.
+ * these clk* elements are finally used while changing the input clock
+ * source of the timers.
+ */
+static void __init
+omap2_dm_timer_setup(char **clk_name, struct clk **clk_src)
+{
+	int i;
+
+	/* Initialize the dmtimer src clocks */
+	for (i = 0; clk_name[i] != NULL; i++)
+		clk_src[i] = clk_get(NULL, clk_name[i]);
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
+ * omap_dm_timer_early_init - build and register early timer device
+ * with an associated timer hwmod
+ * @oh: timer hwmod pointer to be used to build timer device
+ * @user: parameter that can be passed from calling hwmod API
+ *
+ * early init is called in the last part of omap2_init_common_hw
+ * for each early timer class using omap_hwmod_for_each_by_class.
+ * it registers each of the timer devices present in the system.
+ * at the end of function call memory is allocated for omap_device
+ * and hwmod for early timer and the device is registered to the
+ * framework ready to be probed by the driver.
+ */
+static int __init omap_dm_timer_early_init(struct omap_hwmod *oh, void *user)
+{
+	int id;
+	int ret = 0;
+	char *name = "dmtimer";
+	struct dmtimer_platform_data *pdata;
+	struct omap_device *od;
+	struct omap_timer_dev_attr *timer_dev_attr;
+
+	if (!oh) {
+		pr_err("%s:Could not find [%s]\n", __func__, oh->name);
+		return -EINVAL;
+	}
+
+	pr_debug("%s:%s\n", __func__, oh->name);
+
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		pr_err("%s: No memory for [%s]\n", __func__, oh->name);
+		return -ENOMEM;
+	}
+
+	pdata->is_early_init = true;
+
+	/* hook clock set/get functions */
+	pdata->set_timer_src = omap2_dm_timer_set_src;
+
+	/* read timer ip version */
+	pdata->timer_ip_type = oh->class->rev;
+
+	timer_dev_attr = oh->dev_attr;
+
+	/* read register map into platform data */
+	pdata->reg_map = (u32 *)timer_dev_attr->reg_map;
+
+	/*
+	 * array of clock source names are part of hwmod database
+	 * use this are to extract 'struct clk' corresponding to
+	 * each clock names. this is used to change the clock
+	 * sources of the timers.
+	 */
+	omap2_dm_timer_setup((char **)timer_dev_attr->clk_names,
+				pdata->source_clocks);
+	/*
+	 * extract the id from name filed in hwmod database
+	 * and use the same for constructing ids' for the
+	 * timer devices. in a way, we are avoiding usage of
+	 * static variable witin the function to do the same.
+	 * CAUTION: we have to be careful and make sure the
+	 * name in hwmod database does not change in which case
+	 * we might either make corresponding change here or
+	 * switch back static variable mechanism.
+	 */
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
+	 * pdata can be freed because omap_device_build
+	 * creates its own memory pool
+	 */
+	kfree(pdata);
+
+	return ret;
+}
+
+/**
+ * omap2_dm_timer_init - build and register timer device with an
+ * associated timer hwmod
+ * @oh:	timer hwmod pointer to be used to build timer device
+ * @user:	parameter that can be passed from calling hwmod API
+ *
+ * called by omap_hwmod_for_each_by_class to register each of the timer
+ * devices present in the system. the number of timer devices is known
+ * by parsing through the hwmod database for a given class name. at the
+ * end of function call memory is allocated for omap_device and hwmod
+ * for timer and the device is registered to the framework ready to be
+ * proved by the driver.
+ */
+static int __init omap2_dm_timer_init(struct omap_hwmod *oh, void *user)
+{
+	int id;
+	int ret = 0;
+	char *name = "dmtimer";
+	struct omap_device *od;
+	struct dmtimer_platform_data *pdata;
+	struct omap_timer_dev_attr *timer_dev_attr;
+
+	if (!oh) {
+		pr_err("%s:NULL hwmod pointer (oh)\n", __func__);
+		return -EINVAL;
+	}
+	pr_debug("%s:%s\n", __func__, oh->name);
+
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		pr_err("%s:No memory for [%s]\n",  __func__, oh->name);
+		return -ENOMEM;
+	}
+
+	pdata->is_early_init = false;
+
+	/* hook clock set/get functions */
+	pdata->set_timer_src = omap2_dm_timer_set_src;
+
+	/* read timer ip version */
+	pdata->timer_ip_type = oh->class->rev;
+
+	/*
+	 * array of clock source names are part of hwmod database
+	 * use this are to extract 'struct clk' corresponding to
+	 * each clock names. this is used to change the clock
+	 * sources of the timers.
+	 */
+	timer_dev_attr = oh->dev_attr;
+
+	/* read register map into platform data */
+	pdata->reg_map = (u32 *)timer_dev_attr->reg_map;
+
+	/* populate the 'clk' structure from clk_names */
+	omap2_dm_timer_setup((char **)timer_dev_attr->clk_names,
+				pdata->source_clocks);
+
+	/*
+	 * extract the id from name filed in hwmod database
+	 * and use the same for constructing ids' for the
+	 * timer devices. in a way, we are avoiding usage of
+	 * static variable witin the function to do the same.
+	 * CAUTION: we have to be careful and make sure the
+	 * name in hwmod database does not change in which case
+	 * we might either make corresponding change here or
+	 * switch back static variable mechanism.
+	 */
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
+	 * pdata can be freed because omap_device_build
+	 * creates its own memory pool
+	 */
+	kfree(pdata);
+	return ret;
+}
+
+/**
+ * omap2_dm_timer_early_init - top level early timer initialization
+ * called in the last part of omap2_init_common_hw
+ *
+ * uses dedicated hwmod api to parse through hwmod database for
+ * given class name and then build and register the timer device.
+ * at the end driver is registered and early probe initiated.
+ */
+void __init omap2_dm_timer_early_init(void)
+{
+	omap_hwmod_for_each_by_class("timer", omap_dm_timer_early_init, NULL);
+	early_platform_driver_register_all("earlytimer");
+	early_platform_driver_probe("earlytimer", early_timer_count, 0);
+}
+
+/**
+ * omap_timer_init - top level timer device initialization
+ *
+ * uses dedicated hwmod api to parse through hwmod database for
+ * given class names and then build and register the timer device.
+ */
+static int __init omap2_dmtimer_device_init(void)
+{
+	omap_hwmod_for_each_by_class("timer", omap2_dm_timer_init, NULL);
+	return 0;
+}
+arch_initcall(omap2_dmtimer_device_init);
-- 
1.6.0.4

