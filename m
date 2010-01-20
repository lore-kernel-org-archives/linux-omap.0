From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 7/8] OMAP3 PM: Support for Open Switch Retention for Core and MPU power domains in cpuidle path
Date: Wed, 20 Jan 2010 21:00:41 +0530
Message-ID: <1264001442-20078-8-git-send-email-thara@ti.com>
References: <1264001442-20078-1-git-send-email-thara@ti.com>
 <1264001442-20078-2-git-send-email-thara@ti.com>
 <1264001442-20078-3-git-send-email-thara@ti.com>
 <1264001442-20078-4-git-send-email-thara@ti.com>
 <1264001442-20078-5-git-send-email-thara@ti.com>
 <1264001442-20078-6-git-send-email-thara@ti.com>
 <1264001442-20078-7-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46419 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753396Ab0ATPat (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jan 2010 10:30:49 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o0KFUjPe015567
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 20 Jan 2010 09:30:48 -0600
In-Reply-To: <1264001442-20078-7-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>

This patch adds Open SWitch Retention (OSWR) support for
MPU/CORE domains in Cpuidle. In addition to the normal
power domain retention(Closed SWitch retention) in OSWR,
the powerdomain logic is turned OFF. Power domain memory
banks can be chosen to be retained or turned off. In this
implementation both MPU and Core domain memory banks are
turned off during OSWR.
This patch also adds counters ret_logic_off_counter and
ret_mem_off_counter for each power domain. This keeps track
of power domain logic and memory off during powerdomain
retention. These counters together with the retention counter
can be used to find out whether a power domain has entered
OSWR or not. In case of OSWR both the retention counter and
ret_logic_off_counter will get incremented. ret_mem_off_counter
will get incremented if memory bank off during retention
is implemented. In this implementation in case of core or mpu
domain entering OSWR all three flags will be incremented. In
case of normal retention or CSWR only the retention counter
will be incremented

To support this feature two new C states are being added to
the existing C states which makes the new states look like below.

        C1 - MPU WFI + Core active
        C2 - MPU WFI + Core inactive
        C3 - MPU CSWR + Core inactive
        C4 - MPU OFF + Core inactive
        C5 - MPU CSWR + Core CSWR
        C6 - MPU OFF + Core CSWR
        C7 - MPU OSWR + CORE OSWR (New State)
        C8 - MPU OFF + CORE OSWR  (New State)
        C9 - MPU OFF + CORE OFF

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c           |    4 +
 arch/arm/mach-omap2/cpuidle34xx.c             |  129 +++++++++++++++++++++++--
 arch/arm/mach-omap2/pm-debug.c                |    3 +
 arch/arm/mach-omap2/pm34xx.c                  |   55 +++++++++--
 arch/arm/mach-omap2/powerdomain.c             |   13 +++
 arch/arm/mach-omap2/sleep34xx.S               |    4 +
 arch/arm/plat-omap/include/plat/powerdomain.h |    2 +
 7 files changed, 194 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 7d68445..071cf22 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -72,6 +72,10 @@ static struct cpuidle_params omap3_cpuidle_params_table[] = {
 	/* C6 */
 	{1, 3000, 8500, 15000},
 	/* C7 */
+	{1, 4000, 10000, 150000},
+	/* C8 */
+	{1, 8000, 25000, 250000},
+	/* C9 */
 	{1, 10000, 30000, 300000},
 };
 
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 1cfa5a6..419f683 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -36,14 +36,16 @@
 
 #ifdef CONFIG_CPU_IDLE
 
-#define OMAP3_MAX_STATES 7
+#define OMAP3_MAX_STATES 9
 #define OMAP3_STATE_C1 0 /* C1 - MPU WFI + Core active */
 #define OMAP3_STATE_C2 1 /* C2 - MPU WFI + Core inactive */
 #define OMAP3_STATE_C3 2 /* C3 - MPU CSWR + Core inactive */
 #define OMAP3_STATE_C4 3 /* C4 - MPU OFF + Core iactive */
-#define OMAP3_STATE_C5 4 /* C5 - MPU RET + Core RET */
-#define OMAP3_STATE_C6 5 /* C6 - MPU OFF + Core RET */
-#define OMAP3_STATE_C7 6 /* C7 - MPU OFF + Core OFF */
+#define OMAP3_STATE_C5 4 /* C5 - MPU CSWR + Core CSWR */
+#define OMAP3_STATE_C6 5 /* C6 - MPU OFF + Core CSWR */
+#define OMAP3_STATE_C7 6 /* C7 - MPU OSWR + Core OSWR */
+#define OMAP3_STATE_C8 7 /* C8 - MPU OFF + Core OSWR */
+#define OMAP3_STATE_C9 8 /* C9 - MPU OFF + CORE OFF */
 
 struct omap3_processor_cx {
 	u8 valid;
@@ -52,6 +54,11 @@ struct omap3_processor_cx {
 	u32 wakeup_latency;
 	u32 mpu_state;
 	u32 core_state;
+	u32 mpu_logicl1_ret_state;
+	u32 mpu_l2cache_ret_state;
+	u32 core_logic_state;
+	u32 core_mem1_ret_state;
+	u32 core_mem2_ret_state;
 	u32 threshold;
 	u32 flags;
 };
@@ -81,6 +88,10 @@ static struct cpuidle_params cpuidle_params_table[] = {
 	/* C6 */
 	{1, 3000, 8500, 15000},
 	/* C7 */
+	{1, 4000, 10000, 150000},
+	/* C8 */
+	{1, 8000, 25000, 250000},
+	/* C9 */
 	{1, 10000, 30000, 300000},
 };
 
@@ -119,6 +130,11 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	struct omap3_processor_cx *cx = cpuidle_get_statedata(state);
 	struct timespec ts_preidle, ts_postidle, ts_idle;
 	u32 mpu_state = cx->mpu_state, core_state = cx->core_state;
+	u32 mpu_logicl1_ret_state = cx->mpu_logicl1_ret_state;
+	u32 mpu_l2cache_ret_state = cx->mpu_l2cache_ret_state;
+	u32 core_logic_state = cx->core_logic_state;
+	u32 core_mem1_ret_state = cx->core_mem1_ret_state;
+	u32 core_mem2_ret_state = cx->core_mem2_ret_state;
 
 	current_cx_state = *cx;
 
@@ -135,6 +151,20 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 			core_state = PWRDM_POWER_RET;
 	}
 
+	/* For any state above inactive set the logic and memory retention
+	 * bits in case the powerdomain enters retention
+	 */
+	if (mpu_state <= PWRDM_POWER_RET) {
+		pwrdm_set_logic_retst(mpu_pd, mpu_logicl1_ret_state);
+		pwrdm_set_mem_retst(mpu_pd, 0, mpu_l2cache_ret_state);
+	}
+
+	if (core_state <= PWRDM_POWER_RET) {
+		pwrdm_set_logic_retst(core_pd, core_logic_state);
+		pwrdm_set_mem_retst(core_pd, 0, core_mem1_ret_state);
+		pwrdm_set_mem_retst(core_pd, 1, core_mem2_ret_state);
+	}
+
 	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
 	pwrdm_set_next_pwrst(core_pd, core_state);
 
@@ -217,7 +247,7 @@ void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
  *	C3 . MPU CSWR + Core inactive
  *	C4 . MPU OFF + Core inactive
  *	C5 . MPU CSWR + Core CSWR
- *	C6 . MPU OFF + Core CSWR
+ *	C6 . MPU OFF + Core OSWR
  *	C7 . MPU OFF + Core OFF
  */
 void omap_init_power_states(void)
@@ -262,6 +292,10 @@ void omap_init_power_states(void)
 			cpuidle_params_table[OMAP3_STATE_C3].threshold;
 	omap3_power_states[OMAP3_STATE_C3].mpu_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C3].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C3].mpu_logicl1_ret_state =
+				PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C3].mpu_l2cache_ret_state =
+				PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C3].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
 
@@ -277,6 +311,10 @@ void omap_init_power_states(void)
 			cpuidle_params_table[OMAP3_STATE_C4].threshold;
 	omap3_power_states[OMAP3_STATE_C4].mpu_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C4].core_state = PWRDM_POWER_ON;
+	omap3_power_states[OMAP3_STATE_C4].mpu_logicl1_ret_state =
+				PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C4].mpu_l2cache_ret_state =
+				PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C4].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
 
@@ -292,6 +330,15 @@ void omap_init_power_states(void)
 			cpuidle_params_table[OMAP3_STATE_C5].threshold;
 	omap3_power_states[OMAP3_STATE_C5].mpu_state = PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C5].core_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C5].mpu_logicl1_ret_state =
+				PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C5].mpu_l2cache_ret_state =
+				PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C5].core_logic_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C5].core_mem1_ret_state =
+				PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C5].core_mem2_ret_state =
+				PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C5].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
 
@@ -307,10 +354,19 @@ void omap_init_power_states(void)
 			cpuidle_params_table[OMAP3_STATE_C6].threshold;
 	omap3_power_states[OMAP3_STATE_C6].mpu_state = PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C6].core_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C6].mpu_logicl1_ret_state =
+				PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C6].mpu_l2cache_ret_state =
+				PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C6].core_logic_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C6].core_mem1_ret_state =
+				PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C6].core_mem2_ret_state =
+				PWRDM_POWER_RET;
 	omap3_power_states[OMAP3_STATE_C6].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
 
-	/* C7 . MPU OFF + Core OFF */
+	/* C7 . MPU OSWR + Core OSWR */
 	omap3_power_states[OMAP3_STATE_C7].valid =
 			cpuidle_params_table[OMAP3_STATE_C7].valid;
 	omap3_power_states[OMAP3_STATE_C7].type = OMAP3_STATE_C7;
@@ -320,10 +376,67 @@ void omap_init_power_states(void)
 			cpuidle_params_table[OMAP3_STATE_C7].wake_latency;
 	omap3_power_states[OMAP3_STATE_C7].threshold =
 			cpuidle_params_table[OMAP3_STATE_C7].threshold;
-	omap3_power_states[OMAP3_STATE_C7].mpu_state = PWRDM_POWER_OFF;
-	omap3_power_states[OMAP3_STATE_C7].core_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C7].mpu_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C7].core_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C7].mpu_logicl1_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C7].mpu_l2cache_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C7].core_logic_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C7].core_mem1_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C7].core_mem2_ret_state =
+				PWRDM_POWER_OFF;
 	omap3_power_states[OMAP3_STATE_C7].flags = CPUIDLE_FLAG_TIME_VALID |
 				CPUIDLE_FLAG_CHECK_BM;
+
+	/* C8 . MPU OFF + Core OSWR */
+	omap3_power_states[OMAP3_STATE_C8].valid =
+			cpuidle_params_table[OMAP3_STATE_C8].valid;
+	omap3_power_states[OMAP3_STATE_C8].type = OMAP3_STATE_C8;
+	omap3_power_states[OMAP3_STATE_C8].sleep_latency =
+			cpuidle_params_table[OMAP3_STATE_C8].sleep_latency;
+	omap3_power_states[OMAP3_STATE_C8].wakeup_latency =
+			cpuidle_params_table[OMAP3_STATE_C8].wake_latency;
+	omap3_power_states[OMAP3_STATE_C8].threshold =
+			cpuidle_params_table[OMAP3_STATE_C8].threshold;
+	omap3_power_states[OMAP3_STATE_C8].mpu_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C8].core_state = PWRDM_POWER_RET;
+	omap3_power_states[OMAP3_STATE_C8].mpu_logicl1_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C8].mpu_l2cache_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C8].core_logic_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C8].core_mem1_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C8].core_mem2_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C8].flags = CPUIDLE_FLAG_TIME_VALID |
+				CPUIDLE_FLAG_CHECK_BM;
+
+	/* C9 . MPU OFF + Core OFF */
+	omap3_power_states[OMAP3_STATE_C9].valid =
+			cpuidle_params_table[OMAP3_STATE_C9].valid;
+	omap3_power_states[OMAP3_STATE_C9].type = OMAP3_STATE_C9;
+	omap3_power_states[OMAP3_STATE_C9].sleep_latency =
+			cpuidle_params_table[OMAP3_STATE_C9].sleep_latency;
+	omap3_power_states[OMAP3_STATE_C9].wakeup_latency =
+			cpuidle_params_table[OMAP3_STATE_C9].wake_latency;
+	omap3_power_states[OMAP3_STATE_C9].threshold =
+			cpuidle_params_table[OMAP3_STATE_C9].threshold;
+	omap3_power_states[OMAP3_STATE_C9].mpu_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C9].core_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C9].mpu_logicl1_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C9].mpu_l2cache_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C9].core_logic_state = PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C9].core_mem1_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C9].core_mem2_ret_state =
+				PWRDM_POWER_OFF;
+	omap3_power_states[OMAP3_STATE_C9].flags = CPUIDLE_FLAG_TIME_VALID |
+				CPUIDLE_FLAG_CHECK_BM;
 }
 
 struct cpuidle_driver omap3_idle_driver = {
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 85a8c6e..035cfa7 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -385,6 +385,9 @@ static int pwrdm_dbg_show_counter(struct powerdomain *pwrdm, void *user)
 	for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
 		seq_printf(s, ",%s:%d", pwrdm_state_names[i],
 			pwrdm->state_counter[i]);
+	seq_printf(s, ",RET-LOGIC-OFF:%d,RET-MEM-OFF:%d",
+			pwrdm->ret_logic_off_counter,
+			pwrdm->ret_mem_off_counter);
 
 	seq_printf(s, "\n");
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 6e6d954..bfdcac2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -384,7 +384,8 @@ void omap_sram_idle(void)
 	int mpu_next_state = PWRDM_POWER_ON;
 	int per_next_state = PWRDM_POWER_ON;
 	int core_next_state = PWRDM_POWER_ON;
-	int core_prev_state, per_prev_state;
+	int mpu_prev_state, core_prev_state, per_prev_state;
+	int mpu_logic_state, mpu_mem_state, core_logic_state;
 	u32 sdrc_pwr = 0;
 	int per_state_modified = 0;
 
@@ -397,12 +398,25 @@ void omap_sram_idle(void)
 	pwrdm_clear_all_prev_pwrst(per_pwrdm);
 
 	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
+	mpu_logic_state = pwrdm_read_next_logic_pwrst(mpu_pwrdm);
+	mpu_mem_state = pwrdm_read_next_mem_pwrst(mpu_pwrdm, 0);
+
 	switch (mpu_next_state) {
 	case PWRDM_POWER_ON:
-	case PWRDM_POWER_RET:
 		/* No need to save context */
 		save_state = 0;
 		break;
+	case PWRDM_POWER_RET:
+		if (!mpu_logic_state && !mpu_mem_state)
+			save_state = 3;
+		else if (!mpu_mem_state)
+			save_state = 2;
+		else if (!mpu_logic_state)
+			save_state = 1;
+		else
+			/* No need to save context */
+			save_state = 0;
+		break;
 	case PWRDM_POWER_OFF:
 		save_state = 3;
 		break;
@@ -421,6 +435,8 @@ void omap_sram_idle(void)
 	/* PER */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
+	core_logic_state = pwrdm_read_next_logic_pwrst(core_pwrdm);
+
 	if (per_next_state < PWRDM_POWER_ON) {
 		omap2_gpio_prepare_for_idle(per_next_state);
 		if (per_next_state == PWRDM_POWER_OFF) {
@@ -448,8 +464,8 @@ void omap_sram_idle(void)
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
-		omap_uart_prepare_idle(0, core_next_state);
-		omap_uart_prepare_idle(1, core_next_state);
+		omap_uart_prepare_idle(0, core_next_state & core_logic_state);
+		omap_uart_prepare_idle(1, core_next_state & core_logic_state);
 		if (core_next_state == PWRDM_POWER_OFF) {
 			u32 voltctrl = OMAP3430_AUTO_OFF;
 
@@ -460,6 +476,20 @@ void omap_sram_idle(void)
 					     OMAP3_PRM_VOLTCTRL_OFFSET);
 			omap3_core_save_context(PWRDM_POWER_OFF);
 			omap3_prcm_save_context();
+		} else if ((core_next_state == PWRDM_POWER_RET) &&
+				(core_logic_state == PWRDM_POWER_OFF)) {
+			/* Disable DPLL4 autoidle bit so that register
+			 * contents match with that stored in the
+			 * scratchpad. If this is not done rom code
+			 * enters into some wrong path while coming
+			 * out of coreOSWR and causes a crash.
+			 */
+			cm_rmw_mod_reg_bits(OMAP3430_AUTO_PERIPH_DPLL_MASK,
+						0x0, PLL_MOD, CM_AUTOIDLE);
+			omap3_core_save_context(PWRDM_POWER_RET);
+			prm_set_mod_reg_bits(OMAP3430_AUTO_RET,
+						OMAP3430_GR_MOD,
+						OMAP3_PRM_VOLTCTRL_OFFSET);
 		} else if (core_next_state == PWRDM_POWER_RET) {
 			prm_set_mod_reg_bits(OMAP3430_AUTO_RET,
 						OMAP3430_GR_MOD,
@@ -502,18 +532,27 @@ void omap_sram_idle(void)
 	    core_next_state == PWRDM_POWER_OFF)
 		sdrc_write_reg(sdrc_pwr, SDRC_POWER);
 
+	mpu_prev_state = pwrdm_read_prev_pwrst(mpu_pwrdm);
 	/* Restore table entry modified during MMU restoration */
-	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == PWRDM_POWER_OFF)
+	if (((mpu_prev_state == PWRDM_POWER_RET) &&
+			(pwrdm_read_prev_logic_pwrst(mpu_pwrdm) ==
+			 PWRDM_POWER_OFF)) || (mpu_prev_state ==
+			 PWRDM_POWER_OFF))
 		restore_table_entry();
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
 		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
-		if (core_prev_state == PWRDM_POWER_OFF) {
+		if ((core_prev_state == PWRDM_POWER_OFF) ||
+				(core_prev_state == PWRDM_POWER_RET &&
+				pwrdm_read_prev_logic_pwrst(core_pwrdm) ==
+				PWRDM_POWER_OFF)) {
 			omap3_core_restore_context(core_prev_state);
-			omap3_prcm_restore_context();
+			if (core_prev_state == PWRDM_POWER_OFF) {
+				omap3_prcm_restore_context();
+				omap2_sms_restore_context();
+			}
 			omap3_sram_restore_context();
-			omap2_sms_restore_context();
 			/*
 			 * Errata 1.164 fix : OTG autoidle can prevent
 			 * sleep
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 06bf290..ef9f1bb 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -126,6 +126,16 @@ static int _pwrdm_state_switch(struct powerdomain *pwrdm, int flag)
 		prev = pwrdm_read_prev_pwrst(pwrdm);
 		if (pwrdm->state != prev)
 			pwrdm->state_counter[prev]++;
+		if (prev == PWRDM_POWER_RET) {
+			if ((pwrdm->pwrsts_logic_ret == PWRSTS_OFF_RET) &&
+					(pwrdm_read_prev_logic_pwrst(pwrdm) ==
+					 PWRDM_POWER_OFF))
+				pwrdm->ret_logic_off_counter++;
+			if ((pwrdm->pwrsts_mem_ret[0] == PWRSTS_OFF_RET) &&
+					(pwrdm_read_prev_mem_pwrst(pwrdm, 0) ==
+					PWRDM_POWER_OFF))
+				pwrdm->ret_mem_off_counter++;
+		}
 		break;
 	default:
 		return -EINVAL;
@@ -161,6 +171,9 @@ static __init void _pwrdm_setup(struct powerdomain *pwrdm)
 	for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
 		pwrdm->state_counter[i] = 0;
 
+	pwrdm->ret_logic_off_counter = 0;
+	pwrdm->ret_mem_off_counter = 0;
+
 	pwrdm_wait_transition(pwrdm);
 	pwrdm->state = pwrdm_read_pwrst(pwrdm);
 	pwrdm->state_counter[pwrdm->state] = 1;
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 69521be..1d88ef3 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -256,8 +256,12 @@ restore:
 	and     r2, r2, #0x3
 	cmp     r2, #0x0	@ Check if target power state was OFF or RET
         moveq   r9, #0x3        @ MPU OFF => L1 and L2 lost
+	beq	restore_from_off
+	cmp	r2, #0x1
+	moveq	r9, #0x3
 	movne	r9, #0x1	@ Only L1 and L2 lost => avoid L2 invalidation
 	bne	logic_l1_restore
+restore_from_off:
 	ldr	r0, control_stat
 	ldr	r1, [r0]
 	and	r1, #0x700
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index 7576559..405ccd6 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -124,6 +124,8 @@ struct powerdomain {
 
 	int state;
 	unsigned state_counter[PWRDM_MAX_PWRSTS];
+	unsigned ret_logic_off_counter;
+	unsigned ret_mem_off_counter;
 
 #ifdef CONFIG_PM_DEBUG
 	s64 timer;
-- 
1.5.6.3

