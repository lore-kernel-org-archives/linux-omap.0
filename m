From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
Date: Fri, 4 Feb 2011 17:09:21 +0530
Message-ID: <6bbd9e73b48eeb3f9f7615b19949f405@mail.gmail.com>
References: <1294935563-14426-1-git-send-email-j-pihet@ti.com><b52b65db02da68b3febc0c9cf1e99040@mail.gmail.com><9215f5d7252a4b60f58c3e14a9d46f59@mail.gmail.com><AANLkTinRZyVBu=c3cHBQ7OmJv3U8717_w8Haig4R=ZQh@mail.gmail.com><86b8aab234e1451170c0937e2ab786e5@mail.gmail.com>
 <AANLkTinPxJigu8Nc5J04ciQ_c_Kw9R2xS7s1jaiqeM+F@mail.gmail.com> <782caeeca19758b50d370c17db11c78a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd48340602e12049b735594
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:35697 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751045Ab1BDLjY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 06:39:24 -0500
Received: by ywj3 with SMTP id 3so1049634ywj.0
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 03:39:22 -0800 (PST)
In-Reply-To: <782caeeca19758b50d370c17db11c78a@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, Jean Pihet-XID <j-pihet@ti.com>

--000e0cd48340602e12049b735594
Content-Type: text/plain; charset=ISO-8859-1

Jean,
> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar@ti.com]
> Sent: Tuesday, February 01, 2011 5:01 PM
> To: Jean Pihet
> Cc: linux-omap@vger.kernel.org; Jean Pihet-XID
> Subject: RE: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
>
> > -----Original Message-----
> > From: Jean Pihet [mailto:jean.pihet@newoldbits.com]
> > Sent: Tuesday, February 01, 2011 4:53 PM
> > To: Santosh Shilimkar
> > Cc: linux-omap@vger.kernel.org; Jean Pihet-XID
> > Subject: Re: [RFC/PATCH] OMAP3: run the ASM sleep code from DDR
> >
>
> [...]
> > >> Does that makes sense?
> > >>
> > > Actually not. Rather I will separate only the scenario's
> > > where CORE low power targets are attempted and only have
> > > that code run from SRAM.
> > >
> > > There are scenario's where CORE can be active because MODEM,
> > > DSP and MPU can still hit RET, OFF. And here, the errata
> > > isn't applicable.
> > >
> > > Unless I missed something here, I think in the code we check
> > > the the CORE attempted state and based on that we can do a
> > > normal WFI from DDR (no self rfersh) or WFI from
> > > SRAM with self refresh enabled.
> > No. Only the MPU attempted state is checked (this actually is the
> > 'save_state' parameter passed to omap_cpu_suspend).
> > So it makes sense to check the CORE attempted state in order to
> > decide
> > to run the WFI from internal SRAM or DDR.
> >
> > The MPU attempted state is used to decide whether to save the
> > MPU/L1/L2 context.
> >
> Looks like you miss-understood my point. As I understand from
> errata, as long as core clock domain can idle with core
> dpll divider auto idle enabled, the errata is applicable.
>
> So the only check needed is to see if the core clockdomain
> hw_auto or sw sleep is enabled.
>
> If it is suppose to be not idle(we force few C-states
> where CORE inactive is avoided for faster response),
> we can execute WFI from DDR with not enabling
> self refresh.
>
> Rest of the scenario can follow the SRAM path.
>
> Hope this is clear to you.

As per further discussion, I have updated your
patch to address above by using core clockdomain
state.

Have tested OFF and RET with this new update and they
work as expected. Feel free to update further if needed.

------
>From 49fe8164a40431807495638ec23639cc9bc53cb9 Mon Sep 17 00:00:00 2001
From: Jean Pihet <j-pihet@ti.com>
Date: Sat, 29 Jan 2011 20:51:19 +0530
Subject: [PATCH] OMAP3: run the ASM sleep code from DDR

Most of the ASM sleep code (in arch/arm/mach-omap2/sleep34xx.S)
is copied to internal SRAM and run from there.
However only a small part of the code really needs to run from internal
SRAM.

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
  . 1368 bytes for omap_sram_idle (used by suspend/resume in RETention),
  . 124 bytes for es3_sdrc_fix (used by suspend/resume in OFF mode on
ES3.x),
  . 108 bytes for save_secure_ram_context (used on HS parts).

With this fix the usage for suspend/resume in RETention goes down 312
bytes, so the
gain in SRAM usage for suspend/resume is > 1KB.

Tested on OMAP3EVM, Beagleboard (ES2.x) and N900 (ES3.1)
in idle with full RET and OFF modes.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm.h        |   19 ++-
 arch/arm/mach-omap2/pm34xx.c    |   19 ++-
 arch/arm/mach-omap2/sleep34xx.S |  321
+++++++++++++++++++++++----------------
 3 files changed, 219 insertions(+), 140 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 1c1b0ab..ae9dec0 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -87,18 +87,29 @@ extern int pm_dbg_regset_init(int reg_set);
 #define pm_dbg_regset_init(reg_set) do {} while (0);
 #endif /* CONFIG_PM_DEBUG */

+/* 24xx */
 extern void omap24xx_idle_loop_suspend(void);
+extern unsigned int omap24xx_idle_loop_suspend_sz;

 extern void omap24xx_cpu_suspend(u32 dll_ctrl, void __iomem
*sdrc_dlla_ctrl,
 					void __iomem *sdrc_power);
+extern unsigned int omap24xx_cpu_suspend_sz;
+
+/* 3xxx */
 extern void omap34xx_cpu_suspend(u32 *addr, int save_state);
+
+/* omap3_do_wfi function pointer and size, for copy to SRAM */
+extern void omap3_do_wfi(void);
+extern unsigned int omap3_do_wfi_sz;
+/* ... and its pointer from SRAM after copy */
+extern void (*omap3_do_wfi_sram)(void);
+
+/* save_secure_ram_context function pointer and size, for copy to SRAM */
 extern void save_secure_ram_context(u32 *addr);
-extern void omap3_save_scratchpad_contents(void);

-extern unsigned int omap24xx_idle_loop_suspend_sz;
 extern unsigned int save_secure_ram_context_sz;
-extern unsigned int omap24xx_cpu_suspend_sz;
-extern unsigned int omap34xx_cpu_suspend_sz;
+
+extern void omap3_save_scratchpad_contents(void);

 #define PM_RTA_ERRATUM_i608		(1 << 0)
 #define PM_SDRC_WAKEUP_ERRATUM_i583	(1 << 1)
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1b81e8d..cdfd627 100644
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
@@ -357,9 +356,6 @@ void omap_sram_idle(void)
 	int core_prev_state, per_prev_state;
 	u32 sdrc_pwr = 0;

-	if (!_omap_sram_idle)
-		return;
-
 	pwrdm_clear_all_prev_pwrst(mpu_pwrdm);
 	pwrdm_clear_all_prev_pwrst(neon_pwrdm);
 	pwrdm_clear_all_prev_pwrst(core_pwrdm);
@@ -444,7 +440,7 @@ void omap_sram_idle(void)
 	 * get saved. The restore path then reads from this
 	 * location and restores them back.
 	 */
-	_omap_sram_idle(omap3_arm_context, save_state);
+	omap34xx_cpu_suspend(omap3_arm_context, save_state);
 	cpu_init();

 	if (is_suspending())
@@ -993,10 +989,17 @@ static int __init clkdms_setup(struct clockdomain
*clkdm, void *unused)
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
 		_omap_save_secure_sram =
omap_sram_push(save_secure_ram_context,
 				save_secure_ram_context_sz);
diff --git a/arch/arm/mach-omap2/sleep34xx.S
b/arch/arm/mach-omap2/sleep34xx.S
index 98d8232..8a987f7 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -42,6 +42,7 @@
 					OMAP3430_PM_PREPWSTST
 #define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD +
OMAP2_PM_PWSTCTRL
 #define CM_IDLEST1_CORE_V	OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST1)
+#define CM_CLKSTCTRL_CORE_V	OMAP34XX_CM_REGADDR(CORE_MOD,
OMAP2_CM_CLKSTCTRL)
 #define CM_IDLEST_CKGEN_V	OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST)
 #define SRAM_BASE_P		OMAP3_SRAM_PA
 #define CONTROL_STAT		OMAP343X_CTRL_BASE +
OMAP343X_CONTROL_STATUS
@@ -163,8 +164,10 @@ ENTRY(save_secure_ram_context_sz)
  *
  *
  * Notes:
- * - this code gets copied to internal SRAM at boot and after wake-up
- *   from OFF mode. The execution pointer in SRAM is _omap_sram_idle.
+ * - only the minimum set of functions gets copied to internal SRAM at
boot
+ *   and after wake-up from OFF mode, cf. omap_push_sram_idle. The
function
+ *   pointers in SDRAM or SRAM are called depending on the desired low
power
+ *   target state.
  * - when the OMAP wakes up it continues at different execution points
  *   depending on the low power mode (non-OFF vs OFF modes),
  *   cf. 'Resume path for xxx mode' comments.
@@ -181,9 +184,15 @@ ENTRY(omap34xx_cpu_suspend)
 	 *   3 - Both L1 and L2 lost
 	 */

-	/* Directly jump to WFI is the context save is not required */
-	cmp	r1, #0x0
-	beq	omap3_do_wfi
+	/*
+	 * For OFF mode: save context and jump to WFI in SDRAM
(omap3_do_wfi)
+	 * For non-OFF modes: jump to the WFI code in SRAM
(omap3_do_wfi_sram)
+	 */
+	ldr	r4, omap3_do_wfi_sram_addr
+	ldr	r5, [r4]
+	cmp	r1, #0x0		@ If no context save required,
+	bxeq	r5			@  jump to the WFI code in SRAM
+

 	/* Otherwise fall through to the save context code */
 save_context_wfi:
@@ -268,7 +277,7 @@ clean_caches:
 	 * mcr	p15, 0, r11, c7, c11, 1
 	 */
 	cmp	r1, #0x1 		@ Check whether L2 inval is
required
-	beq	omap3_do_wfi
+	beq	do_WFI

 clean_l2:
 	/*
@@ -282,7 +291,44 @@ clean_l2:
 	mov	lr, pc
 	bx	r1

-omap3_do_wfi:
+do_WFI:
+	ldr	r4, cm_clkstctrl_core	@ read the CLKSTCTRL_CORE
+	ldr	r5, [r4]		@ read the contents of
CLKSTCTRL_CORE
+	and	r5, r5, #0x3
+	cmp	r5, #0x3
+	beq	omap3_do_wfi		@ Jumpt to SRAM function
+	mov	r1, #0
+	mcr	p15, 0, r1, c7, c10, 4
+	mcr	p15, 0, r1, c7, c10, 5
+
+	wfi				@ wait for interrupt
+
+	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
+
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
+ENTRY(omap3_do_wfi)
 	ldr	r4, sdrc_power		@ read the SDRC_POWER register
 	ldr	r5, [r4]		@ read the contents of SDRC_POWER
 	orr	r5, r5, #0x40		@ enable self refresh on idle req
@@ -302,7 +348,7 @@ omap3_do_wfi:

 /*
  * ===================================
- * == Resume path for non-OFF modes ==
+ * == Resume path for OFF/RET modes ==
  * ===================================
  */
 	nop
@@ -315,15 +361,113 @@ omap3_do_wfi:
 	nop
 	nop
 	nop
-	bl wait_sdrc_ok
+
+/*
+ * wait_sdrc_ok implements the erratum ID i581 WA:
+ *  SDRC state restore before accessing the SDRAM
+ *
+ * Only used at return from non-OFF mode. For OFF
+ * mode the ROM code configures the SDRC and
+ * the DPLL before calling the restore code directly
+ * from SDRAM.
+ */
+
+/* Make sure SDRC accesses are ok */
+wait_sdrc_ok:
+
+/* DPLL3 must be locked before accessing the SDRC. Maybe the HW ensures
this */
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
+is_dll_in_lock_mode:
+	/* Is dll in lock mode? */
+	ldr	r4, sdrc_dlla_ctrl
+	ldr	r5, [r4]
+	tst	r5, #0x4
+	bne	exit_nonoff_modes	@ Return if locked
+
+	/* wait till dll locks */
+wait_dll_lock_timed:
+	ldr	r4, wait_dll_lock_counter
+	add	r4, r4, #1
+	str	r4, wait_dll_lock_counter
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
+	str	r4, kick_counter
+	b	wait_dll_lock_timed

 /*
  * ===================================
- * == Exit point from non-OFF modes ==
+ * == Exit point from OFF/RET modes ==
  * ===================================
  */
+exit_nonoff_modes:
 	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return

+/*
+ * Local variables
+ */
+sdrc_power:
+	.word	SDRC_POWER_V
+cm_idlest1_core:
+	.word	CM_IDLEST1_CORE_V
+cm_clkstctrl_core:
+	.word CM_CLKSTCTRL_CORE_V
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
@@ -339,6 +483,10 @@ omap3_do_wfi:
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
@@ -357,7 +505,8 @@ copy_to_sram:
 	bne	copy_to_sram
 	ldr	r1, sram_base
 	blx	r1
-	b	restore
+
+	b	restore		@ Fall through to common code

 restore_3630:
 	ldr	r1, pm_prepwstst_core_p
@@ -600,12 +749,41 @@ usettbr0:
  */
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

-/* This function implements the erratum ID i443 WA, applies to 34xx >=
ES3.0 */
+/* This function implements the erratum ID i443 WA, applies to 34xx >=
ES3.0
+ *
+ * Copied and run from SRAM in order to reconfigure the SDRC parameters.
+ */
 	.text
 ENTRY(es3_sdrc_fix)
 	ldr	r4, sdrc_syscfg		@ get config addr
@@ -634,6 +812,9 @@ ENTRY(es3_sdrc_fix)
 	str	r5, [r4]		@ kick off refreshes
 	bx	lr

+/*
+ * Local variables
+ */
 sdrc_syscfg:
 	.word	SDRC_SYSCONFIG_P
 sdrc_mr_0:
@@ -650,119 +831,3 @@ sdrc_manual_1:
 	.word	SDRC_MANUAL_1_P
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
-/* DPLL3 must be locked before accessing the SDRC. Maybe the HW ensures
this */
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
-is_dll_in_lock_mode:
-	/* Is dll in lock mode? */
-	ldr	r4, sdrc_dlla_ctrl
-	ldr	r5, [r4]
-	tst	r5, #0x4
-	bxne	lr			@ Return if locked
-	/* wait till dll locks */
-wait_dll_lock_timed:
-	ldr	r4, wait_dll_lock_counter
-	add	r4, r4, #1
-	str	r4, wait_dll_lock_counter
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
-	str	r4, kick_counter
-	b	wait_dll_lock_timed
-
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
-
-ENTRY(omap34xx_cpu_suspend_sz)
-	.word	. - omap34xx_cpu_suspend
-- 
1.6.0.4

--000e0cd48340602e12049b735594
Content-Type: application/octet-stream;
	name="0001-OMAP3-run-the-ASM-sleep-code-from-DDR.patch"
Content-Disposition: attachment;
	filename="0001-OMAP3-run-the-ASM-sleep-code-from-DDR.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: 22f3769164d87000_0.1

RnJvbSA0OWZlODE2NGE0MDQzMTgwNzQ5NTYzOGVjMjM2MzljYzliYzUzY2I5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKZWFuIFBpaGV0IDxqLXBpaGV0QHRpLmNvbT4KRGF0ZTogU2F0
LCAyOSBKYW4gMjAxMSAyMDo1MToxOSArMDUzMApTdWJqZWN0OiBbUEFUQ0hdIE9NQVAzOiBydW4g
dGhlIEFTTSBzbGVlcCBjb2RlIGZyb20gRERSCgpNb3N0IG9mIHRoZSBBU00gc2xlZXAgY29kZSAo
aW4gYXJjaC9hcm0vbWFjaC1vbWFwMi9zbGVlcDM0eHguUykKaXMgY29waWVkIHRvIGludGVybmFs
IFNSQU0gYW5kIHJ1biBmcm9tIHRoZXJlLgpIb3dldmVyIG9ubHkgYSBzbWFsbCBwYXJ0IG9mIHRo
ZSBjb2RlIHJlYWxseSBuZWVkcyB0byBydW4gZnJvbSBpbnRlcm5hbCBTUkFNLgoKVGhpcyBmaXgg
bGV0cyBtb3N0IG9mIHRoZSBBU00gaWRsZSBjb2RlIHJ1biBmcm9tIHRoZSBERFIKaW4gb3JkZXIg
dG8gbWluaW1pemUgdGhlIFNSQU0gdXNhZ2UuIE5vIHBlcmZvcm1hbmNlCmxvc3Mgb3IgZ2FpbiBj
YW4gYmUgbWVhc3VyZWQgd2l0aCBhIDMyS0h6IGNsb2NrIHBlcmlvZC4KClRoZSBvbmx5IHBpZWNl
cyBvZiBjb2RlIHRoYXQgYXJlIG1hbmRhdG9yeSBpbiBTUkFNCmFyZToKLSB0aGUgaTQ0MyBlcnJh
dHVtIFdBLAotIHRoZSBpNTgxIGVycmF0dW0gV0EsCi0gdGhlIHNlY3VyaXR5IGV4dGVuc2lvbiBj
b2RlLgoKU1JBTSB1c2FnZToKLSBvcmlnaW5hbCBjb2RlOgogIC4gNTYwIGJ5dGVzIGZvciBvbWFw
M19zcmFtX2NvbmZpZ3VyZV9jb3JlX2RwbGwgKHVzZWQgYnkgRFZGUyksCiAgLiAxMzY4IGJ5dGVz
IGZvciBvbWFwX3NyYW1faWRsZSAodXNlZCBieSBzdXNwZW5kL3Jlc3VtZSBpbiBSRVRlbnRpb24p
LAogIC4gMTI0IGJ5dGVzIGZvciBlczNfc2RyY19maXggKHVzZWQgYnkgc3VzcGVuZC9yZXN1bWUg
aW4gT0ZGIG1vZGUgb24gRVMzLngpLAogIC4gMTA4IGJ5dGVzIGZvciBzYXZlX3NlY3VyZV9yYW1f
Y29udGV4dCAodXNlZCBvbiBIUyBwYXJ0cykuCgpXaXRoIHRoaXMgZml4IHRoZSB1c2FnZSBmb3Ig
c3VzcGVuZC9yZXN1bWUgaW4gUkVUZW50aW9uIGdvZXMgZG93biAzMTIgYnl0ZXMsIHNvIHRoZQpn
YWluIGluIFNSQU0gdXNhZ2UgZm9yIHN1c3BlbmQvcmVzdW1lIGlzID4gMUtCLgoKVGVzdGVkIG9u
IE9NQVAzRVZNLCBCZWFnbGVib2FyZCAoRVMyLngpIGFuZCBOOTAwIChFUzMuMSkKaW4gaWRsZSB3
aXRoIGZ1bGwgUkVUIGFuZCBPRkYgbW9kZXMuCgpTaWduZWQtb2ZmLWJ5OiBKZWFuIFBpaGV0IDxq
LXBpaGV0QHRpLmNvbT4KLS0tCiBhcmNoL2FybS9tYWNoLW9tYXAyL3BtLmggICAgICAgIHwgICAx
OSArKy0KIGFyY2gvYXJtL21hY2gtb21hcDIvcG0zNHh4LmMgICAgfCAgIDE5ICsrLQogYXJjaC9h
cm0vbWFjaC1vbWFwMi9zbGVlcDM0eHguUyB8ICAzMjEgKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tCiAzIGZpbGVzIGNoYW5nZWQsIDIxOSBpbnNlcnRpb25zKCspLCAxNDAg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9wbS5oIGIvYXJj
aC9hcm0vbWFjaC1vbWFwMi9wbS5oCmluZGV4IDFjMWIwYWIuLmFlOWRlYzAgMTAwNjQ0Ci0tLSBh
L2FyY2gvYXJtL21hY2gtb21hcDIvcG0uaAorKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL3BtLmgK
QEAgLTg3LDE4ICs4NywyOSBAQCBleHRlcm4gaW50IHBtX2RiZ19yZWdzZXRfaW5pdChpbnQgcmVn
X3NldCk7CiAjZGVmaW5lIHBtX2RiZ19yZWdzZXRfaW5pdChyZWdfc2V0KSBkbyB7fSB3aGlsZSAo
MCk7CiAjZW5kaWYgLyogQ09ORklHX1BNX0RFQlVHICovCiAKKy8qIDI0eHggKi8KIGV4dGVybiB2
b2lkIG9tYXAyNHh4X2lkbGVfbG9vcF9zdXNwZW5kKHZvaWQpOworZXh0ZXJuIHVuc2lnbmVkIGlu
dCBvbWFwMjR4eF9pZGxlX2xvb3Bfc3VzcGVuZF9zejsKIAogZXh0ZXJuIHZvaWQgb21hcDI0eHhf
Y3B1X3N1c3BlbmQodTMyIGRsbF9jdHJsLCB2b2lkIF9faW9tZW0gKnNkcmNfZGxsYV9jdHJsLAog
CQkJCQl2b2lkIF9faW9tZW0gKnNkcmNfcG93ZXIpOworZXh0ZXJuIHVuc2lnbmVkIGludCBvbWFw
MjR4eF9jcHVfc3VzcGVuZF9zejsKKworLyogM3h4eCAqLwogZXh0ZXJuIHZvaWQgb21hcDM0eHhf
Y3B1X3N1c3BlbmQodTMyICphZGRyLCBpbnQgc2F2ZV9zdGF0ZSk7CisKKy8qIG9tYXAzX2RvX3dm
aSBmdW5jdGlvbiBwb2ludGVyIGFuZCBzaXplLCBmb3IgY29weSB0byBTUkFNICovCitleHRlcm4g
dm9pZCBvbWFwM19kb193Zmkodm9pZCk7CitleHRlcm4gdW5zaWduZWQgaW50IG9tYXAzX2RvX3dm
aV9zejsKKy8qIC4uLiBhbmQgaXRzIHBvaW50ZXIgZnJvbSBTUkFNIGFmdGVyIGNvcHkgKi8KK2V4
dGVybiB2b2lkICgqb21hcDNfZG9fd2ZpX3NyYW0pKHZvaWQpOworCisvKiBzYXZlX3NlY3VyZV9y
YW1fY29udGV4dCBmdW5jdGlvbiBwb2ludGVyIGFuZCBzaXplLCBmb3IgY29weSB0byBTUkFNICov
CiBleHRlcm4gdm9pZCBzYXZlX3NlY3VyZV9yYW1fY29udGV4dCh1MzIgKmFkZHIpOwotZXh0ZXJu
IHZvaWQgb21hcDNfc2F2ZV9zY3JhdGNocGFkX2NvbnRlbnRzKHZvaWQpOwogCi1leHRlcm4gdW5z
aWduZWQgaW50IG9tYXAyNHh4X2lkbGVfbG9vcF9zdXNwZW5kX3N6OwogZXh0ZXJuIHVuc2lnbmVk
IGludCBzYXZlX3NlY3VyZV9yYW1fY29udGV4dF9zejsKLWV4dGVybiB1bnNpZ25lZCBpbnQgb21h
cDI0eHhfY3B1X3N1c3BlbmRfc3o7Ci1leHRlcm4gdW5zaWduZWQgaW50IG9tYXAzNHh4X2NwdV9z
dXNwZW5kX3N6OworCitleHRlcm4gdm9pZCBvbWFwM19zYXZlX3NjcmF0Y2hwYWRfY29udGVudHMo
dm9pZCk7CiAKICNkZWZpbmUgUE1fUlRBX0VSUkFUVU1faTYwOAkJKDEgPDwgMCkKICNkZWZpbmUg
UE1fU0RSQ19XQUtFVVBfRVJSQVRVTV9pNTgzCSgxIDw8IDEpCmRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9tYWNoLW9tYXAyL3BtMzR4eC5jIGIvYXJjaC9hcm0vbWFjaC1vbWFwMi9wbTM0eHguYwppbmRl
eCAxYjgxZThkLi5jZGZkNjI3IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW9tYXAyL3BtMzR4
eC5jCisrKyBiL2FyY2gvYXJtL21hY2gtb21hcDIvcG0zNHh4LmMKQEAgLTgzLDkgKzgzLDggQEAg
c3RydWN0IHBvd2VyX3N0YXRlIHsKIAogc3RhdGljIExJU1RfSEVBRChwd3JzdF9saXN0KTsKIAot
c3RhdGljIHZvaWQgKCpfb21hcF9zcmFtX2lkbGUpKHUzMiAqYWRkciwgaW50IHNhdmVfc3RhdGUp
OwotCiBzdGF0aWMgaW50ICgqX29tYXBfc2F2ZV9zZWN1cmVfc3JhbSkodTMyICphZGRyKTsKK3Zv
aWQgKCpvbWFwM19kb193Zmlfc3JhbSkodm9pZCk7CiAKIHN0YXRpYyBzdHJ1Y3QgcG93ZXJkb21h
aW4gKm1wdV9wd3JkbSwgKm5lb25fcHdyZG07CiBzdGF0aWMgc3RydWN0IHBvd2VyZG9tYWluICpj
b3JlX3B3cmRtLCAqcGVyX3B3cmRtOwpAQCAtMzU3LDkgKzM1Niw2IEBAIHZvaWQgb21hcF9zcmFt
X2lkbGUodm9pZCkKIAlpbnQgY29yZV9wcmV2X3N0YXRlLCBwZXJfcHJldl9zdGF0ZTsKIAl1MzIg
c2RyY19wd3IgPSAwOwogCi0JaWYgKCFfb21hcF9zcmFtX2lkbGUpCi0JCXJldHVybjsKLQogCXB3
cmRtX2NsZWFyX2FsbF9wcmV2X3B3cnN0KG1wdV9wd3JkbSk7CiAJcHdyZG1fY2xlYXJfYWxsX3By
ZXZfcHdyc3QobmVvbl9wd3JkbSk7CiAJcHdyZG1fY2xlYXJfYWxsX3ByZXZfcHdyc3QoY29yZV9w
d3JkbSk7CkBAIC00NDQsNyArNDQwLDcgQEAgdm9pZCBvbWFwX3NyYW1faWRsZSh2b2lkKQogCSAq
IGdldCBzYXZlZC4gVGhlIHJlc3RvcmUgcGF0aCB0aGVuIHJlYWRzIGZyb20gdGhpcwogCSAqIGxv
Y2F0aW9uIGFuZCByZXN0b3JlcyB0aGVtIGJhY2suCiAJICovCi0JX29tYXBfc3JhbV9pZGxlKG9t
YXAzX2FybV9jb250ZXh0LCBzYXZlX3N0YXRlKTsKKwlvbWFwMzR4eF9jcHVfc3VzcGVuZChvbWFw
M19hcm1fY29udGV4dCwgc2F2ZV9zdGF0ZSk7CiAJY3B1X2luaXQoKTsKIAogCWlmIChpc19zdXNw
ZW5kaW5nKCkpCkBAIC05OTMsMTAgKzk4OSwxNyBAQCBzdGF0aWMgaW50IF9faW5pdCBjbGtkbXNf
c2V0dXAoc3RydWN0IGNsb2NrZG9tYWluICpjbGtkbSwgdm9pZCAqdW51c2VkKQogCXJldHVybiAw
OwogfQogCisvKgorICogUHVzaCBmdW5jdGlvbnMgdG8gU1JBTQorICoKKyAqIFRoZSBtaW5pbXVt
IHNldCBvZiBmdW5jdGlvbnMgaXMgcHVzaGVkIHRvIFNSQU0gZm9yIGV4ZWN1dGlvbjoKKyAqIC0g
b21hcDNfZG9fd2ZpIGZvciBlcnJhdHVtIGk1ODEgV0EsCisgKiAtIHNhdmVfc2VjdXJlX3JhbV9j
b250ZXh0IGZvciBzZWN1cml0eSBleHRlbnNpb25zLgorICovCiB2b2lkIG9tYXBfcHVzaF9zcmFt
X2lkbGUodm9pZCkKIHsKLQlfb21hcF9zcmFtX2lkbGUgPSBvbWFwX3NyYW1fcHVzaChvbWFwMzR4
eF9jcHVfc3VzcGVuZCwKLQkJCQkJb21hcDM0eHhfY3B1X3N1c3BlbmRfc3opOworCW9tYXAzX2Rv
X3dmaV9zcmFtID0gb21hcF9zcmFtX3B1c2gob21hcDNfZG9fd2ZpLCBvbWFwM19kb193Zmlfc3op
OworCiAJaWYgKG9tYXBfdHlwZSgpICE9IE9NQVAyX0RFVklDRV9UWVBFX0dQKQogCQlfb21hcF9z
YXZlX3NlY3VyZV9zcmFtID0gb21hcF9zcmFtX3B1c2goc2F2ZV9zZWN1cmVfcmFtX2NvbnRleHQs
CiAJCQkJc2F2ZV9zZWN1cmVfcmFtX2NvbnRleHRfc3opOwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
bWFjaC1vbWFwMi9zbGVlcDM0eHguUyBiL2FyY2gvYXJtL21hY2gtb21hcDIvc2xlZXAzNHh4LlMK
aW5kZXggOThkODIzMi4uOGE5ODdmNyAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1vbWFwMi9z
bGVlcDM0eHguUworKysgYi9hcmNoL2FybS9tYWNoLW9tYXAyL3NsZWVwMzR4eC5TCkBAIC00Miw2
ICs0Miw3IEBACiAJCQkJCU9NQVAzNDMwX1BNX1BSRVBXU1RTVAogI2RlZmluZSBQTV9QV1NUQ1RS
TF9NUFVfUAlPTUFQMzQzMF9QUk1fQkFTRSArIE1QVV9NT0QgKyBPTUFQMl9QTV9QV1NUQ1RSTAog
I2RlZmluZSBDTV9JRExFU1QxX0NPUkVfVglPTUFQMzRYWF9DTV9SRUdBRERSKENPUkVfTU9ELCBD
TV9JRExFU1QxKQorI2RlZmluZSBDTV9DTEtTVENUUkxfQ09SRV9WCU9NQVAzNFhYX0NNX1JFR0FE
RFIoQ09SRV9NT0QsIE9NQVAyX0NNX0NMS1NUQ1RSTCkKICNkZWZpbmUgQ01fSURMRVNUX0NLR0VO
X1YJT01BUDM0WFhfQ01fUkVHQUREUihQTExfTU9ELCBDTV9JRExFU1QpCiAjZGVmaW5lIFNSQU1f
QkFTRV9QCQlPTUFQM19TUkFNX1BBCiAjZGVmaW5lIENPTlRST0xfU1RBVAkJT01BUDM0M1hfQ1RS
TF9CQVNFICsgT01BUDM0M1hfQ09OVFJPTF9TVEFUVVMKQEAgLTE2Myw4ICsxNjQsMTAgQEAgRU5U
Ulkoc2F2ZV9zZWN1cmVfcmFtX2NvbnRleHRfc3opCiAgKgogICoKICAqIE5vdGVzOgotICogLSB0
aGlzIGNvZGUgZ2V0cyBjb3BpZWQgdG8gaW50ZXJuYWwgU1JBTSBhdCBib290IGFuZCBhZnRlciB3
YWtlLXVwCi0gKiAgIGZyb20gT0ZGIG1vZGUuIFRoZSBleGVjdXRpb24gcG9pbnRlciBpbiBTUkFN
IGlzIF9vbWFwX3NyYW1faWRsZS4KKyAqIC0gb25seSB0aGUgbWluaW11bSBzZXQgb2YgZnVuY3Rp
b25zIGdldHMgY29waWVkIHRvIGludGVybmFsIFNSQU0gYXQgYm9vdAorICogICBhbmQgYWZ0ZXIg
d2FrZS11cCBmcm9tIE9GRiBtb2RlLCBjZi4gb21hcF9wdXNoX3NyYW1faWRsZS4gVGhlIGZ1bmN0
aW9uCisgKiAgIHBvaW50ZXJzIGluIFNEUkFNIG9yIFNSQU0gYXJlIGNhbGxlZCBkZXBlbmRpbmcg
b24gdGhlIGRlc2lyZWQgbG93IHBvd2VyCisgKiAgIHRhcmdldCBzdGF0ZS4KICAqIC0gd2hlbiB0
aGUgT01BUCB3YWtlcyB1cCBpdCBjb250aW51ZXMgYXQgZGlmZmVyZW50IGV4ZWN1dGlvbiBwb2lu
dHMKICAqICAgZGVwZW5kaW5nIG9uIHRoZSBsb3cgcG93ZXIgbW9kZSAobm9uLU9GRiB2cyBPRkYg
bW9kZXMpLAogICogICBjZi4gJ1Jlc3VtZSBwYXRoIGZvciB4eHggbW9kZScgY29tbWVudHMuCkBA
IC0xODEsOSArMTg0LDE1IEBAIEVOVFJZKG9tYXAzNHh4X2NwdV9zdXNwZW5kKQogCSAqICAgMyAt
IEJvdGggTDEgYW5kIEwyIGxvc3QKIAkgKi8KIAotCS8qIERpcmVjdGx5IGp1bXAgdG8gV0ZJIGlz
IHRoZSBjb250ZXh0IHNhdmUgaXMgbm90IHJlcXVpcmVkICovCi0JY21wCXIxLCAjMHgwCi0JYmVx
CW9tYXAzX2RvX3dmaQorCS8qCisJICogRm9yIE9GRiBtb2RlOiBzYXZlIGNvbnRleHQgYW5kIGp1
bXAgdG8gV0ZJIGluIFNEUkFNIChvbWFwM19kb193ZmkpCisJICogRm9yIG5vbi1PRkYgbW9kZXM6
IGp1bXAgdG8gdGhlIFdGSSBjb2RlIGluIFNSQU0gKG9tYXAzX2RvX3dmaV9zcmFtKQorCSAqLwor
CWxkcglyNCwgb21hcDNfZG9fd2ZpX3NyYW1fYWRkcgorCWxkcglyNSwgW3I0XQorCWNtcAlyMSwg
IzB4MAkJQCBJZiBubyBjb250ZXh0IHNhdmUgcmVxdWlyZWQsCisJYnhlcQlyNQkJCUAgIGp1bXAg
dG8gdGhlIFdGSSBjb2RlIGluIFNSQU0KKwogCiAJLyogT3RoZXJ3aXNlIGZhbGwgdGhyb3VnaCB0
byB0aGUgc2F2ZSBjb250ZXh0IGNvZGUgKi8KIHNhdmVfY29udGV4dF93Zmk6CkBAIC0yNjgsNyAr
Mjc3LDcgQEAgY2xlYW5fY2FjaGVzOgogCSAqIG1jcglwMTUsIDAsIHIxMSwgYzcsIGMxMSwgMQog
CSAqLwogCWNtcAlyMSwgIzB4MSAJCUAgQ2hlY2sgd2hldGhlciBMMiBpbnZhbCBpcyByZXF1aXJl
ZAotCWJlcQlvbWFwM19kb193ZmkKKwliZXEJZG9fV0ZJCiAKIGNsZWFuX2wyOgogCS8qCkBAIC0y
ODIsNyArMjkxLDQ0IEBAIGNsZWFuX2wyOgogCW1vdglsciwgcGMKIAlieAlyMQogCi1vbWFwM19k
b193Zmk6Citkb19XRkk6CisJbGRyCXI0LCBjbV9jbGtzdGN0cmxfY29yZQlAIHJlYWQgdGhlIENM
S1NUQ1RSTF9DT1JFCisJbGRyCXI1LCBbcjRdCQlAIHJlYWQgdGhlIGNvbnRlbnRzIG9mIENMS1NU
Q1RSTF9DT1JFCisJYW5kCXI1LCByNSwgIzB4MworCWNtcAlyNSwgIzB4MworCWJlcQlvbWFwM19k
b193ZmkJCUAgSnVtcHQgdG8gU1JBTSBmdW5jdGlvbgorCW1vdglyMSwgIzAKKwltY3IJcDE1LCAw
LCByMSwgYzcsIGMxMCwgNAorCW1jcglwMTUsIDAsIHIxLCBjNywgYzEwLCA1CisKKwl3ZmkJCQkJ
QCB3YWl0IGZvciBpbnRlcnJ1cHQKKworCWxkbWZkCXNwISwge3IwLXIxMiwgcGN9CUAgcmVzdG9y
ZSByZWdzIGFuZCByZXR1cm4KKworCisvKgorICogTG9jYWwgdmFyaWFibGVzCisgKi8KK29tYXAz
X2RvX3dmaV9zcmFtX2FkZHI6CisJLndvcmQgb21hcDNfZG9fd2ZpX3NyYW0KK2tlcm5lbF9mbHVz
aDoKKwkud29yZCB2N19mbHVzaF9kY2FjaGVfYWxsCisKKy8qID09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09CisgKiA9PSBXRkkgaW5zdHJ1Y3Rpb24gPT4gRW50ZXIgaWRsZSA9PQor
ICogPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KKyAqLworCisvKgorICogRG8g
V0ZJIGluc3RydWN0aW9uCisgKiBJbmNsdWRlcyB0aGUgcmVzdW1lIHBhdGggZm9yIG5vbi1PRkYg
bW9kZXMKKyAqCisgKiBUaGlzIGNvZGUgZ2V0cyBjb3BpZWQgdG8gaW50ZXJuYWwgU1JBTSBhbmQg
aXMgYWNjZXNzaWJsZQorICogZnJvbSBib3RoIFNEUkFNIGFuZCBTUkFNOgorICogLSBleGVjdXRl
ZCBmcm9tIFNSQU0gZm9yIG5vbi1vZmYgbW9kZXMgKG9tYXAzX2RvX3dmaV9zcmFtKSwKKyAqIC0g
ZXhlY3V0ZWQgZnJvbSBTRFJBTSBmb3IgT0ZGIG1vZGUgKG9tYXAzX2RvX3dmaSkuCisgKi8KK0VO
VFJZKG9tYXAzX2RvX3dmaSkKIAlsZHIJcjQsIHNkcmNfcG93ZXIJCUAgcmVhZCB0aGUgU0RSQ19Q
T1dFUiByZWdpc3RlcgogCWxkcglyNSwgW3I0XQkJQCByZWFkIHRoZSBjb250ZW50cyBvZiBTRFJD
X1BPV0VSCiAJb3JyCXI1LCByNSwgIzB4NDAJCUAgZW5hYmxlIHNlbGYgcmVmcmVzaCBvbiBpZGxl
IHJlcQpAQCAtMzAyLDcgKzM0OCw3IEBAIG9tYXAzX2RvX3dmaToKIAogLyoKICAqID09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0gKiA9PSBSZXN1bWUgcGF0aCBmb3Igbm9uLU9G
RiBtb2RlcyA9PQorICogPT0gUmVzdW1lIHBhdGggZm9yIE9GRi9SRVQgbW9kZXMgPT0KICAqID09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgKi8KIAlub3AKQEAgLTMxNSwxNSAr
MzYxLDExMyBAQCBvbWFwM19kb193Zmk6CiAJbm9wCiAJbm9wCiAJbm9wCi0JYmwgd2FpdF9zZHJj
X29rCisKKy8qCisgKiB3YWl0X3NkcmNfb2sgaW1wbGVtZW50cyB0aGUgZXJyYXR1bSBJRCBpNTgx
IFdBOgorICogIFNEUkMgc3RhdGUgcmVzdG9yZSBiZWZvcmUgYWNjZXNzaW5nIHRoZSBTRFJBTQor
ICoKKyAqIE9ubHkgdXNlZCBhdCByZXR1cm4gZnJvbSBub24tT0ZGIG1vZGUuIEZvciBPRkYKKyAq
IG1vZGUgdGhlIFJPTSBjb2RlIGNvbmZpZ3VyZXMgdGhlIFNEUkMgYW5kCisgKiB0aGUgRFBMTCBi
ZWZvcmUgY2FsbGluZyB0aGUgcmVzdG9yZSBjb2RlIGRpcmVjdGx5CisgKiBmcm9tIFNEUkFNLgor
ICovCisKKy8qIE1ha2Ugc3VyZSBTRFJDIGFjY2Vzc2VzIGFyZSBvayAqLword2FpdF9zZHJjX29r
OgorCisvKiBEUExMMyBtdXN0IGJlIGxvY2tlZCBiZWZvcmUgYWNjZXNzaW5nIHRoZSBTRFJDLiBN
YXliZSB0aGUgSFcgZW5zdXJlcyB0aGlzICovCisJbGRyCXI0LCBjbV9pZGxlc3RfY2tnZW4KK3dh
aXRfZHBsbDNfbG9jazoKKwlsZHIJcjUsIFtyNF0KKwl0c3QJcjUsICMxCisJYmVxCXdhaXRfZHBs
bDNfbG9jaworCisJbGRyCXI0LCBjbV9pZGxlc3QxX2NvcmUKK3dhaXRfc2RyY19yZWFkeToKKwls
ZHIJcjUsIFtyNF0KKwl0c3QJcjUsICMweDIKKwlibmUJd2FpdF9zZHJjX3JlYWR5CisJLyogYWxs
b3cgRExMIHBvd2VyZG93biB1cG9uIGh3IGlkbGUgcmVxICovCisJbGRyCXI0LCBzZHJjX3Bvd2Vy
CisJbGRyCXI1LCBbcjRdCisJYmljCXI1LCByNSwgIzB4NDAKKwlzdHIJcjUsIFtyNF0KKworaXNf
ZGxsX2luX2xvY2tfbW9kZToKKwkvKiBJcyBkbGwgaW4gbG9jayBtb2RlPyAqLworCWxkcglyNCwg
c2RyY19kbGxhX2N0cmwKKwlsZHIJcjUsIFtyNF0KKwl0c3QJcjUsICMweDQKKwlibmUJZXhpdF9u
b25vZmZfbW9kZXMJQCBSZXR1cm4gaWYgbG9ja2VkCisKKwkvKiB3YWl0IHRpbGwgZGxsIGxvY2tz
ICovCit3YWl0X2RsbF9sb2NrX3RpbWVkOgorCWxkcglyNCwgd2FpdF9kbGxfbG9ja19jb3VudGVy
CisJYWRkCXI0LCByNCwgIzEKKwlzdHIJcjQsIHdhaXRfZGxsX2xvY2tfY291bnRlcgorCWxkcgly
NCwgc2RyY19kbGxhX3N0YXR1cworCS8qIFdhaXQgMjB1UyBmb3IgbG9jayAqLworCW1vdglyNiwg
IzgKK3dhaXRfZGxsX2xvY2s6CisJc3VicwlyNiwgcjYsICMweDEKKwliZXEJa2lja19kbGwKKwls
ZHIJcjUsIFtyNF0KKwlhbmQJcjUsIHI1LCAjMHg0CisJY21wCXI1LCAjMHg0CisJYm5lCXdhaXRf
ZGxsX2xvY2sKKwliCWV4aXRfbm9ub2ZmX21vZGVzCUAgUmV0dXJuIHdoZW4gbG9ja2VkCisKKwkv
KiBkaXNhYmxlL3JlZW5hYmxlIERMTCBpZiBub3QgbG9ja2VkICovCitraWNrX2RsbDoKKwlsZHIJ
cjQsIHNkcmNfZGxsYV9jdHJsCisJbGRyCXI1LCBbcjRdCisJbW92CXI2LCByNQorCWJpYwlyNiwg
IygxPDwzKQkJQCBkaXNhYmxlIGRsbAorCXN0cglyNiwgW3I0XQorCWRzYgorCW9ycglyNiwgcjYs
ICMoMTw8MykJCUAgZW5hYmxlIGRsbAorCXN0cglyNiwgW3I0XQorCWRzYgorCWxkcglyNCwga2lj
a19jb3VudGVyCisJYWRkCXI0LCByNCwgIzEKKwlzdHIJcjQsIGtpY2tfY291bnRlcgorCWIJd2Fp
dF9kbGxfbG9ja190aW1lZAogCiAvKgogICogPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KLSAqID09IEV4aXQgcG9pbnQgZnJvbSBub24tT0ZGIG1vZGVzID09CisgKiA9PSBFeGl0
IHBvaW50IGZyb20gT0ZGL1JFVCBtb2RlcyA9PQogICogPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0KICAqLworZXhpdF9ub25vZmZfbW9kZXM6CiAJbGRtZmQJc3AhLCB7cjAtcjEy
LCBwY30JQCByZXN0b3JlIHJlZ3MgYW5kIHJldHVybgogCisvKgorICogTG9jYWwgdmFyaWFibGVz
CisgKi8KK3NkcmNfcG93ZXI6CisJLndvcmQJU0RSQ19QT1dFUl9WCitjbV9pZGxlc3QxX2NvcmU6
CisJLndvcmQJQ01fSURMRVNUMV9DT1JFX1YKK2NtX2Nsa3N0Y3RybF9jb3JlOgorCS53b3JkIENN
X0NMS1NUQ1RSTF9DT1JFX1YKK2NtX2lkbGVzdF9ja2dlbjoKKwkud29yZAlDTV9JRExFU1RfQ0tH
RU5fVgorc2RyY19kbGxhX3N0YXR1czoKKwkud29yZAlTRFJDX0RMTEFfU1RBVFVTX1YKK3NkcmNf
ZGxsYV9jdHJsOgorCS53b3JkCVNEUkNfRExMQV9DVFJMX1YKKwkvKgorCSAqIFdoZW4gZXhwb3J0
aW5nIHRvIHVzZXJzcGFjZSB3aGlsZSB0aGUgY291bnRlcnMgYXJlIGluIFNSQU0sCisJICogdGhl
c2UgMiB3b3JkcyBuZWVkIHRvIGJlIGF0IHRoZSBlbmQgdG8gZmFjaWxpdGF0ZSByZXRyaXZhbCEK
KwkgKi8KK2tpY2tfY291bnRlcjoKKwkud29yZAkwCit3YWl0X2RsbF9sb2NrX2NvdW50ZXI6CisJ
LndvcmQJMAorCitFTlRSWShvbWFwM19kb193Zmlfc3opCisJLndvcmQJLiAtIG9tYXAzX2RvX3dm
aQorCiAKIC8qCiAgKiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KQEAgLTMzOSw2ICs0
ODMsMTAgQEAgb21hcDNfZG9fd2ZpOgogICogIHJlc3RvcmVfZXMzOiBhcHBsaWVzIHRvIDM0eHgg
Pj0gRVMzLjAKICAqICByZXN0b3JlXzM2MzA6IGFwcGxpZXMgdG8gMzZ4eAogICogIHJlc3RvcmU6
IGNvbW1vbiBjb2RlIGZvciAzeHh4CisgKgorICogTm90ZTogd2hlbiBiYWNrIGZyb20gQ09SRSBh
bmQgTVBVIE9GRiBtb2RlIHdlIGFyZSBydW5uaW5nCisgKiAgZnJvbSBTRFJBTSwgd2l0aG91dCBN
TVUsIHdpdGhvdXQgdGhlIGNhY2hlcyBhbmQgcHJlZGljdGlvbi4KKyAqICBBbHNvIHRoZSBTUkFN
IGNvbnRlbnQgaGFzIGJlZW4gY2xlYXJlZC4KICAqLwogcmVzdG9yZV9lczM6CiAJbGRyCXI1LCBw
bV9wcmVwd3N0c3RfY29yZV9wCkBAIC0zNTcsNyArNTA1LDggQEAgY29weV90b19zcmFtOgogCWJu
ZQljb3B5X3RvX3NyYW0KIAlsZHIJcjEsIHNyYW1fYmFzZQogCWJseAlyMQotCWIJcmVzdG9yZQor
CisJYglyZXN0b3JlCQlAIEZhbGwgdGhyb3VnaCB0byBjb21tb24gY29kZQogCiByZXN0b3JlXzM2
MzA6CiAJbGRyCXIxLCBwbV9wcmVwd3N0c3RfY29yZV9wCkBAIC02MDAsMTIgKzc0OSw0MSBAQCB1
c2V0dGJyMDoKICAqLwogCWxkbWZkCXNwISwge3IwLXIxMiwgcGN9CUAgcmVzdG9yZSByZWdzIGFu
ZCByZXR1cm4KIAorLyoKKyAqIExvY2FsIHZhcmlhYmxlcworICovCitwbV9wcmVwd3N0c3RfY29y
ZV9wOgorCS53b3JkCVBNX1BSRVBXU1RTVF9DT1JFX1AKK3BtX3B3c3RjdHJsX21wdToKKwkud29y
ZAlQTV9QV1NUQ1RSTF9NUFVfUAorc2NyYXRjaHBhZF9iYXNlOgorCS53b3JkCVNDUkFUQ0hQQURf
QkFTRV9QCitzcmFtX2Jhc2U6CisJLndvcmQJU1JBTV9CQVNFX1AgKyAweDgwMDAKK3R0YnJiaXRf
bWFzazoKKwkud29yZAkweEZGRkZDMDAwCit0YWJsZV9pbmRleF9tYXNrOgorCS53b3JkCTB4RkZG
MDAwMDAKK3RhYmxlX2VudHJ5OgorCS53b3JkCTB4MDAwMDBDMDIKK2NhY2hlX3ByZWRfZGlzYWJs
ZV9tYXNrOgorCS53b3JkCTB4RkZGRkU3RkIKK2NvbnRyb2xfc3RhdDoKKwkud29yZAlDT05UUk9M
X1NUQVQKK2NvbnRyb2xfbWVtX3J0YToKKwkud29yZAlDT05UUk9MX01FTV9SVEFfQ1RSTAorbDJk
aXNfMzYzMDoKKwkud29yZAkwCisKIAogLyoKICAqIEludGVybmFsIGZ1bmN0aW9ucwogICovCiAK
LS8qIFRoaXMgZnVuY3Rpb24gaW1wbGVtZW50cyB0aGUgZXJyYXR1bSBJRCBpNDQzIFdBLCBhcHBs
aWVzIHRvIDM0eHggPj0gRVMzLjAgKi8KKy8qIFRoaXMgZnVuY3Rpb24gaW1wbGVtZW50cyB0aGUg
ZXJyYXR1bSBJRCBpNDQzIFdBLCBhcHBsaWVzIHRvIDM0eHggPj0gRVMzLjAKKyAqCisgKiBDb3Bp
ZWQgYW5kIHJ1biBmcm9tIFNSQU0gaW4gb3JkZXIgdG8gcmVjb25maWd1cmUgdGhlIFNEUkMgcGFy
YW1ldGVycy4KKyAqLwogCS50ZXh0CiBFTlRSWShlczNfc2RyY19maXgpCiAJbGRyCXI0LCBzZHJj
X3N5c2NmZwkJQCBnZXQgY29uZmlnIGFkZHIKQEAgLTYzNCw2ICs4MTIsOSBAQCBFTlRSWShlczNf
c2RyY19maXgpCiAJc3RyCXI1LCBbcjRdCQlAIGtpY2sgb2ZmIHJlZnJlc2hlcwogCWJ4CWxyCiAK
Ky8qCisgKiBMb2NhbCB2YXJpYWJsZXMKKyAqLwogc2RyY19zeXNjZmc6CiAJLndvcmQJU0RSQ19T
WVNDT05GSUdfUAogc2RyY19tcl8wOgpAQCAtNjUwLDExOSArODMxLDMgQEAgc2RyY19tYW51YWxf
MToKIAkud29yZAlTRFJDX01BTlVBTF8xX1AKIEVOVFJZKGVzM19zZHJjX2ZpeF9zeikKIAkud29y
ZAkuIC0gZXMzX3NkcmNfZml4Ci0KLS8qCi0gKiBUaGlzIGZ1bmN0aW9uIGltcGxlbWVudHMgdGhl
IGVycmF0dW0gSUQgaTU4MSBXQToKLSAqICBTRFJDIHN0YXRlIHJlc3RvcmUgYmVmb3JlIGFjY2Vz
c2luZyB0aGUgU0RSQU0KLSAqCi0gKiBPbmx5IHVzZWQgYXQgcmV0dXJuIGZyb20gbm9uLU9GRiBt
b2RlLiBGb3IgT0ZGCi0gKiBtb2RlIHRoZSBST00gY29kZSBjb25maWd1cmVzIHRoZSBTRFJDIGFu
ZAotICogdGhlIERQTEwgYmVmb3JlIGNhbGxpbmcgdGhlIHJlc3RvcmUgY29kZSBkaXJlY3RseQot
ICogZnJvbSBERFIuCi0gKi8KLQotLyogTWFrZSBzdXJlIFNEUkMgYWNjZXNzZXMgYXJlIG9rICov
Ci13YWl0X3NkcmNfb2s6Ci0KLS8qIERQTEwzIG11c3QgYmUgbG9ja2VkIGJlZm9yZSBhY2Nlc3Np
bmcgdGhlIFNEUkMuIE1heWJlIHRoZSBIVyBlbnN1cmVzIHRoaXMgKi8KLQlsZHIJcjQsIGNtX2lk
bGVzdF9ja2dlbgotd2FpdF9kcGxsM19sb2NrOgotCWxkcglyNSwgW3I0XQotCXRzdAlyNSwgIzEK
LQliZXEJd2FpdF9kcGxsM19sb2NrCi0KLQlsZHIJcjQsIGNtX2lkbGVzdDFfY29yZQotd2FpdF9z
ZHJjX3JlYWR5OgotCWxkcglyNSwgW3I0XQotCXRzdAlyNSwgIzB4MgotCWJuZQl3YWl0X3NkcmNf
cmVhZHkKLQkvKiBhbGxvdyBETEwgcG93ZXJkb3duIHVwb24gaHcgaWRsZSByZXEgKi8KLQlsZHIJ
cjQsIHNkcmNfcG93ZXIKLQlsZHIJcjUsIFtyNF0KLQliaWMJcjUsIHI1LCAjMHg0MAotCXN0cgly
NSwgW3I0XQotCi1pc19kbGxfaW5fbG9ja19tb2RlOgotCS8qIElzIGRsbCBpbiBsb2NrIG1vZGU/
ICovCi0JbGRyCXI0LCBzZHJjX2RsbGFfY3RybAotCWxkcglyNSwgW3I0XQotCXRzdAlyNSwgIzB4
NAotCWJ4bmUJbHIJCQlAIFJldHVybiBpZiBsb2NrZWQKLQkvKiB3YWl0IHRpbGwgZGxsIGxvY2tz
ICovCi13YWl0X2RsbF9sb2NrX3RpbWVkOgotCWxkcglyNCwgd2FpdF9kbGxfbG9ja19jb3VudGVy
Ci0JYWRkCXI0LCByNCwgIzEKLQlzdHIJcjQsIHdhaXRfZGxsX2xvY2tfY291bnRlcgotCWxkcgly
NCwgc2RyY19kbGxhX3N0YXR1cwotCS8qIFdhaXQgMjB1UyBmb3IgbG9jayAqLwotCW1vdglyNiwg
IzgKLXdhaXRfZGxsX2xvY2s6Ci0Jc3VicwlyNiwgcjYsICMweDEKLQliZXEJa2lja19kbGwKLQls
ZHIJcjUsIFtyNF0KLQlhbmQJcjUsIHI1LCAjMHg0Ci0JY21wCXI1LCAjMHg0Ci0JYm5lCXdhaXRf
ZGxsX2xvY2sKLQlieAlscgkJCUAgUmV0dXJuIHdoZW4gbG9ja2VkCi0KLQkvKiBkaXNhYmxlL3Jl
ZW5hYmxlIERMTCBpZiBub3QgbG9ja2VkICovCi1raWNrX2RsbDoKLQlsZHIJcjQsIHNkcmNfZGxs
YV9jdHJsCi0JbGRyCXI1LCBbcjRdCi0JbW92CXI2LCByNQotCWJpYwlyNiwgIygxPDwzKQkJQCBk
aXNhYmxlIGRsbAotCXN0cglyNiwgW3I0XQotCWRzYgotCW9ycglyNiwgcjYsICMoMTw8MykJCUAg
ZW5hYmxlIGRsbAotCXN0cglyNiwgW3I0XQotCWRzYgotCWxkcglyNCwga2lja19jb3VudGVyCi0J
YWRkCXI0LCByNCwgIzEKLQlzdHIJcjQsIGtpY2tfY291bnRlcgotCWIJd2FpdF9kbGxfbG9ja190
aW1lZAotCi1jbV9pZGxlc3QxX2NvcmU6Ci0JLndvcmQJQ01fSURMRVNUMV9DT1JFX1YKLWNtX2lk
bGVzdF9ja2dlbjoKLQkud29yZAlDTV9JRExFU1RfQ0tHRU5fVgotc2RyY19kbGxhX3N0YXR1czoK
LQkud29yZAlTRFJDX0RMTEFfU1RBVFVTX1YKLXNkcmNfZGxsYV9jdHJsOgotCS53b3JkCVNEUkNf
RExMQV9DVFJMX1YKLXBtX3ByZXB3c3RzdF9jb3JlX3A6Ci0JLndvcmQJUE1fUFJFUFdTVFNUX0NP
UkVfUAotcG1fcHdzdGN0cmxfbXB1OgotCS53b3JkCVBNX1BXU1RDVFJMX01QVV9QCi1zY3JhdGNo
cGFkX2Jhc2U6Ci0JLndvcmQJU0NSQVRDSFBBRF9CQVNFX1AKLXNyYW1fYmFzZToKLQkud29yZAlT
UkFNX0JBU0VfUCArIDB4ODAwMAotc2RyY19wb3dlcjoKLQkud29yZAlTRFJDX1BPV0VSX1YKLXR0
YnJiaXRfbWFzazoKLQkud29yZAkweEZGRkZDMDAwCi10YWJsZV9pbmRleF9tYXNrOgotCS53b3Jk
CTB4RkZGMDAwMDAKLXRhYmxlX2VudHJ5OgotCS53b3JkCTB4MDAwMDBDMDIKLWNhY2hlX3ByZWRf
ZGlzYWJsZV9tYXNrOgotCS53b3JkCTB4RkZGRkU3RkIKLWNvbnRyb2xfc3RhdDoKLQkud29yZAlD
T05UUk9MX1NUQVQKLWNvbnRyb2xfbWVtX3J0YToKLQkud29yZAlDT05UUk9MX01FTV9SVEFfQ1RS
TAota2VybmVsX2ZsdXNoOgotCS53b3JkCXY3X2ZsdXNoX2RjYWNoZV9hbGwKLWwyZGlzXzM2MzA6
Ci0JLndvcmQJMAotCS8qCi0JICogV2hlbiBleHBvcnRpbmcgdG8gdXNlcnNwYWNlIHdoaWxlIHRo
ZSBjb3VudGVycyBhcmUgaW4gU1JBTSwKLQkgKiB0aGVzZSAyIHdvcmRzIG5lZWQgdG8gYmUgYXQg
dGhlIGVuZCB0byBmYWNpbGl0YXRlIHJldHJpdmFsIQotCSAqLwota2lja19jb3VudGVyOgotCS53
b3JkCTAKLXdhaXRfZGxsX2xvY2tfY291bnRlcjoKLQkud29yZAkwCi0KLUVOVFJZKG9tYXAzNHh4
X2NwdV9zdXNwZW5kX3N6KQotCS53b3JkCS4gLSBvbWFwMzR4eF9jcHVfc3VzcGVuZAotLSAKMS42
LjAuNAoK
--000e0cd48340602e12049b735594--
