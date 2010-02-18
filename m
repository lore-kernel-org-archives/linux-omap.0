From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/7] OMAP3: cpuidle: configure latencies/thresholds from board
	file
Date: Wed, 17 Feb 2010 18:02:25 -0600
Message-ID: <1266451350-4480-3-git-send-email-khilman@deeprootsystems.com>
References: <1266451350-4480-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1266451350-4480-1-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Kalle Jokiniemi <kalle.jokiniemi@digia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The CPUidle C state latencies and thresholds are dependent on various
board specific details.  This patch makes it possible to configure
these values from the respective board files.

omap3_pm_init_cpuidle() can now be optionally called from board files
to pass board specific cpuidle parameters.  If the board files do not
use this function to pass the params default values are used which
might cause higher consumption dur to wrong state selection by the
governor.

This patch only updates the 3430sdp board files to use
omap3_pm_init_cpuidle().

>From Kalle, in addition to original patch from Rajendra:

Building without CONFIG_CPU_IDLE or CONFIG_PM causes build to fail if
cpu idle parameters are tried to pass using omap3_pm_init_cpuidle
function.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   20 +++++++
 arch/arm/mach-omap2/cpuidle34xx.c   |  105 ++++++++++++++++++++++++++++-------
 arch/arm/mach-omap2/pm.h            |   15 +++++
 3 files changed, 119 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 5adef51..99f295e 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -46,6 +46,7 @@
 #include "mux.h"
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "hsmmc.h"
+#include "pm.h"
 
 #define CONFIG_DISABLE_HFCLK 1
 
@@ -57,6 +58,24 @@
 
 #define TWL4030_MSECURE_GPIO 22
 
+/* FIXME: These values need to be updated based on more profiling on 3430sdp*/
+static struct cpuidle_params omap3_cpuidle_params_table[] = {
+	/* C1 */
+	{2, 2, 5},
+	/* C2 */
+	{10, 10, 30},
+	/* C3 */
+	{50, 50, 300},
+	/* C4 */
+	{1500, 1800, 4000},
+	/* C5 */
+	{2500, 7500, 12000},
+	/* C6 */
+	{3000, 8500, 15000},
+	/* C7 */
+	{10000, 30000, 300000},
+};
+
 static int board_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
@@ -307,6 +326,7 @@ static void __init omap_3430sdp_init_irq(void)
 {
 	omap_board_config = sdp3430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
+	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
 	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index ff1ad3d..597148e 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -62,6 +62,30 @@ struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
 struct omap3_processor_cx current_cx_state;
 struct powerdomain *mpu_pd, *core_pd;
 
+/*
+ * The latencies/thresholds for various C states have
+ * to be configured from the respective board files.
+ * These are some default values (which might not provide
+ * the best power savings) used on boards which do not
+ * pass these details from the board file.
+ */
+static struct cpuidle_params cpuidle_params_table[] = {
+	/* C1 */
+	{2, 2, 5},
+	/* C2 */
+	{10, 10, 30},
+	/* C3 */
+	{50, 50, 300},
+	/* C4 */
+	{1500, 1800, 4000},
+	/* C5 */
+	{2500, 7500, 12000},
+	/* C6 */
+	{3000, 8500, 15000},
+	/* C7 */
+	{10000, 30000, 300000},
+};
+
 static int omap3_idle_bm_check(void)
 {
 	if (!omap3_can_sleep())
@@ -245,6 +269,24 @@ void omap3_cpuidle_update_states(void)
 	}
 }
 
+void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
+{
+	int i;
+
+	if (!cpuidle_board_params)
+		return;
+
+	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
+		cpuidle_params_table[i].sleep_latency =
+			cpuidle_board_params[i].sleep_latency;
+		cpuidle_params_table[i].wake_latency =
+			cpuidle_board_params[i].wake_latency;
+		cpuidle_params_table[i].threshold =
+			cpuidle_board_params[i].threshold;
+	}
+	return;
+}
+
 /* omap3_init_power_states - Initialises the OMAP3 specific C states.
  *
  * Below is the desciption of each C state.
@@ -261,9 +303,12 @@ void omap_init_power_states(void)
 	/* C1 . MPU WFI + Core active */
 	omap3_power_states[OMAP3_STATE_C1].valid = 1;
 	omap3_power_states[OMAP3_STATE_C1].type = OMAP3_STATE_C1;
-	omap3_power_states[OMAP3_STATE_C1].sleep_latency = 2;
-	omap3_power_states[OMAP3_STATE_C1].wakeup_latency = 2;
-	omap3_power_states[OMAP3_STATE_C1].threshold = 5;
+	omap3_power_states[OMAP3_STATE_C1].sleep_latency =
+			cpuidle_params_table[OMAP3_STATE_C1].sleep_latency;
+	omap3_power_states[OMAP3_STATE_C1].wakeup_latency =
+			cpuidle_params_table[OMAP3_STATE_C1].wake_latency;
+	omap3_power_states[OMAP3_STATE_C1].threshold =
+			cpuidle_params_table[OMAP3_STATE_C1].threshold;
 	omap3_power_states[OMAP3_STATE_C1].mpu_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C1].core_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C1].flags = CPUIDLE_FLAG_TIME_VALID;
@@ -271,9 +316,12 @@ void omap_init_power_states(void)
 	/* C2 . MPU WFI + Core inactive */
 	omap3_power_states[OMAP3_STATE_C2].valid = 1;
 	omap3_power_states[OMAP3_STATE_C2].type = OMAP3_STATE_C2;
-	omap3_power_states[OMAP3_STATE_C2].sleep_latency = 10;
-	omap3_power_states[OMAP3_STATE_C2].wakeup_latency = 10;
-	omap3_power_states[OMAP3_STATE_C2].threshold = 30;
+	omap3_power_states[OMAP3_STATE_C2].sleep_latency =
+			cpuidle_params_table[OMAP3_STATE_C2].sleep_latency;
+	omap3_power_states[OMAP3_STATE_C2].wakeup_latency =
+			cpuidle_params_table[OMAP3_STATE_C2].wake_latency;
+	omap3_power_states[OMAP3_STATE_C2].threshold =
+			cpuidle_params_table[OMAP3_STATE_C2].threshold;
 	omap3_power_states[OMAP3_STATE_C2].mpu_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C2].core_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C2].flags = CPUIDLE_FLAG_TIME_VALID;
@@ -281,9 +329,12 @@ void omap_init_power_states(void)
 	/* C3 . MPU CSWR + Core inactive */
 	omap3_power_states[OMAP3_STATE_C3].valid = 1;
 	omap3_power_states[OMAP3_STATE_C3].type = OMAP3_STATE_C3;
-	omap3_power_states[OMAP3_STATE_C3].sleep_latency = 50;
-	omap3_power_states[OMAP3_STATE_C3].wakeup_latency = 50;
-	omap3_power_states[OMAP3_STATE_C3].threshold = 300;
+	omap3_power_states[OMAP3_STATE_C3].sleep_latency =
+			cpuidle_params_table[OMAP3_STATE_C3].sleep_latency;
+	omap3_power_states[OMAP3_STATE_C3].wakeup_latency =
+			cpuidle_params_table[OMAP3_STATE_C3].wake_latency;
+	omap3_power_states[OMAP3_STATE_C3].threshold =
+			cpuidle_params_table[OMAP3_STATE_C3].threshold;
 	omap3_power_states[OMAP3_STATE_C3].mpu_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C3].core_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C3].flags = CPUIDLE_FLAG_TIME_VALID |
@@ -292,9 +343,12 @@ void omap_init_power_states(void)
 	/* C4 . MPU OFF + Core inactive */
 	omap3_power_states[OMAP3_STATE_C4].valid = 1;
 	omap3_power_states[OMAP3_STATE_C4].type = OMAP3_STATE_C4;
-	omap3_power_states[OMAP3_STATE_C4].sleep_latency = 1500;
-	omap3_power_states[OMAP3_STATE_C4].wakeup_latency = 1800;
-	omap3_power_states[OMAP3_STATE_C4].threshold = 4000;
+	omap3_power_states[OMAP3_STATE_C4].sleep_latency =
+			cpuidle_params_table[OMAP3_STATE_C4].sleep_latency;
+	omap3_power_states[OMAP3_STATE_C4].wakeup_latency =
+			cpuidle_params_table[OMAP3_STATE_C4].wake_latency;
+	omap3_power_states[OMAP3_STATE_C4].threshold =
+			cpuidle_params_table[OMAP3_STATE_C4].threshold;
 	omap3_power_states[OMAP3_STATE_C4].mpu_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C4].core_state = PWRDM_POWER_ON;
 	omap3_power_states[OMAP3_STATE_C4].flags = CPUIDLE_FLAG_TIME_VALID |
@@ -303,9 +357,12 @@ void omap_init_power_states(void)
 	/* C5 . MPU CSWR + Core CSWR*/
 	omap3_power_states[OMAP3_STATE_C5].valid = 1;
 	omap3_power_states[OMAP3_STATE_C5].type = OMAP3_STATE_C5;
-	omap3_power_states[OMAP3_STATE_C5].sleep_latency = 2500;
-	omap3_power_states[OMAP3_STATE_C5].wakeup_latency = 7500;
-	omap3_power_states[OMAP3_STATE_C5].threshold = 12000;
+	omap3_power_states[OMAP3_STATE_C5].sleep_latency =
+			cpuidle_params_table[OMAP3_STATE_C5].sleep_latency;
+	omap3_power_states[OMAP3_STATE_C5].wakeup_latency =
+			cpuidle_params_table[OMAP3_STATE_C5].wake_latency;
+	omap3_power_states[OMAP3_STATE_C5].threshold =
+			cpuidle_params_table[OMAP3_STATE_C5].threshold;
 	omap3_power_states[OMAP3_STATE_C5].mpu_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C5].core_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C5].flags = CPUIDLE_FLAG_TIME_VALID |
@@ -314,9 +371,12 @@ void omap_init_power_states(void)
 	/* C6 . MPU OFF + Core CSWR */
 	omap3_power_states[OMAP3_STATE_C6].valid = 1;
 	omap3_power_states[OMAP3_STATE_C6].type = OMAP3_STATE_C6;
-	omap3_power_states[OMAP3_STATE_C6].sleep_latency = 3000;
-	omap3_power_states[OMAP3_STATE_C6].wakeup_latency = 8500;
-	omap3_power_states[OMAP3_STATE_C6].threshold = 15000;
+	omap3_power_states[OMAP3_STATE_C6].sleep_latency =
+			cpuidle_params_table[OMAP3_STATE_C6].sleep_latency;
+	omap3_power_states[OMAP3_STATE_C6].wakeup_latency =
+			cpuidle_params_table[OMAP3_STATE_C6].wake_latency;
+	omap3_power_states[OMAP3_STATE_C6].threshold =
+			cpuidle_params_table[OMAP3_STATE_C6].threshold;
 	omap3_power_states[OMAP3_STATE_C6].mpu_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C6].core_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C6].flags = CPUIDLE_FLAG_TIME_VALID |
@@ -325,9 +385,12 @@ void omap_init_power_states(void)
 	/* C7 . MPU OFF + Core OFF */
 	omap3_power_states[OMAP3_STATE_C7].valid = 1;
 	omap3_power_states[OMAP3_STATE_C7].type = OMAP3_STATE_C7;
-	omap3_power_states[OMAP3_STATE_C7].sleep_latency = 10000;
-	omap3_power_states[OMAP3_STATE_C7].wakeup_latency = 30000;
-	omap3_power_states[OMAP3_STATE_C7].threshold = 300000;
+	omap3_power_states[OMAP3_STATE_C7].sleep_latency =
+			cpuidle_params_table[OMAP3_STATE_C7].sleep_latency;
+	omap3_power_states[OMAP3_STATE_C7].wakeup_latency =
+			cpuidle_params_table[OMAP3_STATE_C7].wake_latency;
+	omap3_power_states[OMAP3_STATE_C7].threshold =
+			cpuidle_params_table[OMAP3_STATE_C7].threshold;
 	omap3_power_states[OMAP3_STATE_C7].mpu_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C7].core_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C7].flags = CPUIDLE_FLAG_TIME_VALID |
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 09c0144..58a2671 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -23,6 +23,21 @@ extern int omap3_can_sleep(void);
 extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
 
+struct cpuidle_params {
+	u32 sleep_latency;
+	u32 wake_latency;
+	u32 threshold;
+};
+
+#if defined(CONFIG_PM) && defined(CONFIG_CPU_IDLE)
+extern void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params);
+#else
+static
+inline void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
+{
+}
+#endif
+
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 
-- 
1.6.6
