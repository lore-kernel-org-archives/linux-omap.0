From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 6/6] ARM: l2x0: Optimise the range based operations
Date: Wed, 6 Oct 2010 10:42:30 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030CF13239@dbde02.ent.ti.com>
References: <1283846243-11600-1-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-2-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-3-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-4-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-5-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-6-git-send-email-santosh.shilimkar@ti.com>
 <1283846243-11600-7-git-send-email-santosh.shilimkar@ti.com>
 <20101004212250.GD25241@n2100.arm.linux.org.uk>
 <EAF47CD23C76F840A9E7FCE10091EFAB030CDFEA29@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49992 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab0JFFNH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Oct 2010 01:13:07 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFEA29@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Shilimkar, Santosh
> Sent: Tuesday, October 05, 2010 10:25 AM
> To: Russell King - ARM Linux
> Cc: linux-arm-kernel@lists.infradead.org; catalin.marinas@arm.com;
> tglx@linutronix.de; linux-omap@vger.kernel.org
> Subject: RE: [PATCH 6/6] ARM: l2x0: Optimise the range based operations
> 
[....]

> > mmcblk0: error -5 transferring data, sector 1, nr 7, card status 0x900
> > end_request: I/O error, dev mmcblk0, sector 1
> > Buffer I/O error on device mmcblk0, logical block 0
> > port 1 high speed
> >
> > -5 is -EIO, which is a FIFO overrun error, so somehow these changes are
> > causing the CPU or bus accesses to be slower.
> I don't see the problem on OMAP MMC.
> May be some how additional check is making these operations
> touch slower which lead to the under run.
> 
> Will have a look at it again. May for this merge window you can
> drop 'Optimise the range based operations' and 'Determine cache size'
> patches.
> 
The Pl310 cache way size given in KB and 'Determine cache size' missed
to include that. Have updated the git tree with refreshed patch. Here is
the updated patch.. 

----------------------
>From 8b351fbc4da738a0727854cb88933c4051657384 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Sun, 11 Jul 2010 14:35:37 +0530
Subject: [PATCH 6/8 v2] ARM: l2x0: Determine the cache size

The cache size is needed for to optimise range based
maintainance operations

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
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
index 9310d61..262c752 100644
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
+	l2x0_size = ways * way_size * SZ_1K;
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
+	printk(KERN_INFO "l2x0: %d ways, CACHE_ID 0x%08x, AUX_CTRL 0x%08x, Cache size: %d B\n",
+			ways, cache_id, aux, l2x0_size);
 }
-- 
1.6.0.4

