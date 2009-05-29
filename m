From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/4 v2] ARM: OMAP4: SMP: Add OMAP4430 SMP board files
Date: Fri, 29 May 2009 15:59:47 +0530
Message-ID: <1243592987-15649-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50425 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754858AbZE2KaQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 May 2009 06:30:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, Santosh Shilimkar <santosh.shilimkar@ti.com>

(Updated with new interfaces as per Russell's remarks:
 cpu_set(i, cpu_present_map) --> set_cpu_present(i, true)
 cpu_set(i, cpu_possible_map) --> set_cpu_possible(i, true)
)

This patch adds SMP platform files support for OMAP4430SDP. TI's OMAP4430
SOC is based on ARM Cortex-A9 SMP architecture. It's a dual core SOC
with GIC used for interrupt handling and SCU for cache coherency.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap-headsmp.S    |   46 +++++++++
 arch/arm/mach-omap2/omap-smp.c        |  178 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/smp.h |   51 ++++++++++
 3 files changed, 275 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap-headsmp.S
 create mode 100644 arch/arm/mach-omap2/omap-smp.c
 create mode 100644 arch/arm/plat-omap/include/mach/smp.h

diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
new file mode 100644
index 0000000..4afadba
--- /dev/null
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -0,0 +1,46 @@
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
+/* Physical address needed since MMU not enabled yet on secondary core */
+#define OMAP4_AUX_CORE_BOOT1_PA			0x48281804
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
+	and	r0, r0, #0x0f
+hold:	ldr	r1, =OMAP4_AUX_CORE_BOOT1_PA	@ read from AuxCoreBoot1
+	ldr	r2, [r1]
+	cmp	r2, r0
+	bne	hold
+
+	/*
+	 * we've been released from the cpu_release,secondary_stack
+	 * should now contain the SVC stack for this core
+	 */
+	b	secondary_startup
+
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
new file mode 100644
index 0000000..8fe8d23
--- /dev/null
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -0,0 +1,178 @@
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
+#include <linux/device.h>
+#include <linux/jiffies.h>
+#include <linux/smp.h>
+#include <linux/io.h>
+
+#include <asm/localtimer.h>
+#include <asm/smp_scu.h>
+#include <mach/hardware.h>
+
+/* Registers used for communicating startup information */
+#define OMAP4_AUXCOREBOOT_REG0		(OMAP44XX_VA_WKUPGEN_BASE + 0x800)
+#define OMAP4_AUXCOREBOOT_REG1		(OMAP44XX_VA_WKUPGEN_BASE + 0x804)
+
+/* SCU base address */
+static void __iomem *scu_base = OMAP44XX_VA_SCU_BASE;
+
+/*
+ * Use SCU config register to count number of cores
+ */
+static inline unsigned int get_core_count(void)
+{
+	if (scu_base)
+		return scu_get_core_count(scu_base);
+	return 1;
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
+	 * Update the AuxCoreBoot1 with boot state for secondary core.
+	 * omap_secondary_startup() routine will hold the secondary core till
+	 * the AuxCoreBoot1 register is updated with cpu state
+	 * A barrier is added to ensure that write buffer is drained
+	 */
+	__raw_writel(cpu, OMAP4_AUXCOREBOOT_REG1);
+	smp_wmb();
+
+	timeout = jiffies + (1 * HZ);
+	while (time_before(jiffies, timeout))
+		;
+
+	/*
+	 * Now the secondary core is starting up let it run its
+	 * calibrations, then wait for it to finish
+	 */
+	spin_unlock(&boot_lock);
+
+	return 0;
+}
+
+static void __init wakeup_secondary(void)
+{
+	/*
+	 * Write the address of secondary startup routine into the
+	 * AuxCoreBoot0 where ROM code will jump and start executing
+	 * on secondary core once out of WFE
+	 * A barrier is added to ensure that write buffer is drained
+	 */
+	__raw_writel(virt_to_phys(omap_secondary_startup),	   \
+					OMAP4_AUXCOREBOOT_REG0);
+	smp_wmb();
+
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
+		set_cpu_possible(i, true);
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
+	if (ncores > NR_CPUS) {
+		printk(KERN_WARNING
+		       "OMAP4: no. of cores (%d) greater than configured "
+		       "maximum of %d - clipping\n",
+		       ncores, NR_CPUS);
+		ncores = NR_CPUS;
+	}
+	smp_store_cpu_info(cpu);
+
+	/*
+	 * are we trying to boot more cores than exist?
+	 */
+	if (max_cpus > ncores)
+		max_cpus = ncores;
+
+	/*
+	 * Initialise the present map, which describes the set of CPUs
+	 * actually populated at the present time.
+	 */
+	for (i = 0; i < max_cpus; i++)
+		set_cpu_present(i, true);
+
+	if (max_cpus > 1) {
+		/*
+		 * Enable the local timer or broadcast device for the
+		 * boot CPU, but only if we have more than one CPU.
+		 */
+		percpu_timer_setup();
+
+		/*
+		 * Initialise the SCU and wake up the secondary core using
+		 * wakeup_secondary().
+		 */
+		scu_enable(scu_base);
+		wakeup_secondary();
+	}
+}
diff --git a/arch/arm/plat-omap/include/mach/smp.h b/arch/arm/plat-omap/include/mach/smp.h
new file mode 100644
index 0000000..dcaa8fd
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/smp.h
@@ -0,0 +1,51 @@
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
+#include <asm/hardware/gic.h>
+
+/*
+ * set_event() is used to wake up secondary core from wfe using sev. ROM
+ * code puts the second core into wfe(standby).
+ *
+ */
+#define set_event()	__asm__ __volatile__ ("sev" : : : "memory")
+
+/* Needed for secondary core boot */
+extern void omap_secondary_startup(void);
+
+/*
+ * We use Soft IRQ1 as the IPI
+ */
+static inline void smp_cross_call(const struct cpumask *mask)
+{
+	gic_raise_softirq(mask, 1);
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

