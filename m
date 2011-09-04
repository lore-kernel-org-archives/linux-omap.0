From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 02/25] OMAP4: Redefine mandatory barriers for OMAP to include interconnect barriers.
Date: Sun, 4 Sep 2011 19:24:03 +0530
Message-ID: <1315144466-9395-3-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38006 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754342Ab1IDNzf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 4 Sep 2011 09:55:35 -0400
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Richard Woodruff <r-woodruff2@ti.com>

On OMAP4 SOC intecronnects has many write buffers in the async bridges
and they can be drained only with stongly ordered accesses.

There are two ports as below from MPU and both needs to be drained.
	- MPU --> L3 T2ASYNC FIFO
	- MPU --> DDR T2ASYNC FIFO

Without the interconnect barriers, many issues have been observed
leading to system freeze, CPU deadlocks, random crashes with
register accesses, synchronization loss on initiators operating
on both interconnect port simultaneously.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
---
 arch/arm/mach-omap2/Kconfig                     |    1 +
 arch/arm/mach-omap2/Makefile                    |    3 +-
 arch/arm/mach-omap2/include/mach/barriers.h     |   48 ++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/omap4-common.h |    9 ++++-
 arch/arm/mach-omap2/omap4-common.c              |   50 +++++++++++++++++++++++
 arch/arm/mach-omap2/sleep44xx.S                 |   29 +++++++++++++
 arch/arm/plat-omap/include/plat/sram.h          |    1 +
 arch/arm/plat-omap/sram.c                       |   47 +++++++++++++++------
 8 files changed, 172 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/barriers.h
 create mode 100644 arch/arm/mach-omap2/sleep44xx.S

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 57b66d5..62f45e8 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -50,6 +50,7 @@ config ARCH_OMAP4
 	select ARCH_HAS_OPP
 	select PM_OPP if PM
 	select USB_ARCH_HAS_EHCI
+	select ARCH_HAS_BARRIERS
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f343365..42e4613 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -62,13 +62,14 @@ obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o \
 					   cpuidle34xx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o sleep44xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
 obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
 
 AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
 AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a$(plus_sec)
+AFLAGS_sleep44xx.o			:=-Wa,-march=armv7-a$(plus_sec)
 
 ifeq ($(CONFIG_PM_VERBOSE),y)
 CFLAGS_pm_bus.o				+= -DDEBUG
diff --git a/arch/arm/mach-omap2/include/mach/barriers.h b/arch/arm/mach-omap2/include/mach/barriers.h
new file mode 100644
index 0000000..aa72a33
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/barriers.h
@@ -0,0 +1,48 @@
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
+#include <linux/types.h>
+
+/* provide func ptr so to allow safe calling at any point */
+struct omap_bus_post_fns {
+	void (*sync)(void);
+};
+
+extern struct omap_bus_post_fns omap_bus_post;
+
+#ifdef CONFIG_ARCH_OMAP4
+static inline void bus_sync(void)
+{
+	omap_bus_post.sync();
+}
+#else
+static inline void bus_sync(void)
+{ }
+#endif
+
+#define rmb()		dsb()
+#define wmb()		do { dsb(); outer_sync(); bus_sync(); } while (0)
+#define mb()		wmb()
+
+#endif	/* __MACH_BARRIERS_H */
diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index e4bd87619..26653f6 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -13,6 +13,10 @@
 #ifndef OMAP_ARCH_OMAP4_COMMON_H
 #define OMAP_ARCH_OMAP4_COMMON_H
 
+/* Used to implement memory barrier on DRAM path */
+#define OMAP4_DRAM_BARRIER_VA		0xfe600000
+
+#ifndef __ASSEMBLER__
 /*
  * wfi used in low power code. Directly opcode is used instead
  * of instruction to avoid mulit-omap build break
@@ -32,6 +36,8 @@ extern void __iomem *gic_dist_base_addr;
 
 extern void __init gic_init_irq(void);
 extern void omap_smc1(u32 fn, u32 arg);
+extern void omap_bus_sync(void);
+extern unsigned long omap_get_dram_barrier_base(void);
 
 #ifdef CONFIG_SMP
 /* Needed for secondary core boot */
@@ -40,4 +46,5 @@ extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
 extern void omap_auxcoreboot_addr(u32 cpu_addr);
 extern u32 omap_read_auxcoreboot0(void);
 #endif
-#endif
+#endif /* __ASSEMBLER__ */
+#endif /* OMAP_ARCH_OMAP4_COMMON_H */
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 35ac3e5..4791370 100644
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
 
@@ -30,6 +32,54 @@ void __iomem *l2cache_base;
 
 void __iomem *gic_dist_base_addr;
 
+static unsigned long dram_barrier_base;
+
+static void omap_bus_sync_noop(void)
+{ }
+
+struct omap_bus_post_fns omap_bus_post = {
+	.sync = omap_bus_sync_noop,
+};
+EXPORT_SYMBOL(omap_bus_post);
+
+unsigned long omap_get_dram_barrier_base(void)
+{
+	return dram_barrier_base;
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
+
+	dram_io_desc[0].virtual = OMAP4_DRAM_BARRIER_VA;
+	dram_io_desc[0].pfn = __phys_to_pfn(paddr);
+	dram_barrier_base = dram_io_desc[0].virtual;
+	dram_io_desc[0].length = size;
+	dram_io_desc[0].type = MT_MEMORY_SO;
+
+	iotable_init(dram_io_desc, ARRAY_SIZE(dram_io_desc));
+	omap_bus_post.sync = omap_bus_sync;
+
+	pr_info("OMAP4: Map 0x%08llx to 0x%08lx for dram barrier\n",
+		(long long) paddr, dram_io_desc[0].virtual);
+
+	return 0;
+}
+core_initcall(omap_barriers_init);
 
 void __init gic_init_irq(void)
 {
diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
new file mode 100644
index 0000000..5406713
--- /dev/null
+++ b/arch/arm/mach-omap2/sleep44xx.S
@@ -0,0 +1,29 @@
+/*
+ * OMAP44xx sleep code.
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ * 	Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software,you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/linkage.h>
+#include <asm/system.h>
+
+#include <mach/omap4-common.h>
+
+ENTRY(omap_bus_sync)
+	stmfd	sp!, {lr}
+	/* SO write to drain of MPU-2-DDR T2ASYNC FIFO */
+	bl	omap_get_dram_barrier_base
+	ldr	r2, [r0]
+	str	r2, [r0]
+	/* SO write to drain MPU-2-L3 T2ASYNC FIFO */
+	bl	omap_get_sram_barrier_base
+	ldr	r2, [r0]
+	str	r2, [r0]
+	isb
+	ldmfd	sp!, {pc}
+ENDPROC(omap_bus_sync)
diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-omap/include/plat/sram.h
index f500fc3..a6000d4 100644
--- a/arch/arm/plat-omap/include/plat/sram.h
+++ b/arch/arm/plat-omap/include/plat/sram.h
@@ -15,6 +15,7 @@
 #include <asm/fncpy.h>
 
 extern void *omap_sram_push_address(unsigned long size);
+extern unsigned long omap_get_sram_barrier_base(void);
 
 /* Macro to push a function to the internal SRAM, using the fncpy API */
 #define omap_sram_push(funcp, size) ({				\
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 363c91e..0d370be 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -76,6 +76,12 @@ static unsigned long omap_sram_start;
 static unsigned long omap_sram_base;
 static unsigned long omap_sram_size;
 static unsigned long omap_sram_ceil;
+static unsigned long omap_barrier_base;
+
+unsigned long omap_get_sram_barrier_base(void)
+{
+	return omap_barrier_base;
+}
 
 /*
  * Depending on the target RAMFS firewall setup, the public usable amount of
@@ -185,24 +191,25 @@ static void __init omap_detect_sram(void)
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
@@ -212,14 +219,26 @@ static void __init omap_map_sram(void)
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
+		omap_barrier_base = omap_sram_io_desc[1].virtual;
+		base = omap_sram_start + omap_sram_io_desc[0].length;
+		base = ROUND_DOWN(base, PAGE_SIZE);
+		omap_sram_io_desc[1].pfn = __phys_to_pfn(base);
+		omap_sram_io_desc[1].length = PAGE_SIZE;
+		omap_sram_io_desc[1].type = MT_MEMORY_SO;
+		nr_desc = 2;
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

