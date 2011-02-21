From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/6] omap3: pm: Use amrv7 supported instructions instead of legacy cp15 ones
Date: Mon, 21 Feb 2011 18:49:20 +0530
Message-ID: <1298294365-30770-2-git-send-email-santosh.shilimkar@ti.com>
References: <1298294365-30770-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41447 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755962Ab1BUNTh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 08:19:37 -0500
In-Reply-To: <1298294365-30770-1-git-send-email-santosh.shilimkar@ti.com>
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
 arch/arm/mach-omap2/sleep34xx.S |   35 +++++++++++++++++------------------
 1 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 98d8232..db4cc57 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -131,9 +131,9 @@ ENTRY(save_secure_ram_context)
 	mov	r1, #0			@ set task id for ROM code in r1
 	mov	r2, #4			@ set some flags in r2, r6
 	mov	r6, #0xff
-	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
-	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
-	.word	0xE1600071		@ call SMI monitor (smi #1)
+	dsb				@ data write barrier
+	dmb				@ data memory barrier
+	smc	#1			@ call SMI monitor (smi #1)
 	nop
 	nop
 	nop
@@ -289,9 +289,8 @@ omap3_do_wfi:
 	str	r5, [r4]		@ write back to SDRC_POWER register
 
 	/* Data memory barrier and Data sync barrier */
-	mov	r1, #0
-	mcr	p15, 0, r1, c7, c10, 4
-	mcr	p15, 0, r1, c7, c10, 5
+	dsb
+	dmb
 
 /*
  * ===================================
@@ -406,9 +405,9 @@ skipl2dis:
 	mov	r2, #4			@ set some flags in r2, r6
 	mov	r6, #0xff
 	adr	r3, l2_inv_api_params	@ r3 points to dummy parameters
-	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
-	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
-	.word	0xE1600071		@ call SMI monitor (smi #1)
+	dsb				@ data write barrier
+	dmb				@ data memory barrier
+	smc	#1			@ call SMI monitor (smi #1)
 	/* Write to Aux control register to set some bits */
 	mov	r0, #42			@ set service ID for PPA
 	mov	r12, r0			@ copy secure Service ID in r12
@@ -417,9 +416,9 @@ skipl2dis:
 	mov	r6, #0xff
 	ldr	r4, scratchpad_base
 	ldr	r3, [r4, #0xBC]		@ r3 points to parameters
-	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
-	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
-	.word	0xE1600071		@ call SMI monitor (smi #1)
+	dsb				@ data write barrier
+	dmb				@ data memory barrier
+	smc	#1			@ call SMI monitor (smi #1)
 
 #ifdef CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE
 	/* Restore L2 aux control register */
@@ -432,9 +431,9 @@ skipl2dis:
 	ldr	r4, scratchpad_base
 	ldr	r3, [r4, #0xBC]
 	adds	r3, r3, #8		@ r3 points to parameters
-	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
-	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
-	.word	0xE1600071		@ call SMI monitor (smi #1)
+	dsb				@ data write barrier
+	dmb				@ data memory barrier
+	smc	#1			@ call SMI monitor (smi #1)
 #endif
 	b	logic_l1_restore
 
@@ -443,18 +442,18 @@ l2_inv_api_params:
 l2_inv_gp:
 	/* Execute smi to invalidate L2 cache */
 	mov r12, #0x1			@ set up to invalidate L2
-	.word 0xE1600070		@ Call SMI monitor (smieq)
+	smc	#0			@ Call SMI monitor
 	/* Write to Aux control register to set some bits */
 	ldr	r4, scratchpad_base
 	ldr	r3, [r4,#0xBC]
 	ldr	r0, [r3,#4]
 	mov	r12, #0x3
-	.word	0xE1600070		@ Call SMI monitor (smieq)
+	smc	#0			@ Call SMI monitor
 	ldr	r4, scratchpad_base
 	ldr	r3, [r4,#0xBC]
 	ldr	r0, [r3,#12]
 	mov	r12, #0x2
-	.word	0xE1600070		@ Call SMI monitor (smieq)
+	smc	#0			@ Call SMI monitor
 logic_l1_restore:
 	ldr	r1, l2dis_3630
 	cmp	r1, #0x1		@ Test if L2 re-enable needed on 3630
-- 
1.6.0.4

