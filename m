From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 2/4] ARM: OMAP4: CPUidle: Use coupled cpuidle states to implement SMP cpuidle.
Date: Mon, 21 May 2012 13:02:37 +0530
Message-ID: <1337585559-20250-3-git-send-email-santosh.shilimkar@ti.com>
References: <1337585559-20250-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50421 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753605Ab2EUHc7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 May 2012 03:32:59 -0400
In-Reply-To: <1337585559-20250-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ccross@android.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

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
---
 arch/arm/mach-omap2/Kconfig       |    1 +
 arch/arm/mach-omap2/cpuidle44xx.c |  112 ++++++++++++++++++++++---------------
 2 files changed, 67 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 8141b76..8a12c40 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -54,6 +54,7 @@ config ARCH_OMAP4
 	select PM_OPP if PM
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARM_CPU_SUSPEND if PM
+	select ARCH_NEEDS_CPU_IDLE_COUPLED
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index be1617c..25655eb 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -21,6 +21,7 @@
 #include "common.h"
 #include "pm.h"
 #include "prm.h"
+#include "clockdomain.h"
 
 #ifdef CONFIG_CPU_IDLE
 
@@ -49,10 +50,11 @@ static struct omap4_idle_statedata omap4_idle_data[] = {
 	},
 };
 
-static struct powerdomain *mpu_pd, *cpu0_pd, *cpu1_pd;
+static struct powerdomain *mpu_pd, *cpu_pd[NR_CPUS];
+static struct clockdomain *cpu_clkdm[NR_CPUS];
 
 /**
- * omap4_enter_idle - Programs OMAP4 to enter the specified state
+ * omap4_enter_idle_coupled_[simple/coupled] - OMAP4 cpuidle entry functions
  * @dev: cpuidle device
  * @drv: cpuidle driver
  * @index: the index of state to be entered
@@ -61,60 +63,71 @@ static struct powerdomain *mpu_pd, *cpu0_pd, *cpu1_pd;
  * specified low power state selected by the governor.
  * Returns the amount of time spent in the low power state.
  */
-static int omap4_enter_idle(struct cpuidle_device *dev,
+static int omap4_enter_idle_simple(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv,
+			int index)
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
 	struct omap4_idle_statedata *cx = &omap4_idle_data[index];
-	u32 cpu1_state;
 	int cpu_id = smp_processor_id();
 
 	local_fiq_disable();
 
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
-		cx = &omap4_idle_data[index];
+	if (dev->cpu == 0 && cpumask_test_cpu(1, cpu_online_mask)) {
+		while (pwrdm_read_pwrst(cpu_pd[1]) != PWRDM_POWER_OFF)
+			cpu_relax();
 	}
 
-	if (index > 0)
-		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
 
 	/*
 	 * Call idle CPU PM enter notifier chain so that
 	 * VFP and per CPU interrupt context is saved.
 	 */
-	if (cx->cpu_state == PWRDM_POWER_OFF)
-		cpu_pm_enter();
-
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
+	cpu_pm_enter();
+
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
 
+	/* Wakeup CPU1 only if it is not offlined */
+	if (dev->cpu == 0 && cpumask_test_cpu(1, cpu_online_mask)) {
+		clkdm_wakeup(cpu_clkdm[1]);
+		clkdm_allow_idle(cpu_clkdm[1]);
+	}
+
 	/*
 	 * Call idle CPU PM exit notifier chain to restore
-	 * VFP and per CPU IRQ context. Only CPU0 state is
-	 * considered since CPU1 is managed by CPU hotplug.
+	 * VFP and per CPU IRQ context.
 	 */
-	if (pwrdm_read_prev_pwrst(cpu0_pd) == PWRDM_POWER_OFF)
-		cpu_pm_exit();
+	cpu_pm_exit();
 
 	/*
 	 * Call idle CPU cluster PM exit notifier chain
@@ -123,8 +136,7 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	if (omap4_mpuss_read_prev_context_state())
 		cpu_cluster_pm_exit();
 
-	if (index > 0)
-		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
 
 	local_fiq_enable();
 
@@ -143,7 +155,7 @@ struct cpuidle_driver omap4_idle_driver = {
 			.exit_latency = 2 + 2,
 			.target_residency = 5,
 			.flags = CPUIDLE_FLAG_TIME_VALID,
-			.enter = omap4_enter_idle,
+			.enter = omap4_enter_idle_simple,
 			.name = "C1",
 			.desc = "MPUSS ON"
 		},
@@ -151,8 +163,8 @@ struct cpuidle_driver omap4_idle_driver = {
                         /* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
 			.exit_latency = 328 + 440,
 			.target_residency = 960,
-			.flags = CPUIDLE_FLAG_TIME_VALID,
-			.enter = omap4_enter_idle,
+			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
+			.enter = omap4_enter_idle_coupled,
 			.name = "C2",
 			.desc = "MPUSS CSWR",
 		},
@@ -160,8 +172,8 @@ struct cpuidle_driver omap4_idle_driver = {
 			/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
 			.exit_latency = 460 + 518,
 			.target_residency = 1100,
-			.flags = CPUIDLE_FLAG_TIME_VALID,
-			.enter = omap4_enter_idle,
+			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
+			.enter = omap4_enter_idle_coupled,
 			.name = "C3",
 			.desc = "MPUSS OSWR",
 		},
@@ -182,19 +194,27 @@ int __init omap4_idle_init(void)
 	unsigned int cpu_id = 0;
 
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
-	cpu0_pd = pwrdm_lookup("cpu0_pwrdm");
-	cpu1_pd = pwrdm_lookup("cpu1_pwrdm");
-	if ((!mpu_pd) || (!cpu0_pd) || (!cpu1_pd))
+	cpu_pd[0] = pwrdm_lookup("cpu0_pwrdm");
+	cpu_pd[1] = pwrdm_lookup("cpu1_pwrdm");
+	if ((!mpu_pd) || (!cpu_pd[0]) || (!cpu_pd[1]))
+		return -ENODEV;
+
+	cpu_clkdm[0] = clkdm_lookup("mpu0_clkdm");
+	cpu_clkdm[1] = clkdm_lookup("mpu1_clkdm");
+	if (!cpu_clkdm[0] || !cpu_clkdm[1])
 		return -ENODEV;
 
-	dev = &per_cpu(omap4_idle_dev, cpu_id);
-	dev->cpu = cpu_id;
+	for_each_cpu(cpu_id, cpu_online_mask) {
+		dev = &per_cpu(omap4_idle_dev, cpu_id);
+		dev->cpu = cpu_id;
+		dev->coupled_cpus = *cpu_online_mask;
 
-	cpuidle_register_driver(&omap4_idle_driver);
+		cpuidle_register_driver(&omap4_idle_driver);
 
-	if (cpuidle_register_device(dev)) {
-		pr_err("%s: CPUidle register device failed\n", __func__);
-		return -EIO;
+		if (cpuidle_register_device(dev)) {
+			pr_err("%s: CPUidle register failed\n", __func__);
+			return -EIO;
+		}
 	}
 
 	return 0;
-- 
1.7.5.4

