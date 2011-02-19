From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 11/17] omap4: suspend: Add MPUSS RET and OFF support
Date: Sat, 19 Feb 2011 16:12:32 +0530
Message-ID: <1298112158-28469-12-git-send-email-santosh.shilimkar@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50545 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754020Ab1BSKm5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 05:42:57 -0500
In-Reply-To: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds MPUSS(MPU Sub System) RET and OFF mode support
to suspend path. For both MPUSS RET and OFF support, CPUs are
programmed to OFF state.

Only MPUSS RET and OFF supported at this point of time. CORE RET
will be added subsequently.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap4-mpuss-lowpower.c |    8 ++-
 arch/arm/mach-omap2/pm-debug.c             |    2 +
 arch/arm/mach-omap2/pm.h                   |    1 +
 arch/arm/mach-omap2/pm44xx.c               |   88 ++++++++++++++++++++++++++--
 4 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
index bff768f..ab2e101 100644
--- a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
@@ -25,7 +25,7 @@
  *	ON(Inactive)	OFF		ON(Inactive)
  *	OFF		OFF		CSWR
  *	OFF		OFF		OSWR (*TBD)
- *	OFF		OFF		OFF* (*TBD)
+ *	OFF		OFF		OFF
  *	----------------------------------------------
  *
  * Note: CPU0 is the master core and it is the last CPU to go down
@@ -291,6 +291,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 	 * Check MPUSS next state and save GIC if needed
 	 * GIC lost during MPU OFF and OSWR
 	 */
+	pwrdm_clear_all_prev_pwrst(mpuss_pd);
 	if (pwrdm_read_next_pwrst(mpuss_pd) == PWRDM_POWER_OFF) {
 		omap_wakeupgen_save();
 		gic_save_context();
@@ -357,6 +358,8 @@ int __init omap4_mpuss_init(void)
 		pr_err("Lookup failed for CPU0 pwrdm\n");
 		return -ENODEV;
 	}
+	/* Clear CPU previous power domain state */
+	pwrdm_clear_all_prev_pwrst(pm_info->pwrdm);
 
 	/* Clear CPU previous power domain state */
 	pwrdm_clear_all_prev_pwrst(pm_info->pwrdm);
@@ -394,6 +397,9 @@ int __init omap4_mpuss_init(void)
 		return -ENODEV;
 	}
 
+	/* Clear CPU previous power domain state */
+	pwrdm_clear_all_prev_pwrst(mpuss_pd);
+
 	/*
 	 * Find out how many interrupts are supported.
 	 * OMAP4 supports max of 128 SPIs where as GIC can support
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 125f565..9b46b3e 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -588,6 +588,8 @@ static int option_set(void *data, u64 val)
 			omap_pm_disable_off_mode();
 		if (cpu_is_omap34xx())
 			omap3_pm_off_mode_enable(val);
+		else if (cpu_is_omap44xx())
+			omap4_pm_off_mode_enable(val);
 	}
 
 	return 0;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 1c1b0ab..f557407 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -17,6 +17,7 @@
 
 extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
+extern void omap4_pm_off_mode_enable(int);
 extern void omap_sram_idle(void);
 extern int omap3_can_sleep(void);
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 9a9dc41..f527e33 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -1,8 +1,9 @@
 /*
  * OMAP4 Power Management Routines
  *
- * Copyright (C) 2010 Texas Instruments, Inc.
+ * Copyright (C) 2010-2011 Texas Instruments, Inc.
  * Rajendra Nayak <rnayak@ti.com>
+ * Santosh Shilimkar <santosh.shilimkar@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -21,6 +22,7 @@
 
 #include "powerdomain.h"
 #include "clockdomain.h"
+#include "pm.h"
 
 struct power_state {
 	struct powerdomain *pwrdm;
@@ -36,7 +38,50 @@ static LIST_HEAD(pwrst_list);
 #ifdef CONFIG_SUSPEND
 static int omap4_pm_suspend(void)
 {
-	do_wfi();
+	struct power_state *pwrst;
+	int state, ret = 0;
+	u32 cpu_id = smp_processor_id();
+
+	/* Save current powerdomain state */
+	list_for_each_entry(pwrst, &pwrst_list, node) {
+		pwrst->saved_state = pwrdm_read_next_pwrst(pwrst->pwrdm);
+	}
+
+	/* Set targeted power domain states by suspend */
+	list_for_each_entry(pwrst, &pwrst_list, node) {
+		/* FIXME: Remove this check when CORE retention is supported */
+		if (!strcmp(pwrst->pwrdm->name, "mpu_pwrdm"))
+			omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
+	}
+
+	/*
+	 * For MPUSS to hit power domain retention(CSWR or OSWR),
+	 * CPU0 and CPU1 power domain needs to be in OFF or DORMANT
+	 * state. For MPUSS to reach off-mode. CPU0 and CPU1 power domain
+	 * should be in off state.
+	 * Only master CPU followes suspend path. All other CPUs follow
+	 * cpu-hotplug path in system wide suspend. On OMAP4, CPU power
+	 * domain CSWR is not supported by hardware.
+	 * More details can be found in OMAP4430 TRM section 4.3.4.2.
+	 */
+	omap4_enter_lowpower(cpu_id, PWRDM_POWER_OFF);
+
+	/* Restore next powerdomain state */
+	list_for_each_entry(pwrst, &pwrst_list, node) {
+		state = pwrdm_read_prev_pwrst(pwrst->pwrdm);
+		if (state > pwrst->next_state) {
+			pr_info("Powerdomain (%s) didn't enter "
+			       "target state %d\n",
+			       pwrst->pwrdm->name, pwrst->next_state);
+			ret = -1;
+		}
+		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->saved_state);
+	}
+	if (ret)
+		pr_err("Could not enter target state in pm_suspend\n");
+	else
+		pr_err("Successfully put all powerdomains to target state\n");
+
 	return 0;
 }
 
@@ -91,7 +136,6 @@ static int __init clkdms_setup(struct clockdomain *clkdm, void *unused)
 	return 0;
 }
 
-
 static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
 	struct power_state *pwrst;
@@ -99,14 +143,48 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 	if (!pwrdm->pwrsts)
 		return 0;
 
+	/*
+	 * Skip CPU0 and CPU1 power domains. CPU1 is programmed
+	 * through hotplug path and CPU0 explicitly programmed
+	 * further down in the code path
+	 */
+	if ((!strcmp(pwrdm->name, "cpu0_pwrdm")) ||
+		(!strcmp(pwrdm->name, "cpu1_pwrdm")))
+		return 0;
+
 	pwrst = kmalloc(sizeof(struct power_state), GFP_ATOMIC);
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_ON;
+
+	/* FIXME: Remove this check when core retention is supported */
+	if (!strcmp(pwrst->pwrdm->name, "mpu_pwrdm"))
+		pwrst->next_state = PWRDM_POWER_RET;
+	else
+		pwrst->next_state = PWRDM_POWER_ON;
+
 	list_add(&pwrst->node, &pwrst_list);
 
-	return pwrdm_set_next_pwrst(pwrst->pwrdm, pwrst->next_state);
+	return omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
+}
+
+void omap4_pm_off_mode_enable(int enable)
+{
+	struct power_state *pwrst;
+	u32 state;
+
+	if (enable)
+		state = PWRDM_POWER_OFF;
+	else
+		state = PWRDM_POWER_RET;
+
+	list_for_each_entry(pwrst, &pwrst_list, node) {
+		/* FIXME: Remove this check when core retention is supported */
+		if (!strcmp(pwrst->pwrdm->name, "mpu_pwrdm")) {
+			pwrst->next_state = state;
+			omap_set_pwrdm_state(pwrst->pwrdm, state);
+		}
+	}
 }
 
 /**
-- 
1.6.0.4

