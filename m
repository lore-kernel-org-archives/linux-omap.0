From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 0/4] Hacks to allow booting ARM SMP kernel on UP ARMv7
Date: Tue, 17 Aug 2010 14:52:05 +0100
Message-ID: <20100817135205.GC20325@n2100.arm.linux.org.uk>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49982 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab0HQNwV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 09:52:21 -0400
Content-Disposition: inline
In-Reply-To: <20100817104414.19061.38999.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, bryan.wu@canonical.com

On Tue, Aug 17, 2010 at 01:53:12PM +0300, Tony Lindgren wrote:
> Here are some experimental patches to allow booting ARMv7 SMP
> kernel on UP to some extent. Posting these early in case it is
> of any help as I know at least Bryan Wu is working on similar
> issues.

I think these are compeltely the wrong direction.  First thing to realise
is that XIP in the "SMP and UP in one kernel" is not really practical -
I'm not sure that many people who want that kind of flexibility also want
XIP too.

So let's forget about the kernel text being read-only.

The second thing to realise is that most of the SMP dependencies are in
assembly - and we can make lists of instructions and their modified
versions that would be necessary to boot a SMP kernel on UP.

So something like this will do (though note that not everywhere has been
fixed up - such as the page table flags - or this patch tested yet.)

If we don't want the SMP-on-UP support for SMP kernels (it's not actually
all that big - around 512 bytes) then we can discard the .smpalt.init
section and the __fixup_smp code.

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 6e8f05c..55974d2 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -154,16 +154,32 @@
 	.long	9999b,9001f;			\
 	.popsection
 
+#ifdef CONFIG_SMP
+#define SMP(instr...)						\
+9998:	instr
+#define UP(instr...)						\
+	.pushsection ".smpalt.init", "a"			;\
+	.word	9998b						;\
+	instr							;\
+	.popsection
+#else
+#define SMP(instr...)
+#define UP(instr...) instr
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
 
diff --git a/arch/arm/include/asm/smp_midr.h b/arch/arm/include/asm/smp_midr.h
index e69de29..4538ba4 100644
--- a/arch/arm/include/asm/smp_midr.h
+++ b/arch/arm/include/asm/smp_midr.h
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
+			"	.word	1b\n"				\
+			"	mov	%0, #0\n"			\
+			"	.popsection"				\
+			: "=r" (cpunum));				\
+		cpunum &= 0x0F;						\
+	})
+
+#endif
diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 33b546a..0644860 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -185,12 +185,15 @@
 # define v6wbi_always_flags	(-1UL)
 #endif
 
-#ifdef CONFIG_SMP
-#define v7wbi_tlb_flags (TLB_WB | TLB_DCLEAN | TLB_V7_IS_BTB | \
+#define v7wbi_tlb_flags_smp (TLB_WB | TLB_DCLEAN | TLB_V7_IS_BTB | \
 			 TLB_V7_UIS_FULL | TLB_V7_UIS_PAGE | TLB_V7_UIS_ASID)
-#else
-#define v7wbi_tlb_flags (TLB_WB | TLB_DCLEAN | TLB_BTB | \
+#define v7wbi_tlb_flags_up (TLB_WB | TLB_DCLEAN | TLB_BTB | \
 			 TLB_V6_U_FULL | TLB_V6_U_PAGE | TLB_V6_U_ASID)
+
+#ifdef CONFIG_SMP
+#define v7wbi_tlb_flags	v7wbi_tlb_flags_smp
+#else
+#define v7wbi_tlb_flags	v7wbi_tlb_flags_up
 #endif
 
 #ifdef CONFIG_CPU_TLB_V7
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index bb8e93a..bb2ef60 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -965,11 +965,8 @@ kuser_cmpxchg_fixup:
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
index eb62bf9..feabbf0 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -86,6 +86,9 @@ ENTRY(stext)
 	movs	r8, r5				@ invalid machine (r5=0)?
 	beq	__error_a			@ yes, error 'a'
 	bl	__vet_atags
+#ifdef CONFIG_SMP
+	bl	__fixup_smp
+#endif
 	bl	__create_page_tables
 
 	/*
@@ -333,4 +336,35 @@ __create_page_tables:
 ENDPROC(__create_page_tables)
 	.ltorg
 
+#ifdef CONFIG_SMP
+__fixup_smp:
+	and	r0, r9, #0xff000000
+	teq	r0, #0x41000000		@ ARM CPU?
+	bne	smp_on_up		@ no, assume UP
+	and	r0, r9, #0x00070000
+	teq	r0, #0x00070000		@ ARMv6/v7?
+	bne	smp_on_up		@ no, assume UP
+	mrc	p15, 0, r0, c0, c0, 5	@ read MIDR
+	movs	r0, r0, lsr #30
+	teqne	r0, #3			@ check top two bits 00 or 11
+	moveq	pc, lr
+
+smp_on_up:
+	adr	r0, 1f
+	ldmia	r0, {r1, r2, r3}
+	sub	r1, r0, r1
+	add	r2, r2, r1
+	add	r3, r3, r1
+2:	cmp	r2, r3
+	ldmia	r2!, {r0, r4}
+	movhs	pc, lr
+	str	r4, [r0, r1]
+	b	2b
+ENDPROC(__fixup_smp)
+
+1:	.word	.
+	.word	__smpalt_begin
+	.word	__smpalt_end
+#endif
+
 #include "head-common.S"
diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index b16c079..89858be 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -40,6 +40,9 @@ SECTIONS
 		__tagtable_begin = .;
 			*(.taglist.init)
 		__tagtable_end = .;
+		__smpalt_begin = .;
+			*(.smpalt.init)
+		__smpalt_end = .;
 
 		INIT_SETUP(16)
 
diff --git a/arch/arm/mach-realview/include/mach/smp.h b/arch/arm/mach-realview/include/mach/smp.h
index dd53892..833ee85 100644
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
+#include <asm/smp_midr.h>
 
 /*
  * We use IRQ1 as the IPI
diff --git a/arch/arm/mach-s5pv310/include/mach/smp.h b/arch/arm/mach-s5pv310/include/mach/smp.h
index 990f3ba..1b8b637 100644
--- a/arch/arm/mach-s5pv310/include/mach/smp.h
+++ b/arch/arm/mach-s5pv310/include/mach/smp.h
@@ -7,17 +7,10 @@
 #define ASM_ARCH_SMP_H __FILE__
 
 #include <asm/hardware/gic.h>
+#include <asm/smp_midr.h>
 
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
index 8b42dab..d5c4030 100644
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
+#include <asm/smp_midr.h>
 
 /*
  * We use IRQ1 as the IPI
diff --git a/arch/arm/mach-ux500/include/mach/smp.h b/arch/arm/mach-ux500/include/mach/smp.h
index b59f7bc..87a9cf3 100644
--- a/arch/arm/mach-ux500/include/mach/smp.h
+++ b/arch/arm/mach-ux500/include/mach/smp.h
@@ -10,18 +10,11 @@
 #define ASMARM_ARCH_SMP_H
 
 #include <asm/hardware/gic.h>
+#include <asm/smp_midr.h>
 
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
index 72a9621..e02bc7d 100644
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
+#include <asm/smp_midr.h>
 
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
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 22aac85..692d22e 100644
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
@@ -169,7 +167,8 @@ __v6_setup:
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r0, c8, c7, 0		@ invalidate I + D TLBs
 	mcr	p15, 0, r0, c2, c0, 2		@ TTB control register
-	orr	r4, r4, #TTB_FLAGS
+	SMP(orr	r4, r4, #TTB_FLAGS_SMP)
+	UP(orr	r4, r4, #TTB_FLAGS_UP)
 	mcr	p15, 0, r4, c2, c0, 1		@ load TTB1
 #endif /* CONFIG_MMU */
 	adr	r5, v6_crval
@@ -225,10 +224,16 @@ cpu_elf_name:
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
@@ -249,10 +254,16 @@ __v6_proc_info:
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
index 6a8506d..c04f9c1 100644
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
@@ -235,7 +234,8 @@ __v7_setup:
 #ifdef CONFIG_MMU
 	mcr	p15, 0, r10, c8, c7, 0		@ invalidate I + D TLBs
 	mcr	p15, 0, r10, c2, c0, 2		@ TTB control register
-	orr	r4, r4, #TTB_FLAGS
+	SMP(orr	r4, r4, #TTB_FLAGS_SMP)
+	UP(orr	r4, r4, #TTB_FLAGS_UP)
 	mcr	p15, 0, r4, c2, c0, 1		@ load TTB1
 	mov	r10, #0x1f			@ domains 0, 1 = manager
 	mcr	p15, 0, r10, c3, c0, 0		@ load domain access register
@@ -330,10 +330,16 @@ cpu_elf_name:
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
index f3f288a..26247c9 100644
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
index 6a3ff65..ed96907 100644
--- a/arch/arm/plat-omap/include/plat/smp.h
+++ b/arch/arm/plat-omap/include/plat/smp.h
@@ -18,6 +18,7 @@
 #define OMAP_ARCH_SMP_H
 
 #include <asm/hardware/gic.h>
+#include <asm/smp_midr.h>
 
 /*
  * set_event() is used to wake up secondary core from wfe using sev. ROM
@@ -40,15 +41,4 @@ static inline void smp_cross_call(const struct cpumask *mask)
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

