From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/2] ARM: l2x0: Errata fix for flush by Way operation can cause data corruption
Date: Fri, 18 Feb 2011 18:05:24 +0530
Message-ID: <1298032525-21115-2-git-send-email-santosh.shilimkar@ti.com>
References: <1298032525-21115-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35205 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754576Ab1BRMfo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 07:35:44 -0500
In-Reply-To: <1298032525-21115-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, tony@atomide.com, catalin.marinas@arm.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

PL310 implements the Clean & Invalidate by Way L2 cache maintenance
operation (offset 0x7FC). This operation runs in background so that
PL310 can handle normal accesses while it is in progress. Under very
rare circumstances, due to this erratum, write data can be lost when
PL310 treats a cacheable write transaction during a Clean & Invalidate
by Way operation.

Workaround:
Disable Write-Back and Cache Linefill (Debug Control Register)
Clean & Invalidate by Way (0x7FC)
Re-enable Write-Back and Cache Linefill (Debug Control Register)

This patch also removes any OMAP dependency on PL310 Errata's

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/Kconfig                  |   15 ++++++++++++---
 arch/arm/include/asm/outercache.h |    1 +
 arch/arm/mm/cache-l2x0.c          |   28 +++++++++++++++-------------
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 26d45e5..b6eeab2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1140,7 +1140,7 @@ config ARM_ERRATA_742231
 
 config PL310_ERRATA_588369
 	bool "Clean & Invalidate maintenance operations do not invalidate clean lines"
-	depends on CACHE_L2X0 && ARCH_OMAP4
+	depends on CACHE_L2X0
 	help
 	   The PL310 L2 cache controller implements three types of Clean &
 	   Invalidate maintenance operations: by Physical Address
@@ -1149,8 +1149,7 @@ config PL310_ERRATA_588369
 	   clean operation followed immediately by an invalidate operation,
 	   both performing to the same memory location. This functionality
 	   is not correctly implemented in PL310 as clean lines are not
-	   invalidated as a result of these operations. Note that this errata
-	   uses Texas Instrument's secure monitor api.
+	   invalidated as a result of these operations.
 
 config ARM_ERRATA_720789
 	bool "ARM errata: TLBIASIDIS and TLBIMVAIS operations can broadcast a faulty ASID"
@@ -1177,6 +1176,16 @@ config ARM_ERRATA_743622
 	  visible impact on the overall performance or power consumption of the
 	  processor.
 
+config PL310_ERRATA_727915
+	bool "Background Clean & Invalidate by Way operation can cause data corruption"
+	depends on CACHE_L2X0
+	help
+	  PL310 implements the Clean & Invalidate by Way L2 cache maintenance
+	  operation (offset 0x7FC). This operation runs in background so that
+	  PL310 can handle normal accesses while it is in progress. Under very
+	  rare circumstances, due to this erratum, write data can be lost when
+	  PL310 treats a cacheable write transaction during a Clean &
+	  Invalidate by Way operation.
 endmenu
 
 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index fc19009..348d513 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -31,6 +31,7 @@ struct outer_cache_fns {
 #ifdef CONFIG_OUTER_CACHE_SYNC
 	void (*sync)(void);
 #endif
+	void (*set_debug)(unsigned long);
 };
 
 #ifdef CONFIG_OUTER_CACHE
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 170c9bb..a8caee4 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -67,18 +67,22 @@ static inline void l2x0_inv_line(unsigned long addr)
 	writel_relaxed(addr, base + L2X0_INV_LINE_PA);
 }
 
-#ifdef CONFIG_PL310_ERRATA_588369
+#if defined(CONFIG_PL310_ERRATA_588369) || defined(CONFIG_PL310_ERRATA_727915)
 static void debug_writel(unsigned long val)
 {
-	extern void omap_smc1(u32 fn, u32 arg);
-
-	/*
-	 * Texas Instrument secure monitor api to modify the
-	 * PL310 Debug Control Register.
-	 */
-	omap_smc1(0x100, val);
+	if (outer_cache.set_debug)
+		outer_cache.set_debug(val);
+	else
+		writel(val, l2x0_base + L2X0_DEBUG_CTRL);
+}
+#else
+/* Optimised out for non-errata case */
+static inline void debug_writel(unsigned long val)
+{
 }
+#endif
 
+#ifdef CONFIG_PL310_ERRATA_588369
 static inline void l2x0_flush_line(unsigned long addr)
 {
 	void __iomem *base = l2x0_base;
@@ -91,11 +95,6 @@ static inline void l2x0_flush_line(unsigned long addr)
 }
 #else
 
-/* Optimised out for non-errata case */
-static inline void debug_writel(unsigned long val)
-{
-}
-
 static inline void l2x0_flush_line(unsigned long addr)
 {
 	void __iomem *base = l2x0_base;
@@ -119,9 +118,11 @@ static void l2x0_flush_all(void)
 
 	/* clean all ways */
 	spin_lock_irqsave(&l2x0_lock, flags);
+	debug_writel(0x03);
 	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_INV_WAY);
 	cache_wait_way(l2x0_base + L2X0_CLEAN_INV_WAY, l2x0_way_mask);
 	cache_sync();
+	debug_writel(0x00);
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
@@ -329,6 +330,7 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 	outer_cache.flush_all = l2x0_flush_all;
 	outer_cache.inv_all = l2x0_inv_all;
 	outer_cache.disable = l2x0_disable;
+	outer_cache.set_debug = NULL;
 
 	printk(KERN_INFO "%s cache controller enabled\n", type);
 	printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d B\n",
-- 
1.6.0.4

