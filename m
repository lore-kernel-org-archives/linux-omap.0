From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/2] OMAP3: PM: Configure CPUidle latencies/thresholds from board files
Date: Mon, 29 Jun 2009 20:05:13 +0530
Message-ID: <1246286113-21197-2-git-send-email-rnayak@ti.com>
References: <1246286113-21197-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55016 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601AbZF2OfT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Jun 2009 10:35:19 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5TEZGL9020019
	for <linux-omap@vger.kernel.org>; Mon, 29 Jun 2009 09:35:21 -0500
In-Reply-To: <1246286113-21197-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

The CPUidle C state latencies and thresholds are dependent
on various board specific details.
Hence this patch makes it possible to configure these values from the
respective board files.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c     |   22 ++++++-
 arch/arm/mach-omap2/board-apollon.c     |    2 +-
 arch/arm/mach-omap2/board-generic.c     |    2 +-
 arch/arm/mach-omap2/board-h4.c          |    2 +-
 arch/arm/mach-omap2/board-ldp.c         |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c    |    2 +-
 arch/arm/mach-omap2/board-overo.c       |    3 +-
 arch/arm/mach-omap2/board-rx51.c        |    2 +-
 arch/arm/mach-omap2/board-zoom2.c       |    2 +-
 arch/arm/mach-omap2/cpuidle34xx.c       |  105 ++++++++++++++++++++++++------
 arch/arm/mach-omap2/io.c                |    5 +-
 arch/arm/mach-omap2/pm.c                |    7 ++-
 arch/arm/mach-omap2/pm.h                |   12 +++-
 arch/arm/plat-omap/include/mach/io.h    |    4 +-
 15 files changed, 136 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index b43cf94..750d841 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -75,6 +75,24 @@ static struct prm_setup_vc omap3_setuptime_table = {
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
 static int sdp3430_keymap[] = {
 	KEY(0, 0, KEY_LEFT),
 	KEY(0, 1, KEY_RIGHT),
@@ -191,8 +209,8 @@ static struct platform_device *sdp3430_devices[] __initdata = {
 static void __init omap_3430sdp_init_irq(void)
 {
 	omap2_init_common_hw(hyb18m512160af6_sdrc_params, omap3_mpu_rate_table,
-			     omap3_dsp_rate_table, omap3_l3_rate_table,
-			     &omap3_setuptime_table);
+			omap3_dsp_rate_table, omap3_l3_rate_table,
+			&omap3_setuptime_table, omap3_cpuidle_params_table);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 293a9b2..fe625a9 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -250,7 +250,7 @@ out:
 
 static void __init omap_apollon_init_irq(void)
 {
-	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
+	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	apollon_init_smc91x();
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index dfc1b49..ecf2c45 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -33,7 +33,7 @@
 
 static void __init omap_generic_init_irq(void)
 {
-	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
+	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL, NULL);
 	omap_init_irq();
 }
 
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index af0ebaf..365bc69 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -270,7 +270,7 @@ static void __init h4_init_flash(void)
 
 static void __init omap_h4_init_irq(void)
 {
-	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
+	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	h4_init_flash();
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index eb5e2e0..1265a12 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -270,7 +270,7 @@ static inline void __init ldp_init_smsc911x(void)
 
 static void __init omap_ldp_init_irq(void)
 {
-	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
+	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	ldp_init_smsc911x();
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index e0be6bd..da1f3f6 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -289,7 +289,7 @@ static int __init omap3_beagle_i2c_init(void)
 static void __init omap3_beagle_init_irq(void)
 {
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, omap3_mpu_rate_table,
-			     omap3_dsp_rate_table, omap3_l3_rate_table, NULL);
+			omap3_dsp_rate_table, omap3_l3_rate_table, NULL, NULL);
 	omap_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index eaab39b..4a287b9 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -284,7 +284,7 @@ struct spi_board_info omap3evm_spi_board_info[] = {
 static void __init omap3_evm_init_irq(void)
 {
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, omap3_mpu_rate_table,
-			omap3_dsp_rate_table, omap3_l3_rate_table, NULL);
+			omap3_dsp_rate_table, omap3_l3_rate_table, NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	omap3evm_init_smc911x();
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index f159e18..a673921 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -360,7 +360,8 @@ static int __init overo_i2c_init(void)
 
 static void __init overo_init_irq(void)
 {
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL, NULL, NULL, NULL);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
+				 NULL, NULL, NULL, NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 3629a0e..6cb8715 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -66,7 +66,7 @@ static struct omap_board_config_kernel rx51_config[] = {
 static void __init rx51_init_irq(void)
 {
 	omap2_init_common_hw(rx51_get_sdram_timings(), omap3_mpu_rate_table,
-			     omap3_dsp_rate_table, omap3_l3_rate_table, NULL);
+		omap3_dsp_rate_table, omap3_l3_rate_table, NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index e63bfa0..0fcd0ff 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -27,7 +27,7 @@
 static void __init omap_zoom2_init_irq(void)
 {
 	omap2_init_common_hw(NULL, omap3_mpu_rate_table,
-			omap3_dsp_rate_table, omap3_l3_rate_table, NULL);
+			omap3_dsp_rate_table, omap3_l3_rate_table, NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 7bbec90..3d6c55a 100644
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
+					cpuidle_board_params[i].sleep_latency;
+		cpuidle_params_table[i].wake_latency =
+					cpuidle_board_params[i].wake_latency;
+		cpuidle_params_table[i].threshold =
+					cpuidle_board_params[i].threshold;
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
+			cpuidle_params_table[OMAP3_STATE_C2].sleep_latency;;
+	omap3_power_states[OMAP3_STATE_C2].wakeup_latency =
+			cpuidle_params_table[OMAP3_STATE_C2].wake_latency;;
+	omap3_power_states[OMAP3_STATE_C2].threshold =
+			cpuidle_params_table[OMAP3_STATE_C2].threshold;;
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
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 266a5a1..d8d10aa 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -283,13 +283,14 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sp,
 				 struct omap_opp *mpu_opps,
 				 struct omap_opp *dsp_opps,
 				 struct omap_opp *l3_opps,
-				 struct prm_setup_vc *setup_times)
+				 struct prm_setup_vc *setup_times,
+				 struct cpuidle_params *idle_params)
 {
 	omap2_mux_init();
 #ifndef CONFIG_ARCH_OMAP4 /* FIXME: Remove this once the clkdev is ready */
 	/* The OPP tables have to be registered before a clk init */
 	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
-	omap_pm_early_init(setup_times);
+	omap_pm_early_init(setup_times, idle_params);
 	pwrdm_init(powerdomains_omap);
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omapdev_init(omapdevs);
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index b81ba3b..5c5c59e 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -236,10 +236,13 @@ unsigned get_last_off_on_transaction_id(struct device *dev)
 	return 0;
 }
 
-void __init omap_pm_early_init(struct prm_setup_vc *setup_times)
+void __init omap_pm_early_init(struct prm_setup_vc *setup_times,
+					struct cpuidle_params *idle_params)
 {
-	if (cpu_is_omap34xx())
+	if (cpu_is_omap34xx()) {
 		omap3_set_prm_setup_vc(setup_times);
+		omap3_set_idle_params(idle_params);
+	}
 	return;
 }
 
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 0beb32d..8759053 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -31,6 +31,12 @@ struct prm_setup_vc {
 	u16 vdd1_off;
 };
 
+struct cpuidle_params {
+	u32 sleep_latency;
+	u32 wake_latency;
+	u32 threshold;
+};
+
 #ifdef CONFIG_ARCH_OMAP3
 extern unsigned short enable_dyn_sleep;
 extern unsigned short enable_off_mode;
@@ -43,6 +49,7 @@ extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 extern void omap3_set_prm_setup_vc(struct prm_setup_vc *setup_vc);
+extern void omap3_set_idle_params(struct cpuidle_params *cpuidle_board_params);
 #ifdef CONFIG_CPU_IDLE
 int omap3_idle_init(void);
 #else
@@ -51,8 +58,10 @@ static inline int omap3_idle_init(void) { return 0; }
 
 #else /* CONFIG_ARCH_OMAP3 */
 #define omap3_set_prm_setup_vc(setup_vc) do {} while (0);
+#define omap3_set_idle_params(parmas, board_params) do {} while (0);
 
 #endif /* CONFIG_ARCH_OMAP3 */
+
 extern int resource_set_opp_level(int res, u32 target_level, int flags);
 extern int resource_access_opp_lock(int res, int delta);
 #define resource_lock_opp(res) resource_access_opp_lock(res, 1)
@@ -91,6 +100,7 @@ extern unsigned int omap34xx_suspend_sz;
 extern unsigned int save_secure_ram_context_sz;
 extern unsigned int omap24xx_cpu_suspend_sz;
 extern unsigned int omap34xx_cpu_suspend_sz;
-void __init omap_pm_early_init(struct prm_setup_vc *setup_times);
+void __init omap_pm_early_init(struct prm_setup_vc *setup_times,
+					struct cpuidle_params *idle_params);
 
 #endif
diff --git a/arch/arm/plat-omap/include/mach/io.h b/arch/arm/plat-omap/include/mach/io.h
index 3582bef..d143bd9 100644
--- a/arch/arm/plat-omap/include/mach/io.h
+++ b/arch/arm/plat-omap/include/mach/io.h
@@ -225,6 +225,7 @@
 struct omap_sdrc_params;
 struct omap_opp;
 struct prm_setup_vc;
+struct cpuidle_params;
 
 extern void omap1_map_common_io(void);
 extern void omap1_init_common_hw(void);
@@ -234,7 +235,8 @@ extern void omap2_init_common_hw(struct omap_sdrc_params *sp,
 				 struct omap_opp *mpu_opps,
 				 struct omap_opp *dsp_opps,
 				 struct omap_opp *l3_opps,
-				 struct prm_setup_vc *setup_times);
+				 struct prm_setup_vc *setup_times,
+				 struct cpuidle_params *idle_params);
 
 #define __arch_ioremap(p,s,t)	omap_ioremap(p,s,t)
 #define __arch_iounmap(v)	omap_iounmap(v)
-- 
1.5.4.7

