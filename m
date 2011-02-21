From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/6] omap3: pm: Fix the mmu on sequence in the asm code
Date: Mon, 21 Feb 2011 18:49:21 +0530
Message-ID: <1298294365-30770-3-git-send-email-santosh.shilimkar@ti.com>
References: <1298294365-30770-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33612 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755962Ab1BUNTe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 08:19:34 -0500
In-Reply-To: <1298294365-30770-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

Add necessary barriers after enabling MMU. Also use the sane way to
load pc and jump to it instead of executing ldma first up.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/sleep34xx.S |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index db4cc57..4478379 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -591,12 +591,17 @@ usettbr0:
 	ldr	r2, cache_pred_disable_mask
 	and	r4, r2
 	mcr	p15, 0, r4, c1, c0, 0
+	dsb
+	isb
+	ldr     r0, =restoremmu_on
+	bx      r0
 
 /*
  * ==============================
  * == Exit point from OFF mode ==
  * ==============================
  */
+restoremmu_on:
 	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
 
 
-- 
1.6.0.4

