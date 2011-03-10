From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 5/5] OMAP3: PM: Clear the SCTLR C bit in asm code to prevent data cache allocation
Date: Thu, 10 Mar 2011 12:37:17 +0530
Message-ID: <1299740837-27881-6-git-send-email-santosh.shilimkar@ti.com>
References: <1299740837-27881-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35431 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259Ab1CJHH1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 02:07:27 -0500
In-Reply-To: <1299740837-27881-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On the newer ARM processors like CortexA8, CortexA9, the caches can be
speculatively loaded while they are getting flushed.

Clear the SCTLR C bit to prevent further data cache allocation as
part of cache clean routine

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/sleep34xx.S |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index d29476e..63f1066 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -248,6 +248,27 @@ clean_caches:
 	 *  - it executes in a cached space so is faster than refetch per-block
 	 *  - should be faster and will change with kernel
 	 *  - 'might' have to copy address, load and jump to it
+	 * Flush all data from the L1 data cache before disabling
+	 * SCTLR.C bit.
+	 */
+	ldr	r1, kernel_flush
+	mov	lr, pc
+	bx	r1
+
+	/*
+	 * Clear the SCTLR.C bit to prevent further data cache
+	 * allocation. Clearing SCTLR.C would make all the data accesses
+	 * strongly ordered and would not hit the cache.
+	 */
+	mrc	p15, 0, r0, c1, c0, 0
+	bic	r0, r0, #(1 << 2)	@ Disable the C bit
+	mcr	p15, 0, r0, c1, c0, 0
+	isb
+
+	/*
+	 * Invalidate L1 data cache. Even though only invalidate is
+	 * necessary exported flush API is used here. Doing clean
+	 * on already clean cache would be almost NOP.
 	 */
 	ldr	r1, kernel_flush
 	blx	r1
@@ -297,6 +318,12 @@ omap3_do_wfi:
 	nop
 	bl wait_sdrc_ok
 
+	mrc	p15, 0, r0, c1, c0, 0
+	tst	r0, #(1 << 2)		@ Check C bit enabled?
+	orreq	r0, r0, #(1 << 2)	@ Enable the C bit if cleared
+	mcreq	p15, 0, r0, c1, c0, 0
+	isb
+
 /*
  * ===================================
  * == Exit point from non-OFF modes ==
-- 
1.6.0.4

