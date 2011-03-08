From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v12 4/9] OMAP2+: dmtimer: convert to platform devices
Date: Wed,  9 Mar 2011 05:15:43 +0530
Message-ID: <1299627948-20040-5-git-send-email-tarun.kanti@ti.com>
References: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51425 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756719Ab1CHXna (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 18:43:30 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p28NhRGS025329
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 8 Mar 2011 17:43:29 -0600
In-Reply-To: <1299627948-20040-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Thara Gopinath <thara@ti.com>

Add routines to converts dmtimers to platform devices. The device data
is obtained from hwmod database of respective platform and is registered
to device model after successful binding to driver. It also provides
provision to access timers during early boot when pm_runtime framework
is not completely up and running.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/dmtimer.c              |  190 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/dmtimer.h              |   32 +++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    5 +
 arch/arm/plat-omap/include/plat/dmtimer.h  |    4 +
 5 files changed, 232 insertions(+), 1 deletions(-)
 create mode 100755 arch/arm/mach-omap2/dmtimer.c
 create mode 100755 arch/arm/mach-omap2/dmtimer.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 1c3635d..7e5014b 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o \
-	 common.o gpio.o dma.o wd_timer.o
+	 common.o gpio.o dma.o wd_timer.o dmtimer.o
 
 omap-2-3-common				= irq.o sdrc.o
 hwmod-common				= omap_hwmod.o \
diff --git a/arch/arm/mach-omap2/dmtimer.c b/arch/arm/mach-omap2/dmtimer.c
new file mode 100755
index 0000000..60c410b
--- /dev/null
+++ b/arch/arm/mach-omap2/dmtimer.c
@@ -0,0 +1,190 @@
+/**
+ * OMAP2+ Dual-Mode Timers - platform device registration
+ *
+ * Contains first level initialization routines which extracts timers
+ * information from hwmod database and registers with linux device model.
+ * It also has low level function to change the timer input clock source.
+ *
+ * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * Tarun Kanti DebBarma <tarun.kanti@ti.com>
+ * Thara Gopinath <thara@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#include <plat/dmtimer.h>
+#include <plat/omap_device.h>
+#include <plat/cpu.h>
+#include <plat/omap_hwmod.h>
+
+static u8 __initdata system_timer_id;
+
+/**
+ * omap2_dm_timer_set_src - change the timer input clock source
+ * @pdev:	timer platform device pointer
+ * @source:	array index of parent clock source
+ */
+static int omap2_dm_timer_set_src(struct platform_device *pdev, int source)
+{
+	int ret;
+	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
+	struct clk *fclk = clk_get(&pdev->dev, "fck");
+	struct clk *new_fclk;
+	char *fclk_name = "32k_ck"; /* default name */
+
+	switch (source) {
+	case OMAP_TIMER_SRC_SYS_CLK:
+		fclk_name = "sys_ck";
+		break;
+
+	case OMAP_TIMER_SRC_32_KHZ:
+		fclk_name = "32k_ck";
+		break;
+
+	case OMAP_TIMER_SRC_EXT_CLK:
+		if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_1) {
+			fclk_name = "alt_ck";
+			break;
+		}
+		dev_err(&pdev->dev, "%s: %d: invalid clk src.\n",
+			__func__, __LINE__);
+		return -EINVAL;
+	}
+
+	if (IS_ERR_OR_NULL(fclk)) {
+		dev_err(&pdev->dev, "%s: %d: clk_get() FAILED\n",
+			__func__, __LINE__);
+		return -EINVAL;
+	}
+
+	new_fclk = clk_get(&pdev->dev, fclk_name);
+	if (IS_ERR_OR_NULL(new_fclk)) {
+		dev_err(&pdev->dev, "%s: %d: clk_get() %s FAILED\n",
+			__func__, __LINE__, fclk_name);
+		clk_put(fclk);
+		return -EINVAL;
+	}
+
+	ret = clk_set_parent(fclk, new_fclk);
+	if (IS_ERR_VALUE(ret)) {
+		dev_err(&pdev->dev, "%s: clk_set_parent() to %s FAILED\n",
+			__func__, fclk_name);
+		ret = -EINVAL;
+	}
+
+	clk_put(new_fclk);
+	clk_put(fclk);
+
+	return ret;
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
+ * omap_timer_init - build and register timer device with an
+ * associated timer hwmod
+ * @oh:	timer hwmod pointer to be used to build timer device
+ * @user:	parameter that can be passed from calling hwmod API
+ *
+ * Called by omap_hwmod_for_each_by_class to register each of the timer
+ * devices present in the system. The number of timer devices is known
+ * by parsing through the hwmod database for a given class name. At the
+ * end of function call memory is allocated for timer device and it is
+ * registered to the framework ready to be proved by the driver.
+ */
+static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
+{
+	int id;
+	int ret = 0;
+	char *name = "omap_timer";
+	struct dmtimer_platform_data *pdata;
+	struct omap_device *od;
+	struct omap_secure_timer_dev_attr *secure_timer_dev_attr;
+
+	/*
+	 * Extract the IDs from name field in hwmod database
+	 * and use the same for constructing ids' for the
+	 * timer devices. In a way, we are avoiding usage of
+	 * static variable witin the function to do the same.
+	 * CAUTION: We have to be careful and make sure the
+	 * name in hwmod database does not change in which case
+	 * we might either make corresponding change here or
+	 * switch back static variable mechanism.
+	 */
+	sscanf(oh->name, "timer%2d", &id);
+	if (unlikely(id == system_timer_id))
+		return ret;
+
+	pr_debug("%s: %s\n", __func__, oh->name);
+
+	/* do not register secure timer */
+	secure_timer_dev_attr = oh->dev_attr;
+	if (secure_timer_dev_attr)
+		if (secure_timer_dev_attr->is_secure_timer)
+			return ret;
+
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata) {
+		pr_err("%s: No memory for [%s]\n", __func__, oh->name);
+		return -ENOMEM;
+	}
+	pdata->is_early_init = 0;
+	pdata->set_timer_src = omap2_dm_timer_set_src;
+	pdata->timer_ip_type = oh->class->rev;
+	pdata->needs_manual_reset = 0;
+
+	od = omap_device_build(name, id, oh, pdata, sizeof(*pdata),
+			omap2_dmtimer_latency,
+			ARRAY_SIZE(omap2_dmtimer_latency),
+			pdata->is_early_init);
+
+	if (IS_ERR(od)) {
+		pr_err("%s: Can't build omap_device for %s: %s.\n",
+			__func__, name, oh->name);
+		ret = -EINVAL;
+	}
+
+	kfree(pdata);
+
+	return ret;
+}
+
+/**
+ * omap2_system_timer_set_src - change the timer input clock source
+ * Allow system timer to program clock source before pm_runtime
+ * framework is available during system boot.
+ * @timer:       pointer to struct omap_dm_timer
+ * @source:     array index of parent clock source
+ */
+int __init omap2_system_timer_set_src(struct omap_dm_timer *timer, int source)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(timer)) {
+		pr_warning("%s: invalid timer pointer.\n", __func__);
+		return -EINVAL;
+	}
+
+	clk_disable(timer->fclk);
+	ret = omap2_dm_timer_set_src(timer->pdev, source);
+	clk_enable(timer->fclk);
+
+	return ret;
+}
diff --git a/arch/arm/mach-omap2/dmtimer.h b/arch/arm/mach-omap2/dmtimer.h
new file mode 100755
index 0000000..4cfd580
--- /dev/null
+++ b/arch/arm/mach-omap2/dmtimer.h
@@ -0,0 +1,32 @@
+/**
+ * OMAP Dual-Mode Timers - early initialization interface
+ *
+ * Function interface called first to start dmtimer early initialization.
+ *
+ * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * Tarun Kanti DebBarma <tarun.kanti@ti.com>
+ * Thara Gopinath <thara@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef __ASM_ARCH_OMAP2_DMTIMER_H
+#define __ASM_ARCH_OMAP2_DMTIMER_H
+
+#include <plat/dmtimer.h>
+
+/*
+ * dmtimer is required during early part of boot sequence even before
+ * device model and pm_runtime if fully up and running. This function
+ * is called from following sequence:
+ * start_kernel()->time_init()->timer->init()->omap2_gp_timer_init()
+ */
+extern int __init omap2_system_timer_init(u8 id);
+extern int __init omap2_system_timer_set_src(struct omap_dm_timer *, int);
+#endif
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 9a34e20..93dd209 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -3976,6 +3976,11 @@ static struct omap_hwmod_class omap44xx_timer_hwmod_class = {
 	.rev	= OMAP_TIMER_IP_VERSION_2,
 };
 
+/* secure timer can assign this to .dev_attr field */
+static struct omap_secure_timer_dev_attr secure_timer_dev_attr = {
+	.is_secure_timer        = true,
+};
+
 /* timer1 */
 static struct omap_hwmod omap44xx_timer1_hwmod;
 static struct omap_hwmod_irq_info omap44xx_timer1_irqs[] = {
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 377a00c..0d1a571 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -57,6 +57,10 @@
 #define OMAP_TIMER_IP_VERSION_1			0x1
 #define OMAP_TIMER_IP_VERSION_2			0x2
 
+struct omap_secure_timer_dev_attr {
+	bool is_secure_timer;
+};
+
 struct omap_dm_timer {
 	unsigned long phys_base;
 	int irq;
-- 
1.6.0.4

