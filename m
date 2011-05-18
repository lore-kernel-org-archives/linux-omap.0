From: jean.pihet@newoldbits.com
Subject: [PATCH 05/13] OMAP2+: PM: move common code from pm-debug.c to pm.c
Date: Wed, 18 May 2011 19:32:22 +0200
Message-ID: <1305739950-11695-6-git-send-email-j-pihet@ti.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:46337 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910Ab1ERRcu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 13:32:50 -0400
Received: by gwaa18 with SMTP id a18so620907gwa.19
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 10:32:50 -0700 (PDT)
In-Reply-To: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Move variables and functions that are by the arch code to the common
pm.c code.

Moved:
. PM knobs variables:
  - enable_off_mode
  - omap2_pm_debug
  - sleep_while_idle
  - wakeup_timer_seconds
  - wakeup_timer_milliseconds

. omap2_pm_wakeup_on_timer function.

This also cleans up the core PM code, in order to allow it to be used
as a module.

Note: Some PM important knobs variables (enable_off_mode, sleep_while_idle)
are controlled by the PM debug code and so it mandates the use of the PM
debug code. The control of those variables shall be moved to the PM code.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |   24 ------------------------
 arch/arm/mach-omap2/pm.c       |   26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index a5a83b3..98cc9ee 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -31,19 +31,12 @@
 #include <plat/board.h>
 #include "powerdomain.h"
 #include "clockdomain.h"
-#include <plat/dmtimer.h>
 #include <plat/omap-pm.h>
 
 #include "cm2xxx_3xxx.h"
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
 
-int omap2_pm_debug;
-u32 enable_off_mode;
-u32 sleep_while_idle;
-u32 wakeup_timer_seconds;
-u32 wakeup_timer_milliseconds;
-
 #define DUMP_PRM_MOD_REG(mod, reg)    \
 	regs[reg_count].name = #mod "." #reg; \
 	regs[reg_count++].val = omap2_prm_read_mod_reg(mod, reg)
@@ -162,23 +155,6 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
 		printk(KERN_INFO "%-20s: 0x%08x\n", regs[i].name, regs[i].val);
 }
 
-void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds)
-{
-	u32 tick_rate, cycles;
-
-	if (!seconds && !milliseconds)
-		return;
-
-	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer_wakeup));
-	cycles = tick_rate * seconds + tick_rate * milliseconds / 1000;
-	omap_dm_timer_stop(gptimer_wakeup);
-	omap_dm_timer_set_load_start(gptimer_wakeup, 0, 0xffffffff - cycles);
-
-	pr_info("PM: Resume timer in %u.%03u secs"
-		" (%d ticks at %d ticks/sec.)\n",
-		seconds, milliseconds, cycles, tick_rate);
-}
-
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 84ef409..37a4801 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -18,6 +18,7 @@
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
 #include <plat/common.h>
+#include <plat/dmtimer.h>
 
 #include "voltage.h"
 #include "powerdomain.h"
@@ -29,6 +30,14 @@ static struct omap_device_pm_latency *pm_lats;
 struct cpuidle_params *cpuidle_params_override_table;
 #endif
 
+u32 enable_off_mode;
+EXPORT_SYMBOL(enable_off_mode);
+
+int omap2_pm_debug;
+u32 sleep_while_idle;
+u32 wakeup_timer_seconds;
+u32 wakeup_timer_milliseconds;
+
 static struct device *mpu_dev;
 static struct device *iva_dev;
 static struct device *l3_dev;
@@ -283,3 +292,20 @@ void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
 }
 #endif
 
+void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds)
+{
+	u32 tick_rate, cycles;
+
+	if (!seconds && !milliseconds)
+		return;
+
+	tick_rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer_wakeup));
+	cycles = tick_rate * seconds + tick_rate * milliseconds / 1000;
+	omap_dm_timer_stop(gptimer_wakeup);
+	omap_dm_timer_set_load_start(gptimer_wakeup, 0, 0xffffffff - cycles);
+
+	pr_info("PM: Resume timer in %u.%03u secs"
+		" (%d ticks at %d ticks/sec.)\n",
+		seconds, milliseconds, cycles, tick_rate);
+}
+
-- 
1.7.4.1

