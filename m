From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH RFC 1/2] ARM: move heavy barrier support out of line
Date: Wed, 03 Jun 2015 13:35:15 +0100
Message-ID: <E1Z07t5-0001TP-7f@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:34567 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755543AbbFCMfT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2015 08:35:19 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The existing memory barrier macro causes a significant amount of code
to be inserted inline at every call site.  For example, in
gpio_set_irq_type(), we have this for mb():

c0344c08:       f57ff04e        dsb     st
c0344c0c:       e59f8190        ldr     r8, [pc, #400]  ; c0344da4 <gpio_set_irq_type+0x230>
c0344c10:       e3590004        cmp     r9, #4
c0344c14:       e5983014        ldr     r3, [r8, #20]
c0344c18:       0a000054        beq     c0344d70 <gpio_set_irq_type+0x1fc>
c0344c1c:       e3530000        cmp     r3, #0
c0344c20:       0a000004        beq     c0344c38 <gpio_set_irq_type+0xc4>
c0344c24:       e50b2030        str     r2, [fp, #-48]  ; 0xffffffd0
c0344c28:       e50bc034        str     ip, [fp, #-52]  ; 0xffffffcc
c0344c2c:       e12fff33        blx     r3
c0344c30:       e51bc034        ldr     ip, [fp, #-52]  ; 0xffffffcc
c0344c34:       e51b2030        ldr     r2, [fp, #-48]  ; 0xffffffd0
c0344c38:       e5963004        ldr     r3, [r6, #4]

Moving the outer_cache_sync() call out of line reduces the impact of
the barrier:

c0344968:       f57ff04e        dsb     st
c034496c:       e35a0004        cmp     sl, #4
c0344970:       e50b2030        str     r2, [fp, #-48]  ; 0xffffffd0
c0344974:       0a000044        beq     c0344a8c <gpio_set_irq_type+0x1b8>
c0344978:       ebf363dd        bl      c001d8f4 <arm_heavy_mb>
c034497c:       e5953004        ldr     r3, [r5, #4]

This should reduce the cache footprint of this code.  Overall, this
results in a reduction of around 20K in the kernel size:

    text    data      bss      dec     hex filename
10773970  667392 10369656 21811018 14ccf4a ../build/imx6/vmlinux-old
10754219  667392 10369656 21791267 14c8223 ../build/imx6/vmlinux-new

Another advantage to this approach is that we can finally resolve the
issue of SoCs which have their own memory barrier requirements within
multiplatform kernels (such as OMAP.)  Here, the bus interconnects
need additional handling to ensure that writes become visible in the
correct order (eg, between dma_map() operations, writes to DMA
coherent memory, and MMIO accesses.)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/barrier.h              | 12 ++++++++---
 arch/arm/include/asm/outercache.h           | 17 ---------------
 arch/arm/kernel/irq.c                       |  1 +
 arch/arm/mach-omap2/include/mach/barriers.h | 33 -----------------------------
 arch/arm/mm/Kconfig                         |  4 ++++
 arch/arm/mm/flush.c                         | 11 ++++++++++
 6 files changed, 25 insertions(+), 53 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/include/mach/barriers.h

diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
index d2f81e6b8c1c..646539a903a2 100644
--- a/arch/arm/include/asm/barrier.h
+++ b/arch/arm/include/asm/barrier.h
@@ -2,7 +2,6 @@
 #define __ASM_BARRIER_H
 
 #ifndef __ASSEMBLY__
-#include <asm/outercache.h>
 
 #define nop() __asm__ __volatile__("mov\tr0,r0\t@ nop\n\t");
 
@@ -37,12 +36,19 @@
 #define dmb(x) __asm__ __volatile__ ("" : : : "memory")
 #endif
 
+#ifdef CONFIG_ARM_HEAVY_MB
+extern void arm_heavy_mb(void);
+#define __arm_heavy_mb(x...) do { dsb(x); arm_heavy_mb(); } while (0)
+#else
+#define __arm_heavy_mb(x...) dsb(x)
+#endif
+
 #ifdef CONFIG_ARCH_HAS_BARRIERS
 #include <mach/barriers.h>
 #elif defined(CONFIG_ARM_DMA_MEM_BUFFERABLE) || defined(CONFIG_SMP)
-#define mb()		do { dsb(); outer_sync(); } while (0)
+#define mb()		__arm_heavy_mb()
 #define rmb()		dsb()
-#define wmb()		do { dsb(st); outer_sync(); } while (0)
+#define wmb()		__arm_heavy_mb(st)
 #define dma_rmb()	dmb(osh)
 #define dma_wmb()	dmb(oshst)
 #else
diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index 563b92fc2f41..c2bf24f40177 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -129,21 +129,4 @@ static inline void outer_resume(void) { }
 
 #endif
 
-#ifdef CONFIG_OUTER_CACHE_SYNC
-/**
- * outer_sync - perform a sync point for outer cache
- *
- * Ensure that all outer cache operations are complete and any store
- * buffers are drained.
- */
-static inline void outer_sync(void)
-{
-	if (outer_cache.sync)
-		outer_cache.sync();
-}
-#else
-static inline void outer_sync(void)
-{ }
-#endif
-
 #endif	/* __ASM_OUTERCACHE_H */
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 350f188c92d2..b96c8ed1723a 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -39,6 +39,7 @@
 #include <linux/export.h>
 
 #include <asm/hardware/cache-l2x0.h>
+#include <asm/outercache.h>
 #include <asm/exception.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/irq.h>
diff --git a/arch/arm/mach-omap2/include/mach/barriers.h b/arch/arm/mach-omap2/include/mach/barriers.h
deleted file mode 100644
index 1c582a8592b9..000000000000
--- a/arch/arm/mach-omap2/include/mach/barriers.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- * OMAP memory barrier header.
- *
- * Copyright (C) 2011 Texas Instruments, Inc.
- *  Santosh Shilimkar <santosh.shilimkar@ti.com>
- *  Richard Woodruff <r-woodruff2@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
- */
-
-#ifndef __MACH_BARRIERS_H
-#define __MACH_BARRIERS_H
-
-#include <asm/outercache.h>
-
-extern void omap_bus_sync(void);
-
-#define rmb()		dsb()
-#define wmb()		do { dsb(); outer_sync(); omap_bus_sync(); } while (0)
-#define mb()		wmb()
-
-#endif	/* __MACH_BARRIERS_H */
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index fc5ff68a4789..027d743e34a3 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -895,6 +895,7 @@ config OUTER_CACHE
 
 config OUTER_CACHE_SYNC
 	bool
+	select ARM_HEAVY_MB
 	help
 	  The outer cache has a outer_cache_fns.sync function pointer
 	  that can be used to drain the write buffer of the outer cache.
@@ -1043,6 +1044,9 @@ config ARCH_HAS_BARRIERS
 	  This option allows the use of custom mandatory barriers
 	  included via the mach/barriers.h file.
 
+config ARM_HEAVY_MB
+	bool
+
 config ARCH_SUPPORTS_BIG_ENDIAN
 	bool
 	help
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 34b66af516ea..ce6c2960d5ac 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -21,6 +21,17 @@
 
 #include "mm.h"
 
+#ifdef CONFIG_ARM_HEAVY_MB
+void arm_heavy_mb(void)
+{
+#ifdef CONFIG_OUTER_CACHE_SYNC
+	if (outer_cache.sync)
+		outer_cache.sync();
+#endif
+}
+EXPORT_SYMBOL(arm_heavy_mb);
+#endif
+
 #ifdef CONFIG_CPU_CACHE_VIPT
 
 static void flush_pfn_alias(unsigned long pfn, unsigned long vaddr)
-- 
2.1.0

