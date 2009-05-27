From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/4] ARM: OMAP4: SMP: Add mpu timer support for OMAP4430
Date: Wed, 27 May 2009 21:55:58 +0530
Message-ID: <1243441558-26975-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46206 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758093AbZE0Q0L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 May 2009 12:26:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds SMP platform specific parts for local(mpu) timer support
for OMAP4430 platform. Each Cortex-a9 core has it's own local timer in the
MPU domain. These timers are not in wakeup domain.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/timer-gp.c                |    4 +++
 arch/arm/mach-omap2/timer-mpu.c               |   34 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/entry-macro.S |   28 ++++++++++++++++++++
 arch/arm/plat-omap/include/mach/irqs.h        |    2 +
 4 files changed, 68 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/timer-mpu.c

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 2ce474a..97eeeeb 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -38,6 +38,7 @@
 
 #include <asm/mach/time.h>
 #include <mach/dmtimer.h>
+#include <asm/localtimer.h>
 
 /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
 #define MAX_GPTIMER_ID		12
@@ -229,6 +230,9 @@ static void __init omap2_gp_clocksource_init(void)
 
 static void __init omap2_gp_timer_init(void)
 {
+#ifdef CONFIG_LOCAL_TIMERS
+	twd_base = IO_ADDRESS(OMAP44XX_LOCAL_TWD_BASE);
+#endif
 	omap_dm_timer_init();
 
 	omap2_gp_clockevent_init();
diff --git a/arch/arm/mach-omap2/timer-mpu.c b/arch/arm/mach-omap2/timer-mpu.c
new file mode 100644
index 0000000..c1a650a
--- /dev/null
+++ b/arch/arm/mach-omap2/timer-mpu.c
@@ -0,0 +1,34 @@
+/*
+ * The MPU local timer source file. In OMAP4, both cortex-a9 cores have
+ * own timer in it's MPU domain. These timers will be driving the
+ * linux kernel SMP tick framework when active. These timers are not
+ * part of the wake up domain.
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ *
+ * Author:
+ *      Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This file is based on arm realview smp platform file.
+ * Copyright (C) 2002 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/clockchips.h>
+#include <asm/irq.h>
+#include <asm/smp_twd.h>
+#include <asm/localtimer.h>
+
+/*
+ * Setup the local clock events for a CPU.
+ */
+void __cpuinit local_timer_setup(struct clock_event_device *evt)
+{
+	evt->irq = INT_44XX_LOCALTIMER_IRQ;
+	twd_timer_setup(evt);
+}
+
diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S b/arch/arm/plat-omap/include/mach/entry-macro.S
index 00f45c0..56426ed 100644
--- a/arch/arm/plat-omap/include/mach/entry-macro.S
+++ b/arch/arm/plat-omap/include/mach/entry-macro.S
@@ -136,6 +136,34 @@
 		cmpne   \irqnr, \tmp
 		cmpcs   \irqnr, \irqnr
 		.endm
+
+		/* We assume that irqstat (the raw value of the IRQ acknowledge
+		 * register) is preserved from the macro above.
+		 * If there is an IPI, we immediately signal end of interrupt
+		 * on the controller, since this requires the original irqstat
+		 * value which we won't easily be able to recreate later.
+		 */
+
+		.macro test_for_ipi, irqnr, irqstat, base, tmp
+		bic	\irqnr, \irqstat, #0x1c00
+		cmp	\irqnr, #16
+		it	cc
+		strcc	\irqstat, [\base, #GIC_CPU_EOI]
+		it	cs
+		cmpcs	\irqnr, \irqnr
+		.endm
+
+		/* As above, this assumes that irqstat and base are preserved */
+
+		.macro test_for_ltirq, irqnr, irqstat, base, tmp
+		bic	\irqnr, \irqstat, #0x1c00
+		mov 	\tmp, #0
+		cmp	\irqnr, #29
+		itt	eq
+		moveq	\tmp, #1
+		streq	\irqstat, [\base, #GIC_CPU_EOI]
+		cmp	\tmp, #0
+		.endm
 #endif
 
 		.macro	irq_prio_table
diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
index 5bc331e..e8f84a0 100644
--- a/arch/arm/plat-omap/include/mach/irqs.h
+++ b/arch/arm/plat-omap/include/mach/irqs.h
@@ -427,6 +427,8 @@
 
 
 #define IRQ_GIC_START		32
+#define INT_44XX_LOCALTIMER_IRQ	29
+#define INT_44XX_LOCALWDT_IRQ	30
 
 #define INT_44XX_BENCH_MPU_EMUL	(3 + IRQ_GIC_START)
 #define INT_44XX_SSM_ABORT_IRQ	(6 + IRQ_GIC_START)
-- 
1.5.4.7

