From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [RFC] OMAP3: CPUIDLE & PM: Modifications and fixes
Date: Tue,  8 Jul 2008 14:50:38 +0300
Message-ID: <1215517838-7001-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17649 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806AbYGHLwh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2008 07:52:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, rnayak@ti.com

With this patch cpuidle boot problem with cpuidle doesn't exist. Also hang on wake-up seems to
disappear (haven't seen this far).

Main points in this patch are:
1. Add wkdep between neon and mpu
2. Add wkdep between per and core
3. Deny hwsup mode before writing next pwrst state
3. Make sure that order in idle loop is such that clocks are _really_
   enabled before accessing registers (serial & gpio).

This patch is meant to be applied on top of "OMAP3 CPUidle patches"
patch set and "OMAP3 CPUidle patches - fixes" patch sent by Rajendra
Nayak.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   82 ++--------------------------
 arch/arm/mach-omap2/pm34xx.c      |  109 +++++++++++++++++++++++++++++++++++--
 2 files changed, 108 insertions(+), 83 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 6440515..c14152f 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -404,8 +404,6 @@ void omap3_save_core_ctx(void)
 	omap_save_gpmc_ctx();
 	/* Save the system control module context, padconf already save above*/
 	omap_save_control_ctx();
-	omap_save_uart_ctx(0);
-	omap_save_uart_ctx(1);
 }
 
 void omap3_restore_core_ctx(void)
@@ -416,11 +414,10 @@ void omap3_restore_core_ctx(void)
 	omap_restore_gpmc_ctx();
 	/* Restore the interrupt controller context */
 	omap_restore_intc_ctx();
-	omap_restore_uart_ctx(0);
-	omap_restore_uart_ctx(1);
 	padconf_saved = 0;
 }
 
+int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 /* omap3_enter_idle - Programs OMAP3 to enter the specified state.
  * returns the total time during which the system was idle.
  */
@@ -429,8 +426,7 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 {
 	struct omap3_processor_cx *cx = cpuidle_get_statedata(state);
 	struct timespec ts_preidle, ts_postidle, ts_idle;
-	struct powerdomain *mpu_pd, *core_pd, *per_pd, *neon_pd;
-	int per_pwrst, neon_pwrst;
+	struct powerdomain *mpu_pd, *core_pd;
 
 	current_cx_state = *cx;
 
@@ -450,49 +446,9 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
 	core_pd = pwrdm_lookup("core_pwrdm");
-	per_pd = pwrdm_lookup("per_pwrdm");
-	neon_pd = pwrdm_lookup("neon_pwrdm");
-
-	/* Reset previous power state registers */
-	pwrdm_clear_all_prev_pwrst(mpu_pd);
-	pwrdm_clear_all_prev_pwrst(neon_pd);
-	pwrdm_clear_all_prev_pwrst(core_pd);
-	pwrdm_clear_all_prev_pwrst(per_pd);
-
-	per_pwrst = pwrdm_read_pwrst(per_pd);
-	neon_pwrst = pwrdm_read_pwrst(neon_pd);
-
-	/* Do this before any changes to PRCM registers */
-	if (cx->core_state == PWRDM_POWER_OFF)
-		omap3_save_prcm_ctx();
-
-	/* Program MPU to target state */
-	if (cx->mpu_state < PWRDM_POWER_ON) {
-		pwrdm_set_next_pwrst(neon_pd, cx->mpu_state);
-		pwrdm_set_next_pwrst(mpu_pd, cx->mpu_state);
-	}
 
-	/* Program CORE and PER to target state */
-	if (cx->core_state < PWRDM_POWER_ON) {
-		omap2_gpio_prepare_for_retention();
-		if (clocks_off_while_idle) {
-			omap3_save_per_ctx();
-			per_gpio_clk_disable();
-			omap_save_uart_ctx(2);
-			omap_serial_enable_clocks(0, 2);
-		}
-		if (cx->core_state == PWRDM_POWER_OFF)
-			omap3_save_core_ctx();
-		/* Disable UART1/UART2 clocks here. Done using direct register
-		* writes as using clock f/w calls results in a hang in prcm_
-		* interrupt_handler trying to clear WKST for CORE
-		*/
-		cm_clear_mod_reg_bits(0x6000, CORE_MOD, CM_ICLKEN1);
-		cm_clear_mod_reg_bits(0x6000, CORE_MOD, CM_FCLKEN1);
-		pwrdm_set_next_pwrst(core_pd, cx->core_state);
-	}
-
-	*(scratchpad_restore_addr) = restore_pointer_address;
+        set_pwrdm_state(mpu_pd, cx->mpu_state);
+	set_pwrdm_state(core_pd, cx->core_state);
 
 	if (omap_irq_pending())
 		goto return_sleep_time;
@@ -500,34 +456,6 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	/* Execute ARM wfi */
 	omap_sram_idle();
 
-	*(scratchpad_restore_addr) = 0x0;
-
-	if (cx->core_state < PWRDM_POWER_ON) {
-		cm_set_mod_reg_bits(0x6000, CORE_MOD, CM_ICLKEN1);
-		cm_set_mod_reg_bits(0x6000, CORE_MOD, CM_FCLKEN1);
-		if ((cx->core_state == PWRDM_POWER_OFF)
-		&& (pwrdm_read_prev_pwrst(core_pd) == PWRDM_POWER_OFF)) {
-			omap3_restore_core_ctx();
-			omap3_restore_prcm_ctx();
-			omap3_restore_sram_ctx();
-		}
-		pwrdm_set_next_pwrst(core_pd, PWRDM_POWER_ON);
-		if (clocks_off_while_idle) {
-			omap_serial_enable_clocks(1, 2);
-			omap_restore_uart_ctx(2);
-			per_gpio_clk_enable();
-			omap3_restore_per_ctx();
-		}
-		omap2_gpio_resume_after_retention();
-	}
-
-	pr_debug("MPU prev st:%x,NEON prev st:%x\n",
-				pwrdm_read_prev_pwrst(mpu_pd),
-				pwrdm_read_prev_pwrst(neon_pd));
-	pr_debug("PER prev st:%x,CORE prev st:%x\n",
-				pwrdm_read_prev_pwrst(per_pd),
-				pwrdm_read_prev_pwrst(core_pd));
-
 return_sleep_time:
 	getnstimeofday(&ts_postidle);
 	ts_idle = timespec_sub(ts_postidle, ts_preidle);
@@ -617,7 +545,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID |
-						CPUIDLE_FLAG_BALANCED;
+                                               CPUIDLE_FLAG_BALANCED;
 
 	/* C3 . MPU OFF + Core active */
 	omap3_power_states[OMAP3_STATE_C3].valid = 1;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index dc7bb90..1f9c58a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -65,6 +65,20 @@ void (*_omap_sram_idle)(u32 *addr, int save_state, int disable_clocks);
 static void (*saved_idle)(void);
 
 static struct powerdomain *mpu_pwrdm;
+static struct powerdomain *neon_pwrdm, * per_pwrdm;
+static struct powerdomain *core_pwrdm;
+
+void omap3_save_per_ctx(void);
+void omap3_restore_per_ctx(void);
+void omap3_save_core_ctx(void);
+void omap3_restore_core_ctx(void);
+void omap3_save_sram_ctx(void);
+void omap3_restore_sram_ctx(void);
+void omap3_save_prcm_ctx(void);
+void omap3_restore_prcm_ctx(void);
+void omap_save_uart_ctx(int unum);
+void omap_restore_uart_ctx(int unum);
+int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 
 /* XXX This is for gpio fclk hack. Will be removed as gpio driver
  * handles fcks correctly */
@@ -224,11 +238,19 @@ void omap_sram_idle(void)
 	/* save_state = 1 => Only L1 and logic lost */
 	/* save_state = 2 => Only L2 lost */
 	/* save_state = 3 => L1, L2 and logic lost */
-	int save_state = 0, mpu_next_state;
+	int save_state = 0;
+	int mpu_next_state = PWRDM_POWER_ON, core_next_state = PWRDM_POWER_ON,
+		per_next_state = PWRDM_POWER_ON;
+	int mpu_prev_state, core_prev_state, per_prev_state;
 
 	if (!_omap_sram_idle)
 		return;
 
+	pwrdm_clear_all_prev_pwrst(mpu_pwrdm);
+	pwrdm_clear_all_prev_pwrst(neon_pwrdm);
+	pwrdm_clear_all_prev_pwrst(core_pwrdm);
+	pwrdm_clear_all_prev_pwrst(per_pwrdm);
+
 	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
 	switch (mpu_next_state) {
 	case PWRDM_POWER_ON:
@@ -245,10 +267,79 @@ void omap_sram_idle(void)
 		return;
 	}
 
-	_omap_sram_idle(context_mem, save_state, clocks_off_while_idle);
-	/* Restore table entry modified during MMU restoration */
+	/* NEON control */
+	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
+		set_pwrdm_state(neon_pwrdm, mpu_next_state);
+
+	/* CORE & PER */
+	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
+	if (core_next_state < PWRDM_POWER_ON) {
+		omap2_gpio_prepare_for_retention();
+		/* PER changes only with core */
+		per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
+		if (per_next_state < PWRDM_POWER_ON) {
+			if (per_next_state == PWRDM_POWER_OFF) {
+				omap3_save_per_ctx();
+				omap_save_uart_ctx(2);
+			}
+			if (clocks_off_while_idle) {
+				per_gpio_clk_disable();
+				omap_serial_enable_clocks(0, 2);
+			}
+		}
+		if (core_next_state == PWRDM_POWER_OFF) {
+			omap3_save_core_ctx();
+			omap3_save_prcm_ctx();
+			omap_save_uart_ctx(0);
+			omap_save_uart_ctx(1);
+		}
+		if (clocks_off_while_idle) {
+			omap_serial_enable_clocks(0, 0);
+			omap_serial_enable_clocks(0, 1);
+		}
+		if (core_next_state == PWRDM_POWER_OFF)
+			omap3_save_prcm_ctx();
+	}
+
+	*(scratchpad_restore_addr) = restore_pointer_address;
+
+	_omap_sram_idle(context_mem, save_state, 1);
+
+	*(scratchpad_restore_addr) = 0x0;
+
 	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == 0x0)
 		restore_table_entry();
+	
+	if (core_next_state < PWRDM_POWER_ON) {
+		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
+		if (core_prev_state == PWRDM_POWER_OFF)
+			omap3_restore_prcm_ctx();
+		if (clocks_off_while_idle) {
+			omap_serial_enable_clocks(1, 0);
+			omap_serial_enable_clocks(1, 1);
+		}
+		if (core_prev_state == PWRDM_POWER_OFF) {
+			omap3_restore_core_ctx();
+			omap3_restore_sram_ctx();
+			omap_restore_uart_ctx(0);
+			omap_restore_uart_ctx(1);
+		}
+		if (per_next_state < PWRDM_POWER_ON) {
+			if (clocks_off_while_idle) {
+				per_gpio_clk_enable();
+				/* This would be actually more effective */
+				omap_serial_enable_clocks(1, 2);
+			}
+			per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
+			if (per_prev_state == PWRDM_POWER_OFF) {
+				omap3_restore_per_ctx();
+				/* This would be actually more effective */
+				omap_restore_uart_ctx(2);
+			}
+
+		}
+		omap2_gpio_resume_after_retention();
+	}
 }
 
 static int omap3_fclks_active(void)
@@ -318,7 +409,7 @@ static int _clkdm_allow_idle(struct powerdomain *pwrdm,
 /* This sets pwrdm state (other than mpu & core. Currently only ON &
  * RET are supported. Function is assuming that clkdm doesn't have
  * hw_sup mode enabled. */
-static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
+int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 {
 	u32 cur_state;
 	int ret = 0;
@@ -657,8 +748,8 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	if (!strcmp(pwrst->pwrdm->name, "core_pwrdm"))
-		pwrst->next_state = PWRDM_POWER_RET;
+	if (!strcmp(pwrst->pwrdm->name, "core_pwrdm") || !strcmp(pwrst->pwrdm->name, "mpu_pwrdm") || !strcmp(pwrst->pwrdm->name, "mpu_pwrdm"))
+		pwrst->next_state = PWRDM_POWER_ON;
 	else
 		pwrst->next_state = PWRDM_POWER_OFF;
 	list_add(&pwrst->node, &pwrst_list);
@@ -708,6 +799,9 @@ int __init omap3_pm_init(void)
 		printk(KERN_ERR "Failed to get mpu_pwrdm\n");
 		goto err2;
 	}
+	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
+	per_pwrdm = pwrdm_lookup("per_pwrdm");
+	core_pwrdm = pwrdm_lookup("core_pwrdm");
 
 	omap_push_sram_idle();
 	suspend_set_ops(&omap_pm_ops);
@@ -723,6 +817,9 @@ int __init omap3_pm_init(void)
 		gpio_fcks[i-1] = clk_get(NULL, clk_name);
 	}
 
+	pwrdm_add_wkdep(neon_pwrdm, mpu_pwrdm);
+	pwrdm_add_wkdep(per_pwrdm, core_pwrdm);
+
 err1:
 	return ret;
 err2:
-- 
1.5.5

