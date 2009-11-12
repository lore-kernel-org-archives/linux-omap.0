From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 3/5] OMAP3: PM: Added support for L2 aux ctrl register save and restore
Date: Thu, 12 Nov 2009 12:07:22 +0200
Message-ID: <1258020444-3809-4-git-send-email-tero.kristo@nokia.com>
References: <>
 <1258020444-3809-1-git-send-email-tero.kristo@nokia.com>
 <1258020444-3809-2-git-send-email-tero.kristo@nokia.com>
 <1258020444-3809-3-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:43895 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbZKLKY7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 05:24:59 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id nACAOwLA020660
	for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2009 12:25:03 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id nACAOXWt012786
	for <linux-omap@vger.kernel.org>; Thu, 12 Nov 2009 12:24:37 +0200
In-Reply-To: <1258020444-3809-3-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

This patch adds a save and restore mechanism for ARM L2 auxiliary control
register. The feature is enabled by default for GP devices, but for HS/EMU
devices the user must enable the service and define the PPA service ID to
be used for setting L2 aux ctrl, as this is not currently supported by the
bootloader. If nobody alters the contents of L2 aux ctrl from its reset
value, this feature is not needed.

Kconfig option to enable HS/EMU L2 aux save and restore:
- OMAP3_L2_AUX_SECURE_SAVE_RESTORE
Kconfig option to select HS/EMU PPA service for setting L2 aux ctrl:
- OMAP3_L2_AUX_SECURE_SERVICE_SET_ID

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/sleep34xx.S |   26 ++++++++++++++++++++++++--
 arch/arm/plat-omap/Kconfig      |   17 +++++++++++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 8bd5fc5..69521be 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -284,6 +284,21 @@ restore:
 	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
 	.word	0xE1600071		@ call SMI monitor (smi #1)
 
+#ifdef CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE
+	/* Restore L2 aux control register */
+	@ set service ID for PPA
+	mov	r0, #CONFIG_OMAP3_L2_AUX_SECURE_SERVICE_SET_ID
+	mov	r12, r0		@ copy service ID in r12
+	mov	r1, #0		@ set task ID for ROM code in r1
+	mov	r2, #4		@ set some flags in r2, r6
+	mov	r6, #0xff
+	ldr	r4, scratchpad_base
+	ldr	r3, [r4, #0xBC]
+	adds	r3, r3, #8	@ r3 points to parameters
+	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
+	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
+	.word	0xE1600071		@ call SMI monitor (smi #1)
+#endif
 	b	logic_l1_restore
 l2_inv_api_params:
 	.word   0x1, 0x00
@@ -297,6 +312,11 @@ smi:    .word 0xE1600070		@ Call SMI monitor (smieq)
 	ldr	r0, [r3,#4]
 	mov	r12, #0x3
 	.word 0xE1600070	@ Call SMI monitor (smieq)
+	ldr	r4, scratchpad_base
+	ldr	r3, [r4,#0xBC]
+	ldr	r0, [r3,#12]
+	mov	r12, #0x2
+	.word 0xE1600070	@ Call SMI monitor (smieq)
 logic_l1_restore:
 	mov	r1, #0
 	/* Invalidate all instruction caches to PoU
@@ -305,7 +325,7 @@ logic_l1_restore:
 
 	ldr	r4, scratchpad_base
 	ldr	r3, [r4,#0xBC]
-	adds	r3, r3, #8
+	adds	r3, r3, #16
 	ldmia	r3!, {r4-r6}
 	mov	sp, r4
 	msr	spsr_cxsf, r5
@@ -424,7 +444,9 @@ save_context_wfi:
 	mov	r8, r0 /* Store SDRAM address in r8 */
 	mrc	p15, 0, r5, c1, c0, 1	@ Read Auxiliary Control Register
 	mov	r4, #0x1		@ Number of parameters for restore call
-	stmia	r8!, {r4-r5}
+	stmia	r8!, {r4-r5}		@ Push parameters for restore call
+	mrc	p15, 1, r5, c9, c0, 2	@ Read L2 AUX ctrl register
+	stmia	r8!, {r4-r5}		@ Push parameters for restore call
         /* Check what that target sleep state is:stored in r1*/
         /* 1 - Only L1 and logic lost */
         /* 2 - Only L2 lost */
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 2143db5..3ff1a5f 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -185,6 +185,23 @@ config OMAP3_DEBOBS
 	help
 	  Use ETK pads for debug observability
 
+config OMAP3_L2_AUX_SECURE_SAVE_RESTORE
+	bool "OMAP3 HS/EMU save and restore for L2 AUX control register"
+	depends on ARCH_OMAP3 && PM
+	default n
+	help
+	  Without this option, L2 Auxiliary control register contents are
+	  lost during off-mode entry on HS/EMU devices. This feature
+	  requires support from PPA / boot-loader in HS/EMU devices, which
+	  currently does not exist by default.
+
+config OMAP3_L2_AUX_SECURE_SERVICE_SET_ID
+	int "Service ID for the support routine to set L2 AUX control"
+	depends on OMAP3_L2_AUX_SECURE_SAVE_RESTORE
+	default 43
+	help
+	  PPA routine service ID for setting L2 auxiliary control register.
+
 config OMAP_32K_TIMER_HZ
        int "Kernel internal timer frequency for 32KHz timer"
        range 32 1024
-- 
1.5.4.3

