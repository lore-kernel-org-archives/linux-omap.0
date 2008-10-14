From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 6/6] Errata: ES3.0 SDRC not sending auto-refresh when OMAP wakes-up from OFF mode
Date: Tue, 14 Oct 2008 15:23:31 +0300
Message-ID: <1223987011-25667-7-git-send-email-tero.kristo@nokia.com>
References: <>
 <1223987011-25667-1-git-send-email-tero.kristo@nokia.com>
 <1223987011-25667-2-git-send-email-tero.kristo@nokia.com>
 <1223987011-25667-3-git-send-email-tero.kristo@nokia.com>
 <1223987011-25667-4-git-send-email-tero.kristo@nokia.com>
 <1223987011-25667-5-git-send-email-tero.kristo@nokia.com>
 <1223987011-25667-6-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:54195 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755030AbYJNKiK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 06:38:10 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9EAc39h014430
	for <linux-omap@vger.kernel.org>; Tue, 14 Oct 2008 13:38:08 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m9EAbjM0000373
	for <linux-omap@vger.kernel.org>; Tue, 14 Oct 2008 13:37:54 +0300
In-Reply-To: <1223987011-25667-6-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c         |    5 ++-
 arch/arm/mach-omap2/sleep34xx.S      |   84 +++++++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/mach/pm.h |    1 +
 3 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 513c4bf..5474b12 100755
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -982,7 +982,10 @@ void save_scratchpad_contents(void)
 	/* Get virtual address of SCRATCHPAD */
 	scratchpad_address = (u32 *) OMAP2_IO_ADDRESS(SCRATCHPAD);
 	/* Get Restore pointer to jump to while waking up from OFF */
-	restore_address = get_restore_pointer();
+	if (system_rev >= OMAP3430_REV_ES3_0)
+		restore_address = get_es3_restore_pointer();
+	else
+		restore_address = get_restore_pointer();
 	/* Convert it to physical address */
 	restore_address = (u32 *) io_v2p(restore_address);
 	/* Get address where registers are saved in SDRAM */
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index a2bdab2..f724e65 100755
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -35,6 +35,7 @@
 
 #define PM_PREPWSTST_CORE_V	OMAP34XX_PRM_REGADDR(CORE_MOD, \
 				OMAP3430_PM_PREPWSTST)
+#define PM_PREPWSTST_CORE_P	0x48306AE8
 #define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
 				OMAP3430_PM_PREPWSTST)
 #define PM_PWSTCTRL_MPU_P	0x483069E0
@@ -44,6 +45,13 @@
 				       * available */
 #define SCRATCHPAD_BASE_P	0x48002910
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
+        stmfd   sp!, {lr}     @ save registers on stack
+	adr	r0, restore_es3
+        ldmfd   sp!, {pc}     @ restore regs and return
+ENTRY(get_es3_restore_pointer_sz)
+        .word   . - get_es3_restore_pointer
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
+	.word SDRC_SYSCONFIG_P
+sdrc_mr_0:
+	.word SDRC_MR_0_P
+sdrc_emr2_0:
+	.word SDRC_EMR2_0_P
+sdrc_manual_0:
+	.word SDRC_MANUAL_0_P
+sdrc_mr_1:
+	.word SDRC_MR_1_P
+sdrc_emr2_1:
+	.word SDRC_EMR2_1_P
+sdrc_manual_1:
+	.word SDRC_MANUAL_1_P
+ENTRY(es3_sdrc_fix_sz)
+	.word	. - es3_sdrc_fix
 
 /* Function to call rom code to save secure ram context */
 ENTRY(save_secure_ram_context)
@@ -130,6 +190,24 @@ loop:
 	bl i_dll_wait
 
 	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
+restore_es3:
+	/*b restore_es3*/ 		@ Enable to debug restore code
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
+	ldmia	r0!, {r3}    @ val = *src
+	stmia	r1!, {r3}    @ *dst = val
+	subs	r2, r2, #0x1 @ num_words--
+	bne	copy_to_sram
+	ldr	r1, sram_base
+	blx	r1
 restore:
 	/* b restore*/  @ Enable to debug restore code
         /* Check what was the reason for mpu reset and store the reason in r9*/
@@ -588,12 +666,16 @@ i_dll_delay:
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
 context_mem:
diff --git a/arch/arm/plat-omap/include/mach/pm.h b/arch/arm/plat-omap/include/mach/pm.h
index 532ffe9..4a6512f 100755
--- a/arch/arm/plat-omap/include/mach/pm.h
+++ b/arch/arm/plat-omap/include/mach/pm.h
@@ -157,6 +157,7 @@ extern void omap24xx_idle_loop_suspend(void);
 extern void save_scratchpad_contents(void);
 extern void clear_scratchpad_contents(void);
 extern u32 *get_restore_pointer(void);
+extern u32 *get_es3_restore_pointer(void);
 extern void vfp_enable(void);
 
 extern unsigned int omap730_cpu_suspend_sz;
-- 
1.5.4.3

