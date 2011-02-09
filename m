From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH v4 5/5] ARM: omap3: Thumb-2 compatibility for sleep34xx.S
Date: Wed,  9 Feb 2011 15:01:23 +0000
Message-ID: <1297263683-10621-6-git-send-email-dave.martin@linaro.org>
References: <1297263683-10621-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37557 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab1BIPCL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 10:02:11 -0500
Received: by wwa36 with SMTP id 36so268974wwa.1
        for <linux-omap@vger.kernel.org>; Wed, 09 Feb 2011 07:02:10 -0800 (PST)
In-Reply-To: <1297263683-10621-1-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dave Martin <dave.martin@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

 * Use BSYM() to get the correct Thumb branch address
   for adr <Rd>, <label>

 * Fix an out-of-range ADR when building for ARM

 * Correctly call es3_sdrc_fix as Thumb when copied to SRAM.

 * Remove deprecated/undefined PC-relative stores

 * Add the required ENDPROC() directive for each ENTRY().

 * .align before data words

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/sleep34xx.S |   42 +++++++++++++++++++++++++++++---------
 1 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index a05c348..a204c78 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -80,8 +80,10 @@
 /* Function call to get the restore pointer for resume from OFF */
 ENTRY(get_restore_pointer)
 	stmfd	sp!, {lr}	@ save registers on stack
-	adr	r0, restore
+	adr	r0, BSYM(restore)
 	ldmfd	sp!, {pc}	@ restore regs and return
+ENDPROC(get_restore_pointer)
+	.align
 ENTRY(get_restore_pointer_sz)
 	.word	. - get_restore_pointer
 
@@ -89,8 +91,10 @@ ENTRY(get_restore_pointer_sz)
 /* Function call to get the restore pointer for 3630 resume from OFF */
 ENTRY(get_omap3630_restore_pointer)
 	stmfd	sp!, {lr}	@ save registers on stack
-	adr	r0, restore_3630
+	adr	r0, BSYM(restore_3630)
 	ldmfd	sp!, {pc}	@ restore regs and return
+ENDPROC(get_omap3630_restore_pointer)
+	.align
 ENTRY(get_omap3630_restore_pointer_sz)
 	.word	. - get_omap3630_restore_pointer
 
@@ -98,8 +102,10 @@ ENTRY(get_omap3630_restore_pointer_sz)
 /* Function call to get the restore pointer for ES3 to resume from OFF */
 ENTRY(get_es3_restore_pointer)
 	stmfd	sp!, {lr}	@ save registers on stack
-	adr	r0, restore_es3
+	adr	r0, BSYM(restore_es3)
 	ldmfd	sp!, {pc}	@ restore regs and return
+ENDPROC(get_es3_restore_pointer)
+	.align
 ENTRY(get_es3_restore_pointer_sz)
 	.word	. - get_es3_restore_pointer
 
@@ -113,8 +119,11 @@ ENTRY(enable_omap3630_toggle_l2_on_restore)
 	stmfd	sp!, {lr}	@ save registers on stack
 	/* Setup so that we will disable and enable l2 */
 	mov	r1, #0x1
-	str	r1, l2dis_3630
+ ARM(	adrl	r2, l2dis_3630	)	@ may be out of range for adr in ARM
+ THUMB(	adr	r2, l2dis_3630	)	@ Thumb has more range, but not adrl
+	str	r1, [r2]
 	ldmfd	sp!, {pc}	@ restore regs and return
+ENDPROC(enable_omap3630_toggle_l2_on_restore)
 
 	.text
 /* Function to call rom code to save secure ram context */
@@ -139,12 +148,14 @@ ENTRY(save_secure_ram_context)
 	nop
 	nop
 	ldmfd	sp!, {r1-r12, pc}
+	.align
 sram_phy_addr_mask:
 	.word	SRAM_BASE_P
 high_mask:
 	.word	0xffff
 api_params:
 	.word	0x4, 0x0, 0x0, 0x1, 0x1
+ENDPROC(save_secure_ram_context)
 ENTRY(save_secure_ram_context_sz)
 	.word	. - save_secure_ram_context
 
@@ -279,8 +290,7 @@ clean_l2:
 	 *  - 'might' have to copy address, load and jump to it
 	 */
 	ldr	r1, kernel_flush
-	mov	lr, pc
-	bx	r1
+	blx	r1
 
 omap3_do_wfi:
 	ldr	r4, sdrc_power		@ read the SDRC_POWER register
@@ -346,8 +356,8 @@ restore_es3:
 	and	r4, r4, #0x3
 	cmp	r4, #0x0	@ Check if previous power state of CORE is OFF
 	bne	restore
-	adr	r0, es3_sdrc_fix
-	ldr	r1, sram_base
+	adr	r0, es3_sdrc_fix	@ Not using BSYM clears the Thumb bit.
+	ldr	r1, sram_base	@ Must be 8-byte aligned to preserve alignment.
 	ldr	r2, es3_sdrc_fix_sz
 	mov	r2, r2, ror #2
 copy_to_sram:
@@ -356,6 +366,7 @@ copy_to_sram:
 	subs	r2, r2, #0x1	@ num_words--
 	bne	copy_to_sram
 	ldr	r1, sram_base
+ THUMB(	orr	r1, r1, #BSYM(es3_sdrc_fix) & 1 )
 	blx	r1
 	b	restore
 
@@ -438,6 +449,7 @@ skipl2dis:
 #endif
 	b	logic_l1_restore
 
+	.align
 l2_inv_api_params:
 	.word	0x1, 0x00
 l2_inv_gp:
@@ -607,6 +619,7 @@ usettbr0:
 
 /* This function implements the erratum ID i443 WA, applies to 34xx >= ES3.0 */
 	.text
+	.align	3
 ENTRY(es3_sdrc_fix)
 	ldr	r4, sdrc_syscfg		@ get config addr
 	ldr	r5, [r4]		@ get value
@@ -634,6 +647,7 @@ ENTRY(es3_sdrc_fix)
 	str	r5, [r4]		@ kick off refreshes
 	bx	lr
 
+	.align
 sdrc_syscfg:
 	.word	SDRC_SYSCONFIG_P
 sdrc_mr_0:
@@ -648,6 +662,7 @@ sdrc_emr2_1:
 	.word	SDRC_EMR2_1_P
 sdrc_manual_1:
 	.word	SDRC_MANUAL_1_P
+ENDPROC(es3_sdrc_fix)
 ENTRY(es3_sdrc_fix_sz)
 	.word	. - es3_sdrc_fix
 
@@ -682,6 +697,10 @@ wait_sdrc_ready:
 	bic	r5, r5, #0x40
 	str	r5, [r4]
 
+@ PC-relative stores lead to undefined behaviour in Thumb-2: use a r7 as a
+@ base instead.
+@ Be careful not to clobber r7 when maintaing this code.
+
 is_dll_in_lock_mode:
 	/* Is dll in lock mode? */
 	ldr	r4, sdrc_dlla_ctrl
@@ -689,10 +708,11 @@ is_dll_in_lock_mode:
 	tst	r5, #0x4
 	bxne	lr			@ Return if locked
 	/* wait till dll locks */
+	adr	r7, kick_counter
 wait_dll_lock_timed:
 	ldr	r4, wait_dll_lock_counter
 	add	r4, r4, #1
-	str	r4, wait_dll_lock_counter
+	str	r4, [r7, #wait_dll_lock_counter - kick_counter]
 	ldr	r4, sdrc_dlla_status
 	/* Wait 20uS for lock */
 	mov	r6, #8
@@ -718,9 +738,10 @@ kick_dll:
 	dsb
 	ldr	r4, kick_counter
 	add	r4, r4, #1
-	str	r4, kick_counter
+	str	r4, [r7]		@ kick_counter
 	b	wait_dll_lock_timed
 
+	.align
 cm_idlest1_core:
 	.word	CM_IDLEST1_CORE_V
 cm_idlest_ckgen:
@@ -763,6 +784,7 @@ kick_counter:
 	.word	0
 wait_dll_lock_counter:
 	.word	0
+ENDPROC(omap34xx_cpu_suspend)
 
 ENTRY(omap34xx_cpu_suspend_sz)
 	.word	. - omap34xx_cpu_suspend
-- 
1.7.1

