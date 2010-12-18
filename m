From: jean.pihet@newoldbits.com
Subject: [PATCH 4/7] OMAP3: re-organize the ASM sleep code
Date: Sat, 18 Dec 2010 16:44:44 +0100
Message-ID: <1292687087-22983-5-git-send-email-j-pihet@ti.com>
References: <1292687087-22983-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46369 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756711Ab0LRPvV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Dec 2010 10:51:21 -0500
Received: by mail-ww0-f44.google.com with SMTP id 36so1636752wwa.1
        for <linux-omap@vger.kernel.org>; Sat, 18 Dec 2010 07:51:20 -0800 (PST)
In-Reply-To: <1292687087-22983-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Organize the code in the following sections:
- register access macros,
- API functions,
- internal functions.

Tested on N900 and Beagleboard with full RET and OFF modes,
using cpuidle and suspend.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/sleep34xx.S |  114 +++++++++++++++++++++------------------
 1 files changed, 61 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 8e9f38f..beeb682 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -79,6 +79,7 @@ ENTRY(get_restore_pointer)
         ldmfd   sp!, {pc}     @ restore regs and return
 ENTRY(get_restore_pointer_sz)
         .word   . - get_restore_pointer
+
 	.text
 /* Function call to get the restore pointer for 3630 resume from OFF */
 ENTRY(get_omap3630_restore_pointer)
@@ -89,9 +90,18 @@ ENTRY(get_omap3630_restore_pointer_sz)
         .word   . - get_omap3630_restore_pointer
 
 	.text
+/* Function call to get the restore pointer for ES3 to resume from OFF */
+ENTRY(get_es3_restore_pointer)
+	stmfd	sp!, {lr}	@ save registers on stack
+	adr	r0, restore_es3
+	ldmfd	sp!, {pc}	@ restore regs and return
+ENTRY(get_es3_restore_pointer_sz)
+	.word	. - get_es3_restore_pointer
+
+	.text
 /*
  * L2 cache needs to be toggled for stable OFF mode functionality on 3630.
- * This function sets up a fflag that will allow for this toggling to take
+ * This function sets up a flag that will allow for this toggling to take
  * place on 3630. Hopefully some version in the future maynot need this
  */
 ENTRY(enable_omap3630_toggle_l2_on_restore)
@@ -101,58 +111,6 @@ ENTRY(enable_omap3630_toggle_l2_on_restore)
 	str	r1, l2dis_3630
         ldmfd   sp!, {pc}     @ restore regs and return
 
-	.text
-/* Function call to get the restore pointer for for ES3 to resume from OFF */
-ENTRY(get_es3_restore_pointer)
-	stmfd	sp!, {lr}	@ save registers on stack
-	adr	r0, restore_es3
-	ldmfd	sp!, {pc}	@ restore regs and return
-ENTRY(get_es3_restore_pointer_sz)
-	.word	. - get_es3_restore_pointer
-
-ENTRY(es3_sdrc_fix)
-	ldr	r4, sdrc_syscfg		@ get config addr
-	ldr	r5, [r4]		@ get value
-	tst	r5, #0x100		@ is part access blocked
-	it	eq
-	biceq	r5, r5, #0x100		@ clear bit if set
-	str	r5, [r4]		@ write back change
-	ldr	r4, sdrc_mr_0		@ get config addr
-	ldr	r5, [r4]		@ get value
-	str	r5, [r4]		@ write back change
-	ldr	r4, sdrc_emr2_0		@ get config addr
-	ldr	r5, [r4]		@ get value
-	str	r5, [r4]		@ write back change
-	ldr	r4, sdrc_manual_0	@ get config addr
-	mov	r5, #0x2		@ autorefresh command
-	str	r5, [r4]		@ kick off refreshes
-	ldr	r4, sdrc_mr_1		@ get config addr
-	ldr	r5, [r4]		@ get value
-	str	r5, [r4]		@ write back change
-	ldr	r4, sdrc_emr2_1		@ get config addr
-	ldr	r5, [r4]		@ get value
-	str	r5, [r4]		@ write back change
-	ldr	r4, sdrc_manual_1	@ get config addr
-	mov	r5, #0x2		@ autorefresh command
-	str	r5, [r4]		@ kick off refreshes
-	bx	lr
-sdrc_syscfg:
-	.word	SDRC_SYSCONFIG_P
-sdrc_mr_0:
-	.word	SDRC_MR_0_P
-sdrc_emr2_0:
-	.word	SDRC_EMR2_0_P
-sdrc_manual_0:
-	.word	SDRC_MANUAL_0_P
-sdrc_mr_1:
-	.word	SDRC_MR_1_P
-sdrc_emr2_1:
-	.word	SDRC_EMR2_1_P
-sdrc_manual_1:
-	.word	SDRC_MANUAL_1_P
-ENTRY(es3_sdrc_fix_sz)
-	.word	. - es3_sdrc_fix
-
 /* Function to call rom code to save secure ram context */
 ENTRY(save_secure_ram_context)
 	stmfd	sp!, {r1-r12, lr}	@ save registers on stack
@@ -577,6 +535,56 @@ skip_l2_inval:
 	/* restore regs and return */
 	ldmfd   sp!, {r0-r12, pc}
 
+
+/*
+ * Internal functions
+ */
+
+	.text
+ENTRY(es3_sdrc_fix)
+	ldr	r4, sdrc_syscfg		@ get config addr
+	ldr	r5, [r4]		@ get value
+	tst	r5, #0x100		@ is part access blocked
+	it	eq
+	biceq	r5, r5, #0x100		@ clear bit if set
+	str	r5, [r4]		@ write back change
+	ldr	r4, sdrc_mr_0		@ get config addr
+	ldr	r5, [r4]		@ get value
+	str	r5, [r4]		@ write back change
+	ldr	r4, sdrc_emr2_0		@ get config addr
+	ldr	r5, [r4]		@ get value
+	str	r5, [r4]		@ write back change
+	ldr	r4, sdrc_manual_0	@ get config addr
+	mov	r5, #0x2		@ autorefresh command
+	str	r5, [r4]		@ kick off refreshes
+	ldr	r4, sdrc_mr_1		@ get config addr
+	ldr	r5, [r4]		@ get value
+	str	r5, [r4]		@ write back change
+	ldr	r4, sdrc_emr2_1		@ get config addr
+	ldr	r5, [r4]		@ get value
+	str	r5, [r4]		@ write back change
+	ldr	r4, sdrc_manual_1	@ get config addr
+	mov	r5, #0x2		@ autorefresh command
+	str	r5, [r4]		@ kick off refreshes
+	bx	lr
+
+sdrc_syscfg:
+	.word	SDRC_SYSCONFIG_P
+sdrc_mr_0:
+	.word	SDRC_MR_0_P
+sdrc_emr2_0:
+	.word	SDRC_EMR2_0_P
+sdrc_manual_0:
+	.word	SDRC_MANUAL_0_P
+sdrc_mr_1:
+	.word	SDRC_MR_1_P
+sdrc_emr2_1:
+	.word	SDRC_EMR2_1_P
+sdrc_manual_1:
+	.word	SDRC_MANUAL_1_P
+ENTRY(es3_sdrc_fix_sz)
+	.word	. - es3_sdrc_fix
+
 /* Make sure SDRC accesses are ok */
 wait_sdrc_ok:
 
-- 
1.7.2.3

