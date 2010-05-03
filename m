From: "Reddy, Teerth" <teerth@ti.com>
Subject: RE: ARM suspend to disk?
Date: Mon, 3 May 2010 12:29:44 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0322A8AACA@dbde02.ent.ti.com>
References: <4BD881A7.2020402@gmail.com>
 <87y6g6w373.fsf@deeprootsystems.com>
	<p2kf96d234e1004301446l255a8cb4h7287e2502934e9fd@mail.gmail.com>
 <87iq78d295.fsf@deeprootsystems.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C5217E11@dbde02.ent.ti.com>
 <4BDE5AFD.9070506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42871 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754277Ab0ECG7w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 02:59:52 -0400
In-Reply-To: <4BDE5AFD.9070506@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Tseng <tsenpet09@gmail.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Cliff Brake <cliff.brake@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


Please find the patch which Romit and Raghu had worked on. Hope it helps.


Regards
Teerth


diff -purN 12x_old/arch/arm/kernel/vmlinux.lds.S 12x_git/arch/arm/kernel/vmlinux.lds.S
--- 12x_old/arch/arm/kernel/vmlinux.lds.S       2009-06-30 14:29:09.000000000 +0530
+++ 12x_git/arch/arm/kernel/vmlinux.lds.S       2009-06-30 11:05:16.000000000 +0530
@@ -87,6 +87,7 @@ SECTIONS
        }

        .text : {                       /* Real text segment            */
+       _kern_text_start = .;
                _text = .;              /* Text and read-only data      */
                        __exception_text_start = .;
                        *(.exception.text)
@@ -108,6 +109,7 @@ SECTIONS
        RODATA

        _etext = .;                     /* End of text and rodata section */
+       _kern_text_end = .;

 #ifdef CONFIG_XIP_KERNEL
        __data_loc = ALIGN(4);          /* location in binary */
@@ -134,12 +136,6 @@ SECTIONS
                __init_end = .;
 #endif

-               . = ALIGN(4096);
-               __nosave_begin = .;
-               *(.data.nosave)
-               . = ALIGN(4096);
-               __nosave_end = .;
-
                /*
                 * then the cacheline aligned data
                 */
@@ -165,6 +161,11 @@ SECTIONS
                _edata = .;
        }
        _edata_loc = __data_loc + SIZEOF(.data);
+       . = ALIGN(4096);
+       __nosave_begin = .;
+       .data.nosave : { *(.data.nosave) }
+       . = ALIGN(4096);
+       __nosave_end = .;

        .bss : {
                __bss_start = .;        /* BSS                          */
diff -purN 12x_old/arch/arm/Makefile 12x_git/arch/arm/Makefile
--- 12x_old/arch/arm/Makefile   2009-06-30 14:29:09.000000000 +0530
+++ 12x_git/arch/arm/Makefile   2009-06-30 11:05:16.000000000 +0530
@@ -198,6 +198,7 @@ core-$(CONFIG_ARCH_MXC)             += arch/arm/pla
 drivers-$(CONFIG_OPROFILE)      += arch/arm/oprofile/
 drivers-$(CONFIG_ARCH_CLPS7500)        += drivers/acorn/char/
 drivers-$(CONFIG_ARCH_L7200)   += drivers/acorn/char/
+drivers-$(CONFIG_HIBERNATION)  += arch/arm/power/

 libs-y                         := arch/arm/lib/ $(libs-y)

diff -purN 12x_old/arch/arm/mm/init.c 12x_git/arch/arm/mm/init.c
--- 12x_old/arch/arm/mm/init.c  2009-06-30 14:29:09.000000000 +0530
+++ 12x_git/arch/arm/mm/init.c  2009-06-30 11:05:16.000000000 +0530
@@ -354,6 +354,25 @@ static inline void free_area(unsigned lo
                printk(KERN_INFO "Freeing %s memory: %dK\n", s, size);
 }

+#if defined(CONFIG_HIBERNATION)
+
+/*
+ * Swap suspend & friends need this for resume.
+ */
+
+/* pgd_t is unsigned long [2], so 2 * 4 (byte/word) */
+
+char __nosavedata swsusp_pg_dir[PTRS_PER_PGD * 2 * 4]
+/* Translation Table Base must be on 16KB boundary. */
+__attribute__ ((aligned (1UL << 14)));
+
+void swsusp_save_pg_dir(void)
+{
+       memcpy(swsusp_pg_dir, swapper_pg_dir, PTRS_PER_PGD * 2 * 4);
+}
+#endif
+
+
 static inline void
 free_memmap(int node, unsigned long start_pfn, unsigned long end_pfn)
 {
diff -purN 12x_git/arch/arm/power/cpu.c 2.6.24.7-linux/arch/arm/power/cpu.c
--- 12x_git/arch/arm/power/cpu.c        1970-01-01 05:30:00.000000000 +0530
+++ 2.6.24.7-linux/arch/arm/power/cpu.c 2009-07-06 15:45:30.000000000 +0530
@@ -0,0 +1,157 @@
+/*
+ * cpu.c  - Suspend support specific for ARM.
+ *             based on arch/i386/power/cpu.c
+ *
+ * Distribute under GPLv2
+ *
+ * Copyright (c) 2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (c) 2001 Patrick Mochel <mochel@osdl.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/poll.h>
+#include <linux/delay.h>
+#include <linux/sysrq.h>
+#include <linux/proc_fs.h>
+#include <linux/pm.h>
+#include <linux/device.h>
+#include <asm/suspend.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+#include <asm/tlbflush.h>
+
+static struct saved_context saved_context;
+
+void __save_processor_state(struct saved_context *ctxt)
+{
+       unsigned long reg;
+
+     /* save preempt state and disable it */
+       preempt_disable();
+
+       /* save coprocessor 15 registers*/
+       asm volatile ("mrc p15, 2, %0, c0, c0, 0" : "=r"(ctxt->CSSR));
+       asm volatile ("mrc p15, 0, %0, c1, c0, 0" : "=r"(ctxt->CR));
+       asm volatile ("mrc p15, 0, %0, c1, c0, 2" : "=r"(ctxt->CACR));
+       asm volatile ("mrc p15, 0, %0, c2, c0, 0" : "=r"(ctxt->TTB_0R));
+       asm volatile ("mrc p15, 0, %0, c2, c0, 1" : "=r"(ctxt->TTB_1R));
+       asm volatile ("mrc p15, 0, %0, c2, c0, 2" : "=r"(ctxt->TTBCR));
+       asm volatile ("mrc p15, 0, %0, c3, c0, 0" : "=r"(ctxt->DACR));
+       asm volatile ("mrc p15, 0, %0, c5, c0, 0" : "=r"(ctxt->D_FSR));
+       asm volatile ("mrc p15, 0, %0, c5, c0, 1" : "=r"(ctxt->I_FSR));
+       asm volatile ("mrc p15, 0, %0, c5, c1, 0" : "=r"(ctxt->D_AFSR));
+       asm volatile ("mrc p15, 0, %0, c5, c1, 1" : "=r"(ctxt->I_AFSR));
+       asm volatile ("mrc p15, 0, %0, c6, c0, 0" : "=r"(ctxt->D_FAR));
+       asm volatile ("mrc p15, 0, %0, c6, c0, 2" : "=r"(ctxt->I_FAR));
+       asm volatile ("mrc p15, 0, %0, c7, c4, 0" : "=r"(ctxt->PAR));
+       asm volatile ("mrc p15, 0, %0, c9, c12, 0" : "=r"(ctxt->PMControlR));
+       asm volatile ("mrc p15, 0, %0, c9, c12, 1" : "=r"(ctxt->CESR));
+       asm volatile ("mrc p15, 0, %0, c9, c12, 2" : "=r"(ctxt->CECR));
+       asm volatile ("mrc p15, 0, %0, c9, c12, 3" : "=r"(ctxt->OFSR));
+       asm volatile ("mrc p15, 0, %0, c9, c12, 4" : "=r"(ctxt->SIR));
+       asm volatile ("mrc p15, 0, %0, c9, c12, 5" : "=r"(ctxt->PCSR));
+       asm volatile ("mrc p15, 0, %0, c9, c13, 0" : "=r"(ctxt->CCR));
+       asm volatile ("mrc p15, 0, %0, c9, c13, 1" : "=r"(ctxt->ESR));
+       asm volatile ("mrc p15, 0, %0, c9, c13, 2" : "=r"(ctxt->PMCountR));
+       asm volatile ("mrc p15, 0, %0, c9, c14, 0" : "=r"(ctxt->UER));
+       asm volatile ("mrc p15, 0, %0, c9, c14, 1" : "=r"(ctxt->IESR));
+       asm volatile ("mrc p15, 0, %0, c9, c14, 2" : "=r"(ctxt->IECR));
+       asm volatile ("mrc p15, 1, %0, c9, c0, 0" : "=r"(ctxt->L2CLR));
+       asm volatile ("mrc p15, 0, %0, c10, c0, 0" : "=r"(ctxt->D_TLBLR));
+       asm volatile ("mrc p15, 0, %0, c10, c0, 1" : "=r"(ctxt->I_TLBLR));
+       asm volatile ("mrc p15, 0, %0, c10, c2, 0" : "=r"(ctxt->PRRR));
+       asm volatile ("mrc p15, 0, %0, c10, c2, 1" : "=r"(ctxt->NRRR));
+       asm volatile ("mrc p15, 0, %0, c11, c1, 0" : "=r"(ctxt->PLEUAR));
+       asm volatile ("mrc p15, 0, %0, c11, c2, 0" : "=r"(ctxt->PLECNR));
+       asm volatile ("mrc p15, 0, %0, c11, c4, 0" : "=r"(ctxt->PLECR));
+       asm volatile ("mrc p15, 0, %0, c11, c5, 0" : "=r"(ctxt->PLEISAR));
+       asm volatile ("mrc p15, 0, %0, c11, c7, 0" : "=r"(ctxt->PLEIEAR));
+       asm volatile ("mrc p15, 0, %0, c11, c15, 0" : "=r"(ctxt->PLECIDR));
+       asm volatile ("mrc p15, 0, %0, c12, c0, 0" : "=r"(ctxt->SNSVBAR));
+       asm volatile ("mrc p15, 0, %0, c13, c0, 0" : "=r"(ctxt->FCSE));
+       asm volatile ("mrc p15, 0, %0, c13, c0, 1" : "=r"(ctxt->CID));
+       asm volatile ("mrc p15, 0, %0, c13, c0, 2" : "=r"(ctxt->URWTPID));
+       asm volatile ("mrc p15, 0, %0, c13, c0, 3" : "=r"(ctxt->UROTPID));
+       asm volatile ("mrc p15, 0, %0, c13, c0, 4" : "=r"(ctxt->POTPID));
+
+}
+
+void save_processor_state(void)
+{
+       __save_processor_state(&saved_context);
+}
+
+void __restore_processor_state(struct saved_context *ctxt)
+{
+       asm volatile ("mcr p15, 2, %0, c0, c0, 0" : : "r"(ctxt->CSSR));
+       asm volatile ("mcr p15, 0, %0, c1, c0, 0" : : "r"(ctxt->CR));
+        asm volatile ("mcr p15, 0, %0, c1, c0, 2" : : "r"(ctxt->CACR));
+        asm volatile ("mcr p15, 0, %0, c2, c0, 0" : : "r"(ctxt->TTB_0R));
+        asm volatile ("mcr p15, 0, %0, c2, c0, 1" : : "r"(ctxt->TTB_1R));
+        asm volatile ("mcr p15, 0, %0, c2, c0, 2" : : "r"(ctxt->TTBCR));
+       asm volatile ("mcr p15, 0, %0, c3, c0, 0" : : "r"(ctxt->DACR));
+       asm volatile ("mcr p15, 0, %0, c5, c0, 0" : : "r"(ctxt->D_FSR));
+       asm volatile ("mcr p15, 0, %0, c5, c0, 1" : : "r"(ctxt->I_FSR));
+        asm volatile ("mcr p15, 0, %0, c5, c1, 0" : : "r"(ctxt->D_AFSR));
+        asm volatile ("mcr p15, 0, %0, c5, c1, 1" : : "r"(ctxt->I_AFSR));
+       asm volatile ("mcr p15, 0, %0, c6, c0, 0" : : "r"(ctxt->D_FAR));
+        asm volatile ("mcr p15, 0, %0, c6, c0, 2" : : "r"(ctxt->I_FAR));
+        asm volatile ("mcr p15, 0, %0, c7, c4, 0" : : "r"(ctxt->PAR));
+        asm volatile ("mcr p15, 0, %0, c9, c12, 0" : : "r"(ctxt->PMControlR));
+        asm volatile ("mcr p15, 0, %0, c9, c12, 1" : : "r"(ctxt->CESR));
+        asm volatile ("mcr p15, 0, %0, c9, c12, 2" : : "r"(ctxt->CECR));
+        asm volatile ("mcr p15, 0, %0, c9, c12, 3" : : "r"(ctxt->OFSR));
+        asm volatile ("mcr p15, 0, %0, c9, c12, 4" : : "r"(ctxt->SIR));
+        asm volatile ("mcr p15, 0, %0, c9, c12, 5" : : "r"(ctxt->PCSR));
+        asm volatile ("mcr p15, 0, %0, c9, c13, 0" : : "r"(ctxt->CCR));
+        asm volatile ("mcr p15, 0, %0, c9, c13, 1" : : "r"(ctxt->ESR));
+        asm volatile ("mcr p15, 0, %0, c9, c13, 2" : : "r"(ctxt->PMCountR));
+        asm volatile ("mcr p15, 0, %0, c9, c14, 0" : : "r"(ctxt->UER));
+        asm volatile ("mcr p15, 0, %0, c9, c14, 1" : : "r"(ctxt->IESR));
+        asm volatile ("mcr p15, 0, %0, c9, c14, 2" : : "r"(ctxt->IECR));
+        asm volatile ("mcr p15, 1, %0, c9, c0, 0" : : "r"(ctxt->L2CLR));
+        asm volatile ("mcr p15, 0, %0, c10, c0, 0" : : "r"(ctxt->D_TLBLR));
+        asm volatile ("mcr p15, 0, %0, c10, c0, 1" : : "r"(ctxt->I_TLBLR));
+        asm volatile ("mcr p15, 0, %0, c10, c2, 0" : : "r"(ctxt->PRRR));
+        asm volatile ("mcr p15, 0, %0, c10, c2, 1" : : "r"(ctxt->NRRR));
+        asm volatile ("mcr p15, 0, %0, c11, c1, 0" : : "r"(ctxt->PLEUAR));
+       asm volatile ("mcr p15, 0, %0, c11, c2, 0" : : "r"(ctxt->PLECNR));
+        asm volatile ("mcr p15, 0, %0, c11, c4, 0" : : "r"(ctxt->PLECR));
+        asm volatile ("mcr p15, 0, %0, c11, c5, 0" : : "r"(ctxt->PLEISAR));
+        asm volatile ("mcr p15, 0, %0, c11, c7, 0" : : "r"(ctxt->PLEIEAR));
+        asm volatile ("mcr p15, 0, %0, c11, c15, 0" : : "r"(ctxt->PLECIDR));
+        asm volatile ("mcr p15, 0, %0, c12, c0, 0" : : "r"(ctxt->SNSVBAR));
+        asm volatile ("mcr p15, 0, %0, c13, c0, 0" : : "r"(ctxt->FCSE));
+       asm volatile ("mcr p15, 0, %0, c13, c0, 1" : : "r"(ctxt->CID));
+        asm volatile ("mcr p15, 0, %0, c13, c0, 2" : : "r"(ctxt->URWTPID));
+       asm volatile ("mcr p15, 0, %0, c13, c0, 3" : : "r"(ctxt->UROTPID));
+        asm volatile ("mcr p15, 0, %0, c13, c0, 4" : : "r"(ctxt->POTPID));
+
+       /* restore preempt state */
+       preempt_enable();
+}
+
+void restore_processor_state(void)
+{
+       __restore_processor_state(&saved_context);
+}
+
+
+EXPORT_SYMBOL(save_processor_state);
+EXPORT_SYMBOL(restore_processor_state);
diff -purN 12x_git/arch/arm/power/Makefile 2.6.24.7-linux/arch/arm/power/Makefile
--- 12x_git/arch/arm/power/Makefile     1970-01-01 05:30:00.000000000 +0530
+++ 2.6.24.7-linux/arch/arm/power/Makefile      2009-06-29 15:35:58.000000000 +0530
@@ -0,0 +1 @@
+obj-$(CONFIG_HIBERNATION)       += cpu.o swsusp.o suspend.o
diff -purN 12x_git/arch/arm/power/suspend.c 2.6.24.7-linux/arch/arm/power/suspend.c
--- 12x_git/arch/arm/power/suspend.c    1970-01-01 05:30:00.000000000 +0530
+++ 2.6.24.7-linux/arch/arm/power/suspend.c     2009-06-29 15:34:04.000000000 +0530
@@ -0,0 +1,29 @@
+/*
+ * Suspend support specific for ARM - temporary page tables
+ *
+ * Distribute under GPLv2
+ *
+ * Copyright (c) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+ */
+
+#include <linux/suspend.h>
+#include <linux/bootmem.h>
+
+#include <asm/system.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+/* References to section boundaries */
+extern const void __nosave_begin, __nosave_end;
+
+
+/*
+ *     pfn_is_nosave - check if given pfn is in the 'nosave' section
+ */
+
+int pfn_is_nosave(unsigned long pfn)
+{
+       unsigned long nosave_begin_pfn = __pa_symbol(&__nosave_begin) >> PAGE_SHIFT;
+       unsigned long nosave_end_pfn = PAGE_ALIGN(__pa_symbol(&__nosave_end)) >> PAGE_SHIFT;
+       return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
+}
diff -purN 12x_git/arch/arm/power/swsusp.S 2.6.24.7-linux/arch/arm/power/swsusp.S
--- 12x_git/arch/arm/power/swsusp.S     1970-01-01 05:30:00.000000000 +0530
+++ 2.6.24.7-linux/arch/arm/power/swsusp.S      2009-07-07 16:08:33.000000000 +0530
@@ -0,0 +1,447 @@
+/*
+ * swsusp.S - This file is based on arch/i386/power/swsusp.S;
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*
+ * This may not use any stack, nor any variable that is not "NoSave":
+ *
+ * Its rewriting one kernel image with another. What is stack in "old"
+ * image could very well be data page in "new" image, and overwriting
+ * your own stack under you is bad idea.
+ */
+
+/*
+ * FIXME: Work needs to be done for core with fp.
+ */
+
+#include <linux/linkage.h>
+#include <asm/segment.h>
+#include <asm/page.h>
+
+       .text
+
+#define        LOCAL_WORD(x) \
+       .data                   ; \
+       .p2align 2              ; \
+       .type   x, #object      ; \
+       .size   x, 4            ; \
+x:                             ; \
+       .long 1
+
+#define WORD_ADDR(x) \
+       .align 2                ; \
+.L##x:                         ; \
+       .word x
+
+#define        FUNC(x) \
+        .text                  ; \
+       .p2align 2              ; \
+       .globl x                ; \
+       .type   x, #function    ; \
+x:
+
+#define        FUNC_END(x) \
+       .size   x, .-x
+
+#define CHANGE_MODE(x) \
+       mov     r1, r0          ; \
+       bic     r1, r1, #0x1f   ; \
+       orr     r1, r1, #0x##x  ; \
+       msr     cpsr_c, r1
+
+#define SAVE_VFP_REG(x) \
+       fmrrd   r0, r1, d##x    ; \
+       str     r0, [r2]        ; \
+       str     r1, [r3]        ; \
+       add     r2, r2, #4      ; \
+       add     r3, r3, #4
+
+
+#define RESTORE_VFP_REG(x) \
+       ldr     r0, [r2]        ; \
+       ldr     r1, [r3]        ; \
+       fmdrr   d##x, r0, r1
+
+
+/* nonvolatile int registers */
+#ifdef DEBUG
+       .globl  saved_context_r0        // for debug
+#endif
+       LOCAL_WORD(saved_context_r0)
+       LOCAL_WORD(saved_context_r1)
+       LOCAL_WORD(saved_context_r2)
+       LOCAL_WORD(saved_context_r3)
+       LOCAL_WORD(saved_context_r4)
+       LOCAL_WORD(saved_context_r5)
+       LOCAL_WORD(saved_context_r6)
+       LOCAL_WORD(saved_context_r7)
+       LOCAL_WORD(saved_context_r8)
+       LOCAL_WORD(saved_context_r9)
+       LOCAL_WORD(saved_context_r10)
+       LOCAL_WORD(saved_context_r11)
+       LOCAL_WORD(saved_context_r12)
+       LOCAL_WORD(saved_context_r13)
+       LOCAL_WORD(saved_context_r14)
+       LOCAL_WORD(saved_cpsr)
+
+       LOCAL_WORD(saved_context_r8_fiq)
+       LOCAL_WORD(saved_context_r9_fiq)
+       LOCAL_WORD(saved_context_r10_fiq)
+       LOCAL_WORD(saved_context_r11_fiq)
+       LOCAL_WORD(saved_context_r12_fiq)
+       LOCAL_WORD(saved_context_r13_fiq)
+       LOCAL_WORD(saved_context_r14_fiq)
+       LOCAL_WORD(saved_spsr_fiq)
+
+       LOCAL_WORD(saved_context_r13_irq)
+       LOCAL_WORD(saved_context_r14_irq)
+       LOCAL_WORD(saved_spsr_irq)
+
+       LOCAL_WORD(saved_context_r13_svc)
+       LOCAL_WORD(saved_context_r14_svc)
+       LOCAL_WORD(saved_spsr_svc)
+
+       LOCAL_WORD(saved_context_r13_abt)
+       LOCAL_WORD(saved_context_r14_abt)
+       LOCAL_WORD(saved_spsr_abt)
+
+       LOCAL_WORD(saved_context_r13_und)
+       LOCAL_WORD(saved_context_r14_und)
+       LOCAL_WORD(saved_spsr_und)
+
+       LOCAL_WORD(saved_fpscr)
+       LOCAL_WORD(saved_fpexc)
+
+       LOCAL_WORD(lower_d0);
+        LOCAL_WORD(lower_d1);
+        LOCAL_WORD(lower_d2);
+        LOCAL_WORD(lower_d3);
+        LOCAL_WORD(lower_d4);
+        LOCAL_WORD(lower_d5);
+        LOCAL_WORD(lower_d6);
+        LOCAL_WORD(lower_d7);
+        LOCAL_WORD(lower_d8);
+        LOCAL_WORD(lower_d9);
+        LOCAL_WORD(lower_d10);
+        LOCAL_WORD(lower_d11);
+        LOCAL_WORD(lower_d12);
+        LOCAL_WORD(lower_d13);
+        LOCAL_WORD(lower_d14);
+        LOCAL_WORD(lower_d15);
+
+       LOCAL_WORD(high_d0);
+        LOCAL_WORD(high_d1);
+        LOCAL_WORD(high_d2);
+        LOCAL_WORD(high_d3);
+        LOCAL_WORD(high_d4);
+        LOCAL_WORD(high_d5);
+        LOCAL_WORD(high_d6);
+        LOCAL_WORD(high_d7);
+        LOCAL_WORD(high_d8);
+        LOCAL_WORD(high_d9);
+        LOCAL_WORD(high_d10);
+        LOCAL_WORD(high_d11);
+        LOCAL_WORD(high_d12);
+        LOCAL_WORD(high_d13);
+        LOCAL_WORD(high_d14);
+        LOCAL_WORD(high_d15);
+
+/*
+ * non volatile fpu registers
+ * s16 - s31
+ */
+       /* XXX:TBD */
+
+FUNC(swsusp_arch_suspend)
+
+       ldr     r2, .Llower_d0
+       ldr     r3, .Lhigh_d0
+
+       /* save NEON and VFP registers */
+       fmrrd   r0, r1, d0
+       str     r0, [r2]
+       str     r1, [r3]
+
+       ldr     r2, .Llower_d1
+       ldr     r3, .Lhigh_d1
+       SAVE_VFP_REG(1)
+       SAVE_VFP_REG(2)
+        SAVE_VFP_REG(3)
+        SAVE_VFP_REG(4)
+        SAVE_VFP_REG(5)
+        SAVE_VFP_REG(6)
+        SAVE_VFP_REG(7)
+        SAVE_VFP_REG(8)
+        SAVE_VFP_REG(9)
+        SAVE_VFP_REG(10)
+        SAVE_VFP_REG(11)
+        SAVE_VFP_REG(12)
+        SAVE_VFP_REG(13)
+        SAVE_VFP_REG(14)
+        SAVE_VFP_REG(15)
+
+       /* save current program status register */
+       ldr     r3, .Lsaved_cpsr
+       mrs     r1, cpsr
+       str     r1, [r3]
+
+       /* hold current mode */
+       mrs     r0, cpsr
+
+       CHANGE_MODE(1f) /* change to system(user) mode */
+       /* save nonvolatile int register */
+       ldr     r3, .Lsaved_context_r0
+       stmia   r3, {r0-r14}
+
+       /* Save NEON and VFP System registers */
+       /* First read FPEXC and check whether bit no. 30 is 1 (enabled) or 0 (disabled) */
+       FMRX    r3, FPEXC
+       ldr     r1, .Lsaved_fpexc
+       str     r3, [r1]
+       bic     r3, r3, #0x80000000
+       cmp     r3, #0
+       beq     .Lnext
+       FMRX    r3, FPSCR
+       ldr     r1, .Lsaved_fpscr
+       str     r3, [r1]
+
+.Lnext:
+       CHANGE_MODE(11) /* change to fiq mode */
+       /* save nonvolatile int register */
+       ldr     r3, .Lsaved_context_r8_fiq
+       stmia   r3, {r8-r14}
+       /* save spsr_fiq register */
+       ldr     r3, .Lsaved_spsr_fiq
+       mrs     r1, spsr
+       str     r1, [r3]
+
+       CHANGE_MODE(12) /* change to irq mode */
+       /* save nonvolatile int register */
+       ldr     r3, .Lsaved_context_r13_irq
+       stmia   r3, {r13-r14}
+       /* save spsr_irq register */
+       ldr     r3, .Lsaved_spsr_irq
+       mrs     r1, spsr
+       str     r1, [r3]
+
+       CHANGE_MODE(13) /* change to svc mode */
+       /* save nonvolatile int register */
+       ldr     r3, .Lsaved_context_r13_svc
+       stmia   r3, {r13-r14}
+       /* save spsr_svc register */
+       ldr     r3, .Lsaved_spsr_svc
+       mrs     r1, spsr
+       str     r1, [r3]
+
+       CHANGE_MODE(17) /* change to abt mode */
+       /* save nonvolatile int register */
+       ldr     r3, .Lsaved_context_r13_abt
+       stmia   r3, {r13-r14}
+       /* save spsr_abt register */
+       ldr     r3, .Lsaved_spsr_abt
+       mrs     r1, spsr
+       str     r1, [r3]
+
+       CHANGE_MODE(1b) /* change to und mode */
+       /* save nonvolatile int register */
+       ldr     r3, .Lsaved_context_r13_und
+       stmia   r3, {r13-r14}
+       /* save spsr_und register */
+       ldr     r3, .Lsaved_spsr_und
+       mrs     r1, spsr
+       str     r1, [r3]
+
+       /* go back to original mode */
+       msr     cpsr_c, r0
+
+       /*
+        * save nonvolatile fp registers
+        * and fp status/system registers, if needed
+        */
+       /* XXX:TBD */
+
+       /* call swsusp_save */
+       bl      swsusp_save
+
+       /* restore return address */
+       ldr     r3, .Lsaved_context_r14_svc
+       ldr     lr, [r3]
+       mov     pc, lr
+
+       WORD_ADDR(saved_context_r0)
+       WORD_ADDR(saved_cpsr)
+       WORD_ADDR(saved_context_r8_fiq)
+       WORD_ADDR(saved_spsr_fiq)
+       WORD_ADDR(saved_context_r13_irq)
+       WORD_ADDR(saved_spsr_irq)
+       WORD_ADDR(saved_context_r13_svc)
+       WORD_ADDR(saved_context_r14_svc)
+       WORD_ADDR(saved_spsr_svc)
+       WORD_ADDR(saved_context_r13_abt)
+       WORD_ADDR(saved_spsr_abt)
+       WORD_ADDR(saved_context_r13_und)
+       WORD_ADDR(saved_spsr_und)
+
+       WORD_ADDR(saved_fpscr)
+       WORD_ADDR(saved_fpexc)
+
+       WORD_ADDR(lower_d0)
+       WORD_ADDR(high_d0)
+       WORD_ADDR(lower_d1)
+       WORD_ADDR(high_d1)
+
+FUNC_END(swsusp_arch_suspend)
+
+FUNC(swsusp_arch_resume)
+
+       /* Set page table if needed */
+
+       /* restore_pblist is the starting point for loaded pages */
+       ldr     r0, .Lrestore_pblist
+       ldr     r6, [r0]
+
+.Lcopy_loop:
+       ldr     r4, [r6]     /* src IOW present address */
+       ldr     r5, [r6, #4] /* dst IOW original address*/
+       mov     r9, #1024    /* No. of entries in one page, where each entry is 4 bytes */
+
+       /* this loop could be optimized by using stm and ldm. */
+.Lcopy_one_page:
+       ldr     r8, [r4]
+       str     r8, [r5]
+
+       add     r4, r4, #4
+       add     r5, r5, #4
+       sub     r9, r9, #1
+       cmp     r9, #0
+       bne     .Lcopy_one_page
+
+       ldr     r6, [r6, #8] /* The last field of struct pbe is a pointer to the next pbe structure */
+       cmp     r6, #0
+       bne     .Lcopy_loop
+
+       /* Restore Neon and VFP Registers */
+       ldr     r2, .Llower_d0
+       ldr     r3, .Lhigh_d0
+
+       ldr     r0, [r2]
+       ldr     r1, [r3]
+       fmdrr   d0, r0, r1
+
+       ldr     r2, .Llower_d1
+       ldr     r3, .Lhigh_d1
+
+       RESTORE_VFP_REG(1)
+        RESTORE_VFP_REG(2)
+        RESTORE_VFP_REG(3)
+        RESTORE_VFP_REG(4)
+        RESTORE_VFP_REG(5)
+        RESTORE_VFP_REG(6)
+        RESTORE_VFP_REG(7)
+        RESTORE_VFP_REG(8)
+        RESTORE_VFP_REG(9)
+        RESTORE_VFP_REG(10)
+        RESTORE_VFP_REG(11)
+        RESTORE_VFP_REG(12)
+        RESTORE_VFP_REG(13)
+        RESTORE_VFP_REG(14)
+        RESTORE_VFP_REG(15)
+       /* hold current mode */
+       mrs     r0, cpsr
+
+       CHANGE_MODE(1f) /* change to system(user) mode */
+       /* Restore NEON and VFP system control registers */
+       ldr     r3, .Lsaved_fpexc
+       ldr     r1, [r3]
+       FMXR    FPEXC, r1
+       bic     r1, r1, #0x80000000
+       cmp     r1, #0
+       beq     .Lnext_restore
+       ldr     r3, .Lsaved_fpscr
+       ldr     r1, [r3]
+       FMXR    FPSCR, r1
+
+.Lnext_restore:
+       /* restore nonvolatile int register */
+       ldr     r3, .Lsaved_context_r0
+       ldmia   r3, {r0-r14}
+       /* restore current program status register */
+       ldr     r3, .Lsaved_cpsr
+       ldr     r1, [r3]
+       msr     cpsr_cxsf, r1
+
+       CHANGE_MODE(11) /* change to fiq mode */
+       /* restore nonvolatile int register */
+       ldr     r3, .Lsaved_context_r8_fiq
+       ldmia   r3, {r8-r14}
+       /* restore spsr_fiq register */
+       ldr     r3, .Lsaved_spsr_fiq
+       ldr     r1, [r3]
+       msr     spsr_cxsf, r1
+
+       CHANGE_MODE(12) /* change to irq mode */
+       /* restore nonvolatile int register */
+       ldr     r3, .Lsaved_context_r13_irq
+       ldmia   r3, {r13-r14}
+       /* restore spsr_irq register */
+       ldr     r3, .Lsaved_spsr_irq
+       ldr     r1, [r3]
+       msr     spsr_cxsf, r1
+
+       CHANGE_MODE(13) /* change to svc mode */
+       /* restore nonvolatile int register */
+       ldr     r3, .Lsaved_context_r13_svc
+       ldmia   r3, {r13-r14}
+     /*  ldr     r13, [r3] */
+       /* restore spsr_svc register */
+       ldr     r3, .Lsaved_spsr_svc
+       ldr     r1, [r3]
+       msr     spsr_cxsf, r1
+
+       CHANGE_MODE(17) /* change to abt mode */
+       /* restore nonvolatile int register */
+       ldr     r3, .Lsaved_context_r13_abt
+       ldmia   r3, {r13-r14}
+       /* restore spsr_abt register */
+       ldr     r3, .Lsaved_spsr_abt
+       ldr     r1, [r3]
+       msr     spsr_cxsf, r1
+
+       CHANGE_MODE(1b) /* change to und mode */
+       /* restore nonvolatile int register */
+       ldr     r3, .Lsaved_context_r13_und
+       ldmia   r3, {r13-r14}
+       /* restore spsr_und register */
+       ldr     r3, .Lsaved_spsr_und
+       ldr     r1, [r3]
+       msr     spsr_cxsf, r1
+
+       /* go back to original mode */
+       msr     cpsr_c, r0
+
+       /* Flush TLB (Invalidate unified TLB unlocked entries) */
+       mov     r1, #0
+       mcr     p15, 0, r1, c8, c7, 0
+
+       /* restore return address */
+       ldr     r3, .Lsaved_context_r14_svc
+       ldr     lr, [r3]
+       mov     pc, lr
+
+.Lrestore_pblist:
+       .word restore_pblist
+
+FUNC_END(swsusp_arch_resume)
diff -purN 12x_old/.config_mindrivers 12x_git/.config_mindrivers
--- 12x_old/.config_mindrivers  1970-01-01 05:30:00.000000000 +0530
+++ 12x_git/.config_mindrivers  2009-06-30 11:05:16.000000000 +0530
@@ -0,0 +1,1211 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.24.7-omap1-arm2
+# Tue Jun 16 11:50:46 2009
+#
+CONFIG_ARM=y
+CONFIG_SYS_SUPPORTS_APM_EMULATION=y
+CONFIG_GENERIC_GPIO=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+# CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+CONFIG_HARDIRQS_SW_RESEND=y
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+# CONFIG_ARCH_HAS_ILOG2_U32 is not set
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_ZONE_DMA=y
+CONFIG_VECTORS_BASE=0xffff0000
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# General setup
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+# CONFIG_POSIX_MQUEUE is not set
+CONFIG_BSD_PROCESS_ACCT=y
+# CONFIG_BSD_PROCESS_ACCT_V3 is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_FAIR_USER_SCHED=y
+# CONFIG_FAIR_CGROUP_SCHED is not set
+CONFIG_SYSFS_DEPRECATED=y
+# CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+CONFIG_UID16=y
+# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_MODVERSIONS=y
+CONFIG_MODULE_SRCVERSION_ALL=y
+CONFIG_KMOD=y
+CONFIG_BLOCK=y
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
+
+#
+# System Type
+#
+CONFIG_MMU=y
+# CONFIG_ARCH_AAEC2000 is not set
+# CONFIG_ARCH_INTEGRATOR is not set
+# CONFIG_ARCH_REALVIEW is not set
+# CONFIG_ARCH_VERSATILE is not set
+# CONFIG_ARCH_AT91 is not set
+# CONFIG_ARCH_CLPS7500 is not set
+# CONFIG_ARCH_CLPS711X is not set
+# CONFIG_ARCH_CO285 is not set
+# CONFIG_ARCH_EBSA110 is not set
+# CONFIG_ARCH_EP93XX is not set
+# CONFIG_ARCH_FOOTBRIDGE is not set
+# CONFIG_ARCH_NETX is not set
+# CONFIG_ARCH_H720X is not set
+# CONFIG_ARCH_IMX is not set
+# CONFIG_ARCH_IOP13XX is not set
+# CONFIG_ARCH_IOP32X is not set
+# CONFIG_ARCH_IOP33X is not set
+# CONFIG_ARCH_IXP23XX is not set
+# CONFIG_ARCH_IXP2000 is not set
+# CONFIG_ARCH_IXP4XX is not set
+# CONFIG_ARCH_L7200 is not set
+# CONFIG_ARCH_KS8695 is not set
+# CONFIG_ARCH_NS9XXX is not set
+# CONFIG_ARCH_MXC is not set
+# CONFIG_ARCH_PNX4008 is not set
+# CONFIG_ARCH_PXA is not set
+# CONFIG_ARCH_RPC is not set
+# CONFIG_ARCH_SA1100 is not set
+# CONFIG_ARCH_S3C2410 is not set
+# CONFIG_ARCH_SHARK is not set
+# CONFIG_ARCH_LH7A40X is not set
+# CONFIG_ARCH_DAVINCI is not set
+CONFIG_ARCH_OMAP=y
+
+#
+# TI OMAP Implementations
+#
+CONFIG_ARCH_OMAP_OTG=y
+# CONFIG_ARCH_OMAP1 is not set
+# CONFIG_ARCH_OMAP2 is not set
+CONFIG_ARCH_OMAP3=y
+
+#
+# OMAP Feature Selections
+#
+CONFIG_OMAP_DEBUG_SRAM_PATCH=y
+CONFIG_OMAP_RESET_CLOCKS=y
+CONFIG_OMAP_BOOT_TAG=y
+CONFIG_OMAP_BOOT_REASON=y
+# CONFIG_OMAP_COMPONENT_VERSION is not set
+# CONFIG_OMAP_GPIO_SWITCH is not set
+CONFIG_OMAP_MUX=y
+CONFIG_OMAP_MUX_DEBUG=y
+CONFIG_OMAP_MUX_WARNINGS=y
+# CONFIG_OMAP_MMU_FWK is not set
+# CONFIG_OMAP_MBOX_FWK is not set
+# CONFIG_OMAP_MPU_TIMER is not set
+CONFIG_OMAP_32K_TIMER=y
+CONFIG_OMAP_32K_TIMER_HZ=128
+CONFIG_OMAP_DM_TIMER=y
+CONFIG_OMAP_LL_DEBUG_UART1=y
+# CONFIG_OMAP_LL_DEBUG_UART2 is not set
+# CONFIG_OMAP_LL_DEBUG_UART3 is not set
+CONFIG_OMAP_SERIAL_WAKE=y
+# CONFIG_HS_SERIAL_SUPPORT is not set
+# CONFIG_OMAP_DSI is not set
+CONFIG_OMAP_DMA_LIBRARY_CHANNELS=24
+# CONFIG_OMAP3430_ENABLE_SPI2_PIN_MUX is not set
+CONFIG_ARCH_OMAP34XX=y
+CONFIG_ARCH_OMAP3430=y
+CONFIG_OMAP3430_ES2=y
+# CONFIG_ARCH_OMAP3410 is not set
+
+#
+# OMAP Board Type
+#
+CONFIG_MACH_OMAP_3430SDP=y
+# CONFIG_MACH_OMAP_3430LABRADOR is not set
+# CONFIG_INTERCONNECT_IO_POSTING is not set
+CONFIG_OMAP3_PM=y
+CONFIG_OMAP_VOLT_SR_BYPASS=y
+# CONFIG_OMAP_VOLT_SR is not set
+# CONFIG_OMAP_VOLT_VSEL is not set
+# CONFIG_OMAP_VOLT_VMODE is not set
+CONFIG_OMAP3ES2_VDD1_OPP1=y
+# CONFIG_OMAP3ES2_VDD1_OPP2 is not set
+# CONFIG_OMAP3ES2_VDD1_OPP3 is not set
+# CONFIG_OMAP3ES2_VDD1_OPP4 is not set
+# CONFIG_OMAP3ES2_VDD1_OPP5 is not set
+# CONFIG_OMAP3_CORE_133MHZ is not set
+CONFIG_OMAP3_CORE_166MHZ=y
+CONFIG_OMAP3ES2_VDD2_OPP2=y
+CONFIG_OMAP3ES2_VDD2_OPP2_L3_83MHZ=y
+# CONFIG_OMAP3ES2_VDD2_OPP3_L3_166MHZ is not set
+# CONFIG_OMAP3ES2_VDD2_OPP2_L3_66MHZ is not set
+# CONFIG_OMAP3ES2_VDD2_OPP3_L3_133MHZ is not set
+# CONFIG_ENABLE_VOLTSCALE_IN_SUSPEND is not set
+CONFIG_MPU_OFF=y
+CONFIG_OMAP34XX_OFFMODE=y
+CONFIG_CORE_OFF=y
+CONFIG_CORE_OFF_CPUIDLE=y
+# CONFIG_SYSOFFMODE is not set
+CONFIG_HW_SUP_TRANS=y
+# CONFIG_TRACK_RESOURCES is not set
+CONFIG_AUTO_POWER_DOMAIN_CTRL=y
+# CONFIG_PREVENT_MPU_RET is not set
+# CONFIG_PREVENT_CORE_RET is not set
+CONFIG_DISABLE_EMUDOMAIN_CONTROL=y
+# CONFIG_ENABLE_SWLATENCY_MEASURE is not set
+# CONFIG_ENABLE_OFF_MODE_JTAG_ETM_DEBUG is not set
+
+#
+# Boot options
+#
+
+#
+# Power management
+#
+
+#
+# Processor Type
+#
+CONFIG_CPU_32=y
+CONFIG_CPU_32v6K=y
+CONFIG_CPU_V7=y
+CONFIG_CPU_32v7=y
+CONFIG_CPU_ABRT_EV7=y
+CONFIG_CPU_PABRT_IFAR=y
+CONFIG_CPU_CACHE_V7=y
+CONFIG_CPU_CACHE_VIPT=y
+CONFIG_CPU_COPY_V6=y
+CONFIG_CPU_TLB_V7=y
+CONFIG_CPU_HAS_ASID=y
+CONFIG_CPU_CP15=y
+CONFIG_CPU_CP15_MMU=y
+
+#
+# Processor Features
+#
+CONFIG_ARM_THUMB=y
+# CONFIG_ARM_THUMBEE is not set
+# CONFIG_CPU_ICACHE_DISABLE is not set
+# CONFIG_CPU_DCACHE_DISABLE is not set
+# CONFIG_CPU_LOCKDOWN_TO_64K_L2 is not set
+# CONFIG_CPU_LOCKDOWN_TO_128K_L2 is not set
+CONFIG_CPU_LOCKDOWN_TO_256K_L2=y
+CONFIG_CPU_USER_L2_PLE_ACCESS=y
+# CONFIG_CPU_L2CACHE_DISABLE is not set
+# CONFIG_CPU_BPREDICT_DISABLE is not set
+CONFIG_HAS_TLS_REG=y
+# CONFIG_OUTER_CACHE is not set
+CONFIG_ARM_ERRATA_430973=y
+CONFIG_ARM_ERRATA_451027=y
+# CONFIG_ARM_ERRATA_458693 is not set
+# CONFIG_ARM_ERRATA_460075 is not set
+
+#
+# Bus support
+#
+# CONFIG_PCI_SYSCALL is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+# CONFIG_PCCARD is not set
+
+#
+# Kernel Features
+#
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+CONFIG_PREEMPT=y
+CONFIG_HZ=128
+# CONFIG_THUMB2_KERNEL is not set
+# CONFIG_ARM_ASM_UNIFIED is not set
+CONFIG_AEABI=y
+CONFIG_OABI_COMPAT=y
+# CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
+# CONFIG_LEDS is not set
+CONFIG_ALIGNMENT_TRAP=y
+
+#
+# Boot options
+#
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_CMDLINE="root=/dev/nfs nfsroot=192.168.0.1:/home/user/buildroot ip=192.168.0.2:192.168.0.1:192.168.0.1:255.255.255.0:tgt:eth0:off rw console=ttyS2,115200n8"
+# CONFIG_XIP_KERNEL is not set
+# CONFIG_KEXEC is not set
+
+#
+# CPU Frequency scaling
+#
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_TABLE=y
+# CONFIG_CPU_FREQ_DEBUG is not set
+CONFIG_CPU_FREQ_STAT=y
+# CONFIG_CPU_FREQ_STAT_DETAILS is not set
+CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
+# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
+# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
+# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
+CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
+# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
+# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
+CONFIG_OPROFILE_ARMV7=y
+
+#
+# CPUIdle
+#
+
+#
+# CPI idle PM support
+#
+CONFIG_CPU_IDLE=y
+
+#
+# Governors
+#
+# CONFIG_CPU_IDLE_GOV_LADDER is not set
+CONFIG_CPU_IDLE_GOV_MENU=y
+
+#
+# Floating point emulation
+#
+
+#
+# At least one emulation must be selected
+#
+CONFIG_FPE_NWFPE=y
+# CONFIG_FPE_NWFPE_XP is not set
+# CONFIG_FPE_FASTFPE is not set
+CONFIG_VFP=y
+CONFIG_VFPv3=y
+CONFIG_NEON=y
+CONFIG_NEON_CACHE_BUG=y
+
+#
+# Userspace binary formats
+#
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_AOUT is not set
+CONFIG_BINFMT_MISC=y
+
+#
+# Power management options
+#
+CONFIG_PM=y
+# CONFIG_PM_LEGACY is not set
+CONFIG_PM_DEBUG=y
+CONFIG_PM_VERBOSE=y
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND_UP_POSSIBLE=y
+CONFIG_SUSPEND=y
+CONFIG_HIBERNATION_UP_POSSIBLE=y
+CONFIG_HIBERNATION=y
+CONFIG_PM_STD_PARTITION=""
+# CONFIG_SWSUSP_MTDBLOCK_FLUSH is not set
+# CONFIG_APM_EMULATION is not set
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+CONFIG_NET_KEY=y
+# CONFIG_NET_KEY_MIGRATE is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+# CONFIG_INET_LRO is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+CONFIG_CFG80211=y
+CONFIG_NL80211=y
+CONFIG_WIRELESS_EXT=y
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+# CONFIG_MTD_AFS_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+CONFIG_MTD_CFI_INTELEXT=y
+# CONFIG_MTD_CFI_AMDSTD is not set
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+# CONFIG_MTD_ARM_INTEGRATOR is not set
+CONFIG_MTD_OMAP_NOR=y
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+# CONFIG_MTD_NAND_ECC_SMC is not set
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+CONFIG_MTD_NAND_OMAP2=y
+CONFIG_MTD_NAND_OMAP_HWECC=y
+CONFIG_MTD_NAND_OMAP_PREFETCH=y
+CONFIG_MTD_NAND_OMAP_PREFETCH_MPU=y
+# CONFIG_MTD_NAND_OMAP_PREFETCH_DMA is not set
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
+CONFIG_MTD_ONENAND=y
+CONFIG_MTD_ONENAND_VERIFY_WRITE=y
+# CONFIG_MTD_ONENAND_GENERIC is not set
+CONFIG_MTD_ONENAND_OMAP2=y
+# CONFIG_MTD_ONENAND_OTP is not set
+# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
+# CONFIG_MTD_ONENAND_SIM is not set
+CONFIG_MTD_ONENAND_SYNC_BURST_READ=y
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=16384
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_EEPROM_93CX6 is not set
+CONFIG_TWL4030_MADC=y
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_ATA is not set
+# CONFIG_MD is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+# CONFIG_PHYLIB is not set
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_AX88796 is not set
+CONFIG_SMC91X=y
+# CONFIG_DM9000 is not set
+# CONFIG_SMC911X is not set
+# CONFIG_SMSC911X is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_B44 is not set
+CONFIG_NETDEV_1000=y
+CONFIG_NETDEV_10000=y
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_ISDN is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_OMAP=y
+CONFIG_SERIAL_OMAP_CONSOLE=y
+# CONFIG_SERIAL_OMAP_DMA_UART1 is not set
+CONFIG_SERIAL_OMAP_DMA_UART2=y
+CONFIG_SERIAL_OMAP_UART2_RXDMA_TIMEOUT=1
+CONFIG_SERIAL_OMAP_UART2_RXDMA_BUFSIZE=4096
+# CONFIG_SERIAL_OMAP_DMA_UART3 is not set
+# CONFIG_UNIX98_PTYS is not set
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_NVRAM is not set
+# CONFIG_R3964 is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_CHARDEV=y
+
+#
+# I2C Algorithms
+#
+# CONFIG_I2C_ALGOBIT is not set
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_GPIO is not set
+# CONFIG_I2C_OCORES is not set
+CONFIG_I2C_OMAP=y
+
+#
+# OMAP34XX HS I2C buses
+#
+CONFIG_I2C_OMAP34XX_HS_BUS1=2600
+CONFIG_I2C_OMAP34XX_HS_BUS2=100
+CONFIG_I2C_OMAP34XX_HS_BUS3=400
+CONFIG_OMAP_I2C_SLAVE=y
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_STUB is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_SENSORS_DS1337 is not set
+# CONFIG_SENSORS_DS1374 is not set
+# CONFIG_DS1682 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_ISP1301_OMAP is not set
+# CONFIG_TPS65010 is not set
+# CONFIG_SENSORS_TLV320AIC23 is not set
+CONFIG_TWL4030_CORE=y
+CONFIG_TWL4030_DBG_SYSFS=y
+CONFIG_TWL4030_IRQ_PRIO=26
+CONFIG_TWL4030_GPIO=y
+CONFIG_TWL4030_USB=y
+CONFIG_TWL4030_USB_HS_ULPI=y
+# CONFIG_TWL4030_DETECT_USB_CABLE_TYPE is not set
+# CONFIG_TWL4030_POWEROFF is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+
+#
+# SPI support
+#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+CONFIG_W1=y
+
+#
+# 1-wire Bus Masters
+#
+# CONFIG_W1_MASTER_DS2482 is not set
+# CONFIG_W1_MASTER_DS1WM is not set
+CONFIG_HDQ_MASTER_OMAP=y
+
+#
+# 1-wire Slaves
+#
+# CONFIG_W1_SLAVE_THERM is not set
+# CONFIG_W1_SLAVE_SMEM is not set
+# CONFIG_W1_SLAVE_DS2433 is not set
+# CONFIG_W1_SLAVE_DS2760 is not set
+CONFIG_W1_SLAVE_BQ27000=y
+CONFIG_POWER_SUPPLY=y
+# CONFIG_POWER_SUPPLY_DEBUG is not set
+# CONFIG_PDA_POWER is not set
+# CONFIG_BATTERY_DS2760 is not set
+CONFIG_TWL4030_BCI_BATTERY=y
+CONFIG_BATTERY_BQ27000=y
+# CONFIG_HWMON is not set
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+# CONFIG_DAB is not set
+
+#
+# Graphics support
+#
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+# CONFIG_FB is not set
+# CONFIG_FB_OMAP_LCD_VGA is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+# CONFIG_HID_SUPPORT is not set
+# CONFIG_USB_SUPPORT is not set
+
+#
+# Synchronous Serial Interfaces (SSI)
+#
+# CONFIG_OMAP_MCBSP is not set
+
+#
+# McBSP fifo support
+#
+CONFIG_USE_MCBSP_FIFO=y
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+CONFIG_MMC_UNSAFE_RESUME=y
+
+#
+# MMC/SD Card Drivers
+#
+CONFIG_MMC_BLOCK=y
+CONFIG_MMC_BLOCK_BOUNCE=y
+# CONFIG_SDIO_UART is not set
+
+#
+# MMC/SD Host Controller Drivers
+#
+CONFIG_MMC_OMAP_HS=y
+CONFIG_OMAP_HS_MMC1=y
+# CONFIG_OMAP_HS_MMC2 is not set
+# CONFIG_OMAP_SDIO_NON_DMA_MODE is not set
+# CONFIG_NEW_LEDS is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
+# CONFIG_RTC_DRV_DS1307 is not set
+# CONFIG_RTC_DRV_DS1374 is not set
+# CONFIG_RTC_DRV_DS1672 is not set
+# CONFIG_RTC_DRV_MAX6900 is not set
+# CONFIG_RTC_DRV_RS5C372 is not set
+# CONFIG_RTC_DRV_ISL1208 is not set
+# CONFIG_RTC_DRV_X1205 is not set
+# CONFIG_RTC_DRV_PCF8563 is not set
+# CONFIG_RTC_DRV_PCF8583 is not set
+# CONFIG_RTC_DRV_M41T80 is not set
+CONFIG_RTC_DRV_TWL4030=y
+
+#
+# SPI RTC drivers
+#
+
+#
+# Platform RTC drivers
+#
+# CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
+
+#
+# CBUS support
+#
+# CONFIG_CBUS is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_FS_XATTR is not set
+# CONFIG_EXT4DEV_FS is not set
+CONFIG_JBD=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+CONFIG_QUOTA=y
+# CONFIG_QUOTA_NETLINK_INTERFACE is not set
+CONFIG_PRINT_QUOTA_WARNING=y
+# CONFIG_QFMT_V1 is not set
+CONFIG_QFMT_V2=y
+CONFIG_QUOTACTL=y
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_XATTR is not set
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
+# CONFIG_JFFS2_LZO is not set
+CONFIG_JFFS2_RTIME=y
+# CONFIG_JFFS2_RUBIN is not set
+# CONFIG_JFFS2_CMODE_NONE is not set
+CONFIG_JFFS2_CMODE_PRIORITY=y
+# CONFIG_JFFS2_CMODE_SIZE is not set
+# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+CONFIG_NFS_V4=y
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+# CONFIG_SUNRPC_BIND34 is not set
+CONFIG_RPCSEC_GSS_KRB5=y
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_BSD_DISKLABEL is not set
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_SYSV68_PARTITION is not set
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+# CONFIG_NLS_ASCII is not set
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
+# CONFIG_DLM is not set
+CONFIG_INSTRUMENTATION=y
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
+# CONFIG_SCHEDSTATS is not set
+CONFIG_TIMER_STATS=y
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_PREEMPT is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+CONFIG_DEBUG_MUTEXES=y
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_BUGVERBOSE is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+CONFIG_FRAME_POINTER=y
+CONFIG_FORCED_INLINING=y
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_SAMPLES is not set
+# CONFIG_WANT_EXTRA_DEBUG_INFORMATION is not set
+# CONFIG_UNWIND_INFO is not set
+# CONFIG_KGDB is not set
+# CONFIG_DEBUG_USER is not set
+# CONFIG_DEBUG_ERRORS is not set
+# CONFIG_DEBUG_LL is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_MANAGER=y
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_PCBC=m
+# CONFIG_CRYPTO_LRW is not set
+# CONFIG_CRYPTO_XTS is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
+# CONFIG_CRYPTO_TEST is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+CONFIG_CRYPTO_HW=y
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+CONFIG_CRC_CCITT=y
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
+CONFIG_LIBCRC32C=y
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
diff -purN 12x_git/drivers/mmc/core/core.c 2.6.24.7-linux/drivers/mmc/core/core.c
--- 12x_git/drivers/mmc/core/core.c     2009-07-08 12:15:46.000000000 +0530
+++ 2.6.24.7-linux/drivers/mmc/core/core.c      2009-07-09 09:55:43.000000000 +0530
@@ -619,8 +619,8 @@ void mmc_detect_change(struct mmc_host *
        WARN_ON(host->removed);
        spin_unlock_irqrestore(&host->lock, flags);
 #endif
-
-       mmc_schedule_delayed_work(&host->detect, delay);
+       mmc_rescan(&host->detect.work);
+       //mmc_schedule_delayed_work(&host->detect, delay);
 }

 EXPORT_SYMBOL(mmc_detect_change);
@@ -688,6 +688,7 @@ void mmc_rescan(struct work_struct *work
                mmc_bus_put(host);
        }
 }
+EXPORT_SYMBOL(mmc_rescan);

 void mmc_start_host(struct mmc_host *host)
 {
diff -purN 12x_git/drivers/mmc/host/omap_hsmmc.c 2.6.24.7-linux/drivers/mmc/host/omap_hsmmc.c
--- 12x_git/drivers/mmc/host/omap_hsmmc.c       2009-07-08 12:15:46.000000000 +0530
+++ 2.6.24.7-linux/drivers/mmc/host/omap_hsmmc.c        2009-07-09 10:14:46.000000000 +0530
@@ -139,6 +137,8 @@
 static int bytec;
 #endif

+extern void mmc_rescan(struct work_struct *);
+
 struct mmc_omap_host {
        struct  device          *dev;
        struct  mmc_host        *mmc;
@@ -1398,7 +1395,8 @@ static int __init omap_mmc_probe(struct

        platform_set_drvdata(pdev, host);
        mmc_add_host(mmc);
-
+       cancel_delayed_work(&mmc->detect.work);
+        mmc_rescan(&mmc->detect.work);
        return 0;

 err:
diff -purN 12x_old/include/asm-arm/page.h 12x_git/include/asm-arm/page.h
--- 12x_old/include/asm-arm/page.h      2009-06-30 14:29:37.000000000 +0530
+++ 12x_git/include/asm-arm/page.h      2009-06-30 11:26:56.000000000 +0530
@@ -178,6 +178,8 @@ typedef unsigned long pgprot_t;

 #include <asm/memory.h>

+#define __pa_symbol(x) __pa(RELOC_HIDE((unsigned long)(x),0))
+
 #endif /* !__ASSEMBLY__ */

 #define VM_DATA_DEFAULT_FLAGS  (VM_READ | VM_WRITE | VM_EXEC | \
diff -purN 12x_old/include/asm-arm/suspend.h 12x_git/include/asm-arm/suspend.h
--- 12x_old/include/asm-arm/suspend.h   2009-06-30 14:29:37.000000000 +0530
+++ 12x_git/include/asm-arm/suspend.h   2009-06-30 11:14:10.000000000 +0530
@@ -1,4 +1,81 @@
 #ifndef _ASMARM_SUSPEND_H
 #define _ASMARM_SUSPEND_H

+/*
+ * Based on code include/asm-i386/suspend.h
+ * Copyright 2001-2002 Pavel Machek <pavel@suse.cz>
+ * Copyright 2001 Patrick Mochel <mochel@osdl.org>
+ */
+
+#include <asm/types.h>
+
+static inline int
+arch_prepare_suspend(void)
+{
+       return 0;
+}
+
+/* image of the saved processor state */
+struct saved_context {
+       /*
+        * Structure saved_context would be used to hold processor state
+        * except caller and callee registers, just before suspending.
+        */
+
+       /* coprocessor 15 registers */
+//     __u32 ID_code;    /* read only reg */
+//     __u32 cache_type; /* read only reg */
+//     __u32 TCM_stat;   /* read only reg */
+       __u32 CR;
+       __u32 DACR;
+       __u32 D_FSR;
+       __u32 I_FSR;
+       __u32 D_FAR;
+       __u32 I_FAR;
+//     __u32 COR;    /*write only reg */
+//     __u32 TLBOR;  /*write only reg */
+       __u32 D_CLR;
+       __u32 I_CLR;
+       __u32 D_TCMRR;
+       __u32 I_TCMRR;
+       __u32 D_TLBLR;
+       __u32 FCSE;
+       __u32 CID;
+       __u32 CSSR;
+       __u32 CACR;
+       __u32 TTB_0R;
+       __u32 TTB_1R;
+       __u32 TTBCR;
+       __u32 D_AFSR;
+       __u32 I_AFSR;
+       __u32 PAR;
+       __u32 PMControlR;
+       __u32 CESR;
+       __u32 CECR;
+       __u32 OFSR;
+       __u32 SIR;
+       __u32 PCSR;
+       __u32 CCR;
+       __u32 ESR;
+       __u32 PMCountR;
+       __u32 UER;
+       __u32 IESR;
+       __u32 IECR;
+       __u32 L2CLR;
+       __u32 I_TLBLR;
+       __u32 PRRR;
+       __u32 NRRR;
+       __u32 PLEUAR;
+       __u32 PLECNR;
+       __u32 PLECR;
+       __u32 PLEISAR;
+       __u32 PLEIEAR;
+       __u32 PLECIDR;
+       __u32 SNSVBAR;
+       __u32 URWTPID;
+       __u32 UROTPID;
+       __u32 POTPID;
+       __u32 r0;
+} __attribute__((packed));
+
 #endif
diff -purN 12x_old/kernel/power/disk.c 12x_git/kernel/power/disk.c
--- 12x_old/kernel/power/disk.c 2009-06-30 14:29:37.000000000 +0530
+++ 12x_git/kernel/power/disk.c 2009-06-30 11:14:50.000000000 +0530
@@ -21,6 +21,7 @@
 #include <linux/console.h>
 #include <linux/cpu.h>
 #include <linux/freezer.h>
+#include <asm/suspend.h>

 #include "power.h"

diff -purN 12x_old/kernel/power/Kconfig 12x_git/kernel/power/Kconfig
--- 12x_old/kernel/power/Kconfig        2009-06-30 14:29:37.000000000 +0530
+++ 12x_git/kernel/power/Kconfig        2009-06-30 11:10:36.000000000 +0530
@@ -99,7 +99,7 @@ config SUSPEND

 config HIBERNATION_UP_POSSIBLE
        bool
-       depends on X86 || PPC64_SWSUSP || PPC32
+       depends on X86 || PPC64_SWSUSP || PPC32 || ARM
        depends on !SMP
        default y





> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Peter Tseng
> Sent: Monday, May 03, 2010 10:41 AM
> To: Shilimkar, Santosh
> Cc: Kevin Hilman; Cliff Brake; linux-omap@vger.kernel.org
> Subject: Re: ARM suspend to disk?
>
> On 05/01/2010 03:12 AM, Shilimkar, Santosh wrote:
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Kevin
> >> Hilman
> >> Sent: Saturday, May 01, 2010 3:36 AM
> >> To: Cliff Brake
> >> Cc: Peter Tseng; linux-omap@vger.kernel.org
> >> Subject: Re: ARM suspend to disk?
> >>
> >> Cliff Brake <cliff.brake@gmail.com> writes:
> >>
> >>> On Thu, Apr 29, 2010 at 1:58 PM, Kevin Hilman
> >>> <khilman@deeprootsystems.com> wrote:
> >>>
> >>>> What do you expect to gain from suspend-to-disk + snapshot boot that
> >>>> you don't already get from suspend-to-RAM using off-mode?
> >>>>
> >>>> On OMAP, with off-mode enabled, a suspend to RAM puts the entire OMAP
> >>>> into full-chip off, and essentially reboots the ARM when waking up
> >>>> from suspend (or idle) already.
> >>>
> >>> What does the resume process look like in off mode?  Does the resume
> >>> pass through the bootloader?  If so, are the bits that detects resume
> >>> from "off" available in U-boot?
> >>
> >> No, it does not pass through the boot loader.
> >>
> >> In general terms, resume from off-mode is the same to "normal" resume
> (from
> >> retention) except that some additional state has to be restored before
> >> continuing where you left off since the ARM core (as well as most the
> >> OMAP itself) was turned off.
> >>
> > On suspend to disk topic, Raghu under Romit's guidance did a
> > prototype few months back as part of his internship using some of the
> earlier
> > ARM work. The whole system snapshot was stored to the MMC card and one
> > can take that MMC card on another board and continue from where it was
> suspended.
> >
> > We should have these patches somewhere.
> >
>
> It would be interesting to see these. Are you able to find these patches
> somewhere?
>
> Peter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
