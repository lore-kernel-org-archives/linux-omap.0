From: Dave Martin <dave.martin@linaro.org>
Subject: [PATCH v3 1/5] ARM: omap4: Replace custom do_wfi() with generic wfi()
Date: Fri,  4 Feb 2011 14:21:43 +0000
Message-ID: <1296829307-21439-2-git-send-email-dave.martin@linaro.org>
References: <1296829307-21439-1-git-send-email-dave.martin@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49122 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857Ab1BDOWJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 09:22:09 -0500
Received: by mail-wy0-f174.google.com with SMTP id 28so2295541wyb.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Feb 2011 06:22:08 -0800 (PST)
In-Reply-To: <1296829307-21439-1-git-send-email-dave.martin@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dave Martin <dave.martin@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Jean Pihet <j-pihet@ti.com>, linux-omap@vger.kernel.org, Nicolas Pitre <nicolas.pitre@linaro.org>

Now that wfi() in <asm/system.h> is suitably generic, we can
remove the omap-specific do_wfi() macro.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |    7 -------
 arch/arm/mach-omap2/omap-hotplug.c              |    3 ++-
 arch/arm/mach-omap2/pm44xx.c                    |    3 ++-
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index 5b0270b..b2ac175 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -13,13 +13,6 @@
 #ifndef OMAP_ARCH_OMAP4_COMMON_H
 #define OMAP_ARCH_OMAP4_COMMON_H
 
-/*
- * wfi used in low power code. Directly opcode is used instead
- * of instruction to avoid mulit-omap build break
- */
-#define do_wfi()			\
-		__asm__ __volatile__ (".word	0xe320f003" : : : "memory")
-
 #ifdef CONFIG_CACHE_L2X0
 extern void __iomem *l2cache_base;
 #endif
diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index 4976b93..c983e1d 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -19,6 +19,7 @@
 #include <linux/smp.h>
 
 #include <asm/cacheflush.h>
+#include <asm/system.h>
 #include <mach/omap4-common.h>
 
 int platform_cpu_kill(unsigned int cpu)
@@ -45,7 +46,7 @@ void platform_cpu_die(unsigned int cpu)
 		/*
 		 * Execute WFI
 		 */
-		do_wfi();
+		wfi();
 
 		if (omap_read_auxcoreboot0() == cpu) {
 			/*
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 76cfff2..9e454b6 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
+#include <asm/system.h>
 #include "powerdomain.h"
 #include <mach/omap4-common.h>
 
@@ -33,7 +34,7 @@ static LIST_HEAD(pwrst_list);
 #ifdef CONFIG_SUSPEND
 static int omap4_pm_suspend(void)
 {
-	do_wfi();
+	wfi();
 	return 0;
 }
 
-- 
1.7.1

