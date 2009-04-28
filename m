From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/3][RFC]OMAP4: SMP: Add OMAP4430 SMP board files
Date: Tue, 28 Apr 2009 21:26:54 +0530
Message-ID: <1240934214-21662-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53170 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762291AbZD1P5C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2009 11:57:02 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3SFuuZx016738
	for <linux-omap@vger.kernel.org>; Tue, 28 Apr 2009 10:57:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds SMP platform files support for OMAP4430SDP. TI's OMAP4430
SOC is based on ARM Cortex-A9 SMP architecture. It's a dual core SOC
with GIC used for interrupt handling and SCU for cache coherency.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-headsmp.S    |   49 +++++++
 arch/arm/mach-omap2/omap-smp.c        |  238 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/scu.h |   28 ++++
 arch/arm/plat-omap/include/mach/smp.h |   56 ++++++++
 4 files changed, 371 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap-headsmp.S
 create mode 100644 arch/arm/mach-omap2/omap-smp.c
 create mode 100644 arch/arm/plat-omap/include/mach/scu.h
 create mode 100644 arch/arm/plat-omap/include/mach/smp.h

diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
new file mode 100644
index 0000000..0afe039
--- /dev/null
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -0,0 +1,49 @@
+/*
+ * Secondary CPU startup routine source file.
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ *
+ * Author:
+ *      Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * Interface functions needed for the SMP. This file is based on arm
+ * realview smp platform.
+ * Copyright (c) 2003 ARM Limited.
+ *
+ * This program is free software,you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <linux/init.h>
+
+	__INIT
+
+/*
+ * OMAP4 specific entry point for secondary CPU to jump from ROM
+ * code.  This routine also provides a holding flag into which
+ * secondary core is held until we're ready for it to initialise.
+ * The primary core will update the this flag using a hardware
+ * register AuxCoreBoot1.
+ */
+ENTRY(omap_secondary_startup)
+	mrc	p15, 0, r0, c0, c0, 5
+	and	r0, r0, #15
+	adr	r4, 1f
+	ldmia	r4, {r5, r6}
+	sub	r4, r4, r5
+	add	r6, r6, r4
+hold:	ldr	r7, [r6]	 @ read from AuxCoreBoot1
+	cmp	r7, r0
+	bne	hold
+
+	/*
+	 * we've been released from the holding pen: secondary_stack
+	 * should now contain the SVC stack for this core
+	 */
+	b	secondary_startup
+
+1:	.long	.
+	.long	cpu_release
+
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
new file mode 100644
index 0000000..1d18acb
--- /dev/null
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -0,0 +1,238 @@
+/*
+ * OMAP4 SMP source file. It contains platform specific fucntions
+ * needed for the linux smp kernel.
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ *
+ * Author:
+ *      Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * Platform file needed for the OMAP4 SMP. This file is based on arm
+ * realview smp platform.
+ * * Copyright (c) 2002 ARM Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/jiffies.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+
+#include <asm/cacheflush.h>
+#include <mach/scu.h>
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+
+/* Registers used for communicating startup information */
+#define OMAP4_AUXCOREBOOT_REG0		(OMAP44XX_VA_WKUPGEN_BASE + 0x800)
+#define OMAP4_AUXCOREBOOT_REG1		(OMAP44XX_VA_WKUPGEN_BASE + 0x804)
+
+/* FIXME: Move to a common header file */
+extern void omap_secondary_startup(void);
+
+/*
+ * Control for which core is the next to come out of the secondary
+ * boot "Auxcontrol_register"
+ */
+int __cpuinitdata cpu_release = -1;
+
+/*
+ * Setup the SCU
+ */
+static void scu_enable(void)
+{
+	u32 scu_ctrl;
+	void __iomem *scu_base = OMAP44XX_VA_SCU_BASE;
+
+	scu_ctrl = __raw_readl(scu_base + SCU_CTRL);
+	scu_ctrl |= 1;
+	__raw_writel(scu_ctrl, scu_base + SCU_CTRL);
+}
+
+/*
+ * Use SCU config register to count number of cores
+ */
+static unsigned int __init get_core_count(void)
+{
+	unsigned int ncores;
+	void __iomem *scu_base = OMAP44XX_VA_SCU_BASE;
+
+	if (scu_base) {
+		ncores = __raw_readl(scu_base + SCU_CONFIG);
+		ncores = (ncores & 0x03) + 1;
+	} else {
+			ncores = 1;
+	}
+
+	return ncores;
+}
+
+static DEFINE_SPINLOCK(boot_lock);
+
+void __cpuinit platform_secondary_init(unsigned int cpu)
+{
+	trace_hardirqs_off();
+
+	/*
+	 * If any interrupts are already enabled for the primary
+	 * core (e.g. timer irq), then they will not have been enabled
+	 * for us: do so
+	 */
+
+	gic_cpu_init(0, IO_ADDRESS(OMAP44XX_GIC_CPU_BASE));
+
+	/*
+	 * Let the primary processor know we're out of the
+	 * pen, then head off into the C entry point
+	 */
+	cpu_release = -1;
+	smp_wmb();
+
+	/*
+	 * Synchronise with the boot thread.
+	 */
+	spin_lock(&boot_lock);
+	spin_unlock(&boot_lock);
+}
+
+int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	unsigned long timeout;
+
+	/*
+	 * Set synchronisation state between this boot processor
+	 * and the secondary one
+	 */
+	spin_lock(&boot_lock);
+
+	/*
+	 * The secondary processor is waiting for an event to come out of
+	 * wfe. Release it, then wait for it to flag that it has been
+	 * released by resetting cpu_release.
+	 *
+	 * Singal the ROM code that the secondary core can be released
+	 */
+	cpu_release = cpu;
+	__raw_writel(cpu, OMAP4_AUXCOREBOOT_REG1);
+	flush_cache_all();
+	/*
+	 * Send a 'sev' to wake the secondary core again because
+	 * ROM code will put core in WFE till the cpu_release
+	 * flag is set.
+	 */
+	set_event();
+	mb();
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout)) {
+		smp_rmb();
+		if (cpu_release == -1)
+			break;
+
+		udelay(10);
+	}
+
+	/*
+	 * Now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	spin_unlock(&boot_lock);
+
+	return cpu_release != -1 ? -ENOSYS : 0;
+}
+
+static void __init wakeup_secondary(void)
+{
+
+	/* cpu is not to be released from the hold yet */
+	cpu_release = -1;
+
+	/*
+	 * write the address of secondary startup into the system-wide
+	 * AuxCoreBoot0 where ROM code will jump and start executing
+	 * on secondary core
+	 */
+	__raw_writel(virt_to_phys(omap_secondary_startup),	   \
+					OMAP4_AUXCOREBOOT_REG0);
+	/*
+	 * Send a 'sev' to wake the secondary core from WFE.
+	 */
+	set_event();
+	mb();
+}
+
+/*
+ * Initialise the CPU possible map early - this describes the CPUs
+ * which may be present or become present in the system.
+ */
+void __init smp_init_cpus(void)
+{
+	unsigned int i, ncores = get_core_count();
+
+	for (i = 0; i < ncores; i++)
+		cpu_set(i, cpu_possible_map);
+}
+
+void __init smp_prepare_cpus(unsigned int max_cpus)
+{
+	unsigned int ncores = get_core_count();
+	unsigned int cpu = smp_processor_id();
+	int i;
+
+	/* sanity check */
+	if (ncores == 0) {
+		printk(KERN_ERR
+		       "OMAP4: strange core count of 0? Default to 1\n");
+		ncores = 1;
+	}
+
+	if (ncores > num_possible_cpus()) {
+		printk(KERN_WARNING
+		       "OMAP4: no. of cores (%d) greater than configured "
+		       "maximum of %d - clipping\n",
+		       ncores, num_possible_cpus());
+		ncores = num_possible_cpus();
+	}
+	smp_store_cpu_info(cpu);
+
+	/*
+	 * are we trying to boot more cores than exist?
+	 */
+	if (max_cpus > ncores)
+		max_cpus = ncores;
+
+#ifdef CONFIG_LOCAL_TIMERS
+	/*
+	 * Enable the local timer for primary CPU. If the device is
+	 * dummy (!CONFIG_LOCAL_TIMERS), it was already registers in
+	 * omap_timer_init
+	 */
+	local_timer_setup();
+#endif
+
+	/*
+	 * Initialise the present map, which describes the set of CPUs
+	 * actually populated at the present time.
+	 */
+	for (i = 0; i < max_cpus; i++)
+		cpu_set(i, cpu_present_map);
+
+	/*
+	 * Initialise the SCU and wake up the secondary core using
+	 *  wakeup_secondary().
+	 */
+	if (max_cpus > 1) {
+		scu_enable();
+		/*
+		 * Ensure that the data accessed by CPU0 before the SCU was
+		 * initialised is visible to CPU1.
+		 */
+		flush_cache_all();
+		wakeup_secondary();
+	}
+}
diff --git a/arch/arm/plat-omap/include/mach/scu.h b/arch/arm/plat-omap/include/mach/scu.h
new file mode 100644
index 0000000..2ee6660
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/scu.h
@@ -0,0 +1,28 @@
+/*
+ * SCU regsiter header.
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ *
+ *
+ * Author:
+ *      Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * Snoop Control Unit Registers. This file is based on arm
+ * realview smp platform.
+ * Copyright (c) 2003 ARM Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __OMAP_ARCH_SCU_H
+#define __OMAP_ARCH_SCU_H
+/*
+ * SCU registers
+ */
+#define SCU_CTRL		0x00
+#define SCU_CONFIG		0x04
+#define SCU_CPU_STATUS		0x08
+#define SCU_INVALIDATE		0x0c
+
+#endif
diff --git a/arch/arm/plat-omap/include/mach/smp.h b/arch/arm/plat-omap/include/mach/smp.h
new file mode 100644
index 0000000..b6a3e67
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/smp.h
@@ -0,0 +1,56 @@
+/*
+ * OMAP4 machine specific smp.h
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ *
+ * Author:
+ *	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * Interface functions needed for the SMP. This file is based on arm
+ * realview smp platform.
+ * Copyright (c) 2003 ARM Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef OMAP_ARCH_SMP_H
+#define OMAP_ARCH_SMP_H
+
+
+#include <asm/hardware/gic.h>
+
+/*
+ * set_event() is used to wake up secondary core from wfe using sev. ROM
+ * code puts the second core into wfe(standby).
+ *
+ */
+ #define set_event()	__asm__ __volatile__ ("sev" : : : "memory")
+
+/*
+ * We use Soft IRQ1 as the IPI
+ */
+static inline void smp_cross_call(cpumask_t callmap)
+{
+	gic_raise_softirq(callmap, 1);
+}
+
+/*
+ * Can be useful for WFI boot strategy.
+ */
+static inline void smp_cross_call_done(cpumask_t callmap)
+{
+}
+
+/*
+ * Read MPIDR: Multiprocessor affinity register
+ */
+#define hard_smp_processor_id()			\
+	({						\
+		unsigned int cpunum;			\
+		__asm__("mrc p15, 0, %0, c0, c0, 5"	\
+			: "=r" (cpunum));		\
+		cpunum &= 0x0F;				\
+	})
+
+#endif
-- 
1.5.4.7

