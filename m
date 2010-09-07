From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 6/6] ARM: l2x0: Optimise the range based operations
Date: Tue,  7 Sep 2010 13:27:23 +0530
Message-ID: <1283846243-11600-7-git-send-email-santosh.shilimkar@ti.com>
References: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-2-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-3-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-4-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-5-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-6-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51102 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534Ab0IGH5t (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Sep 2010 03:57:49 -0400
In-Reply-To: <1283846243-11600-6-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: tglx@linutronix.de, catalin.marinas@arm.com, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

For the big buffers which are in excess of cache size, the maintaince
operations by PA are very slow. For such buffers the maintainace
operations can be speeded up by using the WAY based method.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/cache-l2x0.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 87b487e..143a39f 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -125,6 +125,18 @@ static void l2x0_flush_all(void)
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
+static void l2x0_clean_all(void)
+{
+	unsigned long flags;
+
+	/* clean all ways */
+	spin_lock_irqsave(&l2x0_lock, flags);
+	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_WAY);
+	cache_wait_way(l2x0_base + L2X0_CLEAN_WAY, l2x0_way_mask);
+	cache_sync();
+	spin_unlock_irqrestore(&l2x0_lock, flags);
+}
+
 static void l2x0_inv_all(void)
 {
 	unsigned long flags;
@@ -183,6 +195,11 @@ static void l2x0_clean_range(unsigned long start, unsigned long end)
 	void __iomem *base = l2x0_base;
 	unsigned long flags;
 
+	if ((end - start) >= l2x0_size) {
+		l2x0_clean_all();
+		return;
+	}
+
 	spin_lock_irqsave(&l2x0_lock, flags);
 	start &= ~(CACHE_LINE_SIZE - 1);
 	while (start < end) {
@@ -208,6 +225,11 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
 	void __iomem *base = l2x0_base;
 	unsigned long flags;
 
+	if ((end - start) >= l2x0_size) {
+		l2x0_flush_all();
+		return;
+	}
+
 	spin_lock_irqsave(&l2x0_lock, flags);
 	start &= ~(CACHE_LINE_SIZE - 1);
 	while (start < end) {
-- 
1.6.0.4

