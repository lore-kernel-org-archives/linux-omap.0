From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/8] OMAP3 SDRC: Move the clk stabilization delay to the right
	place
Date: Fri, 24 Jul 2009 20:11:29 -0600
Message-ID: <20090725021127.29059.29503.stgit@localhost.localdomain>
References: <20090725021102.29059.94214.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50656 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755190AbZGYCND (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 22:13:03 -0400
In-Reply-To: <20090725021102.29059.94214.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

The clock stabilization delay post a M2 divider change is needed
even before a SDRC interface clock re-enable and not only before
jumping back to SDRAM.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/sram34xx.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index e6b1125..82aa4a3 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -127,6 +127,8 @@ skip_cs1_params:
 	blne	lock_dll
 	bl	sdram_in_selfrefresh	@ put SDRAM in self refresh, idle SDRC
 	bl 	configure_core_dpll	@ change the DPLL3 M2 divider
+	mov	r12, r2
+	bl	wait_clk_stable		@ wait for SDRC to stabilize
 	bl	enable_sdrc		@ take SDRC out of idle
 	cmp	r1, #SDRC_UNLOCK_DLL	@ wait for DLL status to change
 	bleq	wait_dll_unlock
@@ -134,8 +136,6 @@ skip_cs1_params:
 	cmp	r3, #1			@ if increasing SDRC clk rate,
 	beq	return_to_sdram		@ return to SDRAM code, otherwise,
 	bl	configure_sdrc		@ reprogram SDRC regs now
-	mov	r12, r2
-	bl	wait_clk_stable		@ wait for SDRC to stabilize
 return_to_sdram:
 	isb				@ prevent speculative exec past here
 	mov 	r0, #0 			@ return value


