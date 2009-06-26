From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] OMAP3: PM: Move the clk stabilization delay to the right place
Date: Fri, 26 Jun 2009 16:59:15 +0530
Message-ID: <1246015755-9267-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43634 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751587AbZFZL3U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Jun 2009 07:29:20 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5QBTHup020083
	for <linux-omap@vger.kernel.org>; Fri, 26 Jun 2009 06:29:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

The clock stabilization delay post a M2 divider change is needed
even before a SDRC interface clock re-enable and not only before
jumping back to SDRAM.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/sram34xx.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index f41f8d9..481f912 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -97,6 +97,8 @@ ENTRY(omap3_sram_configure_core_dpll)
 	blne	lock_dll
 	bl	sdram_in_selfrefresh	@ put SDRAM in self refresh, idle SDRC
 	bl 	configure_core_dpll	@ change the DPLL3 M2 divider
+	mov	r12, r5
+	bl	wait_clk_stable		@ wait for SDRC to stabilize
 	bl	enable_sdrc		@ take SDRC out of idle
 	cmp	r4, #SDRC_UNLOCK_DLL	@ wait for DLL status to change
 	bleq	wait_dll_unlock
@@ -104,8 +106,6 @@ ENTRY(omap3_sram_configure_core_dpll)
 	cmp	r7, #1			@ if increasing SDRC clk rate,
 	beq	return_to_sdram		@ return to SDRAM code, otherwise,
 	bl	configure_sdrc		@ reprogram SDRC regs now
-	mov	r12, r5
-	bl	wait_clk_stable		@ wait for SDRC to stabilize
 return_to_sdram:
 	isb				@ prevent speculative exec past here
 	mov 	r0, #0 			@ return value
-- 
1.5.4.7

