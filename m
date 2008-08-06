From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 06/11] mpu off state enabled
Date: Wed, 6 Aug 2008 18:45:24 +0530 (IST)
Message-ID: <44373.192.168.10.89.1218028524.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:45936 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757560AbYHFNYf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Aug 2008 09:24:35 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m76DFPmg003514
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 08:15:30 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id m76DFLHR021997
	for <linux-omap@vger.kernel.org>; Wed, 6 Aug 2008 08:15:23 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch updates the CPUidle code to handle MPU OFF related C states

Signed-off-by: Rajendra Nayak <rnayak@ti.com>

---
 arch/arm/mach-omap2/cpuidle34xx.c |   19 +++++++++++++++----
 arch/arm/mach-omap2/cpuidle34xx.h |    5 +++++
 2 files changed, 20 insertions(+), 4 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.c	2008-08-06
18:09:48.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c	2008-08-06
18:10:59.000000000 +0530
@@ -82,8 +82,12 @@ static int omap3_enter_idle(struct cpuid

 	/* Program MPU to target state */
 	if (cx->mpu_state < PWRDM_POWER_ON) {
-		if (neon_pwrst == PWRDM_POWER_ON)
-			pwrdm_set_next_pwrst(neon_pd, PWRDM_POWER_RET);
+		if (neon_pwrst == PWRDM_POWER_ON) {
+			if (cx->mpu_state == PWRDM_POWER_RET)
+				pwrdm_set_next_pwrst(neon_pd, PWRDM_POWER_RET);
+			else if (cx->mpu_state == PWRDM_POWER_OFF)
+				pwrdm_set_next_pwrst(neon_pd, PWRDM_POWER_OFF);
+		}
 		pwrdm_set_next_pwrst(mpu_pd, cx->mpu_state);
 	}

@@ -99,9 +103,13 @@ static int omap3_enter_idle(struct cpuid
 		pwrdm_set_next_pwrst(core_pd, cx->core_state);
 	}

+	*(scratchpad_restore_addr) = restore_pointer_address;
+
 	/* Execute ARM wfi */
 	omap_sram_idle();

+	*(scratchpad_restore_addr) = 0x0;
+
 	/* Program MPU/NEON to ON */
 	if (cx->mpu_state < PWRDM_POWER_ON) {
 		if (neon_pwrst == PWRDM_POWER_ON)
@@ -211,7 +219,7 @@ void omap_init_power_states(void)
 						CPUIDLE_FLAG_BALANCED;

 	/* C3 . MPU OFF + Core active */
-	omap3_power_states[3].valid = 0;
+	omap3_power_states[3].valid = 1;
 	omap3_power_states[3].type = OMAP3_STATE_C3;
 	omap3_power_states[3].sleep_latency = 1500;
 	omap3_power_states[3].wakeup_latency = 1800;
@@ -233,7 +241,7 @@ void omap_init_power_states(void)
 			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;

 	/* C5 . MPU OFF + Core CSWR */
-	omap3_power_states[5].valid = 0;
+	omap3_power_states[5].valid = 1;
 	omap3_power_states[5].type = OMAP3_STATE_C5;
 	omap3_power_states[5].sleep_latency = 3000;
 	omap3_power_states[5].wakeup_latency = 8500;
@@ -270,6 +278,9 @@ int omap3_idle_init(void)
 	struct cpuidle_state *state;
 	struct cpuidle_device *dev;

+	clear_scratchpad_contents();
+	save_scratchpad_contents();
+
 	omap_init_power_states();
 	cpuidle_register_driver(&omap3_idle_driver);

Index: linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.h	2008-08-06
18:09:48.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.h	2008-08-06
18:10:59.000000000 +0530
@@ -40,6 +40,11 @@ extern void per_gpio_clk_enable(void);
 extern void per_gpio_clk_disable(void);
 extern void omap_serial_enable_clocks(int enable);
 extern int omap3_can_sleep();
+extern void clear_scratchpad_contents(void);
+extern void save_scratchpad_contents(void);
+extern u32 *scratchpad_restore_addr;
+extern u32 restore_pointer_address;
+
 struct omap3_processor_cx {
 	u8 valid;
 	u8 type;


