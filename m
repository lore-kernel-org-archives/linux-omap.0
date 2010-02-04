From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/5] ARM: L2 : Errata 588369: Clean & Invalidate do not invalidate clean lines
Date: Thu,  4 Feb 2010 19:55:46 +0530
Message-ID: <1265293547-18960-4-git-send-email-santosh.shilimkar@ti.com>
References: <1265293547-18960-1-git-send-email-santosh.shilimkar@ti.com>
 <1265293547-18960-2-git-send-email-santosh.shilimkar@ti.com>
 <1265293547-18960-3-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51098 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758267Ab0BDO0h (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Feb 2010 09:26:37 -0500
In-Reply-To: <1265293547-18960-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, rmk@arm.linux.org.uk, catalin.marinas@arm.com, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Woodruff Richard <r-woodruff2@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>

This patch implements the work-around for the errata 588369. The secure API
is used to alter L2 debug register because of trust-zone.

This version updated with comments from Russell and Catalin and generated
against 2.6.33-rc4 mainline kernel. Detail comments can be found:
	http://www.spinics.net/lists/linux-omap/msg23431.html

Signed-off-by: Woodruff Richard <r-woodruff2@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
CC: Tony Lindgren <tony@atomide.com>
CC: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig         |   13 +++++++++++++
 arch/arm/mm/cache-l2x0.c |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c33ca8..6825802 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -920,6 +920,19 @@ config ARM_ERRATA_460075
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
index 1a14d18..6241f10 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -56,12 +56,41 @@ static inline void l2x0_inv_line(unsigned long addr)
 	writel(addr, base + L2X0_INV_LINE_PA);
 }
 
+#ifdef CONFIG_PL310_ERRATA_588369
+extern void omap_smc1(u32 fn, u32 arg);
+static void debug_writel(unsigned long val)
+{
+	/*
+	 * Texas Instrument secure monitor api to modify the
+	 * PL310 Debug Control Register.
+	 */
+	omap_smc1(0x100, val);
+}
+
+static inline void l2x0_flush_line(unsigned long addr)
+{
+	void __iomem *base = l2x0_base;
+
+	/* Clean by PA followed by Invalidate by PA */
+	cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
+	writel(addr, base + L2X0_CLEAN_LINE_PA);
+	cache_wait(base + L2X0_INV_LINE_PA, 1);
+	writel(addr, base + L2X0_INV_LINE_PA);
+}
+#else
+
+/* Optimised out for non-errata case */
+static inline void debug_writel(unsigned long val)
+{
+}
+
 static inline void l2x0_flush_line(unsigned long addr)
 {
 	void __iomem *base = l2x0_base;
 	cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
 	writel(addr, base + L2X0_CLEAN_INV_LINE_PA);
 }
+#endif
 
 static inline void l2x0_inv_all(void)
 {
@@ -83,13 +112,17 @@ static void l2x0_inv_range(unsigned long start, unsigned long end)
 	spin_lock_irqsave(&l2x0_lock, flags);
 	if (start & (CACHE_LINE_SIZE - 1)) {
 		start &= ~(CACHE_LINE_SIZE - 1);
+		debug_writel(0x03);
 		l2x0_flush_line(start);
+		debug_writel(0x00);
 		start += CACHE_LINE_SIZE;
 	}
 
 	if (end & (CACHE_LINE_SIZE - 1)) {
 		end &= ~(CACHE_LINE_SIZE - 1);
+		debug_writel(0x03);
 		l2x0_flush_line(end);
+		debug_writel(0x00);
 	}
 
 	while (start < end) {
@@ -145,10 +178,12 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
 	while (start < end) {
 		unsigned long blk_end = start + min(end - start, 4096UL);
 
+		debug_writel(0x03);
 		while (start < blk_end) {
 			l2x0_flush_line(start);
 			start += CACHE_LINE_SIZE;
 		}
+		debug_writel(0x00);
 
 		if (blk_end < end) {
 			spin_unlock_irqrestore(&l2x0_lock, flags);
-- 
1.6.0.4

