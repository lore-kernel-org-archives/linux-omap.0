From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Mon, 6 Sep 2010 11:44:13 +0100
Message-ID: <20100906104413.GD20903@n2100.arm.linux.org.uk>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39025 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885Ab0IFKob (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Sep 2010 06:44:31 -0400
Content-Disposition: inline
In-Reply-To: <20100817104414.19061.38999.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bryan.wu@canonical.com

Here's my latest patch (which is combined from two patches.)

Tony, could you follow up with patches for anything which is still
required - I think there's two things you've addressed which this
currently misses:

1. not initializing twd_base (I'm not convinced this is safe - rather
   making smp_prepare_cpus() return early is probably a better idea.)
2. __flush_icache_all()

Note that (2) seems to be complicated by the instruction only being
available on ARMv7 and later.

Also note that this should only be used for comparing SMP vs UP versions
of the same architecture - in other words, not ARMv6 vs ARMv6K.

Lastly, what's happening about ARMv6 and ARMv7 processor setup functions?
Are we going to split them into those which need SMP bits twiddled and
those which don't?  If we are going to split them, someone needs to follow
up on this email with patches to do it (preferably to be slotted in
before these changes.)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 836a3e5..11daea0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1166,6 +1166,19 @@ config SMP
 
 	  If you don't know what to do here, say N.
 
+config SMP_ON_UP
+	bool "Allow booting SMP kernel on uniprocessor systems (EXPERIMENTAL)"
+	depends on EXPERIMENTAL
+	depends on SMP && !XIP
+	default y
+	help
+	  SMP kernels contain instructions which fail on non-SMP processors.
+	  Enabling this option allows the kernel to modify itself to make
+	  these instructions safe.  Disabling it allows about 1K of space
+	  savings.
+
+	  If you don't know what to do here, say Y.
+
 config HAVE_ARM_SCU
 	bool
 	depends on SMP
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 6e8f05c..e2bd8c6 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -154,16 +154,39 @@
 	.long	9999b,9001f;			\
 	.popsection
 
+#ifdef CONFIG_SMP
+#define SMP(instr...)						\
+9998:	instr
+#define UP(instr...)						\
+	.pushsection ".smpalt.init", "a"			;\
+	.long	9998b						;\
+	instr							;\
+	.popsection
+#define UP_B(label)						\
+	.equ	up_b_offset, label - 9998b			;\
+	.pushsection ".smpalt.init", "a"			;\
+	.long	9998b						;\
+	b	. + up_b_offset					;\
+	.popsection
+#else
+#define SMP(instr...)
+#define UP(instr...) instr
+#define UP_B(label) b label
+#endif
+
 /*
  * SMP data memory barrier
  */
 	.macro	smp_dmb
 #ifdef CONFIG_SMP
 #if __LINUX_ARM_ARCH__ >= 7
-	dmb
+	SMP(dmb)
 #elif __LINUX_ARM_ARCH__ == 6
-	mcr	p15, 0, r0, c7, c10, 5	@ dmb
+	SMP(mcr	p15, 0, r0, c7, c10, 5)	@ dmb
+#else
+#error Incompatible SMP platform
 #endif
+	UP(nop)
 #endif
 	.endm
 
diff --git a/arch/arm/include/asm/smp_mpidr.h b/arch/arm/include/asm/smp_mpidr.h
new file mode 100644
index 0000000..18f2117
--- /dev/null
+++ b/arch/arm/include/asm/smp_mpidr.h
@@ -0,0 +1,17 @@
+#ifndef ASMARM_SMP_MIDR_H
+#define ASMARM_SMP_MIDR_H
+
+#define hard_smp_processor_id()						\
+	({								\
+		unsigned int cpunum;					\
+		__asm__("\n"						\
+			"1:	mrc p15, 0, %0, c0, c0, 5\n"		\
+			"	.pushsection \".smpalt.init\", \"a\"\n"	\
+			"	.long	1b\n"				\
+			"	mov	%0, #0\n"			\
+			"	.popsection"				\
+			: "=r" (cpunum));				\
+		cpunum &= 0x0F;						\
+	})
+
+#endif
diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index e621530..7de5aa5 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -18,4 +18,19 @@ static inline int cache_ops_need_broadcast(void)
 	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 1;
 }
 
+/*
+ * Return true if we are running on a SMP platform
+ */
+static inline bool is_smp(void)
+{
+#ifndef CONFIG_SMP
+	return false;
+#elif defined(CONFIG_SMP_ON_UP)
+	extern unsigned int smp_on_up;
+	return !!smp_on_up;
+#else
+	return true;
+#endif
+}
+
 #endif
diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 33b546a..cf2f018 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -70,6 +70,10 @@
 #undef _TLB
 #undef MULTI_TLB
 
+#ifdef CONFIG_SMP_ON_UP
+#define MULTI_TLB 1
+#endif
+
 #define v3_tlb_flags	(TLB_V3_FULL | TLB_V3_PAGE)
 
 #ifdef CONFIG_CPU_TLB_V3
@@ -185,17 +189,23 @@
 # define v6wbi_always_flags	(-1UL)
 #endif
 
-#ifdef CONFIG_SMP
-#define v7wbi_tlb_flags (TLB_WB | TLB_DCLEAN | TLB_V7_IS_BTB | \
+#define v7wbi_tlb_flags_smp	(TLB_WB | TLB_DCLEAN | TLB_V7_IS_BTB | \
 			 TLB_V7_UIS_FULL | TLB_V7_UIS_PAGE | TLB_V7_UIS_ASID)
-#else
-#define v7wbi_tlb_flags (TLB_WB | TLB_DCLEAN | TLB_BTB | \
+#define v7wbi_tlb_flags_up	(TLB_WB | TLB_DCLEAN | TLB_BTB | \
 			 TLB_V6_U_FULL | TLB_V6_U_PAGE | TLB_V6_U_ASID)
-#endif
 
 #ifdef CONFIG_CPU_TLB_V7
-# define v7wbi_possible_flags	v7wbi_tlb_flags
-# define v7wbi_always_flags	v7wbi_tlb_flags
+
+# ifdef CONFIG_SMP_ON_UP
+#  define v7wbi_possible_flags	(v7wbi_tlb_flags_smp | v7wbi_tlb_flags_up)
+#  define v7wbi_always_flags	(v7wbi_tlb_flags_smp & v7wbi_tlb_flags_up)
+# elif defined(CONFIG_SMP)
+#  define v7wbi_possible_flags	v7wbi_tlb_flags_smp
+#  define v7wbi_always_flags	v7wbi_tlb_flags_smp
+# else
+#  define v7wbi_possible_flags	v7wbi_tlb_flags_up
+#  define v7wbi_always_flags	v7wbi_tlb_flags_up
+# endif
 # ifdef _TLB
 #  define MULTI_TLB 1
 # else
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index bb8e93a..a42f267 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -46,7 +46,8 @@
 	 * this macro assumes that irqstat (r6) and base (r5) are
 	 * preserved from get_irqnr_and_base above
 	 */
-	test_for_ipi r0, r6, r5, lr
+	SMP(test_for_ipi r0, r6, r5, lr)
+	UP_B(9997f)
 	movne	r0, sp
 	adrne	lr, BSYM(1b)
 	bne	do_IPI
@@ -57,6 +58,7 @@
 	adrne	lr, BSYM(1b)
 	bne	do_local_timer
 #endif
+9997:
 #endif
 
 	.endm
@@ -965,11 +967,8 @@ kuser_cmpxchg_fixup:
 	beq	1b
 	rsbs	r0, r3, #0
 	/* beware -- each __kuser slot must be 8 instructions max */
-#ifdef CONFIG_SMP
-	b	__kuser_memory_barrier
-#else
-	usr_ret	lr
-#endif
+	SMP(b	__kuser_memory_barrier)
+	UP(usr_ret	lr)
 
 #endif
 
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index eb62bf9..e15dc0f 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -86,6 +86,9 @@ ENTRY(stext)
 	movs	r8, r5				@ invalid machine (r5=0)?
 	beq	__error_a			@ yes, error 'a'
 	bl	__vet_atags
+#ifdef CONFIG_SMP_ON_UP
+	bl	__fixup_smp
+#endif
 	bl	__create_page_tables
 
 	/*
@@ -333,4 +336,51 @@ __create_page_tables:
 ENDPROC(__create_page_tables)
 	.ltorg
 
+#ifdef CONFIG_SMP_ON_UP
+__fixup_smp:
+	mov	r7, #0x00070000
+	orr	r6, r7, #0xff000000	@ mask 0xff070000
+	orr	r7, r7, #0x41000000	@ val 0x41070000
+	and	r0, r9, r6
+	teq	r0, r7			@ ARM CPU and ARMv6/v7?
+	bne	__fixup_smp_on_up	@ no, assume UP
+
+	orr	r6, r6, #0x0000ff00
+	orr	r6, r6, #0x000000f0	@ mask 0xff07fff0
+	orr	r7, r7, #0x0000b000
+	orr	r7, r7, #0x00000020	@ val 0x4107b020
+	and	r0, r9, r6
+	teq	r0, r7			@ ARM 11MPCore?
+	moveq	pc, lr			@ yes, assume SMP
+
+	mrc	p15, 0, r0, c0, c0, 5	@ read MIDR
+	tst	r0, #1 << 31
+	movne	pc, lr			@ bit 31 => SMP
+
+__fixup_smp_on_up:
+	adr	r0, 1f
+	ldmia	r0, {r3, r6, r7}
+	sub	r3, r0, r3
+	add	r6, r6, r3
+	add	r7, r7, r3
+2:	cmp	r6, r7
+	ldmia	r6!, {r0, r4}
+	strlo	r4, [r0, r3]
+	blo	2b
+	mov	pc, lr
+ENDPROC(__fixup_smp)
+
+1:	.word	.
+	.word	__smpalt_begin
+	.word	__smpalt_end
+
+	.pushsection .data
+	.globl	smp_on_up
+smp_on_up:
+	SMP(.long	1)
+	UP(.long	0)
+	.popsection
+
+#endif
+
 #include "head-common.S"
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d5231ae..fe94467 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -36,6 +36,7 @@
 #include <asm/procinfo.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
+#include <asm/smp_plat.h>
 #include <asm/mach-types.h>
 #include <asm/cacheflush.h>
 #include <asm/cachetype.h>
@@ -824,9 +825,8 @@ void __init setup_arch(char **cmdline_p)
 	paging_init(mdesc);
 	request_standard_resources(&meminfo, mdesc);
 
-#ifdef CONFIG_SMP
-	smp_init_cpus();
-#endif
+	if (is_smp())
+		smp_init_cpus();
 	reserve_crashkernel();
 
 	cpu_init();
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index b16c079..53cb57e 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -40,6 +40,11 @@ SECTIONS
 		__tagtable_begin = .;
 			*(.taglist.init)
 		__tagtable_end = .;
+#ifdef CONFIG_SMP_ON_UP
+		__smpalt_begin = .;
+			*(.smpalt.init)
+		__smpalt_end = .;
+#endif
 
 		INIT_SETUP(16)
 
@@ -237,6 +242,12 @@ SECTIONS
 
 	/* Default discards */
 	DISCARDS
+
+#ifndef CONFIG_SMP_ON_UP
+	/DISCARD/ {
+		*(.smpalt.init)
+	}
+#endif
 }
 
 /*
diff --git a/arch/arm/mach-realview/include/mach/smp.h b/arch/arm/mach-realview/include/mach/smp.h
index dd53892..d3cd265 100644
--- a/arch/arm/mach-realview/include/mach/smp.h
+++ b/arch/arm/mach-realview/include/mach/smp.h
@@ -1,16 +1,8 @@
 #ifndef ASMARM_ARCH_SMP_H
 #define ASMARM_ARCH_SMP_H
 
-
 #include <asm/hardware/gic.h>
-
-#define hard_smp_processor_id()			\
-	({						\
-		unsigned int cpunum;			\
-		__asm__("mrc p15, 0, %0, c0, c0, 5"	\
-			: "=r" (cpunum));		\
-		cpunum &= 0x0F;				\
-	})
+#include <asm/smp_mpidr.h>
 
 /*
  * We use IRQ1 as the IPI
diff --git a/arch/arm/mach-s5pv310/include/mach/smp.h b/arch/arm/mach-s5pv310/include/mach/smp.h
index 990f3ba..b7ec252 100644
--- a/arch/arm/mach-s5pv310/include/mach/smp.h
+++ b/arch/arm/mach-s5pv310/include/mach/smp.h
@@ -7,17 +7,10 @@
 #define ASM_ARCH_SMP_H __FILE__
 
 #include <asm/hardware/gic.h>
+#include <asm/smp_mpidr.h>
 
 extern void __iomem *gic_cpu_base_addr;
 
-#define hard_smp_processor_id()			\
-	({						\
-		unsigned int cpunum;			\
-		__asm__("mrc p15, 0, %0, c0, c0, 5"	\
-			: "=r" (cpunum));		\
-		cpunum &= 0x03;				\
-	})
-
 /*
  * We use IRQ1 as the IPI
  */
diff --git a/arch/arm/mach-tegra/include/mach/smp.h b/arch/arm/mach-tegra/include/mach/smp.h
index 8b42dab..e4a34a3 100644
--- a/arch/arm/mach-tegra/include/mach/smp.h
+++ b/arch/arm/mach-tegra/include/mach/smp.h
@@ -1,16 +1,8 @@
 #ifndef ASMARM_ARCH_SMP_H
 #define ASMARM_ARCH_SMP_H
 
-
 #include <asm/hardware/gic.h>
-
-#define hard_smp_processor_id()			\
-	({						\
-		unsigned int cpunum;			\
-		__asm__("mrc p15, 0, %0, c0, c0, 5"	\
-			: "=r" (cpunum));		\
-		cpunum &= 0x0F;				\
-	})
+#include <asm/smp_mpidr.h>
 
 /*
  * We use IRQ1 as the IPI
diff --git a/arch/arm/mach-ux500/include/mach/smp.h b/arch/arm/mach-ux500/include/mach/smp.h
index b59f7bc..197e841 100644
--- a/arch/arm/mach-ux500/include/mach/smp.h
+++ b/arch/arm/mach-ux500/include/mach/smp.h
@@ -10,18 +10,11 @@
 #define ASMARM_ARCH_SMP_H
 
 #include <asm/hardware/gic.h>
+#include <asm/smp_mpidr.h>
 
 /* This is required to wakeup the secondary core */
 extern void u8500_secondary_startup(void);
 
-#define hard_smp_processor_id()				\
-	({						\
-		unsigned int cpunum;			\
-		__asm__("mrc p15, 0, %0, c0, c0, 5"	\
-			: "=r" (cpunum));		\
-		cpunum &= 0x0F;				\
-	})
-
 /*
  * We use IRQ1 as the IPI
  */
diff --git a/arch/arm/mach-vexpress/include/mach/smp.h b/arch/arm/mach-vexpress/include/mach/smp.h
index 72a9621..5a6da4f 100644
--- a/arch/arm/mach-vexpress/include/mach/smp.h
+++ b/arch/arm/mach-vexpress/include/mach/smp.h
@@ -2,14 +2,7 @@
 #define __MACH_SMP_H
 
 #include <asm/hardware/gic.h>
-
-#define hard_smp_processor_id()				\
-	({						\
-		unsigned int cpunum;			\
-		__asm__("mrc p15, 0, %0, c0, c0, 5"	\
-			: "=r" (cpunum));		\
-		cpunum &= 0x0F;				\
-	})
+#include <asm/smp_mpidr.h>
 
 /*
  * We use IRQ1 as the IPI
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 37c8157..2aa59d5 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -91,11 +91,8 @@ ENTRY(v7_flush_kern_cache_all)
  THUMB(	stmfd	sp!, {r4-r7, r9-r11, lr}	)
 	bl	v7_flush_dcache_all
 	mov	r0, #0
-#ifdef CONFIG_SMP
-	mcr	p15, 0, r0, c7, c1, 0		@ invalidate I-cache inner shareable
-#else
-	mcr	p15, 0, r0, c7, c5, 0		@ I+BTB cache invalidate
-#endif
+	SMP(mcr	p15, 0, r0, c7, c1, 0)		@ invalidate I-cache inner shareable
+	UP(mcr	p15, 0, r0, c7, c5, 0)		@ I+BTB cache invalidate
  ARM(	ldmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
  THUMB(	ldmfd	sp!, {r4-r7, r9-r11, lr}	)
 	mov	pc, lr
@@ -171,11 +168,8 @@ ENTRY(v7_coherent_user_range)
 	cmp	r0, r1
 	blo	1b
 	mov	r0, #0
-#ifdef CONFIG_SMP
-	mcr	p15, 0, r0, c7, c1, 6		@ invalidate BTB Inner Shareable
-#else
-	mcr	p15, 0, r0, c7, c5, 6		@ invalidate BTB
-#endif
+	SMP(mcr	p15, 0, r0, c7, c1, 6)		@ invalidate BTB Inner Shareable
+	UP(mcr	p15, 0, r0, c7, c5, 6)		@ invalidate BTB
 	dsb
 	isb
 	mov	pc, lr
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 6e1c4f6..a789320 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -303,9 +303,8 @@ static void __init build_mem_type_table(void)
 			cachepolicy = CPOLICY_WRITEBACK;
 		ecc_mask = 0;
 	}
-#ifdef CONFIG_SMP
-	cachepolicy = CPOLICY_WRITEALLOC;
-#endif
+	if (is_smp())
+		cachepolicy = CPOLICY_WRITEALLOC;
 
 	/*
 	 * Strip out features not present on earlier architectures.
@@ -399,13 +398,11 @@ static void __init build_mem_type_table(void)
 	cp = &cache_policies[cachepolicy];
 	vecs_pgprot = kern_pgprot = user_pgprot = cp->pte;
 
-#ifndef CONFIG_SMP
 	/*
 	 * Only use write-through for non-SMP systems
 	 */
-	if (cpu_arch >= CPU_ARCH_ARMv5 && cachepolicy > CPOLICY_WRITETHROUGH)
+	if (!is_smp() && cpu_arch >= CPU_ARCH_ARMv5 && cachepolicy > CPOLICY_WRITETHROUGH)
 		vecs_pgprot = cache_policies[CPOLICY_WRITETHROUGH].pte;
-#endif
 
 	/*
 	 * Enable CPU-specific coherency if supported.
@@ -426,20 +423,21 @@ static void __init build_mem_type_table(void)
 		mem_types[MT_MINICLEAN].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
 		mem_types[MT_CACHECLEAN].prot_sect |= PMD_SECT_APX|PMD_SECT_AP_WRITE;
 
-#ifdef CONFIG_SMP
-		/*
-		 * Mark memory with the "shared" attribute for SMP systems
-		 */
-		user_pgprot |= L_PTE_SHARED;
-		kern_pgprot |= L_PTE_SHARED;
-		vecs_pgprot |= L_PTE_SHARED;
-		mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_S;
-		mem_types[MT_DEVICE_WC].prot_pte |= L_PTE_SHARED;
-		mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_S;
-		mem_types[MT_DEVICE_CACHED].prot_pte |= L_PTE_SHARED;
-		mem_types[MT_MEMORY].prot_sect |= PMD_SECT_S;
-		mem_types[MT_MEMORY_NONCACHED].prot_sect |= PMD_SECT_S;
-#endif
+		if (is_smp()) {
+			/*
+			 * Mark memory with the "shared" attribute
+			 * for SMP systems
+			 */
+			user_pgprot |= L_PTE_SHARED;
+			kern_pgprot |= L_PTE_SHARED;
+			vecs_pgprot |= L_PTE_SHARED;
+			mem_types[MT_DEVICE_WC].prot_sect |= PMD_SECT_S;
+			mem_types[MT_DEVICE_WC].prot_pte |= L_PTE_SHARED;
+			mem_types[MT_DEVICE_CACHED].prot_sect |= PMD_SECT_S;
+			mem_types[MT_DEVICE_CACHED].prot_pte |= L_PTE_SHARED;
+			mem_types[MT_MEMORY].prot_sect |= PMD_SECT_S;
+			mem_types[MT_MEMORY_NONCACHED].prot_sect |= PMD_SECT_S;
+		}
 	}
 
 	/*
@@ -802,8 +800,7 @@ static void __init sanity_check_meminfo(void)
 			 * rather difficult.
 			 */
 			reason = "with VIPT aliasing cache";
-#ifdef CONFIG_SMP
-		} else if (tlb_ops_need_broadcast()) {
+		} else if (is_smp() && tlb_ops_need_broadcast()) {
 			/*
 			 * kmap_high needs to occasionally flush TLB entries,
 			 * however, if the TLB entries need to be broadcast
@@ -813,7 +810,6 @@ static void __init sanity_check_meminfo(void)
 			 *   (must not be called with irqs off)
 			 */
 			reason = "without hardware TLB ops broadcasting";
-#endif
 		}
 		if (reason) {
 			printk(KERN_CRIT "HIGHMEM is not supported %s, ignoring high memory\n",
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 22aac85..00692b0 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -30,13 +30,10 @@
 #define TTB_RGN_WT	(2 << 3)
 #define TTB_RGN_WB	(3 << 3)
 
-#ifndef CONFIG_SMP
-#define TTB_FLAGS	TTB_RGN_WBWA
-#define PMD_FLAGS	PMD_SECT_WB
-#else
-#define TTB_FLAGS	TTB_RGN_WBWA|TTB_S
-#define PMD_FLAGS	PMD_SECT_WBWA|PMD_SECT_S
-#endif
+#define TTB_FLAGS_UP	TTB_RGN_WBWA
+#define PMD_FLAGS_UP	PMD_SECT_WB
+#define TTB_FLAGS_SMP	TTB_RGN_WBWA|TTB_S
+#define PMD_FLAGS_SMP	PMD_SECT_WBWA|PMD_SECT_S
 
 ENTRY(cpu_v6_proc_init)
 	mov	pc, lr
@@ -97,7 +94,8 @@ ENTRY(cpu_v6_switch_mm)
 #ifdef CONFIG_MMU
 	mov	r2, #0
 	ldr	r1, [r1, #MM_CONTEXT_ID]	@ get mm->context.id
-	orr	r0, r0, #TTB_FLAGS
+	SMP(orr	r0, r0, #TTB_FLAGS_SMP)
+	UP(orr	r0, r0, #TTB_FLAGS_UP)
 	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
 	mcr	p15, 0, r2, c7, c10, 4		@ drain write buffer
 	mcr	p15, 0, r0, c2, c0, 0		@ set TTB 0
@@ -156,9 +154,11 @@ cpu_pj4_name:
  */
 __v6_setup:
 #ifdef CONFIG_SMP
-	mrc	p15, 0, r0, c1, c0, 1		@ Enable SMP/nAMP mode
+	SMP(mrc	p15, 0, r0, c1, c0, 1)		@ Enable SMP/nAMP mode
+	UP(nop)
 	orr	r0, r0, #0x20
-	mcr	p15, 0, r0, c1, c0, 1
+	SMP(mcr	p15, 0, r0, c1, c0, 1)
+	UP(nop)
 #endif
 
 	mov	r0, #0
@@ -169,7 +169,8 @@ __v6_setup:
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r0, c8, c7, 0		@ invalidate I + D TLBs
 	mcr	p15, 0, r0, c2, c0, 2		@ TTB control register
-	orr	r4, r4, #TTB_FLAGS
+	SMP(orr	r4, r4, #TTB_FLAGS_SMP)
+	UP(orr	r4, r4, #TTB_FLAGS_UP)
 	mcr	p15, 0, r4, c2, c0, 1		@ load TTB1
 #endif /* CONFIG_MMU */
 	adr	r5, v6_crval
@@ -225,10 +226,16 @@ cpu_elf_name:
 __v6_proc_info:
 	.long	0x0007b000
 	.long	0x0007f000
-	.long   PMD_TYPE_SECT | \
+	SMP(.long \
+		PMD_TYPE_SECT | \
+		PMD_SECT_AP_WRITE | \
+		PMD_SECT_AP_READ | \
+		PMD_FLAGS_SMP)
+	UP(.long \
+		PMD_TYPE_SECT | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ | \
-		PMD_FLAGS
+		PMD_FLAGS_UP)
 	.long   PMD_TYPE_SECT | \
 		PMD_SECT_XN | \
 		PMD_SECT_AP_WRITE | \
@@ -249,10 +256,16 @@ __v6_proc_info:
 __pj4_v6_proc_info:
 	.long	0x560f5810
 	.long	0xff0ffff0
-	.long   PMD_TYPE_SECT | \
+	SMP(.long \
+		PMD_TYPE_SECT | \
+		PMD_SECT_AP_WRITE | \
+		PMD_SECT_AP_READ | \
+		PMD_FLAGS_SMP)
+	UP(.long \
+		PMD_TYPE_SECT | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ | \
-		PMD_FLAGS
+		PMD_FLAGS_UP)
 	.long   PMD_TYPE_SECT | \
 		PMD_SECT_XN | \
 		PMD_SECT_AP_WRITE | \
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 6a8506d..07fc660 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -30,15 +30,13 @@
 #define TTB_IRGN_WT	((1 << 0) | (0 << 6))
 #define TTB_IRGN_WB	((1 << 0) | (1 << 6))
 
-#ifndef CONFIG_SMP
 /* PTWs cacheable, inner WB not shareable, outer WB not shareable */
-#define TTB_FLAGS	TTB_IRGN_WB|TTB_RGN_OC_WB
-#define PMD_FLAGS	PMD_SECT_WB
-#else
+#define TTB_FLAGS_UP	TTB_IRGN_WB|TTB_RGN_OC_WB
+#define PMD_FLAGS_UP	PMD_SECT_WB
+
 /* PTWs cacheable, inner WBWA shareable, outer WBWA not shareable */
-#define TTB_FLAGS	TTB_IRGN_WBWA|TTB_S|TTB_NOS|TTB_RGN_OC_WBWA
-#define PMD_FLAGS	PMD_SECT_WBWA|PMD_SECT_S
-#endif
+#define TTB_FLAGS_SMP	TTB_IRGN_WBWA|TTB_S|TTB_NOS|TTB_RGN_OC_WBWA
+#define PMD_FLAGS_SMP	PMD_SECT_WBWA|PMD_SECT_S
 
 ENTRY(cpu_v7_proc_init)
 	mov	pc, lr
@@ -105,7 +103,8 @@ ENTRY(cpu_v7_switch_mm)
 #ifdef CONFIG_MMU
 	mov	r2, #0
 	ldr	r1, [r1, #MM_CONTEXT_ID]	@ get mm->context.id
-	orr	r0, r0, #TTB_FLAGS
+	SMP(orr	r0, r0, #TTB_FLAGS_SMP)
+	UP(orr	r0, r0, #TTB_FLAGS_UP)
 #ifdef CONFIG_ARM_ERRATA_430973
 	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
 #endif
@@ -188,7 +187,8 @@ cpu_v7_name:
  */
 __v7_setup:
 #ifdef CONFIG_SMP
-	mrc	p15, 0, r0, c1, c0, 1
+	SMP(mrc	p15, 0, r0, c1, c0, 1)
+	UP(mov	r0, #(1 << 6))			@ fake it for UP
 	tst	r0, #(1 << 6)			@ SMP/nAMP mode enabled?
 	orreq	r0, r0, #(1 << 6) | (1 << 0)	@ Enable SMP/nAMP mode and
 	mcreq	p15, 0, r0, c1, c0, 1		@ TLB ops broadcasting
@@ -235,7 +235,8 @@ __v7_setup:
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r10, c8, c7, 0		@ invalidate I + D TLBs
 	mcr	p15, 0, r10, c2, c0, 2		@ TTB control register
-	orr	r4, r4, #TTB_FLAGS
+	SMP(orr	r4, r4, #TTB_FLAGS_SMP)
+	UP(orr	r4, r4, #TTB_FLAGS_UP)
 	mcr	p15, 0, r4, c2, c0, 1		@ load TTB1
 	mov	r10, #0x1f			@ domains 0, 1 = manager
 	mcr	p15, 0, r10, c3, c0, 0		@ load domain access register
@@ -330,10 +331,16 @@ cpu_elf_name:
 __v7_proc_info:
 	.long	0x000f0000		@ Required ID value
 	.long	0x000f0000		@ Mask for ID
-	.long   PMD_TYPE_SECT | \
+	SMP(.long \
+		PMD_TYPE_SECT | \
+		PMD_SECT_AP_WRITE | \
+		PMD_SECT_AP_READ | \
+		PMD_FLAGS_SMP)
+	UP(.long \
+		PMD_TYPE_SECT | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ | \
-		PMD_FLAGS
+		PMD_FLAGS_UP)
 	.long   PMD_TYPE_SECT | \
 		PMD_SECT_XN | \
 		PMD_SECT_AP_WRITE | \
diff --git a/arch/arm/mm/tlb-v7.S b/arch/arm/mm/tlb-v7.S
index f3f288a..4671c8f 100644
--- a/arch/arm/mm/tlb-v7.S
+++ b/arch/arm/mm/tlb-v7.S
@@ -13,6 +13,7 @@
  */
 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/page.h>
 #include <asm/tlbflush.h>
@@ -41,20 +42,15 @@ ENTRY(v7wbi_flush_user_tlb_range)
 	orr	r0, r3, r0, lsl #PAGE_SHIFT	@ Create initial MVA
 	mov	r1, r1, lsl #PAGE_SHIFT
 1:
-#ifdef CONFIG_SMP
-	mcr	p15, 0, r0, c8, c3, 1		@ TLB invalidate U MVA (shareable) 
-#else
-	mcr	p15, 0, r0, c8, c7, 1		@ TLB invalidate U MVA
-#endif
+	SMP(mcr	p15, 0, r0, c8, c3, 1)		@ TLB invalidate U MVA (shareable)
+	UP(mcr	p15, 0, r0, c8, c7, 1)		@ TLB invalidate U MVA
+
 	add	r0, r0, #PAGE_SZ
 	cmp	r0, r1
 	blo	1b
 	mov	ip, #0
-#ifdef CONFIG_SMP
-	mcr	p15, 0, ip, c7, c1, 6		@ flush BTAC/BTB Inner Shareable
-#else
-	mcr	p15, 0, ip, c7, c5, 6		@ flush BTAC/BTB
-#endif
+	SMP(mcr	p15, 0, ip, c7, c1, 6)		@ flush BTAC/BTB Inner Shareable
+	UP(mcr	p15, 0, ip, c7, c5, 6)		@ flush BTAC/BTB
 	dsb
 	mov	pc, lr
 ENDPROC(v7wbi_flush_user_tlb_range)
@@ -74,20 +70,14 @@ ENTRY(v7wbi_flush_kern_tlb_range)
 	mov	r0, r0, lsl #PAGE_SHIFT
 	mov	r1, r1, lsl #PAGE_SHIFT
 1:
-#ifdef CONFIG_SMP
-	mcr	p15, 0, r0, c8, c3, 1		@ TLB invalidate U MVA (shareable)
-#else
-	mcr	p15, 0, r0, c8, c7, 1		@ TLB invalidate U MVA
-#endif
+	SMP(mcr	p15, 0, r0, c8, c3, 1)		@ TLB invalidate U MVA (shareable)
+	UP(mcr	p15, 0, r0, c8, c7, 1)		@ TLB invalidate U MVA
 	add	r0, r0, #PAGE_SZ
 	cmp	r0, r1
 	blo	1b
 	mov	r2, #0
-#ifdef CONFIG_SMP
-	mcr	p15, 0, r2, c7, c1, 6		@ flush BTAC/BTB Inner Shareable
-#else
-	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
-#endif
+	SMP(mcr	p15, 0, r2, c7, c1, 6)		@ flush BTAC/BTB Inner Shareable
+	UP(mcr	p15, 0, r2, c7, c5, 6)		@ flush BTAC/BTB
 	dsb
 	isb
 	mov	pc, lr
@@ -99,5 +89,6 @@ ENDPROC(v7wbi_flush_kern_tlb_range)
 ENTRY(v7wbi_tlb_fns)
 	.long	v7wbi_flush_user_tlb_range
 	.long	v7wbi_flush_kern_tlb_range
-	.long	v7wbi_tlb_flags
+	SMP(.long	v7wbi_tlb_flags_smp)
+	UP(.long	v7wbi_tlb_flags_up)
 	.size	v7wbi_tlb_fns, . - v7wbi_tlb_fns
diff --git a/arch/arm/plat-omap/include/plat/smp.h b/arch/arm/plat-omap/include/plat/smp.h
index 5177a9c..ecd6a48 100644
--- a/arch/arm/plat-omap/include/plat/smp.h
+++ b/arch/arm/plat-omap/include/plat/smp.h
@@ -18,6 +18,7 @@
 #define OMAP_ARCH_SMP_H
 
 #include <asm/hardware/gic.h>
+#include <asm/smp_mpidr.h>
 
 /* Needed for secondary core boot */
 extern void omap_secondary_startup(void);
@@ -33,15 +34,4 @@ static inline void smp_cross_call(const struct cpumask *mask)
 	gic_raise_softirq(mask, 1);
 }
 
-/*
- * Read MPIDR: Multiprocessor affinity register
- */
-#define hard_smp_processor_id()			\
-	({						\
-		unsigned int cpunum;			\
-		__asm__("mrc p15, 0, %0, c0, c0, 5"	\
-			: "=r" (cpunum));		\
-		cpunum &= 0x0F;				\
-	})
-
 #endif

