From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/2] ARM: OMAP4: Move the barrier memboclk_steal() as part of reserve callback
Date: Thu, 2 Feb 2012 19:33:55 +0530
Message-ID: <1328191435-18652-3-git-send-email-santosh.shilimkar@ti.com>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35264 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756254Ab2BBOEP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Feb 2012 09:04:15 -0500
In-Reply-To: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

arm_memblock_steal() is not suppose to be used outside ->reserve callback.
OMAP barrier errata code was using it outside reserve callback and hence
it was broken.

Move the allocation as part of ->reserve callback to fix the it.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig                   |    4 ++--
 arch/arm/mach-omap2/common.h                  |    1 +
 arch/arm/mach-omap2/io.c                      |    1 +
 arch/arm/mach-omap2/omap4-common.c            |   25 ++++++++++++++++---------
 arch/arm/plat-omap/common.c                   |    1 +
 arch/arm/plat-omap/include/plat/omap-secure.h |    6 ++++++
 6 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 41e6612..ac6b1d3 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -365,8 +365,8 @@ config OMAP3_SDRC_AC_TIMING
 	  going on could result in system crashes;
 
 config OMAP4_ERRATA_I688
-	bool "OMAP4 errata: Async Bridge Corruption (BROKEN)"
-	depends on ARCH_OMAP4 && BROKEN
+	bool "OMAP4 errata: Async Bridge Corruption"
+	depends on ARCH_OMAP4
 	select ARCH_HAS_BARRIERS
 	help
 	  If a data is stalled inside asynchronous bridge because of back
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index febffde..7e9338e 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -132,6 +132,7 @@ void omap3_map_io(void);
 void am33xx_map_io(void);
 void omap4_map_io(void);
 void ti81xx_map_io(void);
+void omap_barriers_init(void);
 
 /**
  * omap_test_timeout - busy-loop, testing a condition
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 3f174d5..f64aa79 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -307,6 +307,7 @@ void __init omapam33xx_map_common_io(void)
 void __init omap44xx_map_common_io(void)
 {
 	iotable_init(omap44xx_io_desc, ARRAY_SIZE(omap44xx_io_desc));
+	omap_barriers_init();
 }
 #endif
 
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 40a8fbc..ebc5950 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -24,6 +24,7 @@
 
 #include <plat/irqs.h>
 #include <plat/sram.h>
+#include <plat/omap-secure.h>
 
 #include <mach/hardware.h>
 #include <mach/omap-wakeupgen.h>
@@ -43,6 +44,9 @@ static void __iomem *sar_ram_base;
 
 void __iomem *dram_sync, *sram_sync;
 
+static phys_addr_t paddr;
+static u32 size;
+
 void omap_bus_sync(void)
 {
 	if (dram_sync && sram_sync) {
@@ -52,18 +56,20 @@ void omap_bus_sync(void)
 	}
 }
 
-static int __init omap_barriers_init(void)
+/* Steal one page physical memory for barrier implementation */
+int __init omap_barrier_reserve_memblock(void)
 {
-	struct map_desc dram_io_desc[1];
-	phys_addr_t paddr;
-	u32 size;
-
-	if (!cpu_is_omap44xx())
-		return -ENODEV;
 
 	size = ALIGN(PAGE_SIZE, SZ_1M);
 	paddr = arm_memblock_steal(size, SZ_1M);
 
+	return 0;
+}
+
+void __init omap_barriers_init(void)
+{
+	struct map_desc dram_io_desc[1];
+
 	dram_io_desc[0].virtual = OMAP4_DRAM_BARRIER_VA;
 	dram_io_desc[0].pfn = __phys_to_pfn(paddr);
 	dram_io_desc[0].length = size;
@@ -75,9 +81,10 @@ static int __init omap_barriers_init(void)
 	pr_info("OMAP4: Map 0x%08llx to 0x%08lx for dram barrier\n",
 		(long long) paddr, dram_io_desc[0].virtual);
 
-	return 0;
 }
-core_initcall(omap_barriers_init);
+#else
+void __init omap_barriers_init(void)
+{}
 #endif
 
 void __init gic_init_irq(void)
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 06383b5..4de7d1e 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -69,6 +69,7 @@ void __init omap_reserve(void)
 	omap_vram_reserve_sdram_memblock();
 	omap_dsp_reserve_sdram_memblock();
 	omap_secure_ram_reserve_memblock();
+	omap_barrier_reserve_memblock();
 }
 
 void __init omap_init_consistent_dma_size(void)
diff --git a/arch/arm/plat-omap/include/plat/omap-secure.h b/arch/arm/plat-omap/include/plat/omap-secure.h
index 64f9d1c..0f14fb7 100644
--- a/arch/arm/plat-omap/include/plat/omap-secure.h
+++ b/arch/arm/plat-omap/include/plat/omap-secure.h
@@ -10,4 +10,10 @@ static inline void omap_secure_ram_reserve_memblock(void)
 { }
 #endif
 
+#ifdef CONFIG_OMAP4_ERRATA_I688
+extern int omap_barrier_reserve_memblock(void);
+#else
+static inline void omap_barrier_reserve_memblock(void)
+{ }
+#endif
 #endif /* __OMAP_SECURE_H__ */
-- 
1.7.4.1

