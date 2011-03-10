From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 16/19] OMAP4: cpuidle: Add MPUSS RET OFF states
Date: Thu, 10 Mar 2011 19:38:12 +0530
Message-ID: <1299766095-23879-17-git-send-email-santosh.shilimkar@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53988 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541Ab1CJOIe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 09:08:34 -0500
In-Reply-To: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds MPUSS low power states in cpuidle.

	C1 - CPU0 ON + CPU1 ON + MPU ON
	C2 - CPU0 ON + CPU1 OFF + MPU ON
	C3 - CPU0 OFF + CPU1 OFF + MPU CSWR
	C4 - CPU0 OFF + CPU1 OFF + MPU OFF

MPU OSWR isn't supported yet. To support OSWR, power domain context
registers needs to be managed which are not supported yet. A patch
to address this was submitted but it's not ready for merge yet because
it was not addressing all OMAP4 power domain context registers.
More info on this issue:
	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg38667.html

OMAP4 powerdomain INACTIVE support is also dropped because of inconsistency
of it with OMAP3. More information  on this thread.
	http://www.spinics.net/lists/linux-omap/msg45370.html

CORE low power states and associated latencies will be updated as part
along with chip retention support.

On OMAP4 because of hardware constraints, no low power states are
targeted when both CPUs are online and in SMP mode. The low power
states are attempted only when secondary CPU gets offline to OFF
through hotplug infrastructure.

Thanks to Nicole Chalhoub <n-chalhoub@ti.com> for doing exhaustive
C-state latency profiling.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |  129 +++++++++++++++++++++++++++++++++++--
 1 files changed, 124 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 270404f..19a405c 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2011 Texas Instruments, Inc.
  * Rajendra Nayak <rnayak@ti.com>
+ * Santosh Shilimkar <santosh.shilimkar@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -17,12 +18,20 @@
 #include <mach/omap4-common.h>
 
 #include "pm.h"
+#include "prm.h"
 
 #ifdef CONFIG_CPU_IDLE
 
-#define OMAP4_MAX_STATES	1
+#define OMAP4_MAX_STATES	4
+
 /* C1 - CPU0 ON + + CPU1 ON + MPU ON + CORE ON */
 #define OMAP4_STATE_C1		0
+/* C2 - CPU0 ON + CPU1 OFF + MPU ON + CORE ON */
+#define OMAP4_STATE_C2		1
+/* C3 - CPU0 OFF + CPU1 OFF + MPU CSWR + CORE ON */
+#define OMAP4_STATE_C3		2
+/* C4 - CPU0 OFF + CPU1 OFF + MPU OFF + CORE ON */
+#define OMAP4_STATE_C4		3
 
 struct omap4_processor_cx {
 	u8 valid;
@@ -31,16 +40,34 @@ struct omap4_processor_cx {
 	u32 wakeup_latency;
 	u32 cpu0_state;
 	u32 mpu_state;
+	u32 mpu_logic_state;
 	u32 core_state;
+	u32 core_logic_state;
 	u32 threshold;
 	u32 flags;
+	const char *desc;
 };
 
 struct omap4_processor_cx omap4_power_states[OMAP4_MAX_STATES];
+static struct powerdomain *mpu_pd, *cpu1_pd, *core_pd;
 
+/*
+ * FIXME: Full latency numbers needs to be updated as part of
+ * cpuidle CORE retention support.
+ * Currently only MPUSS latency numbers are added based on
+ * measurements done internally. The numbers for MPUSS are
+ * not board dependent and hence set directly here instead of
+ * passing it from board files.
+ */
 static struct cpuidle_params cpuidle_params_table[] = {
-	/* C1 */
-	{1, 2, 2, 5},
+	/* C1 - CPU0 ON + CPU1 ON + MPU ON  + CORE ON */
+	{1,	2,	2,	5},
+	/* C2 - CPU0 ON + CPU1 OFF + MPU ON  + CORE ON */
+	{1,	140,	160,	300},
+	/* C3 - CPU0 OFF + CPU1 OFF + MPU CSWR + CORE ON */
+	{1,	200,	300,	700},
+	/* C4 - CPU0 OFF + CPU1 OFF + MPU OFF + CORE ON */
+	{1,	1400,	600,	5000},
 };
 
 /**
@@ -55,7 +82,9 @@ static struct cpuidle_params cpuidle_params_table[] = {
 static int omap4_enter_idle(struct cpuidle_device *dev,
 			struct cpuidle_state *state)
 {
+	struct omap4_processor_cx *cx = cpuidle_get_statedata(state);
 	struct timespec ts_preidle, ts_postidle, ts_idle;
+	u32 cpu1_state;
 
 	/* Used to keep track of the total time in idle */
 	getnstimeofday(&ts_preidle);
@@ -63,7 +92,26 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	local_irq_disable();
 	local_fiq_disable();
 
-	cpu_do_idle();
+	/*
+	 * Continue to do only WFI on CPU0 till CPU1 hits OFF state.
+	 * This is necessary to honour hardware recommondation
+	 * of triggeing all the possible low power modes once CPU1 is
+	 * out of coherency and in OFF mode.
+	 * Update dev->last_state so that governor stats reflects right
+	 * data.
+	 */
+	cpu1_state = pwrdm_read_pwrst(cpu1_pd);
+	if ((cpu1_state != PWRDM_POWER_OFF) || (!cx->valid)) {
+		dev->last_state = dev->safe_state;
+		cx = cpuidle_get_statedata(dev->safe_state);
+	}
+
+	pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
+	omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
+	pwrdm_set_logic_retst(core_pd, cx->core_logic_state);
+	omap_set_pwrdm_state(core_pd, cx->core_state);
+
+	omap4_enter_lowpower(dev->cpu, cx->cpu0_state);
 
 	getnstimeofday(&ts_postidle);
 	ts_idle = timespec_sub(ts_postidle, ts_preidle);
@@ -96,9 +144,73 @@ void omap4_init_power_states(void)
 			cpuidle_params_table[OMAP4_STATE_C1].wake_latency;
 	omap4_power_states[OMAP4_STATE_C1].threshold =
 			cpuidle_params_table[OMAP4_STATE_C1].threshold;
+	omap4_power_states[OMAP4_STATE_C1].cpu0_state = PWRDM_POWER_ON;
 	omap4_power_states[OMAP4_STATE_C1].mpu_state = PWRDM_POWER_ON;
+	omap4_power_states[OMAP4_STATE_C1].mpu_logic_state = PWRDM_POWER_RET;
 	omap4_power_states[OMAP4_STATE_C1].core_state = PWRDM_POWER_ON;
+	omap4_power_states[OMAP4_STATE_C1].core_logic_state = PWRDM_POWER_RET;
 	omap4_power_states[OMAP4_STATE_C1].flags = CPUIDLE_FLAG_TIME_VALID;
+	omap4_power_states[OMAP4_STATE_C1].desc = "MPU ON + CORE ON";
+
+	/*
+	 * C2 - CPU0 ON + CPU1 OFF + MPU ON + CORE ON
+	 */
+	omap4_power_states[OMAP4_STATE_C2].valid =
+			cpuidle_params_table[OMAP4_STATE_C2].valid;
+	omap4_power_states[OMAP4_STATE_C2].type = OMAP4_STATE_C2;
+	omap4_power_states[OMAP4_STATE_C2].sleep_latency =
+			cpuidle_params_table[OMAP4_STATE_C2].sleep_latency;
+	omap4_power_states[OMAP4_STATE_C2].wakeup_latency =
+			cpuidle_params_table[OMAP4_STATE_C2].wake_latency;
+	omap4_power_states[OMAP4_STATE_C2].threshold =
+			cpuidle_params_table[OMAP4_STATE_C2].threshold;
+	omap4_power_states[OMAP4_STATE_C2].cpu0_state = PWRDM_POWER_ON;
+	omap4_power_states[OMAP4_STATE_C2].mpu_state = PWRDM_POWER_ON;
+	omap4_power_states[OMAP4_STATE_C2].mpu_logic_state = PWRDM_POWER_RET;
+	omap4_power_states[OMAP4_STATE_C2].core_state = PWRDM_POWER_ON;
+	omap4_power_states[OMAP4_STATE_C2].core_logic_state = PWRDM_POWER_RET;
+	omap4_power_states[OMAP4_STATE_C2].flags = CPUIDLE_FLAG_IGNORE;
+	omap4_power_states[OMAP4_STATE_C2].desc = "MPU ON + CORE ON";
+
+	/*
+	 * C3 - CPU0 OFF + CPU1 OFF + MPU CSWR + CORE ON
+	 */
+	omap4_power_states[OMAP4_STATE_C3].valid =
+			cpuidle_params_table[OMAP4_STATE_C3].valid;
+	omap4_power_states[OMAP4_STATE_C3].type = OMAP4_STATE_C3;
+	omap4_power_states[OMAP4_STATE_C3].sleep_latency =
+			cpuidle_params_table[OMAP4_STATE_C3].sleep_latency;
+	omap4_power_states[OMAP4_STATE_C3].wakeup_latency =
+			cpuidle_params_table[OMAP4_STATE_C3].wake_latency;
+	omap4_power_states[OMAP4_STATE_C3].threshold =
+			cpuidle_params_table[OMAP4_STATE_C3].threshold;
+	omap4_power_states[OMAP4_STATE_C3].cpu0_state = PWRDM_POWER_OFF;
+	omap4_power_states[OMAP4_STATE_C3].mpu_state = PWRDM_POWER_RET;
+	omap4_power_states[OMAP4_STATE_C3].mpu_logic_state = PWRDM_POWER_RET;
+	omap4_power_states[OMAP4_STATE_C3].core_state = PWRDM_POWER_ON;
+	omap4_power_states[OMAP4_STATE_C3].core_logic_state = PWRDM_POWER_RET;
+	omap4_power_states[OMAP4_STATE_C3].flags = CPUIDLE_FLAG_IGNORE;
+	omap4_power_states[OMAP4_STATE_C3].desc = "MPU CSWR + CORE ON";
+
+	/*
+	 * C4 - CPU0 OFF + CPU1 OFF + MPU OFF + CORE ON
+	 */
+	omap4_power_states[OMAP4_STATE_C4].valid =
+			cpuidle_params_table[OMAP4_STATE_C4].valid;
+	omap4_power_states[OMAP4_STATE_C4].type = OMAP4_STATE_C4;
+	omap4_power_states[OMAP4_STATE_C4].sleep_latency =
+			cpuidle_params_table[OMAP4_STATE_C4].sleep_latency;
+	omap4_power_states[OMAP4_STATE_C4].wakeup_latency =
+			cpuidle_params_table[OMAP4_STATE_C4].wake_latency;
+	omap4_power_states[OMAP4_STATE_C4].threshold =
+			cpuidle_params_table[OMAP4_STATE_C4].threshold;
+	omap4_power_states[OMAP4_STATE_C4].cpu0_state = PWRDM_POWER_OFF;
+	omap4_power_states[OMAP4_STATE_C4].mpu_state = PWRDM_POWER_OFF;
+	omap4_power_states[OMAP4_STATE_C4].mpu_logic_state = PWRDM_POWER_OFF;
+	omap4_power_states[OMAP4_STATE_C4].core_state = PWRDM_POWER_ON;
+	omap4_power_states[OMAP4_STATE_C4].core_logic_state = PWRDM_POWER_RET;
+	omap4_power_states[OMAP4_STATE_C4].flags = CPUIDLE_FLAG_IGNORE;
+	omap4_power_states[OMAP4_STATE_C4].desc = "MPU OFF + CORE ON";
 
 }
 
@@ -115,11 +227,15 @@ struct cpuidle_driver omap4_idle_driver = {
  */
 int __init omap4_idle_init(void)
 {
-	int cpu_id = 0, i, count = 0;
+	int cpu_id = 0, i, count = 0, ret;
 	struct omap4_processor_cx *cx;
 	struct cpuidle_state *state;
 	struct cpuidle_device *dev;
 
+	mpu_pd = pwrdm_lookup("mpu_pwrdm");
+	cpu1_pd = pwrdm_lookup("cpu1_pwrdm");
+	core_pd = pwrdm_lookup("core_pwrdm");
+
 	omap4_init_power_states();
 	cpuidle_register_driver(&omap4_idle_driver);
 
@@ -137,8 +253,11 @@ int __init omap4_idle_init(void)
 						cx->wakeup_latency;
 		state->target_residency = cx->threshold;
 		state->flags = cx->flags;
+		if (cx->type == OMAP4_STATE_C1)
+			dev->safe_state = state;
 		state->enter = omap4_enter_idle;
 		sprintf(state->name, "C%d", count+1);
+		strncpy(state->desc, cx->desc, CPUIDLE_DESC_LEN);
 		count++;
 	}
 
-- 
1.6.0.4

