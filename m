From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 21/24] OMAP4: PM: Add CPUidle support
Date: Sat, 24 Sep 2011 11:44:41 +0530
Message-ID: <1316844884-21700-22-git-send-email-santosh.shilimkar@ti.com>
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39758 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752251Ab1IXGPW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 24 Sep 2011 02:15:22 -0400
In-Reply-To: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

Add OMAP4 CPUIDLE support. CPU1 is left with defualt idle and
the low power state for it is managed via cpu-hotplug.

This patch adds MPUSS low power states in cpuidle.

	C1 - CPU0 ON + CPU1 ON + MPU ON
	C2 - CPU0 OFF + CPU1 OFF + MPU CSWR
	C3 - CPU0 OFF + CPU1 OFF + MPU OSWR

OMAP4460 onwards, MPUSS power domain doesn't support OFF state any more
anymore just like CORE power domain. The deepest state supported is OSWr.
Ofcourse when MPUSS and CORE PD transitions to OSWR along with device
off mode, even the memory contemts are lost which is as good as
the PD off state.

On OMAP4 because of hardware constraints, no low power states are
targeted when both CPUs are online and in SMP mode. The low power
states are attempted only when secondary CPU gets offline to OFF
through hotplug infrastructure.

Thanks to Nicole Chalhoub <n-chalhoub@ti.com> for doing exhaustive
C-state latency profiling.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Jean Pihet <j-pihet@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/Makefile      |    3 +-
 arch/arm/mach-omap2/cpuidle44xx.c |  210 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h          |    1 +
 arch/arm/mach-omap2/pm44xx.c      |    2 +
 4 files changed, 215 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/cpuidle44xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 974c9d1..a9f8d48 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -65,7 +65,8 @@ obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o \
 					   cpuidle34xx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
+obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o \
+					   cpuidle44xx.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
 obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
new file mode 100644
index 0000000..ac8f4c0
--- /dev/null
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -0,0 +1,210 @@
+/*
+ * OMAP4 CPU idle Routines
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ * Santosh Shilimkar <santosh.shilimkar@ti.com>
+ * Rajendra Nayak <rnayak@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/sched.h>
+#include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
+
+#include <asm/proc-fns.h>
+
+#include <mach/omap4-common.h>
+
+#include "pm.h"
+#include "prm.h"
+
+#ifdef CONFIG_CPU_IDLE
+
+/* Machine specific information to be recorded in the C-state driver_data */
+struct omap4_idle_statedata {
+	u32 cpu_state;
+	u32 mpu_logic_state;
+	u32 mpu_state;
+	u8 valid;
+};
+
+static struct cpuidle_params cpuidle_params_table[] = {
+	/* C1 - CPU0 ON + CPU1 ON + MPU ON */
+	{.exit_latency = 2 + 2 , .target_residency = 5, .valid = 1},
+	/* C2- CPU0 OFF + CPU1 OFF + MPU CSWR */
+	{.exit_latency = 328 + 440 , .target_residency = 960, .valid = 1},
+	/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
+	{.exit_latency = 460 + 518 , .target_residency = 1100, .valid = 1},
+};
+
+#define OMAP4_NUM_STATES ARRAY_SIZE(cpuidle_params_table)
+
+struct omap4_idle_statedata omap4_idle_data[OMAP4_NUM_STATES];
+static struct powerdomain *mpu_pd, *cpu0_pd, *cpu1_pd;
+
+/**
+ * omap4_enter_idle - Programs OMAP4 to enter the specified state
+ * @dev: cpuidle device
+ * @state: The target state to be programmed
+ *
+ * Called from the CPUidle framework to program the device to the
+ * specified low power state selected by the governor.
+ * Returns the amount of time spent in the low power state.
+ */
+static int omap4_enter_idle(struct cpuidle_device *dev,
+			struct cpuidle_state *state)
+{
+	struct omap4_idle_statedata *cx = cpuidle_get_statedata(state);
+	struct timespec ts_preidle, ts_postidle, ts_idle;
+	u32 cpu1_state;
+
+	/* Used to keep track of the total time in idle */
+	getnstimeofday(&ts_preidle);
+
+	local_irq_disable();
+	local_fiq_disable();
+
+	/*
+	 * CPU0 has to stay ON (i.e in C1) until CPU1 is OFF state.
+	 * This is necessary to honour hardware recommondation
+	 * of triggeing all the possible low power modes once CPU1 is
+	 * out of coherency and in OFF mode.
+	 * Update dev->last_state so that governor stats reflects right
+	 * data.
+	 */
+	cpu1_state = pwrdm_read_pwrst(cpu1_pd);
+	if (cpu1_state != PWRDM_POWER_OFF) {
+		dev->last_state = dev->safe_state;
+		cx = cpuidle_get_statedata(dev->safe_state);
+	}
+
+	/*
+	 * Call idle CPU PM enter notifier chain so that
+	 * VFP and per CPU interrupt context is saved.
+	 */
+	if (cx->cpu_state == PWRDM_POWER_OFF)
+		cpu_pm_enter();
+
+	pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
+	omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
+
+	/*
+	 * Call idle CPU cluster PM enter notifier chain
+	 * to save GIC and wakeupgen context.
+	 */
+	if ((cx->mpu_state == PWRDM_POWER_RET) &&
+		(cx->mpu_logic_state == PWRDM_POWER_OFF))
+			cpu_cluster_pm_enter();
+
+	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
+
+	/*
+	 * Call idle CPU PM exit notifier chain to restore
+	 * VFP and per CPU IRQ context. Only CPU0 state is
+	 * considered since CPU1 is managed by CPU hotplug.
+	 */
+	if (pwrdm_read_prev_pwrst(cpu0_pd) == PWRDM_POWER_OFF)
+		cpu_pm_exit();
+
+	/*
+	 * Call idle CPU cluster PM exit notifier chain
+	 * to restore GIC and wakeupgen context.
+	 */
+	if (omap4_mpuss_read_prev_context_state())
+		cpu_cluster_pm_exit();
+
+	getnstimeofday(&ts_postidle);
+	ts_idle = timespec_sub(ts_postidle, ts_preidle);
+
+	local_irq_enable();
+	local_fiq_enable();
+
+	return ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_sec * USEC_PER_SEC;
+}
+
+DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
+
+struct cpuidle_driver omap4_idle_driver = {
+	.name =		"omap4_idle",
+	.owner =	THIS_MODULE,
+};
+
+static inline struct omap4_idle_statedata *_fill_cstate(
+					struct cpuidle_device *dev,
+					int idx, const char *descr)
+{
+	struct omap4_idle_statedata *cx = &omap4_idle_data[idx];
+	struct cpuidle_state *state = &dev->states[idx];
+
+	state->exit_latency	= cpuidle_params_table[idx].exit_latency;
+	state->target_residency	= cpuidle_params_table[idx].target_residency;
+	state->flags		= CPUIDLE_FLAG_TIME_VALID;
+	state->enter		= omap4_enter_idle;
+	cx->valid		= cpuidle_params_table[idx].valid;
+	sprintf(state->name, "C%d", idx + 1);
+	strncpy(state->desc, descr, CPUIDLE_DESC_LEN);
+	cpuidle_set_statedata(state, cx);
+
+	return cx;
+}
+
+/**
+ * omap4_idle_init - Init routine for OMAP4 idle
+ *
+ * Registers the OMAP4 specific cpuidle driver to the cpuidle
+ * framework with the valid set of states.
+ */
+int __init omap4_idle_init(void)
+{
+	struct omap4_idle_statedata *cx;
+	struct cpuidle_device *dev;
+	unsigned int cpu_id = 0;
+
+	mpu_pd = pwrdm_lookup("mpu_pwrdm");
+	cpu0_pd = pwrdm_lookup("cpu0_pwrdm");
+	cpu1_pd = pwrdm_lookup("cpu1_pwrdm");
+	if ((!mpu_pd) || (!cpu0_pd) || (!cpu1_pd))
+		return -ENODEV;
+
+	cpuidle_register_driver(&omap4_idle_driver);
+
+	dev = &per_cpu(omap4_idle_dev, cpu_id);
+	dev->cpu = cpu_id;
+
+	/* C1 - CPU0 ON + CPU1 ON + MPU ON */
+	cx = _fill_cstate(dev, 0, "MPUSS ON");
+	dev->safe_state = &dev->states[0];
+	cx->valid = 1;	/* C1 is always valid */
+	cx->cpu_state = PWRDM_POWER_ON;
+	cx->mpu_state = PWRDM_POWER_ON;
+	cx->mpu_logic_state = PWRDM_POWER_RET;
+
+	/* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
+	cx = _fill_cstate(dev, 1, "MPUSS CSWR");
+	cx->cpu_state = PWRDM_POWER_OFF;
+	cx->mpu_state = PWRDM_POWER_RET;
+	cx->mpu_logic_state = PWRDM_POWER_RET;
+
+	/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
+	cx = _fill_cstate(dev, 2, "MPUSS OSWR");
+	cx->cpu_state = PWRDM_POWER_OFF;
+	cx->mpu_state = PWRDM_POWER_RET;
+	cx->mpu_logic_state = PWRDM_POWER_OFF;
+
+	dev->state_count = OMAP4_NUM_STATES;
+	if (cpuidle_register_device(dev)) {
+		pr_err("%s: CPUidle register device failed\n", __func__);
+			return -EIO;
+		}
+
+	return 0;
+}
+#else
+int __init omap4_idle_init(void)
+{
+	return 0;
+}
+#endif /* CONFIG_CPU_IDLE */
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 4e166ad..b737b11 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -21,6 +21,7 @@ extern void omap_sram_idle(void);
 extern int omap3_can_sleep(void);
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 extern int omap3_idle_init(void);
+extern int omap4_idle_init(void);
 
 #if defined(CONFIG_PM_OPP)
 extern int omap3_opp_init(void);
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index fda656d..0e4c39c 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -259,6 +259,8 @@ static int __init omap4_pm_init(void)
 	/* Overwrite the default arch_idle() */
 	pm_idle = omap_default_idle;
 
+	omap4_idle_init();
+
 err2:
 	return ret;
 }
-- 
1.7.4.1

