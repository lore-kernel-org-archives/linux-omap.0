From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 12/18][V3] ARM: OMAP3: cpuidle - remove cpuidle_params_table
Date: Tue, 24 Apr 2012 16:05:33 +0200
Message-ID: <1335276339-11135-13-git-send-email-daniel.lezcano@linaro.org>
References: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:48974 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650Ab2DXOGF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Apr 2012 10:06:05 -0400
Received: by mail-wi0-f178.google.com with SMTP id hq7so719542wib.1
        for <linux-omap@vger.kernel.org>; Tue, 24 Apr 2012 07:06:04 -0700 (PDT)
In-Reply-To: <1335276339-11135-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

We do not longer need the ''cpuidle_params_table' array as
we defined the states in the driver and we checked they are
all valid.

We also remove the structure definition as it is no longer used.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   28 +++-------------------------
 arch/arm/mach-omap2/pm.h          |   12 ------------
 2 files changed, 3 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 29b4f87..a82a887 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -38,36 +38,14 @@
 
 #ifdef CONFIG_CPU_IDLE
 
-/*
- * The latencies/thresholds for various C states have
- * to be configured from the respective board files.
- * These are some default values (which might not provide
- * the best power savings) used on boards which do not
- * pass these details from the board file.
- */
-static struct cpuidle_params cpuidle_params_table[] = {
-	/* C1 */
-	{2 + 2, 5, 1},
-	/* C2 */
-	{10 + 10, 30, 1},
-	/* C3 */
-	{50 + 50, 300, 1},
-	/* C4 */
-	{1500 + 1800, 4000, 1},
-	/* C5 */
-	{2500 + 7500, 12000, 1},
-	/* C6 */
-	{3000 + 8500, 15000, 1},
-	/* C7 */
-	{10000 + 30000, 300000, 1},
-};
-#define OMAP3_NUM_STATES ARRAY_SIZE(cpuidle_params_table)
-
 /* Mach specific information to be recorded in the C-state driver_data */
 struct omap3_idle_statedata {
 	u32 mpu_state;
 	u32 core_state;
 };
+
+#define OMAP3_NUM_STATES 7
+
 struct omap3_idle_statedata omap3_idle_data[OMAP3_NUM_STATES];
 
 struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 5646b80..7856489 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -38,18 +38,6 @@ static inline int omap4_opp_init(void)
 }
 #endif
 
-/*
- * cpuidle mach specific parameters
- *
- * The board code can override the default C-states definition using
- * omap3_pm_init_cpuidle
- */
-struct cpuidle_params {
-	u32 exit_latency;	/* exit_latency = sleep + wake-up latencies */
-	u32 target_residency;
-	u8 valid;		/* validates the C-state */
-};
-
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 
-- 
1.7.5.4

