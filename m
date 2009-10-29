From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 2/3] OMAP3: Add valid field into C-state parameter passing
Date: Thu, 29 Oct 2009 10:30:19 +0200
Message-ID: <1256805020-7402-3-git-send-email-kalle.jokiniemi@digia.com>
References: <>
 <1256805020-7402-1-git-send-email-kalle.jokiniemi@digia.com>
 <1256805020-7402-2-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:12145 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753209AbZJ2IaI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Oct 2009 04:30:08 -0400
In-Reply-To: <1256805020-7402-2-git-send-email-kalle.jokiniemi@digia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, jouni.hogander@nokia.com, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

Different boards benefit differently from the available
seven C-states for cpu idle. In most cases, only few,
properly spaced (in terms of consumption and latency)
C-states are required to make the power management
optimal. Hence we need a possibility to pass which
C-states are actually used for each board.

So added the valid field to cpuidle_params and added
support to 3430sdp, which uses the paramenter passing.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   14 ++++++------
 arch/arm/mach-omap2/cpuidle34xx.c   |   37 +++++++++++++++++++++-------------
 arch/arm/mach-omap2/pm.h            |    1 +
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 11f0dc5..74c20ee 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -76,19 +76,19 @@ static struct prm_setup_vc omap3_setuptime_table = {
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
index fdfa1d5..9c9474a 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -69,19 +69,19 @@ struct powerdomain *mpu_pd, *core_pd;
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
@@ -197,6 +197,8 @@ void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
 		return;
 
 	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
+		cpuidle_params_table[i].valid =
+			cpuidle_board_params[i].valid;
 		cpuidle_params_table[i].sleep_latency =
 			cpuidle_board_params[i].sleep_latency;
 		cpuidle_params_table[i].wake_latency =
@@ -221,7 +223,8 @@ void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
 void omap_init_power_states(void)
 {
 	/* C1 . MPU WFI + Core active */
-	omap3_power_states[OMAP3_STATE_C1].valid = 1;
+	omap3_power_states[OMAP3_STATE_C1].valid =
+			cpuidle_params_table[OMAP3_STATE_C1].valid;
 	omap3_power_states[OMAP3_STATE_C1].type = OMAP3_STATE_C1;
 	omap3_power_states[OMAP3_STATE_C1].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C1].sleep_latency;
@@ -234,7 +237,8 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C1].flags = CPUIDLE_FLAG_TIME_VALID;
 
 	/* C2 . MPU WFI + Core inactive */
-	omap3_power_states[OMAP3_STATE_C2].valid = 1;
+	omap3_power_states[OMAP3_STATE_C2].valid =
+			cpuidle_params_table[OMAP3_STATE_C2].valid;
 	omap3_power_states[OMAP3_STATE_C2].type = OMAP3_STATE_C2;
 	omap3_power_states[OMAP3_STATE_C2].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C2].sleep_latency;
@@ -247,7 +251,8 @@ void omap_init_power_states(void)
 	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID;
 
 	/* C3 . MPU CSWR + Core inactive */
-	omap3_power_states[OMAP3_STATE_C3].valid = 1;
+	omap3_power_states[OMAP3_STATE_C3].valid =
+			cpuidle_params_table[OMAP3_STATE_C3].valid;
 	omap3_power_states[OMAP3_STATE_C3].type = OMAP3_STATE_C3;
 	omap3_power_states[OMAP3_STATE_C3].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C3].sleep_latency;
@@ -261,7 +266,8 @@ void omap_init_power_states(void)
 				CPUIDLE_FLAG_CHECK_BM;
 
 	/* C4 . MPU OFF + Core inactive */
-	omap3_power_states[OMAP3_STATE_C4].valid = 1;
+	omap3_power_states[OMAP3_STATE_C4].valid =
+			cpuidle_params_table[OMAP3_STATE_C4].valid;
 	omap3_power_states[OMAP3_STATE_C4].type = OMAP3_STATE_C4;
 	omap3_power_states[OMAP3_STATE_C4].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C4].sleep_latency;
@@ -275,7 +281,8 @@ void omap_init_power_states(void)
 				CPUIDLE_FLAG_CHECK_BM;
 
 	/* C5 . MPU CSWR + Core CSWR*/
-	omap3_power_states[OMAP3_STATE_C5].valid = 1;
+	omap3_power_states[OMAP3_STATE_C5].valid =
+			cpuidle_params_table[OMAP3_STATE_C5].valid;
 	omap3_power_states[OMAP3_STATE_C5].type = OMAP3_STATE_C5;
 	omap3_power_states[OMAP3_STATE_C5].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C5].sleep_latency;
@@ -289,7 +296,8 @@ void omap_init_power_states(void)
 				CPUIDLE_FLAG_CHECK_BM;
 
 	/* C6 . MPU OFF + Core CSWR */
-	omap3_power_states[OMAP3_STATE_C6].valid = 1;
+	omap3_power_states[OMAP3_STATE_C6].valid =
+			cpuidle_params_table[OMAP3_STATE_C6].valid;
 	omap3_power_states[OMAP3_STATE_C6].type = OMAP3_STATE_C6;
 	omap3_power_states[OMAP3_STATE_C6].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C6].sleep_latency;
@@ -303,7 +311,8 @@ void omap_init_power_states(void)
 				CPUIDLE_FLAG_CHECK_BM;
 
 	/* C7 . MPU OFF + Core OFF */
-	omap3_power_states[OMAP3_STATE_C7].valid = 1;
+	omap3_power_states[OMAP3_STATE_C7].valid =
+			cpuidle_params_table[OMAP3_STATE_C7].valid;
 	omap3_power_states[OMAP3_STATE_C7].type = OMAP3_STATE_C7;
 	omap3_power_states[OMAP3_STATE_C7].sleep_latency =
 			cpuidle_params_table[OMAP3_STATE_C7].sleep_latency;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index b9421e8..c195b14 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -43,6 +43,7 @@ struct prm_setup_vc {
 };
 
 struct cpuidle_params {
+	u8  valid;
 	u32 sleep_latency;
 	u32 wake_latency;
 	u32 threshold;
-- 
1.5.4.3

