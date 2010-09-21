From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: Handle __flush_icache_all for CONFIG_SMP_ON_UP
Date: Tue, 21 Sep 2010 09:16:00 -0700
Message-ID: <20100921161600.GT4611@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
 <20100906104413.GD20903@n2100.arm.linux.org.uk>
 <20100914185907.GG8647@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53340 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188Ab0IUQQE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 12:16:04 -0400
Content-Disposition: inline
In-Reply-To: <20100914185907.GG8647@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bryan.wu@canonical.com

* Tony Lindgren <tony@atomide.com> [100914 12:04]:
> 
> Here's a patch for __flush_icache_all. I believe this is the last
> remaining patch we need.
> 
> The only other thing I can think of are the conflicts with
> CONFIG_CPU_32v6K, on early ARM1136 and later ARM11 systems if somebody
> wants to compile a kernel that supports both. But that's not needed for
> omap2, so we can boot now omap2, 3 and 4 with a single defconfig :)

Here's an updated version with a typo fix s/fluch/flush/ from Anand.

Regards,

Tony

From: Tony Lindgren <tony@atomide.com>
Date: Mon, 20 Sep 2010 16:37:16 -0700
Subject: [PATCH] ARM: Handle __flush_icache_all for CONFIG_SMP_ON_UP

Do this by adding flush_icache_all to cache_fns for ARMv6 and 7.
As flush_icache_all may neeed to be called from flush_kern_cache_all,
add it as the first entry in the cache_fns.

Note that now we can remove the ARM_ERRATA_411920 dependency
to !SMP so it can be selected on UP ARMv6 processors, such
as omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>

--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1017,7 +1017,7 @@ endif
 
 config ARM_ERRATA_411920
 	bool "ARM errata: Invalidation of the Instruction Cache operation can fail"
-	depends on CPU_V6 && !SMP
+	depends on CPU_V6
 	help
 	  Invalidation of the Instruction Cache operation can
 	  fail. This erratum is present in 1136 (before r1p4), 1156 and 1176.
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -156,6 +156,12 @@
  *	Please note that the implementation of these, and the required
  *	effects are cache-type (VIVT/VIPT/PIPT) specific.
  *
+ *	flush_icache_all()
+ *
+ *		Unconditionally clean and invalidate the entire icache.
+ *		Currently only needed for cache-v6.S and cache-v7.S, see
+ *		__flush_icache_all for the generic implementation.
+ *
  *	flush_kern_all()
  *
  *		Unconditionally clean and invalidate the entire cache.
@@ -206,6 +212,7 @@
  */
 
 struct cpu_cache_fns {
+	void (*flush_icache_all)(void);
 	void (*flush_kern_all)(void);
 	void (*flush_user_all)(void);
 	void (*flush_user_range)(unsigned long, unsigned long, unsigned int);
@@ -227,6 +234,7 @@ struct cpu_cache_fns {
 
 extern struct cpu_cache_fns cpu_cache;
 
+#define __cpuc_flush_icache_all		cpu_cache.flush_icache_all
 #define __cpuc_flush_kern_all		cpu_cache.flush_kern_all
 #define __cpuc_flush_user_all		cpu_cache.flush_user_all
 #define __cpuc_flush_user_range		cpu_cache.flush_user_range
@@ -246,6 +254,7 @@ extern struct cpu_cache_fns cpu_cache;
 
 #else
 
+#define __cpuc_flush_icache_all		__glue(_CACHE,_flush_icache_all)
 #define __cpuc_flush_kern_all		__glue(_CACHE,_flush_kern_cache_all)
 #define __cpuc_flush_user_all		__glue(_CACHE,_flush_user_cache_all)
 #define __cpuc_flush_user_range		__glue(_CACHE,_flush_user_cache_range)
@@ -253,6 +262,7 @@ extern struct cpu_cache_fns cpu_cache;
 #define __cpuc_coherent_user_range	__glue(_CACHE,_coherent_user_range)
 #define __cpuc_flush_dcache_area	__glue(_CACHE,_flush_kern_dcache_area)
 
+extern void __cpuc_flush_icache_all(void);
 extern void __cpuc_flush_kern_all(void);
 extern void __cpuc_flush_user_all(void);
 extern void __cpuc_flush_user_range(unsigned long, unsigned long, unsigned int);
@@ -291,6 +301,37 @@ extern void copy_to_user_page(struct vm_area_struct *, struct page *,
 /*
  * Convert calls to our calling convention.
  */
+
+/* Invalidate I-cache */
+#define __flush_icache_all_generic()					\
+	asm("mcr	p15, 0, %0, c7, c5, 0"				\
+	    : : "r" (0));
+
+/* Invalidate I-cache inner shareable */
+#define __flush_icache_all_v7_smp()					\
+	asm("mcr	p15, 0, %0, c7, c1, 0"				\
+	    : : "r" (0));
+
+/*
+ * Optimized __flush_icache_all for the common cases. Note that UP ARMv7
+ * will fall through to use __flush_icache_all_generic.
+ */
+#if (defined(CONFIG_CPU_V7) && defined(CONFIG_CPU_V6)) ||		\
+	defined(CONFIG_SMP_ON_UP)
+#define __flush_icache_preferred	__cpuc_flush_icache_all
+#elif __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
+#define __flush_icache_preferred	__flush_icache_all_v7_smp
+#elif __LINUX_ARM_ARCH__ == 6 && defined(CONFIG_ARM_ERRATA_411920)
+#define __flush_icache_preferred	__cpuc_flush_icache_all
+#else
+#define __flush_icache_preferred	__flush_icache_all_generic
+#endif
+
+static inline void __flush_icache_all(void)
+{
+	__flush_icache_preferred();
+}
+
 #define flush_cache_all()		__cpuc_flush_kern_all()
 
 static inline void vivt_flush_cache_mm(struct mm_struct *mm)
@@ -366,21 +407,6 @@ extern void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *);
 
-static inline void __flush_icache_all(void)
-{
-#ifdef CONFIG_ARM_ERRATA_411920
-	extern void v6_icache_inval_all(void);
-	v6_icache_inval_all();
-#elif defined(CONFIG_SMP) && __LINUX_ARM_ARCH__ >= 7
-	asm("mcr	p15, 0, %0, c7, c1, 0	@ invalidate I-cache inner shareable\n"
-	    :
-	    : "r" (0));
-#else
-	asm("mcr	p15, 0, %0, c7, c5, 0	@ invalidate I-cache\n"
-	    :
-	    : "r" (0));
-#endif
-}
 static inline void flush_kernel_vmap_range(void *addr, int size)
 {
 	if ((cache_is_vivt() || cache_is_vipt_aliasing()))
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -21,18 +21,22 @@
 #define D_CACHE_LINE_SIZE	32
 #define BTB_FLUSH_SIZE		8
 
-#ifdef CONFIG_ARM_ERRATA_411920
 /*
- * Invalidate the entire I cache (this code is a workaround for the ARM1136
- * erratum 411920 - Invalidate Instruction Cache operation can fail. This
- * erratum is present in 1136, 1156 and 1176. It does not affect the MPCore.
+ *	v6_flush_icache_all()
+ *
+ *	Flush the whole I-cache.
  *
- * Registers:
- *   r0 - set to 0
- *   r1 - corrupted
+ *	ARM1136 erratum 411920 - Invalidate Instruction Cache operation can fail.
+ *	This erratum is present in 1136, 1156 and 1176. It does not affect the
+ *	MPCore.
+ *
+ *	Registers:
+ *	r0 - set to 0
+ *	r1 - corrupted
  */
-ENTRY(v6_icache_inval_all)
+ENTRY(v6_flush_icache_all)
 	mov	r0, #0
+#ifdef CONFIG_ARM_ERRATA_411920
 	mrs	r1, cpsr
 	cpsid	ifa				@ disable interrupts
 	mcr	p15, 0, r0, c7, c5, 0		@ invalidate entire I-cache
@@ -43,8 +47,11 @@ ENTRY(v6_icache_inval_all)
 	.rept	11				@ ARM Ltd recommends at least
 	nop					@ 11 NOPs
 	.endr
-	mov	pc, lr
+#else
+	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I-cache
 #endif
+	mov	pc, lr
+ENDPROC(v6_flush_icache_all)
 
 /*
  *	v6_flush_cache_all()
@@ -60,7 +67,7 @@ ENTRY(v6_flush_kern_cache_all)
 #ifndef CONFIG_ARM_ERRATA_411920
 	mcr	p15, 0, r0, c7, c5, 0		@ I+BTB cache invalidate
 #else
-	b	v6_icache_inval_all
+	b	v6_flush_icache_all
 #endif
 #else
 	mcr	p15, 0, r0, c7, c15, 0		@ Cache clean+invalidate
@@ -138,7 +145,7 @@ ENTRY(v6_coherent_user_range)
 #ifndef CONFIG_ARM_ERRATA_411920
 	mcr	p15, 0, r0, c7, c5, 0		@ I+BTB cache invalidate
 #else
-	b	v6_icache_inval_all
+	b	v6_flush_icache_all
 #endif
 #else
 	mcr	p15, 0, r0, c7, c5, 6		@ invalidate BTB
@@ -312,6 +319,7 @@ ENDPROC(v6_dma_unmap_area)
 
 	.type	v6_cache_fns, #object
 ENTRY(v6_cache_fns)
+	.long	v6_flush_icache_all
 	.long	v6_flush_kern_cache_all
 	.long	v6_flush_user_cache_all
 	.long	v6_flush_user_cache_range
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -18,6 +18,21 @@
 #include "proc-macros.S"
 
 /*
+ *	v7_flush_icache_all()
+ *
+ *	Flush the whole I-cache.
+ *
+ *	Registers:
+ *	r0 - set to 0
+ */
+ENTRY(v7_flush_icache_all)
+	mov	r0, #0
+	ALT_SMP(mcr	p15, 0, r0, c7, c1, 0)		@ invalidate I-cache inner shareable
+	ALT_UP(mcr	p15, 0, r0, c7, c5, 0)		@ I+BTB cache invalidate
+	mov	pc, lr
+ENDPROC(v7_flush_icache_all)
+
+/*
  *	v7_flush_dcache_all()
  *
  *	Flush the whole D-cache.
@@ -303,6 +318,7 @@ ENDPROC(v7_dma_unmap_area)
 
 	.type	v7_cache_fns, #object
 ENTRY(v7_cache_fns)
+	.long	v7_flush_icache_all
 	.long	v7_flush_kern_cache_all
 	.long	v7_flush_user_cache_all
 	.long	v7_flush_user_cache_range
