From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v14 REPOST 03/12] OMAP1: dmtimer: conversion to platform devices
Date: Fri, 15 Jul 2011 17:34:52 +0530
Message-ID: <1310731501-13078-4-git-send-email-tarun.kanti@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45938 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939Ab1GOMFT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 15 Jul 2011 08:05:19 -0400
In-Reply-To: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Thara Gopinath <thara@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

From: Thara Gopinath <thara@ti.com>

Convert OMAP1 dmtimers into a platform devices and then registers with
device model framework so that it can be bound to corresponding driver.

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/mach-omap1/Makefile              |    2 +-
 arch/arm/mach-omap1/timer.c               |  174 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/dmtimer.c              |   56 ++-------
 arch/arm/plat-omap/include/plat/dmtimer.h |    8 ++
 4 files changed, 195 insertions(+), 45 deletions(-)
 create mode 100644 arch/arm/mach-omap1/timer.c

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 5b114d1..11c85cd 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := io.o id.o sram.o time.o irq.o mux.o flash.o serial.o devices.o dma.o
-obj-y += clock.o clock_data.o opp_data.o reset.o pm_bus.o
+obj-y += clock.o clock_data.o opp_data.o reset.o pm_bus.o timer.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
new file mode 100644
index 0000000..980b23b
--- /dev/null
+++ b/arch/arm/mach-omap1/timer.c
@@ -0,0 +1,174 @@
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
+#include <linux/platform_device.h>
+
+#include <mach/irqs.h>
+
+#include <plat/dmtimer.h>
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
+	int n = (pdev->id - 1) << 1;
+	u32 l;
+
+	l = omap_readl(MOD_CONF_CTRL_1) & ~(0x03 << n);
+	l |= source << n;
+	omap_writel(l, MOD_CONF_CTRL_1);
+
+	return 0;
+}
+
+
+int __init omap1_dm_timer_init(void)
+{
+	int i;
+	int ret;
+	struct dmtimer_platform_data *pdata;
+	struct platform_device *pdev;
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
+			 * not supposed to reach here.
+			 * this is to remove warning.
+			 */
+			return -EINVAL;
+		}
+
+		pdev = platform_device_alloc("omap_timer", i);
+		if (!pdev) {
+			pr_err("%s: Failed to device alloc for dmtimer%d\n",
+				__func__, i);
+			return -ENOMEM;
+		}
+
+		memset(res, 0, 2 * sizeof(struct resource));
+		res[0].start = base;
+		res[0].end = base + 0x46;
+		res[0].flags = IORESOURCE_MEM;
+		res[1].start = irq;
+		res[1].end = irq;
+		res[1].flags = IORESOURCE_IRQ;
+		ret = platform_device_add_resources(pdev, res,
+				ARRAY_SIZE(res));
+		if (ret) {
+			dev_err(&pdev->dev, "%s: Failed to add resources.\n",
+				__func__);
+			goto err_free_pdev;
+		}
+
+		pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+		if (!pdata) {
+			dev_err(&pdev->dev, "%s: Failed to allocate pdata.\n",
+				__func__);
+			ret = -ENOMEM;
+			goto err_free_pdata;
+		}
+
+		pdata->set_timer_src = omap1_dm_timer_set_src;
+		pdata->timer_ip_type = OMAP_TIMER_IP_VERSION_1;
+		pdata->needs_manual_reset = 1;
+
+		ret = platform_device_add_data(pdev, pdata, sizeof(*pdata));
+		if (ret) {
+			dev_err(&pdev->dev, "%s: Failed to add platform data.\n",
+				__func__);
+			goto err_free_pdata;
+		}
+
+		ret = platform_device_add(pdev);
+		if (ret) {
+			dev_err(&pdev->dev, "%s: Failed to add platform device.\n",
+				__func__);
+			goto err_free_pdata;
+		}
+
+		dev_dbg(&pdev->dev, " Registered.\n");
+	}
+
+	return 0;
+
+err_free_pdata:
+	kfree(pdata);
+
+err_free_pdev:
+	platform_device_unregister(pdev);
+
+	return ret;
+}
+arch_initcall(omap1_dm_timer_init);
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 8dfb818..995bab0 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -3,6 +3,12 @@
  *
  * OMAP Dual-Mode Timers
  *
+ * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
+ * Tarun Kanti DebBarma <tarun.kanti@ti.com>
+ * Thara Gopinath <thara@ti.com>
+ *
+ * dmtimer adaptation to platform_driver.
+ *
  * Copyright (C) 2005 Nokia Corporation
  * OMAP2 support by Juha Yrjola
  * API improvements and OMAP2 clock framework support by Timo Teras
@@ -43,25 +49,6 @@
 
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
@@ -405,35 +392,20 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
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
 	if (source < 0 || source >= 3)
 		return -EINVAL;
 
+#ifdef CONFIG_ARCH_OMAP2PLUS
 	return __omap_dm_timer_set_source(timer->fclk,
 						dm_source_clocks[source]);
+#else
+	return 0;
+#endif
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
 
-#endif
-
 void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 			    unsigned int load)
 {
@@ -577,16 +549,12 @@ static int __init omap_dm_timer_init(void)
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
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 1892abf..e5d4b4f 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -34,6 +34,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/platform_device.h>
 
 #ifndef __ASM_ARCH_DMTIMER_H
 #define __ASM_ARCH_DMTIMER_H
@@ -63,6 +64,12 @@
 struct omap_dm_timer;
 struct clk;
 
+struct dmtimer_platform_data {
+	int (*set_timer_src)(struct platform_device *pdev, int source);
+	int timer_ip_type;
+	u32 needs_manual_reset:1;
+};
+
 struct omap_dm_timer *omap_dm_timer_request(void);
 struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
 void omap_dm_timer_free(struct omap_dm_timer *timer);
@@ -219,6 +226,7 @@ struct omap_dm_timer {
 	unsigned reserved:1;
 	unsigned enabled:1;
 	unsigned posted:1;
+	struct platform_device *pdev;
 };
 
 extern u32 sys_timer_reserved;
-- 
1.6.0.4

