From: jean.pihet@newoldbits.com
Subject: [PATCH 2/5] OMAP3: clean-up mach specific cpuidle data structures
Date: Fri, 29 Apr 2011 11:26:23 +0200
Message-ID: <1304069186-3086-3-git-send-email-j-pihet@ti.com>
References: <1304069186-3086-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:33081 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786Ab1D2J0q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Apr 2011 05:26:46 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so2712160wya.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Apr 2011 02:26:45 -0700 (PDT)
In-Reply-To: <1304069186-3086-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

- sleep_latency and wake_latency are not used, replace them by
  exit_latency which is used by cpuidle. exit_latency simply is
  the sum of sleep_latency and wake_latency,
- replace threshold by target_residency,
- changed the OMAP3 specific cpuidle code accordingly,
- changed the OMAP3 board code accordingly.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/board-rx51.c  |   15 +++---
 arch/arm/mach-omap2/cpuidle34xx.c |  103 +++++++++++++++---------------------
 arch/arm/mach-omap2/pm.h          |   13 +++--
 3 files changed, 60 insertions(+), 71 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index f8ba20a..44656e8 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -58,21 +58,22 @@ static struct platform_device leds_gpio = {
 	},
 };
 
+/* cpuidle C-states definition override from the default values */
 static struct cpuidle_params rx51_cpuidle_params[] = {
 	/* C1 */
-	{1, 110, 162, 5},
+	{110 + 162, 5 , 1},
 	/* C2 */
-	{1, 106, 180, 309},
+	{106 + 180, 309, 1},
 	/* C3 */
-	{0, 107, 410, 46057},
+	{107 + 410, 46057, 0},
 	/* C4 */
-	{0, 121, 3374, 46057},
+	{121 + 3374, 46057, 0},
 	/* C5 */
-	{1, 855, 1146, 46057},
+	{855 + 1146, 46057, 1},
 	/* C6 */
-	{0, 7580, 4134, 484329},
+	{7580 + 4134, 484329, 0},
 	/* C7 */
-	{1, 7505, 15274, 484329},
+	{7505 + 15274, 484329, 1},
 };
 
 static struct omap_lcd_config rx51_lcd_config = {
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 1c240ef..d7bc31a 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -52,11 +52,10 @@
 struct omap3_processor_cx {
 	u8 valid;
 	u8 type;
-	u32 sleep_latency;
-	u32 wakeup_latency;
+	u32 exit_latency;
 	u32 mpu_state;
 	u32 core_state;
-	u32 threshold;
+	u32 target_residency;
 	u32 flags;
 	const char *desc;
 };
@@ -75,19 +74,19 @@ struct powerdomain *cam_pd;
  */
 static struct cpuidle_params cpuidle_params_table[] = {
 	/* C1 */
-	{1, 2, 2, 5},
+	{2 + 2, 5, 1},
 	/* C2 */
-	{1, 10, 10, 30},
+	{10 + 10, 30, 1},
 	/* C3 */
-	{1, 50, 50, 300},
+	{50 + 50, 300, 1},
 	/* C4 */
-	{1, 1500, 1800, 4000},
+	{1500 + 1800, 4000, 1},
 	/* C5 */
-	{1, 2500, 7500, 12000},
+	{2500 + 7500, 12000, 1},
 	/* C6 */
-	{1, 3000, 8500, 15000},
+	{3000 + 8500, 15000, 1},
 	/* C7 */
-	{1, 10000, 30000, 300000},
+	{10000 + 30000, 300000, 1},
 };
 
 static int omap3_idle_bm_check(void)
@@ -330,12 +329,10 @@ void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
 	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
 		cpuidle_params_table[i].valid =
 			cpuidle_board_params[i].valid;
-		cpuidle_params_table[i].sleep_latency =
-			cpuidle_board_params[i].sleep_latency;
-		cpuidle_params_table[i].wake_latency =
-			cpuidle_board_params[i].wake_latency;
-		cpuidle_params_table[i].threshold =
-			cpuidle_board_params[i].threshold;
+		cpuidle_params_table[i].exit_latency =
+			cpuidle_board_params[i].exit_latency;
+		cpuidle_params_table[i].target_residency =
+			cpuidle_board_params[i].target_residency;
 	}
 	return;
 }
@@ -357,12 +354,10 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C1].valid =
 			cpuidle_params_table[OMAP3_STATE_C1].valid;
 	omap3_power_states[OMAP3_STATE_C1].type = OMAP3_STATE_C1;
-	omap3_power_states[OMAP3_STATE_C1].sleep_latency =
-			cpuidle_params_table[OMAP3_STATE_C1].sleep_latency;
-	omap3_power_states[OMAP3_STATE_C1].wakeup_latency =
-			cpuidle_params_table[OMAP3_STATE_C1].wake_latency;
-	omap3_power_states[OMAP3_STATE_C1].threshold =
-			cpuidle_params_table[OMAP3_STATE_C1].threshold;
+	omap3_power_states[OMAP3_STATE_C1].exit_latency =
+			cpuidle_params_table[OMAP3_STATE_C1].exit_latency;
+	omap3_power_states[OMAP3_STATE_C1].target_residency =
+			cpuidle_params_table[OMAP3_STATE_C1].target_residency;
 	omap3_power_states[OMAP3_STATE_C1].mpu_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C1].core_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C1].flags = CPUIDLE_FLAG_TIME_VALID;
@@ -372,12 +367,10 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C2].valid =
 			cpuidle_params_table[OMAP3_STATE_C2].valid;
 	omap3_power_states[OMAP3_STATE_C2].type = OMAP3_STATE_C2;
-	omap3_power_states[OMAP3_STATE_C2].sleep_latency =
-			cpuidle_params_table[OMAP3_STATE_C2].sleep_latency;
-	omap3_power_states[OMAP3_STATE_C2].wakeup_latency =
-			cpuidle_params_table[OMAP3_STATE_C2].wake_latency;
-	omap3_power_states[OMAP3_STATE_C2].threshold =
-			cpuidle_params_table[OMAP3_STATE_C2].threshold;
+	omap3_power_states[OMAP3_STATE_C2].exit_latency =
+			cpuidle_params_table[OMAP3_STATE_C2].exit_latency;
+	omap3_power_states[OMAP3_STATE_C2].target_residency =
+			cpuidle_params_table[OMAP3_STATE_C2].target_residency;
 	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID |
@@ -388,12 +381,10 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C3].valid =
 			cpuidle_params_table[OMAP3_STATE_C3].valid;
 	omap3_power_states[OMAP3_STATE_C3].type = OMAP3_STATE_C3;
-	omap3_power_states[OMAP3_STATE_C3].sleep_latency =
-			cpuidle_params_table[OMAP3_STATE_C3].sleep_latency;
-	omap3_power_states[OMAP3_STATE_C3].wakeup_latency =
-			cpuidle_params_table[OMAP3_STATE_C3].wake_latency;
-	omap3_power_states[OMAP3_STATE_C3].threshold =
-			cpuidle_params_table[OMAP3_STATE_C3].threshold;
+	omap3_power_states[OMAP3_STATE_C3].exit_latency =
+			cpuidle_params_table[OMAP3_STATE_C3].exit_latency;
+	omap3_power_states[OMAP3_STATE_C3].target_residency =
+			cpuidle_params_table[OMAP3_STATE_C3].target_residency;
 	omap3_power_states[OMAP3_STATE_C3].mpu_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C3].core_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C3].flags = CPUIDLE_FLAG_TIME_VALID |
@@ -404,12 +395,10 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C4].valid =
 			cpuidle_params_table[OMAP3_STATE_C4].valid;
 	omap3_power_states[OMAP3_STATE_C4].type = OMAP3_STATE_C4;
-	omap3_power_states[OMAP3_STATE_C4].sleep_latency =
-			cpuidle_params_table[OMAP3_STATE_C4].sleep_latency;
-	omap3_power_states[OMAP3_STATE_C4].wakeup_latency =
-			cpuidle_params_table[OMAP3_STATE_C4].wake_latency;
-	omap3_power_states[OMAP3_STATE_C4].threshold =
-			cpuidle_params_table[OMAP3_STATE_C4].threshold;
+	omap3_power_states[OMAP3_STATE_C4].exit_latency =
+			cpuidle_params_table[OMAP3_STATE_C4].exit_latency;
+	omap3_power_states[OMAP3_STATE_C4].target_residency =
+			cpuidle_params_table[OMAP3_STATE_C4].target_residency;
 	omap3_power_states[OMAP3_STATE_C4].mpu_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C4].core_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C4].flags = CPUIDLE_FLAG_TIME_VALID |
@@ -420,12 +409,10 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C5].valid =
 			cpuidle_params_table[OMAP3_STATE_C5].valid;
 	omap3_power_states[OMAP3_STATE_C5].type = OMAP3_STATE_C5;
-	omap3_power_states[OMAP3_STATE_C5].sleep_latency =
-			cpuidle_params_table[OMAP3_STATE_C5].sleep_latency;
-	omap3_power_states[OMAP3_STATE_C5].wakeup_latency =
-			cpuidle_params_table[OMAP3_STATE_C5].wake_latency;
-	omap3_power_states[OMAP3_STATE_C5].threshold =
-			cpuidle_params_table[OMAP3_STATE_C5].threshold;
+	omap3_power_states[OMAP3_STATE_C5].exit_latency =
+			cpuidle_params_table[OMAP3_STATE_C5].exit_latency;
+	omap3_power_states[OMAP3_STATE_C5].target_residency =
+			cpuidle_params_table[OMAP3_STATE_C5].target_residency;
 	omap3_power_states[OMAP3_STATE_C5].mpu_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C5].core_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C5].flags = CPUIDLE_FLAG_TIME_VALID |
@@ -436,12 +423,10 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C6].valid =
 			cpuidle_params_table[OMAP3_STATE_C6].valid;
 	omap3_power_states[OMAP3_STATE_C6].type = OMAP3_STATE_C6;
-	omap3_power_states[OMAP3_STATE_C6].sleep_latency =
-			cpuidle_params_table[OMAP3_STATE_C6].sleep_latency;
-	omap3_power_states[OMAP3_STATE_C6].wakeup_latency =
-			cpuidle_params_table[OMAP3_STATE_C6].wake_latency;
-	omap3_power_states[OMAP3_STATE_C6].threshold =
-			cpuidle_params_table[OMAP3_STATE_C6].threshold;
+	omap3_power_states[OMAP3_STATE_C6].exit_latency =
+			cpuidle_params_table[OMAP3_STATE_C6].exit_latency;
+	omap3_power_states[OMAP3_STATE_C6].target_residency =
+			cpuidle_params_table[OMAP3_STATE_C6].target_residency;
 	omap3_power_states[OMAP3_STATE_C6].mpu_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C6].core_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C6].flags = CPUIDLE_FLAG_TIME_VALID |
@@ -452,12 +437,10 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C7].valid =
 			cpuidle_params_table[OMAP3_STATE_C7].valid;
 	omap3_power_states[OMAP3_STATE_C7].type = OMAP3_STATE_C7;
-	omap3_power_states[OMAP3_STATE_C7].sleep_latency =
-			cpuidle_params_table[OMAP3_STATE_C7].sleep_latency;
-	omap3_power_states[OMAP3_STATE_C7].wakeup_latency =
-			cpuidle_params_table[OMAP3_STATE_C7].wake_latency;
-	omap3_power_states[OMAP3_STATE_C7].threshold =
-			cpuidle_params_table[OMAP3_STATE_C7].threshold;
+	omap3_power_states[OMAP3_STATE_C7].exit_latency =
+			cpuidle_params_table[OMAP3_STATE_C7].exit_latency;
+	omap3_power_states[OMAP3_STATE_C7].target_residency =
+			cpuidle_params_table[OMAP3_STATE_C7].target_residency;
 	omap3_power_states[OMAP3_STATE_C7].mpu_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C7].core_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C7].flags = CPUIDLE_FLAG_TIME_VALID |
@@ -512,8 +495,8 @@ int __init omap3_idle_init(void)
 		if (!cx->valid)
 			continue;
 		cpuidle_set_statedata(state, cx);
-		state->exit_latency = cx->sleep_latency + cx->wakeup_latency;
-		state->target_residency = cx->threshold;
+		state->exit_latency = cx->exit_latency;
+		state->target_residency = cx->target_residency;
 		state->flags = cx->flags;
 		state->enter = (state->flags & CPUIDLE_FLAG_CHECK_BM) ?
 			omap3_enter_idle_bm : omap3_enter_idle;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 797bfd1..32dbc13 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -36,11 +36,16 @@ static inline int omap4_opp_init(void)
 }
 #endif
 
+/*
+ * cpuidle mach specific parameters
+ *
+ * The board code can override the default C-states definition using
+ * omap3_pm_init_cpuidle
+ */
 struct cpuidle_params {
-	u8  valid;
-	u32 sleep_latency;
-	u32 wake_latency;
-	u32 threshold;
+	u32 exit_latency;	/* exit_latency = sleep + wake-up latencies */
+	u32 target_residency;
+	u8 valid;		/* validates the C-state */
 };
 
 #if defined(CONFIG_PM) && defined(CONFIG_CPU_IDLE)
-- 
1.7.1

