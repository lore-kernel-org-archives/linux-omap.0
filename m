From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 6/8] ARM: OMAP2+: PM: use the functional power states API for logic and memory
Date: Thu, 14 Jun 2012 16:53:09 +0200
Message-ID: <1339685591-11177-7-git-send-email-j-pihet@ti.com>
References: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:52899 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756160Ab2FNOxj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 10:53:39 -0400
Received: by mail-we0-f174.google.com with SMTP id u7so1317216wey.19
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 07:53:39 -0700 (PDT)
In-Reply-To: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com
Cc: Jean Pihet <j-pihet@ti.com>

Since the power domains logic state is derived from the power domain
functional state and is now programmed from omap_set_pwrdm_state,
the calls to pwrdm_set_logic_retst are removed and the mpu_logic_state
field is removed from the private data of the cpuidle and suspend code.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c         |   11 ++---------
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    6 +-----
 arch/arm/mach-omap2/pm24xx.c              |    5 +----
 arch/arm/mach-omap2/pm44xx.c              |   10 ++--------
 4 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index 50c9082..221039a 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -27,7 +27,6 @@
 /* Machine specific information */
 struct omap4_idle_statedata {
 	u32 cpu_state;
-	u32 mpu_logic_state;
 	u32 mpu_state;
 };
 
@@ -35,17 +34,14 @@ static struct omap4_idle_statedata omap4_idle_data[] = {
 	{
 		.cpu_state = PWRDM_FUNC_PWRST_ON,
 		.mpu_state = PWRDM_FUNC_PWRST_ON,
-		.mpu_logic_state = PWRDM_POWER_RET,
 	},
 	{
 		.cpu_state = PWRDM_FUNC_PWRST_OFF,
 		.mpu_state = PWRDM_FUNC_PWRST_CSWR,
-		.mpu_logic_state = PWRDM_POWER_RET,
 	},
 	{
 		.cpu_state = PWRDM_FUNC_PWRST_OFF,
-		.mpu_state = PWRDM_FUNC_PWRST_CSWR,
-		.mpu_logic_state = PWRDM_POWER_OFF,
+		.mpu_state = PWRDM_FUNC_PWRST_OSWR,
 	},
 };
 
@@ -95,16 +91,13 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
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
index 0bed51e..fdb0767 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -93,7 +93,6 @@ static int omap2_enter_full_retention(void)
 	 * Set MPU powerdomain's next power state to RETENTION;
 	 * preserve logic state during retention
 	 */
-	pwrdm_set_logic_retst(mpu_pwrdm, PWRDM_POWER_RET);
 	omap_set_pwrdm_state(mpu_pwrdm, PWRDM_FUNC_PWRST_CSWR);
 
 	/* Workaround to kill USB */
@@ -248,7 +247,7 @@ static void __init prcm_setup_regs(void)
 	 */
 	num_mem_banks = pwrdm_get_mem_bank_count(core_pwrdm);
 	for (i = 0; i < num_mem_banks; i++)
-		pwrdm_set_mem_retst(core_pwrdm, i, PWRDM_POWER_RET);
+		pwrdm_set_mem_retst(core_pwrdm, i, PWRDM_LOGIC_MEM_PWRST_RET);
 
 	/* Set CORE powerdomain's next power state to RETENTION */
 	omap_set_pwrdm_state(core_pwrdm, PWRDM_FUNC_PWRST_CSWR);
@@ -257,11 +256,9 @@ static void __init prcm_setup_regs(void)
 	 * Set MPU powerdomain's next power state to RETENTION;
 	 * preserve logic state during retention
 	 */
-	pwrdm_set_logic_retst(mpu_pwrdm, PWRDM_POWER_RET);
 	omap_set_pwrdm_state(mpu_pwrdm, PWRDM_FUNC_PWRST_CSWR);
 
 	/* Force-power down DSP, GFX powerdomains */
-
 	pwrdm = clkdm_get_pwrdm(dsp_clkdm);
 	omap_set_pwrdm_state(pwrdm, PWRDM_FUNC_PWRST_OFF);
 	clkdm_sleep(dsp_clkdm);
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 98bb699..eb12d25 100644
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
@@ -43,16 +42,12 @@ static int omap4_pm_suspend(void)
 	u32 cpu_id = smp_processor_id();
 
 	/* Save current powerdomain state */
-	list_for_each_entry(pwrst, &pwrst_list, node) {
+	list_for_each_entry(pwrst, &pwrst_list, node)
 		pwrst->saved_state = pwrdm_read_next_func_pwrst(pwrst->pwrdm);
-		pwrst->saved_logic_state = pwrdm_read_logic_retst(pwrst->pwrdm);
-	}
 
 	/* Set targeted power domain states by suspend */
-	list_for_each_entry(pwrst, &pwrst_list, node) {
+	list_for_each_entry(pwrst, &pwrst_list, node)
 		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
-		pwrdm_set_logic_retst(pwrst->pwrdm, PWRDM_POWER_OFF);
-	}
 
 	/*
 	 * For MPUSS to hit power domain retention(CSWR or OSWR),
@@ -75,7 +70,6 @@ static int omap4_pm_suspend(void)
 			ret = -1;
 		}
 		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
-		pwrdm_set_logic_retst(pwrst->pwrdm, pwrst->saved_logic_state);
 	}
 	if (ret)
 		pr_crit("Could not enter target state in pm_suspend\n");
-- 
1.7.7.6

