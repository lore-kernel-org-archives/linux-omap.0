From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Fwd: [RFC 4/5] ARM: P2V: introduce phys_to_virt/virt_to_phys
	runtime patching
Date: Tue, 18 Jan 2011 18:32:52 +0000
Message-ID: <20110118183252.GJ16980@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53192 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab1ARSc6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 13:32:58 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

A warning for OMAP.

Your use of the __virt_to_phys() in assembly code for the debug stuff
will break with this patch... please ensure that it is resolved by the
next merge window.

----- Forwarded message from Russell King - ARM Linux <linux@arm.linux.org.uk> -----

Date: Tue, 04 Jan 2011 20:23:18 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Nicolas Pitre <nico@fluxnic.net>
Cc: linux-arm-kernel@lists.infradead.org
Subject: [RFC 4/5] ARM: P2V: introduce phys_to_virt/virt_to_phys runtime
	patching

This idea came from Nicolas, Eric Miao produced an initial version,
which was then rewritten into this.

Patch the physical to virtual translations at runtime.  As we modify
the code, this makes it incompatible with XIP kernels, but on allows
is to achieve this with minimal loss of performance.

As many translations are of the form:

	physical = virtual + (PHYS_OFFSET - PAGE_OFFSET)
	virtual = physical - (PHYS_OFFSET - PAGE_OFFSET)

we generate an 'add' instruction for __virt_to_phys(), and a 'sub'
instruction for __phys_to_virt().  We calculate at run time (PHYS_OFFSET
- PAGE_OFFSET) by comparing the address prior to MMU initialization with
where it should be once the MMU has been initialized, and place this
constant into the above add/sub instructions.

Once we have (PHYS_OFFSET - PAGE_OFFSET), we can calcuate the real
PHYS_OFFSET as PAGE_OFFSET is a build-time constant, and save this for
the C-mode PHYS_OFFSET variable definition to use.

At present, we are unable to support Realview with Sparsemem enabled
as this uses a complex mapping function, and MSM as this requires a
constant which will not fit in our math instruction.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig              |   14 +++++++++
 arch/arm/include/asm/memory.h |   55 ++++++++++++++++++++++++++++--------
 arch/arm/kernel/head.S        |   63 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/module.c      |   23 ++++++++++++++-
 arch/arm/kernel/setup.c       |    2 +-
 arch/arm/kernel/vmlinux.lds.S |    4 ++
 6 files changed, 147 insertions(+), 14 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7b155b0..801192b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -196,6 +196,19 @@ config VECTORS_BASE
 	help
 	  The base address of exception vectors.
 
+config ARM_PATCH_PHYS_VIRT
+	bool "Patch physical to virtual translations at runtime (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	depends on !XIP_KERNEL && !THUMB2_KERNEL && MMU
+	depends on !ARCH_MSM
+	depends on !ARCH_REALVIEW || !SPARSEMEM
+	help
+	  Patch phys-to-virt translation functions at runtime according to
+	  the position of the kernel in system memory.
+
+	  This can only be used with non-XIP, non-Thumb2, MMU kernels where
+	  the base of physical memory is at a 16MB boundary.
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
@@ -608,6 +621,7 @@ config ARCH_PXA
 	select TICK_ONESHOT
 	select PLAT_PXA
 	select SPARSE_IRQ
+	select ARM_PATCH_PHYS_VIRT
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 00b04ae..288b690 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -24,8 +24,6 @@
  */
 #define UL(x) _AC(x, UL)
 
-#define PHYS_OFFSET	PLAT_PHYS_OFFSET
-
 #ifdef CONFIG_MMU
 
 /*
@@ -135,16 +133,6 @@
 #endif
 
 /*
- * Physical vs virtual RAM address space conversion.  These are
- * private definitions which should NOT be used outside memory.h
- * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
- */
-#ifndef __virt_to_phys
-#define __virt_to_phys(x)	((x) - PAGE_OFFSET + PHYS_OFFSET)
-#define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)
-#endif
-
-/*
  * Convert a physical address to a Page Frame Number and back
  */
 #define	__phys_to_pfn(paddr)	((paddr) >> PAGE_SHIFT)
@@ -159,6 +147,49 @@
 #ifndef __ASSEMBLY__
 
 /*
+ * Physical vs virtual RAM address space conversion.  These are
+ * private definitions which should NOT be used outside memory.h
+ * files.  Use virt_to_phys/phys_to_virt/__pa/__va instead.
+ */
+#ifndef __virt_to_phys
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
+
+extern unsigned long __pv_phys_offset;
+#define PHYS_OFFSET __pv_phys_offset
+
+#define __pv_stub(from,to,instr)			\
+	__asm__("@ __pv_stub\n"				\
+	"1:	" instr "	%0, %1, %2\n"		\
+	"	.pushsection .pv_table,\"a\"\n"		\
+	"	.long	1b\n"				\
+	"	.popsection\n"				\
+	: "=r" (to)					\
+	: "r" (from), "I" (1))
+
+static inline unsigned long __virt_to_phys(unsigned long x)
+{
+	unsigned long t;
+	__pv_stub(x, t, "add");
+	return t;
+}
+
+static inline unsigned long __phys_to_virt(unsigned long x)
+{
+	unsigned long t;
+	__pv_stub(x, t, "sub");
+	return t;
+}
+#else
+#define __virt_to_phys(x)	((x) - PAGE_OFFSET + PHYS_OFFSET)
+#define __phys_to_virt(x)	((x) - PHYS_OFFSET + PAGE_OFFSET)
+#endif
+#endif
+
+#ifndef PHYS_OFFSET
+#define PHYS_OFFSET	PLAT_PHYS_OFFSET
+#endif
+
+/*
  * The DMA mask corresponding to the maximum bus address allocatable
  * using GFP_DMA.  The default here places no restriction on DMA
  * allocations.  This must be the smallest DMA mask in the system,
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index aedd80e..258b0ca 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -100,6 +100,9 @@ ENTRY(stext)
 #ifdef CONFIG_SMP_ON_UP
 	bl	__fixup_smp
 #endif
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
+	bl	__fixup_pv_table
+#endif
 	bl	__create_page_tables
 
 	/*
@@ -445,4 +448,64 @@ smp_on_up:
 
 #endif
 
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
+
+/* __fixup_pv_table - patch the stub instructions with the delta between
+ * PHYS_OFFSET and PAGE_OFFSET, which is assumed to be 16MiB aligned and
+ * can be expressed by an immediate shifter operand. The stub instruction
+ * has a form of '(add|sub) rd, rn, #imm'.
+ */
+__fixup_pv_table:
+	adr	r0, 1f
+	ldmia	r0, {r3-r5,r7,ip}
+	sub	r3, r0, r3	@ PHYS_OFFSET - PAGE_OFFSET
+	add	r4, r4, r3	@ adjust table start address
+	add	r5, r5, r3	@ adjust table end address
+	add	ip, ip, r3	@ our PHYS_OFFSET
+	str	ip, [r7, r3]!	@ save to __pv_phys_offset
+	mov	r6, r3, lsr #24	@ constant for add/sub instructions
+	teq	r3, r6, lsl #24 @ must be 16MiB aligned
+	bne	__error
+	orr	r6, r6, #0x400	@ mask in rotate right 8 bits
+	str	r6, [r7, #4]	@ save to __pv_offset
+__fixup_a_pv_table:
+2:	cmp	r4, r5
+	ldrlo	r7, [r4], #4
+	ldrlo	ip, [r7, r3]
+	bic	ip, ip, #0x000000ff
+	bic	ip, ip, #0x00000f00
+	orr	ip, ip, r6
+	strlo	ip, [r7, r3]
+	blo	2b
+	mov	pc, lr
+ENDPROC(__fixup_phys_virt)
+
+ENTRY(fixup_pv_table)
+	stmfd	sp!, {r4 - r7, lr}
+	ldr	r2, 2f			@ get address of __pv_phys_offset
+	mov	r3, #0			@ no offset
+	mov	r4, r0			@ r0 = table start
+	add	r5, r0, r1		@ r1 = table size
+	ldr	r6, [r2, #4]		@ get __pv_offset
+	bl	__fixup_a_pv_table
+	ldmfd	sp!, {r4 - r7, pc}
+ENDPROC(fixup_pv_table)
+
+	.align
+1:	.long	.
+	.long	__pv_table_begin
+	.long	__pv_table_end
+2:	.long	__pv_phys_offset
+	.long	PAGE_OFFSET
+
+	.data
+	.globl	__pv_phys_offset
+	.type	__pv_phys_offset, %object
+__pv_phys_offset:
+	.long	0
+	.size	__pv_phys_offset, . - __pv_phys_offset
+__pv_offset:
+	.long	0
+#endif
+
 #include "head-common.S"
diff --git a/arch/arm/kernel/module.c b/arch/arm/kernel/module.c
index 0c1bb68..6a42e17 100644
--- a/arch/arm/kernel/module.c
+++ b/arch/arm/kernel/module.c
@@ -276,12 +276,28 @@ struct mod_unwind_map {
 	const Elf_Shdr *txt_sec;
 };
 
+static const Elf_Shdr *find_mod_section(const Elf32_Ehdr *hdr,
+	const Elf_Shdr *sechdrs, const char *name)
+{
+	const Elf_Shdr *s, *se;
+	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
+
+	for (s = sechdrs, se = sechdrs + hdr->e_shnum; s < se; s++)
+		if (strcmp(name, secstrs + s->sh_name) == 0)
+			return s;
+
+	return NULL;
+}
+
+extern void fixup_pv_table(const void *, unsigned long);
+
 int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
 		    struct module *mod)
 {
+	const Elf_Shdr *s = NULL;
 #ifdef CONFIG_ARM_UNWIND
 	const char *secstrs = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
-	const Elf_Shdr *s, *sechdrs_end = sechdrs + hdr->e_shnum;
+	const Elf_Shdr *sechdrs_end = sechdrs + hdr->e_shnum;
 	struct mod_unwind_map maps[ARM_SEC_MAX];
 	int i;
 
@@ -323,6 +339,11 @@ int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
 					         maps[i].txt_sec->sh_addr,
 					         maps[i].txt_sec->sh_size);
 #endif
+#ifdef CONFIG_ARM_PATCH_PHYS_VIRT
+	s = find_mod_section(hdr, sechdrs, ".pv_table");
+	if (s)
+		fixup_pv_table((void *)s->sh_addr, s->sh_size);
+#endif
 	return 0;
 }
 
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index f67e682..7c5499d 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -804,7 +804,7 @@ void __init setup_arch(char **cmdline_p)
 	struct machine_desc *mdesc;
 	char *from = default_command_line;
 
-	tags->mem.start = PHYS_OFFSET;
+	init_tags.mem.start = PHYS_OFFSET;
 
 	unwind_init();
 
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 86b66f3..45b5651 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -57,6 +57,10 @@ SECTIONS
 		__smpalt_end = .;
 #endif
 
+		__pv_table_begin = .;
+			*(.pv_table)
+		__pv_table_end = .;
+
 		INIT_SETUP(16)
 
 		INIT_CALLS
-- 
1.6.2.5
