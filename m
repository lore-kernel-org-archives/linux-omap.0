From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 4/4] ARM: l2x0: Optmise the range based operations
Date: Sat, 31 Jul 2010 23:16:12 +0530
Message-ID: <1280598372-4830-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45622 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754084Ab0GaRq3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 31 Jul 2010 13:46:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Catalin Marinas <catalin.marinas@arm.com>

For the big buffers which are in excess of cache size, the maintaince
operations by PA are very slow. For such buffers the maintainace
operations can be speeded up by using the WAY based method.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/cache-l2x0.c |   95 ++++++++++++++++++++++++++++------------------
 1 files changed, 58 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index b2938d4..c0d6108 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -116,6 +116,18 @@ static void l2x0_flush_all(void)
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
+static void l2x0_clean_all(void)
+{
+	unsigned long flags;
+
+	/* clean all ways */
+	spin_lock_irqsave(&l2x0_lock, flags);
+	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_WAY);
+	cache_wait(l2x0_base + L2X0_CLEAN_WAY, l2x0_way_mask);
+	cache_sync();
+	spin_unlock_irqrestore(&l2x0_lock, flags);
+}
+
 static void l2x0_inv_all(void)
 {
 	unsigned long flags;
@@ -171,54 +183,63 @@ static void l2x0_inv_range(unsigned long start, unsigned long end)
 
 static void l2x0_clean_range(unsigned long start, unsigned long end)
 {
-	void __iomem *base = l2x0_base;
-	unsigned long flags;
 
-	spin_lock_irqsave(&l2x0_lock, flags);
-	start &= ~(CACHE_LINE_SIZE - 1);
-	while (start < end) {
-		unsigned long blk_end = start + min(end - start, 4096UL);
+	if ((end - start) >= l2x0_size) {
+		l2x0_clean_all();
+	} else {
+		void __iomem *base = l2x0_base;
+		unsigned long flags, blk_end;
 
-		while (start < blk_end) {
-			l2x0_clean_line(start);
-			start += CACHE_LINE_SIZE;
-		}
-
-		if (blk_end < end) {
-			spin_unlock_irqrestore(&l2x0_lock, flags);
-			spin_lock_irqsave(&l2x0_lock, flags);
+		spin_lock_irqsave(&l2x0_lock, flags);
+		start &= ~(CACHE_LINE_SIZE - 1);
+		while (start < end) {
+			blk_end = start + min(end - start, 4096UL);
+
+			while (start < blk_end) {
+				l2x0_clean_line(start);
+				start += CACHE_LINE_SIZE;
+			}
+
+			if (blk_end < end) {
+				spin_unlock_irqrestore(&l2x0_lock, flags);
+				spin_lock_irqsave(&l2x0_lock, flags);
+			}
 		}
+		cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
+		cache_sync();
+		spin_unlock_irqrestore(&l2x0_lock, flags);
 	}
-	cache_wait(base + L2X0_CLEAN_LINE_PA, 1);
-	cache_sync();
-	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
 static void l2x0_flush_range(unsigned long start, unsigned long end)
 {
-	void __iomem *base = l2x0_base;
-	unsigned long flags;
-
-	spin_lock_irqsave(&l2x0_lock, flags);
-	start &= ~(CACHE_LINE_SIZE - 1);
-	while (start < end) {
-		unsigned long blk_end = start + min(end - start, 4096UL);
-
-		debug_writel(0x03);
-		while (start < blk_end) {
-			l2x0_flush_line(start);
-			start += CACHE_LINE_SIZE;
-		}
-		debug_writel(0x00);
+	if ((end - start) >= l2x0_size) {
+		l2x0_flush_all();
+	} else {
+		void __iomem *base = l2x0_base;
+		unsigned long flags, blk_end;
 
-		if (blk_end < end) {
-			spin_unlock_irqrestore(&l2x0_lock, flags);
-			spin_lock_irqsave(&l2x0_lock, flags);
+		spin_lock_irqsave(&l2x0_lock, flags);
+		start &= ~(CACHE_LINE_SIZE - 1);
+		while (start < end) {
+			blk_end = start + min(end - start, 4096UL);
+
+			debug_writel(0x03);
+			while (start < blk_end) {
+				l2x0_flush_line(start);
+				start += CACHE_LINE_SIZE;
+			}
+			debug_writel(0x00);
+
+			if (blk_end < end) {
+				spin_unlock_irqrestore(&l2x0_lock, flags);
+				spin_lock_irqsave(&l2x0_lock, flags);
+			}
 		}
+		cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
+		cache_sync();
+		spin_unlock_irqrestore(&l2x0_lock, flags);
 	}
-	cache_wait(base + L2X0_CLEAN_INV_LINE_PA, 1);
-	cache_sync();
-	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
 static void l2x0_disable(void)
-- 
1.6.0.4

