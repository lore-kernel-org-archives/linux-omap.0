From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 09/11] OMAP3: PM: Added support for L2 aux ctrl register save and restore
Date: Fri, 23 Oct 2009 19:03:53 +0300
Message-ID: <1256313835-2391-10-git-send-email-tero.kristo@nokia.com>
References: <>
 <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-2-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-3-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-4-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-5-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-6-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-7-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-8-git-send-email-tero.kristo@nokia.com>
 <1256313835-2391-9-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:21524 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbZJWQSt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 12:18:49 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9NGIc8w001696
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 19:18:52 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9NGIPiD022176
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 19:18:35 +0300
In-Reply-To: <1256313835-2391-9-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

This patch adds a save and restore mechanism for ARM L2 auxiliary control
register. This feature is enabled via Kconfig option
OMAP3_L2_AUX_SECURE_SAVE_RESTORE and the service ID for PPA can be provided
via option OMAP3_L2_AUX_SECURE_SERVICE_SET_ID. If bootloader does not modify
L2 aux register, using this save and restore logic for it is not needed.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/control.c   |    1 +
 arch/arm/mach-omap2/sleep34xx.S |   31 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/Kconfig      |   17 +++++++++++++++++
 3 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 730fc53..82d8f1a 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -95,6 +95,7 @@ void *omap3_secure_ram_storage;
  */
 u32 omap3_arm_context[128];
 u32 omap3_aux_ctrl[2] = { 0x1, 0x0 };
+u32 omap3_l2_aux_ctrl[2] = { 0x1, 0x0 };
 
 struct omap3_control_regs {
 	u32 sysconfig;
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 0b03bf9..e291d6d 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -288,11 +288,30 @@ restore:
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
+	ldr	r3, write_l2_aux_control_params	@ r3 points to parameters
+	ldr	r4, phys_offset
+	adds	r3, r3, r4
+	ldr	r4, page_offset
+	subs	r3, r3, r4
+	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
+	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
+	.word	0xE1600071		@ call SMI monitor (smi #1)
+#endif
 	b	logic_l1_restore
 l2_inv_api_params:
 	.word   0x1, 0x00
 write_aux_control_params:
 	.word	omap3_aux_ctrl
+write_l2_aux_control_params:
+	.word	omap3_l2_aux_ctrl
 l2_inv_gp:
 	/* Execute smi to invalidate L2 cache */
 	mov r12, #0x1                         @ set up to invalide L2
@@ -306,6 +325,15 @@ smi:    .word 0xE1600070		@ Call SMI monitor (smieq)
 	ldr	r0, [r1, #4]
 	mov	r12, #0x3
 	.word 0xE1600070	@ Call SMI monitor (smieq)
+	/* Restore L2 AUX control register */
+	ldr	r1, write_l2_aux_control_params
+	ldr	r0, phys_offset
+	adds	r1, r1, r0
+	ldr	r0, page_offset
+	subs	r1, r1, r0
+	ldr	r0, [r1, #4]
+	mov	r12, #0x2
+	.word 0xE1600070	@ Call SMI monitor (smieq)
 logic_l1_restore:
 	mov	r1, #0
 	/* Invalidate all instruction caches to PoU
@@ -433,6 +461,9 @@ save_context_wfi:
 	mrc	p15, 0, r4, c1, c0, 1	@ Read Auxiliary Control Register
 	ldr	r5, write_aux_control_params
 	str	r4, [r5, #4]
+	mrc	p15, 1, r4, c9, c0, 2	@ Read L2 AUX ctrl register
+	ldr	r5, write_l2_aux_control_params
+	str	r4, [r5, #4]
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

