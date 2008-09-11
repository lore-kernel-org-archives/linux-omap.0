From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 06/29] per/neon and core handling in idle
Date: Thu, 11 Sep 2008 15:33:50 +0300
Message-ID: <1221136453-16697-6-git-send-email-khilman@deeprootsystems.com>
References: <87iqt2amoi.fsf@deeprootsystems.com>
 <1221136453-16697-1-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-2-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-3-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-4-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-5-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:48496 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754981AbYIKMeu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:34:50 -0400
In-Reply-To: <1221136453-16697-5-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This patches adds handling of PER/NEON and CORE domain in idle.
---
 arch/arm/mach-omap2/cpuidle34xx.c |   94 ++++++++++++++++++++++++++++++-------
 arch/arm/mach-omap2/cpuidle34xx.h |    6 ++-
 arch/arm/mach-omap2/pm34xx.c      |   38 ++++++++-------
 3 files changed, 101 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index d06146d..99ecd75 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -26,6 +26,8 @@
 #include <asm/arch/pm.h>
 #include <asm/arch/prcm.h>
 #include <asm/arch/powerdomain.h>
+#include <asm/arch/clockdomain.h>
+#include <asm/arch/gpio.h>
 #include "cpuidle34xx.h"
 
 #ifdef CONFIG_CPU_IDLE
@@ -35,6 +37,8 @@ struct omap3_processor_cx current_cx_state;
 
 static int omap3_idle_bm_check(void)
 {
+	if (!omap3_can_sleep())
+		return 1;
 	return 0;
 }
 
@@ -46,34 +50,82 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 {
 	struct omap3_processor_cx *cx = cpuidle_get_statedata(state);
 	struct timespec ts_preidle, ts_postidle, ts_idle;
-	struct powerdomain *mpu_pd;
+	struct powerdomain *mpu_pd, *core_pd, *per_pd, *neon_pd;
+	int per_pwrst, neon_pwrst;
 
 	current_cx_state = *cx;
 
-	/* Used to keep track of the total time in idle */
-	getnstimeofday(&ts_preidle);
-
-
 	if (cx->type == OMAP3_STATE_C0) {
 		/* Do nothing for C0, not even a wfi */
 		return 0;
 	}
 
+	/* Used to keep track of the total time in idle */
+	getnstimeofday(&ts_preidle);
+
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
+	core_pd = pwrdm_lookup("core_pwrdm");
+	per_pd = pwrdm_lookup("per_pwrdm");
+	neon_pd = pwrdm_lookup("neon_pwrdm");
+
+	/* Reset previous power state registers */
+	pwrdm_clear_all_prev_pwrst(mpu_pd);
+	pwrdm_clear_all_prev_pwrst(neon_pd);
+	pwrdm_clear_all_prev_pwrst(core_pd);
+	pwrdm_clear_all_prev_pwrst(per_pd);
+
+	if (omap_irq_pending())
+		return 0;
+
+	per_pwrst = pwrdm_read_pwrst(per_pd);
+	neon_pwrst = pwrdm_read_pwrst(neon_pd);
+
 	/* Program MPU to target state */
-	if (cx->mpu_state < PWRDM_POWER_ON)
+	if (cx->mpu_state < PWRDM_POWER_ON) {
+		if (neon_pwrst == PWRDM_POWER_ON)
+			pwrdm_set_next_pwrst(neon_pd, PWRDM_POWER_RET);
 		pwrdm_set_next_pwrst(mpu_pd, cx->mpu_state);
+	}
+
+	/* Program CORE and PER to target state */
+	if (cx->core_state < PWRDM_POWER_ON) {
+		if (per_pwrst == PWRDM_POWER_ON) {
+			omap2_gpio_prepare_for_retention();
+			per_gpio_clk_disable();
+			omap_serial_enable_clocks(0);
+		}
+		pwrdm_set_next_pwrst(core_pd, cx->core_state);
+	}
 
 	/* Execute ARM wfi */
 	omap_sram_idle();
 
-	/* Program MPU to ON */
-	if (cx->mpu_state < PWRDM_POWER_ON)
+	/* Program MPU/NEON to ON */
+	if (cx->mpu_state < PWRDM_POWER_ON) {
+		if (neon_pwrst == PWRDM_POWER_ON)
+			pwrdm_set_next_pwrst(neon_pd, PWRDM_POWER_ON);
 		pwrdm_set_next_pwrst(mpu_pd, PWRDM_POWER_ON);
+	}
+
+	if (cx->core_state < PWRDM_POWER_ON) {
+		if (per_pwrst == PWRDM_POWER_ON) {
+			omap_serial_enable_clocks(1);
+			per_gpio_clk_enable();
+			omap2_gpio_resume_after_retention();
+		}
+		pwrdm_set_next_pwrst(core_pd, PWRDM_POWER_ON);
+	}
+
+	pr_debug("MPU prev st:%x,NEON prev st:%x\n",
+			       pwrdm_read_prev_pwrst(mpu_pd),
+			       pwrdm_read_prev_pwrst(neon_pd));
+	pr_debug("PER prev st:%x,CORE prev st:%x\n",
+			       pwrdm_read_prev_pwrst(per_pd),
+			       pwrdm_read_prev_pwrst(core_pd));
 
 	getnstimeofday(&ts_postidle);
 	ts_idle = timespec_sub(ts_postidle, ts_preidle);
-	return timespec_to_ns(&ts_idle);
+	return (u32)timespec_to_ns(&ts_idle)/1000;
 }
 
 static int omap3_enter_idle_bm(struct cpuidle_device *dev,
@@ -130,7 +182,7 @@ void omap_init_power_states(void)
 	omap3_power_states[0].threshold = 0;
 	omap3_power_states[0].mpu_state = PWRDM_POWER_ON;
 	omap3_power_states[0].core_state = PWRDM_POWER_ON;
-	omap3_power_states[0].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[0].flags = CPUIDLE_FLAG_SHALLOW;
 
 	/* C1 . MPU WFI + Core active */
 	omap3_power_states[1].valid = 1;
@@ -140,7 +192,8 @@ void omap_init_power_states(void)
 	omap3_power_states[1].threshold = 30;
 	omap3_power_states[1].mpu_state = PWRDM_POWER_ON;
 	omap3_power_states[1].core_state = PWRDM_POWER_ON;
-	omap3_power_states[1].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[1].flags = CPUIDLE_FLAG_TIME_VALID |
+						CPUIDLE_FLAG_SHALLOW;
 
 	/* C2 . MPU CSWR + Core active */
 	omap3_power_states[2].valid = 1;
@@ -150,7 +203,8 @@ void omap_init_power_states(void)
 	omap3_power_states[2].threshold = 300;
 	omap3_power_states[2].mpu_state = PWRDM_POWER_RET;
 	omap3_power_states[2].core_state = PWRDM_POWER_ON;
-	omap3_power_states[2].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[2].flags = CPUIDLE_FLAG_TIME_VALID |
+						CPUIDLE_FLAG_BALANCED;
 
 	/* C3 . MPU OFF + Core active */
 	omap3_power_states[3].valid = 0;
@@ -159,18 +213,20 @@ void omap_init_power_states(void)
 	omap3_power_states[3].wakeup_latency = 1800;
 	omap3_power_states[3].threshold = 4000;
 	omap3_power_states[3].mpu_state = PWRDM_POWER_OFF;
-	omap3_power_states[3].core_state = PWRDM_POWER_RET;
-	omap3_power_states[3].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[3].core_state = PWRDM_POWER_ON;
+	omap3_power_states[3].flags = CPUIDLE_FLAG_TIME_VALID |
+			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;
 
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
@@ -180,7 +236,8 @@ void omap_init_power_states(void)
 	omap3_power_states[5].threshold = 15000;
 	omap3_power_states[5].mpu_state = PWRDM_POWER_OFF;
 	omap3_power_states[5].core_state = PWRDM_POWER_RET;
-	omap3_power_states[5].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[5].flags = CPUIDLE_FLAG_TIME_VALID |
+			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;
 
 	/* C6 . MPU OFF + Core OFF */
 	omap3_power_states[6].valid = 0;
@@ -190,7 +247,8 @@ void omap_init_power_states(void)
 	omap3_power_states[6].threshold = 300000;
 	omap3_power_states[6].mpu_state = PWRDM_POWER_OFF;
 	omap3_power_states[6].core_state = PWRDM_POWER_OFF;
-	omap3_power_states[6].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap3_power_states[6].flags = CPUIDLE_FLAG_TIME_VALID |
+			CPUIDLE_FLAG_DEEP | CPUIDLE_FLAG_CHECK_BM;
 }
 
 struct cpuidle_driver omap3_idle_driver = {
diff --git a/arch/arm/mach-omap2/cpuidle34xx.h b/arch/arm/mach-omap2/cpuidle34xx.h
index ed8dc9b..46ed51e 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.h
+++ b/arch/arm/mach-omap2/cpuidle34xx.h
@@ -33,11 +33,13 @@
 /* Currently, we support only upto C2 */
 #define MAX_SUPPORTED_STATES 3
 
+extern unsigned short clocks_off_while_idle;
 extern void omap_sram_idle(void);
-extern int omap3_irq_pending(void);
+extern int omap_irq_pending(void);
 extern void per_gpio_clk_enable(void);
 extern void per_gpio_clk_disable(void);
-
+extern void omap_serial_enable_clocks(int enable);
+extern int omap3_can_sleep();
 struct omap3_processor_cx {
 	u8 valid;
 	u8 type;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8feab92..0646595 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -61,7 +61,7 @@ static struct powerdomain *mpu_pwrdm;
 static struct clk *gpio_fcks[NUM_OF_PERGPIOS];
 
 /* Enable GPIO clocks from sleep routines if allowed */
-static void per_gpio_clk_enable(void)
+void per_gpio_clk_enable(void)
 {
 	int i;
 
@@ -72,7 +72,7 @@ static void per_gpio_clk_enable(void)
 }
 
 /* Disable GPIO clocks from sleep routines if allowed */
-static void per_gpio_clk_disable(void)
+void per_gpio_clk_disable(void)
 {
 	int i;
 
@@ -213,22 +213,8 @@ void omap_sram_idle(void)
 
 	pm_dbg_pre_suspend();
 
-	omap2_gpio_prepare_for_retention();
-
-	/* Disable GPIO clocks if allowed */
-	per_gpio_clk_disable();
-
-	/* Disable UART clocks if allowed */
-	omap_serial_enable_clocks(0);
-
 	_omap_sram_idle(NULL, save_state);
 
-	/* Enable UART clocks if allowed */
-	omap_serial_enable_clocks(1);
-
-	/* Enable GPIO clocks if allowed */
-	per_gpio_clk_enable();
-
 	omap2_gpio_resume_after_retention();
 
 	pm_dbg_post_suspend();
@@ -273,7 +259,7 @@ static int omap3_fclks_active(void)
 	return 0;
 }
 
-static int omap3_can_sleep(void)
+int omap3_can_sleep(void)
 {
 	if (!enable_dyn_sleep)
 		return 0;
@@ -361,8 +347,17 @@ static void omap3_pm_idle(void)
 	if (omap_irq_pending())
 		goto out;
 
+	omap2_gpio_prepare_for_retention();
+
+	omap_serial_enable_clocks(0);
+	per_gpio_clk_disable();
+
 	omap_sram_idle();
 
+	omap_serial_enable_clocks(1);
+	per_gpio_clk_enable();
+
+	omap2_gpio_resume_after_retention();
 out:
 	local_fiq_enable();
 	local_irq_enable();
@@ -395,8 +390,17 @@ static int omap3_pm_suspend(void)
 			goto restore;
 	}
 
+	omap2_gpio_prepare_for_retention();
+
+	omap_serial_enable_clocks(0);
+	per_gpio_clk_disable();
+
 	omap_sram_idle();
 
+	omap_serial_enable_clocks(1);
+	per_gpio_clk_enable();
+
+	omap2_gpio_resume_after_retention();
 restore:
 	/* Restore next_pwrsts */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
-- 
1.6.0

