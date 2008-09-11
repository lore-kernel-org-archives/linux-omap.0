From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 09/29] mpu off state enabled
Date: Thu, 11 Sep 2008 15:33:53 +0300
Message-ID: <1221136453-16697-9-git-send-email-khilman@deeprootsystems.com>
References: <87iqt2amoi.fsf@deeprootsystems.com>
 <1221136453-16697-1-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-2-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-3-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-4-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-5-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-6-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-7-git-send-email-khilman@deeprootsystems.com>
 <1221136453-16697-8-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:18946 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755849AbYIKMer (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 08:34:47 -0400
In-Reply-To: <1221136453-16697-8-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This patch updates the CPUidle code to handle MPU OFF related C states
---
 arch/arm/mach-omap2/cpuidle34xx.c |   19 +++++++++++++++----
 arch/arm/mach-omap2/cpuidle34xx.h |    5 +++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 99ecd75..ee58873 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -82,8 +82,12 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 
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
 
@@ -97,9 +101,13 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
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
@@ -207,7 +215,7 @@ void omap_init_power_states(void)
 						CPUIDLE_FLAG_BALANCED;
 
 	/* C3 . MPU OFF + Core active */
-	omap3_power_states[3].valid = 0;
+	omap3_power_states[3].valid = 1;
 	omap3_power_states[3].type = OMAP3_STATE_C3;
 	omap3_power_states[3].sleep_latency = 1500;
 	omap3_power_states[3].wakeup_latency = 1800;
@@ -229,7 +237,7 @@ void omap_init_power_states(void)
 			CPUIDLE_FLAG_BALANCED | CPUIDLE_FLAG_CHECK_BM;
 
 	/* C5 . MPU OFF + Core CSWR */
-	omap3_power_states[5].valid = 0;
+	omap3_power_states[5].valid = 1;
 	omap3_power_states[5].type = OMAP3_STATE_C5;
 	omap3_power_states[5].sleep_latency = 3000;
 	omap3_power_states[5].wakeup_latency = 8500;
@@ -266,6 +274,9 @@ int omap3_idle_init(void)
 	struct cpuidle_state *state;
 	struct cpuidle_device *dev;
 
+	clear_scratchpad_contents();
+	save_scratchpad_contents();
+
 	omap_init_power_states();
 	cpuidle_register_driver(&omap3_idle_driver);
 
diff --git a/arch/arm/mach-omap2/cpuidle34xx.h b/arch/arm/mach-omap2/cpuidle34xx.h
index 46ed51e..f2ebe68 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.h
+++ b/arch/arm/mach-omap2/cpuidle34xx.h
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
-- 
1.6.0

