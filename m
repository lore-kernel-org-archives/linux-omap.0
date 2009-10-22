From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 22/32] OMAP3: PM: SDRC auto-refresh workaround for off-mode
Date: Thu, 22 Oct 2009 16:09:43 -0700
Message-ID: <1256252993-24328-23-git-send-email-khilman@deeprootsystems.com>
References: <1256252993-24328-1-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-2-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-3-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-4-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-5-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-6-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-7-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-8-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-9-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-10-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-11-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-12-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-13-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-14-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-15-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-16-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-17-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-18-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-19-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-20-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-21-git-send-email-khilman@deeprootsystems.com>
 <1256252993-24328-22-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f194.google.com ([209.85.221.194]:37878 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450AbZJVXLN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 19:11:13 -0400
Received: by mail-qy0-f194.google.com with SMTP id 32so5544712qyk.4
        for <linux-omap@vger.kernel.org>; Thu, 22 Oct 2009 16:11:18 -0700 (PDT)
In-Reply-To: <1256252993-24328-22-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tero Kristo <tero.kristo@nokia.com>, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

From: Tero Kristo <tero.kristo@nokia.com>

Errata: ES3.0, ES3.1 SDRC not sending auto-refresh when OMAP wakes-up
from OFF mode

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/control.c             |    9 +++-
 arch/arm/mach-omap2/sleep34xx.S           |   84 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/control.h |    1 +
 3 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index c41565e..2ff8d7c 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -209,8 +209,13 @@ void omap3_save_scratchpad_contents(void)
 
 	/* Populate the Scratchpad contents */
 	scratchpad_contents.boot_config_ptr = 0x0;
-	scratchpad_contents.public_restore_ptr =
-			 virt_to_phys(get_restore_pointer());
+	if (omap_rev() != OMAP3430_REV_ES3_0 &&
+					omap_rev() != OMAP3430_REV_ES3_1)
+		scratchpad_contents.public_restore_ptr =
+			virt_to_phys(get_restore_pointer());
+	else
+		scratchpad_contents.public_restore_ptr =
+			virt_to_phys(get_es3_restore_pointer());
 	if (omap_type() == OMAP2_DEVICE_TYPE_GP)
 		scratchpad_contents.secure_ram_restore_ptr = 0x0;
 	else
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index b6abadc..dedfa0e 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -34,6 +34,7 @@
 
 #define PM_PREPWSTST_CORE_V	OMAP34XX_PRM_REGADDR(CORE_MOD, \
 				OMAP3430_PM_PREPWSTST)
+#define PM_PREPWSTST_CORE_P	0x48306AE8
 #define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
 				OMAP3430_PM_PREPWSTST)
 #define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD + PM_PWSTCTRL
@@ -44,6 +45,13 @@
 #define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE + OMAP343X_CONTROL_MEM_WKUP\
 						+ SCRATCHPAD_MEM_OFFS)
 #define SDRC_POWER_V		OMAP34XX_SDRC_REGADDR(SDRC_POWER)
+#define SDRC_SYSCONFIG_P	(OMAP343X_SDRC_BASE + SDRC_SYSCONFIG)
+#define SDRC_MR_0_P		(OMAP343X_SDRC_BASE + SDRC_MR_0)
+#define SDRC_EMR2_0_P		(OMAP343X_SDRC_BASE + SDRC_EMR2_0)
+#define SDRC_MANUAL_0_P		(OMAP343X_SDRC_BASE + SDRC_MANUAL_0)
+#define SDRC_MR_1_P		(OMAP343X_SDRC_BASE + SDRC_MR_1)
+#define SDRC_EMR2_1_P		(OMAP343X_SDRC_BASE + SDRC_EMR2_1)
+#define SDRC_MANUAL_1_P		(OMAP343X_SDRC_BASE + SDRC_MANUAL_1)
 
 	.text
 /* Function call to get the restore pointer for resume from OFF */
@@ -52,7 +60,59 @@ ENTRY(get_restore_pointer)
 	adr	r0, restore
         ldmfd   sp!, {pc}     @ restore regs and return
 ENTRY(get_restore_pointer_sz)
-        .word   . - get_restore_pointer_sz
+        .word   . - get_restore_pointer
+
+	.text
+/* Function call to get the restore pointer for for ES3 to resume from OFF */
+ENTRY(get_es3_restore_pointer)
+	stmfd	sp!, {lr}	@ save registers on stack
+	adr	r0, restore_es3
+	ldmfd	sp!, {pc}	@ restore regs and return
+ENTRY(get_es3_restore_pointer_sz)
+	.word	. - get_es3_restore_pointer
+
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
 
 /* Function to call rom code to save secure ram context */
 ENTRY(save_secure_ram_context)
@@ -130,6 +190,24 @@ loop:
 	bl i_dll_wait
 
 	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
+restore_es3:
+	/*b restore_es3*/		@ Enable to debug restore code
+	ldr	r5, pm_prepwstst_core_p
+	ldr	r4, [r5]
+	and	r4, r4, #0x3
+	cmp	r4, #0x0	@ Check if previous power state of CORE is OFF
+	bne	restore
+	adr	r0, es3_sdrc_fix
+	ldr	r1, sram_base
+	ldr	r2, es3_sdrc_fix_sz
+	mov	r2, r2, ror #2
+copy_to_sram:
+	ldmia	r0!, {r3}	@ val = *src
+	stmia	r1!, {r3}	@ *dst = val
+	subs	r2, r2, #0x1	@ num_words--
+	bne	copy_to_sram
+	ldr	r1, sram_base
+	blx	r1
 restore:
 	/* b restore*/  @ Enable to debug restore code
         /* Check what was the reason for mpu reset and store the reason in r9*/
@@ -478,12 +556,16 @@ i_dll_delay:
 	bx	lr
 pm_prepwstst_core:
 	.word	PM_PREPWSTST_CORE_V
+pm_prepwstst_core_p:
+	.word	PM_PREPWSTST_CORE_P
 pm_prepwstst_mpu:
 	.word	PM_PREPWSTST_MPU_V
 pm_pwstctrl_mpu:
 	.word	PM_PWSTCTRL_MPU_P
 scratchpad_base:
 	.word	SCRATCHPAD_BASE_P
+sram_base:
+	.word	SRAM_BASE_P + 0x8000
 sdrc_power:
 	.word SDRC_POWER_V
 clk_stabilize_delay:
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index 0308e3f..81c3e1e 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -301,6 +301,7 @@ extern void omap_ctrl_writel(u32 val, u16 offset);
 extern void omap3_save_scratchpad_contents(void);
 extern void omap3_clear_scratchpad_contents(void);
 extern u32 *get_restore_pointer(void);
+extern u32 *get_es3_restore_pointer(void);
 extern u32 omap3_arm_context[128];
 extern void omap3_control_save_context(void);
 extern void omap3_control_restore_context(void);
-- 
1.6.4.3

