From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 02/05] OMAP3: Enables state C4
Date: Wed, 8 Oct 2008 17:31:22 +0530
Message-ID: <001801c9293d$95236b00$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54006 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753740AbYJHMBb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Oct 2008 08:01:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: 'Kevin Hilman' <khilman@deeprootsystems.com>

This patch adds support and enables state C4(MPU RET + CORE RET).

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c    |   24 ++++++++++++++----------
 arch/arm/mach-omap2/pm34xx.c         |    2 +-
 arch/arm/plat-omap/include/mach/pm.h |    1 +
 3 files changed, 16 insertions(+), 11 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.c	2008-10-08 16:50:02.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c	2008-10-08 16:51:45.000000000 +0530
@@ -51,10 +51,14 @@ struct omap3_processor_cx {
 
 struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
 struct omap3_processor_cx current_cx_state;
-struct powerdomain *mpu_pd;
+struct powerdomain *mpu_pd, *core_pd;
+
+int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 
 static int omap3_idle_bm_check(void)
 {
+	if (!omap3_can_sleep())
+		return 1;
 	return 0;
 }
 
@@ -80,24 +84,23 @@ static int omap3_enter_idle(struct cpuid
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
+return_sleep_time :
 	getnstimeofday(&ts_postidle);
 	ts_idle = timespec_sub(ts_postidle, ts_preidle);
 
 	local_irq_enable();
 	local_fiq_enable();
 
-	return timespec_to_ns(&ts_idle);
+	return (u32)timespec_to_ns(&ts_idle)/1000;
 }
 
 /**
@@ -186,7 +189,7 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C3].flags = CPUIDLE_FLAG_TIME_VALID;
 
 	/* C4 . MPU CSWR + Core CSWR*/
-	omap3_power_states[OMAP3_STATE_C4].valid = 0;
+	omap3_power_states[OMAP3_STATE_C4].valid = 1;
 	omap3_power_states[OMAP3_STATE_C4].type = OMAP3_STATE_C4;
 	omap3_power_states[OMAP3_STATE_C4].sleep_latency = 2500;
 	omap3_power_states[OMAP3_STATE_C4].wakeup_latency = 7500;
@@ -268,6 +271,7 @@ int omap3_idle_init(void)
 		return -EIO;
 	}
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
+	core_pd = pwrdm_lookup("core_pwrdm");
 	return 0;
 }
 device_initcall(omap3_idle_init);
Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-10-08 16:49:10.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-10-08 16:51:45.000000000 +0530
@@ -389,7 +389,7 @@ static int omap3_fclks_active(void)
 	return 0;
 }
 
-static int omap3_can_sleep(void)
+int omap3_can_sleep(void)
 {
 	if (!enable_dyn_sleep)
 		return 0;
Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/pm.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/pm.h	2008-10-08 16:49:10.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/pm.h	2008-10-08 16:51:45.000000000 +0530
@@ -143,6 +143,7 @@ extern void omap2_allow_sleep(void);
 static inline void omap2_block_sleep(void) { }
 static inline void omap2_allow_sleep(void) { }
 #endif
+extern int omap3_can_sleep(void);
 extern void omap730_cpu_suspend(unsigned short, unsigned short);
 extern void omap1510_cpu_suspend(unsigned short, unsigned short);
 extern void omap1610_cpu_suspend(unsigned short, unsigned short);

