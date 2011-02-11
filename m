From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 1/6] ARM: move cache/processor/fault glue to separate include files
Date: Fri, 11 Feb 2011 16:17:34 +0000
Message-ID: <E1Pnvgc-0002yU-Gr@rmk-PC.arm.linux.org.uk>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34499 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757377Ab1BKQRz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 11:17:55 -0500
In-Reply-To: <20110211161626.GA31356@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

This allows the cache/processor/fault glue to be more easily used
from assembler code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/cacheflush.h  |  133 +----------------
 arch/arm/include/asm/cpu-multi32.h |   69 --------
 arch/arm/include/asm/cpu-single.h  |   44 ------
 arch/arm/include/asm/glue-cache.h  |  146 ++++++++++++++++++
 arch/arm/include/asm/glue-df.h     |  110 +++++++++++++
 arch/arm/include/asm/glue-pf.h     |   57 +++++++
 arch/arm/include/asm/glue-proc.h   |  261 +++++++++++++++++++++++++++++++
 arch/arm/include/asm/glue.h        |  138 -----------------
 arch/arm/include/asm/proc-fns.h    |  299 ++++++++----------------------------
 arch/arm/kernel/asm-offsets.c      |    2 +
 arch/arm/kernel/entry-armv.S       |    3 +-
 11 files changed, 644 insertions(+), 618 deletions(-)
 delete mode 100644 arch/arm/include/asm/cpu-multi32.h
 delete mode 100644 arch/arm/include/asm/cpu-single.h
 create mode 100644 arch/arm/include/asm/glue-cache.h
 create mode 100644 arch/arm/include/asm/glue-df.h
 create mode 100644 arch/arm/include/asm/glue-pf.h
 create mode 100644 arch/arm/include/asm/glue-proc.h

diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 3acd8fa..18a5664 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -12,7 +12,7 @@
 
 #include <linux/mm.h>
 
-#include <asm/glue.h>
+#include <asm/glue-cache.h>
 #include <asm/shmparam.h>
 #include <asm/cachetype.h>
 #include <asm/outercache.h>
@@ -20,123 +20,6 @@
 #define CACHE_COLOUR(vaddr)	((vaddr & (SHMLBA - 1)) >> PAGE_SHIFT)
 
 /*
- *	Cache Model
- *	===========
- */
-#undef _CACHE
-#undef MULTI_CACHE
-
-#if defined(CONFIG_CPU_CACHE_V3)
-# ifdef _CACHE
-#  define MULTI_CACHE 1
-# else
-#  define _CACHE v3
-# endif
-#endif
-
-#if defined(CONFIG_CPU_CACHE_V4)
-# ifdef _CACHE
-#  define MULTI_CACHE 1
-# else
-#  define _CACHE v4
-# endif
-#endif
-
-#if defined(CONFIG_CPU_ARM920T) || defined(CONFIG_CPU_ARM922T) || \
-    defined(CONFIG_CPU_ARM925T) || defined(CONFIG_CPU_ARM1020) || \
-    defined(CONFIG_CPU_ARM1026)
-# define MULTI_CACHE 1
-#endif
-
-#if defined(CONFIG_CPU_FA526)
-# ifdef _CACHE
-#  define MULTI_CACHE 1
-# else
-#  define _CACHE fa
-# endif
-#endif
-
-#if defined(CONFIG_CPU_ARM926T)
-# ifdef _CACHE
-#  define MULTI_CACHE 1
-# else
-#  define _CACHE arm926
-# endif
-#endif
-
-#if defined(CONFIG_CPU_ARM940T)
-# ifdef _CACHE
-#  define MULTI_CACHE 1
-# else
-#  define _CACHE arm940
-# endif
-#endif
-
-#if defined(CONFIG_CPU_ARM946E)
-# ifdef _CACHE
-#  define MULTI_CACHE 1
-# else
-#  define _CACHE arm946
-# endif
-#endif
-
-#if defined(CONFIG_CPU_CACHE_V4WB)
-# ifdef _CACHE
-#  define MULTI_CACHE 1
-# else
-#  define _CACHE v4wb
-# endif
-#endif
-
-#if defined(CONFIG_CPU_XSCALE)
-# ifdef _CACHE
-#  define MULTI_CACHE 1
-# else
-#  define _CACHE xscale
-# endif
-#endif
-
-#if defined(CONFIG_CPU_XSC3)
-# ifdef _CACHE
-#  define MULTI_CACHE 1
-# else
-#  define _CACHE xsc3
-# endif
-#endif
-
-#if defined(CONFIG_CPU_MOHAWK)
-# ifdef _CACHE
-#  define MULTI_CACHE 1
-# else
-#  define _CACHE mohawk
-# endif
-#endif
-
-#if defined(CONFIG_CPU_FEROCEON)
-# define MULTI_CACHE 1
-#endif
-
-#if defined(CONFIG_CPU_V6)
-//# ifdef _CACHE
-#  define MULTI_CACHE 1
-//# else
-//#  define _CACHE v6
-//# endif
-#endif
-
-#if defined(CONFIG_CPU_V7)
-//# ifdef _CACHE
-#  define MULTI_CACHE 1
-//# else
-//#  define _CACHE v7
-//# endif
-#endif
-
-#if !defined(_CACHE) && !defined(MULTI_CACHE)
-#error Unknown cache maintainence model
-#endif
-
-/*
  * This flag is used to indicate that the page pointed to by a pte is clean
  * and does not require cleaning before returning it to the user.
  */
@@ -249,19 +132,11 @@ extern struct cpu_cache_fns cpu_cache;
  * visible to the CPU.
  */
 #define dmac_map_area			cpu_cache.dma_map_area
-#define dmac_unmap_area		cpu_cache.dma_unmap_area
+#define dmac_unmap_area			cpu_cache.dma_unmap_area
 #define dmac_flush_range		cpu_cache.dma_flush_range
 
 #else
 
-#define __cpuc_flush_icache_all		__glue(_CACHE,_flush_icache_all)
-#define __cpuc_flush_kern_all		__glue(_CACHE,_flush_kern_cache_all)
-#define __cpuc_flush_user_all		__glue(_CACHE,_flush_user_cache_all)
-#define __cpuc_flush_user_range		__glue(_CACHE,_flush_user_cache_range)
-#define __cpuc_coherent_kern_range	__glue(_CACHE,_coherent_kern_range)
-#define __cpuc_coherent_user_range	__glue(_CACHE,_coherent_user_range)
-#define __cpuc_flush_dcache_area	__glue(_CACHE,_flush_kern_dcache_area)
-
 extern void __cpuc_flush_icache_all(void);
 extern void __cpuc_flush_kern_all(void);
 extern void __cpuc_flush_user_all(void);
@@ -276,10 +151,6 @@ extern void __cpuc_flush_dcache_area(void *, size_t);
  * is visible to DMA, or data written by DMA to system memory is
  * visible to the CPU.
  */
-#define dmac_map_area			__glue(_CACHE,_dma_map_area)
-#define dmac_unmap_area		__glue(_CACHE,_dma_unmap_area)
-#define dmac_flush_range		__glue(_CACHE,_dma_flush_range)
-
 extern void dmac_map_area(const void *, size_t, int);
 extern void dmac_unmap_area(const void *, size_t, int);
 extern void dmac_flush_range(const void *, const void *);
diff --git a/arch/arm/include/asm/cpu-multi32.h b/arch/arm/include/asm/cpu-multi32.h
deleted file mode 100644
index e2b5b0b..0000000
--- a/arch/arm/include/asm/cpu-multi32.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/*
- *  arch/arm/include/asm/cpu-multi32.h
- *
- *  Copyright (C) 2000 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#include <asm/page.h>
-
-struct mm_struct;
-
-/*
- * Don't change this structure - ASM code
- * relies on it.
- */
-extern struct processor {
-	/* MISC
-	 * get data abort address/flags
-	 */
-	void (*_data_abort)(unsigned long pc);
-	/*
-	 * Retrieve prefetch fault address
-	 */
-	unsigned long (*_prefetch_abort)(unsigned long lr);
-	/*
-	 * Set up any processor specifics
-	 */
-	void (*_proc_init)(void);
-	/*
-	 * Disable any processor specifics
-	 */
-	void (*_proc_fin)(void);
-	/*
-	 * Special stuff for a reset
-	 */
-	void (*reset)(unsigned long addr) __attribute__((noreturn));
-	/*
-	 * Idle the processor
-	 */
-	int (*_do_idle)(void);
-	/*
-	 * Processor architecture specific
-	 */
-	/*
-	 * clean a virtual address range from the
-	 * D-cache without flushing the cache.
-	 */
-	void (*dcache_clean_area)(void *addr, int size);
-
-	/*
-	 * Set the page table
-	 */
-	void (*switch_mm)(unsigned long pgd_phys, struct mm_struct *mm);
-	/*
-	 * Set a possibly extended PTE.  Non-extended PTEs should
-	 * ignore 'ext'.
-	 */
-	void (*set_pte_ext)(pte_t *ptep, pte_t pte, unsigned int ext);
-} processor;
-
-#define cpu_proc_init()			processor._proc_init()
-#define cpu_proc_fin()			processor._proc_fin()
-#define cpu_reset(addr)			processor.reset(addr)
-#define cpu_do_idle()			processor._do_idle()
-#define cpu_dcache_clean_area(addr,sz)	processor.dcache_clean_area(addr,sz)
-#define cpu_set_pte_ext(ptep,pte,ext)	processor.set_pte_ext(ptep,pte,ext)
-#define cpu_do_switch_mm(pgd,mm)	processor.switch_mm(pgd,mm)
diff --git a/arch/arm/include/asm/cpu-single.h b/arch/arm/include/asm/cpu-single.h
deleted file mode 100644
index f073a6d..0000000
--- a/arch/arm/include/asm/cpu-single.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- *  arch/arm/include/asm/cpu-single.h
- *
- *  Copyright (C) 2000 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-/*
- * Single CPU
- */
-#ifdef __STDC__
-#define __catify_fn(name,x)	name##x
-#else
-#define __catify_fn(name,x)	name/**/x
-#endif
-#define __cpu_fn(name,x)	__catify_fn(name,x)
-
-/*
- * If we are supporting multiple CPUs, then we must use a table of
- * function pointers for this lot.  Otherwise, we can optimise the
- * table away.
- */
-#define cpu_proc_init			__cpu_fn(CPU_NAME,_proc_init)
-#define cpu_proc_fin			__cpu_fn(CPU_NAME,_proc_fin)
-#define cpu_reset			__cpu_fn(CPU_NAME,_reset)
-#define cpu_do_idle			__cpu_fn(CPU_NAME,_do_idle)
-#define cpu_dcache_clean_area		__cpu_fn(CPU_NAME,_dcache_clean_area)
-#define cpu_do_switch_mm		__cpu_fn(CPU_NAME,_switch_mm)
-#define cpu_set_pte_ext			__cpu_fn(CPU_NAME,_set_pte_ext)
-
-#include <asm/page.h>
-
-struct mm_struct;
-
-/* declare all the functions as extern */
-extern void cpu_proc_init(void);
-extern void cpu_proc_fin(void);
-extern int cpu_do_idle(void);
-extern void cpu_dcache_clean_area(void *, int);
-extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
-extern void cpu_set_pte_ext(pte_t *ptep, pte_t pte, unsigned int ext);
-extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
diff --git a/arch/arm/include/asm/glue-cache.h b/arch/arm/include/asm/glue-cache.h
new file mode 100644
index 0000000..0591d35
--- /dev/null
+++ b/arch/arm/include/asm/glue-cache.h
@@ -0,0 +1,146 @@
+/*
+ *  arch/arm/include/asm/glue-cache.h
+ *
+ *  Copyright (C) 1999-2002 Russell King
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef ASM_GLUE_CACHE_H
+#define ASM_GLUE_CACHE_H
+
+#include <asm/glue.h>
+
+/*
+ *	Cache Model
+ *	===========
+ */
+#undef _CACHE
+#undef MULTI_CACHE
+
+#if defined(CONFIG_CPU_CACHE_V3)
+# ifdef _CACHE
+#  define MULTI_CACHE 1
+# else
+#  define _CACHE v3
+# endif
+#endif
+
+#if defined(CONFIG_CPU_CACHE_V4)
+# ifdef _CACHE
+#  define MULTI_CACHE 1
+# else
+#  define _CACHE v4
+# endif
+#endif
+
+#if defined(CONFIG_CPU_ARM920T) || defined(CONFIG_CPU_ARM922T) || \
+    defined(CONFIG_CPU_ARM925T) || defined(CONFIG_CPU_ARM1020) || \
+    defined(CONFIG_CPU_ARM1026)
+# define MULTI_CACHE 1
+#endif
+
+#if defined(CONFIG_CPU_FA526)
+# ifdef _CACHE
+#  define MULTI_CACHE 1
+# else
+#  define _CACHE fa
+# endif
+#endif
+
+#if defined(CONFIG_CPU_ARM926T)
+# ifdef _CACHE
+#  define MULTI_CACHE 1
+# else
+#  define _CACHE arm926
+# endif
+#endif
+
+#if defined(CONFIG_CPU_ARM940T)
+# ifdef _CACHE
+#  define MULTI_CACHE 1
+# else
+#  define _CACHE arm940
+# endif
+#endif
+
+#if defined(CONFIG_CPU_ARM946E)
+# ifdef _CACHE
+#  define MULTI_CACHE 1
+# else
+#  define _CACHE arm946
+# endif
+#endif
+
+#if defined(CONFIG_CPU_CACHE_V4WB)
+# ifdef _CACHE
+#  define MULTI_CACHE 1
+# else
+#  define _CACHE v4wb
+# endif
+#endif
+
+#if defined(CONFIG_CPU_XSCALE)
+# ifdef _CACHE
+#  define MULTI_CACHE 1
+# else
+#  define _CACHE xscale
+# endif
+#endif
+
+#if defined(CONFIG_CPU_XSC3)
+# ifdef _CACHE
+#  define MULTI_CACHE 1
+# else
+#  define _CACHE xsc3
+# endif
+#endif
+
+#if defined(CONFIG_CPU_MOHAWK)
+# ifdef _CACHE
+#  define MULTI_CACHE 1
+# else
+#  define _CACHE mohawk
+# endif
+#endif
+
+#if defined(CONFIG_CPU_FEROCEON)
+# define MULTI_CACHE 1
+#endif
+
+#if defined(CONFIG_CPU_V6)
+//# ifdef _CACHE
+#  define MULTI_CACHE 1
+//# else
+//#  define _CACHE v6
+//# endif
+#endif
+
+#if defined(CONFIG_CPU_V7)
+//# ifdef _CACHE
+#  define MULTI_CACHE 1
+//# else
+//#  define _CACHE v7
+//# endif
+#endif
+
+#if !defined(_CACHE) && !defined(MULTI_CACHE)
+#error Unknown cache maintainence model
+#endif
+
+#ifndef MULTI_CACHE
+#define __cpuc_flush_icache_all		__glue(_CACHE,_flush_icache_all)
+#define __cpuc_flush_kern_all		__glue(_CACHE,_flush_kern_cache_all)
+#define __cpuc_flush_user_all		__glue(_CACHE,_flush_user_cache_all)
+#define __cpuc_flush_user_range		__glue(_CACHE,_flush_user_cache_range)
+#define __cpuc_coherent_kern_range	__glue(_CACHE,_coherent_kern_range)
+#define __cpuc_coherent_user_range	__glue(_CACHE,_coherent_user_range)
+#define __cpuc_flush_dcache_area	__glue(_CACHE,_flush_kern_dcache_area)
+
+#define dmac_map_area			__glue(_CACHE,_dma_map_area)
+#define dmac_unmap_area			__glue(_CACHE,_dma_unmap_area)
+#define dmac_flush_range		__glue(_CACHE,_dma_flush_range)
+#endif
+
+#endif
diff --git a/arch/arm/include/asm/glue-df.h b/arch/arm/include/asm/glue-df.h
new file mode 100644
index 0000000..354d571
--- /dev/null
+++ b/arch/arm/include/asm/glue-df.h
@@ -0,0 +1,110 @@
+/*
+ *  arch/arm/include/asm/glue-df.h
+ *
+ *  Copyright (C) 1997-1999 Russell King
+ *  Copyright (C) 2000-2002 Deep Blue Solutions Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef ASM_GLUE_DF_H
+#define ASM_GLUE_DF_H
+
+#include <asm/glue.h>
+
+/*
+ *	Data Abort Model
+ *	================
+ *
+ *	We have the following to choose from:
+ *	  arm6          - ARM6 style
+ *	  arm7		- ARM7 style
+ *	  v4_early	- ARMv4 without Thumb early abort handler
+ *	  v4t_late	- ARMv4 with Thumb late abort handler
+ *	  v4t_early	- ARMv4 with Thumb early abort handler
+ *	  v5tej_early	- ARMv5 with Thumb and Java early abort handler
+ *	  xscale	- ARMv5 with Thumb with Xscale extensions
+ *	  v6_early	- ARMv6 generic early abort handler
+ *	  v7_early	- ARMv7 generic early abort handler
+ */
+#undef CPU_DABORT_HANDLER
+#undef MULTI_DABORT
+
+#if defined(CONFIG_CPU_ARM610)
+# ifdef CPU_DABORT_HANDLER
+#  define MULTI_DABORT 1
+# else
+#  define CPU_DABORT_HANDLER cpu_arm6_data_abort
+# endif
+#endif
+
+#if defined(CONFIG_CPU_ARM710)
+# ifdef CPU_DABORT_HANDLER
+#  define MULTI_DABORT 1
+# else
+#  define CPU_DABORT_HANDLER cpu_arm7_data_abort
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ABRT_LV4T
+# ifdef CPU_DABORT_HANDLER
+#  define MULTI_DABORT 1
+# else
+#  define CPU_DABORT_HANDLER v4t_late_abort
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ABRT_EV4
+# ifdef CPU_DABORT_HANDLER
+#  define MULTI_DABORT 1
+# else
+#  define CPU_DABORT_HANDLER v4_early_abort
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ABRT_EV4T
+# ifdef CPU_DABORT_HANDLER
+#  define MULTI_DABORT 1
+# else
+#  define CPU_DABORT_HANDLER v4t_early_abort
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ABRT_EV5TJ
+# ifdef CPU_DABORT_HANDLER
+#  define MULTI_DABORT 1
+# else
+#  define CPU_DABORT_HANDLER v5tj_early_abort
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ABRT_EV5T
+# ifdef CPU_DABORT_HANDLER
+#  define MULTI_DABORT 1
+# else
+#  define CPU_DABORT_HANDLER v5t_early_abort
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ABRT_EV6
+# ifdef CPU_DABORT_HANDLER
+#  define MULTI_DABORT 1
+# else
+#  define CPU_DABORT_HANDLER v6_early_abort
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ABRT_EV7
+# ifdef CPU_DABORT_HANDLER
+#  define MULTI_DABORT 1
+# else
+#  define CPU_DABORT_HANDLER v7_early_abort
+# endif
+#endif
+
+#ifndef CPU_DABORT_HANDLER
+#error Unknown data abort handler type
+#endif
+
+#endif
diff --git a/arch/arm/include/asm/glue-pf.h b/arch/arm/include/asm/glue-pf.h
new file mode 100644
index 0000000..d385f37
--- /dev/null
+++ b/arch/arm/include/asm/glue-pf.h
@@ -0,0 +1,57 @@
+/*
+ *  arch/arm/include/asm/glue-pf.h
+ *
+ *  Copyright (C) 1997-1999 Russell King
+ *  Copyright (C) 2000-2002 Deep Blue Solutions Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef ASM_GLUE_PF_H
+#define ASM_GLUE_PF_H
+
+#include <asm/glue.h>
+
+/*
+ *	Prefetch Abort Model
+ *	================
+ *
+ *	We have the following to choose from:
+ *	  legacy	- no IFSR, no IFAR
+ *	  v6		- ARMv6: IFSR, no IFAR
+ *	  v7		- ARMv7: IFSR and IFAR
+ */
+
+#undef CPU_PABORT_HANDLER
+#undef MULTI_PABORT
+
+#ifdef CONFIG_CPU_PABRT_LEGACY
+# ifdef CPU_PABORT_HANDLER
+#  define MULTI_PABORT 1
+# else
+#  define CPU_PABORT_HANDLER legacy_pabort
+# endif
+#endif
+
+#ifdef CONFIG_CPU_PABRT_V6
+# ifdef CPU_PABORT_HANDLER
+#  define MULTI_PABORT 1
+# else
+#  define CPU_PABORT_HANDLER v6_pabort
+# endif
+#endif
+
+#ifdef CONFIG_CPU_PABRT_V7
+# ifdef CPU_PABORT_HANDLER
+#  define MULTI_PABORT 1
+# else
+#  define CPU_PABORT_HANDLER v7_pabort
+# endif
+#endif
+
+#ifndef CPU_PABORT_HANDLER
+#error Unknown prefetch abort handler type
+#endif
+
+#endif
diff --git a/arch/arm/include/asm/glue-proc.h b/arch/arm/include/asm/glue-proc.h
new file mode 100644
index 0000000..e3bf443
--- /dev/null
+++ b/arch/arm/include/asm/glue-proc.h
@@ -0,0 +1,261 @@
+/*
+ *  arch/arm/include/asm/glue-proc.h
+ *
+ *  Copyright (C) 1997-1999 Russell King
+ *  Copyright (C) 2000 Deep Blue Solutions Ltd
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef ASM_GLUE_PROC_H
+#define ASM_GLUE_PROC_H
+
+#include <asm/glue.h>
+
+/*
+ * Work out if we need multiple CPU support
+ */
+#undef MULTI_CPU
+#undef CPU_NAME
+
+/*
+ * CPU_NAME - the prefix for CPU related functions
+ */
+
+#ifdef CONFIG_CPU_ARM610
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_arm6
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ARM7TDMI
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_arm7tdmi
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ARM710
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_arm7
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ARM720T
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_arm720
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ARM740T
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_arm740
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ARM9TDMI
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_arm9tdmi
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ARM920T
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_arm920
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ARM922T
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_arm922
+# endif
+#endif
+
+#ifdef CONFIG_CPU_FA526
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_fa526
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ARM925T
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_arm925
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ARM926T
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_arm926
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ARM940T
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_arm940
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ARM946E
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_arm946
+# endif
+#endif
+
+#ifdef CONFIG_CPU_SA110
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_sa110
+# endif
+#endif
+
+#ifdef CONFIG_CPU_SA1100
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_sa1100
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ARM1020
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_arm1020
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ARM1020E
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_arm1020e
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ARM1022
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_arm1022
+# endif
+#endif
+
+#ifdef CONFIG_CPU_ARM1026
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_arm1026
+# endif
+#endif
+
+#ifdef CONFIG_CPU_XSCALE
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_xscale
+# endif
+#endif
+
+#ifdef CONFIG_CPU_XSC3
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_xsc3
+# endif
+#endif
+
+#ifdef CONFIG_CPU_MOHAWK
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_mohawk
+# endif
+#endif
+
+#ifdef CONFIG_CPU_FEROCEON
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_feroceon
+# endif
+#endif
+
+#ifdef CONFIG_CPU_V6
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_v6
+# endif
+#endif
+
+#ifdef CONFIG_CPU_V7
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_v7
+# endif
+#endif
+
+#ifndef MULTI_CPU
+#define cpu_proc_init			__glue(CPU_NAME,_proc_init)
+#define cpu_proc_fin			__glue(CPU_NAME,_proc_fin)
+#define cpu_reset			__glue(CPU_NAME,_reset)
+#define cpu_do_idle			__glue(CPU_NAME,_do_idle)
+#define cpu_dcache_clean_area		__glue(CPU_NAME,_dcache_clean_area)
+#define cpu_do_switch_mm		__glue(CPU_NAME,_switch_mm)
+#define cpu_set_pte_ext			__glue(CPU_NAME,_set_pte_ext)
+#endif
+
+#endif
diff --git a/arch/arm/include/asm/glue.h b/arch/arm/include/asm/glue.h
index 234a3fc..0ec35d1 100644
--- a/arch/arm/include/asm/glue.h
+++ b/arch/arm/include/asm/glue.h
@@ -15,7 +15,6 @@
  */
 #ifdef __KERNEL__
 
-
 #ifdef __STDC__
 #define ____glue(name,fn)	name##fn
 #else
@@ -23,141 +22,4 @@
 #endif
 #define __glue(name,fn)		____glue(name,fn)
 
-
-
-/*
- *	Data Abort Model
- *	================
- *
- *	We have the following to choose from:
- *	  arm6          - ARM6 style
- *	  arm7		- ARM7 style
- *	  v4_early	- ARMv4 without Thumb early abort handler
- *	  v4t_late	- ARMv4 with Thumb late abort handler
- *	  v4t_early	- ARMv4 with Thumb early abort handler
- *	  v5tej_early	- ARMv5 with Thumb and Java early abort handler
- *	  xscale	- ARMv5 with Thumb with Xscale extensions
- *	  v6_early	- ARMv6 generic early abort handler
- *	  v7_early	- ARMv7 generic early abort handler
- */
-#undef CPU_DABORT_HANDLER
-#undef MULTI_DABORT
-
-#if defined(CONFIG_CPU_ARM610)
-# ifdef CPU_DABORT_HANDLER
-#  define MULTI_DABORT 1
-# else
-#  define CPU_DABORT_HANDLER cpu_arm6_data_abort
-# endif
-#endif
-
-#if defined(CONFIG_CPU_ARM710)
-# ifdef CPU_DABORT_HANDLER
-#  define MULTI_DABORT 1
-# else
-#  define CPU_DABORT_HANDLER cpu_arm7_data_abort
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ABRT_LV4T
-# ifdef CPU_DABORT_HANDLER
-#  define MULTI_DABORT 1
-# else
-#  define CPU_DABORT_HANDLER v4t_late_abort
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ABRT_EV4
-# ifdef CPU_DABORT_HANDLER
-#  define MULTI_DABORT 1
-# else
-#  define CPU_DABORT_HANDLER v4_early_abort
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ABRT_EV4T
-# ifdef CPU_DABORT_HANDLER
-#  define MULTI_DABORT 1
-# else
-#  define CPU_DABORT_HANDLER v4t_early_abort
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ABRT_EV5TJ
-# ifdef CPU_DABORT_HANDLER
-#  define MULTI_DABORT 1
-# else
-#  define CPU_DABORT_HANDLER v5tj_early_abort
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ABRT_EV5T
-# ifdef CPU_DABORT_HANDLER
-#  define MULTI_DABORT 1
-# else
-#  define CPU_DABORT_HANDLER v5t_early_abort
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ABRT_EV6
-# ifdef CPU_DABORT_HANDLER
-#  define MULTI_DABORT 1
-# else
-#  define CPU_DABORT_HANDLER v6_early_abort
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ABRT_EV7
-# ifdef CPU_DABORT_HANDLER
-#  define MULTI_DABORT 1
-# else
-#  define CPU_DABORT_HANDLER v7_early_abort
-# endif
-#endif
-
-#ifndef CPU_DABORT_HANDLER
-#error Unknown data abort handler type
-#endif
-
-/*
- *	Prefetch Abort Model
- *	================
- *
- *	We have the following to choose from:
- *	  legacy	- no IFSR, no IFAR
- *	  v6		- ARMv6: IFSR, no IFAR
- *	  v7		- ARMv7: IFSR and IFAR
- */
-
-#undef CPU_PABORT_HANDLER
-#undef MULTI_PABORT
-
-#ifdef CONFIG_CPU_PABRT_LEGACY
-# ifdef CPU_PABORT_HANDLER
-#  define MULTI_PABORT 1
-# else
-#  define CPU_PABORT_HANDLER legacy_pabort
-# endif
-#endif
-
-#ifdef CONFIG_CPU_PABRT_V6
-# ifdef CPU_PABORT_HANDLER
-#  define MULTI_PABORT 1
-# else
-#  define CPU_PABORT_HANDLER v6_pabort
-# endif
-#endif
-
-#ifdef CONFIG_CPU_PABRT_V7
-# ifdef CPU_PABORT_HANDLER
-#  define MULTI_PABORT 1
-# else
-#  define CPU_PABORT_HANDLER v7_pabort
-# endif
-#endif
-
-#ifndef CPU_PABORT_HANDLER
-#error Unknown prefetch abort handler type
-#endif
-
 #endif
diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index 8fdae9b..6980215 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -13,248 +13,77 @@
 
 #ifdef __KERNEL__
 
+#include <asm/glue-proc.h>
+#include <asm/page.h>
 
-/*
- * Work out if we need multiple CPU support
- */
-#undef MULTI_CPU
-#undef CPU_NAME
+#ifndef __ASSEMBLY__
+
+struct mm_struct;
 
 /*
- * CPU_NAME - the prefix for CPU related functions
+ * Don't change this structure - ASM code relies on it.
  */
-
-#ifdef CONFIG_CPU_ARM610
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm6
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ARM7TDMI
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm7tdmi
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ARM710
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm7
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ARM720T
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm720
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ARM740T
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm740
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ARM9TDMI
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm9tdmi
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ARM920T
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm920
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ARM922T
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm922
-# endif
-#endif
-
-#ifdef CONFIG_CPU_FA526
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_fa526
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ARM925T
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm925
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ARM926T
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm926
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ARM940T
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm940
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ARM946E
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm946
-# endif
-#endif
-
-#ifdef CONFIG_CPU_SA110
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_sa110
-# endif
-#endif
-
-#ifdef CONFIG_CPU_SA1100
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_sa1100
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ARM1020
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm1020
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ARM1020E
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm1020e
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ARM1022
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm1022
-# endif
-#endif
-
-#ifdef CONFIG_CPU_ARM1026
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_arm1026
-# endif
-#endif
-
-#ifdef CONFIG_CPU_XSCALE
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_xscale
-# endif
-#endif
-
-#ifdef CONFIG_CPU_XSC3
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_xsc3
-# endif
-#endif
-
-#ifdef CONFIG_CPU_MOHAWK
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_mohawk
-# endif
-#endif
-
-#ifdef CONFIG_CPU_FEROCEON
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_feroceon
-# endif
-#endif
-
-#ifdef CONFIG_CPU_V6
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_v6
-# endif
-#endif
-
-#ifdef CONFIG_CPU_V7
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_v7
-# endif
-#endif
-
-#ifndef __ASSEMBLY__
+extern struct processor {
+	/* MISC
+	 * get data abort address/flags
+	 */
+	void (*_data_abort)(unsigned long pc);
+	/*
+	 * Retrieve prefetch fault address
+	 */
+	unsigned long (*_prefetch_abort)(unsigned long lr);
+	/*
+	 * Set up any processor specifics
+	 */
+	void (*_proc_init)(void);
+	/*
+	 * Disable any processor specifics
+	 */
+	void (*_proc_fin)(void);
+	/*
+	 * Special stuff for a reset
+	 */
+	void (*reset)(unsigned long addr) __attribute__((noreturn));
+	/*
+	 * Idle the processor
+	 */
+	int (*_do_idle)(void);
+	/*
+	 * Processor architecture specific
+	 */
+	/*
+	 * clean a virtual address range from the
+	 * D-cache without flushing the cache.
+	 */
+	void (*dcache_clean_area)(void *addr, int size);
+
+	/*
+	 * Set the page table
+	 */
+	void (*switch_mm)(unsigned long pgd_phys, struct mm_struct *mm);
+	/*
+	 * Set a possibly extended PTE.  Non-extended PTEs should
+	 * ignore 'ext'.
+	 */
+	void (*set_pte_ext)(pte_t *ptep, pte_t pte, unsigned int ext);
+} processor;
 
 #ifndef MULTI_CPU
-#include <asm/cpu-single.h>
+extern void cpu_proc_init(void);
+extern void cpu_proc_fin(void);
+extern int cpu_do_idle(void);
+extern void cpu_dcache_clean_area(void *, int);
+extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
+extern void cpu_set_pte_ext(pte_t *ptep, pte_t pte, unsigned int ext);
+extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
 #else
-#include <asm/cpu-multi32.h>
+#define cpu_proc_init()			processor._proc_init()
+#define cpu_proc_fin()			processor._proc_fin()
+#define cpu_reset(addr)			processor.reset(addr)
+#define cpu_do_idle()			processor._do_idle()
+#define cpu_dcache_clean_area(addr,sz)	processor.dcache_clean_area(addr,sz)
+#define cpu_set_pte_ext(ptep,pte,ext)	processor.set_pte_ext(ptep,pte,ext)
+#define cpu_do_switch_mm(pgd,mm)	processor.switch_mm(pgd,mm)
 #endif
 
 #include <asm/memory.h>
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 82da661..5302a91 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -13,6 +13,8 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
+#include <asm/glue-df.h>
+#include <asm/glue-pf.h>
 #include <asm/mach/arch.h>
 #include <asm/thread_info.h>
 #include <asm/memory.h>
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 2b46fea..e8d8856 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -16,7 +16,8 @@
  */
 
 #include <asm/memory.h>
-#include <asm/glue.h>
+#include <asm/glue-df.h>
+#include <asm/glue-pf.h>
 #include <asm/vfpmacros.h>
 #include <mach/entry-macro.S>
 #include <asm/thread_notify.h>
-- 
1.6.2.5

