From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/3] omap4: hotplug: Add basic CPU hotplug support
Date: Tue,  6 Jul 2010 20:28:39 +0530
Message-ID: <1278428319-8743-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57853 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab0GFO6r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Jul 2010 10:58:47 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds cpu hotplug support for OMAP4430. Only CPU inactive
state is supported as a low power state in the basic hot-plug support

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/Makefile                    |    1 +
 arch/arm/mach-omap2/include/mach/omap4-common.h |    7 ++
 arch/arm/mach-omap2/omap-hotplug.c              |   79 +++++++++++++++++++++++
 arch/arm/mach-omap2/omap-smp.c                  |    3 +-
 4 files changed, 89 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap-hotplug.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 3cb1b51..0db90ff 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 # SMP support ONLY available for OMAP4
 obj-$(CONFIG_SMP)			+= omap-smp.o omap-headsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)		+= timer-mpu.o
+obj-$(CONFIG_HOTPLUG_CPU)		+= omap-hotplug.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap44xx-smc.o omap4-common.o
 
 AFLAGS_omap44xx-smc.o			:=-Wa,-march=armv7-a
diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index 423af3a..2744dfe 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -13,6 +13,13 @@
 #ifndef OMAP_ARCH_OMAP4_COMMON_H
 #define OMAP_ARCH_OMAP4_COMMON_H
 
+/*
+ * wfi used in low power code. Directly opcode is used instead
+ * of instruction to avoid mulit-omap build break
+ */
+#define do_wfi()			\
+		__asm__ __volatile__ (".word	0xe320f003" : : : "memory")
+
 #ifdef CONFIG_CACHE_L2X0
 extern void __iomem *l2cache_base;
 #endif
diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
new file mode 100644
index 0000000..6cee456
--- /dev/null
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -0,0 +1,79 @@
+/*
+ * OMAP4 SMP cpu-hotplug support
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Author:
+ *      Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * Platform file needed for the OMAP4 SMP. This file is based on arm
+ * realview smp platform.
+ * Copyright (c) 2002 ARM Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+#include <linux/completion.h>
+
+#include <asm/cacheflush.h>
+#include <mach/omap4-common.h>
+
+static DECLARE_COMPLETION(cpu_killed);
+
+int platform_cpu_kill(unsigned int cpu)
+{
+	return wait_for_completion_timeout(&cpu_killed, 5000);
+}
+
+/*
+ * platform-specific code to shutdown a CPU
+ * Called with IRQs disabled
+ */
+void platform_cpu_die(unsigned int cpu)
+{
+	unsigned int this_cpu = hard_smp_processor_id();
+
+	if (cpu != this_cpu) {
+		pr_crit("platform_cpu_die running on %u, should be %u\n",
+			   this_cpu, cpu);
+		BUG();
+	}
+	pr_notice("CPU%u: shutdown\n", cpu);
+	complete(&cpu_killed);
+	flush_cache_all();
+	dsb();
+
+	/*
+	 * we're ready for shutdown now, so do it
+	 */
+	if (omap_modify_auxcoreboot0(0x0, 0x200) != 0x0)
+		printk(KERN_CRIT "Secure clear status failed\n");
+
+	for (;;) {
+		/*
+		 * Execute WFI
+		 */
+		do_wfi();
+
+		if (omap_read_auxcoreboot0() == cpu) {
+			/*
+			 * OK, proper wakeup, we're done
+			 */
+			break;
+		}
+		pr_debug("CPU%u: spurious wakeup call\n", cpu);
+	}
+}
+
+int platform_cpu_disable(unsigned int cpu)
+{
+	/*
+	 * we don't allow CPU 0 to be shutdown (it is still too special
+	 * e.g. clock tick interrupts)
+	 */
+	return cpu == 0 ? -EPERM : 0;
+}
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 1cf5231..af3c20c 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -73,9 +73,10 @@ int __cpuinit boot_secondary(unsigned int cpu, struct task_struct *idle)
 	 * the AuxCoreBoot1 register is updated with cpu state
 	 * A barrier is added to ensure that write buffer is drained
 	 */
-	omap_modify_auxcoreboot0(0x200, 0x0);
+	omap_modify_auxcoreboot0(0x200, 0xfffffdff);
 	flush_cache_all();
 	smp_wmb();
+	smp_cross_call(cpumask_of(cpu));
 
 	/*
 	 * Now the secondary core is starting up let it run its
-- 
1.6.0.4

