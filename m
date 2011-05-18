From: jean.pihet@newoldbits.com
Subject: [PATCH 08/13] OMAP2+: PM: provide the next timer event API to PM modules
Date: Wed, 18 May 2011 19:32:25 +0200
Message-ID: <1305739950-11695-9-git-send-email-j-pihet@ti.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:43729 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910Ab1ERRcz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 13:32:55 -0400
Received: by mail-yi0-f46.google.com with SMTP id 27so622746yia.19
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 10:32:55 -0700 (PDT)
In-Reply-To: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Provide omap_pm_tick_nohz_get_sleep_length_us so that the code
from the OMAP PM modules can use it.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |    7 ++++---
 arch/arm/mach-omap2/pm.c       |   15 +++++++++++++++
 arch/arm/mach-omap2/pm.h       |   12 ++++++++----
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 0b896d4..24e5c31 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -141,9 +141,10 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
 	if (!resume)
 #ifdef CONFIG_NO_HZ
 		printk(KERN_INFO
-		       "--- Going to %s %s (next timer after %u ms)\n", s1, s2,
-		       jiffies_to_msecs(get_next_timer_interrupt(jiffies) -
-					jiffies));
+		       "--- Going to %s %s (next timer after %lu ms)\n", s1, s2,
+		       DIV_ROUND_UP(omap_pm_tick_nohz_get_sleep_length_us(),
+				    1000)
+		      );
 #else
 		printk(KERN_INFO "--- Going to %s %s\n", s1, s2);
 #endif
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 37a4801..0c451e3 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -14,6 +14,8 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/opp.h>
+#include <linux/hrtimer.h>
+#include <linux/tick.h>
 
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
@@ -30,6 +32,7 @@ static struct omap_device_pm_latency *pm_lats;
 struct cpuidle_params *cpuidle_params_override_table;
 #endif
 
+#ifdef CONFIG_PM_DEBUG
 u32 enable_off_mode;
 EXPORT_SYMBOL(enable_off_mode);
 
@@ -37,6 +40,7 @@ int omap2_pm_debug;
 u32 sleep_while_idle;
 u32 wakeup_timer_seconds;
 u32 wakeup_timer_milliseconds;
+#endif
 
 static struct device *mpu_dev;
 static struct device *iva_dev;
@@ -292,6 +296,7 @@ void omap3_pm_init_cpuidle(struct cpuidle_params *cpuidle_board_params)
 }
 #endif
 
+#ifdef CONFIG_PM_DEBUG
 void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds)
 {
 	u32 tick_rate, cycles;
@@ -308,4 +313,14 @@ void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds)
 		" (%d ticks at %d ticks/sec.)\n",
 		seconds, milliseconds, cycles, tick_rate);
 }
+EXPORT_SYMBOL(omap2_pm_wakeup_on_timer);
+#endif
+
+#ifdef CONFIG_NO_HZ
+unsigned long omap_pm_tick_nohz_get_sleep_length_us(void)
+{
+	return ktime_to_us(tick_nohz_get_sleep_length());
+}
+EXPORT_SYMBOL(omap_pm_tick_nohz_get_sleep_length_us);
+#endif
 
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 03da7f8..70eb80e 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -68,11 +68,15 @@ extern int omap2_pm_debug;
 extern u32 enable_off_mode;
 extern u32 sleep_while_idle;
 #else
-#define omap2_pm_dump(mode, resume, us)		do {} while (0);
+#define omap2_pm_dump(mode, resume, us)			do {} while (0);
 #define omap2_pm_wakeup_on_timer(seconds, milliseconds)	do {} while (0);
-#define omap2_pm_debug				0
-#define enable_off_mode 0
-#define sleep_while_idle 0
+#define omap2_pm_debug					0
+#define enable_off_mode					0
+#define sleep_while_idle				0
+#endif
+
+#ifdef CONFIG_NO_HZ
+extern unsigned long omap_pm_tick_nohz_get_sleep_length_us(void);
 #endif
 
 #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
-- 
1.7.4.1

