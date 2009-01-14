From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] Wait for SDRC ready iso a blind delay
Date: Wed, 14 Jan 2009 18:04:09 +0200
Message-ID: <1231949049-7285-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:47542 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754258AbZANQEX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jan 2009 11:04:23 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n0EG4CZF016017
	for <linux-omap@vger.kernel.org>; Wed, 14 Jan 2009 18:04:20 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch improves the wakeup SRAM code polling the SDRC to become ready
instead of just waiting for a fixed amount of time.

---
 arch/arm/mach-omap2/sleep34xx.S |   50 ++++++++++++++++++++++++++++----------
 1 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 0c33e30..d29c180 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -38,6 +38,8 @@
 #define PM_PREPWSTST_CORE_P	0x48306AE8
 #define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
 				OMAP3430_PM_PREPWSTST)
+#define CM_IDLEST1_CORE_V	IO_ADDRESS(OMAP3430_CM_BASE + 0x220)
+
 /*
  * This is the physical address of the register as specified
  * by the _P. To be used while the MMU is still disabled.
@@ -57,6 +59,8 @@
 #define SDRC_MR_1_P		(OMAP343X_SDRC_BASE + SDRC_MR_1)
 #define SDRC_EMR2_1_P		(OMAP343X_SDRC_BASE + SDRC_EMR2_1)
 #define SDRC_MANUAL_1_P		(OMAP343X_SDRC_BASE + SDRC_MANUAL_1)
+#define SDRC_DLLA_STATUS_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
+#define SDRC_DLLA_CTRL_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
 
 	.text
 /* Function call to get the restore pointer for resume from OFF */
@@ -192,7 +196,7 @@ loop:
 	nop
 	nop
 	nop
-	bl i_dll_wait
+	bl wait_sdrc_ok
 
 	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
 restore_es3:
@@ -651,21 +655,41 @@ skip_l2_inval:
 	nop
 	nop
 	nop
-	bl i_dll_wait
+	bl wait_sdrc_ok
 	/* restore regs and return */
 	ldmfd   sp!, {r0-r12, pc}
 
-i_dll_wait:
-	ldr     r4, clk_stabilize_delay
-
-i_dll_delay:
-	subs    r4, r4, #0x1
-	bne     i_dll_delay
-	ldr     r4, sdrc_power
-	ldr     r5, [r4]
-	bic     r5, r5, #0x40
-	str     r5, [r4]
-	bx	lr
+/* Make sure SDRC accesses are ok */
+wait_sdrc_ok:
+        ldr     r4, cm_idlest1_core
+        ldr     r5, [r4]
+        and     r5, r5, #0x2
+        cmp     r5, #0
+        bne     wait_sdrc_ok
+        ldr     r4, sdrc_power
+        ldr     r5, [r4]
+        bic     r5, r5, #0x40
+        str     r5, [r4]
+wait_dll_lock:
+        /* Is dll in lock mode? */
+        ldr     r4, sdrc_dlla_ctrl
+        ldr     r5, [r4]
+        tst     r5, #0x4
+        bxne    lr
+        /* wait till dll locks */
+        ldr     r4, sdrc_dlla_status
+        ldr     r5, [r4]
+        and     r5, r5, #0x4
+        cmp     r5, #0x4
+        bne     wait_dll_lock
+        bx      lr
+
+cm_idlest1_core:
+	.word	CM_IDLEST1_CORE_V
+sdrc_dlla_status:
+	.word	SDRC_DLLA_STATUS_V
+sdrc_dlla_ctrl:
+	.word	SDRC_DLLA_CTRL_V
 pm_prepwstst_core:
 	.word	PM_PREPWSTST_CORE_V
 pm_prepwstst_core_p:
-- 
1.5.6.3

