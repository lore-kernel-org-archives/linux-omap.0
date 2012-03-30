From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/3] ARM: OMAP4: cpuidle: Use coupled cpuidle states to implement SMP cpuidle.
Date: Fri, 30 Mar 2012 18:57:27 +0530
Message-ID: <1333114048-26136-3-git-send-email-santosh.shilimkar@ti.com>
References: <1333114048-26136-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54871 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760037Ab2C3N1l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Mar 2012 09:27:41 -0400
In-Reply-To: <1333114048-26136-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, ccross@android.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

OMAP4 CPUDILE driver is converted mainly based on notes from the
coupled cpuidle patch series.

The changes include :
- Register both CPUs and C-states to cpuidle driver.
- Set struct cpuidle_device.coupled_cpus
- Set struct cpuidle_device.safe_state to non coupled state.
- Set CPUIDLE_FLAG_COUPLED in struct cpuidle_state.flags for each
  state that affects multiple cpus.
- Separate ->enter hooks for coupled & simple idle.
- CPU0 wait loop for CPU1 power transition.
- CPU1 wakeup mechanism for the idle exit.
- Enabling ARCH_NEEDS_CPU_IDLE_COUPLED for OMAP4.

Thanks to Kevin Hilman and Colin Cross on the suggestions/fixes
on the intermediate version of this patch.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
CC: Kevin Hilman <khilman@ti.com>
Cc: Colin Cross <ccross@android.com>
---
 arch/arm/mach-omap2/Kconfig       |    1 +
 arch/arm/mach-omap2/cpuidle44xx.c |  167 ++++++++++++++++++++++---------------
 2 files changed, 101 insertions(+), 67 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index e20c8ab..250786e 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -54,6 +54,7 @@ config ARCH_OMAP4
 	select PM_OPP if PM
 	select USB_ARCH_HAS_EHCI
 	select ARM_CPU_SUSPEND if PM
+	select ARCH_NEEDS_CPU_IDLE_COUPLED if CPU_IDLE
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index f386cbe..5724393 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -21,6 +21,7 @@
 #include "common.h"
 #include "pm.h"
 #include "prm.h"
+#include "clockdomain.h"
 
 #ifdef CONFIG_CPU_IDLE
 
@@ -44,10 +45,11 @@ static struct cpuidle_params cpuidle_params_table[] = {
 #define OMAP4_NUM_STATES ARRAY_SIZE(cpuidle_params_table)
 
 struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
-static struct powerdomain *mpu_pd, *cpu0_pd, *cpu1_pd;
+static struct powerdomain *mpu_pd, *cpu_pd[NR_CPUS];
+static struct clockdomain *cpu_clkdm[NR_CPUS];
 
 /**
- * omap4_enter_idle - Programs OMAP4 to enter the specified state
+ * omap4_enter_idle_coupled_[simple/coupled] - OMAP4 cpuidle entry functions
  * @dev: cpuidle device
  * @drv: cpuidle driver
  * @index: the index of state to be entered
@@ -56,34 +58,40 @@ static struct powerdomain *mpu_pd, *cpu0_pd, *cpu1_pd;
  * specified low power state selected by the governor.
  * Returns the amount of time spent in the low power state.
  */
-static int omap4_enter_idle(struct cpuidle_device *dev,
+static int omap4_enter_idle_simple(struct cpuidle_device *dev,
+				   struct cpuidle_driver *drv,
+				   int index)
+{
+	local_fiq_disable();
+	omap_do_wfi();
+	local_fiq_enable();
+
+	return index;
+}
+
+static int omap4_enter_idle_coupled(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
 {
 	struct omap4_idle_statedata *cx =
 			cpuidle_get_statedata(&dev->states_usage[index]);
-	u32 cpu1_state;
 	int cpu_id = smp_processor_id();
 
 	local_fiq_disable();
 
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
+
 	/*
-	 * CPU0 has to stay ON (i.e in C1) until CPU1 is OFF state.
+	 * CPU0 has to wait and stay ON until CPU1 is OFF state.
 	 * This is necessary to honour hardware recommondation
 	 * of triggeing all the possible low power modes once CPU1 is
 	 * out of coherency and in OFF mode.
-	 * Update dev->last_state so that governor stats reflects right
-	 * data.
 	 */
-	cpu1_state = pwrdm_read_pwrst(cpu1_pd);
-	if (cpu1_state != PWRDM_POWER_OFF) {
-		index = drv->safe_state_index;
-		cx = cpuidle_get_statedata(&dev->states_usage[index]);
+	if (dev->cpu == 0) {
+		while (pwrdm_read_pwrst(cpu_pd[1]) != PWRDM_POWER_OFF)
+			cpu_relax();
 	}
 
-	if (index > 0)
-		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
-
 	/*
 	 * Call idle CPU PM enter notifier chain so that
 	 * VFP and per CPU interrupt context is saved.
@@ -91,25 +99,35 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	if (cx->cpu_state == PWRDM_POWER_OFF)
 		cpu_pm_enter();
 
-	pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
-	omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
-
-	/*
-	 * Call idle CPU cluster PM enter notifier chain
-	 * to save GIC and wakeupgen context.
-	 */
-	if ((cx->mpu_state == PWRDM_POWER_RET) &&
-		(cx->mpu_logic_state == PWRDM_POWER_OFF))
-			cpu_cluster_pm_enter();
+	if (dev->cpu == 0) {
+		pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
+		omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
+
+		/*
+		 * Call idle CPU cluster PM enter notifier chain
+		 * to save GIC and wakeupgen context.
+		 */
+		if ((cx->mpu_state == PWRDM_POWER_RET) &&
+			(cx->mpu_logic_state == PWRDM_POWER_OFF))
+				cpu_cluster_pm_enter();
+	}
 
 	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
 
+	if (dev->cpu == 0) {
+		/* Wakeup CPU1 only if it is not offlined */
+		if (cpumask_test_cpu(1, cpu_online_mask)) {
+			clkdm_wakeup(cpu_clkdm[1]);
+			clkdm_allow_idle(cpu_clkdm[1]);
+		}
+	}
+
 	/*
 	 * Call idle CPU PM exit notifier chain to restore
 	 * VFP and per CPU IRQ context. Only CPU0 state is
 	 * considered since CPU1 is managed by CPU hotplug.
 	 */
-	if (pwrdm_read_prev_pwrst(cpu0_pd) == PWRDM_POWER_OFF)
+	if (pwrdm_read_prev_pwrst(cpu_pd[dev->cpu]) == PWRDM_POWER_OFF)
 		cpu_pm_exit();
 
 	/*
@@ -119,8 +137,7 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	if (omap4_mpuss_read_prev_context_state())
 		cpu_cluster_pm_exit();
 
-	if (index > 0)
-		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
 
 	local_fiq_enable();
 
@@ -136,14 +153,17 @@ struct cpuidle_driver omap4_idle_driver = {
 };
 
 static inline void _fill_cstate(struct cpuidle_driver *drv,
-					int idx, const char *descr)
+					int idx, const char *descr, int flags)
 {
 	struct cpuidle_state *state = &drv->states[idx];
 
 	state->exit_latency	= cpuidle_params_table[idx].exit_latency;
 	state->target_residency	= cpuidle_params_table[idx].target_residency;
-	state->flags		= CPUIDLE_FLAG_TIME_VALID;
-	state->enter		= omap4_enter_idle;
+	state->flags		= (CPUIDLE_FLAG_TIME_VALID | flags);
+	if (state->flags & CPUIDLE_FLAG_COUPLED)
+		state->enter		= omap4_enter_idle_coupled;
+	else
+		state->enter		= omap4_enter_idle_simple;
 	sprintf(state->name, "C%d", idx + 1);
 	strncpy(state->desc, descr, CPUIDLE_DESC_LEN);
 }
@@ -177,47 +197,60 @@ int __init omap4_idle_init(void)
 	unsigned int cpu_id = 0;
 
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
-	cpu0_pd = pwrdm_lookup("cpu0_pwrdm");
-	cpu1_pd = pwrdm_lookup("cpu1_pwrdm");
-	if ((!mpu_pd) || (!cpu0_pd) || (!cpu1_pd))
+	cpu_pd[0] = pwrdm_lookup("cpu0_pwrdm");
+	cpu_pd[1] = pwrdm_lookup("cpu1_pwrdm");
+	if ((!mpu_pd) || (!cpu_pd[0]) || (!cpu_pd[1]))
 		return -ENODEV;
 
+	cpu_clkdm[0] = clkdm_lookup("mpu0_clkdm");
+	cpu_clkdm[1] = clkdm_lookup("mpu1_clkdm");
+	if (!cpu_clkdm[0] || !cpu_clkdm[1])
+		return -ENODEV;
 
-	drv->safe_state_index = -1;
-	dev = &per_cpu(omap4_idle_dev, cpu_id);
-	dev->cpu = cpu_id;
-
-	/* C1 - CPU0 ON + CPU1 ON + MPU ON */
-	_fill_cstate(drv, 0, "MPUSS ON");
-	drv->safe_state_index = 0;
-	cx = _fill_cstate_usage(dev, 0);
-	cx->valid = 1;	/* C1 is always valid */
-	cx->cpu_state = PWRDM_POWER_ON;
-	cx->mpu_state = PWRDM_POWER_ON;
-	cx->mpu_logic_state = PWRDM_POWER_RET;
-
-	/* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
-	_fill_cstate(drv, 1, "MPUSS CSWR");
-	cx = _fill_cstate_usage(dev, 1);
-	cx->cpu_state = PWRDM_POWER_OFF;
-	cx->mpu_state = PWRDM_POWER_RET;
-	cx->mpu_logic_state = PWRDM_POWER_RET;
-
-	/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
-	_fill_cstate(drv, 2, "MPUSS OSWR");
-	cx = _fill_cstate_usage(dev, 2);
-	cx->cpu_state = PWRDM_POWER_OFF;
-	cx->mpu_state = PWRDM_POWER_RET;
-	cx->mpu_logic_state = PWRDM_POWER_OFF;
-
-	drv->state_count = OMAP4_NUM_STATES;
-	cpuidle_register_driver(&omap4_idle_driver);
-
-	dev->state_count = OMAP4_NUM_STATES;
-	if (cpuidle_register_device(dev)) {
-		pr_err("%s: CPUidle register device failed\n", __func__);
-			return -EIO;
+	for_each_cpu(cpu_id, cpu_online_mask) {
+		drv->safe_state_index = -1;
+		dev = &per_cpu(omap4_idle_dev, cpu_id);
+		dev->cpu = cpu_id;
+		dev->state_count = 0;
+		dev->coupled_cpus = *cpu_online_mask;
+		drv->state_count = 0;
+
+		/* C1 - CPU0 ON + CPU1 ON + MPU ON */
+		_fill_cstate(drv, 0, "MPUSS ON", 0);
+		drv->safe_state_index = 0;
+		cx = _fill_cstate_usage(dev, 0);
+		cx->valid = 1;	/* C1 is always valid */
+		cx->cpu_state = PWRDM_POWER_ON;
+		cx->mpu_state = PWRDM_POWER_ON;
+		cx->mpu_logic_state = PWRDM_POWER_RET;
+		dev->state_count++;
+		drv->state_count++;
+
+		/* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
+		_fill_cstate(drv, 1, "MPUSS CSWR", CPUIDLE_FLAG_COUPLED);
+		cx = _fill_cstate_usage(dev, 1);
+		cx->cpu_state = PWRDM_POWER_OFF;
+		cx->mpu_state = PWRDM_POWER_RET;
+		cx->mpu_logic_state = PWRDM_POWER_RET;
+		dev->state_count++;
+		drv->state_count++;
+
+		/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
+		_fill_cstate(drv, 2, "MPUSS OSWR", CPUIDLE_FLAG_COUPLED);
+		cx = _fill_cstate_usage(dev, 2);
+		cx->cpu_state = PWRDM_POWER_OFF;
+		cx->mpu_state = PWRDM_POWER_RET;
+		cx->mpu_logic_state = PWRDM_POWER_OFF;
+		dev->state_count++;
+		drv->state_count++;
+
+		cpuidle_register_driver(&omap4_idle_driver);
+
+		if (cpuidle_register_device(dev)) {
+			pr_err("%s: CPUidle register failed\n", __func__);
+				return -EIO;
 		}
+	}
 
 	return 0;
 }
-- 
1.7.5.4

