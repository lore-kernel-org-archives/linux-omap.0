From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 5/6] ARM: l2x0: Determine the cache size
Date: Tue,  7 Sep 2010 13:27:22 +0530
Message-ID: <1283846243-11600-6-git-send-email-santosh.shilimkar@ti.com>
References: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-2-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-3-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-4-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-5-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42697 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753399Ab0IGH5v (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Sep 2010 03:57:51 -0400
In-Reply-To: <1283846243-11600-5-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: tglx@linutronix.de, catalin.marinas@arm.com, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

The cache size is needed for to optimise range based
maintainance operations

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |    1 +
 arch/arm/mm/cache-l2x0.c                   |   13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index d833355..4633d2a 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -55,6 +55,7 @@
 #define L2X0_CACHE_ID_PART_MASK		(0xf << 6)
 #define L2X0_CACHE_ID_PART_L210		(1 << 6)
 #define L2X0_CACHE_ID_PART_L310		(3 << 6)
+#define L2X0_AUX_CTRL_WAY_SIZE_MASK	(0x3 << 17)
 
 #ifndef __ASSEMBLY__
 extern void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 9310d61..87b487e 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -28,6 +28,7 @@
 static void __iomem *l2x0_base;
 static DEFINE_SPINLOCK(l2x0_lock);
 static uint32_t l2x0_way_mask;	/* Bitmask of active ways */
+static uint32_t l2x0_size;
 
 static inline void cache_wait_way(void __iomem *reg, unsigned long mask)
 {
@@ -242,6 +243,7 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 {
 	__u32 aux;
 	__u32 cache_id;
+	__u32 way_size = 0;
 	int ways;
 	const char *type;
 
@@ -276,6 +278,13 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 	l2x0_way_mask = (1 << ways) - 1;
 
 	/*
+	 * L2 cache Size =  Way size * Number of ways
+	 */
+	way_size = (aux & L2X0_AUX_CTRL_WAY_SIZE_MASK) >> 17;
+	way_size = 1 << (way_size + 3);
+	l2x0_size = ways * way_size;
+
+	/*
 	 * Check if l2x0 controller is already enabled.
 	 * If you are booting from non-secure mode
 	 * accessing the below registers will fault.
@@ -300,6 +309,6 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 	outer_cache.disable = l2x0_disable;
 
 	printk(KERN_INFO "%s cache controller enabled\n", type);
-	printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x\n",
-			 ways, cache_id, aux);
+	printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d KB\n",
+			ways, cache_id, aux, l2x0_size);
 }
-- 
1.6.0.4

