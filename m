From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v5 7/12] OMAP1: dmtimer: conversion to platform devices
Date: Tue,  7 Dec 2010 05:14:14 +0530
Message-ID: <1291679059-13419-8-git-send-email-tarun.kanti@ti.com>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39475 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752015Ab0LFMkn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Dec 2010 07:40:43 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id oB6Cee0a015525
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 6 Dec 2010 06:40:42 -0600
In-Reply-To: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

From: Thara Gopinath <thara@ti.com>

Convert OMAP1 dmtimers into a platform devices and then registers with
device model framework so that it can be bound to corresponding driver.

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reviewed-by: Cousson, Benoit <b-cousson@ti.com>
Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
---
 arch/arm/mach-omap1/Makefile  |    2 +-
 arch/arm/mach-omap1/dmtimer.c |  172 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/dmtimer.c  |   46 +-----------
 3 files changed, 175 insertions(+), 45 deletions(-)
 create mode 100644 arch/arm/mach-omap1/dmtimer.c

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 9a304d8..0001659 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := io.o id.o sram.o irq.o mux.o flash.o serial.o devices.o
-obj-y += clock.o clock_data.o opp_data.o
+obj-y += clock.o clock_data.o opp_data.o dmtimer.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
diff --git a/arch/arm/mach-omap1/dmtimer.c b/arch/arm/mach-omap1/dmtimer.c
new file mode 100644
index 0000000..2c42432
--- /dev/null
+++ b/arch/arm/mach-omap1/dmtimer.c
@@ -0,0 +1,172 @@
+/**
+ * OMAP1 Dual-Mode Timers - platform device registration
+ *
+ * Contains first level initialization routines which internally
+ * generates timer device information and registers with linux
+ * device model. It also has low level function to chnage the timer
+ * input clock source.
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
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <mach/irqs.h>
+#include <plat/dmtimer.h>
+#include <plat/omap_device.h>
+
+#define OMAP1610_GPTIMER1_BASE		0xfffb1400
+#define OMAP1610_GPTIMER2_BASE		0xfffb1c00
+#define OMAP1610_GPTIMER3_BASE		0xfffb2400
+#define OMAP1610_GPTIMER4_BASE		0xfffb2c00
+#define OMAP1610_GPTIMER5_BASE		0xfffb3400
+#define OMAP1610_GPTIMER6_BASE		0xfffb3c00
+#define OMAP1610_GPTIMER7_BASE		0xfffb7400
+#define OMAP1610_GPTIMER8_BASE		0xfffbd400
+
+#define OMAP1_DM_TIMER_COUNT		8
+
+static int omap1_dm_timer_set_src(struct platform_device *pdev,
+				int source)
+{
+	int n = (pdev->id) << 1;
+	u32 l;
+
+	l = omap_readl(MOD_CONF_CTRL_1) & ~(0x03 << n);
+	l |= source << n;
+	omap_writel(l, MOD_CONF_CTRL_1);
+
+	return 0;
+}
+
+int __init omap1_dm_timer_device_init(void)
+{
+	int i;
+	int ret;
+	struct dmtimer_platform_data *pdata;
+	struct platform_device *pdev;
+
+	pr_debug("%s: +\n", __func__);
+
+	if (!cpu_is_omap16xx())
+		return 0;
+
+	for (i = 1; i <= OMAP1_DM_TIMER_COUNT; i++) {
+		struct resource res[2];
+		u32 base, irq;
+
+		switch (i) {
+		case 1:
+			base = OMAP1610_GPTIMER1_BASE;
+			irq = INT_1610_GPTIMER1;
+			break;
+		case 2:
+			base = OMAP1610_GPTIMER2_BASE;
+			irq = INT_1610_GPTIMER2;
+			break;
+		case 3:
+			base = OMAP1610_GPTIMER3_BASE;
+			irq = INT_1610_GPTIMER3;
+			break;
+		case 4:
+			base = OMAP1610_GPTIMER4_BASE;
+			irq = INT_1610_GPTIMER4;
+			break;
+		case 5:
+			base = OMAP1610_GPTIMER5_BASE;
+			irq = INT_1610_GPTIMER5;
+			break;
+		case 6:
+			base = OMAP1610_GPTIMER6_BASE;
+			irq = INT_1610_GPTIMER6;
+			break;
+		case 7:
+			base = OMAP1610_GPTIMER7_BASE;
+			irq = INT_1610_GPTIMER7;
+			break;
+		case 8:
+			base = OMAP1610_GPTIMER8_BASE;
+			irq = INT_1610_GPTIMER8;
+			break;
+		default:
+			/*
+			 * not supposd to reach here.
+			 * this is to remove warning.
+			 */
+			return -EINVAL;
+		}
+
+		pdev = platform_device_alloc("omap_timer", i);
+		if (!pdev) {
+			pr_err("%s: Unable to device alloc for dmtimer%d\n",
+				__func__, i);
+			return -ENOMEM;
+		}
+
+		memset(res, 0, 2 * sizeof(struct resource));
+		res[0].start = base;
+		res[0].end = base + 0xff;
+		res[0].flags = IORESOURCE_MEM;
+		res[1].start = res[1].end = irq;
+		res[1].flags = IORESOURCE_IRQ;
+		ret = platform_device_add_resources(pdev, res,
+				ARRAY_SIZE(res));
+		if (ret) {
+			pr_err("%s: Unable to add resources for %s.%d\n",
+				__func__, pdev->name, pdev->id);
+			goto err_free_pdev;
+		}
+
+		pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+		if (!pdata) {
+			pr_err("%s: Unable to allocate pdata for %s.%d\n",
+				__func__, pdev->name, pdev->id);
+			ret = -ENOMEM;
+			goto err_free_pdev;
+		}
+
+		pdata->set_timer_src = omap1_dm_timer_set_src;
+		pdata->is_early_init = 0;
+		pdata->timer_ip_type = OMAP_TIMER_IP_VERSION_1;
+		pdata->intr_reg_offset = 0;
+		pdata->func_reg_offset = 0;
+		ret = platform_device_add_data(pdev, pdata, sizeof(*pdata));
+		if (ret) {
+			pr_err("%s: Unable to add platform data for %s.%d\n",
+				__func__, pdev->name, pdev->id);
+			goto err_free_pdata;
+		}
+		ret = platform_device_add(pdev);
+		if (ret) {
+			pr_err("%s: Unable to add platform device for %s.%d\n",
+				__func__, pdev->name, pdev->id);
+			goto err_free_pdata;
+		}
+
+		pr_info("%s.%d: registered\n", pdev->name, pdev->id);
+	}
+
+	return 0;
+
+err_free_pdata:
+	kfree(pdata);
+
+err_free_pdev:
+	platform_device_del(pdev);
+
+	return ret;
+}
+arch_initcall(omap1_dm_timer_device_init);
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 7fdf107..9bf6ac8 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -171,25 +171,6 @@ struct omap_dm_timer {
 
 static int dm_timer_count;
 
-#ifdef CONFIG_ARCH_OMAP1
-static struct omap_dm_timer omap1_dm_timers[] = {
-	{ .phys_base = 0xfffb1400, .irq = INT_1610_GPTIMER1 },
-	{ .phys_base = 0xfffb1c00, .irq = INT_1610_GPTIMER2 },
-	{ .phys_base = 0xfffb2400, .irq = INT_1610_GPTIMER3 },
-	{ .phys_base = 0xfffb2c00, .irq = INT_1610_GPTIMER4 },
-	{ .phys_base = 0xfffb3400, .irq = INT_1610_GPTIMER5 },
-	{ .phys_base = 0xfffb3c00, .irq = INT_1610_GPTIMER6 },
-	{ .phys_base = 0xfffb7400, .irq = INT_1610_GPTIMER7 },
-	{ .phys_base = 0xfffbd400, .irq = INT_1610_GPTIMER8 },
-};
-
-static const int omap1_dm_timer_count = ARRAY_SIZE(omap1_dm_timers);
-
-#else
-#define omap1_dm_timers			NULL
-#define omap1_dm_timer_count		0
-#endif	/* CONFIG_ARCH_OMAP1 */
-
 #ifdef CONFIG_ARCH_OMAP2
 static struct omap_dm_timer omap2_dm_timers[] = {
 	{ .phys_base = 0x48028000, .irq = INT_24XX_GPTIMER1 },
@@ -556,23 +537,6 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
 
-#ifdef CONFIG_ARCH_OMAP1
-
-int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
-{
-	int n = (timer - dm_timers) << 1;
-	u32 l;
-
-	l = omap_readl(MOD_CONF_CTRL_1) & ~(0x03 << n);
-	l |= source << n;
-	omap_writel(l, MOD_CONF_CTRL_1);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
-
-#else
-
 int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 {
 	int ret = -EINVAL;
@@ -594,8 +558,6 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
 
-#endif
-
 void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 			    unsigned int load)
 {
@@ -745,16 +707,12 @@ int __init omap_dm_timer_init(void)
 	struct omap_dm_timer *timer;
 	int i, map_size = SZ_8K;	/* Module 4KB + L4 4KB except on omap1 */
 
-	if (!(cpu_is_omap16xx() || cpu_class_is_omap2()))
+	if (!cpu_class_is_omap2())
 		return -ENODEV;
 
 	spin_lock_init(&dm_timer_lock);
 
-	if (cpu_class_is_omap1()) {
-		dm_timers = omap1_dm_timers;
-		dm_timer_count = omap1_dm_timer_count;
-		map_size = SZ_2K;
-	} else if (cpu_is_omap24xx()) {
+	if (cpu_is_omap24xx()) {
 		dm_timers = omap2_dm_timers;
 		dm_timer_count = omap2_dm_timer_count;
 		dm_source_names = omap2_dm_source_names;
-- 
1.6.0.4

