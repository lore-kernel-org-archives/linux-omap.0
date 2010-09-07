From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/6] arm: Implement l2x0 cache disable functions
Date: Tue,  7 Sep 2010 13:27:19 +0530
Message-ID: <1283846243-11600-3-git-send-email-santosh.shilimkar@ti.com>
References: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-2-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51124 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878Ab0IGH6J (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Sep 2010 03:58:09 -0400
In-Reply-To: <1283846243-11600-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: tglx@linutronix.de, catalin.marinas@arm.com, linux-omap@vger.kernel.orgtglx@linutronix.de@vger.kernel.org

From: Thomas Gleixner <[tglx@linutronix.de]>

Add flush_all, inv_all and disable functions to the l2x0 code. These
functions are called from kexec code to prevent random crashes in the
new kernel.

Platforms like OMAP which control L2 enable/disable via SMI mode can
override the outer_cache.disable() function to implement their own.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/cache-l2x0.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index edb43ff..9310d61 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -112,12 +112,26 @@ static void l2x0_cache_sync(void)
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
-static inline void l2x0_inv_all(void)
+static void l2x0_flush_all(void)
+{
+	unsigned long flags;
+
+	/* clean all ways */
+	spin_lock_irqsave(&l2x0_lock, flags);
+	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_CLEAN_INV_WAY);
+	cache_wait_way(l2x0_base + L2X0_CLEAN_INV_WAY, l2x0_way_mask);
+	cache_sync();
+	spin_unlock_irqrestore(&l2x0_lock, flags);
+}
+
+static void l2x0_inv_all(void)
 {
 	unsigned long flags;
 
 	/* invalidate all ways */
 	spin_lock_irqsave(&l2x0_lock, flags);
+	/* Invalidating when L2 is enabled is a nono */
+	BUG_ON(readl(l2x0_base + L2X0_CTRL) & 1);
 	writel_relaxed(l2x0_way_mask, l2x0_base + L2X0_INV_WAY);
 	cache_wait_way(l2x0_base + L2X0_INV_WAY, l2x0_way_mask);
 	cache_sync();
@@ -215,6 +229,15 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
+static void l2x0_disable(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&l2x0_lock, flags);
+	writel(0, l2x0_base + L2X0_CTRL);
+	spin_unlock_irqrestore(&l2x0_lock, flags);
+}
+
 void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 {
 	__u32 aux;
@@ -272,6 +295,9 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 	outer_cache.clean_range = l2x0_clean_range;
 	outer_cache.flush_range = l2x0_flush_range;
 	outer_cache.sync = l2x0_cache_sync;
+	outer_cache.flush_all = l2x0_flush_all;
+	outer_cache.inv_all = l2x0_inv_all;
+	outer_cache.disable = l2x0_disable;
 
 	printk(KERN_INFO "%s cache controller enabled\n", type);
 	printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x\n",
-- 
1.6.0.4

