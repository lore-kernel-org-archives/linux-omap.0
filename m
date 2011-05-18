From: jean.pihet@newoldbits.com
Subject: [PATCH 04/13] OMAP2+: cpuidle: register the board specific C-states table
Date: Wed, 18 May 2011 19:32:21 +0200
Message-ID: <1305739950-11695-5-git-send-email-j-pihet@ti.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63275 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910Ab1ERRcs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 13:32:48 -0400
Received: by mail-yw0-f46.google.com with SMTP id 9so445875ywe.19
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 10:32:48 -0700 (PDT)
In-Reply-To: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Register the board specific cpuidle C-states table for the cpuidle driver
to use it later at cpuidle init time.

This also cleans up the cpuidle code, in order to allow it to be used
as a module.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   13 +++++++------
 arch/arm/mach-omap2/pm.c          |   15 +++++++++++++++
 arch/arm/mach-omap2/pm.h          |    6 ++----
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 1c240ef..df92f4a 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -320,22 +320,22 @@ void omap3_cpuidle_update_states(u32 mpu_deepest_state, u32 core_deepest_state)
 	}
 }
 
-void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
+static void omap3_pm_override_cpuidle_states(void)
 {
 	int i;
 
-	if (!cpuidle_board_params)
+	if (!cpuidle_params_override_table)
 		return;
 
 	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
 		cpuidle_params_table[i].valid =
-			cpuidle_board_params[i].valid;
+			cpuidle_params_override_table[i].valid;
 		cpuidle_params_table[i].sleep_latency =
-			cpuidle_board_params[i].sleep_latency;
+			cpuidle_params_override_table[i].sleep_latency;
 		cpuidle_params_table[i].wake_latency =
-			cpuidle_board_params[i].wake_latency;
+			cpuidle_params_override_table[i].wake_latency;
 		cpuidle_params_table[i].threshold =
-			cpuidle_board_params[i].threshold;
+			cpuidle_params_override_table[i].threshold;
 	}
 	return;
 }
@@ -500,6 +500,7 @@ int __init omap3_idle_init(void)
 	per_pd = pwrdm_lookup("per_pwrdm");
 	cam_pd = pwrdm_lookup("cam_pwrdm");
 
+	omap3_pm_override_cpuidle_states();
 	omap_init_power_states();
 	cpuidle_register_driver(&omap3_idle_driver);
 
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 49486f5..84ef409 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -25,6 +25,9 @@
 #include "pm.h"
 
 static struct omap_device_pm_latency *pm_lats;
+#if defined(CONFIG_PM) && defined(CONFIG_CPU_IDLE)
+struct cpuidle_params *cpuidle_params_override_table;
+#endif
 
 static struct device *mpu_dev;
 static struct device *iva_dev;
@@ -268,3 +271,15 @@ static int __init omap2_common_pm_late_init(void)
 	return 0;
 }
 late_initcall(omap2_common_pm_late_init);
+
+#if defined(CONFIG_PM) && defined(CONFIG_CPU_IDLE)
+/*
+ * Used by the board code to override the default cpuidle C-states tables.
+ * Must be called before the cpuidle driver is registered in omap3_idle_init.
+ */
+void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
+{
+	cpuidle_params_override_table = cpuidle_board_params;
+}
+#endif
+
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 797bfd1..3ed185c 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -44,7 +44,9 @@ struct cpuidle_params {
 };
 
 #if defined(CONFIG_PM) && defined(CONFIG_CPU_IDLE)
+extern struct cpuidle_params *cpuidle_params_override_table;
 extern void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params);
+extern void omap3_cpuidle_update_states(u32, u32);
 #else
 static
 inline void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
@@ -73,10 +75,6 @@ extern u32 sleep_while_idle;
 #define sleep_while_idle 0
 #endif
 
-#if defined(CONFIG_CPU_IDLE)
-extern void omap3_cpuidle_update_states(u32, u32);
-#endif
-
 #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
 extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
 extern int pm_dbg_regset_save(int reg_set);
-- 
1.7.4.1

