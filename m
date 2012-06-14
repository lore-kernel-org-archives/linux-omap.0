From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 3/8] ARM: OMAP2+: PM: use the functional power states API
Date: Thu, 14 Jun 2012 16:53:06 +0200
Message-ID: <1339685591-11177-4-git-send-email-j-pihet@ti.com>
References: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63696 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756077Ab2FNOxh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 10:53:37 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so2009876wgb.1
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 07:53:36 -0700 (PDT)
In-Reply-To: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

Use the functional power states as the API to control power domains.
The omap_set_pwrdm_state function shall be used instead of
pwrdm_set_next_pwrst to control the power domains next states.

Note: the internal code for power domains state management still
uses the internal power states.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c         |   61 +++++++++++-----------
 arch/arm/mach-omap2/cpuidle44xx.c         |   25 +++++-----
 arch/arm/mach-omap2/omap-hotplug.c        |    2 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   43 +++++++++-------
 arch/arm/mach-omap2/pm24xx.c              |   10 ++--
 arch/arm/mach-omap2/pm34xx.c              |   78 +++++++++++++++--------------
 arch/arm/mach-omap2/pm44xx.c              |    8 ++--
 arch/arm/mach-omap2/powerdomain.c         |    2 +-
 8 files changed, 119 insertions(+), 110 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 207bc1c..ef8d7d4 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -46,32 +46,32 @@ struct omap3_idle_statedata {
 
 static struct omap3_idle_statedata omap3_idle_data[] = {
 	{
-		.mpu_state = PWRDM_POWER_ON,
-		.core_state = PWRDM_POWER_ON,
+		.mpu_state = PWRDM_FUNC_PWRST_ON,
+		.core_state = PWRDM_FUNC_PWRST_ON,
 	},
 	{
-		.mpu_state = PWRDM_POWER_ON,
-		.core_state = PWRDM_POWER_ON,
+		.mpu_state = PWRDM_FUNC_PWRST_ON,
+		.core_state = PWRDM_FUNC_PWRST_ON,
 	},
 	{
-		.mpu_state = PWRDM_POWER_RET,
-		.core_state = PWRDM_POWER_ON,
+		.mpu_state = PWRDM_FUNC_PWRST_CSWR,
+		.core_state = PWRDM_FUNC_PWRST_ON,
 	},
 	{
-		.mpu_state = PWRDM_POWER_OFF,
-		.core_state = PWRDM_POWER_ON,
+		.mpu_state = PWRDM_FUNC_PWRST_OFF,
+		.core_state = PWRDM_FUNC_PWRST_ON,
 	},
 	{
-		.mpu_state = PWRDM_POWER_RET,
-		.core_state = PWRDM_POWER_RET,
+		.mpu_state = PWRDM_FUNC_PWRST_CSWR,
+		.core_state = PWRDM_FUNC_PWRST_CSWR,
 	},
 	{
-		.mpu_state = PWRDM_POWER_OFF,
-		.core_state = PWRDM_POWER_RET,
+		.mpu_state = PWRDM_FUNC_PWRST_OFF,
+		.core_state = PWRDM_FUNC_PWRST_CSWR,
 	},
 	{
-		.mpu_state = PWRDM_POWER_OFF,
-		.core_state = PWRDM_POWER_OFF,
+		.mpu_state = PWRDM_FUNC_PWRST_OFF,
+		.core_state = PWRDM_FUNC_PWRST_OFF,
 	},
 };
 
@@ -100,8 +100,8 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
 
 	local_fiq_disable();
 
-	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
-	pwrdm_set_next_pwrst(core_pd, core_state);
+	omap_set_pwrdm_state(mpu_pd, mpu_state);
+	omap_set_pwrdm_state(core_pd, core_state);
 
 	if (omap_irq_pending() || need_resched())
 		goto return_sleep_time;
@@ -116,7 +116,7 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
 	 * Call idle CPU PM enter notifier chain so that
 	 * VFP context is saved.
 	 */
-	if (mpu_state == PWRDM_POWER_OFF)
+	if (mpu_state == PWRDM_FUNC_PWRST_OFF)
 		cpu_pm_enter();
 
 	/* Execute ARM wfi */
@@ -126,7 +126,7 @@ static int __omap3_enter_idle(struct cpuidle_device *dev,
 	 * Call idle CPU PM enter notifier chain to restore
 	 * VFP context.
 	 */
-	if (pwrdm_read_prev_pwrst(mpu_pd) == PWRDM_POWER_OFF)
+	if (pwrdm_read_prev_func_pwrst(mpu_pd) == PWRDM_FUNC_PWRST_OFF)
 		cpu_pm_exit();
 
 	/* Re-allow idle for C1 */
@@ -175,20 +175,20 @@ static int next_valid_state(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv, int index)
 {
 	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
-	u32 mpu_deepest_state = PWRDM_POWER_RET;
-	u32 core_deepest_state = PWRDM_POWER_RET;
+	u32 mpu_deepest_state = PWRDM_FUNC_PWRST_CSWR;
+	u32 core_deepest_state = PWRDM_FUNC_PWRST_CSWR;
 	int idx;
 	int next_index = -1;
 
 	if (enable_off_mode) {
-		mpu_deepest_state = PWRDM_POWER_OFF;
+		mpu_deepest_state = PWRDM_FUNC_PWRST_OFF;
 		/*
 		 * Erratum i583: valable for ES rev < Es1.2 on 3630.
 		 * CORE OFF mode is not supported in a stable form, restrict
 		 * instead the CORE state to RET.
 		 */
 		if (!IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583))
-			core_deepest_state = PWRDM_POWER_OFF;
+			core_deepest_state = PWRDM_FUNC_PWRST_OFF;
 	}
 
 	/* Check if current state is valid */
@@ -232,7 +232,7 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 			       int index)
 {
 	int new_state_idx;
-	u32 core_next_state, per_next_state = 0, per_saved_state = 0, cam_state;
+	u32 core_next_state, per_next_state = 0, per_saved_state = 0;
 	struct omap3_idle_statedata *cx;
 	int ret;
 
@@ -240,8 +240,7 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	 * Prevent idle completely if CAM is active.
 	 * CAM does not have wakeup capability in OMAP3.
 	 */
-	cam_state = pwrdm_read_pwrst(cam_pd);
-	if (cam_state == PWRDM_POWER_ON) {
+	if (pwrdm_read_func_pwrst(cam_pd) == PWRDM_FUNC_PWRST_ON) {
 		new_state_idx = drv->safe_state_index;
 		goto select_state;
 	}
@@ -260,14 +259,14 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	 */
 	cx = &omap3_idle_data[index];
 	core_next_state = cx->core_state;
-	per_next_state = per_saved_state = pwrdm_read_next_pwrst(per_pd);
-	if ((per_next_state == PWRDM_POWER_OFF) &&
-	    (core_next_state > PWRDM_POWER_RET))
-		per_next_state = PWRDM_POWER_RET;
+	per_next_state = per_saved_state = pwrdm_read_next_func_pwrst(per_pd);
+	if ((per_next_state == PWRDM_FUNC_PWRST_OFF) &&
+	    (core_next_state > PWRDM_FUNC_PWRST_CSWR))
+		per_next_state = PWRDM_FUNC_PWRST_CSWR;
 
 	/* Are we changing PER target state? */
 	if (per_next_state != per_saved_state)
-		pwrdm_set_next_pwrst(per_pd, per_next_state);
+		omap_set_pwrdm_state(per_pd, per_next_state);
 
 	new_state_idx = next_valid_state(dev, drv, index);
 
@@ -276,7 +275,7 @@ select_state:
 
 	/* Restore original PER state if it was modified */
 	if (per_next_state != per_saved_state)
-		pwrdm_set_next_pwrst(per_pd, per_saved_state);
+		omap_set_pwrdm_state(per_pd, per_saved_state);
 
 	return ret;
 }
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index be1617c..50c9082 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -33,18 +33,18 @@ struct omap4_idle_statedata {
 
 static struct omap4_idle_statedata omap4_idle_data[] = {
 	{
-		.cpu_state = PWRDM_POWER_ON,
-		.mpu_state = PWRDM_POWER_ON,
+		.cpu_state = PWRDM_FUNC_PWRST_ON,
+		.mpu_state = PWRDM_FUNC_PWRST_ON,
 		.mpu_logic_state = PWRDM_POWER_RET,
 	},
 	{
-		.cpu_state = PWRDM_POWER_OFF,
-		.mpu_state = PWRDM_POWER_RET,
+		.cpu_state = PWRDM_FUNC_PWRST_OFF,
+		.mpu_state = PWRDM_FUNC_PWRST_CSWR,
 		.mpu_logic_state = PWRDM_POWER_RET,
 	},
 	{
-		.cpu_state = PWRDM_POWER_OFF,
-		.mpu_state = PWRDM_POWER_RET,
+		.cpu_state = PWRDM_FUNC_PWRST_OFF,
+		.mpu_state = PWRDM_FUNC_PWRST_CSWR,
 		.mpu_logic_state = PWRDM_POWER_OFF,
 	},
 };
@@ -79,8 +79,8 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	 * Update dev->last_state so that governor stats reflects right
 	 * data.
 	 */
-	cpu1_state = pwrdm_read_pwrst(cpu1_pd);
-	if (cpu1_state != PWRDM_POWER_OFF) {
+	cpu1_state = pwrdm_read_func_pwrst(cpu1_pd);
+	if (cpu1_state != PWRDM_FUNC_PWRST_OFF) {
 		index = drv->safe_state_index;
 		cx = &omap4_idle_data[index];
 	}
@@ -92,7 +92,7 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	 * Call idle CPU PM enter notifier chain so that
 	 * VFP and per CPU interrupt context is saved.
 	 */
-	if (cx->cpu_state == PWRDM_POWER_OFF)
+	if (cx->cpu_state == PWRDM_FUNC_PWRST_OFF)
 		cpu_pm_enter();
 
 	pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
@@ -102,8 +102,9 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	 * Call idle CPU cluster PM enter notifier chain
 	 * to save GIC and wakeupgen context.
 	 */
-	if ((cx->mpu_state == PWRDM_POWER_RET) &&
-		(cx->mpu_logic_state == PWRDM_POWER_OFF))
+	if (((cx->mpu_state == PWRDM_FUNC_PWRST_CSWR) ||
+	     (cx->mpu_state == PWRDM_FUNC_PWRST_OSWR)) &&
+	    (cx->mpu_logic_state == PWRDM_POWER_OFF))
 			cpu_cluster_pm_enter();
 
 	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
@@ -113,7 +114,7 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	 * VFP and per CPU IRQ context. Only CPU0 state is
 	 * considered since CPU1 is managed by CPU hotplug.
 	 */
-	if (pwrdm_read_prev_pwrst(cpu0_pd) == PWRDM_POWER_OFF)
+	if (pwrdm_read_prev_func_pwrst(cpu0_pd) == PWRDM_FUNC_PWRST_OFF)
 		cpu_pm_exit();
 
 	/*
diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index 56c345b..cb7a7eb 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -50,7 +50,7 @@ void __ref platform_cpu_die(unsigned int cpu)
 		/*
 		 * Enter into low power state
 		 */
-		omap4_hotplug_cpu(cpu, PWRDM_POWER_OFF);
+		omap4_hotplug_cpu(cpu, PWRDM_FUNC_PWRST_OFF);
 		this_cpu = smp_processor_id();
 		if (omap_read_auxcoreboot0() == this_cpu) {
 			/*
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 13670aa..dd94a0e 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -86,14 +86,14 @@ static inline void set_cpu_wakeup_addr(unsigned int cpu_id, u32 addr)
 }
 
 /*
- * Set the CPUx powerdomain's previous power state
+ * Set the CPUx powerdomain's next functional power state
  */
 static inline void set_cpu_next_pwrst(unsigned int cpu_id,
 				unsigned int power_state)
 {
 	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu_id);
 
-	pwrdm_set_next_pwrst(pm_info->pwrdm, power_state);
+	omap_set_pwrdm_state(pm_info->pwrdm, power_state);
 }
 
 /*
@@ -103,7 +103,7 @@ static inline unsigned int read_cpu_prev_pwrst(unsigned int cpu_id)
 {
 	struct omap4_cpu_pm_info *pm_info = &per_cpu(omap4_pm_info, cpu_id);
 
-	return pwrdm_read_prev_pwrst(pm_info->pwrdm);
+	return pwrdm_read_prev_func_pwrst(pm_info->pwrdm);
 }
 
 /*
@@ -125,14 +125,15 @@ static void scu_pwrst_prepare(unsigned int cpu_id, unsigned int cpu_state)
 	u32 scu_pwr_st;
 
 	switch (cpu_state) {
-	case PWRDM_POWER_RET:
+	case PWRDM_FUNC_PWRST_OSWR:
+	case PWRDM_FUNC_PWRST_CSWR:
 		scu_pwr_st = SCU_PM_DORMANT;
 		break;
-	case PWRDM_POWER_OFF:
+	case PWRDM_FUNC_PWRST_OFF:
 		scu_pwr_st = SCU_PM_POWEROFF;
 		break;
-	case PWRDM_POWER_ON:
-	case PWRDM_POWER_INACTIVE:
+	case PWRDM_FUNC_PWRST_ON:
+	case PWRDM_FUNC_PWRST_INACTIVE:
 	default:
 		scu_pwr_st = SCU_PM_NORMAL;
 		break;
@@ -231,19 +232,21 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 {
 	unsigned int save_state = 0;
 	unsigned int wakeup_cpu;
+	int mpuss_state;
 
 	if (omap_rev() == OMAP4430_REV_ES1_0)
 		return -ENXIO;
 
 	switch (power_state) {
-	case PWRDM_POWER_ON:
-	case PWRDM_POWER_INACTIVE:
+	case PWRDM_FUNC_PWRST_ON:
+	case PWRDM_FUNC_PWRST_INACTIVE:
 		save_state = 0;
 		break;
-	case PWRDM_POWER_OFF:
+	case PWRDM_FUNC_PWRST_OFF:
 		save_state = 1;
 		break;
-	case PWRDM_POWER_RET:
+	case PWRDM_FUNC_PWRST_OSWR:
+	case PWRDM_FUNC_PWRST_CSWR:
 	default:
 		/*
 		 * CPUx CSWR is invalid hardware state. Also CPUx OSWR
@@ -259,11 +262,13 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 
 	/*
 	 * Check MPUSS next state and save interrupt controller if needed.
-	 * In MPUSS OSWR or device OFF, interrupt controller  contest is lost.
+	 * In MPUSS OSWR or device OFF, interrupt controller context is lost.
 	 */
 	mpuss_clear_prev_logic_pwrst();
-	if ((pwrdm_read_next_pwrst(mpuss_pd) == PWRDM_POWER_RET) &&
-		(pwrdm_read_logic_retst(mpuss_pd) == PWRDM_POWER_OFF))
+	mpuss_state = pwrdm_read_next_func_pwrst(mpuss_pd);
+	if (((mpuss_state == PWRDM_FUNC_PWRST_CSWR) ||
+	     (mpuss_state == PWRDM_FUNC_PWRST_OSWR)) &&
+	    (pwrdm_read_logic_retst(mpuss_pd) == PWRDM_POWER_OFF))
 		save_state = 2;
 
 	cpu_clear_prev_logic_pwrst(cpu);
@@ -285,7 +290,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	 * domain transition
 	 */
 	wakeup_cpu = smp_processor_id();
-	set_cpu_next_pwrst(wakeup_cpu, PWRDM_POWER_ON);
+	set_cpu_next_pwrst(wakeup_cpu, PWRDM_FUNC_PWRST_ON);
 
 	pwrdm_post_transition();
 
@@ -304,7 +309,7 @@ int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
 	if (omap_rev() == OMAP4430_REV_ES1_0)
 		return -ENXIO;
 
-	if (power_state == PWRDM_POWER_OFF)
+	if (power_state == PWRDM_FUNC_PWRST_OFF)
 		cpu_state = 1;
 
 	clear_cpu_prev_pwrst(cpu);
@@ -319,7 +324,7 @@ int __cpuinit omap4_hotplug_cpu(unsigned int cpu, unsigned int power_state)
 	 */
 	omap4_finish_suspend(cpu_state);
 
-	set_cpu_next_pwrst(cpu, PWRDM_POWER_ON);
+	set_cpu_next_pwrst(cpu, PWRDM_FUNC_PWRST_ON);
 	return 0;
 }
 
@@ -354,7 +359,7 @@ int __init omap4_mpuss_init(void)
 	cpu_clear_prev_logic_pwrst(0);
 
 	/* Initialise CPU0 power domain state to ON */
-	pwrdm_set_next_pwrst(pm_info->pwrdm, PWRDM_POWER_ON);
+	omap_set_pwrdm_state(pm_info->pwrdm, PWRDM_FUNC_PWRST_ON);
 
 	pm_info = &per_cpu(omap4_pm_info, 0x1);
 	pm_info->scu_sar_addr = sar_base + SCU_OFFSET1;
@@ -371,7 +376,7 @@ int __init omap4_mpuss_init(void)
 	cpu_clear_prev_logic_pwrst(1);
 
 	/* Initialise CPU1 power domain state to ON */
-	pwrdm_set_next_pwrst(pm_info->pwrdm, PWRDM_POWER_ON);
+	omap_set_pwrdm_state(pm_info->pwrdm, PWRDM_FUNC_PWRST_ON);
 
 	mpuss_pd = pwrdm_lookup("mpu_pwrdm");
 	if (!mpuss_pd) {
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 2edeffc..0bed51e 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -94,7 +94,7 @@ static int omap2_enter_full_retention(void)
 	 * preserve logic state during retention
 	 */
 	pwrdm_set_logic_retst(mpu_pwrdm, PWRDM_POWER_RET);
-	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_RET);
+	omap_set_pwrdm_state(mpu_pwrdm, PWRDM_FUNC_PWRST_CSWR);
 
 	/* Workaround to kill USB */
 	l = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0) | OMAP24XX_USBSTANDBYCTRL;
@@ -251,23 +251,23 @@ static void __init prcm_setup_regs(void)
 		pwrdm_set_mem_retst(core_pwrdm, i, PWRDM_POWER_RET);
 
 	/* Set CORE powerdomain's next power state to RETENTION */
-	pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_RET);
+	omap_set_pwrdm_state(core_pwrdm, PWRDM_FUNC_PWRST_CSWR);
 
 	/*
 	 * Set MPU powerdomain's next power state to RETENTION;
 	 * preserve logic state during retention
 	 */
 	pwrdm_set_logic_retst(mpu_pwrdm, PWRDM_POWER_RET);
-	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_RET);
+	omap_set_pwrdm_state(mpu_pwrdm, PWRDM_FUNC_PWRST_CSWR);
 
 	/* Force-power down DSP, GFX powerdomains */
 
 	pwrdm = clkdm_get_pwrdm(dsp_clkdm);
-	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_OFF);
+	omap_set_pwrdm_state(pwrdm, PWRDM_FUNC_PWRST_OFF);
 	clkdm_sleep(dsp_clkdm);
 
 	pwrdm = clkdm_get_pwrdm(gfx_clkdm);
-	pwrdm_set_next_pwrst(pwrdm, PWRDM_POWER_OFF);
+	omap_set_pwrdm_state(pwrdm, PWRDM_FUNC_PWRST_OFF);
 	clkdm_sleep(gfx_clkdm);
 
 	/* Enable hardware-supervised idle for all clkdms */
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a34023d..b2fc786 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -139,7 +139,7 @@ static void omap3_core_restore_context(void)
 static void omap3_save_secure_ram_context(void)
 {
 	u32 ret;
-	int mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
+	int mpu_next_state = pwrdm_read_next_func_pwrst(mpu_pwrdm);
 
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
 		/*
@@ -147,10 +147,10 @@ static void omap3_save_secure_ram_context(void)
 		 * otherwise the WFI executed inside the ROM code
 		 * will hang the system.
 		 */
-		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
+		omap_set_pwrdm_state(mpu_pwrdm, PWRDM_FUNC_PWRST_ON);
 		ret = _omap_save_secure_sram((u32 *)
 				__pa(omap3_secure_ram_storage));
-		pwrdm_set_next_pwrst(mpu_pwrdm, mpu_next_state);
+		omap_set_pwrdm_state(mpu_pwrdm, mpu_next_state);
 		/* Following is for error tracking, it should not happen */
 		if (ret) {
 			pr_err("save_secure_sram() returns %08x\n", ret);
@@ -269,21 +269,23 @@ void omap_sram_idle(void)
 	/* save_state = 2 => Only L2 lost */
 	/* save_state = 3 => L1, L2 and logic lost */
 	int save_state = 0;
-	int mpu_next_state = PWRDM_POWER_ON;
-	int per_next_state = PWRDM_POWER_ON;
-	int core_next_state = PWRDM_POWER_ON;
+	int mpu_next_state = PWRDM_FUNC_PWRST_ON;
+	int per_next_state = PWRDM_FUNC_PWRST_ON;
+	int core_next_state = PWRDM_FUNC_PWRST_ON;
 	int per_going_off;
 	int core_prev_state;
 	u32 sdrc_pwr = 0;
 
-	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
+	mpu_next_state = pwrdm_read_next_func_pwrst(mpu_pwrdm);
 	switch (mpu_next_state) {
-	case PWRDM_POWER_ON:
-	case PWRDM_POWER_RET:
+	case PWRDM_FUNC_PWRST_ON:
+	case PWRDM_FUNC_PWRST_INACTIVE:
+	case PWRDM_FUNC_PWRST_CSWR:
 		/* No need to save context */
 		save_state = 0;
 		break;
-	case PWRDM_POWER_OFF:
+	case PWRDM_FUNC_PWRST_OSWR:
+	case PWRDM_FUNC_PWRST_OFF:
 		save_state = 3;
 		break;
 	default:
@@ -293,16 +295,17 @@ void omap_sram_idle(void)
 	}
 
 	/* NEON control */
-	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
-		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
+	if (pwrdm_read_func_pwrst(neon_pwrdm) == PWRDM_FUNC_PWRST_ON)
+		omap_set_pwrdm_state(neon_pwrdm, mpu_next_state);
 
 	/* Enable IO-PAD and IO-CHAIN wakeups */
-	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
-	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
+	per_next_state = pwrdm_read_next_func_pwrst(per_pwrdm);
+	core_next_state = pwrdm_read_next_func_pwrst(core_pwrdm);
 	if (omap3_has_io_wakeup() &&
-	    (per_next_state < PWRDM_POWER_ON ||
-	     core_next_state < PWRDM_POWER_ON)) {
-		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
+	    (per_next_state < PWRDM_FUNC_PWRST_ON ||
+	     core_next_state < PWRDM_FUNC_PWRST_ON)) {
+		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
+					   PM_WKEN);
 		if (omap3_has_io_chain_ctrl())
 			omap3_enable_io_chain();
 	}
@@ -310,14 +313,15 @@ void omap_sram_idle(void)
 	pwrdm_pre_transition();
 
 	/* PER */
-	if (per_next_state < PWRDM_POWER_ON) {
-		per_going_off = (per_next_state == PWRDM_POWER_OFF) ? 1 : 0;
+	if (per_next_state < PWRDM_FUNC_PWRST_ON) {
+		per_going_off = (per_next_state == PWRDM_FUNC_PWRST_OFF) ?
+				1 : 0;
 		omap2_gpio_prepare_for_idle(per_going_off);
 	}
 
 	/* CORE */
-	if (core_next_state < PWRDM_POWER_ON) {
-		if (core_next_state == PWRDM_POWER_OFF) {
+	if (core_next_state < PWRDM_FUNC_PWRST_ON) {
+		if (core_next_state == PWRDM_FUNC_PWRST_OFF) {
 			omap3_core_save_context();
 			omap3_cm_save_context();
 		}
@@ -334,7 +338,7 @@ void omap_sram_idle(void)
 	if (cpu_is_omap3430() && omap_rev() >= OMAP3430_REV_ES3_0 &&
 	    (omap_type() == OMAP2_DEVICE_TYPE_EMU ||
 	     omap_type() == OMAP2_DEVICE_TYPE_SEC) &&
-	    core_next_state == PWRDM_POWER_OFF)
+	    core_next_state == PWRDM_FUNC_PWRST_OFF)
 		sdrc_pwr = sdrc_read_reg(SDRC_POWER);
 
 	/*
@@ -353,19 +357,19 @@ void omap_sram_idle(void)
 	if (cpu_is_omap3430() && omap_rev() >= OMAP3430_REV_ES3_0 &&
 	    (omap_type() == OMAP2_DEVICE_TYPE_EMU ||
 	     omap_type() == OMAP2_DEVICE_TYPE_SEC) &&
-	    core_next_state == PWRDM_POWER_OFF)
+	    core_next_state == PWRDM_FUNC_PWRST_OFF)
 		sdrc_write_reg(sdrc_pwr, SDRC_POWER);
 
 	/* CORE */
-	if (core_next_state < PWRDM_POWER_ON) {
-		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
-		if (core_prev_state == PWRDM_POWER_OFF) {
+	if (core_next_state < PWRDM_FUNC_PWRST_ON) {
+		core_prev_state = pwrdm_read_prev_func_pwrst(core_pwrdm);
+		if (core_prev_state == PWRDM_FUNC_PWRST_OFF) {
 			omap3_core_restore_context();
 			omap3_cm_restore_context();
 			omap3_sram_restore_context();
 			omap2_sms_restore_context();
 		}
-		if (core_next_state == PWRDM_POWER_OFF)
+		if (core_next_state == PWRDM_FUNC_PWRST_OFF)
 			omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
 					       OMAP3430_GR_MOD,
 					       OMAP3_PRM_VOLTCTRL_OFFSET);
@@ -375,13 +379,13 @@ void omap_sram_idle(void)
 	pwrdm_post_transition();
 
 	/* PER */
-	if (per_next_state < PWRDM_POWER_ON)
+	if (per_next_state < PWRDM_FUNC_PWRST_ON)
 		omap2_gpio_resume_after_idle();
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
 	if (omap3_has_io_wakeup() &&
-	    (per_next_state < PWRDM_POWER_ON ||
-	     core_next_state < PWRDM_POWER_ON)) {
+	    (per_next_state < PWRDM_FUNC_PWRST_ON ||
+	     core_next_state < PWRDM_FUNC_PWRST_ON)) {
 		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
 					     PM_WKEN);
 		if (omap3_has_io_chain_ctrl())
@@ -418,7 +422,7 @@ static int omap3_pm_suspend(void)
 
 	/* Read current next_pwrsts */
 	list_for_each_entry(pwrst, &pwrst_list, node)
-		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
+		pwrst->saved_state = pwrdm_read_next_func_pwrst(pwrst->pwrdm);
 	/* Set ones wanted by suspend */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		if (omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state))
@@ -434,7 +438,7 @@ static int omap3_pm_suspend(void)
 restore:
 	/* Restore next_pwrsts */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
-		state = pwrdm_read_prev_pwrst(pwrst->pwrdm);
+		state = pwrdm_read_prev_func_pwrst(pwrst->pwrdm);
 		if (state > pwrst->next_state) {
 			pr_info("Powerdomain (%s) didn't enter "
 				"target state %d\n",
@@ -608,15 +612,15 @@ void omap3_pm_off_mode_enable(int enable)
 	u32 state;
 
 	if (enable)
-		state = PWRDM_POWER_OFF;
+		state = PWRDM_FUNC_PWRST_OFF;
 	else
-		state = PWRDM_POWER_RET;
+		state = PWRDM_FUNC_PWRST_CSWR;
 
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583) &&
 				pwrst->pwrdm == core_pwrdm &&
-				state == PWRDM_POWER_OFF) {
-			pwrst->next_state = PWRDM_POWER_RET;
+				state == PWRDM_FUNC_PWRST_OFF) {
+			pwrst->next_state = PWRDM_FUNC_PWRST_CSWR;
 			pr_warn("%s: Core OFF disabled due to errata i583\n",
 				__func__);
 		} else {
@@ -661,7 +665,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_RET;
+	pwrst->next_state = PWRDM_FUNC_PWRST_CSWR;
 	list_add(&pwrst->node, &pwrst_list);
 
 	if (pwrdm_has_hdwr_sar(pwrdm))
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index ea24174..98bb699 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -44,7 +44,7 @@ static int omap4_pm_suspend(void)
 
 	/* Save current powerdomain state */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
-		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
+		pwrst->saved_state = pwrdm_read_next_func_pwrst(pwrst->pwrdm);
 		pwrst->saved_logic_state = pwrdm_read_logic_retst(pwrst->pwrdm);
 	}
 
@@ -63,11 +63,11 @@ static int omap4_pm_suspend(void)
 	 * domain CSWR is not supported by hardware.
 	 * More details can be found in OMAP4430 TRM section 4.3.4.2.
 	 */
-	omap4_enter_lowpower(cpu_id, PWRDM_POWER_OFF);
+	omap4_enter_lowpower(cpu_id, PWRDM_FUNC_PWRST_OFF);
 
 	/* Restore next powerdomain state */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
-		state = pwrdm_read_prev_pwrst(pwrst->pwrdm);
+		state = pwrdm_read_prev_func_pwrst(pwrst->pwrdm);
 		if (state > pwrst->next_state) {
 			pr_info("Powerdomain (%s) didn't enter "
 			       "target state %d\n",
@@ -113,7 +113,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 		return -ENOMEM;
 
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_RET;
+	pwrst->next_state = PWRDM_FUNC_PWRST_CSWR;
 	list_add(&pwrst->node, &pwrst_list);
 
 	return omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index e79b5ae..ec2b21c 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -270,7 +270,7 @@ int pwrdm_complete_init(void)
 		return -EACCES;
 
 	list_for_each_entry(temp_p, &pwrdm_list, node)
-		pwrdm_set_next_pwrst(temp_p, PWRDM_POWER_ON);
+		omap_set_pwrdm_state(temp_p, PWRDM_FUNC_PWRST_ON);
 
 	return 0;
 }
-- 
1.7.7.6

