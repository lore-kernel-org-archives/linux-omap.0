From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv3 2/17] dmtimer: infrastructure to support hwmod
Date: Tue, 21 Sep 2010 14:21:28 +0530
Message-ID: <1285059089-26341-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48298 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757269Ab0ITVug (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Sep 2010 17:50:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Partha Basak <p-basak2@ti.com>, Thara Gopinath <thara@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

This patch introduces data structures and new fields on
existing data structures to support dmtimer conversion
to platform driver and support hwmod database for the diferent
OMAP platforms.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/dmtimer.h             |   25 +++++++++++++++++
 arch/arm/plat-omap/dmtimer.c              |    9 ++++++
 arch/arm/plat-omap/include/plat/dmtimer.h |   42 +++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/dmtimer.h

diff --git a/arch/arm/mach-omap2/dmtimer.h b/arch/arm/mach-omap2/dmtimer.h
new file mode 100644
index 0000000..3355725
--- /dev/null
+++ b/arch/arm/mach-omap2/dmtimer.h
@@ -0,0 +1,25 @@
+/**
+ * linux/arch/arm/mach-omap2/dmtimer.h
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
+#ifndef __ASM_ARCH_DMTIMER_H
+#define __ASM_ARCH_DMTIMER_H
+
+/*
+ * dmtimer is required during early part of boot sequence even before
+ * device model and pm_runtime if fully up and running. this function
+ * provides hook to omap2_init_common_hw() which is triggered from
+ * start_kernel()->init_irq() of kernel initalization sequence.
+ */
+void __init omap2_dm_timer_early_init(void);
+
+#endif
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 44bafda..a7b1679 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -10,6 +10,12 @@
  * Copyright (C) 2009 Texas Instruments
  * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
  *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Thara Gopinath <thara@ti.com>
+ * Tarun Kanti DebBarma <tarun.kanti@ti.com>
+ * - hwmod support
+ * - omap4 support
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
  * Free Software Foundation; either version 2 of the License, or (at your
@@ -151,6 +157,8 @@
 		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
 
 struct omap_dm_timer {
+	int id;
+	unsigned long fclk_rate;
 	unsigned long phys_base;
 	int irq;
 #ifdef CONFIG_ARCH_OMAP2PLUS
@@ -160,6 +168,7 @@ struct omap_dm_timer {
 	unsigned reserved:1;
 	unsigned enabled:1;
 	unsigned posted:1;
+	struct platform_device *pdev;
 };
 
 static int dm_timer_count;
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 20f1054..3ec17c5 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -29,6 +29,8 @@
 #ifndef __ASM_ARCH_DMTIMER_H
 #define __ASM_ARCH_DMTIMER_H
 
+#include <linux/platform_device.h>
+
 /* clock sources */
 #define OMAP_TIMER_SRC_SYS_CLK			0x00
 #define OMAP_TIMER_SRC_32_KHZ			0x01
@@ -44,9 +46,49 @@
 #define OMAP_TIMER_TRIGGER_OVERFLOW		0x01
 #define OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE	0x02
 
+/* timer ip constants */
+#define OMAP_TIMER_IP_VERSION_1			0x1 /* OMAP1/2/3 timers */
+#define OMAP_TIMER_IP_VERSION_2			0x2 /* OMAP4 timers */
+
+/*
+ * number of clock sources supported in the current platform.
+ * for the time being keeping it to 6 just to accomodate future.
+ * expansion. currently, only upto a maximum of 3 clock sources
+ * supported on OMAP4.
+ */
+#define NR_CLK_SOURCES			3
+
+
+/**
+ * omap_timer_dev_attr - timer device attribute
+ *
+ * current implementation contains array of clock source names supported
+ * by different timers. for example, in the case of OMAP4, timer[5-8]
+ * supports different set of input clock sources as compared to the rest.
+ * these array of clock names are used during timer initialization to
+ * parse through timer list and obtain their corresponding struct clk*.
+ * this is subsequently used for changing the timer input clock sources
+ * by client drivers.
+ */
+struct omap_timer_dev_attr {
+	char **clk_names;
+	u32 *reg_map;
+};
+
 struct omap_dm_timer;
 struct clk;
 
+struct dmtimer_platform_data {
+	int (*set_timer_src)
+		(struct platform_device *pdev, int source);
+#ifdef CONFIG_ARCH_OMAP2PLUS
+	struct clk *source_clocks[NR_CLK_SOURCES];
+#endif
+	u32 *reg_map;
+	int timer_ip_type;
+	bool is_early_init;
+};
+
 int omap_dm_timer_init(void);
 
 struct omap_dm_timer *omap_dm_timer_request(void);
-- 
1.6.0.4

