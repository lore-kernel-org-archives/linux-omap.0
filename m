From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 24/24] OMAP4: Fix errata i688 with MPU interconnect barriers.
Date: Sat, 24 Sep 2011 11:44:44 +0530
Message-ID: <1316844884-21700-25-git-send-email-santosh.shilimkar@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44281 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290Ab1IXGP0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 24 Sep 2011 02:15:26 -0400
In-Reply-To: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>, Russell King <linux@arm.linux.org.uk>

On OMAP4 SOC, intecronnects has many write buffers in the async bridges
and they need to be drained before CPU enters into standby state.

Patch 'OMAP4: PM: Add CPUX OFF mode support' added CPU PM support
but OMAP errata i688 (Async Bridge Corruption) needs to be taken
care to avoid issues like system freeze, CPU deadlocks, random
crashes with register accesses, synchronisation loss on initiators
operating on both interconnect port simultaneously.

As per the errata, if a data is stalled inside asynchronous bridge
because of back pressure, it may be accepted multiple times, creating
pointer misalignment that will corrupt next transfers on that data
path until next reset of the system (No recovery procedure once
the issue is hit, the path remains consistently broken).
Async bridge can be found on path between MPU to EMIF and
MPU to L3 interconnect. This situation can happen only when the
idle is initiated by a Master Request Disconnection (which is
trigged by software when executing WFI on CPU).

The work-around for this errata needs all the initiators
connected through async bridge must ensure that data path
is properly drained before issuing WFI. This condition will be
met if one Strongly ordered access is performed to the
target right before executing the WFI. In MPU case, L3 T2ASYNC
FIFO and DDR T2ASYNC FIFO needs to be drained. IO barrier ensure
that there is no synchronisation loss on initiators operating
on both interconnect port simultaneously.

Thanks to Russell for a tip to conver assembly function to
C fuction there by reducing 40 odd lines of code from the patch.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
Acked-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-omap2/Kconfig                     |   21 +++++++++++
 arch/arm/mach-omap2/include/mach/barriers.h     |   31 ++++++++++++++++
 arch/arm/mach-omap2/include/mach/omap4-common.h |    4 ++
 arch/arm/mach-omap2/omap4-common.c              |   44 +++++++++++++++++++++++
 arch/arm/mach-omap2/sleep44xx.S                 |    8 ++++
 arch/arm/plat-omap/sram.c                       |   43 ++++++++++++++--------
 6 files changed, 136 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/barriers.h

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 57b66d5..767a587 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -345,6 +345,27 @@ config OMAP3_SDRC_AC_TIMING
 	  wish to say no.  Selecting yes without understanding what is
 	  going on could result in system crashes;
 
+config OMAP4_ERRATA_I688
+	bool "OMAP4 errata: Async Bridge Corruption"
+	depends on ARCH_OMAP4
+	select ARCH_HAS_BARRIERS
+	help
+	  If a data is stalled inside asynchronous bridge because of back
+	  pressure, it may be accepted multiple times, creating pointer
+	  misalignment that will corrupt next transfers on that data path
+	  until next reset of the system (No recovery procedure once the
+	  issue is hit, the path remains consistently broken). Async bridge
+	  can be found on path between MPU to EMIF and MPU to L3 interconnect.
+	  This situation can happen only when the idle is initiated by a
+	  Master Request Disconnection (which is trigged by software when
+	  executing WFI on CPU).
+	  The work-around for this errata needs all the initiators connected
+	  through async bridge must ensure that data path is properly drained
+	  before issuing WFI. This condition will be met if one Strongly ordered
+	  access is performed to the target right before executing the WFI.
+	  In MPU case, L3 T2ASYNC FIFO and DDR T2ASYNC FIFO needs to be drained.
+	  IO barrier ensure that there is no synchronisation loss on initiators
+	  operating on both interconnect port simultaneously.
 endmenu
 
 endif
diff --git a/arch/arm/mach-omap2/include/mach/barriers.h b/arch/arm/mach-omap2/include/mach/barriers.h
new file mode 100644
index 0000000..4fa72c7
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/barriers.h
@@ -0,0 +1,31 @@
+/*
+ * OMAP memory barrier header.
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ *  Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *  Richard Woodruff <r-woodruff2@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef __MACH_BARRIERS_H
+#define __MACH_BARRIERS_H
+
+extern void omap_bus_sync(void);
+
+#define rmb()		dsb()
+#define wmb()		do { dsb(); outer_sync(); omap_bus_sync(); } while (0)
+#define mb()		wmb()
+
+#endif	/* __MACH_BARRIERS_H */
diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index 1f6ae1d..8aa3420 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -15,11 +15,15 @@
 
 #include <asm/proc-fns.h>
 
+/* Used to implement memory barrier on DRAM path */
+#define OMAP4_DRAM_BARRIER_VA			0xfe600000
+
 #ifndef __ASSEMBLER__
 
 #ifdef CONFIG_CACHE_L2X0
 extern void __iomem *omap4_get_l2cache_base(void);
 #endif
+extern void __iomem *dram_sync, *sram_sync;
 
 #ifdef CONFIG_SMP
 extern void __iomem *omap4_get_scu_base(void);
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 17274c0..29bb097 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -15,9 +15,11 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/memblock.h>
 
 #include <asm/hardware/gic.h>
 #include <asm/hardware/cache-l2x0.h>
+#include <asm/mach/map.h>
 
 #include <plat/irqs.h>
 
@@ -32,9 +34,51 @@ static void __iomem *l2cache_base;
 #endif
 
 void __iomem *gic_dist_base_addr;
+void __iomem *dram_sync, *sram_sync;
 
 static void __iomem *sar_ram_base;
 
+#ifdef CONFIG_OMAP4_ERRATA_I688
+void omap_bus_sync(void)
+{
+	if (dram_sync && sram_sync) {
+		writel_relaxed(readl_relaxed(dram_sync), dram_sync);
+		writel_relaxed(readl_relaxed(sram_sync), sram_sync);
+		isb();
+	}
+}
+
+static int __init omap_barriers_init(void)
+{
+	struct map_desc dram_io_desc[1];
+	phys_addr_t paddr;
+	u32 size;
+
+	if (!cpu_is_omap44xx())
+		return -ENODEV;
+
+	size = ALIGN(PAGE_SIZE, SZ_1M);
+	paddr = memblock_alloc(size, SZ_1M);
+	if (!paddr) {
+		pr_err("%s: failed to reserve 4 Kbytes\n", __func__);
+		return -ENOMEM;
+	}
+	memblock_free(paddr, size);
+	memblock_remove(paddr, size);
+	dram_io_desc[0].virtual = OMAP4_DRAM_BARRIER_VA;
+	dram_io_desc[0].pfn = __phys_to_pfn(paddr);
+	dram_io_desc[0].length = size;
+	dram_io_desc[0].type = MT_MEMORY_SO;
+	iotable_init(dram_io_desc, ARRAY_SIZE(dram_io_desc));
+	dram_sync = (void __iomem *) dram_io_desc[0].virtual;
+
+	pr_info("OMAP4: Map 0x%08llx to 0x%08lx for dram barrier\n",
+		(long long) paddr, dram_io_desc[0].virtual);
+
+	return 0;
+}
+core_initcall(omap_barriers_init);
+#endif
 
 void __init gic_init_irq(void)
 {
diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
index 94935bc..5e3f474 100644
--- a/arch/arm/mach-omap2/sleep44xx.S
+++ b/arch/arm/mach-omap2/sleep44xx.S
@@ -324,8 +324,16 @@ skip_l2en:
 ENDPROC(omap4_cpu_resume)
 #endif
 
+#ifndef CONFIG_OMAP4_ERRATA_I688
+ENTRY(omap_bus_sync)
+	mov	pc, lr
+ENDPROC(omap_bus_sync)
+#endif
+
 ENTRY(omap_do_wfi)
 	stmfd	sp!, {lr}
+	/* Drain interconnect write buffers. */
+	bl omap_bus_sync
 
 	/*
 	 * Execute an ISB instruction to ensure that all of the
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 363c91e..e5e4989 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -23,13 +23,13 @@
 
 #include <asm/tlb.h>
 #include <asm/cacheflush.h>
-
 #include <asm/mach/map.h>
 
 #include <plat/sram.h>
 #include <plat/board.h>
 #include <plat/cpu.h>
 #include <plat/vram.h>
+#include <mach/omap4-common.h>
 
 #include "sram.h"
 #include "fb.h"
@@ -185,24 +185,25 @@ static void __init omap_detect_sram(void)
 	omap_sram_ceil = omap_sram_base + omap_sram_size;
 }
 
-static struct map_desc omap_sram_io_desc[] __initdata = {
-	{	/* .length gets filled in at runtime */
-		.virtual	= OMAP1_SRAM_VA,
-		.pfn		= __phys_to_pfn(OMAP1_SRAM_PA),
-		.type		= MT_MEMORY
-	}
-};
-
 /*
  * Note that we cannot use ioremap for SRAM, as clock init needs SRAM early.
  */
 static void __init omap_map_sram(void)
 {
 	unsigned long base;
+	struct map_desc omap_sram_io_desc[2];
+	int	nr_desc = 1;
 
 	if (omap_sram_size == 0)
 		return;
 
+	omap_sram_io_desc[0].virtual = omap_sram_base;
+	base = omap_sram_start;
+	base = ROUND_DOWN(base, PAGE_SIZE);
+	omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
+	omap_sram_io_desc[0].length = ROUND_DOWN(omap_sram_size, PAGE_SIZE);
+	omap_sram_io_desc[0].type = MT_MEMORY;
+
 	if (cpu_is_omap34xx()) {
 		/*
 		 * SRAM must be marked as non-cached on OMAP3 since the
@@ -212,14 +213,26 @@ static void __init omap_map_sram(void)
 		 * which will cause the system to hang.
 		 */
 		omap_sram_io_desc[0].type = MT_MEMORY_NONCACHED;
+	} else if (cpu_is_omap44xx()) {
+		omap_sram_io_desc[0].length =
+			ROUND_DOWN(omap_sram_size - PAGE_SIZE, PAGE_SIZE);
+		/*
+		 * Map a page of SRAM with strongly ordered attributes
+		 * for interconnect barrier usage.
+		 */
+		omap_sram_io_desc[1].virtual =
+			omap_sram_base + omap_sram_io_desc[0].length;
+		base = omap_sram_start + omap_sram_io_desc[0].length;
+		base = ROUND_DOWN(base, PAGE_SIZE);
+		omap_sram_io_desc[1].pfn = __phys_to_pfn(base);
+		omap_sram_io_desc[1].length = PAGE_SIZE;
+		omap_sram_io_desc[1].type = MT_MEMORY_SO;
+		nr_desc = 2;
+		sram_sync = (void __iomem *) omap_sram_io_desc[1].virtual;
 	}
 
-	omap_sram_io_desc[0].virtual = omap_sram_base;
-	base = omap_sram_start;
-	base = ROUND_DOWN(base, PAGE_SIZE);
-	omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
-	omap_sram_io_desc[0].length = ROUND_DOWN(omap_sram_size, PAGE_SIZE);
-	iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
+
+	iotable_init(omap_sram_io_desc, nr_desc);
 
 	pr_info("SRAM: Mapped pa 0x%08llx to va 0x%08lx size: 0x%lx\n",
 		(long long) __pfn_to_phys(omap_sram_io_desc[0].pfn),
-- 
1.7.4.1

