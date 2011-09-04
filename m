From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 18/25] OMAP4: suspend: Add MPUSS power domain RETENTION support
Date: Sun, 4 Sep 2011 19:24:19 +0530
Message-ID: <1315144466-9395-19-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36816 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754619Ab1IDN4M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 4 Sep 2011 09:56:12 -0400
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch adds MPUSS(MPU Sub System) power domain
CSWR(Close Switch Retention) support to system wide suspend.
For both MPUSS RET support, CPUs are programmed to OFF state.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap-mpuss-lowpower.c |   16 +++++++
 arch/arm/mach-omap2/pm44xx.c              |   71 +++++++++++++++++++++++++++--
 2 files changed, 82 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-mpuss-lowpower.c b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
index 9d68abf..9f632fe 100644
--- a/arch/arm/mach-omap2/omap-mpuss-lowpower.c
+++ b/arch/arm/mach-omap2/omap-mpuss-lowpower.c
@@ -66,6 +66,7 @@ struct omap4_cpu_pm_info {
 };
 
 static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
+static struct powerdomain *mpuss_pd;
 
 /*
  * Program the wakeup routine address for the CPU0 and CPU1
@@ -140,6 +141,13 @@ static void scu_pwrst_prepare(unsigned int cpu_id, unsigned int cpu_state)
  * of OMAP4 MPUSS subsystem
  * @cpu : CPU ID
  * @power_state: Low power state.
+ *
+ * MPUSS states for the context save:
+ * save_state =
+ *	0 - Nothing lost and no need to save: MPUSS INACTIVE
+ *	1 - CPUx L1 and logic lost: MPUSS CSWR
+ *	2 - CPUx L1 and logic lost + GIC lost: MPUSS OSWR
+ *	3 - CPUx L1 and logic lost + GIC + L2 lost: DEVICE OFF
  */
 int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 {
@@ -169,6 +177,7 @@ int omap4_enter_lowpower(unsigned int cpu, unsigned int power_state)
 		return -ENXIO;
 	}
 
+	pwrdm_clear_all_prev_pwrst(mpuss_pd);
 	clear_cpu_prev_pwrst(cpu);
 	set_cpu_next_pwrst(cpu, power_state);
 	set_cpu_wakeup_addr(cpu, virt_to_phys(omap4_cpu_resume));
@@ -270,6 +279,13 @@ int __init omap4_mpuss_init(void)
 	/* Initialise CPU1 power domain state to ON */
 	pwrdm_set_next_pwrst(pm_info->pwrdm, PWRDM_POWER_ON);
 
+	mpuss_pd = pwrdm_lookup("mpu_pwrdm");
+	if (!mpuss_pd) {
+		pr_err("Failed to lookup MPUSS power domain\n");
+		return -ENODEV;
+	}
+	pwrdm_clear_all_prev_pwrst(mpuss_pd);
+
 	/* Save device type on scratchpad for low level code to use */
 	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
 		__raw_writel(1, sar_base + OMAP_TYPE_OFFSET);
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 4f39de5..63e8f9b 100644
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
@@ -16,9 +17,11 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
+#include <mach/omap4-common.h>
+
 #include "powerdomain.h"
 #include "clockdomain.h"
-#include <mach/omap4-common.h>
+#include "pm.h"
 
 struct power_state {
 	struct powerdomain *pwrdm;
@@ -34,7 +37,48 @@ static LIST_HEAD(pwrst_list);
 #ifdef CONFIG_SUSPEND
 static int omap4_pm_suspend(void)
 {
-	omap_do_wfi();
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
+		omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
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
 
@@ -97,14 +141,31 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
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
+	/*
+	 * FIXME: Remove this check when core retention is supported
+	 * Only MPUSS power domain is added in the list.
+	 */
+	if (strcmp(pwrdm->name, "mpu_pwrdm"))
+		return 0;
+
 	pwrst = kmalloc(sizeof(struct power_state), GFP_ATOMIC);
 	if (!pwrst)
 		return -ENOMEM;
+
 	pwrst->pwrdm = pwrdm;
-	pwrst->next_state = PWRDM_POWER_ON;
+	pwrst->next_state = PWRDM_POWER_RET;
 	list_add(&pwrst->node, &pwrst_list);
 
-	return pwrdm_set_next_pwrst(pwrst->pwrdm, pwrst->next_state);
+	return omap_set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
 }
 
 /**
-- 
1.7.4.1

