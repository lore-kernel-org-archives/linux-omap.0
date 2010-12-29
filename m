From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] arm: mach-omap2: pm: cleanup !CONFIG_SUSPEND handling
Date: Wed, 29 Dec 2010 18:34:43 +0200
Message-ID: <1293640483-25610-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:44779 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847Ab0L2Qdi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Dec 2010 11:33:38 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>

Make !CONFIG_SUSPEND init declarations identical on all OMAPs and
eliminate some ifdefs.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/pm.h     |    4 ++++
 arch/arm/mach-omap2/pm24xx.c |   16 ++++++++--------
 arch/arm/mach-omap2/pm34xx.c |   16 ++++++++--------
 arch/arm/mach-omap2/pm44xx.c |   17 +++++++++--------
 4 files changed, 29 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 1c1b0ab..704766b 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -138,4 +138,8 @@ static inline int omap4_twl_init(void)
 }
 #endif
 
+#ifndef CONFIG_SUSPEND
+#define omap_pm_ops NULL
+#endif
+
 #endif
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index dac2d1d..e65b329 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -350,14 +350,14 @@ static void omap2_pm_end(void)
 	enable_hlt();
 }
 
-static struct platform_suspend_ops omap_pm_ops = {
-	.begin		= omap2_pm_begin,
-	.enter		= omap2_pm_enter,
-	.end		= omap2_pm_end,
-	.valid		= suspend_valid_only_mem,
+static const struct platform_suspend_ops omap_pm_ops[] = {
+	{
+		.begin		= omap2_pm_begin,
+		.enter		= omap2_pm_enter,
+		.end		= omap2_pm_end,
+		.valid		= suspend_valid_only_mem,
+	}
 };
-#else
-static const struct platform_suspend_ops __initdata omap_pm_ops;
 #endif /* CONFIG_SUSPEND */
 
 /* XXX This function should be shareable between OMAP2xxx and OMAP3 */
@@ -582,7 +582,7 @@ static int __init omap2_pm_init(void)
 						    omap24xx_cpu_suspend_sz);
 	}
 
-	suspend_set_ops(&omap_pm_ops);
+	suspend_set_ops(omap_pm_ops);
 	pm_idle = omap2_pm_idle;
 
 	return 0;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 5b323f2..a4c9283 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -605,11 +605,13 @@ static void omap3_pm_end(void)
 	return;
 }
 
-static struct platform_suspend_ops omap_pm_ops = {
-	.begin		= omap3_pm_begin,
-	.end		= omap3_pm_end,
-	.enter		= omap3_pm_enter,
-	.valid		= suspend_valid_only_mem,
+static const struct platform_suspend_ops omap_pm_ops[] = {
+	{
+		.begin		= omap3_pm_begin,
+		.end		= omap3_pm_end,
+		.enter		= omap3_pm_enter,
+		.valid		= suspend_valid_only_mem,
+	}
 };
 #endif /* CONFIG_SUSPEND */
 
@@ -1067,9 +1069,7 @@ static int __init omap3_pm_init(void)
 	core_clkdm = clkdm_lookup("core_clkdm");
 
 	omap_push_sram_idle();
-#ifdef CONFIG_SUSPEND
-	suspend_set_ops(&omap_pm_ops);
-#endif /* CONFIG_SUSPEND */
+	suspend_set_ops(omap_pm_ops);
 
 	pm_idle = omap3_pm_idle;
 	omap3_idle_init();
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index e9f4862..6022c0a 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
+#include "pm.h"
 #include "powerdomain.h"
 #include <mach/omap4-common.h>
 
@@ -65,11 +66,13 @@ static void omap4_pm_end(void)
 	return;
 }
 
-static struct platform_suspend_ops omap_pm_ops = {
-	.begin		= omap4_pm_begin,
-	.end		= omap4_pm_end,
-	.enter		= omap4_pm_enter,
-	.valid		= suspend_valid_only_mem,
+static const struct platform_suspend_ops omap_pm_ops[] = {
+	{
+		.begin		= omap4_pm_begin,
+		.end		= omap4_pm_end,
+		.enter		= omap4_pm_enter,
+		.valid		= suspend_valid_only_mem,
+	}
 };
 #endif /* CONFIG_SUSPEND */
 
@@ -113,9 +116,7 @@ static int __init omap4_pm_init(void)
 	}
 #endif
 
-#ifdef CONFIG_SUSPEND
-	suspend_set_ops(&omap_pm_ops);
-#endif /* CONFIG_SUSPEND */
+	suspend_set_ops(omap_pm_ops);
 
 err2:
 	return ret;
-- 
1.5.6.5

