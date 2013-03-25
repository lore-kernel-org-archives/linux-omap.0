From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 17/18] ARM: OMAP4+: CPUidle: Add OMAP5 idle driver support
Date: Mon, 25 Mar 2013 15:35:09 +0530
Message-ID: <1364205910-32392-18-git-send-email-santosh.shilimkar@ti.com>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38593 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab3CYKEQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Mar 2013 06:04:16 -0400
In-Reply-To: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

The OMAP5 idle driver can re-use OMAP4 CPUidle driver implementation thanks
to compatible MPUSS design.

Though unlike OMAP4, on OMAP5 devices, MPUSS CSWR (Close Switch Retention)
power states can be achieved with respective power states on CPU0 and CPU1
power domain. This mode was broken on OMAP4 devices because of hardware
limitation. Also there is no CPU low power entry order requirement like
master CPU etc for CSWR C-state, which is icing on the cake. Code makes
use of voting scheme for cluster low power state to support MPUSS CSWR
C-state.

Supported OMAP5 CPUidle C-states:
        C1 - CPU0 ON(WFI) + CPU1 ON(WFI) + MPUSS ON
        C2 - CPU0 CSWR + CPU1 CSWR + MPUSS CSWR
        C3 - CPU0 OFF + CPU1 OFF + MPUSS OSWR

Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Kconfig                        |    1 +
 arch/arm/mach-omap2/Makefile                       |    3 +-
 .../{cpuidle44xx.c => cpuidle_omap4plus.c}         |  110 +++++++++++++++++++-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |    7 +-
 arch/arm/mach-omap2/pm_omap4plus.c                 |    2 +-
 5 files changed, 115 insertions(+), 8 deletions(-)
 rename arch/arm/mach-omap2/{cpuidle44xx.c => cpuidle_omap4plus.c} (69%)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b9c0ed3..838ea67 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -105,6 +105,7 @@ config SOC_OMAP5
 	select HAVE_SMP
 	select COMMON_CLK
 	select HAVE_ARM_ARCH_TIMER
+	select ARCH_NEEDS_CPU_IDLE_COUPLED
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index d91ae0f..ddaaa6c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -102,7 +102,8 @@ endif
 
 ifeq ($(CONFIG_CPU_IDLE),y)
 obj-$(CONFIG_ARCH_OMAP3)                += cpuidle34xx.o
-obj-$(CONFIG_ARCH_OMAP4)                += cpuidle44xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= cpuidle_omap4plus.o
+obj-$(CONFIG_SOC_OMAP5)			+= cpuidle_omap4plus.o
 endif
 
 # PRCM
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle_omap4plus.c
similarity index 69%
rename from arch/arm/mach-omap2/cpuidle44xx.c
rename to arch/arm/mach-omap2/cpuidle_omap4plus.c
index e6218d3..defb830 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle_omap4plus.c
@@ -22,12 +22,14 @@
 #include "pm.h"
 #include "prm.h"
 #include "clockdomain.h"
+#include "soc.h"
 
 /* Machine specific information */
 struct idle_statedata {
 	u32 cpu_state;
 	u32 mpu_logic_state;
 	u32 mpu_state;
+	u32 mpu_state_vote;
 };
 
 static struct idle_statedata omap4_idle_data[] = {
@@ -48,17 +50,36 @@ static struct idle_statedata omap4_idle_data[] = {
 	},
 };
 
+static struct idle_statedata omap5_idle_data[] = {
+	{
+		.cpu_state = PWRDM_POWER_ON,
+		.mpu_state = PWRDM_POWER_ON,
+		.mpu_logic_state = PWRDM_POWER_RET,
+	},
+	{
+		.cpu_state = PWRDM_POWER_RET,
+		.mpu_state = PWRDM_POWER_RET,
+		.mpu_logic_state = PWRDM_POWER_RET,
+	},
+	{
+		.cpu_state = PWRDM_POWER_OFF,
+		.mpu_state = PWRDM_POWER_RET,
+		.mpu_logic_state = PWRDM_POWER_OFF,
+	},
+};
+
 static struct powerdomain *mpu_pd, *cpu_pd[NR_CPUS];
 static struct clockdomain *cpu_clkdm[NR_CPUS];
 
 static atomic_t abort_barrier;
 static bool cpu_done[NR_CPUS];
-static struct idle_statedata *state_ptr = &omap4_idle_data[0];
+static struct idle_statedata *state_ptr;
+static DEFINE_RAW_SPINLOCK(mpu_lock);
 
 /* Private functions */
 
 /**
- * omap_enter_idle_[simple/coupled] - OMAP4PLUS cpuidle entry functions
+ * omap_enter_idle_[simple/smp/coupled] - OMAP4PLUS cpuidle entry functions
  * @dev: cpuidle device
  * @drv: cpuidle driver
  * @index: the index of state to be entered
@@ -131,6 +152,8 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
 
 	/* Wakeup CPU1 only if it is not offlined */
 	if (dev->cpu == 0 && cpumask_test_cpu(1, cpu_online_mask)) {
+		/* Restore MPU PD state post idle */
+		omap_set_pwrdm_state(mpu_pd, PWRDM_POWER_ON);
 		clkdm_wakeup(cpu_clkdm[1]);
 		omap_set_pwrdm_state(cpu_pd[1], PWRDM_POWER_ON);
 		clkdm_allow_idle(cpu_clkdm[1]);
@@ -159,6 +182,37 @@ fail:
 	return index;
 }
 
+static int omap_enter_idle_smp(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv,
+			int index)
+{
+	struct idle_statedata *cx = state_ptr + index;
+	int cpu_id = smp_processor_id();
+	unsigned long flag;
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
+
+	raw_spin_lock_irqsave(&mpu_lock, flag);
+	cx->mpu_state_vote++;
+	if (cx->mpu_state_vote == num_online_cpus()) {
+		pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
+		omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
+	}
+	raw_spin_unlock_irqrestore(&mpu_lock, flag);
+
+	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
+
+	raw_spin_lock_irqsave(&mpu_lock, flag);
+	if (cx->mpu_state_vote == num_online_cpus())
+		omap_set_pwrdm_state(mpu_pd, PWRDM_POWER_ON);
+	cx->mpu_state_vote--;
+	raw_spin_unlock_irqrestore(&mpu_lock, flag);
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
+
+	return index;
+}
+
 /*
  * For each cpu, setup the broadcast timer because local timers
  * stops for the states above C1.
@@ -208,6 +262,43 @@ static struct cpuidle_driver omap4_idle_driver = {
 	.safe_state_index = 0,
 };
 
+static struct cpuidle_driver omap5_idle_driver = {
+	.name				= "omap5_idle",
+	.owner				= THIS_MODULE,
+	.en_core_tk_irqen		= 1,
+	.states = {
+		{
+			/* C1 - CPU0 ON + CPU1 ON + MPU ON */
+			.exit_latency = 2 + 2,
+			.target_residency = 5,
+			.flags = CPUIDLE_FLAG_TIME_VALID,
+			.enter = omap_enter_idle_simple,
+			.name = "C1",
+			.desc = "CPUx ON, MPUSS ON"
+		},
+		{
+			/* C2 - CPU0 CSWR + CPU1 CSWR + MPU CSWR */
+			.exit_latency = 16 + 16,
+			.target_residency = 40,
+			.flags = CPUIDLE_FLAG_TIME_VALID,
+			.enter = omap_enter_idle_smp,
+			.name = "C2",
+			.desc = "CPUx CSWR, MPUSS CSWR",
+		},
+		{
+			/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
+			.exit_latency = 460 + 518,
+			.target_residency = 1100,
+			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
+			.enter = omap_enter_idle_coupled,
+			.name = "C3",
+			.desc = "CPUx OFF, MPUSS OSWR",
+		},
+	},
+	.state_count = ARRAY_SIZE(omap5_idle_data),
+	.safe_state_index = 0,
+};
+
 /* Public functions */
 
 /**
@@ -219,7 +310,8 @@ static struct cpuidle_driver omap4_idle_driver = {
 int __init omap4_idle_init(void)
 {
 	struct cpuidle_device *dev;
-	unsigned int cpu_id = 0;
+	static struct cpuidle_driver *drv;
+	unsigned cpu_id = 0;
 
 	mpu_pd = pwrdm_lookup("mpu_pwrdm");
 	cpu_pd[0] = pwrdm_lookup("cpu0_pwrdm");
@@ -235,7 +327,15 @@ int __init omap4_idle_init(void)
 	/* Configure the broadcast timer on each cpu */
 	on_each_cpu(omap_setup_broadcast_timer, NULL, 1);
 
-	if (cpuidle_register_driver(&omap4_idle_driver)) {
+	if (cpu_is_omap44xx()) {
+		drv = &omap4_idle_driver;
+		state_ptr = &omap4_idle_data[0];
+	} else if (soc_is_omap54xx()) {
+		drv = &omap5_idle_driver;
+		state_ptr = &omap5_idle_data[0];
+	}
+
+	if (cpuidle_register_driver(drv)) {
 		pr_err("%s: CPUidle driver register failed\n", __func__);
 		return -EIO;
 	}
@@ -248,7 +348,7 @@ int __init omap4_idle_init(void)
 #endif
 		if (cpuidle_register_device(dev)) {
 			pr_err("%s: CPUidle register failed\n", __func__);
-			cpuidle_unregister_driver(&omap4_idle_driver);
+			cpuidle_unregister_driver(drv);
 			return -EIO;
 		}
 	}
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 6e917d7..8f6a0be 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -100,7 +100,7 @@ extern int omap5_finish_suspend(unsigned long cpu_state);
 static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
 static struct powerdomain *mpuss_pd;
 static void __iomem *sar_base;
-static u32 cpu_context_offset;
+static u32 cpu_context_offset, cpu_cswr_supported;
 
 static int default_finish_suspend(unsigned long cpu_state)
 {
@@ -248,6 +248,10 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 		save_state = 1;
 		break;
 	case PWRDM_POWER_RET:
+		if (cpu_cswr_supported) {
+			save_state = 0;
+			break;
+		}
 	default:
 		/*
 		 * CPUx CSWR is invalid hardware state. Also CPUx OSWR
@@ -441,6 +445,7 @@ int __init omap4_mpuss_init(void)
 		omap_pm_ops.resume = cpu_resume;
 		cpu_context_offset = OMAP54XX_RM_CPU0_CPU0_CONTEXT_OFFSET;
 		enable_mercury_retention_mode();
+		cpu_cswr_supported = 1;
 	}
 
 	/* Over-write the OMAP4 hook to take care of ROM BUG */
diff --git a/arch/arm/mach-omap2/pm_omap4plus.c b/arch/arm/mach-omap2/pm_omap4plus.c
index 2dadb4e..85408ce 100644
--- a/arch/arm/mach-omap2/pm_omap4plus.c
+++ b/arch/arm/mach-omap2/pm_omap4plus.c
@@ -275,7 +275,7 @@ int __init omap4_pm_init(void)
 	/* Overwrite the default cpu_do_idle() */
 	arm_pm_idle = omap_default_idle;
 
-	if (cpu_is_omap44xx())
+	if (cpu_is_omap44xx() || soc_is_omap54xx())
 		omap4_idle_init();
 
 err2:
-- 
1.7.9.5

