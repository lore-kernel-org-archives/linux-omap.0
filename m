From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/6] omap3: pm: Allow the cache clean when L1 is lost.
Date: Mon, 21 Feb 2011 18:49:22 +0530
Message-ID: <1298294365-30770-4-git-send-email-santosh.shilimkar@ti.com>
References: <1298294365-30770-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36687 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755962Ab1BUNTg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 08:19:36 -0500
In-Reply-To: <1298294365-30770-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

When L1 cache is suppose to be lost, it needs to be cleaned before
entrering to the low power mode.

While at this, also fix few comments and remove un-necessary
clean_l2 lable.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/sleep34xx.S |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 4478379..7442431 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -173,12 +173,12 @@ ENTRY(omap34xx_cpu_suspend)
 	stmfd	sp!, {r0-r12, lr}	@ save registers on stack
 
 	/*
-	 * r0 contains restore pointer in sdram
+	 * r0 contains CPU context save/restore pointer in sdram
 	 * r1 contains information about saving context:
 	 *   0 - No context lost
 	 *   1 - Only L1 and logic lost
-	 *   2 - Only L2 lost
-	 *   3 - Both L1 and L2 lost
+	 *   2 - Only L2 lost (Even L1 is retained we clean it along with L2)
+	 *   3 - Both L1 and L2 lost and logic lost
 	 */
 
 	/* Directly jump to WFI is the context save is not required */
@@ -263,15 +263,6 @@ l1_logic_lost:
 
 clean_caches:
 	/*
-	 * Clean Data or unified cache to POU
-	 * How to invalidate only L1 cache???? - #FIX_ME#
-	 * mcr	p15, 0, r11, c7, c11, 1
-	 */
-	cmp	r1, #0x1 		@ Check whether L2 inval is required
-	beq	omap3_do_wfi
-
-clean_l2:
-	/*
 	 * jump out to kernel flush routine
 	 *  - reuse that code is better
 	 *  - it executes in a cached space so is faster than refetch per-block
-- 
1.6.0.4

