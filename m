From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC][PATCH 3/9] ARM: OMAP3: cpuidle - set enable_off_mode as static
Date: Fri, 23 Mar 2012 10:26:28 +0100
Message-ID: <1332494794-7810-3-git-send-email-daniel.lezcano@linaro.org>
References: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:43866 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757333Ab2CWJ0i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 05:26:38 -0400
Received: by wgbdr13 with SMTP id dr13so1979620wgb.1
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 02:26:37 -0700 (PDT)
In-Reply-To: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

This variable is only used in the pm-debug.c file.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/pm-debug.c |    2 +-
 arch/arm/mach-omap2/pm.h       |   30 ++++++++++++------------------
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 814bcd9..86aa398 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -38,7 +38,7 @@
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
 
-u32 enable_off_mode;
+static u32 enable_off_mode;
 
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index af73a86..f5c3072 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -25,6 +25,18 @@ extern int omap4_idle_init(void);
 extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused);
 extern int (*omap_pm_suspend)(void);
 
+/*
+ * cpuidle mach specific parameters
+ *
+ * The board code can override the default C-states definition using
+ * omap3_pm_init_cpuidle
+ */
+struct cpuidle_params {
+       u32 exit_latency;       /* exit_latency = sleep + wake-up latencies */
+       u32 target_residency;
+       u8 valid;               /* validates the C-state */
+};
+
 #if defined(CONFIG_PM_OPP)
 extern int omap3_opp_init(void);
 extern int omap4_opp_init(void);
@@ -39,27 +51,9 @@ static inline int omap4_opp_init(void)
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
 
-#ifdef CONFIG_PM_DEBUG
-extern u32 enable_off_mode;
-#else
-#define enable_off_mode 0
-#endif
-
 #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
 extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
 #else
-- 
1.7.5.4

