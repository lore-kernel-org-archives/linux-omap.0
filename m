From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 3/7] OMAP3: cpuidle: Add valid field into C-state parameter passing
Date: Wed, 17 Feb 2010 18:02:26 -0600
Message-ID: <1266451350-4480-4-git-send-email-khilman@deeprootsystems.com>
References: <1266451350-4480-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f227.google.com ([209.85.217.227]:53834 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758003Ab0BRACl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 19:02:41 -0500
Received: by gxk27 with SMTP id 27so1957648gxk.1
        for <linux-omap@vger.kernel.org>; Wed, 17 Feb 2010 16:02:39 -0800 (PST)
In-Reply-To: <1266451350-4480-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

Different boards benefit differently from the available
seven C-states for cpu idle. In most cases, only few,
properly spaced (in terms of consumption and latency)
C-states are required to make the power management
optimal. Hence we need a possibility to pass which
C-states are actually used for each board.

So added the valid field to cpuidle_params and added
support to 3430sdp, which uses the paramenter passing.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   14 ++++++------
 arch/arm/mach-omap2/cpuidle34xx.c   |   37 +++++++++++++++++++++-------------
 arch/arm/mach-omap2/pm.h            |    1 +
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 99f295e..d4647ab 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -61,19 +61,19 @@
 /* FIXME: These values need to be updated based on more profiling on 3430sdp*/
 static struct cpuidle_params omap3_cpuidle_params_table[] = {
 	/* C1 */
-	{2, 2, 5},
+	{1, 2, 2, 5},
 	/* C2 */
-	{10, 10, 30},
+	{1, 10, 10, 30},
 	/* C3 */
-	{50, 50, 300},
+	{1, 50, 50, 300},
 	/* C4 */
-	{1500, 1800, 4000},
+	{1, 1500, 1800, 4000},
 	/* C5 */
-	{2500, 7500, 12000},
+	{1, 2500, 7500, 12000},
 	/* C6 */
-	{3000, 8500, 15000},
+	{1, 3000, 8500, 15000},
 	/* C7 */
-	{10000, 30000, 300000},
+	{1, 10000, 30000, 300000},
 };
 
 static int board_keymap[] = {
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 597148e..3d3d035 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -71,19 +71,19 @@ struct powerdomain *mpu_pd, *core_pd;
  */
 static struct cpuidle_params cpuidle_params_table[] = {
 	/* C1 */
-	{2, 2, 5},
+	{1, 2, 2, 5},
 	/* C2 */
-	{10, 10, 30},
+	{1, 10, 10, 30},
 	/* C3 */
-	{50, 50, 300},
+	{1, 50, 50, 300},
 	/* C4 */
-	{1500, 1800, 4000},
+	{1, 1500, 1800, 4000},
 	/* C5 */
-	{2500, 7500, 12000},
+	{1, 2500, 7500, 12000},
 	/* C6 */
-	{3000, 8500, 15000},
+	{1, 3000, 8500, 15000},
 	/* C7 */
-	{10000, 30000, 300000},
+	{1, 10000, 30000, 300000},
 };
 
 static int omap3_idle_bm_check(void)
@@ -277,6 +277,8 @@ void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
 		return;
 
 	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
+		cpuidle_params_table[i].valid =
+			cpuidle_board_params[i].valid;
 		cpuidle_params_table[i].sleep_latency =
 			cpuidle_board_params[i].sleep_latency;
 		cpuidle_params_table[i].wake_latency =
@@ -301,7 +303,8 @@ void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
 void omap_init_power_states(void)
 {
 	/* C1 . MPU WFI + Core active */
-	omap3_power_states[OMAP3_STATE_C1].valid = 1;
+	omap3_power_states[OMAP3_STATE_C1].valid =
+			cpuidle_params_table[OMAP3_STATE_C1].valid;
 	omap3_power_states[OMAP3_STATE_C1].type = OMAP3_STATE_C1;
 	omap3_power_states[OMAP3_STATE_C1].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C1].sleep_latency;
@@ -314,7 +317,8 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C1].flags = CPUIDLE_FLAG_TIME_VALID;
 
 	/* C2 . MPU WFI + Core inactive */
-	omap3_power_states[OMAP3_STATE_C2].valid = 1;
+	omap3_power_states[OMAP3_STATE_C2].valid =
+			cpuidle_params_table[OMAP3_STATE_C2].valid;
 	omap3_power_states[OMAP3_STATE_C2].type = OMAP3_STATE_C2;
 	omap3_power_states[OMAP3_STATE_C2].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C2].sleep_latency;
@@ -327,7 +331,8 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID;
 
 	/* C3 . MPU CSWR + Core inactive */
-	omap3_power_states[OMAP3_STATE_C3].valid = 1;
+	omap3_power_states[OMAP3_STATE_C3].valid =
+			cpuidle_params_table[OMAP3_STATE_C3].valid;
 	omap3_power_states[OMAP3_STATE_C3].type = OMAP3_STATE_C3;
 	omap3_power_states[OMAP3_STATE_C3].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C3].sleep_latency;
@@ -341,7 +346,8 @@ void omap_init_power_states(void)
 				CPUIDLE_FLAG_CHECK_BM;
 
 	/* C4 . MPU OFF + Core inactive */
-	omap3_power_states[OMAP3_STATE_C4].valid = 1;
+	omap3_power_states[OMAP3_STATE_C4].valid =
+			cpuidle_params_table[OMAP3_STATE_C4].valid;
 	omap3_power_states[OMAP3_STATE_C4].type = OMAP3_STATE_C4;
 	omap3_power_states[OMAP3_STATE_C4].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C4].sleep_latency;
@@ -355,7 +361,8 @@ void omap_init_power_states(void)
 				CPUIDLE_FLAG_CHECK_BM;
 
 	/* C5 . MPU CSWR + Core CSWR*/
-	omap3_power_states[OMAP3_STATE_C5].valid = 1;
+	omap3_power_states[OMAP3_STATE_C5].valid =
+			cpuidle_params_table[OMAP3_STATE_C5].valid;
 	omap3_power_states[OMAP3_STATE_C5].type = OMAP3_STATE_C5;
 	omap3_power_states[OMAP3_STATE_C5].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C5].sleep_latency;
@@ -369,7 +376,8 @@ void omap_init_power_states(void)
 				CPUIDLE_FLAG_CHECK_BM;
 
 	/* C6 . MPU OFF + Core CSWR */
-	omap3_power_states[OMAP3_STATE_C6].valid = 1;
+	omap3_power_states[OMAP3_STATE_C6].valid =
+			cpuidle_params_table[OMAP3_STATE_C6].valid;
 	omap3_power_states[OMAP3_STATE_C6].type = OMAP3_STATE_C6;
 	omap3_power_states[OMAP3_STATE_C6].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C6].sleep_latency;
@@ -383,7 +391,8 @@ void omap_init_power_states(void)
 				CPUIDLE_FLAG_CHECK_BM;
 
 	/* C7 . MPU OFF + Core OFF */
-	omap3_power_states[OMAP3_STATE_C7].valid = 1;
+	omap3_power_states[OMAP3_STATE_C7].valid =
+			cpuidle_params_table[OMAP3_STATE_C7].valid;
 	omap3_power_states[OMAP3_STATE_C7].type = OMAP3_STATE_C7;
 	omap3_power_states[OMAP3_STATE_C7].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C7].sleep_latency;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 58a2671..bd6466a 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -24,6 +24,7 @@ extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
 
 struct cpuidle_params {
+	u8  valid;
 	u32 sleep_latency;
 	u32 wake_latency;
 	u32 threshold;
-- 
1.6.6

