From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 1/5] OMAP3: PM: Use ARMv7 supported instructions instead of legacy CP15 ones
Date: Thu, 10 Mar 2011 12:37:13 +0530
Message-ID: <1299740837-27881-2-git-send-email-santosh.shilimkar@ti.com>
References: <1299740837-27881-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48973 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994Ab1CJHH0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 02:07:26 -0500
In-Reply-To: <1299740837-27881-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On ARMv7 dsb, dmb instructions are supported and can be used directly
instead of their cp15 equivalnet. Also remove the opcodes for smc
and use the available instruction directly in OMAP3 low power asm code

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/sleep34xx.S |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 5403bc4..8894c08 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -145,8 +145,8 @@ ENTRY(save_secure_ram_context)
 	mov	r1, #0			@ set task id for ROM code in r1
 	mov	r2, #4			@ set some flags in r2, r6
 	mov	r6, #0xff
-	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
-	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
+	dsb				@ data write barrier
+	dmb				@ data memory barrier
 	smc	#1			@ call SMI monitor (smi #1)
 	nop
 	nop
@@ -316,9 +316,8 @@ omap3_do_wfi:
 	str	r5, [r4]		@ write back to SDRC_POWER register
 
 	/* Data memory barrier and Data sync barrier */
-	mov	r1, #0
-	mcr	p15, 0, r1, c7, c10, 4
-	mcr	p15, 0, r1, c7, c10, 5
+	dsb
+	dmb
 
 /*
  * ===================================
@@ -433,8 +432,8 @@ skipl2dis:
 	mov	r2, #4			@ set some flags in r2, r6
 	mov	r6, #0xff
 	adr	r3, l2_inv_api_params	@ r3 points to dummy parameters
-	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
-	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
+	dsb				@ data write barrier
+	dmb				@ data memory barrier
 	smc	#1			@ call SMI monitor (smi #1)
 	/* Write to Aux control register to set some bits */
 	mov	r0, #42			@ set service ID for PPA
@@ -444,8 +443,8 @@ skipl2dis:
 	mov	r6, #0xff
 	ldr	r4, scratchpad_base
 	ldr	r3, [r4, #0xBC]		@ r3 points to parameters
-	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
-	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
+	dsb				@ data write barrier
+	dmb				@ data memory barrier
 	smc	#1			@ call SMI monitor (smi #1)
 
 #ifdef CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE
@@ -459,8 +458,8 @@ skipl2dis:
 	ldr	r4, scratchpad_base
 	ldr	r3, [r4, #0xBC]
 	adds	r3, r3, #8		@ r3 points to parameters
-	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
-	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
+	dsb				@ data write barrier
+	dmb				@ data memory barrier
 	smc	#1			@ call SMI monitor (smi #1)
 #endif
 	b	logic_l1_restore
-- 
1.6.0.4

