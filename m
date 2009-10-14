From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 22/27] OMAP3: PM: SDRC auto-refresh workaround for off-mode
Date: Wed, 14 Oct 2009 14:58:05 -0700
Message-ID: <1255557490-16787-23-git-send-email-khilman@deeprootsystems.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-5-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-6-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-7-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-8-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-9-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-10-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-11-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-12-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-13-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-14-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-15-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-16-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-17-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-18-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-19-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-20-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-21-git-send-email-khilman@deeprootsystems.com>
 <1255557490-16787-22-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:42306 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761296AbZJNV70 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Oct 2009 17:59:26 -0400
Received: by pxi10 with SMTP id 10so23299pxi.4
        for <linux-omap@vger.kernel.org>; Wed, 14 Oct 2009 14:58:49 -0700 (PDT)
In-Reply-To: <1255557490-16787-22-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tero Kristo <tero.kristo@nokia.com>

From: Tero Kristo <tero.kristo@nokia.com>

Errata: ES3.0 SDRC not sending auto-refresh when OMAP wakes-up from OFF mode

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/control.c             |    8 ++-
 arch/arm/mach-omap2/sleep34xx.S           |   84 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/mach/control.h |    1 +
 3 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 50b3afc..ca9a739 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -207,8 +207,12 @@ void omap3_save_scratchpad_contents(void)
 
 	/* Populate the Scratchpad contents */
 	scratchpad_contents.boot_config_ptr = 0x0;
-	scratchpad_contents.public_restore_ptr =
-			 virt_to_phys(get_restore_pointer());
+	if (system_rev != OMAP3430_REV_ES3_0)
+		scratchpad_contents.public_restore_ptr =
+			virt_to_phys(get_restore_pointer());
+	else
+		scratchpad_contents.public_restore_ptr =
+			virt_to_phys(get_es3_restore_pointer());
 	if (omap_type() == OMAP2_DEVICE_TYPE_GP)
 		scratchpad_contents.secure_ram_restore_ptr = 0x0;
 	else
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 34a55f1..3868ae4 100644
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
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index 9da5c5a..135611a 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -258,6 +258,7 @@ extern void omap_ctrl_writel(u32 val, u16 offset);
 extern void omap3_save_scratchpad_contents(void);
 extern void omap3_clear_scratchpad_contents(void);
 extern u32 *get_restore_pointer(void);
+extern u32 *get_es3_restore_pointer(void);
 extern u32 omap3_arm_context[128];
 extern void omap3_control_save_context(void);
 extern void omap3_control_restore_context(void);
-- 
1.6.4.3

