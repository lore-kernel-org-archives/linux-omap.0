From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC][PATCH 9/9] ARM: OMAP3/4: consolidate cpuidle Makefile
Date: Fri, 23 Mar 2012 10:26:34 +0100
Message-ID: <1332494794-7810-9-git-send-email-daniel.lezcano@linaro.org>
References: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:43866 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757411Ab2CWJ0r (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Mar 2012 05:26:47 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1979620wgb.1
        for <linux-omap@vger.kernel.org>; Fri, 23 Mar 2012 02:26:46 -0700 (PDT)
In-Reply-To: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-omap2/Makefile      |   11 +++++++----
 arch/arm/mach-omap2/cpuidle34xx.c |    8 --------
 arch/arm/mach-omap2/cpuidle44xx.c |    8 --------
 arch/arm/mach-omap2/pm.h          |   17 +++++++++++++++--
 4 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index bd76394..93819c4 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -63,10 +63,8 @@ endif
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o \
-					   cpuidle34xx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o \
-					   cpuidle44xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= pm44xx.o omap-mpuss-lowpower.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_OMAP_SMARTREFLEX)          += sr_device.o smartreflex.o
 obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
@@ -80,6 +78,11 @@ endif
 
 endif
 
+ifeq ($(CONFIG_CPU_IDLE),y)
+obj-$(CONFIG_ARCH_OMAP3)                += cpuidle34xx.o
+obj-$(CONFIG_ARCH_OMAP4)                += cpuidle44xx.o
+endif
+
 # PRCM
 obj-y					+= prm_common.o
 obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 726f0bf..579424c 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -36,8 +36,6 @@
 #include "control.h"
 #include "common.h"
 
-#ifdef CONFIG_CPU_IDLE
-
 /* Mach specific information to be recorded in the C-state driver_data */
 struct omap3_idle_statedata {
 	u32 mpu_state;
@@ -335,9 +333,3 @@ int __init omap3_idle_init(void)
 
 	return 0;
 }
-#else
-int __init omap3_idle_init(void)
-{
-	return 0;
-}
-#endif /* CONFIG_CPU_IDLE */
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index f6a6194..d251187 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -22,8 +22,6 @@
 #include "pm.h"
 #include "prm.h"
 
-#ifdef CONFIG_CPU_IDLE
-
 /* Machine specific information */
 struct omap4_idle_statedata {
 	u32 cpu_state;
@@ -219,9 +217,3 @@ int __init omap4_idle_init(void)
 
 	return 0;
 }
-#else
-int __init omap4_idle_init(void)
-{
-	return 0;
-}
-#endif /* CONFIG_CPU_IDLE */
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index a41c8dd..d9a97e8 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -15,13 +15,26 @@
 
 #include "powerdomain.h"
 
+#ifdef CONFIG_CPU_IDLE
+extern int omap3_idle_init(void);
+extern int omap4_idle_init(void);
+#else
+static inline int omap3_idle_init(void)
+{
+	return 0;
+}
+
+static inline int omap4_idle_init(void)
+{
+	return 0;
+}
+#endif
+
 extern void *omap3_secure_ram_storage;
 extern void omap3_pm_off_mode_enable(int);
 extern void omap_sram_idle(void);
 extern int omap3_can_sleep(void);
 extern int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
-extern int omap3_idle_init(void);
-extern int omap4_idle_init(void);
 extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused);
 extern int (*omap_pm_suspend)(void);
 
-- 
1.7.5.4

