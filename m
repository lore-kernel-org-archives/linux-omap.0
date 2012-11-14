From: Russ Dill <Russ.Dill@ti.com>
Subject: [RFC PATCH v7] ARM hibernation / suspend-to-disk
Date: Wed, 14 Nov 2012 12:22:50 -0800
Message-ID: <1352924570-17194-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43915 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057Ab2KNUXA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Nov 2012 15:23:00 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so621772pbc.19
        for <linux-omap@vger.kernel.org>; Wed, 14 Nov 2012 12:22:59 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, tuxonice-devel@tuxonice.net, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
Cc: Russ Dill <Russ.Dill@ti.com>

This is a rebase/rework of Frank Hofmann's work, the most recent patchset
being here:
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/053229.html

The biggest gotcha right now:

   If there's any cpu-specific / SoC-specific state that needs (re)init
   over a suspend-to-disk/resume-from-disk cycle, this patch is incomplete
   because it provides no hooks/code for that.

   This is the case e.g. for "secure" SoCs that have different sets of
   control registers and/or different CR reg access patterns.

   It's also the case e.g. for SoCs with L2 caches as the activation
   sequence there is SoC-dependent; a full off-on cycle for L2 is not done
   by the hibernation support code.

   It's also the case if the SoC requires steps on wakeup _before_ the
   "generic" parts done by cpu_suspend / cpu_resume can work correctly.

   (OMAP is an example of such a SoC; the patch "works" on OMAP in the
   sense that it gets you a non-secure OMAP back from hibernation but as
   mentioned, your mileage may vary; I for example don't know what the
   consequences  of not disabling / reenabling the L2 cache over cpu_reset
   are)

I've only tested on Beagleboard xM, and it gets stuck trying to program
some GPIOs since the interface clock isn't enabled. However, things
generally look good.

The work is built on Linux-3.7.0-rc5-00014-g9924a19.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 arch/arm/include/asm/memory.h |   1 +
 arch/arm/kernel/Makefile      |   1 +
 arch/arm/kernel/hibernate.c   | 117 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/Kconfig           |   5 ++
 4 files changed, 124 insertions(+)
 create mode 100644 arch/arm/kernel/hibernate.c

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 73cf03a..8376a39 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -230,6 +230,7 @@ static inline void *phys_to_virt(phys_addr_t x)
  */
 #define __pa(x)			__virt_to_phys((unsigned long)(x))
 #define __va(x)			((void *)__phys_to_virt((unsigned long)(x)))
+#define __pa_symbol(x)		__pa(RELOC_HIDE((unsigned long)(x),0))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 
 /*
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 5bbec7b..2971988 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_ARTHUR)		+= arthur.o
 obj-$(CONFIG_ISA_DMA)		+= dma-isa.o
 obj-$(CONFIG_PCI)		+= bios32.o isa.o
 obj-$(CONFIG_ARM_CPU_SUSPEND)	+= sleep.o suspend.o
+obj-$(CONFIG_HIBERNATION)	+= hibernate.o
 obj-$(CONFIG_SMP)		+= smp.o smp_tlb.o
 obj-$(CONFIG_HAVE_ARM_SCU)	+= smp_scu.o
 obj-$(CONFIG_HAVE_ARM_TWD)	+= smp_twd.o
diff --git a/arch/arm/kernel/hibernate.c b/arch/arm/kernel/hibernate.c
new file mode 100644
index 0000000..0b72e17
--- /dev/null
+++ b/arch/arm/kernel/hibernate.c
@@ -0,0 +1,117 @@
+/*
+ * Hibernation support specific for ARM
+ *
+ * Derived from work on ARM hibernation support by:
+ *
+ * Ubuntu project, hibernation support for mach-dove
+ * Copyright (C) 2010 Nokia Corporation (Hiroshi Doyu)
+ * Copyright (C) 2010 Texas Instruments, Inc. (Teerth Reddy et al.)
+ *	https://lkml.org/lkml/2010/6/18/4
+ *	https://lists.linux-foundation.org/pipermail/linux-pm/2010-June/027422.html
+ *	https://patchwork.kernel.org/patch/96442/
+ *
+ * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/mm.h>
+#include <linux/suspend.h>
+#include <asm/tlbflush.h>
+#include <asm/cacheflush.h>
+#include <asm/system_misc.h>
+#include <asm/idmap.h>
+#include <asm/suspend.h>
+
+extern const void __nosave_begin, __nosave_end;
+extern void cpu_resume(void);
+
+int pfn_is_nosave(unsigned long pfn)
+{
+	unsigned long nosave_begin_pfn =
+			__pa_symbol(&__nosave_begin) >> PAGE_SHIFT;
+	unsigned long nosave_end_pfn =
+			PAGE_ALIGN(__pa_symbol(&__nosave_end)) >> PAGE_SHIFT;
+
+	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
+}
+
+void notrace save_processor_state(void)
+{
+	WARN_ON(num_online_cpus() != 1);
+	flush_thread();
+	local_fiq_disable();
+}
+
+void notrace restore_processor_state(void)
+{
+	local_fiq_enable();
+}
+
+/*
+ * Snapshot kernel memory and reset the system.
+ * After resume, the hibernation snapshot is written out.
+ */
+static int notrace __swsusp_arch_save_image(unsigned long unused)
+{
+	extern int swsusp_save(void);
+	int ret;
+
+	ret = swsusp_save();
+	if (ret == 0)
+		soft_restart(virt_to_phys(cpu_resume));
+	return ret;
+}
+
+/*
+ * Save the current CPU state before suspend / poweroff.
+ */
+int notrace swsusp_arch_suspend(void)
+{
+	return cpu_suspend(0, __swsusp_arch_save_image);
+}
+
+/*
+ * The framework loads the hibernation image into a linked list anchored
+ * at restore_pblist, for swsusp_arch_resume() to copy back to the proper
+ * destinations.
+ *
+ * To make this work if resume is triggered from initramfs, the
+ * pagetables need to be switched to allow writes to kernel mem.
+ */
+static void notrace __swsusp_arch_restore_image(void *unused)
+{
+	extern struct pbe *restore_pblist;
+	phys_reset_t phys_reset;
+	struct pbe *pbe;
+
+	cpu_switch_mm(idmap_pgd, &init_mm);
+
+	for (pbe = restore_pblist; pbe; pbe = pbe->next)
+		copy_page(pbe->orig_address, pbe->address);
+
+	cpu_proc_fin();
+	flush_cache_all();
+
+	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
+
+	/* Return from cpu_suspend/swsusp_arch_suspend */
+	phys_reset((unsigned long)virt_to_phys(cpu_resume));
+}
+
+static u8 __swsusp_resume_stk[PAGE_SIZE/2] __nosavedata;
+
+/*
+ * Resume from the hibernation image.
+ * Due to the kernel heap / data restore, stack contents change underneath
+ * and that would make function calls impossible; switch to a temporary
+ * stack within the nosave region to avoid that problem.
+ */
+int __naked swsusp_arch_resume(void)
+{
+	extern void call_with_stack(void (*fn)(void *), void *arg, void *sp);
+	cpu_init();	/* get a clean PSR */
+	call_with_stack(__swsusp_arch_restore_image, 0,
+		__swsusp_resume_stk + sizeof(__swsusp_resume_stk));
+	return 0;
+}
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 94186b6..e3bd891 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -583,6 +583,11 @@ config CPU_USE_DOMAINS
 config IO_36
 	bool
 
+config ARCH_HIBERNATION_POSSIBLE
+	bool
+	depends on MMU
+	default y if CPU_ARM920T || CPU_ARM926T || CPU_SA1100 || CPU_XSCALE || CPU_XSC3 || CPU_V6 || CPU_V6K || CPU_V7
+
 comment "Processor Features"
 
 config ARM_LPAE
-- 
1.8.0

