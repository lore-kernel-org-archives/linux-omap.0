From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH v4 3/5] ARM: omap3: Remove hand-encoded SMC instructions
Date: Wed,  9 Feb 2011 15:01:21 +0000
Message-ID: <1297263683-10621-4-git-send-email-dave.martin@linaro.org>
References: <1297263683-10621-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50678 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab1BIPCB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 10:02:01 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so265094wyb.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Feb 2011 07:02:00 -0800 (PST)
In-Reply-To: <1297263683-10621-1-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dave Martin <dave.martin@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

For various reasons, Linux now only officially supports being built
with tools which are new enough to understand the SMC instruction.

Replacing the hand-encoded instructions when the mnemonic also
allows for correct assembly in Thumb-2 (otherwise, the result is
random data in the middle of the code).

The Makefile already ensures that this file is built with a high
enough gcc -march= flag (armv7-a).

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/sleep34xx.S |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 98d8232..a05c348 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -133,7 +133,7 @@ ENTRY(save_secure_ram_context)
 	mov	r6, #0xff
 	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
 	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
-	.word	0xE1600071		@ call SMI monitor (smi #1)
+	smc	#1			@ call SMI monitor (smi #1)
 	nop
 	nop
 	nop
@@ -408,7 +408,7 @@ skipl2dis:
 	adr	r3, l2_inv_api_params	@ r3 points to dummy parameters
 	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
 	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
-	.word	0xE1600071		@ call SMI monitor (smi #1)
+	smc	#1			@ call SMI monitor (smi #1)
 	/* Write to Aux control register to set some bits */
 	mov	r0, #42			@ set service ID for PPA
 	mov	r12, r0			@ copy secure Service ID in r12
@@ -419,7 +419,7 @@ skipl2dis:
 	ldr	r3, [r4, #0xBC]		@ r3 points to parameters
 	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
 	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
-	.word	0xE1600071		@ call SMI monitor (smi #1)
+	smc	#1			@ call SMI monitor (smi #1)
 
 #ifdef CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE
 	/* Restore L2 aux control register */
@@ -434,7 +434,7 @@ skipl2dis:
 	adds	r3, r3, #8		@ r3 points to parameters
 	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
 	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
-	.word	0xE1600071		@ call SMI monitor (smi #1)
+	smc	#1			@ call SMI monitor (smi #1)
 #endif
 	b	logic_l1_restore
 
@@ -443,18 +443,18 @@ l2_inv_api_params:
 l2_inv_gp:
 	/* Execute smi to invalidate L2 cache */
 	mov r12, #0x1			@ set up to invalidate L2
-	.word 0xE1600070		@ Call SMI monitor (smieq)
+	smc	#0			@ Call SMI monitor (smieq)
 	/* Write to Aux control register to set some bits */
 	ldr	r4, scratchpad_base
 	ldr	r3, [r4,#0xBC]
 	ldr	r0, [r3,#4]
 	mov	r12, #0x3
-	.word	0xE1600070		@ Call SMI monitor (smieq)
+	smc	#0			@ Call SMI monitor (smieq)
 	ldr	r4, scratchpad_base
 	ldr	r3, [r4,#0xBC]
 	ldr	r0, [r3,#12]
 	mov	r12, #0x2
-	.word	0xE1600070		@ Call SMI monitor (smieq)
+	smc	#0			@ Call SMI monitor (smieq)
 logic_l1_restore:
 	ldr	r1, l2dis_3630
 	cmp	r1, #0x1		@ Test if L2 re-enable needed on 3630
-- 
1.7.1

