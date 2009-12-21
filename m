From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v3] ARM: L2 : Errata 588369: Clean & Invalidate do not invalidate clean lines
Date: Mon, 21 Dec 2009 15:39:21 +0530
Message-ID: <1261390161-20196-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35499 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748AbZLUKJv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Dec 2009 05:09:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Woodruff Richard <r-woodruff2@ti.com>, Catalin Marinas <catalin.marinas@arm.com>

This patch implements the work-around for the errata 588369. The secure API
is used to alter L2 debug regsiter because of trust-zone.

v3 is rebased on the latest 2.6.33-rc1 which has Russell's "pending-l2x0"
changes merged. The patch is tested on OMAP4430 SDP.

Signed-off-by: Woodruff Richard <r-woodruff2@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/Kconfig         |   13 ++++++++++++
 arch/arm/mm/cache-l2x0.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 233a222..3891b77 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -917,6 +917,19 @@ config ARM_ERRATA_460075
 	  ACTLR register. Note that setting specific bits in the ACTLR register
 	  may not be available in non-secure mode.
 
+config PL310_ERRATA_588369
+	bool "Clean & Invalidate maintenance operations do not invalidate clean lines"
+	depends on CACHE_L2X0 && ARCH_OMAP4
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
index cb8fc65..5443c0d 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -28,6 +28,24 @@
 static void __iomem *l2x0_base;
 static DEFINE_SPINLOCK(l2x0_lock);
 
+#ifdef CONFIG_PL310_ERRATA_588369
+static void debug_writel(unsigned long val)
+{
+	register unsigned long r0 asm("r0") = val;
+	/*
+	 * Texas Instrument secure monitor api to modify the PL310
+	 * Debug Control Register.
+	 */
+	__asm__ __volatile__(
+		__asmeq("%0", "r0")
+		"ldr r12, =0x100\n"
+		"dsb\n"
+		"smc\n"
+		: : "r" (r0)
+		: "r4", "r5", "r6", "r7", "r8");
+}
+#endif
+
 static inline void cache_wait(void __iomem *reg, unsigned long mask)
 {
 	/* wait for the operation to complete */
@@ -62,15 +80,33 @@ static void l2x0_inv_range(unsigned long start, unsigned long end)
 	spin_lock_irqsave(&l2x0_lock, flags);
 	if (start & (CACHE_LINE_SIZE - 1)) {
 		start &= ~(CACHE_LINE_SIZE - 1);
+#ifdef CONFIG_PL310_ERRATA_588369
+		debug_writel(0x03);
+		cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
+		writel(start, base + L2X0_CLEAN_LINE_PA);
+		cache_wait(base + L2X0_INV_LINE_PA, 1);
+		writel(start, base + L2X0_INV_LINE_PA);
+		debug_writel(0x00);
+#else
 		cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
 		writel(start, base + L2X0_CLEAN_INV_LINE_PA);
+#endif
 		start += CACHE_LINE_SIZE;
 	}
 
 	if (end & (CACHE_LINE_SIZE - 1)) {
 		end &= ~(CACHE_LINE_SIZE - 1);
+#ifdef CONFIG_PL310_ERRATA_588369
+		debug_writel(0x03);
+		cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
+		writel(end, base + L2X0_CLEAN_LINE_PA);
+		cache_wait(base + L2X0_INV_LINE_PA, 1);
+		writel(end, base + L2X0_INV_LINE_PA);
+			debug_writel(0x00);
+#else
 		cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
 		writel(end, base + L2X0_CLEAN_INV_LINE_PA);
+#endif
 	}
 
 	while (start < end) {
@@ -129,8 +165,17 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
 		unsigned long blk_end = start + min(end - start, 4096UL);
 
 		while (start < blk_end) {
+#ifdef CONFIG_PL310_ERRATA_588369
+			debug_writel(0x03);
+			/* Clean by PA followed by Invalidate by PA */
+			cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
+			writel(start, base + L2X0_CLEAN_LINE_PA);
+			cache_wait(base + L2X0_INV_LINE_PA, 1);
+			writel(start, base + L2X0_INV_LINE_PA);
+#else
 			cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
 			writel(start, base + L2X0_CLEAN_INV_LINE_PA);
+#endif
 			start += CACHE_LINE_SIZE;
 		}
 
@@ -139,7 +184,12 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
 			spin_lock_irqsave(&l2x0_lock, flags);
 		}
 	}
+#ifdef CONFIG_PL310_ERRATA_588369
+	cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
+	cache_wait(base + L2X0_INV_LINE_PA, 1);
+#else
 	cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
+#endif
 	cache_sync();
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
-- 
1.6.0.4

