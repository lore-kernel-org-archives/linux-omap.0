From: jean.pihet@newoldbits.com
Subject: [PATCH] OMAP3: run the ASM sleep code from DDR
Date: Fri, 17 Jun 2011 10:52:05 +0200
Message-ID: <1308300725-12150-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46001 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757271Ab1FQIwT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 04:52:19 -0400
Received: by wyb38 with SMTP id 38so153493wyb.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 01:52:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Most of the ASM sleep code (in arch/arm/mach-omap2/sleep34xx.S)
is copied to internal SRAM and run from there.
However only a small part of the code really needs to run from internal SRAM.

This fix lets most of the ASM idle code run from the DDR
in order to minimize the SRAM usage. No performance
loss or gain can be measured with a 32KHz clock period.

The only pieces of code that are mandatory in SRAM
are:
- the i443 erratum WA,
- the i581 erratum WA,
- the security extension code.

SRAM usage:
- original code:
  . 560 bytes for omap3_sram_configure_core_dpll (used by DVFS),
  . 1196 bytes for omap_sram_idle (used by suspend/resume in RETention),
  . 124 bytes for es3_sdrc_fix (used by suspend/resume in OFF mode on ES3.x),
  . 108 bytes for save_secure_ram_context (used on HS parts only).

With this fix the usage for suspend/resume in RETention goes down 288 bytes,
so the gain in SRAM usage for suspend/resume is 908 bytes.

Also fixed the SRAM initialization sequence to avoid an unnecessary
copy to SRAM at boot time and for readability.

Tested on Beagleboard (ES2.x) in idle with full RET and OFF modes.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm.h        |   20 ++-
 arch/arm/mach-omap2/pm34xx.c    |   20 ++-
 arch/arm/mach-omap2/sleep34xx.S |  316 ++++++++++++++++++++++-----------------
 arch/arm/plat-omap/sram.c       |   15 +--
 4 files changed, 213 insertions(+), 158 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 45bcfce..a4ec213 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -88,18 +88,28 @@ extern int pm_dbg_regset_init(int reg_set);
 #define pm_dbg_regset_init(reg_set) do {} while (0);
 #endif /* CONFIG_PM_DEBUG */
 
+/* 24xx */
 extern void omap24xx_idle_loop_suspend(void);
+extern unsigned int omap24xx_idle_loop_suspend_sz;
 
 extern void omap24xx_cpu_suspend(u32 dll_ctrl, void __iomem *sdrc_dlla_ctrl,
 					void __iomem *sdrc_power);
+extern unsigned int omap24xx_cpu_suspend_sz;
+
+/* 3xxx */
 extern void omap34xx_cpu_suspend(u32 *addr, int save_state);
-extern int save_secure_ram_context(u32 *addr);
-extern void omap3_save_scratchpad_contents(void);
 
-extern unsigned int omap24xx_idle_loop_suspend_sz;
+/* omap3_do_wfi function pointer and size, for copy to SRAM */
+extern void omap3_do_wfi(void);
+extern unsigned int omap3_do_wfi_sz;
+/* ... and its pointer from SRAM after copy */
+extern void (*omap3_do_wfi_sram)(void);
+
+/* save_secure_ram_context function pointer and size, for copy to SRAM */
+extern int save_secure_ram_context(u32 *addr);
 extern unsigned int save_secure_ram_context_sz;
-extern unsigned int omap24xx_cpu_suspend_sz;
-extern unsigned int omap34xx_cpu_suspend_sz;
+
+extern void omap3_save_scratchpad_contents(void);
 
 #define PM_RTA_ERRATUM_i608		(1 << 0)
 #define PM_SDRC_WAKEUP_ERRATUM_i583	(1 << 1)
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c155c9d..f056732 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -83,9 +83,8 @@ struct power_state {
 
 static LIST_HEAD(pwrst_list);
 
-static void (*_omap_sram_idle)(u32 *addr, int save_state);
-
 static int (*_omap_save_secure_sram)(u32 *addr);
+void (*omap3_do_wfi_sram)(void);
 
 static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
@@ -352,9 +351,6 @@ void omap_sram_idle(void)
 	int core_prev_state, per_prev_state;
 	u32 sdrc_pwr = 0;
 
-	if (!_omap_sram_idle)
-		return;
-
 	pwrdm_clear_all_prev_pwrst(mpu_pwrdm);
 	pwrdm_clear_all_prev_pwrst(neon_pwrdm);
 	pwrdm_clear_all_prev_pwrst(core_pwrdm);
@@ -436,7 +432,7 @@ void omap_sram_idle(void)
 	 * get saved. The restore path then reads from this
 	 * location and restores them back.
 	 */
-	_omap_sram_idle(omap3_arm_context, save_state);
+	omap34xx_cpu_suspend(omap3_arm_context, save_state);
 	cpu_init();
 
 	/* Restore normal SDRC POWER settings */
@@ -852,10 +848,17 @@ static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
 	return 0;
 }
 
+/*
+ * Push functions to SRAM
+ *
+ * The minimum set of functions is pushed to SRAM for execution:
+ * - omap3_do_wfi for erratum i581 WA,
+ * - save_secure_ram_context for security extensions.
+ */
 void omap_push_sram_idle(void)
 {
-	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
-					omap34xx_cpu_suspend_sz);
+	omap3_do_wfi_sram = omap_sram_push(omap3_do_wfi, omap3_do_wfi_sz);
+
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
 		_omap_save_secure_sram = omap_sram_push(save_secure_ram_context,
 				save_secure_ram_context_sz);
@@ -920,7 +923,6 @@ static int __init omap3_pm_init(void)
 	per_clkdm = clkdm_lookup("per_clkdm");
 	core_clkdm = clkdm_lookup("core_clkdm");
 
-	omap_push_sram_idle();
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
 #endif /* CONFIG_SUSPEND */
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 63f1066..2ef0c0d 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -179,8 +179,10 @@ ENTRY(save_secure_ram_context_sz)
  *
  *
  * Notes:
- * - this code gets copied to internal SRAM at boot and after wake-up
- *   from OFF mode. The execution pointer in SRAM is _omap_sram_idle.
+ * - only the minimum set of functions gets copied to internal SRAM at boot
+ *   and after wake-up from OFF mode, cf. omap_push_sram_idle. The function
+ *   pointers in SDRAM or SRAM are called depending on the desired low power
+ *   target state.
  * - when the OMAP wakes up it continues at different execution points
  *   depending on the low power mode (non-OFF vs OFF modes),
  *   cf. 'Resume path for xxx mode' comments.
@@ -198,9 +200,15 @@ ENTRY(omap34xx_cpu_suspend)
 	 *   3 - Both L1 and L2 lost and logic lost
 	 */
 
-	/* Directly jump to WFI is the context save is not required */
-	cmp	r1, #0x0
-	beq	omap3_do_wfi
+	/*
+	 * For OFF mode: save context and jump to WFI in SDRAM (omap3_do_wfi)
+	 * For non-OFF modes: jump to the WFI code in SRAM (omap3_do_wfi_sram)
+	 */
+	ldr	r4, omap3_do_wfi_sram_addr
+	ldr	r5, [r4]
+	cmp	r1, #0x0		@ If no context save required,
+	bxeq	r5			@  jump to the WFI code in SRAM
+
 
 	/* Otherwise fall through to the save context code */
 save_context_wfi:
@@ -284,7 +292,32 @@ clean_caches:
  THUMB(	nop		)
 	.arm
 
-omap3_do_wfi:
+	b	omap3_do_wfi
+
+/*
+ * Local variables
+ */
+omap3_do_wfi_sram_addr:
+	.word omap3_do_wfi_sram
+kernel_flush:
+	.word v7_flush_dcache_all
+
+/* ===================================
+ * == WFI instruction => Enter idle ==
+ * ===================================
+ */
+
+/*
+ * Do WFI instruction
+ * Includes the resume path for non-OFF modes
+ *
+ * This code gets copied to internal SRAM and is accessible
+ * from both SDRAM and SRAM:
+ * - executed from SRAM for non-off modes (omap3_do_wfi_sram),
+ * - executed from SDRAM for OFF mode (omap3_do_wfi).
+ */
+	.align	3
+ENTRY(omap3_do_wfi)
 	ldr	r4, sdrc_power		@ read the SDRC_POWER register
 	ldr	r5, [r4]		@ read the contents of SDRC_POWER
 	orr	r5, r5, #0x40		@ enable self refresh on idle req
@@ -316,8 +349,86 @@ omap3_do_wfi:
 	nop
 	nop
 	nop
-	bl wait_sdrc_ok
 
+/*
+ * This function implements the erratum ID i581 WA:
+ *  SDRC state restore before accessing the SDRAM
+ *
+ * Only used at return from non-OFF mode. For OFF
+ * mode the ROM code configures the SDRC and
+ * the DPLL before calling the restore code directly
+ * from DDR.
+ */
+
+/* Make sure SDRC accesses are ok */
+wait_sdrc_ok:
+
+/* DPLL3 must be locked before accessing the SDRC. Maybe the HW ensures this */
+	ldr	r4, cm_idlest_ckgen
+wait_dpll3_lock:
+	ldr	r5, [r4]
+	tst	r5, #1
+	beq	wait_dpll3_lock
+
+	ldr	r4, cm_idlest1_core
+wait_sdrc_ready:
+	ldr	r5, [r4]
+	tst	r5, #0x2
+	bne	wait_sdrc_ready
+	/* allow DLL powerdown upon hw idle req */
+	ldr	r4, sdrc_power
+	ldr	r5, [r4]
+	bic	r5, r5, #0x40
+	str	r5, [r4]
+
+/*
+ * PC-relative stores lead to undefined behaviour in Thumb-2: use a r7 as a
+ * base instead.
+ * Be careful not to clobber r7 when maintaing this code.
+ */
+
+is_dll_in_lock_mode:
+	/* Is dll in lock mode? */
+	ldr	r4, sdrc_dlla_ctrl
+	ldr	r5, [r4]
+	tst	r5, #0x4
+	bne	exit_nonoff_modes	@ Return if locked
+	/* wait till dll locks */
+	adr	r7, kick_counter
+wait_dll_lock_timed:
+	ldr	r4, wait_dll_lock_counter
+	add	r4, r4, #1
+	str	r4, [r7, #wait_dll_lock_counter - kick_counter]
+	ldr	r4, sdrc_dlla_status
+	/* Wait 20uS for lock */
+	mov	r6, #8
+wait_dll_lock:
+	subs	r6, r6, #0x1
+	beq	kick_dll
+	ldr	r5, [r4]
+	and	r5, r5, #0x4
+	cmp	r5, #0x4
+	bne	wait_dll_lock
+	b	exit_nonoff_modes	@ Return when locked
+
+	/* disable/reenable DLL if not locked */
+kick_dll:
+	ldr	r4, sdrc_dlla_ctrl
+	ldr	r5, [r4]
+	mov	r6, r5
+	bic	r6, #(1<<3)		@ disable dll
+	str	r6, [r4]
+	dsb
+	orr	r6, r6, #(1<<3)		@ enable dll
+	str	r6, [r4]
+	dsb
+	ldr	r4, kick_counter
+	add	r4, r4, #1
+	str	r4, [r7]		@ kick_counter
+	b	wait_dll_lock_timed
+
+exit_nonoff_modes:
+	/* Re-enable C-bit if needed */
 	mrc	p15, 0, r0, c1, c0, 0
 	tst	r0, #(1 << 2)		@ Check C bit enabled?
 	orreq	r0, r0, #(1 << 2)	@ Enable the C bit if cleared
@@ -331,6 +442,31 @@ omap3_do_wfi:
  */
 	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
 
+/*
+ * Local variables
+ */
+sdrc_power:
+	.word	SDRC_POWER_V
+cm_idlest1_core:
+	.word	CM_IDLEST1_CORE_V
+cm_idlest_ckgen:
+	.word	CM_IDLEST_CKGEN_V
+sdrc_dlla_status:
+	.word	SDRC_DLLA_STATUS_V
+sdrc_dlla_ctrl:
+	.word	SDRC_DLLA_CTRL_V
+	/*
+	 * When exporting to userspace while the counters are in SRAM,
+	 * these 2 words need to be at the end to facilitate retrival!
+	 */
+kick_counter:
+	.word	0
+wait_dll_lock_counter:
+	.word	0
+
+ENTRY(omap3_do_wfi_sz)
+	.word	. - omap3_do_wfi
+
 
 /*
  * ==============================
@@ -346,6 +482,10 @@ omap3_do_wfi:
  *  restore_es3: applies to 34xx >= ES3.0
  *  restore_3630: applies to 36xx
  *  restore: common code for 3xxx
+ *
+ * Note: when back from CORE and MPU OFF mode we are running
+ *  from SDRAM, without MMU, without the caches and prediction.
+ *  Also the SRAM content has been cleared.
  */
 restore_es3:
 	ldr	r5, pm_prepwstst_core_p
@@ -364,7 +504,8 @@ copy_to_sram:
 	bne	copy_to_sram
 	ldr	r1, sram_base
 	blx	r1
-	b	restore
+
+	b	restore		@ Fall through to common code
 
 restore_3630:
 	ldr	r1, pm_prepwstst_core_p
@@ -574,12 +715,41 @@ usettbr0:
 restoremmu_on:
 	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
 
+/*
+ * Local variables
+ */
+pm_prepwstst_core_p:
+	.word	PM_PREPWSTST_CORE_P
+pm_pwstctrl_mpu:
+	.word	PM_PWSTCTRL_MPU_P
+scratchpad_base:
+	.word	SCRATCHPAD_BASE_P
+sram_base:
+	.word	SRAM_BASE_P + 0x8000
+ttbrbit_mask:
+	.word	0xFFFFC000
+table_index_mask:
+	.word	0xFFF00000
+table_entry:
+	.word	0x00000C02
+cache_pred_disable_mask:
+	.word	0xFFFFE7FB
+control_stat:
+	.word	CONTROL_STAT
+control_mem_rta:
+	.word	CONTROL_MEM_RTA_CTRL
+l2dis_3630:
+	.word	0
+
 
 /*
  * Internal functions
  */
 
-/* This function implements the erratum ID i443 WA, applies to 34xx >= ES3.0 */
+/* This function implements the erratum ID i443 WA, applies to 34xx >= ES3.0
+ *
+ * Copied and run from SRAM in order to reconfigure the SDRC parameters.
+ */
 	.text
 	.align	3
 ENTRY(es3_sdrc_fix)
@@ -609,6 +779,9 @@ ENTRY(es3_sdrc_fix)
 	str	r5, [r4]		@ kick off refreshes
 	bx	lr
 
+/*
+ * Local variables
+ */
 	.align
 sdrc_syscfg:
 	.word	SDRC_SYSCONFIG_P
@@ -627,128 +800,3 @@ sdrc_manual_1:
 ENDPROC(es3_sdrc_fix)
 ENTRY(es3_sdrc_fix_sz)
 	.word	. - es3_sdrc_fix
-
-/*
- * This function implements the erratum ID i581 WA:
- *  SDRC state restore before accessing the SDRAM
- *
- * Only used at return from non-OFF mode. For OFF
- * mode the ROM code configures the SDRC and
- * the DPLL before calling the restore code directly
- * from DDR.
- */
-
-/* Make sure SDRC accesses are ok */
-wait_sdrc_ok:
-
-/* DPLL3 must be locked before accessing the SDRC. Maybe the HW ensures this */
-	ldr	r4, cm_idlest_ckgen
-wait_dpll3_lock:
-	ldr	r5, [r4]
-	tst	r5, #1
-	beq	wait_dpll3_lock
-
-	ldr	r4, cm_idlest1_core
-wait_sdrc_ready:
-	ldr	r5, [r4]
-	tst	r5, #0x2
-	bne	wait_sdrc_ready
-	/* allow DLL powerdown upon hw idle req */
-	ldr	r4, sdrc_power
-	ldr	r5, [r4]
-	bic	r5, r5, #0x40
-	str	r5, [r4]
-
-/*
- * PC-relative stores lead to undefined behaviour in Thumb-2: use a r7 as a
- * base instead.
- * Be careful not to clobber r7 when maintaing this code.
- */
-
-is_dll_in_lock_mode:
-	/* Is dll in lock mode? */
-	ldr	r4, sdrc_dlla_ctrl
-	ldr	r5, [r4]
-	tst	r5, #0x4
-	bxne	lr			@ Return if locked
-	/* wait till dll locks */
-	adr	r7, kick_counter
-wait_dll_lock_timed:
-	ldr	r4, wait_dll_lock_counter
-	add	r4, r4, #1
-	str	r4, [r7, #wait_dll_lock_counter - kick_counter]
-	ldr	r4, sdrc_dlla_status
-	/* Wait 20uS for lock */
-	mov	r6, #8
-wait_dll_lock:
-	subs	r6, r6, #0x1
-	beq	kick_dll
-	ldr	r5, [r4]
-	and	r5, r5, #0x4
-	cmp	r5, #0x4
-	bne	wait_dll_lock
-	bx	lr			@ Return when locked
-
-	/* disable/reenable DLL if not locked */
-kick_dll:
-	ldr	r4, sdrc_dlla_ctrl
-	ldr	r5, [r4]
-	mov	r6, r5
-	bic	r6, #(1<<3)		@ disable dll
-	str	r6, [r4]
-	dsb
-	orr	r6, r6, #(1<<3)		@ enable dll
-	str	r6, [r4]
-	dsb
-	ldr	r4, kick_counter
-	add	r4, r4, #1
-	str	r4, [r7]		@ kick_counter
-	b	wait_dll_lock_timed
-
-	.align
-cm_idlest1_core:
-	.word	CM_IDLEST1_CORE_V
-cm_idlest_ckgen:
-	.word	CM_IDLEST_CKGEN_V
-sdrc_dlla_status:
-	.word	SDRC_DLLA_STATUS_V
-sdrc_dlla_ctrl:
-	.word	SDRC_DLLA_CTRL_V
-pm_prepwstst_core_p:
-	.word	PM_PREPWSTST_CORE_P
-pm_pwstctrl_mpu:
-	.word	PM_PWSTCTRL_MPU_P
-scratchpad_base:
-	.word	SCRATCHPAD_BASE_P
-sram_base:
-	.word	SRAM_BASE_P + 0x8000
-sdrc_power:
-	.word	SDRC_POWER_V
-ttbrbit_mask:
-	.word	0xFFFFC000
-table_index_mask:
-	.word	0xFFF00000
-table_entry:
-	.word	0x00000C02
-cache_pred_disable_mask:
-	.word	0xFFFFE7FB
-control_stat:
-	.word	CONTROL_STAT
-control_mem_rta:
-	.word	CONTROL_MEM_RTA_CTRL
-kernel_flush:
-	.word	v7_flush_dcache_all
-l2dis_3630:
-	.word	0
-	/*
-	 * When exporting to userspace while the counters are in SRAM,
-	 * these 2 words need to be at the end to facilitate retrival!
-	 */
-kick_counter:
-	.word	0
-wait_dll_lock_counter:
-	.word	0
-ENDPROC(omap34xx_cpu_suspend)
-
-ENTRY(omap34xx_cpu_suspend_sz)
-	.word	. - omap34xx_cpu_suspend
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 6af3d0b..363c91e 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -394,20 +394,15 @@ void omap3_sram_restore_context(void)
 }
 #endif /* CONFIG_PM */
 
-static int __init omap34xx_sram_init(void)
-{
-	_omap3_sram_configure_core_dpll =
-		omap_sram_push(omap3_sram_configure_core_dpll,
-			       omap3_sram_configure_core_dpll_sz);
-	omap_push_sram_idle();
-	return 0;
-}
-#else
+#endif /* CONFIG_ARCH_OMAP3 */
+
 static inline int omap34xx_sram_init(void)
 {
+#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
+	omap3_sram_restore_context();
+#endif
 	return 0;
 }
-#endif
 
 int __init omap_sram_init(void)
 {
-- 
1.7.4.1

