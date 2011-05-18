From: jean.pihet@newoldbits.com
Subject: [PATCH 09/13] OMAP2+: PM: export suspend_set_ops to PM modules
Date: Wed, 18 May 2011 19:32:26 +0200
Message-ID: <1305739950-11695-10-git-send-email-j-pihet@ti.com>
References: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62820 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932910Ab1ERRc5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 13:32:57 -0400
Received: by mail-yx0-f174.google.com with SMTP id 7so624062yxs.19
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 10:32:56 -0700 (PDT)
In-Reply-To: <1305739950-11695-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Jean Pihet <j-pihet@ti.com>

Export the suspend_set_ops API as omap_pm_suspend_set_ops in the pm
generic code, under CONFIG_SUSPEND.

Note -hack warning-: since the 'suspend_valid_only_mem' function is
not exported to modules, fill the 'valid' field value of
'struct platform_suspend_ops' in the common code.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm.c     |   10 ++++++++++
 arch/arm/mach-omap2/pm.h     |    5 +++++
 arch/arm/mach-omap2/pm24xx.c |    9 ++++-----
 arch/arm/mach-omap2/pm34xx.c |    5 ++---
 arch/arm/mach-omap2/pm44xx.c |    6 +++---
 5 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 0c451e3..2e43fd6 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -16,6 +16,7 @@
 #include <linux/opp.h>
 #include <linux/hrtimer.h>
 #include <linux/tick.h>
+#include <linux/suspend.h>
 
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
@@ -324,3 +325,12 @@ unsigned long omap_pm_tick_nohz_get_sleep_length_us(void)
 EXPORT_SYMBOL(omap_pm_tick_nohz_get_sleep_length_us);
 #endif
 
+#ifdef CONFIG_SUSPEND
+void omap_pm_suspend_set_ops(struct platform_suspend_ops *pm_ops)
+{
+	if (pm_ops)
+		pm_ops->valid = suspend_valid_only_mem;
+	suspend_set_ops((const struct platform_suspend_ops *) pm_ops);
+}
+EXPORT_SYMBOL(omap_pm_suspend_set_ops);
+#endif
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 70eb80e..d1bc6a3 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -12,6 +12,7 @@
 #define __ARCH_ARM_MACH_OMAP2_PM_H
 
 #include <linux/err.h>
+#include <linux/suspend.h>
 
 #include "powerdomain.h"
 
@@ -79,6 +80,10 @@ extern u32 sleep_while_idle;
 extern unsigned long omap_pm_tick_nohz_get_sleep_length_us(void);
 #endif
 
+#ifdef CONFIG_SUSPEND
+extern void omap_pm_suspend_set_ops(struct platform_suspend_ops *pm_ops);
+#endif
+
 #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
 extern int pm_dbg_regset_save(int reg_set);
 extern int pm_dbg_regset_init(int reg_set);
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index df3ded6..340da03 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -350,14 +350,11 @@ static void omap2_pm_end(void)
 	enable_hlt();
 }
 
-static const struct platform_suspend_ops omap_pm_ops = {
+static struct platform_suspend_ops omap_pm_ops = {
 	.begin		= omap2_pm_begin,
 	.enter		= omap2_pm_enter,
 	.end		= omap2_pm_end,
-	.valid		= suspend_valid_only_mem,
 };
-#else
-static const struct platform_suspend_ops __initdata omap_pm_ops;
 #endif /* CONFIG_SUSPEND */
 
 /* XXX This function should be shareable between OMAP2xxx and OMAP3 */
@@ -515,7 +512,9 @@ static int __init omap2_pm_init(void)
 						    omap24xx_cpu_suspend_sz);
 	}
 
-	suspend_set_ops(&omap_pm_ops);
+#ifdef CONFIG_SUSPEND
+	omap_pm_suspend_set_ops(&omap_pm_ops);
+#endif
 	pm_idle = omap2_pm_idle;
 
 	return 0;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 4c80861..967b931 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -609,11 +609,10 @@ static void omap3_pm_end(void)
 	return;
 }
 
-static const struct platform_suspend_ops omap_pm_ops = {
+static struct platform_suspend_ops omap_pm_ops = {
 	.begin		= omap3_pm_begin,
 	.end		= omap3_pm_end,
 	.enter		= omap3_pm_enter,
-	.valid		= suspend_valid_only_mem,
 };
 #endif /* CONFIG_SUSPEND */
 
@@ -962,7 +961,7 @@ static int __init omap3_pm_init(void)
 
 	omap_push_sram_idle();
 #ifdef CONFIG_SUSPEND
-	suspend_set_ops(&omap_pm_ops);
+	omap_pm_suspend_set_ops(&omap_pm_ops);
 #endif /* CONFIG_SUSPEND */
 
 	pm_idle = omap3_pm_idle;
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 59a870b..3d6b991 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -18,6 +18,7 @@
 
 #include "powerdomain.h"
 #include <mach/omap4-common.h>
+#include "pm.h"
 
 struct power_state {
 	struct powerdomain *pwrdm;
@@ -65,11 +66,10 @@ static void omap4_pm_end(void)
 	return;
 }
 
-static const struct platform_suspend_ops omap_pm_ops = {
+static struct platform_suspend_ops omap_pm_ops = {
 	.begin		= omap4_pm_begin,
 	.end		= omap4_pm_end,
 	.enter		= omap4_pm_enter,
-	.valid		= suspend_valid_only_mem,
 };
 #endif /* CONFIG_SUSPEND */
 
@@ -112,7 +112,7 @@ static int __init omap4_pm_init(void)
 	}
 
 #ifdef CONFIG_SUSPEND
-	suspend_set_ops(&omap_pm_ops);
+	omap_pm_suspend_set_ops(&omap_pm_ops);
 #endif /* CONFIG_SUSPEND */
 
 err2:
-- 
1.7.4.1

