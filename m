From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/5] ARM: L2 : Add maintainace by line helper functions
Date: Thu,  4 Feb 2010 19:55:43 +0530
Message-ID: <1265293547-18960-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51088 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752219Ab0BDO0X (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Feb 2010 09:26:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, rmk@arm.linux.org.uk, catalin.marinas@arm.com, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <rmk+kernel@arm.linux.org.uk>

This patch adds the cache maintainance by line helper functions.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
CC: Tony Lindgren <tony@atomide.com>
CC: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-l2x0.c |   36 ++++++++++++++++++++++++++----------
 1 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index cb8fc65..1a14d18 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -42,6 +42,27 @@ static inline void cache_sync(void)
 	cache_wait(base + L2X0_CACHE_SYNC, 1);
 }
 
+static inline void l2x0_clean_line(unsigned long addr)
+{
+	void __iomem *base = l2x0_base;
+	cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
+	writel(addr, base + L2X0_CLEAN_LINE_PA);
+}
+
+static inline void l2x0_inv_line(unsigned long addr)
+{
+	void __iomem *base = l2x0_base;
+	cache_wait(base + L2X0_INV_LINE_PA, 1);
+	writel(addr, base + L2X0_INV_LINE_PA);
+}
+
+static inline void l2x0_flush_line(unsigned long addr)
+{
+	void __iomem *base = l2x0_base;
+	cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
+	writel(addr, base + L2X0_CLEAN_INV_LINE_PA);
+}
+
 static inline void l2x0_inv_all(void)
 {
 	unsigned long flags;
@@ -62,23 +83,20 @@ static void l2x0_inv_range(unsigned long start, unsigned long end)
 	spin_lock_irqsave(&l2x0_lock, flags);
 	if (start & (CACHE_LINE_SIZE - 1)) {
 		start &= ~(CACHE_LINE_SIZE - 1);
-		cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
-		writel(start, base + L2X0_CLEAN_INV_LINE_PA);
+		l2x0_flush_line(start);
 		start += CACHE_LINE_SIZE;
 	}
 
 	if (end & (CACHE_LINE_SIZE - 1)) {
 		end &= ~(CACHE_LINE_SIZE - 1);
-		cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
-		writel(end, base + L2X0_CLEAN_INV_LINE_PA);
+		l2x0_flush_line(end);
 	}
 
 	while (start < end) {
 		unsigned long blk_end = start + min(end - start, 4096UL);
 
 		while (start < blk_end) {
-			cache_wait(base + L2X0_INV_LINE_PA, 1);
-			writel(start, base + L2X0_INV_LINE_PA);
+			l2x0_inv_line(start);
 			start += CACHE_LINE_SIZE;
 		}
 
@@ -103,8 +121,7 @@ static void l2x0_clean_range(unsigned long start, unsigned long end)
 		unsigned long blk_end = start + min(end - start, 4096UL);
 
 		while (start < blk_end) {
-			cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
-			writel(start, base + L2X0_CLEAN_LINE_PA);
+			l2x0_clean_line(start);
 			start += CACHE_LINE_SIZE;
 		}
 
@@ -129,8 +146,7 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
 		unsigned long blk_end = start + min(end - start, 4096UL);
 
 		while (start < blk_end) {
-			cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
-			writel(start, base + L2X0_CLEAN_INV_LINE_PA);
+			l2x0_flush_line(start);
 			start += CACHE_LINE_SIZE;
 		}
 
-- 
1.6.0.4

