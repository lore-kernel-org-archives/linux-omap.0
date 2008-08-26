From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 02/06] per/neon and core handling in idle - enables C4
Date: Tue, 26 Aug 2008 18:33:56 +0530 (IST)
Message-ID: <64981.192.168.10.89.1219755836.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46151 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752983AbYHZNED (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Aug 2008 09:04:03 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m7QD3vgZ008704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 08:04:02 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id m7QD3ti8002585
	for <linux-omap@vger.kernel.org>; Tue, 26 Aug 2008 08:03:56 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds handling of PER/NEON and CORE domain in idle.
Enables state C4(MPU RET + CORE RET).

Signed-off-by: Rajendra Nayak <rnayak@ti.com>

---
 arch/arm/mach-omap2/cpuidle34xx.c        |   68 +++++++++++++++--------
 arch/arm/mach-omap2/cpuidle34xx.h        |    2
 arch/arm/mach-omap2/pm34xx.c             |   90 ++++++++++++++++++++++++-------
 arch/arm/mach-omap2/serial.c             |   19 ++----
 arch/arm/plat-omap/include/mach/common.h |    2
 5 files changed, 129 insertions(+), 52 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.c	2008-08-26
17:22:27.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c	2008-08-26
17:22:52.000000000 +0530
@@ -26,6 +26,8 @@
 #include <mach/pm.h>
 #include <mach/prcm.h>
 #include <mach/powerdomain.h>
+#include <linux/sched.h>
+
 #include "cpuidle34xx.h"

 #ifdef CONFIG_CPU_IDLE
@@ -35,9 +37,12 @@ struct omap3_processor_cx current_cx_sta

 static int omap3_idle_bm_check(void)
 {
+	if (!omap3_can_sleep())
+		return 1;
 	return 0;
 }

+int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 /* omap3_enter_idle - Programs OMAP3 to enter the specified state.
  * returns the total time during which the system was idle.
  */
@@ -46,34 +51,47 @@ static int omap3_enter_idle(struct cpuid
 {
 	struct omap3_processor_cx *cx = cpuidle_get_statedata(state);
 	struct timespec ts_preidle, ts_postidle, ts_idle;
-	struct powerdomain *mpu_pd;
+	struct powerdomain *mpu_pd, *core_pd;;

 	current_cx_state = *cx;

-	/* Used to keep track of the total time in idle */
-	getnstimeofday(&ts_preidle);
-
-
 	if (cx->type == OMAP3_STATE_C0) {
 		/* Do nothing for C0, not even a wfi */
 		return 0;
 	}

+	local_irq_disable();
+	local_fiq_disable();
+
+	/* Used to keep track of the total time in idle */
+	getnstimeofday(&ts_preidle);
+
+	if (cx->type > OMAP3_STATE_C1)
+		sched_clock_idle_sleep_event(); /* about to enter deep idle */
+
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
-	/* Program MPU to target state */
-	if (cx->mpu_state < PWRDM_POWER_ON)
-		pwrdm_set_next_pwrst(mpu_pd, cx->mpu_state);
+	core_pd = pwrdm_lookup("core_pwrdm");
+
+	set_pwrdm_state(mpu_pd, cx->mpu_state);
+	set_pwrdm_state(core_pd, cx->core_state);
+
+	if (omap_irq_pending())
+		goto return_sleep_time;

 	/* Execute ARM wfi */
 	omap_sram_idle();

-	/* Program MPU to ON */
-	if (cx->mpu_state < PWRDM_POWER_ON)
-		pwrdm_set_next_pwrst(mpu_pd, PWRDM_POWER_ON);
-
+return_sleep_time:
 	getnstimeofday(&ts_postidle);
 	ts_idle = timespec_sub(ts_postidle, ts_preidle);
-	return timespec_to_ns(&ts_idle);
+
+	if (cx->type > OMAP3_STATE_C1)
+		sched_clock_idle_wakeup_event(timespec_to_ns(&ts_idle));
+
+	local_irq_enable();
+	local_fiq_enable();
+
+	return (u32)timespec_to_ns(&ts_idle)/1000;
 }

 static int omap3_enter_idle_bm(struct cpuidle_device *dev,
@@ -130,7 +148,7 @@ void omap_init_power_states(void)
 	omap3_power_states[0].threshold = 0;
 	omap3_power_states[0].mpu_state = PWRDM_POWER_ON;
 	omap3_power_states[0].core_state = PWRDM_POWER_ON;
-	omap3_power_states[0].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[0].flags = CPUIDLE_FLAG_SHALLOW;

 	/* C1 . MPU WFI + Core active */
 	omap3_power_states[1].valid = 1;
@@ -140,7 +158,8 @@ void omap_init_power_states(void)
 	omap3_power_states[1].threshold = 30;
 	omap3_power_states[1].mpu_state = PWRDM_POWER_ON;
 	omap3_power_states[1].core_state = PWRDM_POWER_ON;
-	omap3_power_states[1].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[1].flags = CPUIDLE_FLAG_TIME_VALID |
+						CPUIDLE_FLAG_SHALLOW;

 	/* C2 . MPU CSWR + Core active */
 	omap3_power_states[2].valid = 1;
@@ -150,7 +169,8 @@ void omap_init_power_states(void)
 	omap3_power_states[2].threshold = 300;
 	omap3_power_states[2].mpu_state = PWRDM_POWER_RET;
 	omap3_power_states[2].core_state = PWRDM_POWER_ON;
-	omap3_power_states[2].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[2].flags = CPUIDLE_FLAG_TIME_VALID |
+						CPUIDLE_FLAG_BALANCED;

 	/* C3 . MPU OFF + Core active */
 	omap3_power_states[3].valid = 0;
@@ -159,18 +179,20 @@ void omap_init_power_states(void)
 	omap3_power_states[3].wakeup_latency = 1800;
 	omap3_power_states[3].threshold = 4000;
 	omap3_power_states[3].mpu_state = PWRDM_POWER_OFF;
-	omap3_power_states[3].core_state = PWRDM_POWER_RET;
-	omap3_power_states[3].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[3].core_state = PWRDM_POWER_ON;
+	omap3_power_states[3].flags = CPUIDLE_FLAG_TIME_VALID |
+			CPUIDLE_FLAG_BALANCED;

 	/* C4 . MPU CSWR + Core CSWR*/
-	omap3_power_states[4].valid = 0;
+	omap3_power_states[4].valid = 1;
 	omap3_power_states[4].type = OMAP3_STATE_C4;
 	omap3_power_states[4].sleep_latency = 2500;
 	omap3_power_states[4].wakeup_latency = 7500;
 	omap3_power_states[4].threshold = 12000;
 	omap3_power_states[4].mpu_state = PWRDM_POWER_RET;
 	omap3_power_states[4].core_state = PWRDM_POWER_RET;
-	omap3_power_states[4].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[4].flags = CPUIDLE_FLAG_TIME_VALID |
+			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;

 	/* C5 . MPU OFF + Core CSWR */
 	omap3_power_states[5].valid = 0;
@@ -180,7 +202,8 @@ void omap_init_power_states(void)
 	omap3_power_states[5].threshold = 15000;
 	omap3_power_states[5].mpu_state = PWRDM_POWER_OFF;
 	omap3_power_states[5].core_state = PWRDM_POWER_RET;
-	omap3_power_states[5].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[5].flags = CPUIDLE_FLAG_TIME_VALID |
+			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;

 	/* C6 . MPU OFF + Core OFF */
 	omap3_power_states[6].valid = 0;
@@ -190,7 +213,8 @@ void omap_init_power_states(void)
 	omap3_power_states[6].threshold = 300000;
 	omap3_power_states[6].mpu_state = PWRDM_POWER_OFF;
 	omap3_power_states[6].core_state = PWRDM_POWER_OFF;
-	omap3_power_states[6].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[6].flags = CPUIDLE_FLAG_TIME_VALID |
+			CPUIDLE_FLAG_DEEP | CPUIDLE_FLAG_CHECK_BM;
 }

 struct cpuidle_driver omap3_idle_driver = {
Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.h	2008-08-26
17:22:27.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.h	2008-08-26
17:22:52.000000000 +0530
@@ -34,6 +34,8 @@
 #define MAX_SUPPORTED_STATES 3

 extern void omap_sram_idle(void);
+extern int omap_irq_pending(void);
+extern int omap3_can_sleep();

 struct omap3_processor_cx {
 	u8 valid;
Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-08-26
17:22:27.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-08-26 17:23:13.000000000
+0530
@@ -52,7 +52,10 @@ static void (*_omap_sram_idle)(u32 *addr

 static void (*saved_idle)(void);

-static struct powerdomain *mpu_pwrdm;
+static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
+static struct powerdomain *core_pwrdm, *per_pwrdm;
+
+int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);

 /* XXX This is for gpio fclk hack. Will be removed as gpio driver
  * handles fcks correctly */
@@ -184,11 +187,20 @@ void omap_sram_idle(void)
 	/* save_state = 1 => Only L1 and logic lost */
 	/* save_state = 2 => Only L2 lost */
 	/* save_state = 3 => L1, L2 and logic lost */
-	int save_state = 0, mpu_next_state;
+	int save_state = 0;
+	int mpu_next_state = PWRDM_POWER_ON;
+	int per_next_state = PWRDM_POWER_ON;
+	int core_next_state = PWRDM_POWER_ON;
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
@@ -202,24 +214,50 @@ void omap_sram_idle(void)
 		return;
 	}

-	omap2_gpio_prepare_for_retention();
-	if (clocks_off_while_idle) {
-		omap_serial_enable_clocks(0);
-		/* XXX This is for gpio fclk hack. Will be removed as
-		 * gpio driver * handles fcks correctly */
-		per_gpio_clk_disable();
+	/* NEON control */
+	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
+	      set_pwrdm_state(neon_pwrdm, mpu_next_state);
+
+	/* CORE & PER */
+	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
+	if (core_next_state < PWRDM_POWER_ON) {
+		omap2_gpio_prepare_for_retention();
+		/* PER changes only with core */
+		per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
+		if (per_next_state < PWRDM_POWER_ON) {
+			if (clocks_off_while_idle) {
+				per_gpio_clk_disable();
+				omap_serial_enable_clocks(0, 2);
+			}
+		}
+		if (clocks_off_while_idle) {
+			omap_serial_enable_clocks(0, 0);
+			omap_serial_enable_clocks(0, 1);
+		}
+		/* Enable IO-PAD wakeup */
+		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 	}

 	_omap_sram_idle(NULL, save_state);

-	if (clocks_off_while_idle) {
-		omap_serial_enable_clocks(1);
-		/* XXX This is for gpio fclk hack. Will be removed as
-		 * gpio driver * handles fcks correctly */
-		per_gpio_clk_enable();
+	if (core_next_state < PWRDM_POWER_ON) {
+		/* Disable IO-PAD wakeup */
+		prm_clear_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
+		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
+		if (clocks_off_while_idle) {
+			omap_serial_enable_clocks(1, 0);
+			omap_serial_enable_clocks(1, 1);
+		}
+		if (per_next_state < PWRDM_POWER_ON) {
+			if (clocks_off_while_idle) {
+				per_gpio_clk_enable();
+				/* This would be actually more effective */
+				omap_serial_enable_clocks(1, 2);
+			}
+			per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
+		}
+		omap2_gpio_resume_after_retention();
 	}
-
-	omap2_gpio_resume_after_retention();
 }

 /*
@@ -263,7 +301,7 @@ static int omap3_fclks_active(void)
 	return 0;
 }

-static int omap3_can_sleep(void)
+int omap3_can_sleep(void)
 {
 	if (!enable_dyn_sleep)
 		return 0;
@@ -295,7 +333,7 @@ static int _clkdm_allow_idle(struct powe
 /* This sets pwrdm state (other than mpu & core. Currently only ON &
  * RET are supported. Function is assuming that clkdm doesn't have
  * hw_sup mode enabled. */
-static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
+int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 {
 	u32 cur_state;
 	int ret = 0;
@@ -708,7 +746,11 @@ static int __init pwrdms_setup(struct po
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_RET;
+	if (!strcmp(pwrst->pwrdm->name, "core_pwrdm") ||
+			!strcmp(pwrst->pwrdm->name, "mpu_pwrdm"))
+		pwrst->next_state = PWRDM_POWER_ON;
+	else
+		pwrst->next_state = PWRDM_POWER_OFF;
 	list_add(&pwrst->node, &pwrst_list);

 	if (pwrdm_has_hdwr_sar(pwrdm))
@@ -750,6 +792,10 @@ int __init omap3_pm_init(void)
 		goto err2;
 	}

+	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
+	per_pwrdm = pwrdm_lookup("per_pwrdm");
+	core_pwrdm = pwrdm_lookup("core_pwrdm");
+
 	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
 					omap34xx_cpu_suspend_sz);

@@ -765,6 +811,14 @@ int __init omap3_pm_init(void)
 		sprintf(clk_name, "gpio%d_fck", i + 1);
 		gpio_fcks[i-1] = clk_get(NULL, clk_name);
 	}
+	/*
+	 * REVISIT: This wkdep is only necessary when GPIO2-6 are enabled for
+	 * IO-pad wakeup.  Otherwise it will unnecessarily waste power
+	 * waking up PER with every CORE wakeup - see
+	 * http://marc.info/?l=linux-omap&m=121852150710062&w=2
+	*/
+	pwrdm_add_wkdep(neon_pwrdm, mpu_pwrdm);
+	pwrdm_add_wkdep(per_pwrdm, core_pwrdm);

 err1:
 	return ret;
Index: linux-omap-2.6/arch/arm/mach-omap2/serial.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/serial.c	2008-08-26
17:22:24.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/serial.c	2008-08-26 17:22:52.000000000
+0530
@@ -147,18 +147,15 @@ static void omap_serial_kick(void)
 		NSEC_PER_SEC);
 }

-void omap_serial_enable_clocks(int enable)
+void omap_serial_enable_clocks(int enable, int unum)
 {
-	int i;
-	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
-		if (uart_ick[i] && uart_fck[i]) {
-			if (enable) {
-				clk_enable(uart_ick[i]);
-				clk_enable(uart_fck[i]);
-			} else {
-				clk_disable(uart_ick[i]);
-				clk_disable(uart_fck[i]);
-			}
+	if (uart_ick[unum] && uart_fck[unum]) {
+		if (enable) {
+			clk_enable(uart_ick[unum]);
+			clk_enable(uart_fck[unum]);
+		} else {
+			clk_disable(uart_ick[unum]);
+			clk_disable(uart_fck[unum]);
 		}
 	}
 }
Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/common.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/common.h	2008-08-26
17:22:24.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/common.h	2008-08-26
17:22:52.000000000 +0530
@@ -34,7 +34,7 @@ struct sys_timer;
 extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
 extern void omap_serial_init(void);
-extern void omap_serial_enable_clocks(int enable);
+extern void omap_serial_enable_clocks(int enable, int unum);
 extern int omap_serial_can_sleep(void);
 extern void omap_serial_fclk_mask(u32 *f1, u32 *f2);
 void omap_serial_check_wakeup(void);


