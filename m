From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 06/11] mpu off state enabled
Date: Tue, 1 Jul 2008 19:46:20 +0530
Message-ID: <004301c8db85$08e0e970$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57370 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759571AbYGAOQ3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Jul 2008 10:16:29 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id m61EGKgT015729
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 1 Jul 2008 09:16:28 -0500
Received: from a0393137pc (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id m61EGJGp011499
	for <linux-omap@vger.kernel.org>; Tue, 1 Jul 2008 19:46:19 +0530 (IST)
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
--- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.c	2008-07-01 16:47:53.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.c	2008-07-01 16:55:39.112465404 +0530
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
--- linux-omap-2.6.orig/arch/arm/mach-omap2/cpuidle34xx.h	2008-07-01 16:25:16.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/cpuidle34xx.h	2008-07-01 16:56:13.298377929 +0530
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

