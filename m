From: Nick Bowler <nbowler@elliptictech.com>
Subject: [PATCH 5/5] ARM: omap4: Kill private do_wfi macro.
Date: Fri,  9 Sep 2011 11:26:52 -0400
Message-ID: <1315582012-23507-6-git-send-email-nbowler@elliptictech.com>
References: <1315582012-23507-1-git-send-email-nbowler@elliptictech.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from dsl-67-204-24-19.acanac.net ([67.204.24.19]:41248 "EHLO
	mail.ellipticsemi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751492Ab1IIP14 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 11:27:56 -0400
In-Reply-To: <1315582012-23507-1-git-send-email-nbowler@elliptictech.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

The do_wfi macro duplicates the functionality of the wfi macro in common
ARM code.  Use the common version instead.

Signed-off-by: Nick Bowler <nbowler@elliptictech.com>
---
Compile tested in both ARM and Thumb-2 mode.
---
 arch/arm/mach-omap2/include/mach/omap4-common.h |   11 -----------
 arch/arm/mach-omap2/omap-hotplug.c              |    7 +++----
 arch/arm/mach-omap2/pm44xx.c                    |    4 +++-
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index e4bd87619..9e8c214 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -13,17 +13,6 @@
 #ifndef OMAP_ARCH_OMAP4_COMMON_H
 #define OMAP_ARCH_OMAP4_COMMON_H
 
-/*
- * wfi used in low power code. Directly opcode is used instead
- * of instruction to avoid mulit-omap build break
- */
-#ifdef CONFIG_THUMB2_KERNEL
-#define do_wfi() __asm__ __volatile__ ("wfi" : : : "memory")
-#else
-#define do_wfi()			\
-		__asm__ __volatile__ (".word	0xe320f003" : : : "memory")
-#endif
-
 #ifdef CONFIG_CACHE_L2X0
 extern void __iomem *l2cache_base;
 #endif
diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index 4976b93..3a43eb8 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -19,6 +19,8 @@
 #include <linux/smp.h>
 
 #include <asm/cacheflush.h>
+#include <asm/system.h>
+
 #include <mach/omap4-common.h>
 
 int platform_cpu_kill(unsigned int cpu)
@@ -42,10 +44,7 @@ void platform_cpu_die(unsigned int cpu)
 		printk(KERN_CRIT "Secure clear status failed\n");
 
 	for (;;) {
-		/*
-		 * Execute WFI
-		 */
-		do_wfi();
+		wfi();
 
 		if (omap_read_auxcoreboot0() == cpu) {
 			/*
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 59a870b..c741ad7 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -16,6 +16,8 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
+#include <asm/system.h>
+
 #include "powerdomain.h"
 #include <mach/omap4-common.h>
 
@@ -33,7 +35,7 @@ static LIST_HEAD(pwrst_list);
 #ifdef CONFIG_SUSPEND
 static int omap4_pm_suspend(void)
 {
-	do_wfi();
+	wfi();
 	return 0;
 }
 
-- 
1.7.3.4

