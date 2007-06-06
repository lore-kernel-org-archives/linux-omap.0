From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [Patch 3/4] TLB handling functions for V7
Date: Tue, 5 Jun 2007 19:26:48 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701120B44@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

TLB handling functions for  V7 architecture derived from ARM GIT.

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 tlb-v7.S |   88
 1 files changed, 88 insertions(+)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff -purN linux-omap/arch/arm/mm/tlb-v7.S =
val_3430_GIT/arch/arm/mm/tlb-v7.S
--- linux-omap/arch/arm/mm/tlb-v7.S	1969-12-31 18:00:00.000000000 -0600
+++ val_3430_GIT/arch/arm/mm/tlb-v7.S	2007-06-05 15:54:25.000000000 =
-0500
@@ -0,0 +1,88 @@
+/*
+ *  linux/arch/arm/mm/tlb-v7.S
+ *
+ *  Copyright (C) 1997-2002 Russell King
+ *  Modified for ARMv7 by Catalin Marinas
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *  ARM architecture version 6 TLB handling functions.
+ *  These assume a split I/D TLB.
+ */
+#include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/page.h>
+#include <asm/tlbflush.h>
+#include "proc-macros.S"
+
+/*
+ *	v7wbi_flush_user_tlb_range(start, end, vma)
+ *
+ *	Invalidate a range of TLB entries in the specified address space.
+ *
+ *	- start - start address (may not be aligned)
+ *	- end   - end address (exclusive, may not be aligned)
+ *	- vma   - vma_struct describing address range
+ *
+ *	It is assumed that:
+ *	- the "Invalidate single entry" instruction will invalidate
+ *	  both the I and the D TLBs on Harvard-style TLBs
+ */
+ENTRY(v7wbi_flush_user_tlb_range)
+	vma_vm_mm r3, r2			@ get vma->vm_mm
+	mmid	r3, r3				@ get vm_mm->context.id
+	dsb
+	mov	r0, r0, lsr #PAGE_SHIFT		@ align address
+	mov	r1, r1, lsr #PAGE_SHIFT
+	asid	r3, r3				@ mask ASID
+	orr	r0, r3, r0, lsl #PAGE_SHIFT	@ Create initial MVA
+	mov	r1, r1, lsl #PAGE_SHIFT
+	vma_vm_flags r2, r2			@ get vma->vm_flags
+1:
+	mcr	p15, 0, r0, c8, c6, 1		@ TLB invalidate D MVA (was 1)
+	tst	r2, #VM_EXEC			@ Executable area ?
+	mcrne	p15, 0, r0, c8, c5, 1		@ TLB invalidate I MVA (was 1)
+	add	r0, r0, #PAGE_SZ
+	cmp	r0, r1
+	blo	1b
+	mov	ip, #0
+	mcr	p15, 0, ip, c7, c5, 6		@ flush BTAC/BTB
+	dsb
+	mov	pc, lr
+
+/*
+ *	v7wbi_flush_kern_tlb_range(start,end)
+ *
+ *	Invalidate a range of kernel TLB entries
+ *
+ *	- start - start address (may not be aligned)
+ *	- end   - end address (exclusive, may not be aligned)
+ */
+ENTRY(v7wbi_flush_kern_tlb_range)
+	dsb
+	mov	r0, r0, lsr #PAGE_SHIFT		@ align address
+	mov	r1, r1, lsr #PAGE_SHIFT
+	mov	r0, r0, lsl #PAGE_SHIFT
+	mov	r1, r1, lsl #PAGE_SHIFT
+1:
+	mcr	p15, 0, r0, c8, c6, 1		@ TLB invalidate D MVA
+	mcr	p15, 0, r0, c8, c5, 1		@ TLB invalidate I MVA
+	add	r0, r0, #PAGE_SZ
+	cmp	r0, r1
+	blo	1b
+	mov	r2, #0
+	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
+	dsb
+	isb
+	mov	pc, lr
+
+	.section ".text.init", #alloc, #execinstr
+
+	.type	v7wbi_tlb_fns, #object
+ENTRY(v7wbi_tlb_fns)
+	.long	v7wbi_flush_user_tlb_range
+	.long	v7wbi_flush_kern_tlb_range
+	.long	v6wbi_tlb_flags
+	.size	v7wbi_tlb_fns, . - v7wbi_tlb_fns
