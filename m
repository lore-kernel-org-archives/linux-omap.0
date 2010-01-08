From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 07/13] OMAP3: Fixed ARM aux ctrl register save/restore
Date: Fri,  8 Jan 2010 09:59:25 -0800
Message-ID: <1262973571-25796-8-git-send-email-khilman@deeprootsystems.com>
References: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-2-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-3-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-4-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-5-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-6-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-7-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:47107 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728Ab0AHR7r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 12:59:47 -0500
Received: by mail-pw0-f42.google.com with SMTP id 9so160327pwj.21
        for <linux-omap@vger.kernel.org>; Fri, 08 Jan 2010 09:59:47 -0800 (PST)
In-Reply-To: <1262973571-25796-7-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

Current value is stored on SDRAM and it is written back during wakeup.
Previously a static value of 0x72 was written there.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Acked-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/sleep34xx.S |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 15268f8..c3626ea 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -245,7 +245,8 @@ restore:
 	mov	r1, #0		@ set task id for ROM code in r1
 	mov	r2, #4		@ set some flags in r2, r6
 	mov	r6, #0xff
-	adr	r3, write_aux_control_params	@ r3 points to parameters
+	ldr	r4, scratchpad_base
+	ldr	r3, [r4, #0xBC]	@ r3 points to parameters
 	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
 	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
 	.word	0xE1600071		@ call SMI monitor (smi #1)
@@ -253,14 +254,14 @@ restore:
 	b	logic_l1_restore
 l2_inv_api_params:
 	.word   0x1, 0x00
-write_aux_control_params:
-	.word   0x1, 0x72
 l2_inv_gp:
 	/* Execute smi to invalidate L2 cache */
 	mov r12, #0x1                         @ set up to invalide L2
 smi:    .word 0xE1600070		@ Call SMI monitor (smieq)
 	/* Write to Aux control register to set some bits */
-	mov	r0, #0x72
+	ldr	r4, scratchpad_base
+	ldr	r3, [r4,#0xBC]
+	ldr	r0, [r3,#4]
 	mov	r12, #0x3
 	.word 0xE1600070	@ Call SMI monitor (smieq)
 logic_l1_restore:
@@ -271,6 +272,7 @@ logic_l1_restore:
 
 	ldr	r4, scratchpad_base
 	ldr	r3, [r4,#0xBC]
+	adds	r3, r3, #8
 	ldmia	r3!, {r4-r6}
 	mov	sp, r4
 	msr	spsr_cxsf, r5
@@ -387,6 +389,9 @@ usettbr0:
 save_context_wfi:
 	/*b	save_context_wfi*/	@ enable to debug save code
 	mov	r8, r0 /* Store SDRAM address in r8 */
+	mrc	p15, 0, r5, c1, c0, 1	@ Read Auxiliary Control Register
+	mov	r4, #0x1		@ Number of parameters for restore call
+	stmia	r8!, {r4-r5}
         /* Check what that target sleep state is:stored in r1*/
         /* 1 - Only L1 and logic lost */
         /* 2 - Only L2 lost */
-- 
1.6.6.rc2.1.g42108

