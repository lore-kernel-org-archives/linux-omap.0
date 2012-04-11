From: jean.pihet@newoldbits.com
Subject: [PATCH 5/6] ARM: OMAP2+: PM: use the functional power states API for logic and memory
Date: Wed, 11 Apr 2012 22:46:11 +0200
Message-ID: <1334177172-28583-6-git-send-email-j-pihet@ti.com>
References: <1334177172-28583-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:64961 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933164Ab2DKUqs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 16:46:48 -0400
Received: by wibhj6 with SMTP id hj6so4802402wib.1
        for <linux-omap@vger.kernel.org>; Wed, 11 Apr 2012 13:46:47 -0700 (PDT)
In-Reply-To: <1334177172-28583-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ldc_pm_all@list.ti.com, linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Since the power domains logic state is derived from the power domain
functional state and is now programmed from omap_set_pwrdm_state,
the calls to pwrdm_set_logic_retst are removed and the mpu_logic_state
field is removed from the private data of the cpuidle and suspend code.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c         |    9 +--------
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    6 +-----
 arch/arm/mach-omap2/pm24xx.c              |    4 +---
 arch/arm/mach-omap2/pm44xx.c              |    7 +------
 4 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 1daa0c1..9d99696 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -27,7 +27,6 @@
 /* Machine specific information to be recorded in the C-state driver_data */
 struct omap4_idle_statedata {
 	u32 cpu_state;
-	u32 mpu_logic_state;
 	u32 mpu_state;
 	u8 valid;
 };
@@ -91,16 +90,13 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	if (cx->cpu_state == PWRDM_FUNC_PWRST_OFF)
 		cpu_pm_enter();
 
-	pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
 	omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
 
 	/*
 	 * Call idle CPU cluster PM enter notifier chain
 	 * to save GIC and wakeupgen context.
 	 */
-	if (((cx->mpu_state == PWRDM_FUNC_PWRST_CSWR) ||
-	     (cx->mpu_state == PWRDM_FUNC_PWRST_OSWR)) &&
-	    (cx->mpu_logic_state == PWRDM_POWER_OFF))
+	if (cx->mpu_state == PWRDM_FUNC_PWRST_OSWR)
 			cpu_cluster_pm_enter();
 
 	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
@@ -195,21 +191,18 @@ int __init omap4_idle_init(void)
 	cx->valid = 1;	/* C1 is always valid */
 	cx->cpu_state = PWRDM_FUNC_PWRST_ON;
 	cx->mpu_state = PWRDM_FUNC_PWRST_ON;
-	cx->mpu_logic_state = PWRDM_POWER_RET;
 
 	/* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
 	_fill_cstate(drv, 1, "MPUSS CSWR");
 	cx = _fill_cstate_usage(dev, 1);
 	cx->cpu_state = PWRDM_FUNC_PWRST_OFF;
 	cx->mpu_state = PWRDM_FUNC_PWRST_CSWR;
-	cx->mpu_logic_state = PWRDM_POWER_RET;
 
 	/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
 	_fill_cstate(drv, 2, "MPUSS OSWR");
 	cx = _fill_cstate_usage(dev, 2);
 	cx->cpu_state = PWRDM_FUNC_PWRST_OFF;
 	cx->mpu_state = PWRDM_FUNC_PWRST_OSWR;
-	cx->mpu_logic_state = PWRDM_POWER_OFF;
 
 	drv->state_count = OMAP4_NUM_STATES;
 	cpuidle_register_driver(&omap4_idle_driver);
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index dd94a0e..c79cc0f 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -232,7 +232,6 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 {
 	unsigned int save_state = 0;
 	unsigned int wakeup_cpu;
-	int mpuss_state;
 
 	if (omap_rev() == OMAP4430_REV_ES1_0)
 		return -ENXIO;
@@ -265,10 +264,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	 * In MPUSS OSWR or device OFF, interrupt controller context is lost.
 	 */
 	mpuss_clear_prev_logic_pwrst();
-	mpuss_state = pwrdm_read_next_func_pwrst(mpuss_pd);
-	if (((mpuss_state == PWRDM_FUNC_PWRST_CSWR) ||
-	     (mpuss_state == PWRDM_FUNC_PWRST_OSWR)) &&
-	    (pwrdm_read_logic_retst(mpuss_pd) == PWRDM_POWER_OFF))
+	if (pwrdm_read_next_func_pwrst(mpuss_pd) == PWRDM_FUNC_PWRST_OSWR)
 		save_state = 2;
 
 	cpu_clear_prev_logic_pwrst(cpu);
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index bb84348..fbadc37 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -93,7 +93,6 @@ static int omap2_enter_full_retention(void)
 	 * Set MPU powerdomain's next power state to RETENTION;
 	 * preserve logic state during retention
 	 */
-	pwrdm_set_logic_retst(mpu_pwrdm, PWRDM_POWER_RET);
 	omap_set_pwrdm_state(mpu_pwrdm, PWRDM_FUNC_PWRST_CSWR);
 
 	/* Workaround to kill USB */
@@ -251,7 +250,7 @@ static void __init prcm_setup_regs(void)
 	 */
 	num_mem_banks = pwrdm_get_mem_bank_count(core_pwrdm);
 	for (i = 0; i < num_mem_banks; i++)
-		pwrdm_set_mem_retst(core_pwrdm, i, PWRDM_POWER_RET);
+		pwrdm_set_mem_retst(core_pwrdm, i, PWRDM_LOGIC_MEM_PWRST_RET);
 
 	/* Set CORE powerdomain's next power state to RETENTION */
 	omap_set_pwrdm_state(core_pwrdm, PWRDM_FUNC_PWRST_CSWR);
@@ -260,7 +259,6 @@ static void __init prcm_setup_regs(void)
 	 * Set MPU powerdomain's next power state to RETENTION;
 	 * preserve logic state during retention
 	 */
-	pwrdm_set_logic_retst(mpu_pwrdm, PWRDM_POWER_RET);
 	omap_set_pwrdm_state(mpu_pwrdm, PWRDM_FUNC_PWRST_CSWR);
 
 	/* Force-power down DSP, GFX powerdomains */
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 897fdee..6c3caf3 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -28,7 +28,6 @@ struct power_state {
 	u32 next_state;
 #ifdef CONFIG_SUSPEND
 	u32 saved_state;
-	u32 saved_logic_state;
 #endif
 	struct list_head node;
 };
@@ -45,14 +44,11 @@ static int omap4_pm_suspend(void)
 	/* Save current powerdomain state */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		pwrst->saved_state = pwrdm_read_next_func_pwrst(pwrst->pwrdm);
-		pwrst->saved_logic_state = pwrdm_read_logic_retst(pwrst->pwrdm);
 	}
 
 	/* Set targeted power domain states by suspend */
-	list_for_each_entry(pwrst, &pwrst_list, node) {
+	list_for_each_entry(pwrst, &pwrst_list, node)
 		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
-		pwrdm_set_logic_retst(pwrst->pwrdm, PWRDM_POWER_OFF);
-	}
 
 	/*
 	 * For MPUSS to hit power domain retention(CSWR or OSWR),
@@ -75,7 +71,6 @@ static int omap4_pm_suspend(void)
 			ret = -1;
 		}
 		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
-		pwrdm_set_logic_retst(pwrst->pwrdm, pwrst->saved_logic_state);
 	}
 	if (ret)
 		pr_crit("Could not enter target state in pm_suspend\n");
-- 
1.7.7.6

