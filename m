From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 6/9] ARM: vexpress/realview: consolidate immitation CPU hotplug
Date: Thu, 13 Dec 2018 18:01:07 +0000
Message-ID: <E1gXVIJ-0008CX-8y@rmk-PC.armlinux.org.uk>
References: <20181213175952.GC26090@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181213175952.GC26090@n2100.armlinux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org, linux-oxnas@groups.io, linux-samsung-soc@vger.kernel.org, linux-soc@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-omap@vger.kernel.org

The only difference between the hotplug implementation for Realview
and Versatile Express are the bit in the auxiliary control register
to disable coherency.  Combine the two implentations accounting for
that difference.

Rename the functions to try to discourage cargo-cult copying of this
code.

Tested-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-realview/Makefile                    |   1 -
 arch/arm/mach-realview/hotplug.c                   | 111 ---------------------
 arch/arm/mach-realview/hotplug.h                   |   1 -
 arch/arm/mach-realview/platsmp-dt.c                |   8 +-
 arch/arm/mach-vexpress/Makefile                    |   1 -
 arch/arm/mach-vexpress/core.h                      |   2 -
 arch/arm/mach-vexpress/platsmp.c                   |   7 ++
 arch/arm/plat-versatile/Makefile                   |   1 +
 .../{mach-vexpress => plat-versatile}/hotplug.c    |  45 ++++-----
 arch/arm/plat-versatile/include/plat/platsmp.h     |   1 +
 10 files changed, 36 insertions(+), 142 deletions(-)
 delete mode 100644 arch/arm/mach-realview/hotplug.c
 delete mode 100644 arch/arm/mach-realview/hotplug.h
 rename arch/arm/{mach-vexpress => plat-versatile}/hotplug.c (58%)

diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
index adf39ad71cc3..6ca6400fa51e 100644
--- a/arch/arm/mach-realview/Makefile
+++ b/arch/arm/mach-realview/Makefile
@@ -5,4 +5,3 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-versatile/inc
 
 obj-y					+= realview-dt.o
 obj-$(CONFIG_SMP)			+= platsmp-dt.o
-obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
diff --git a/arch/arm/mach-realview/hotplug.c b/arch/arm/mach-realview/hotplug.c
deleted file mode 100644
index 968e2d1964f6..000000000000
--- a/arch/arm/mach-realview/hotplug.c
+++ /dev/null
@@ -1,111 +0,0 @@
-/*
- *  linux/arch/arm/mach-realview/hotplug.c
- *
- *  Copyright (C) 2002 ARM Ltd.
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/smp.h>
-
-#include <asm/cp15.h>
-#include <asm/smp_plat.h>
-
-static inline void cpu_enter_lowpower(void)
-{
-	unsigned int v;
-
-	asm volatile(
-	"	mcr	p15, 0, %1, c7, c5, 0\n"
-	"	mcr	p15, 0, %1, c7, c10, 4\n"
-	/*
-	 * Turn off coherency
-	 */
-	"	mrc	p15, 0, %0, c1, c0, 1\n"
-	"	bic	%0, %0, #0x20\n"
-	"	mcr	p15, 0, %0, c1, c0, 1\n"
-	"	mrc	p15, 0, %0, c1, c0, 0\n"
-	"	bic	%0, %0, %2\n"
-	"	mcr	p15, 0, %0, c1, c0, 0\n"
-	  : "=&r" (v)
-	  : "r" (0), "Ir" (CR_C)
-	  : "cc");
-}
-
-static inline void cpu_leave_lowpower(void)
-{
-	unsigned int v;
-
-	asm volatile(	"mrc	p15, 0, %0, c1, c0, 0\n"
-	"	orr	%0, %0, %1\n"
-	"	mcr	p15, 0, %0, c1, c0, 0\n"
-	"	mrc	p15, 0, %0, c1, c0, 1\n"
-	"	orr	%0, %0, #0x20\n"
-	"	mcr	p15, 0, %0, c1, c0, 1\n"
-	  : "=&r" (v)
-	  : "Ir" (CR_C)
-	  : "cc");
-}
-
-static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
-{
-	/*
-	 * there is no power-control hardware on this platform, so all
-	 * we can do is put the core into WFI; this is safe as the calling
-	 * code will have already disabled interrupts
-	 */
-	for (;;) {
-		/*
-		 * here's the WFI
-		 */
-		asm(".word	0xe320f003\n"
-		    :
-		    :
-		    : "memory", "cc");
-
-		if (pen_release == cpu_logical_map(cpu)) {
-			/*
-			 * OK, proper wakeup, we're done
-			 */
-			break;
-		}
-
-		/*
-		 * Getting here, means that we have come out of WFI without
-		 * having been woken up - this shouldn't happen
-		 *
-		 * Just note it happening - when we're woken, we can report
-		 * its occurrence.
-		 */
-		(*spurious)++;
-	}
-}
-
-/*
- * platform-specific code to shutdown a CPU
- *
- * Called with IRQs disabled
- */
-void realview_cpu_die(unsigned int cpu)
-{
-	int spurious = 0;
-
-	/*
-	 * we're ready for shutdown now, so do it
-	 */
-	cpu_enter_lowpower();
-	platform_do_lowpower(cpu, &spurious);
-
-	/*
-	 * bring this CPU back into the world of cache
-	 * coherency, and then restore interrupts
-	 */
-	cpu_leave_lowpower();
-
-	if (spurious)
-		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
-}
diff --git a/arch/arm/mach-realview/hotplug.h b/arch/arm/mach-realview/hotplug.h
deleted file mode 100644
index eacd7a4dad2f..000000000000
--- a/arch/arm/mach-realview/hotplug.h
+++ /dev/null
@@ -1 +0,0 @@
-void realview_cpu_die(unsigned int cpu);
diff --git a/arch/arm/mach-realview/platsmp-dt.c b/arch/arm/mach-realview/platsmp-dt.c
index c242423bf8db..ce331b3dbf54 100644
--- a/arch/arm/mach-realview/platsmp-dt.c
+++ b/arch/arm/mach-realview/platsmp-dt.c
@@ -17,7 +17,6 @@
 #include <asm/smp_scu.h>
 
 #include <plat/platsmp.h>
-#include "hotplug.h"
 
 #define REALVIEW_SYS_FLAGSSET_OFFSET	0x30
 
@@ -79,6 +78,13 @@ static void __init realview_smp_prepare_cpus(unsigned int max_cpus)
 		     __pa_symbol(versatile_secondary_startup));
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void realview_cpu_die(unsigned int cpu)
+{
+	return versatile_immitation_cpu_die(cpu, 0x20);
+}
+#endif
+
 static const struct smp_operations realview_dt_smp_ops __initconst = {
 	.smp_prepare_cpus	= realview_smp_prepare_cpus,
 	.smp_secondary_init	= versatile_secondary_init,
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 51c35e2b737a..3651a1ed0f2b 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -15,6 +15,5 @@ obj-$(CONFIG_ARCH_VEXPRESS_TC2_PM)	+= tc2_pm.o
 CFLAGS_tc2_pm.o				+= -march=armv7-a
 CFLAGS_REMOVE_tc2_pm.o			= -pg
 obj-$(CONFIG_SMP)			+= platsmp.o
-obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
 
 obj-$(CONFIG_ARCH_MPS2)			+= v2m-mps2.o
diff --git a/arch/arm/mach-vexpress/core.h b/arch/arm/mach-vexpress/core.h
index a162ab46ee02..f4a7519084f1 100644
--- a/arch/arm/mach-vexpress/core.h
+++ b/arch/arm/mach-vexpress/core.h
@@ -1,5 +1,3 @@
 bool vexpress_smp_init_ops(void);
 
 extern const struct smp_operations vexpress_smp_dt_ops;
-
-extern void vexpress_cpu_die(unsigned int cpu);
diff --git a/arch/arm/mach-vexpress/platsmp.c b/arch/arm/mach-vexpress/platsmp.c
index 742499bac6d0..af0113be5970 100644
--- a/arch/arm/mach-vexpress/platsmp.c
+++ b/arch/arm/mach-vexpress/platsmp.c
@@ -82,6 +82,13 @@ static void __init vexpress_smp_dt_prepare_cpus(unsigned int max_cpus)
 	vexpress_flags_set(__pa_symbol(versatile_secondary_startup));
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void vexpress_cpu_die(unsigned int cpu)
+{
+	versatile_immitation_cpu_die(cpu, 0x40);
+}
+#endif
+
 const struct smp_operations vexpress_smp_dt_ops __initconst = {
 	.smp_prepare_cpus	= vexpress_smp_dt_prepare_cpus,
 	.smp_secondary_init	= versatile_secondary_init,
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index bff3ba889882..b2f0ddfdc4cc 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -2,3 +2,4 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
 
 obj-$(CONFIG_PLAT_VERSATILE_SCHED_CLOCK) += sched-clock.o
 obj-$(CONFIG_SMP) += headsmp.o platsmp.o
+obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
diff --git a/arch/arm/mach-vexpress/hotplug.c b/arch/arm/plat-versatile/hotplug.c
similarity index 58%
rename from arch/arm/mach-vexpress/hotplug.c
rename to arch/arm/plat-versatile/hotplug.c
index d8f1a05f5e87..e2d3e9035d0f 100644
--- a/arch/arm/mach-vexpress/hotplug.c
+++ b/arch/arm/plat-versatile/hotplug.c
@@ -1,12 +1,15 @@
 /*
- *  linux/arch/arm/mach-realview/hotplug.c
- *
  *  Copyright (C) 2002 ARM Ltd.
  *  All Rights Reserved
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * This hotplug implementation is _specific_ to the situation found on
+ * ARM development platforms where there is _no_ possibility of actually
+ * taking a CPU offline, resetting it, or otherwise.  Real platforms must
+ * NOT copy this code.
  */
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -15,9 +18,7 @@
 #include <asm/smp_plat.h>
 #include <asm/cp15.h>
 
-#include "core.h"
-
-static inline void cpu_enter_lowpower(void)
+static inline void versatile_immitation_enter_lowpower(unsigned int actrl_mask)
 {
 	unsigned int v;
 
@@ -34,11 +35,11 @@ static inline void cpu_enter_lowpower(void)
 	"	bic	%0, %0, %2\n"
 	"	mcr	p15, 0, %0, c1, c0, 0\n"
 	  : "=&r" (v)
-	  : "r" (0), "Ir" (CR_C), "Ir" (0x40)
+	  : "r" (0), "Ir" (CR_C), "Ir" (actrl_mask)
 	  : "cc");
 }
 
-static inline void cpu_leave_lowpower(void)
+static inline void versatile_immitation_leave_lowpower(unsigned int actrl_mask)
 {
 	unsigned int v;
 
@@ -50,16 +51,18 @@ static inline void cpu_leave_lowpower(void)
 	"	orr	%0, %0, %2\n"
 	"	mcr	p15, 0, %0, c1, c0, 1\n"
 	  : "=&r" (v)
-	  : "Ir" (CR_C), "Ir" (0x40)
+	  : "Ir" (CR_C), "Ir" (actrl_mask)
 	  : "cc");
 }
 
-static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
+static inline void versatile_immitation_do_lowpower(unsigned int cpu, int *spurious)
 {
 	/*
 	 * there is no power-control hardware on this platform, so all
 	 * we can do is put the core into WFI; this is safe as the calling
-	 * code will have already disabled interrupts
+	 * code will have already disabled interrupts.
+	 *
+	 * This code should not be used outside Versatile platforms.
 	 */
 	for (;;) {
 		wfi();
@@ -83,25 +86,17 @@ static inline void platform_do_lowpower(unsigned int cpu, int *spurious)
 }
 
 /*
- * platform-specific code to shutdown a CPU
- *
- * Called with IRQs disabled
+ * platform-specific code to shutdown a CPU.
+ * This code supports immitation-style CPU hotplug for Versatile/Realview/
+ * Versatile Express platforms that are unable to do real CPU hotplug.
  */
-void vexpress_cpu_die(unsigned int cpu)
+void versatile_immitation_cpu_die(unsigned int cpu, unsigned int actrl_mask)
 {
 	int spurious = 0;
 
-	/*
-	 * we're ready for shutdown now, so do it
-	 */
-	cpu_enter_lowpower();
-	platform_do_lowpower(cpu, &spurious);
-
-	/*
-	 * bring this CPU back into the world of cache
-	 * coherency, and then restore interrupts
-	 */
-	cpu_leave_lowpower();
+	versatile_immitation_enter_lowpower(actrl_mask);
+	versatile_immitation_do_lowpower(cpu, &spurious);
+	versatile_immitation_leave_lowpower(actrl_mask);
 
 	if (spurious)
 		pr_warn("CPU%u: %u spurious wakeup calls\n", cpu, spurious);
diff --git a/arch/arm/plat-versatile/include/plat/platsmp.h b/arch/arm/plat-versatile/include/plat/platsmp.h
index 50fb830192e0..9fff1f241c9e 100644
--- a/arch/arm/plat-versatile/include/plat/platsmp.h
+++ b/arch/arm/plat-versatile/include/plat/platsmp.h
@@ -12,3 +12,4 @@
 extern void versatile_secondary_startup(void);
 extern void versatile_secondary_init(unsigned int cpu);
 extern int  versatile_boot_secondary(unsigned int cpu, struct task_struct *idle);
+void versatile_immitation_cpu_die(unsigned int cpu, unsigned int actrl_mask);
-- 
2.7.4
