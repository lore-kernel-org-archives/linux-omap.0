From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/4 v2] ARM: L2 : Errata 588369: Clean & Invalidate do not invalidate clean lines
Date: Thu, 17 Dec 2009 18:30:32 +0530
Message-ID: <1261054832-14995-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47779 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbZLQNBG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 08:01:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, Santosh Shilimkar <santosh.shilimkar@ti.com>, Woodruff Richard <r-woodruff2@ti.com>, Catalin Marinas <catalin.marinas@arm.com>

This patch implements the work-around for the errata 588369. The secure API
is used to alter L2 debug regsiter because of trust-zone.

Signed-off-by: Woodruff Richard <r-woodruff2@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/Kconfig         |   14 ++++++++++++++
 arch/arm/mm/cache-l2x0.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 233a222..daae2d0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -917,6 +917,20 @@ config ARM_ERRATA_460075
 	  ACTLR register. Note that setting specific bits in the ACTLR register
 	  may not be available in non-secure mode.
 
+config PL310_ERRATA_588369
+	bool "Clean & Invalidate maintenance operations do not invalidate clean lines"
+	depends on CACHE_L2X0 && ARCH_OMAP4
+	default n
+	help
+	   The PL310 L2 cache controller implements three types of Clean &
+	   Invalidate maintenance operations: by Physical Address
+	   (offset 0x7F0), by Index/Way (0x7F8) and by Way (0x7FC).
+	   They are architecturally defined to behave as the execution of a
+	   clean operation followed immediately by an invalidate operation,
+	   both performing to the same memory location. This functionality
+	   is not correctly implemented in PL310 as clean lines are not
+	   invalidated as a result of these operations. Note that this errata
+	   uses Texas Instrument's secure monitor api.
 endmenu
 
 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 747f9a9..4d33dc9 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -28,6 +28,21 @@
 static void __iomem *l2x0_base;
 static DEFINE_SPINLOCK(l2x0_lock);
 
+#ifdef CONFIG_PL310_ERRATA_588369
+static void debug_writel(unsigned long val)
+{
+	/*
+	 * Texas Instrument secure monitor api to modify the PL310
+	 * Debug Control Register. R0 = val
+	 */
+	__asm__ __volatile__(
+	"stmfd r13!, {r4-r8}\n"
+	"ldr r12, =0x100\n"
+	"dsb\n"
+	"smc\n"
+	"ldmfd r13!, {r4-r8}");
+}
+#endif
 static inline void sync_writel(unsigned long val, unsigned long reg,
 			       unsigned long complete_mask)
 {
@@ -59,13 +74,27 @@ static void l2x0_inv_range(unsigned long start, unsigned long end)
 
 	if (start & (CACHE_LINE_SIZE - 1)) {
 		start &= ~(CACHE_LINE_SIZE - 1);
+#ifdef CONFIG_PL310_ERRATA_588369
+		debug_writel(0x03);
+		sync_writel(start, L2X0_CLEAN_LINE_PA, 1);
+		sync_writel(start, L2X0_INV_LINE_PA, 1);
+		debug_writel(0x00);
+#else
 		sync_writel(start, L2X0_CLEAN_INV_LINE_PA, 1);
+#endif
 		start += CACHE_LINE_SIZE;
 	}
 
 	if (end & (CACHE_LINE_SIZE - 1)) {
 		end &= ~(CACHE_LINE_SIZE - 1);
+#ifdef CONFIG_PL310_ERRATA_588369
+		debug_writel(0x03);
+		sync_writel(end, L2X0_CLEAN_LINE_PA, 1);
+		sync_writel(end, L2X0_INV_LINE_PA, 1);
+		debug_writel(0x00);
+#else
 		sync_writel(end, L2X0_CLEAN_INV_LINE_PA, 1);
+#endif
 	}
 
 	for (addr = start; addr < end; addr += CACHE_LINE_SIZE)
@@ -88,8 +117,23 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
 	unsigned long addr;
 
 	start &= ~(CACHE_LINE_SIZE - 1);
+#ifdef CONFIG_PL310_ERRATA_588369
+
+	/* Disbale Write-Back and Cache Linefill */
+	debug_writel(0x03);
+
+	/* Clean by PA followed by Invalidate by PA */
+	for (addr = start; addr < end; addr += CACHE_LINE_SIZE) {
+		sync_writel(addr, L2X0_CLEAN_LINE_PA, 1);
+		sync_writel(addr, L2X0_INV_LINE_PA, 1);
+	}
+
+	/* Enable Write-Back and Cache Linefill */
+	debug_writel(0x00);
+#else
 	for (addr = start; addr < end; addr += CACHE_LINE_SIZE)
 		sync_writel(addr, L2X0_CLEAN_INV_LINE_PA, 1);
+#endif
 	cache_sync();
 }
 
-- 
1.6.0.4

