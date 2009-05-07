From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/3] OMAP4: SMP: Add mpu timer support for OMAP4430
Date: Thu,  7 May 2009 12:59:25 +0530
Message-ID: <1241681366-21094-2-git-send-email-santosh.shilimkar@ti.com>
References: <1241681366-21094-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50790 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753897AbZEGH3l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 03:29:41 -0400
In-Reply-To: <1241681366-21094-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds SMP platform specific parts for local(mpu) timer support
for OMAP4430 platform. Each Cortex-a9 core has it's own local timer in the
MPU domain. These timers are not in wakeup domain.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/timer-gp.c                |   11 ++
 arch/arm/mach-omap2/timer-mpu.c               |  214 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/common.h      |    3 +
 arch/arm/plat-omap/include/mach/entry-macro.S |   28 ++++
 arch/arm/plat-omap/include/mach/irqs.h        |    2 +
 5 files changed, 258 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/timer-mpu.c

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 080868d..08c6ded 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -36,6 +36,7 @@
 
 #include <asm/mach/time.h>
 #include <mach/dmtimer.h>
+#include <mach/common.h>
 
 static struct omap_dm_timer *gptimer;
 static struct clock_event_device clockevent_gpt;
@@ -187,6 +188,16 @@ static void __init omap2_gp_clocksource_init(void)
 
 static void __init omap2_gp_timer_init(void)
 {
+#ifdef CONFIG_LOCAL_TIMERS
+	twd_base = IO_ADDRESS(OMAP44XX_LOCAL_TWD_BASE);
+#endif
+#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
+	/*
+	 * The dummy clock device has to be registered before the main device
+	 * so that the latter will broadcast the clock events
+	 */
+	local_timer_setup();
+#endif
 	omap_dm_timer_init();
 
 	omap2_gp_clockevent_init();
diff --git a/arch/arm/mach-omap2/timer-mpu.c b/arch/arm/mach-omap2/timer-mpu.c
new file mode 100644
index 0000000..bb91b24
--- /dev/null
+++ b/arch/arm/mach-omap2/timer-mpu.c
@@ -0,0 +1,214 @@
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
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/smp.h>
+#include <linux/jiffies.h>
+#include <linux/percpu.h>
+#include <linux/clockchips.h>
+#include <linux/irq.h>
+
+#include <asm/hardware/arm_twd.h>
+#include <asm/hardware/gic.h>
+#include <asm/irq.h>
+
+#include <mach/hardware.h>
+#include <mach/common.h>
+
+static DEFINE_PER_CPU(struct clock_event_device, local_clockevent);
+
+/*
+ * Used on SMP for either the local timer or IPI_TIMER
+ */
+void local_timer_interrupt(void)
+{
+	struct clock_event_device *clk = &__get_cpu_var(local_clockevent);
+
+	clk->event_handler(clk);
+}
+
+#ifdef CONFIG_LOCAL_TIMERS
+
+/* set up by the platform code */
+void __iomem *twd_base;
+
+static unsigned long mpcore_timer_rate;
+
+static void local_timer_set_mode(enum clock_event_mode mode,
+				 struct clock_event_device *clk)
+{
+	unsigned long ctrl;
+
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		/* timer load already set up */
+		ctrl = TWD_TIMER_CONTROL_ENABLE | TWD_TIMER_CONTROL_IT_ENABLE
+			| TWD_TIMER_CONTROL_PERIODIC;
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		/* period set, and timer enabled in 'next_event' hook */
+		ctrl = TWD_TIMER_CONTROL_IT_ENABLE | TWD_TIMER_CONTROL_ONESHOT;
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+	default:
+		ctrl = 0;
+	}
+
+	__raw_writel(ctrl, twd_base + TWD_TIMER_CONTROL);
+}
+
+static int local_timer_set_next_event(unsigned long evt,
+				      struct clock_event_device *unused)
+{
+	unsigned long ctrl = __raw_readl(twd_base + TWD_TIMER_CONTROL);
+
+	__raw_writel(evt, twd_base + TWD_TIMER_COUNTER);
+	__raw_writel(ctrl | TWD_TIMER_CONTROL_ENABLE,
+				twd_base + TWD_TIMER_CONTROL);
+
+	return 0;
+}
+
+/*
+ * local_timer_ack: checks for a local timer interrupt.
+ *
+ * If a local timer interrupt has occurred, acknowledge and return 1.
+ * Otherwise, return 0.
+ */
+int local_timer_ack(void)
+{
+	if (__raw_readl(twd_base + TWD_TIMER_INTSTAT)) {
+		__raw_writel(1, twd_base + TWD_TIMER_INTSTAT);
+		return 1;
+	}
+
+	return 0;
+}
+
+static void __cpuinit twd_calibrate_rate(void)
+{
+	unsigned long load, count;
+	u64 waitjiffies;
+
+	/*
+	 * If this is the first time round, we need to work out how fast
+	 * the timer ticks
+	 */
+	if (mpcore_timer_rate == 0) {
+		printk(KERN_INFO "Calibrating local timer... ");
+
+		/* Wait for a tick to start */
+		waitjiffies = get_jiffies_64() + 1;
+
+		while (get_jiffies_64() < waitjiffies)
+			udelay(10);
+
+		/* OK, now the tick has started, let's get the timer going */
+		waitjiffies += 5;
+
+				 /* enable, no interrupt or reload */
+		__raw_writel(0x1, twd_base + TWD_TIMER_CONTROL);
+
+				 /* maximum value */
+		__raw_writel(0xFFFFFFFFU, twd_base + TWD_TIMER_COUNTER);
+
+		while (get_jiffies_64() < waitjiffies)
+			udelay(10);
+
+		count = __raw_readl(twd_base + TWD_TIMER_COUNTER);
+
+		mpcore_timer_rate = (0xFFFFFFFFU - count) * (HZ / 5);
+
+		printk("%lu.%02luMHz.\n", mpcore_timer_rate / 1000000,
+			(mpcore_timer_rate / 100000) % 100);
+	}
+
+	load = mpcore_timer_rate / HZ;
+
+	__raw_writel(load, twd_base + TWD_TIMER_LOAD);
+}
+
+/*
+ * Setup the local clock events for a CPU.
+ */
+void __cpuinit local_timer_setup(void)
+{
+	unsigned int cpu = smp_processor_id();
+	struct clock_event_device *clk = &per_cpu(local_clockevent, cpu);
+	unsigned long flags;
+
+	twd_calibrate_rate();
+
+	clk->name		= "local_timer";
+	clk->features		= CLOCK_EVT_FEAT_PERIODIC
+					| CLOCK_EVT_FEAT_ONESHOT;
+	clk->rating		= 350;
+	clk->set_mode		= local_timer_set_mode;
+	clk->set_next_event	= local_timer_set_next_event;
+	clk->irq		= INT_44XX_LOCALTIMER_IRQ;
+	clk->cpumask		= cpumask_of(cpu);
+	clk->shift		= 20;
+	clk->mult		= div_sc(mpcore_timer_rate,
+						NSEC_PER_SEC, clk->shift);
+	clk->max_delta_ns	= clockevent_delta2ns(0xffffffff, clk);
+	clk->min_delta_ns	= clockevent_delta2ns(0xf, clk);
+
+	/* Make sure our local interrupt controller has this enabled */
+	local_irq_save(flags);
+	get_irq_chip(INT_44XX_LOCALTIMER_IRQ)->unmask(INT_44XX_LOCALTIMER_IRQ);
+	local_irq_restore(flags);
+
+	clockevents_register_device(clk);
+}
+
+/*
+ * take a local timer down
+ */
+void __cpuexit local_timer_stop(void)
+{
+	__raw_writel(0, twd_base + TWD_TIMER_CONTROL);
+}
+
+#else	/* CONFIG_LOCAL_TIMERS */
+
+static void dummy_timer_set_mode(enum clock_event_mode mode,
+				 struct clock_event_device *clk)
+{
+}
+
+void __cpuinit local_timer_setup(void)
+{
+	unsigned int cpu = smp_processor_id();
+	struct clock_event_device *clk = &per_cpu(local_clockevent, cpu);
+
+	clk->name		= "dummy_timer";
+	clk->features		= CLOCK_EVT_FEAT_DUMMY;
+	clk->rating		= 200;
+	clk->mult               = 1;
+	clk->set_mode		= dummy_timer_set_mode;
+	clk->broadcast		= smp_timer_broadcast;
+	clk->cpumask		= cpumask_of(cpu);
+
+	clockevents_register_device(clk);
+}
+
+#endif	/* !CONFIG_LOCAL_TIMERS */
diff --git a/arch/arm/plat-omap/include/mach/common.h b/arch/arm/plat-omap/include/mach/common.h
index 4b18833..99381df 100644
--- a/arch/arm/plat-omap/include/mach/common.h
+++ b/arch/arm/plat-omap/include/mach/common.h
@@ -30,6 +30,9 @@
 #include <linux/i2c.h>
 
 struct sys_timer;
+#ifdef CONFIG_LOCAL_TIMERS /* Base address of mpu timer */
+extern void __iomem *twd_base;
+#endif
 
 extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
diff --git a/arch/arm/plat-omap/include/mach/entry-macro.S b/arch/arm/plat-omap/include/mach/entry-macro.S
index 62bcb1b..388f239 100644
--- a/arch/arm/plat-omap/include/mach/entry-macro.S
+++ b/arch/arm/plat-omap/include/mach/entry-macro.S
@@ -133,6 +133,34 @@
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

