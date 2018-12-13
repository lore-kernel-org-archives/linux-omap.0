From: Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4/9] ARM: sti: remove pen_release and boot_lock
Date: Thu, 13 Dec 2018 18:00:57 +0000
Message-ID: <E1gXVI9-000897-25@rmk-PC.armlinux.org.uk>
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
Cc: Patrice Chotard <patrice.chotard@st.com>
List-Id: linux-omap@vger.kernel.org

The pen_release implementation was created for Versatile platforms to
work around boot loaders that did not differentiate between the
various different secondary CPUs on this ARM development platform.
This should not be true of modern platforms where we send IPIs to
specific CPUs to wake them up.  Remove the pen_release stuff from
SoCs that make use of the per-CPU IPI mechanism.

The boot_lock is something that was required for ARM development
platforms to ensure that the delay calibration worked properly.  This
is not necessary for modern platforms that have better bus bandwidth
and do not need to calibrate the delay loop for secondary cores.
Remove the boot_lock entirely.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sti/Makefile  |  2 +-
 arch/arm/mach-sti/headsmp.S | 43 -------------------------------
 arch/arm/mach-sti/platsmp.c | 62 ++-------------------------------------------
 3 files changed, 3 insertions(+), 104 deletions(-)
 delete mode 100644 arch/arm/mach-sti/headsmp.S

diff --git a/arch/arm/mach-sti/Makefile b/arch/arm/mach-sti/Makefile
index acb330916333..f85ff059cfba 100644
--- a/arch/arm/mach-sti/Makefile
+++ b/arch/arm/mach-sti/Makefile
@@ -1,2 +1,2 @@
-obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
+obj-$(CONFIG_SMP)		+= platsmp.o
 obj-$(CONFIG_ARCH_STI) 		+= board-dt.o
diff --git a/arch/arm/mach-sti/headsmp.S b/arch/arm/mach-sti/headsmp.S
deleted file mode 100644
index e0ad451700d5..000000000000
--- a/arch/arm/mach-sti/headsmp.S
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- *  arch/arm/mach-sti/headsmp.S
- *
- * Copyright (C) 2013 STMicroelectronics (R&D) Limited.
- *		http://www.st.com
- *
- * Cloned from linux/arch/arm/mach-vexpress/headsmp.S
- *
- *  Copyright (c) 2003 ARM Limited
- *  All Rights Reserved
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <linux/linkage.h>
-#include <linux/init.h>
-
-/*
- * ST specific entry point for secondary CPUs.  This provides
- * a "holding pen" into which all secondary cores are held until we're
- * ready for them to initialise.
- */
-ENTRY(sti_secondary_startup)
-	mrc	p15, 0, r0, c0, c0, 5
-	and	r0, r0, #15
-	adr	r4, 1f
-	ldmia	r4, {r5, r6}
-	sub	r4, r4, r5
-	add	r6, r6, r4
-pen:	ldr	r7, [r6]
-	cmp	r7, r0
-	bne	pen
-
-	/*
-	 * we've been released from the holding pen: secondary_stack
-	 * should now contain the SVC stack for this core
-	 */
-	b	secondary_startup
-ENDPROC(sti_secondary_startup)
-
-1:	.long	.
-	.long	pen_release
diff --git a/arch/arm/mach-sti/platsmp.c b/arch/arm/mach-sti/platsmp.c
index 231f19e17436..21668501c9bb 100644
--- a/arch/arm/mach-sti/platsmp.c
+++ b/arch/arm/mach-sti/platsmp.c
@@ -28,72 +28,15 @@
 
 #include "smp.h"
 
-static void write_pen_release(int val)
-{
-	pen_release = val;
-	smp_wmb();
-	sync_cache_w(&pen_release);
-}
-
-static DEFINE_SPINLOCK(boot_lock);
-
-static void sti_secondary_init(unsigned int cpu)
-{
-	/*
-	 * let the primary processor know we're out of the
-	 * pen, then head off into the C entry point
-	 */
-	write_pen_release(-1);
-
-	/*
-	 * Synchronise with the boot thread.
-	 */
-	spin_lock(&boot_lock);
-	spin_unlock(&boot_lock);
-}
-
 static int sti_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
-	unsigned long timeout;
-
-	/*
-	 * set synchronisation state between this boot processor
-	 * and the secondary one
-	 */
-	spin_lock(&boot_lock);
-
-	/*
-	 * The secondary processor is waiting to be released from
-	 * the holding pen - release it, then wait for it to flag
-	 * that it has been released by resetting pen_release.
-	 *
-	 * Note that "pen_release" is the hardware CPU ID, whereas
-	 * "cpu" is Linux's internal ID.
-	 */
-	write_pen_release(cpu_logical_map(cpu));
-
 	/*
 	 * Send the secondary CPU a soft interrupt, thereby causing
 	 * it to jump to the secondary entrypoint.
 	 */
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 
-	timeout = jiffies + (1 * HZ);
-	while (time_before(jiffies, timeout)) {
-		smp_rmb();
-		if (pen_release == -1)
-			break;
-
-		udelay(10);
-	}
-
-	/*
-	 * now the secondary core is starting up let it run its
-	 * calibrations, then wait for it to finish
-	 */
-	spin_unlock(&boot_lock);
-
-	return pen_release != -1 ? -ENOSYS : 0;
+	return 0;
 }
 
 static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
@@ -103,7 +46,7 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 	u32 __iomem *cpu_strt_ptr;
 	u32 release_phys;
 	int cpu;
-	unsigned long entry_pa = __pa_symbol(sti_secondary_startup);
+	unsigned long entry_pa = __pa_symbol(secondary_startup);
 
 	np = of_find_compatible_node(NULL, NULL, "arm,cortex-a9-scu");
 
@@ -158,6 +101,5 @@ static void __init sti_smp_prepare_cpus(unsigned int max_cpus)
 
 const struct smp_operations sti_smp_ops __initconst = {
 	.smp_prepare_cpus	= sti_smp_prepare_cpus,
-	.smp_secondary_init	= sti_secondary_init,
 	.smp_boot_secondary	= sti_boot_secondary,
 };
-- 
2.7.4
