From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 3/3] OMAP3: PM: Configure CPUidle latencies/thresholds from board files
Date: Mon, 12 Oct 2009 19:12:40 +0530
Message-ID: <1255354960-7873-3-git-send-email-rnayak@ti.com>
References: <1255354960-7873-1-git-send-email-rnayak@ti.com>
 <1255354960-7873-2-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50191 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756623AbZJLNnW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Oct 2009 09:43:22 -0400
In-Reply-To: <1255354960-7873-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, Rajendra Nayak <rnayak@ti.com>

The CPUidle C state latencies and thresholds are dependent
on various board specific details.
Hence this patch makes it possible to configure these values from the
respective board files.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c     |   21 ++++++-
 arch/arm/mach-omap2/board-apollon.c     |    2 +-
 arch/arm/mach-omap2/board-generic.c     |    2 +-
 arch/arm/mach-omap2/board-h4.c          |    2 +-
 arch/arm/mach-omap2/board-ldp.c         |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c    |    2 +-
 arch/arm/mach-omap2/board-overo.c       |    2 +-
 arch/arm/mach-omap2/board-rx51.c        |    2 +-
 arch/arm/mach-omap2/board-zoom2.c       |    2 +-
 arch/arm/mach-omap2/cpuidle34xx.c       |  105 ++++++++++++++++++++++++------
 arch/arm/mach-omap2/pm.h                |   12 +++-
 arch/arm/mach-omap2/pm34xx.c            |    4 +-
 13 files changed, 126 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 0f4ffb2..fb0cd4c 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -73,6 +73,24 @@ static struct prm_setup_vc omap3_setuptime_table = {
 	.vdd1_off = 0x00,
 };
 
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
@@ -203,7 +221,8 @@ static void __init omap_3430sdp_init_irq(void)
 	omap_board_config = sdp3430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
 	omap3_pm_early_init(omap3_mpu_rate_table, omap3_dsp_rate_table,
-				 omap3_l3_rate_table, &omap3_setuptime_table);
+			    omap3_l3_rate_table, &omap3_setuptime_table,
+			    omap3_cpuidle_params_table);
 	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index c6014d7..c847718 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -267,7 +267,7 @@ static void __init omap_apollon_init_irq(void)
 {
 	omap_board_config = apollon_config;
 	omap_board_config_size = ARRAY_SIZE(apollon_config);
-	omap3_pm_early_init(NULL, NULL, NULL, NULL);
+	omap3_pm_early_init(NULL, NULL, NULL, NULL, NULL);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 20f6dfe..3053768 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -38,7 +38,7 @@ static void __init omap_generic_init_irq(void)
 {
 	omap_board_config = generic_config;
 	omap_board_config_size = ARRAY_SIZE(generic_config);
-	omap3_pm_early_init(NULL, NULL, NULL, NULL);
+	omap3_pm_early_init(NULL, NULL, NULL, NULL, NULL);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 }
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 2757b16..d6fc5f0 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -313,7 +313,7 @@ static void __init omap_h4_init_irq(void)
 {
 	omap_board_config = h4_config;
 	omap_board_config_size = ARRAY_SIZE(h4_config);
-	omap3_pm_early_init(NULL, NULL, NULL, NULL)
+	omap3_pm_early_init(NULL, NULL, NULL, NULL, NULL)
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 21fae1a..dc5ce14 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -289,7 +289,7 @@ static void __init omap_ldp_init_irq(void)
 {
 	omap_board_config = ldp_config;
 	omap_board_config_size = ARRAY_SIZE(ldp_config);
-	omap3_pm_early_init(NULL, NULL, NULL, NULL);
+	omap3_pm_early_init(NULL, NULL, NULL, NULL, NULL);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 056c086..4856028 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -352,7 +352,7 @@ static void __init omap3_beagle_init_irq(void)
 	omap_board_config = omap3_beagle_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
 	omap3_pm_early_init(omap3_mpu_rate_table, omap3_dsp_rate_table,
-				omap3_l3_rate_table, NULL);
+			    omap3_l3_rate_table, NULL, NULL);
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index d1328dd..bb98748 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -291,7 +291,7 @@ static void __init omap3_evm_init_irq(void)
 	omap_board_config = omap3_evm_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
 	omap3_pm_early_init(omap3_mpu_rate_table, omap3_dsp_rate_table,
-				omap3_l3_rate_table, NULL);
+			    omap3_l3_rate_table, NULL, NULL);
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 68bb994..a560a56 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -375,7 +375,7 @@ static void __init overo_init_irq(void)
 {
 	omap_board_config = overo_config;
 	omap_board_config_size = ARRAY_SIZE(overo_config);
-	omap3_pm_early_init(NULL, NULL, NULL, NULL);
+	omap3_pm_early_init(NULL, NULL, NULL, NULL, NULL);
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index ea51c21..23553b7 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -87,7 +87,7 @@ static void __init rx51_init_irq(void)
 	omap_board_config = rx51_config;
 	omap_board_config_size = ARRAY_SIZE(rx51_config);
 	omap3_pm_early_init(omap3_mpu_rate_table, omap3_dsp_rate_table,
-				omap3_l3_rate_table, NULL);
+			    omap3_l3_rate_table, NULL, NULL);
 	omap2_init_common_hw(rx51_get_sdram_timings(),
 			     rx51_get_sdram_timings());
 	omap_init_irq();
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 270f788..6d14406 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -216,7 +216,7 @@ static void __init omap_zoom2_init_irq(void)
 	omap_board_config = zoom2_config;
 	omap_board_config_size = ARRAY_SIZE(zoom2_config);
 	omap3_pm_early_init(omap3_mpu_rate_table, omap3_dsp_rate_table,
-				omap3_l3_rate_table, NULL);
+			    omap3_l3_rate_table, NULL, NULL);
 	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index c44a942..ea0917d 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -60,6 +60,30 @@ struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
 struct omap3_processor_cx current_cx_state;
 struct powerdomain *mpu_pd, *core_pd, *per_pd;
 
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
@@ -165,6 +189,24 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 
 DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
 
+void omap3_set_idle_params(struct cpuidle_params *cpuidle_board_params)
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
@@ -181,9 +223,12 @@ void omap_init_power_states(void)
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
@@ -191,9 +236,12 @@ void omap_init_power_states(void)
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
@@ -201,9 +249,12 @@ void omap_init_power_states(void)
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
@@ -212,9 +263,12 @@ void omap_init_power_states(void)
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
@@ -223,9 +277,12 @@ void omap_init_power_states(void)
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
@@ -234,9 +291,12 @@ void omap_init_power_states(void)
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
@@ -245,9 +305,12 @@ void omap_init_power_states(void)
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
index 3330d7b..83dd31a 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -41,8 +41,15 @@ struct prm_setup_vc {
 	u16 vdd1_ret;
 	u16 vdd1_off;
 };
-extern void omap3_set_prm_setup_vc(struct prm_setup_vc *setup_vc);
 
+struct cpuidle_params {
+	u32 sleep_latency;
+	u32 wake_latency;
+	u32 threshold;
+};
+
+extern void omap3_set_prm_setup_vc(struct prm_setup_vc *setup_vc);
+extern void omap3_set_idle_params(struct cpuidle_params *cpuidle_board_params);
 extern int resource_set_opp_level(int res, u32 target_level, int flags);
 extern int resource_access_opp_lock(int res, int delta);
 #define resource_lock_opp(res) resource_access_opp_lock(res, 1)
@@ -87,5 +94,6 @@ extern unsigned int omap34xx_cpu_suspend_sz;
 void omap3_pm_early_init(struct omap_opp *mpu_opps,
 			 struct omap_opp *dsp_opps,
 			 struct omap_opp *l3_opps,
-			 struct prm_setup_vc *setup_times);
+			 struct prm_setup_vc *setup_times,
+			 struct cpuidle_params *idle_params);
 #endif
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 6f2fb51..5b8d948 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -1289,7 +1289,8 @@ static void __init configure_vc(void)
 void omap3_pm_early_init(struct omap_opp *mpu_opps,
 			 struct omap_opp *dsp_opps,
 			 struct omap_opp *l3_opps,
-			 struct prm_setup_vc *setup_times)
+			 struct prm_setup_vc *setup_times,
+			 struct cpuidle_params *idle_params)
 {
 	prm_clear_mod_reg_bits(OMAP3430_OFFMODE_POL, OMAP3430_GR_MOD,
 				OMAP3_PRM_POLCTRL_OFFSET);
@@ -1297,6 +1298,7 @@ void omap3_pm_early_init(struct omap_opp *mpu_opps,
 	configure_vc();
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
 	omap3_set_prm_setup_vc(setup_times);
+	omap3_set_idle_params(idle_params);
 
 	return;
 }
-- 
1.5.4.7

