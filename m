From: Stefan Hengelein <stefan.hengelein@fau.de>
Subject: [PATCH] ARM: OMAP4: remove dead kconfig option OMAP4_ERRATA_I688
Date: Wed, 25 Feb 2015 19:44:27 +0100
Message-ID: <1424889867-8980-1-git-send-email-stefan.hengelein@fau.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, linux@arm.linux.org.uk, santosh.shilimkar@oracle.com, gregkh@linuxfoundation.org, Stefan Hengelein <stefan.hengelein@fau.de>
List-Id: linux-omap@vger.kernel.org

The Kconfig-Option OMAP4_ERRATA_I688 is never visible due to a
contradiction in it's dependencies.
The option requires ARCH_MULTIPLATFORM to be 'disabled'. However, an
enclosing menu requires either ARCH_MULTI_V6 or ARCH_MULTI_V7 to be
enabled. These options inherit a dependency from an enclosing menu,
that requires ARCH_MULTIPLATFORM to be 'enabled'.
This is a contradiction and made this option also unavailable for
non-multiplatform configurations.

Since there are no selects on OMAP4_ERRATA_I688, which would ignore
dependencies, the code related to that option is dead and can be
removed.

This (logical) defect has been found with the undertaker tool.
(https://undertaker.cs.fau.de)

Signed-off-by: Stefan Hengelein <stefan.hengelein@fau.de>

---
Tony Lindgren suggested to remove the code since nobody complained for
a few years and Santosh Shilimkar agreed.
https://lkml.org/lkml/2015/2/25/449
---
As far as I see, this should remove all the code related to
OMAP4_ERRATA_I688, I hope I didn't remove too much.
---
 arch/arm/mach-omap2/Kconfig        | 21 ------------
 arch/arm/mach-omap2/common.c       |  1 -
 arch/arm/mach-omap2/common.h       |  3 --
 arch/arm/mach-omap2/io.c           |  2 --
 arch/arm/mach-omap2/omap-secure.h  |  7 ----
 arch/arm/mach-omap2/omap4-common.c | 69 --------------------------------------
 arch/arm/mach-omap2/sleep44xx.S    |  2 --
 7 files changed, 105 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 2b8e477..c7f4d9a 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -278,27 +278,6 @@ config OMAP3_SDRC_AC_TIMING
 	  wish to say no.  Selecting yes without understanding what is
 	  going on could result in system crashes;
 
-config OMAP4_ERRATA_I688
-	bool "OMAP4 errata: Async Bridge Corruption"
-	depends on (ARCH_OMAP4 || SOC_OMAP5) && !ARCH_MULTIPLATFORM
-	select ARCH_HAS_BARRIERS
-	help
-	  If a data is stalled inside asynchronous bridge because of back
-	  pressure, it may be accepted multiple times, creating pointer
-	  misalignment that will corrupt next transfers on that data path
-	  until next reset of the system (No recovery procedure once the
-	  issue is hit, the path remains consistently broken). Async bridge
-	  can be found on path between MPU to EMIF and MPU to L3 interconnect.
-	  This situation can happen only when the idle is initiated by a
-	  Master Request Disconnection (which is trigged by software when
-	  executing WFI on CPU).
-	  The work-around for this errata needs all the initiators connected
-	  through async bridge must ensure that data path is properly drained
-	  before issuing WFI. This condition will be met if one Strongly ordered
-	  access is performed to the target right before executing the WFI.
-	  In MPU case, L3 T2ASYNC FIFO and DDR T2ASYNC FIFO needs to be drained.
-	  IO barrier ensure that there is no synchronisation loss on initiators
-	  operating on both interconnect port simultaneously.
 endmenu
 
 endif
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 484cdad..eae6a0e 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -30,5 +30,4 @@ int __weak omap_secure_ram_reserve_memblock(void)
 void __init omap_reserve(void)
 {
 	omap_secure_ram_reserve_memblock();
-	omap_barrier_reserve_memblock();
 }
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 46e2458..cf3cf22 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -200,9 +200,6 @@ void __init omap4_map_io(void);
 void __init omap5_map_io(void);
 void __init ti81xx_map_io(void);
 
-/* omap_barriers_init() is OMAP4 only */
-void omap_barriers_init(void);
-
 /**
  * omap_test_timeout - busy-loop, testing a condition
  * @cond: condition to test until it evaluates to true
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index c4871c5..1eeff6b 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -306,7 +306,6 @@ void __init am33xx_map_io(void)
 void __init omap4_map_io(void)
 {
 	iotable_init(omap44xx_io_desc, ARRAY_SIZE(omap44xx_io_desc));
-	omap_barriers_init();
 }
 #endif
 
@@ -314,7 +313,6 @@ void __init omap4_map_io(void)
 void __init omap5_map_io(void)
 {
 	iotable_init(omap54xx_io_desc, ARRAY_SIZE(omap54xx_io_desc));
-	omap_barriers_init();
 }
 #endif
 /*
diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
index dec2b05..af2851f 100644
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -70,13 +70,6 @@ extern u32 rx51_secure_dispatcher(u32 idx, u32 process, u32 flag, u32 nargs,
 extern u32 rx51_secure_update_aux_cr(u32 set_bits, u32 clear_bits);
 extern u32 rx51_secure_rng_call(u32 ptr, u32 count, u32 flag);
 
-#ifdef CONFIG_OMAP4_ERRATA_I688
-extern int omap_barrier_reserve_memblock(void);
-#else
-static inline void omap_barrier_reserve_memblock(void)
-{ }
-#endif
-
 #ifdef CONFIG_SOC_HAS_REALTIME_COUNTER
 void set_cntfreq(void);
 #else
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index cee0fe1..afaac9e 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -52,75 +52,6 @@ static void __iomem *twd_base;
 
 #define IRQ_LOCALTIMER		29
 
-#ifdef CONFIG_OMAP4_ERRATA_I688
-/* Used to implement memory barrier on DRAM path */
-#define OMAP4_DRAM_BARRIER_VA			0xfe600000
-
-void __iomem *dram_sync, *sram_sync;
-
-static phys_addr_t paddr;
-static u32 size;
-
-void omap_bus_sync(void)
-{
-	if (dram_sync && sram_sync) {
-		writel_relaxed(readl_relaxed(dram_sync), dram_sync);
-		writel_relaxed(readl_relaxed(sram_sync), sram_sync);
-		isb();
-	}
-}
-EXPORT_SYMBOL(omap_bus_sync);
-
-static int __init omap4_sram_init(void)
-{
-	struct device_node *np;
-	struct gen_pool *sram_pool;
-
-	np = of_find_compatible_node(NULL, NULL, "ti,omap4-mpu");
-	if (!np)
-		pr_warn("%s:Unable to allocate sram needed to handle errata I688\n",
-			__func__);
-	sram_pool = of_get_named_gen_pool(np, "sram", 0);
-	if (!sram_pool)
-		pr_warn("%s:Unable to get sram pool needed to handle errata I688\n",
-			__func__);
-	else
-		sram_sync = (void *)gen_pool_alloc(sram_pool, PAGE_SIZE);
-
-	return 0;
-}
-omap_arch_initcall(omap4_sram_init);
-
-/* Steal one page physical memory for barrier implementation */
-int __init omap_barrier_reserve_memblock(void)
-{
-
-	size = ALIGN(PAGE_SIZE, SZ_1M);
-	paddr = arm_memblock_steal(size, SZ_1M);
-
-	return 0;
-}
-
-void __init omap_barriers_init(void)
-{
-	struct map_desc dram_io_desc[1];
-
-	dram_io_desc[0].virtual = OMAP4_DRAM_BARRIER_VA;
-	dram_io_desc[0].pfn = __phys_to_pfn(paddr);
-	dram_io_desc[0].length = size;
-	dram_io_desc[0].type = MT_MEMORY_RW_SO;
-	iotable_init(dram_io_desc, ARRAY_SIZE(dram_io_desc));
-	dram_sync = (void __iomem *) dram_io_desc[0].virtual;
-
-	pr_info("OMAP4: Map 0x%08llx to 0x%08lx for dram barrier\n",
-		(long long) paddr, dram_io_desc[0].virtual);
-
-}
-#else
-void __init omap_barriers_init(void)
-{}
-#endif
-
 void gic_dist_disable(void)
 {
 	if (gic_dist_base_addr)
diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
index b84a012..ad1bb94 100644
--- a/arch/arm/mach-omap2/sleep44xx.S
+++ b/arch/arm/mach-omap2/sleep44xx.S
@@ -333,11 +333,9 @@ ENDPROC(omap4_cpu_resume)
 
 #endif	/* defined(CONFIG_SMP) && defined(CONFIG_PM) */
 
-#ifndef CONFIG_OMAP4_ERRATA_I688
 ENTRY(omap_bus_sync)
 	ret	lr
 ENDPROC(omap_bus_sync)
-#endif
 
 ENTRY(omap_do_wfi)
 	stmfd	sp!, {lr}
-- 
1.9.1
