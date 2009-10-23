From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 02/10] OMAP3: PM: CPUidle: support retention and off-mode C-states
Date: Fri, 23 Oct 2009 09:59:00 -0700
Message-ID: <1256317148-25506-3-git-send-email-khilman@deeprootsystems.com>
References: <1256317148-25506-1-git-send-email-khilman@deeprootsystems.com>
 <1256317148-25506-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:11746 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbZJWQ7P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Oct 2009 12:59:15 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1391355qwb.37
        for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 09:59:20 -0700 (PDT)
In-Reply-To: <1256317148-25506-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This patch adds support and enables state C4(MPU RET + CORE RET)
and MPU OFF states (C3 and C5.)

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   28 ++++++++++++++++------------
 arch/arm/mach-omap2/pm.h          |    2 ++
 arch/arm/mach-omap2/pm34xx.c      |    6 ++----
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 858b216..0bf1bc3 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -26,6 +26,8 @@
 
 #include <plat/prcm.h>
 #include <plat/powerdomain.h>
+#include <plat/irqs.h>
+#include <plat/control.h>
 
 #ifdef CONFIG_CPU_IDLE
 
@@ -50,10 +52,12 @@ struct omap3_processor_cx {
 
 struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
 struct omap3_processor_cx current_cx_state;
-struct powerdomain *mpu_pd;
+struct powerdomain *mpu_pd, *core_pd;
 
 static int omap3_idle_bm_check(void)
 {
+	if (!omap3_can_sleep())
+		return 1;
 	return 0;
 }
 
@@ -79,24 +83,23 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	local_irq_disable();
 	local_fiq_disable();
 
-	/* Program MPU to target state */
-	if (cx->mpu_state < PWRDM_POWER_ON)
-		pwrdm_set_next_pwrst(mpu_pd, cx->mpu_state);
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
 
 	local_irq_enable();
 	local_fiq_enable();
 
-	return timespec_to_ns(&ts_idle);
+	return (u32)timespec_to_ns(&ts_idle)/1000;
 }
 
 /**
@@ -153,7 +156,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID;
 
 	/* C3 . MPU OFF + Core active */
-	omap3_power_states[OMAP3_STATE_C3].valid = 0;
+	omap3_power_states[OMAP3_STATE_C3].valid = 1;
 	omap3_power_states[OMAP3_STATE_C3].type = OMAP3_STATE_C3;
 	omap3_power_states[OMAP3_STATE_C3].sleep_latency = 1500;
 	omap3_power_states[OMAP3_STATE_C3].wakeup_latency = 1800;
@@ -163,7 +166,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C3].flags = CPUIDLE_FLAG_TIME_VALID;
 
 	/* C4 . MPU CSWR + Core CSWR*/
-	omap3_power_states[OMAP3_STATE_C4].valid = 0;
+	omap3_power_states[OMAP3_STATE_C4].valid = 1;
 	omap3_power_states[OMAP3_STATE_C4].type = OMAP3_STATE_C4;
 	omap3_power_states[OMAP3_STATE_C4].sleep_latency = 2500;
 	omap3_power_states[OMAP3_STATE_C4].wakeup_latency = 7500;
@@ -174,7 +177,7 @@ void omap_init_power_states(void)
 				CPUIDLE_FLAG_CHECK_BM;
 
 	/* C5 . MPU OFF + Core CSWR */
-	omap3_power_states[OMAP3_STATE_C5].valid = 0;
+	omap3_power_states[OMAP3_STATE_C5].valid = 1;
 	omap3_power_states[OMAP3_STATE_C5].type = OMAP3_STATE_C5;
 	omap3_power_states[OMAP3_STATE_C5].sleep_latency = 3000;
 	omap3_power_states[OMAP3_STATE_C5].wakeup_latency = 8500;
@@ -215,6 +218,7 @@ int omap3_idle_init(void)
 	struct cpuidle_device *dev;
 
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
+	core_pd = pwrdm_lookup("core_pwrdm");
 
 	omap_init_power_states();
 	cpuidle_register_driver(&omap3_idle_driver);
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 2edf1ba..379e350 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -19,6 +19,8 @@ extern u32 sleep_while_idle;
 extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
 extern void omap_sram_idle(void);
+extern int omap3_can_sleep(void);
+extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 3e3de6c..67412b8 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -76,8 +76,6 @@ static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
 static struct powerdomain *cam_pwrdm;
 
-static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
-
 static inline void omap3_per_save_context(void)
 {
 	omap_gpio_save_context();
@@ -503,7 +501,7 @@ static int omap3_fclks_active(void)
 	return 0;
 }
 
-static int omap3_can_sleep(void)
+int omap3_can_sleep(void)
 {
 	if (!sleep_while_idle)
 		return 0;
@@ -517,7 +515,7 @@ static int omap3_can_sleep(void)
 /* This sets pwrdm state (other than mpu & core. Currently only ON &
  * RET are supported. Function is assuming that clkdm doesn't have
  * hw_sup mode enabled. */
-static int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
+int set_pwrdm_state(struct powerdomain *pwrdm, u32 state)
 {
 	u32 cur_state;
 	int sleep_switch = 0;
-- 
1.6.4.3

