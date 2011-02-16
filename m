From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v10 06/11] OMAP1: dmtimer: conversion to platform devices
Date: Wed, 16 Feb 2011 18:30:15 +0530
Message-ID: <1297861220-831-7-git-send-email-tarun.kanti@ti.com>
References: <1297861220-831-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52096 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753028Ab1BPM5x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 07:57:53 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1GCvnfB019339
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 06:57:51 -0600
In-Reply-To: <1297861220-831-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, Thara Gopinath <thara@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

From: Thara Gopinath <thara@ti.com>

Convert OMAP1 dmtimers into a platform devices and then registers with
device model framework so that it can be bound to corresponding driver.

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Acked-by: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/mach-omap1/Makefile              |    2 +-
 arch/arm/mach-omap1/dmtimer.c             |  214 +++++++++++++++++++++++++++++
 arch/arm/mach-omap1/timer32k.c            |    4 -
 arch/arm/plat-omap/dmtimer.c              |   64 +--------
 arch/arm/plat-omap/include/plat/dmtimer.h |   24 +++-
 5 files changed, 246 insertions(+), 62 deletions(-)
 create mode 100644 arch/arm/mach-omap1/dmtimer.c

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index af98117..a0ae35f 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := io.o id.o sram.o time.o irq.o mux.o flash.o serial.o devices.o dma.o
-obj-y += clock.o clock_data.o opp_data.o reset.o
+obj-y += clock.o clock_data.o opp_data.o reset.o dmtimer.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
diff --git a/arch/arm/mach-omap1/dmtimer.c b/arch/arm/mach-omap1/dmtimer.c
new file mode 100644
index 0000000..d1e17fe
--- /dev/null
+++ b/arch/arm/mach-omap1/dmtimer.c
@@ -0,0 +1,214 @@
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
+#define OMAP_TIMER_OCP_CFG_REG		0x10
+#define OMAP_TIMER_SYS_STAT_REG		0x14
+#define OMAP_TIMER_IF_CTRL_REG		0x40
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
+static void omap1_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
+{
+	int c;
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+
+	c = 0;
+	while (!(pdata->dm_timer_read_reg(timer, OMAP_TIMER_SYS_STAT_REG) & 1)) {
+		c++;
+		if (c > 100000) {
+			printk(KERN_ERR "Timer failed to reset.\n");
+			return;
+		}
+	}
+}
+
+static void omap1_dm_timer_reset(struct omap_dm_timer *timer)
+{
+	u32 l;
+	struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
+
+	if (timer->pdev->id != 1) {
+		pdata->dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
+		omap1_dm_timer_wait_for_reset(timer);
+	}
+
+	l = pdata->dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
+	l |= 0x02 << 3;  /* Set to smart-idle mode */
+	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
+	pdata->dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
+}
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
+		pdata->dm_timer_reset = omap1_dm_timer_reset;
+		pdata->set_timer_src = omap1_dm_timer_set_src;
+
+		pdata->is_early_init = 1;
+		pdata->is_omap16xx = 1;
+		pdata->timer_ip_type = OMAP_TIMER_IP_VERSION_1;
+
+		pdata->intr_offset = 0;
+		pdata->func_offset = 0;
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
diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 13d7b8f..dc4a8fd 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -53,7 +53,6 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 #include <plat/common.h>
-#include <plat/dmtimer.h>
 
 /*
  * ---------------------------------------------------------------------------
@@ -184,9 +183,6 @@ bool __init omap_32k_timer_init(void)
 {
 	omap_init_clocksource_32k();
 
-#ifdef CONFIG_OMAP_DM_TIMER
-	omap_dm_timer_init();
-#endif
 	omap_init_32k_timer();
 
 	return true;
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 1d706cf..1bfaf09 100644
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
@@ -150,39 +156,8 @@
 #define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
 		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
 
-struct omap_dm_timer {
-	unsigned long phys_base;
-	int irq;
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	struct clk *iclk, *fclk;
-#endif
-	void __iomem *io_base;
-	unsigned reserved:1;
-	unsigned enabled:1;
-	unsigned posted:1;
-};
-
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
@@ -549,23 +524,6 @@ void omap_dm_timer_stop(struct omap_dm_timer *timer)
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
@@ -587,8 +545,6 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
 
-#endif
-
 void omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 			    unsigned int load)
 {
@@ -738,16 +694,12 @@ int __init omap_dm_timer_init(void)
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
index 05a967e..4bfbfcc 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -57,11 +57,33 @@
 #define OMAP_TIMER_IP_VERSION_1                        0x1
 #define OMAP_TIMER_IP_VERSION_2                        0x2
 
-struct omap_dm_timer;
+struct omap_dm_timer {
+	unsigned long phys_base;
+	int irq;
+	struct clk *iclk, *fclk;
+	void __iomem *io_base;
+	unsigned reserved:1;
+	unsigned enabled:1;
+	unsigned posted:1;
+	struct platform_device *pdev;
+};
+
 extern struct omap_dm_timer *gptimer_wakeup;
 extern struct sys_timer omap_timer;
 struct clk;
 
+struct dmtimer_platform_data {
+	int (*set_timer_src)(struct platform_device *pdev, int source);
+	void (*dm_timer_reset)(struct omap_dm_timer *);
+	u32 (*dm_timer_read_reg)(struct omap_dm_timer *, u32);
+	void (*dm_timer_write_reg)(struct omap_dm_timer *, u32, u32);
+	int timer_ip_type;
+	u8 func_offset;
+	u8 intr_offset;
+	u32 is_early_init:1;
+	u32 is_omap16xx:1;
+};
+
 int omap_dm_timer_init(void);
 
 struct omap_dm_timer *omap_dm_timer_request(void);
-- 
1.6.0.4

