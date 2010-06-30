From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [RFC][PATCH 1/1] ARM: Add initial hibernation support
Date: Wed, 30 Jun 2010 17:28:01 +0300
Message-ID: <1277908081-17195-2-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1277908081-17195-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29665 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756287Ab0F3O26 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 10:28:58 -0400
In-Reply-To: <1277908081-17195-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Yoshiya.Hirase@nokia.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org, teerth@ti.com, linux-pm@lists.linux-foundation.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Hibernation (a.k.a: Suspend-To-Disk) support for ARM

Based on the original work from Romit and Raghu at TI. The original
patch(*1) was sent to LOML by Teerth Reddy <teerth@ti.com>

*1: https://patchwork.kernel.org/patch/96442/

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/Kconfig                |    4 +
 arch/arm/include/asm/memory.h   |    1 +
 arch/arm/include/asm/suspend.h  |    6 +
 arch/arm/kernel/Makefile        |    1 +
 arch/arm/kernel/hibernate.c     |  234 +++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/hibernate_asm.S |  135 ++++++++++++++++++++++
 arch/arm/kernel/vmlinux.lds.S   |    3 +-
 7 files changed, 383 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/include/asm/suspend.h
 create mode 100644 arch/arm/kernel/hibernate.c
 create mode 100644 arch/arm/kernel/hibernate_asm.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1f254bd..c19a206 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -189,6 +189,10 @@ config VECTORS_BASE
 	help
 	  The base address of exception vectors.
 
+config ARCH_HIBERNATION_POSSIBLE
+	def_bool y
+	depends on CPU_V7 && !SMP
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 4312ee5..cd49706 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -194,6 +194,7 @@ static inline void *phys_to_virt(unsigned long x)
  */
 #define __pa(x)			__virt_to_phys((unsigned long)(x))
 #define __va(x)			((void *)__phys_to_virt((unsigned long)(x)))
+#define __pa_symbol(x)		__pa(RELOC_HIDE((unsigned long)(x),0))
 #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 
 /*
diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
new file mode 100644
index 0000000..8857c79
--- /dev/null
+++ b/arch/arm/include/asm/suspend.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_ARM_SUSPEND_H
+#define __ASM_ARM_SUSPEND_H
+
+static inline int arch_prepare_suspend(void) { return 0; }
+
+#endif	/* __ASM_ARM_SUSPEND_H */
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 26d302c..38a0b10 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_ARM_THUMBEE)	+= thumbee.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_ARM_UNWIND)	+= unwind.o
 obj-$(CONFIG_HAVE_TCM)		+= tcm.o
+obj-$(CONFIG_HIBERNATION)       += hibernate.o hibernate_asm.o
 
 obj-$(CONFIG_CRUNCH)		+= crunch.o crunch-bits.o
 AFLAGS_crunch-bits.o		:= -Wa,-mcpu=ep9312
diff --git a/arch/arm/kernel/hibernate.c b/arch/arm/kernel/hibernate.c
new file mode 100644
index 0000000..692c720
--- /dev/null
+++ b/arch/arm/kernel/hibernate.c
@@ -0,0 +1,234 @@
+/*
+ * Hibernation support specific for ARM
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+ *
+ * Contact: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/module.h>
+#include <linux/mm.h>
+
+/*
+ * Image of the saved processor state
+ *
+ * coprocessor 15 registers(RW)
+ */
+struct saved_context {
+/*
+ * FIXME: Only support for Cortex A8 now
+ */
+	/* CR0 */
+	u32 cssr;	/* Cache Size Selection */
+	/* CR1 */
+	u32 cr;		/* Control */
+	u32 cacr;	/* Coprocessor Access Control */
+	/* CR2 */
+	u32 ttb_0r;	/* Translation Table Base 0 */
+	u32 ttb_1r;	/* Translation Table Base 1 */
+	u32 ttbcr;	/* Translation Talbe Base Control */
+	/* CR3 */
+	u32 dacr;	/* Domain Access Control */
+	/* CR5 */
+	u32 d_fsr;	/* Data Fault Status */
+	u32 i_fsr;	/* Instruction Fault Status */
+	u32 d_afsr;	/* Data Auxilirary Fault Status */	 ;
+	u32 i_afsr;	/* Instruction Auxilirary Fault Status */;
+	/* CR6 */
+	u32 d_far;	/* Data Fault Address */
+	u32 i_far;	/* Instruction Fault Address */
+	/* CR7 */
+	u32 par;	/* Physical Address */
+	/* CR9 */	/* FIXME: Are they necessary? */
+	u32 pmcontrolr;	/* Performance Monitor Control */
+	u32 cesr;      	/* Count Enable Set */
+	u32 cecr;      	/* Count Enable Clear */
+	u32 ofsr;      	/* Overflow Flag Status */
+	u32 sir;       	/* Software Increment */
+	u32 pcsr;      	/* Performance Counter Selection */
+	u32 ccr;       	/* Cycle Count */
+	u32 esr;       	/* Event Selection */
+	u32 pmcountr;  	/* Performance Monitor Count */
+	u32 uer;       	/* User Enable */
+	u32 iesr;      	/* Interrupt Enable Set */
+	u32 iecr;      	/* Interrupt Enable Clear */
+	u32 l2clr;     	/* L2 Cache Lockdown */
+	/* CR10 */
+	u32 d_tlblr;	/* Data TLB Lockdown Register */
+	u32 i_tlblr;	/* Instruction TLB Lockdown Register */
+	u32 prrr;	/* Primary Region Remap Register */
+	u32 nrrr;	/* Normal Memory Remap Register */
+	/* CR11 */
+	u32 pleuar;	/* PLE User Accessibility */
+	u32 plecnr;	/* PLE Channel Number */
+	u32 plecr;	/* PLE Control */
+	u32 pleisar;	/* PLE Internal Start Address */
+	u32 pleiear;	/* PLE Internal End Address */
+	u32 plecidr;	/* PLE Context ID */
+	/* CR12 */
+	u32 snsvbar;	/* Secure or Nonsecure Vector Base Address */
+	/* CR13 */
+	u32 fcse;	/* FCSE PID */
+	u32 cid;	/* Context ID */
+	u32 urwtpid;	/* User read/write Thread and Process ID */
+	u32 urotpid;	/* User read-only Thread and Process ID */
+	u32 potpid;	/* Privileged only Thread and Process ID */
+} __attribute__((packed));
+
+/* Used in hibernate_asm.S */
+#define USER_CONTEXT_SIZE (sizeof(u32) * 15)
+unsigned long saved_context_r0[USER_CONTEXT_SIZE];
+unsigned long saved_cpsr;
+unsigned long saved_context_r13_svc;
+unsigned long saved_context_r14_svc;
+unsigned long saved_spsr_svc;
+
+static struct saved_context saved_context;
+
+/* References to section boundaries */
+extern const void __nosave_begin, __nosave_end;
+
+/*
+ * pfn_is_nosave - check if given pfn is in the 'nosave' section
+ */
+int pfn_is_nosave(unsigned long pfn)
+{
+	unsigned long nosave_begin_pfn = __pa_symbol(&__nosave_begin) >> PAGE_SHIFT;
+	unsigned long nosave_end_pfn = PAGE_ALIGN(__pa_symbol(&__nosave_end)) >> PAGE_SHIFT;
+
+	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
+}
+
+static inline void __save_processor_state(struct saved_context *ctxt)
+{
+	/* CR0 */
+	asm volatile ("mrc p15, 2, %0, c0, c0, 0" : "=r"(ctxt->cssr));
+	/* CR1 */
+	asm volatile ("mrc p15, 0, %0, c1, c0, 0" : "=r"(ctxt->cr));
+	asm volatile ("mrc p15, 0, %0, c1, c0, 2" : "=r"(ctxt->cacr));
+	/* CR2 */
+	asm volatile ("mrc p15, 0, %0, c2, c0, 0" : "=r"(ctxt->ttb_0r));
+	asm volatile ("mrc p15, 0, %0, c2, c0, 1" : "=r"(ctxt->ttb_1r));
+	asm volatile ("mrc p15, 0, %0, c2, c0, 2" : "=r"(ctxt->ttbcr));
+	/* CR3 */
+	asm volatile ("mrc p15, 0, %0, c3, c0, 0" : "=r"(ctxt->dacr));
+	/* CR5 */
+	asm volatile ("mrc p15, 0, %0, c5, c0, 0" : "=r"(ctxt->d_fsr));
+	asm volatile ("mrc p15, 0, %0, c5, c0, 1" : "=r"(ctxt->i_fsr));
+	asm volatile ("mrc p15, 0, %0, c5, c1, 0" : "=r"(ctxt->d_afsr));
+	asm volatile ("mrc p15, 0, %0, c5, c1, 1" : "=r"(ctxt->i_afsr));
+	/* CR6 */
+	asm volatile ("mrc p15, 0, %0, c6, c0, 0" : "=r"(ctxt->d_far));
+	asm volatile ("mrc p15, 0, %0, c6, c0, 2" : "=r"(ctxt->i_far));
+	/* CR7 */
+	asm volatile ("mrc p15, 0, %0, c7, c4, 0" : "=r"(ctxt->par));
+	/* CR9 */
+	asm volatile ("mrc p15, 0, %0, c9, c12, 0" : "=r"(ctxt->pmcontrolr));
+	asm volatile ("mrc p15, 0, %0, c9, c12, 1" : "=r"(ctxt->cesr));
+	asm volatile ("mrc p15, 0, %0, c9, c12, 2" : "=r"(ctxt->cecr));
+	asm volatile ("mrc p15, 0, %0, c9, c12, 3" : "=r"(ctxt->ofsr));
+	asm volatile ("mrc p15, 0, %0, c9, c12, 4" : "=r"(ctxt->sir));
+	asm volatile ("mrc p15, 0, %0, c9, c12, 5" : "=r"(ctxt->pcsr));
+	asm volatile ("mrc p15, 0, %0, c9, c13, 0" : "=r"(ctxt->ccr));
+	asm volatile ("mrc p15, 0, %0, c9, c13, 1" : "=r"(ctxt->esr));
+	asm volatile ("mrc p15, 0, %0, c9, c13, 2" : "=r"(ctxt->pmcountr));
+	asm volatile ("mrc p15, 0, %0, c9, c14, 0" : "=r"(ctxt->uer));
+	asm volatile ("mrc p15, 0, %0, c9, c14, 1" : "=r"(ctxt->iesr));
+	asm volatile ("mrc p15, 0, %0, c9, c14, 2" : "=r"(ctxt->iecr));
+	asm volatile ("mrc p15, 1, %0, c9, c0, 0" : "=r"(ctxt->l2clr));
+	/* CR10 */
+	asm volatile ("mrc p15, 0, %0, c10, c0, 0" : "=r"(ctxt->d_tlblr));
+	asm volatile ("mrc p15, 0, %0, c10, c0, 1" : "=r"(ctxt->i_tlblr));
+	asm volatile ("mrc p15, 0, %0, c10, c2, 0" : "=r"(ctxt->prrr));
+	asm volatile ("mrc p15, 0, %0, c10, c2, 1" : "=r"(ctxt->nrrr));
+	/* CR11 */
+	asm volatile ("mrc p15, 0, %0, c11, c1, 0" : "=r"(ctxt->pleuar));
+	asm volatile ("mrc p15, 0, %0, c11, c2, 0" : "=r"(ctxt->plecnr));
+	asm volatile ("mrc p15, 0, %0, c11, c4, 0" : "=r"(ctxt->plecr));
+	asm volatile ("mrc p15, 0, %0, c11, c5, 0" : "=r"(ctxt->pleisar));
+	asm volatile ("mrc p15, 0, %0, c11, c7, 0" : "=r"(ctxt->pleiear));
+	asm volatile ("mrc p15, 0, %0, c11, c15, 0" : "=r"(ctxt->plecidr));
+	/* CR12 */
+	asm volatile ("mrc p15, 0, %0, c12, c0, 0" : "=r"(ctxt->snsvbar));
+	/* CR13 */
+	asm volatile ("mrc p15, 0, %0, c13, c0, 0" : "=r"(ctxt->fcse));
+	asm volatile ("mrc p15, 0, %0, c13, c0, 1" : "=r"(ctxt->cid));
+	asm volatile ("mrc p15, 0, %0, c13, c0, 2" : "=r"(ctxt->urwtpid));
+	asm volatile ("mrc p15, 0, %0, c13, c0, 3" : "=r"(ctxt->urotpid));
+	asm volatile ("mrc p15, 0, %0, c13, c0, 4" : "=r"(ctxt->potpid));
+}
+
+static inline void __restore_processor_state(struct saved_context *ctxt)
+{
+	/* CR0 */
+	asm volatile ("mcr p15, 2, %0, c0, c0, 0" : : "r"(ctxt->cssr));
+	/* CR1 */
+	asm volatile ("mcr p15, 0, %0, c1, c0, 0" : : "r"(ctxt->cr));
+	asm volatile ("mcr p15, 0, %0, c1, c0, 2" : : "r"(ctxt->cacr));
+	/* CR2 */
+	asm volatile ("mcr p15, 0, %0, c2, c0, 0" : : "r"(ctxt->ttb_0r));
+	asm volatile ("mcr p15, 0, %0, c2, c0, 1" : : "r"(ctxt->ttb_1r));
+	asm volatile ("mcr p15, 0, %0, c2, c0, 2" : : "r"(ctxt->ttbcr));
+	/* CR3 */
+	asm volatile ("mcr p15, 0, %0, c3, c0, 0" : : "r"(ctxt->dacr));
+	/* CR5 */
+	asm volatile ("mcr p15, 0, %0, c5, c0, 0" : : "r"(ctxt->d_fsr));
+	asm volatile ("mcr p15, 0, %0, c5, c0, 1" : : "r"(ctxt->i_fsr));
+	asm volatile ("mcr p15, 0, %0, c5, c1, 0" : : "r"(ctxt->d_afsr));
+	asm volatile ("mcr p15, 0, %0, c5, c1, 1" : : "r"(ctxt->i_afsr));
+	/* CR6 */
+	asm volatile ("mcr p15, 0, %0, c6, c0, 0" : : "r"(ctxt->d_far));
+	asm volatile ("mcr p15, 0, %0, c6, c0, 2" : : "r"(ctxt->i_far));
+	/* CR7 */
+	asm volatile ("mcr p15, 0, %0, c7, c4, 0" : : "r"(ctxt->par));
+	/* CR9 */
+	asm volatile ("mcr p15, 0, %0, c9, c12, 0" : : "r"(ctxt->pmcontrolr));
+	asm volatile ("mcr p15, 0, %0, c9, c12, 1" : : "r"(ctxt->cesr));
+	asm volatile ("mcr p15, 0, %0, c9, c12, 2" : : "r"(ctxt->cecr));
+	asm volatile ("mcr p15, 0, %0, c9, c12, 3" : : "r"(ctxt->ofsr));
+	asm volatile ("mcr p15, 0, %0, c9, c12, 4" : : "r"(ctxt->sir));
+	asm volatile ("mcr p15, 0, %0, c9, c12, 5" : : "r"(ctxt->pcsr));
+	asm volatile ("mcr p15, 0, %0, c9, c13, 0" : : "r"(ctxt->ccr));
+	asm volatile ("mcr p15, 0, %0, c9, c13, 1" : : "r"(ctxt->esr));
+	asm volatile ("mcr p15, 0, %0, c9, c13, 2" : : "r"(ctxt->pmcountr));
+	asm volatile ("mcr p15, 0, %0, c9, c14, 0" : : "r"(ctxt->uer));
+	asm volatile ("mcr p15, 0, %0, c9, c14, 1" : : "r"(ctxt->iesr));
+	asm volatile ("mcr p15, 0, %0, c9, c14, 2" : : "r"(ctxt->iecr));
+	asm volatile ("mcr p15, 1, %0, c9, c0, 0" : : "r"(ctxt->l2clr));
+	/* CR10 */
+	asm volatile ("mcr p15, 0, %0, c10, c0, 0" : : "r"(ctxt->d_tlblr));
+	asm volatile ("mcr p15, 0, %0, c10, c0, 1" : : "r"(ctxt->i_tlblr));
+	asm volatile ("mcr p15, 0, %0, c10, c2, 0" : : "r"(ctxt->prrr));
+	asm volatile ("mcr p15, 0, %0, c10, c2, 1" : : "r"(ctxt->nrrr));
+	/* CR11 */
+	asm volatile ("mcr p15, 0, %0, c11, c1, 0" : : "r"(ctxt->pleuar));
+	asm volatile ("mcr p15, 0, %0, c11, c2, 0" : : "r"(ctxt->plecnr));
+	asm volatile ("mcr p15, 0, %0, c11, c4, 0" : : "r"(ctxt->plecr));
+	asm volatile ("mcr p15, 0, %0, c11, c5, 0" : : "r"(ctxt->pleisar));
+	asm volatile ("mcr p15, 0, %0, c11, c7, 0" : : "r"(ctxt->pleiear));
+	asm volatile ("mcr p15, 0, %0, c11, c15, 0" : : "r"(ctxt->plecidr));
+	/* CR12 */
+	asm volatile ("mcr p15, 0, %0, c12, c0, 0" : : "r"(ctxt->snsvbar));
+	/* CR13 */
+	asm volatile ("mcr p15, 0, %0, c13, c0, 0" : : "r"(ctxt->fcse));
+	asm volatile ("mcr p15, 0, %0, c13, c0, 1" : : "r"(ctxt->cid));
+	asm volatile ("mcr p15, 0, %0, c13, c0, 2" : : "r"(ctxt->urwtpid));
+	asm volatile ("mcr p15, 0, %0, c13, c0, 3" : : "r"(ctxt->urotpid));
+	asm volatile ("mcr p15, 0, %0, c13, c0, 4" : : "r"(ctxt->potpid));
+}
+
+void save_processor_state(void)
+{
+	preempt_disable();
+	__save_processor_state(&saved_context);
+}
+
+void restore_processor_state(void)
+{
+	__restore_processor_state(&saved_context);
+	preempt_enable();
+}
diff --git a/arch/arm/kernel/hibernate_asm.S b/arch/arm/kernel/hibernate_asm.S
new file mode 100644
index 0000000..6fc199c
--- /dev/null
+++ b/arch/arm/kernel/hibernate_asm.S
@@ -0,0 +1,135 @@
+/*
+ * Hibernation support specific for ARM
+ *
+ * Copyright (C) 2010 Nokia Corporation
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+ *
+ * Contact: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/linkage.h>
+	.text
+ENTRY(swsusp_arch_suspend)
+	/*
+	 * Save current program status register
+	 */
+	ldr     r3, .Lsaved_cpsr
+	mrs     r0, cpsr
+	str     r0, [r3]
+
+	/*
+	 * Change to system(user) mode
+	 */
+	mov     r1, r0
+	orr     r1, r1, #0x1f
+	msr     cpsr_c, r1
+
+	/*
+	 * Save User context
+	 */
+	ldr     r3, .Lsaved_context_r0
+	stmia   r3, {r0-r14}
+
+	/*
+	 * Go back to original SVC mode
+	 */
+	msr     cpsr_c, r0
+
+	/*
+	 * Save SVC context
+	 */
+	ldr     r3, .Lsaved_context_r13_svc
+	stmia   r3, {r13-r14}
+	ldr     r3, .Lsaved_spsr_svc
+	mrs     r1, spsr
+	str     r1, [r3]
+
+	bl      swsusp_save
+
+	/*
+	 * Restore return address
+	 */
+	ldr     r3, .Lsaved_context_r14_svc
+	ldr     lr, [r3]
+	mov     pc, lr
+ENDPROC(swsusp_arch_suspend)
+
+ENTRY(swsusp_arch_resume)
+	/*
+	 * Restore_pblist is the starting point for loaded pages
+	 */
+	ldr     r0, .Lrestore_pblist
+	ldr     r6, [r0]
+
+.Lcopy_loop:
+	ldr     r4, [r6]     /* src IOW present address */
+	ldr     r5, [r6, #4] /* dst IOW original address*/
+	mov     r9, #1024    /* No. of entries in one page, where each entry is 4 bytes */
+
+.Lcopy_one_page:
+	/*
+	 * This loop could be optimized by using stm and ldm.
+	 */
+	ldr     r8, [r4], #4
+	str     r8, [r5], #4
+	subs    r9, r9, #1
+	bne     .Lcopy_one_page
+
+	/* The last field of struct pbe is a pointer to the next pbe structure */
+	ldr     r6, [r6, #8]
+	cmp     r6, #0
+	bne     .Lcopy_loop
+
+	/*
+	 * Restore SVC context
+	 */
+	ldr     r3, .Lsaved_context_r13_svc
+	ldmia   r3, {r13-r14}
+	ldr     r3, .Lsaved_spsr_svc
+	ldr     r1, [r3]
+	msr     spsr_cxsf, r1
+
+	mrs     r0, cpsr	/* Save current mode into r0 */
+
+	/*
+	 * Change to system(user) mode
+	 */
+	mov     r1, r0
+	orr     r1, r1, #0x1f
+	msr     cpsr_c, r1
+
+	/*
+	 * Restore User context
+	 */
+	ldr     r3, .Lsaved_context_r0
+	ldmia   r3, {r0-r14}
+	ldr     r3, .Lsaved_cpsr
+	ldr     r1, [r3]
+	msr     cpsr_cxsf, r1
+
+	msr     cpsr_c, r0	/* Restore original mode from r0 */
+
+	/*
+	 * Flush TLB (Invalidate unified TLB unlocked entries)
+	 */
+	mov     r1, #0
+	mcr     p15, 0, r1, c8, c7, 0
+
+	/* Set the return value */
+	mov	r0, #0
+
+	/* Restore return address */
+	ldr     r3, .Lsaved_context_r14_svc
+	ldr     lr, [r3]
+	mov     pc, lr
+ENDPROC(swsusp_arch_resume)
+	.align	4
+.Lsaved_context_r0:		.long	saved_context_r0
+.Lsaved_cpsr:			.long	saved_cpsr
+.Lsaved_context_r13_svc: 	.long	saved_context_r13_svc
+.Lsaved_context_r14_svc:	.long	saved_context_r14_svc
+.Lsaved_spsr_svc:		.long	saved_spsr_svc
+.Lrestore_pblist:		.long	restore_pblist
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index b16c079..799c79c 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -149,7 +149,6 @@ SECTIONS
 		__init_end = .;
 #endif
 
-		NOSAVE_DATA
 		CACHELINE_ALIGNED_DATA(32)
 
 		/*
@@ -172,6 +171,8 @@ SECTIONS
 	}
 	_edata_loc = __data_loc + SIZEOF(.data);
 
+	NOSAVE_DATA
+
 #ifdef CONFIG_HAVE_TCM
         /*
 	 * We align everything to a page boundary so we can
-- 
1.7.1.rc2

