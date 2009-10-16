From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 13/17] OMAP3: Fixed ARM aux ctrl register save/restore
Date: Fri, 16 Oct 2009 13:49:06 +0300
Message-ID: <1255690150-16853-14-git-send-email-tero.kristo@nokia.com>
References: <>
 <1255690150-16853-1-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-2-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-3-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-4-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-5-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-6-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-7-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-8-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-9-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-10-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-11-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-12-git-send-email-tero.kristo@nokia.com>
 <1255690150-16853-13-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:32302 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758504AbZJPLEk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 07:04:40 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB31QN012142
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 14:03:11 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-sa02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9GB2fa7022261
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2009 14:02:57 +0300
In-Reply-To: <1255690150-16853-13-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Current value is stored on SDRAM and it is written back during wakeup.
Previously a static value of 0x72 was written there.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/control.c   |    1 +
 arch/arm/mach-omap2/sleep34xx.S |   23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 296f2c2..730fc53 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -94,6 +94,7 @@ void *omap3_secure_ram_storage;
  * during the restore path.
  */
 u32 omap3_arm_context[128];
+u32 omap3_aux_ctrl[2] = { 0x1, 0x0 };
 
 struct omap3_control_regs {
 	u32 sysconfig;
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index f4f5ebe..0b03bf9 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -26,6 +26,7 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
+#include <asm/memory.h>
 #include <mach/io.h>
 #include <mach/control.h>
 
@@ -278,7 +279,11 @@ restore:
 	mov	r1, #0		@ set task id for ROM code in r1
 	mov	r2, #4		@ set some flags in r2, r6
 	mov	r6, #0xff
-	adr	r3, write_aux_control_params	@ r3 points to parameters
+	ldr	r3, write_aux_control_params	@ r3 points to parameters
+	ldr	r4, phys_offset
+	adds	r3, r3, r4
+	ldr	r4, page_offset
+	subs	r3, r3, r4
 	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
 	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
 	.word	0xE1600071		@ call SMI monitor (smi #1)
@@ -287,13 +292,18 @@ restore:
 l2_inv_api_params:
 	.word   0x1, 0x00
 write_aux_control_params:
-	.word   0x1, 0x72
+	.word	omap3_aux_ctrl
 l2_inv_gp:
 	/* Execute smi to invalidate L2 cache */
 	mov r12, #0x1                         @ set up to invalide L2
 smi:    .word 0xE1600070		@ Call SMI monitor (smieq)
 	/* Write to Aux control register to set some bits */
-	mov	r0, #0x72
+	ldr	r1, write_aux_control_params
+	ldr	r0, phys_offset
+	adds	r1, r1, r0
+	ldr	r0, page_offset
+	subs	r1, r1, r0
+	ldr	r0, [r1, #4]
 	mov	r12, #0x3
 	.word 0xE1600070	@ Call SMI monitor (smieq)
 logic_l1_restore:
@@ -420,6 +430,9 @@ usettbr0:
 save_context_wfi:
 	/*b	save_context_wfi*/	@ enable to debug save code
 	mov	r8, r0 /* Store SDRAM address in r8 */
+	mrc	p15, 0, r4, c1, c0, 1	@ Read Auxiliary Control Register
+	ldr	r5, write_aux_control_params
+	str	r4, [r5, #4]
         /* Check what that target sleep state is:stored in r1*/
         /* 1 - Only L1 and logic lost */
         /* 2 - Only L2 lost */
@@ -605,6 +618,10 @@ wait_dll_lock:
         bne     wait_dll_lock
         bx      lr
 
+phys_offset:
+	.word	PHYS_OFFSET
+page_offset:
+	.word	PAGE_OFFSET
 cm_idlest1_core:
 	.word	CM_IDLEST1_CORE_V
 sdrc_dlla_status:
-- 
1.5.4.3

