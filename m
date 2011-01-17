From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 04/14] ARM: v6k: introduce CPU_V6K option
Date: Mon, 17 Jan 2011 19:22:21 +0000
Message-ID: <E1Peuej-0003SV-Dn@rmk-PC.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59824 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab1AQTah (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 14:30:37 -0500
In-Reply-To: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Introduce a CPU_V6K configuration option for platforms to select if they
have a V6K CPU core.  This allows us to identify whether we need to
support ARMv6 CPUs without the V6K SMP extensions at build time.

Currently CPU_V6K is just an alias for CPU_V6, and all places which
reference CPU_V6 are replaced by (CPU_V6 || CPU_V6K).

Select CPU_V6K from platforms which are known to be V6K-only.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig                  |   10 ++++----
 arch/arm/Makefile                 |    1 +
 arch/arm/boot/compressed/head.S   |    2 +-
 arch/arm/boot/compressed/misc.c   |    2 +-
 arch/arm/include/asm/cacheflush.h |    5 ++-
 arch/arm/include/asm/proc-fns.h   |    2 +-
 arch/arm/kernel/debug.S           |    2 +-
 arch/arm/kernel/perf_event_v6.c   |    4 +-
 arch/arm/mm/Kconfig               |   47 +++++++++++++++++++++++-------------
 arch/arm/mm/Makefile              |    1 +
 arch/arm/mm/mmap.c                |    2 +-
 11 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5cff165..95ba92f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -24,7 +24,7 @@ config ARM
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
 	select HAVE_REGS_AND_STACK_ACCESS_API
-	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V7))
+	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7))
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_GENERIC_HARDIRQS
 	select HAVE_SPARSE_IRQ
@@ -1048,7 +1048,7 @@ config XSCALE_PMU
 	default y
 
 config CPU_HAS_PMU
-	depends on (CPU_V6 || CPU_V7 || XSCALE_PMU) && \
+	depends on (CPU_V6 || CPU_V6K || CPU_V7 || XSCALE_PMU) && \
 		   (!ARCH_OMAP3 || OMAP3_EMU)
 	default y
 	bool
@@ -1064,7 +1064,7 @@ endif
 
 config ARM_ERRATA_411920
 	bool "ARM errata: Invalidation of the Instruction Cache operation can fail"
-	depends on CPU_V6
+	depends on CPU_V6 || CPU_V6K
 	help
 	  Invalidation of the Instruction Cache operation can
 	  fail. This erratum is present in 1136 (before r1p4), 1156 and 1176.
@@ -1361,7 +1361,7 @@ config HZ
 
 config THUMB2_KERNEL
 	bool "Compile the kernel in Thumb-2 mode (EXPERIMENTAL)"
-	depends on CPU_V7 && !CPU_V6 && EXPERIMENTAL
+	depends on CPU_V7 && !CPU_V6 && !CPU_V6K && EXPERIMENTAL
 	select AEABI
 	select ARM_ASM_UNIFIED
 	help
@@ -1852,7 +1852,7 @@ config FPE_FASTFPE
 
 config VFP
 	bool "VFP-format floating point maths"
-	depends on CPU_V6 || CPU_ARM926T || CPU_V7 || CPU_FEROCEON
+	depends on CPU_V6 || CPU_V6K || CPU_ARM926T || CPU_V7 || CPU_FEROCEON
 	help
 	  Say Y to include VFP support code in the kernel. This is needed
 	  if your hardware includes a VFP unit.
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c22c1ad..9c43052 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -89,6 +89,7 @@ tune-$(CONFIG_CPU_XSCALE)	:=$(call cc-option,-mtune=xscale,-mtune=strongarm110)
 tune-$(CONFIG_CPU_XSC3)		:=$(call cc-option,-mtune=xscale,-mtune=strongarm110) -Wa,-mcpu=xscale
 tune-$(CONFIG_CPU_FEROCEON)	:=$(call cc-option,-mtune=marvell-f,-mtune=xscale)
 tune-$(CONFIG_CPU_V6)		:=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
+tune-$(CONFIG_CPU_V6K)		:=$(call cc-option,-mtune=arm1136j-s,-mtune=strongarm)
 
 ifeq ($(CONFIG_AEABI),y)
 CFLAGS_ABI	:=-mabi=aapcs-linux -mno-thumb-interwork
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 7193884..91f20f0 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -21,7 +21,7 @@
 
 #if defined(CONFIG_DEBUG_ICEDCC)
 
-#ifdef CONFIG_CPU_V6
+#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
 		.macro	loadsp, rb, tmp
 		.endm
 		.macro	writeb, ch, rb
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index e653a6d..4657e87 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -36,7 +36,7 @@ extern void error(char *x);
 
 #ifdef CONFIG_DEBUG_ICEDCC
 
-#ifdef CONFIG_CPU_V6
+#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
 
 static void icedcc_putc(int ch)
 {
diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 3acd8fa..7d0614f 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -116,7 +116,7 @@
 # define MULTI_CACHE 1
 #endif
 
-#if defined(CONFIG_CPU_V6)
+#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
 //# ifdef _CACHE
 #  define MULTI_CACHE 1
 //# else
@@ -316,7 +316,8 @@ extern void copy_to_user_page(struct vm_area_struct *, struct page *,
  * Optimized __flush_icache_all for the common cases. Note that UP ARMv7
  * will fall through to use __flush_icache_all_generic.
  */
-#if (defined(CONFIG_CPU_V7) && defined(CONFIG_CPU_V6)) ||		\
+#if (defined(CONFIG_CPU_V7) && \
+     (defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K))) || \
 	defined(CONFIG_SMP_ON_UP)
 #define __flush_icache_preferred	__cpuc_flush_icache_all
 #elif __LINUX_ARM_ARCH__ >= 7 && defined(CONFIG_SMP)
diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index 8fdae9b..296ca47 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -231,7 +231,7 @@
 # endif
 #endif
 
-#ifdef CONFIG_CPU_V6
+#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
 # ifdef CPU_NAME
 #  undef  MULTI_CPU
 #  define MULTI_CPU
diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index a0f0752..d2d983b 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -25,7 +25,7 @@
 		.macro	addruart, rp, rv
 		.endm
 
-#if defined(CONFIG_CPU_V6)
+#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
 
 		.macro	senduart, rd, rx
 		mcr	p14, 0, \rd, c0, c5, 0
diff --git a/arch/arm/kernel/perf_event_v6.c b/arch/arm/kernel/perf_event_v6.c
index c058bfc..6fc2d22 100644
--- a/arch/arm/kernel/perf_event_v6.c
+++ b/arch/arm/kernel/perf_event_v6.c
@@ -30,7 +30,7 @@
  * enable the interrupt.
  */
 
-#ifdef CONFIG_CPU_V6
+#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
 enum armv6_perf_types {
 	ARMV6_PERFCTR_ICACHE_MISS	    = 0x0,
 	ARMV6_PERFCTR_IBUF_STALL	    = 0x1,
@@ -669,4 +669,4 @@ static const struct arm_pmu *__init armv6mpcore_pmu_init(void)
 {
 	return NULL;
 }
-#endif	/* CONFIG_CPU_V6 */
+#endif	/* CONFIG_CPU_V6 || CONFIG_CPU_V6K */
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 9d30c6f..559e933 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -402,16 +402,18 @@ config CPU_V6
 	select CPU_TLB_V6 if MMU
 
 # ARMv6k
-config CPU_32v6K
-	bool "Support ARM V6K processor extensions" if !SMP
-	depends on CPU_V6 || CPU_V7
-	default y if SMP && !(ARCH_MX3 || ARCH_OMAP2)
-	help
-	  Say Y here if your ARMv6 processor supports the 'K' extension.
-	  This enables the kernel to use some instructions not present
-	  on previous processors, and as such a kernel build with this
-	  enabled will not boot on processors with do not support these
-	  instructions.
+config CPU_V6K
+	bool "Support ARM V6K processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_DOVE
+	select CPU_32v6
+	select CPU_32v6K if !ARCH_OMAP2
+	select CPU_ABRT_EV6
+	select CPU_PABRT_V6
+	select CPU_CACHE_V6
+	select CPU_CACHE_VIPT
+	select CPU_CP15_MMU
+	select CPU_HAS_ASID if MMU
+	select CPU_COPY_V6 if MMU
+	select CPU_TLB_V6 if MMU
 
 # ARMv7
 config CPU_V7
@@ -453,6 +455,17 @@ config CPU_32v6
 	bool
 	select TLS_REG_EMUL if !CPU_32v6K && !MMU
 
+config CPU_32v6K
+	bool "Support ARM V6K processor extensions" if !SMP
+	depends on CPU_V6 || CPU_V6K || CPU_V7
+	default y if SMP && !(ARCH_MX3 || ARCH_OMAP2)
+	help
+	  Say Y here if your ARMv6 processor supports the 'K' extension.
+	  This enables the kernel to use some instructions not present
+	  on previous processors, and as such a kernel build with this
+	  enabled will not boot on processors with do not support these
+	  instructions.
+
 config CPU_32v7
 	bool
 
@@ -623,7 +636,7 @@ comment "Processor Features"
 
 config ARM_THUMB
 	bool "Support Thumb user binaries"
-	depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || CPU_ARM1020 || CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_V6 || CPU_V7 || CPU_FEROCEON
+	depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || CPU_ARM1020 || CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_V6 || CPU_V6K || CPU_V7 || CPU_FEROCEON
 	default y
 	help
 	  Say Y if you want to include kernel support for running user space
@@ -681,7 +694,7 @@ config CPU_BIG_ENDIAN
 config CPU_ENDIAN_BE8
 	bool
 	depends on CPU_BIG_ENDIAN
-	default CPU_V6 || CPU_V7
+	default CPU_V6 || CPU_V6K || CPU_V7
 	help
 	  Support for the BE-8 (big-endian) mode on ARMv6 and ARMv7 processors.
 
@@ -747,7 +760,7 @@ config CPU_CACHE_ROUND_ROBIN
 
 config CPU_BPREDICT_DISABLE
 	bool "Disable branch prediction"
-	depends on CPU_ARM1020 || CPU_V6 || CPU_MOHAWK || CPU_XSC3 || CPU_V7 || CPU_FA526
+	depends on CPU_ARM1020 || CPU_V6 || CPU_V6K || CPU_MOHAWK || CPU_XSC3 || CPU_V7 || CPU_FA526
 	help
 	  Say Y here to disable branch prediction.  If unsure, say N.
 
@@ -767,7 +780,7 @@ config NEEDS_SYSCALL_FOR_CMPXCHG
 
 config DMA_CACHE_RWFO
 	bool "Enable read/write for ownership DMA cache maintenance"
-	depends on CPU_V6 && SMP
+	depends on (CPU_V6 || CPU_V6K) && SMP
 	default y
 	help
 	  The Snoop Control Unit on ARM11MPCore does not detect the
@@ -823,7 +836,7 @@ config CACHE_L2X0
 config CACHE_PL310
 	bool
 	depends on CACHE_L2X0
-	default y if CPU_V7 && !CPU_V6
+	default y if CPU_V7 && !(CPU_V6 || CPU_V6K)
 	help
 	  This option enables optimisations for the PL310 cache
 	  controller.
@@ -851,10 +864,10 @@ config ARM_L1_CACHE_SHIFT
 	default 5
 
 config ARM_DMA_MEM_BUFFERABLE
-	bool "Use non-cacheable memory for DMA" if CPU_V6 && !CPU_V7
+	bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K) && !CPU_V7
 	depends on !(MACH_REALVIEW_PB1176 || REALVIEW_EB_ARM11MP || \
 		     MACH_REALVIEW_PB11MP)
-	default y if CPU_V6 || CPU_V7
+	default y if CPU_V6 || CPU_V6K || CPU_V7
 	help
 	  Historically, the kernel has used strongly ordered mappings to
 	  provide DMA coherent memory.  With the advent of ARMv7, mapping
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 00d74a0..bca7e61 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_CPU_XSC3)		+= proc-xsc3.o
 obj-$(CONFIG_CPU_MOHAWK)	+= proc-mohawk.o
 obj-$(CONFIG_CPU_FEROCEON)	+= proc-feroceon.o
 obj-$(CONFIG_CPU_V6)		+= proc-v6.o
+obj-$(CONFIG_CPU_V6K)		+= proc-v6.o
 obj-$(CONFIG_CPU_V7)		+= proc-v7.o
 
 AFLAGS_proc-v6.o	:=-Wa,-march=armv6
diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index b0a9830..afe209e 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -31,7 +31,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long start_addr;
-#ifdef CONFIG_CPU_V6
+#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
 	unsigned int cache_type;
 	int do_align = 0, aliasing = 0;
 
-- 
1.6.2.5

