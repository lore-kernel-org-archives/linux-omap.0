From: Rajendra Nayak <rnayak@ti.com>
Subject: RFC: Simplification of Power Domain Control
Date: Thu, 5 Jul 2012 18:17:41 +0530
Message-ID: <1341492461-24119-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43247 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082Ab2GEMsL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jul 2012 08:48:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, j-pihet@ti.com, khilman@ti.com, rnayak@ti.com
Cc: santosh.shilimkar@ti.com, b-cousson@ti.com, dderrick@ti.com, linux-omap@vger.kernel.org

Hi,

This RFC is aimed at simplifying the powerdomain control
(in software) for OMAP. Powerdomains on OMAP have been
fairly complex to program (as compared to other SoCs)
mainly due to the multiple memory/logic control exposed
to software. These controls are limited to achieving
whats know as 'OSWR: Open Switch Retention' state in OMAP.
Rest of the states supported (ON, INACTIVE, CSWR, OFF) are
fairly easy to program needing just a target power state
to be configured.

While in theory, the hardware does expose multiple ways/
combinations in which OSWR can be achieved, we in software
have always been  using just *one* combination all along.
OSWR has always been configured as *logic lost, all memory
retained* for all current OMAPs supported.

With future OMAPs planning to get rid of all the memory/logic
control altogether it makes sense to look at the apis exposed 
through the current powerdomain framework to its users (like
cpuilde, suspend etc) and see if those could also be simplified.

The RFC is suspend tested on OMAP4430sdp and 
OMAP3630Beagle-Xm.

regards,
Rajendra

----
>From 5f5e4eb342110286bf719c7d9d7c1959f53e34f9 Mon Sep 17 00:00:00 2001
From: Rajendra Nayak <rnayak@ti.com>
Date: Thu, 5 Jul 2012 17:33:28 +0530
Subject: [RFC] ARM: OMAP: Powerdomain: control memory and logic bits internally

Powerdomain framework exposes various apis for memory and logic
control for powerdomains, for its users to program OSWR: Open SWitch
Retention state. While in theory, there are various combinations of
memory and logic states possible which can be configured as OSWR,
in practice all OMAPs use just one combination. Logic lost, memory retained.

This can very easily be handled within the powerdomain framework itself,
without exposing all complex memory/logic control apis to upper layer
drivers like cpuidle and suspend.

To do this, introduce 2 new power domain states PWRDM_POWER_CSWR and
PWRDM_POWER_OSWR usable by the users of powerdomain framework and
make all memory/logic control apis internal to powerdomain framework.
Change all users of powerdomain framework to get rid of all usage
of memory/logic control apis and use the newly defined states for
CSWR and OSWR with the already used powerstate control apis.

Some functions (which are now made internal) are forward declared
to avoid moving functions around in the file (which can be done in a
later patch) to help keep the patch reviewable.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c                |    9 +---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c        |    7 +--
 arch/arm/mach-omap2/pm24xx.c                     |   17 +------
 arch/arm/mach-omap2/pm34xx.c                     |    8 ++--
 arch/arm/mach-omap2/pm44xx.c                     |   11 +---
 arch/arm/mach-omap2/powerdomain-private.h        |   17 +++++++
 arch/arm/mach-omap2/powerdomain.c                |   54 +++++++++++++++++++---
 arch/arm/mach-omap2/powerdomain.h                |   14 +-----
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |    1 +
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |    1 +
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |    1 +
 arch/arm/mach-omap2/powerdomains44xx_data.c      |    1 +
 12 files changed, 85 insertions(+), 56 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomain-private.h

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index be1617c..d40fe90 100644
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
 		.cpu_state = PWRDM_POWER_ON,
 		.mpu_state = PWRDM_POWER_ON,
-		.mpu_logic_state = PWRDM_POWER_RET,
 	},
 	{
 		.cpu_state = PWRDM_POWER_OFF,
-		.mpu_state = PWRDM_POWER_RET,
-		.mpu_logic_state = PWRDM_POWER_RET,
+		.mpu_state = PWRDM_POWER_CSWR,
 	},
 	{
 		.cpu_state = PWRDM_POWER_OFF,
-		.mpu_state = PWRDM_POWER_RET,
-		.mpu_logic_state = PWRDM_POWER_OFF,
+		.mpu_state = PWRDM_POWER_OSWR,
 	},
 };
 
@@ -95,7 +91,6 @@ static int omap4_enter_idle(struct cpuidle_device *dev,
 	if (cx->cpu_state == PWRDM_POWER_OFF)
 		cpu_pm_enter();
 
-	pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
 	omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
 
 	/*
diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 13670aa..41d559b 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -125,7 +125,7 @@ static void scu_pwrst_prepare(unsigned int cpu_id, unsigned int cpu_state)
 	u32 scu_pwr_st;
 
 	switch (cpu_state) {
-	case PWRDM_POWER_RET:
+	case PWRDM_POWER_OSWR:
 		scu_pwr_st = SCU_PM_DORMANT;
 		break;
 	case PWRDM_POWER_OFF:
@@ -243,7 +243,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	case PWRDM_POWER_OFF:
 		save_state = 1;
 		break;
-	case PWRDM_POWER_RET:
+	case PWRDM_POWER_CSWR:
 	default:
 		/*
 		 * CPUx CSWR is invalid hardware state. Also CPUx OSWR
@@ -262,8 +262,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	 * In MPUSS OSWR or device OFF, interrupt controller  contest is lost.
 	 */
 	mpuss_clear_prev_logic_pwrst();
-	if ((pwrdm_read_next_pwrst(mpuss_pd) == PWRDM_POWER_RET) &&
-		(pwrdm_read_logic_retst(mpuss_pd) == PWRDM_POWER_OFF))
+	if (pwrdm_read_next_pwrst(mpuss_pd) == PWRDM_POWER_OSWR)
 		save_state = 2;
 
 	cpu_clear_prev_logic_pwrst(cpu);
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 2edeffc..fe60d31 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -93,8 +93,7 @@ static int omap2_enter_full_retention(void)
 	 * Set MPU powerdomain's next power state to RETENTION;
 	 * preserve logic state during retention
 	 */
-	pwrdm_set_logic_retst(mpu_pwrdm, PWRDM_POWER_RET);
-	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_RET);
+	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_CSWR);
 
 	/* Workaround to kill USB */
 	l = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0) | OMAP24XX_USBSTANDBYCTRL;
@@ -232,7 +231,6 @@ out:
 
 static void __init prcm_setup_regs(void)
 {
-	int i, num_mem_banks;
 	struct powerdomain *pwrdm;
 
 	/*
@@ -242,23 +240,14 @@ static void __init prcm_setup_regs(void)
 	omap2_prm_write_mod_reg(OMAP24XX_AUTOIDLE_MASK, OCP_MOD,
 			  OMAP2_PRCM_SYSCONFIG_OFFSET);
 
-	/*
-	 * Set CORE powerdomain memory banks to retain their contents
-	 * during RETENTION
-	 */
-	num_mem_banks = pwrdm_get_mem_bank_count(core_pwrdm);
-	for (i = 0; i < num_mem_banks; i++)
-		pwrdm_set_mem_retst(core_pwrdm, i, PWRDM_POWER_RET);
-
 	/* Set CORE powerdomain's next power state to RETENTION */
-	pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_RET);
+	pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_CSWR);
 
 	/*
 	 * Set MPU powerdomain's next power state to RETENTION;
 	 * preserve logic state during retention
 	 */
-	pwrdm_set_logic_retst(mpu_pwrdm, PWRDM_POWER_RET);
-	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_RET);
+	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_CSWR);
 
 	/* Force-power down DSP, GFX powerdomains */
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 3a595e8..6ae3b4d 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -279,7 +279,7 @@ void omap_sram_idle(void)
 	mpu_next_state = pwrdm_read_next_pwrst(mpu_pwrdm);
 	switch (mpu_next_state) {
 	case PWRDM_POWER_ON:
-	case PWRDM_POWER_RET:
+	case PWRDM_POWER_CSWR:
 		/* No need to save context */
 		save_state = 0;
 		break;
@@ -610,13 +610,13 @@ void omap3_pm_off_mode_enable(int enable)
 	if (enable)
 		state = PWRDM_POWER_OFF;
 	else
-		state = PWRDM_POWER_RET;
+		state = PWRDM_POWER_CSWR;
 
 	list_for_each_entry(pwrst, &pwrst_list, node) {
 		if (IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583) &&
 				pwrst->pwrdm == core_pwrdm &&
 				state == PWRDM_POWER_OFF) {
-			pwrst->next_state = PWRDM_POWER_RET;
+			pwrst->next_state = PWRDM_POWER_CSWR;
 			pr_warn("%s: Core OFF disabled due to errata i583\n",
 				__func__);
 		} else {
@@ -661,7 +661,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_RET;
+	pwrst->next_state = PWRDM_POWER_CSWR;
 	list_add(&pwrst->node, &pwrst_list);
 
 	if (pwrdm_has_hdwr_sar(pwrdm))
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index ea24174..2029740 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -43,16 +43,12 @@ static int omap4_pm_suspend(void)
 	u32 cpu_id = smp_processor_id();
 
 	/* Save current powerdomain state */
-	list_for_each_entry(pwrst, &pwrst_list, node) {
+	list_for_each_entry(pwrst, &pwrst_list, node)
 		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
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
@@ -75,7 +71,6 @@ static int omap4_pm_suspend(void)
 			ret = -1;
 		}
 		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
-		pwrdm_set_logic_retst(pwrst->pwrdm, pwrst->saved_logic_state);
 	}
 	if (ret)
 		pr_crit("Could not enter target state in pm_suspend\n");
@@ -113,7 +108,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 		return -ENOMEM;
 
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_RET;
+	pwrst->next_state = PWRDM_POWER_CSWR;
 	list_add(&pwrst->node, &pwrst_list);
 
 	return omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
diff --git a/arch/arm/mach-omap2/powerdomain-private.h b/arch/arm/mach-omap2/powerdomain-private.h
new file mode 100644
index 0000000..0c2dd23
--- /dev/null
+++ b/arch/arm/mach-omap2/powerdomain-private.h
@@ -0,0 +1,17 @@
+/*
+ * Internal powerdomain header
+ *
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_POWERDOMAIN_PRIVATE_H
+#define __ARCH_ARM_MACH_OMAP2_POWERDOMAIN_PRIVATE_H
+
+#define PWRDM_POWER_RET		0x1
+
+#endif /* __ARCH_ARM_MACH_OMAP2_POWERDOMAIN_PRIVATE_H */
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 9611490..79e3b28 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -30,6 +30,7 @@
 #include <asm/cpu.h>
 #include <plat/cpu.h>
 #include "powerdomain.h"
+#include "powerdomain-private.h"
 #include "clockdomain.h"
 #include <plat/prcm.h>
 
@@ -42,6 +43,13 @@ enum {
 	PWRDM_STATE_PREV,
 };
 
+/* Fwd declarations */
+static int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst);
+static int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
+static int pwrdm_read_logic_retst(struct powerdomain *pwrdm);
+static int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm);
+static int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
+static int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm);
 
 /* pwrdm_list contains all registered struct powerdomains */
 static LIST_HEAD(pwrdm_list);
@@ -477,7 +485,7 @@ int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm)
  */
 int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 {
-	int ret = -EINVAL;
+	int ret = -EINVAL, i, num_mem_banks;
 
 	if (!pwrdm)
 		return -EINVAL;
@@ -488,6 +496,20 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 	pr_debug("powerdomain: setting next powerstate for %s to %0x\n",
 		 pwrdm->name, pwrst);
 
+	switch (pwrst) {
+	case PWRDM_POWER_CSWR:
+	case PWRDM_POWER_OSWR:
+		if (pwrst == PWRDM_POWER_OSWR)
+			pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_OFF);
+		num_mem_banks = pwrdm_get_mem_bank_count(pwrdm);
+		for (i = 0; i < num_mem_banks; i++)
+			pwrdm_set_mem_retst(pwrdm, i, PWRDM_POWER_RET);
+		pwrst = PWRDM_POWER_RET;
+		break;
+	default:
+		break;
+	}
+
 	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
 		/* Trace the pwrdm desired target state */
 		trace_power_domain_target(pwrdm->name, pwrst,
@@ -517,6 +539,12 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 	if (arch_pwrdm && arch_pwrdm->pwrdm_read_next_pwrst)
 		ret = arch_pwrdm->pwrdm_read_next_pwrst(pwrdm);
 
+	if (ret == PWRDM_POWER_RET) {
+		if (pwrdm_read_logic_retst(pwrdm) == PWRDM_POWER_OFF)
+			ret = PWRDM_POWER_OSWR;
+		else
+			ret = PWRDM_POWER_CSWR;
+	}
 	return ret;
 }
 
@@ -538,6 +566,12 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
 	if (arch_pwrdm && arch_pwrdm->pwrdm_read_pwrst)
 		ret = arch_pwrdm->pwrdm_read_pwrst(pwrdm);
 
+	if (ret == PWRDM_POWER_RET) {
+		if (pwrdm_read_logic_pwrst(pwrdm) == PWRDM_POWER_OFF)
+			ret = PWRDM_POWER_OSWR;
+		else
+			ret = PWRDM_POWER_CSWR;
+	}
 	return ret;
 }
 
@@ -559,6 +593,12 @@ int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 	if (arch_pwrdm && arch_pwrdm->pwrdm_read_prev_pwrst)
 		ret = arch_pwrdm->pwrdm_read_prev_pwrst(pwrdm);
 
+	if (ret == PWRDM_POWER_RET) {
+		if (pwrdm_read_prev_logic_pwrst(pwrdm) == PWRDM_POWER_OFF)
+			ret = PWRDM_POWER_OSWR;
+		else
+			ret = PWRDM_POWER_CSWR;
+	}
 	return ret;
 }
 
@@ -573,7 +613,7 @@ int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
  * -EINVAL if the powerdomain pointer is null or the target power
  * state is not not supported, or returns 0 upon success.
  */
-int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
+static int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 {
 	int ret = -EINVAL;
 
@@ -645,7 +685,7 @@ int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
  * bank does not exist or is not controllable, or returns 0 upon
  * success.
  */
-int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
+static int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 {
 	int ret = -EINVAL;
 
@@ -676,7 +716,7 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
  * if the powerdomain pointer is null or returns the logic retention
  * power state upon success.
  */
-int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
+static int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
 {
 	int ret = -EINVAL;
 
@@ -697,7 +737,7 @@ int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
  * -EINVAL if the powerdomain pointer is null or returns the previous
  * logic power state upon success.
  */
-int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
+static int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
 {
 	int ret = -EINVAL;
 
@@ -718,7 +758,7 @@ int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
  * if the powerdomain pointer is null or returns the next logic
  * power state upon success.
  */
-int pwrdm_read_logic_retst(struct powerdomain *pwrdm)
+static int pwrdm_read_logic_retst(struct powerdomain *pwrdm)
 {
 	int ret = -EINVAL;
 
@@ -771,7 +811,7 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
  * controllable, or returns the previous memory power state upon
  * success.
  */
-int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
+static int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 {
 	int ret = -EINVAL;
 
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 8f88d65..57d9953 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -28,9 +28,10 @@
 
 /* Powerdomain basic power states */
 #define PWRDM_POWER_OFF		0x0
-#define PWRDM_POWER_RET		0x1
 #define PWRDM_POWER_INACTIVE	0x2
 #define PWRDM_POWER_ON		0x3
+#define PWRDM_POWER_CSWR	0x4
+#define PWRDM_POWER_OSWR	0x5
 
 #define PWRDM_MAX_PWRSTS	4
 
@@ -195,17 +196,6 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm);
 int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm);
 
-int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst);
-int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
-int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
-
-int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm);
-int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm);
-int pwrdm_read_logic_retst(struct powerdomain *pwrdm);
-int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
-int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
-int pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank);
-
 int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm);
 int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm);
 bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
index d3a5399..de8c67f 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
@@ -32,6 +32,7 @@
  */
 
 #include "powerdomain.h"
+#include "powerdomain-private.h"
 
 #include "prcm-common.h"
 #include "prm.h"
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_data.c
index 2385c1f..170462f 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_data.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 
 #include "powerdomain.h"
+#include "powerdomain-private.h"
 #include "powerdomains2xxx_3xxx_data.h"
 
 #include "prcm-common.h"
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index fb0a0a6..9aa847b 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -18,6 +18,7 @@
 #include <plat/cpu.h>
 
 #include "powerdomain.h"
+#include "powerdomain-private.h"
 #include "powerdomains2xxx_3xxx_data.h"
 
 #include "prcm-common.h"
diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index 704664c..4f8c9ee 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 
 #include "powerdomain.h"
+#include "powerdomain-private.h"
 
 #include "prcm-common.h"
 #include "prcm44xx.h"
-- 
1.7.1

