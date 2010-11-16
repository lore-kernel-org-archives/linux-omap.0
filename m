From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/3] OMAP2+: wd_timer: separate watchdog disable code from the
	rest of mach-omap2/devices.c
Date: Tue, 16 Nov 2010 03:25:15 -0700
Message-ID: <20101116102512.27991.28535.stgit@twilight.localdomain>
References: <20101116102205.27991.37909.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40967 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934134Ab0KPK1m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 05:27:42 -0500
In-Reply-To: <20101116102205.27991.37909.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Charulatha Varadarajan <charu@ti.com>

Split the wd_timer disable code out into its own file,
mach-omap2/wd_timer.c; it belongs in its own file rather than
cluttering up devices.c.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Charulatha Varadarajan <charu@ti.com>
---
 arch/arm/mach-omap2/Makefile   |    2 +
 arch/arm/mach-omap2/devices.c  |   55 +++-----------------------------
 arch/arm/mach-omap2/wd_timer.c |   68 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/wd_timer.h |   17 ++++++++++
 4 files changed, 91 insertions(+), 51 deletions(-)
 create mode 100644 arch/arm/mach-omap2/wd_timer.c
 create mode 100644 arch/arm/mach-omap2/wd_timer.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b0810b9..fbacad5 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o \
-	 common.o
+	 common.o wd_timer.o
 
 omap-2-3-common				= irq.o sdrc.o prm2xxx_3xxx.o
 hwmod-common				= omap_hwmod.o \
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 5a0c148..cd6a46a 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -33,6 +33,7 @@
 
 #include "mux.h"
 #include "control.h"
+#include "wd_timer.h"
 
 #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
 
@@ -951,69 +952,23 @@ static inline void omap_init_vout(void) {}
 
 /*-------------------------------------------------------------------------*/
 
-/*
- * Inorder to avoid any assumptions from bootloader regarding WDT
- * settings, WDT module is reset during init. This enables the watchdog
- * timer. Hence it is required to disable the watchdog after the WDT reset
- * during init. Otherwise the system would reboot as per the default
- * watchdog timer registers settings.
- */
-#define OMAP_WDT_WPS	(0x34)
-#define OMAP_WDT_SPR	(0x48)
-
 static int omap2_disable_wdt(struct omap_hwmod *oh, void *unused)
 {
-	void __iomem *base;
-	int ret;
-
-	if (!oh) {
-		pr_err("%s: Could not look up wdtimer_hwmod\n", __func__);
-		return -EINVAL;
-	}
-
-	base = omap_hwmod_get_mpu_rt_va(oh);
-	if (!base) {
-		pr_err("%s: Could not get the base address for %s\n",
-				oh->name, __func__);
-		return -EINVAL;
-	}
-
-	/* Enable the clocks before accessing the WDT registers */
-	ret = omap_hwmod_enable(oh);
-	if (ret) {
-		pr_err("%s: Could not enable clocks for %s\n",
-				oh->name, __func__);
-		return ret;
-	}
-
-	/* sequence required to disable watchdog */
-	__raw_writel(0xAAAA, base + OMAP_WDT_SPR);
-	while (__raw_readl(base + OMAP_WDT_WPS) & 0x10)
-		cpu_relax();
-
-	__raw_writel(0x5555, base + OMAP_WDT_SPR);
-	while (__raw_readl(base + OMAP_WDT_WPS) & 0x10)
-		cpu_relax();
-
-	ret = omap_hwmod_idle(oh);
-	if (ret)
-		pr_err("%s: Could not disable clocks for %s\n",
-				oh->name, __func__);
-
-	return ret;
+	return omap2_wd_timer_disable(oh);
 }
 
 static void __init omap_disable_wdt(void)
 {
 	if (cpu_class_is_omap2())
 		omap_hwmod_for_each_by_class("wd_timer",
-						omap2_disable_wdt, NULL);
+					     omap2_disable_wdt, NULL);
 	return;
 }
 
 static int __init omap2_init_devices(void)
 {
-	/* please keep these calls, and their implementations above,
+	/*
+	 * please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
 	omap_disable_wdt();
diff --git a/arch/arm/mach-omap2/wd_timer.c b/arch/arm/mach-omap2/wd_timer.c
new file mode 100644
index 0000000..06c256d
--- /dev/null
+++ b/arch/arm/mach-omap2/wd_timer.c
@@ -0,0 +1,68 @@
+/*
+ * OMAP2+ MPU WD_TIMER-specific code
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/err.h>
+
+#include <plat/omap_hwmod.h>
+
+/*
+ * In order to avoid any assumptions from bootloader regarding WDT
+ * settings, WDT module is reset during init. This enables the watchdog
+ * timer. Hence it is required to disable the watchdog after the WDT reset
+ * during init. Otherwise the system would reboot as per the default
+ * watchdog timer registers settings.
+ */
+#define OMAP_WDT_WPS		0x34
+#define OMAP_WDT_SPR		0x48
+
+
+int omap2_wd_timer_disable(struct omap_hwmod *oh)
+{
+	void __iomem *base;
+	int ret;
+
+	if (!oh) {
+		pr_err("%s: Could not look up wdtimer_hwmod\n", __func__);
+		return -EINVAL;
+	}
+
+	base = omap_hwmod_get_mpu_rt_va(oh);
+	if (!base) {
+		pr_err("%s: Could not get the base address for %s\n",
+				oh->name, __func__);
+		return -EINVAL;
+	}
+
+	/* Enable the clocks before accessing the WDT registers */
+	ret = omap_hwmod_enable(oh);
+	if (ret) {
+		pr_err("%s: Could not enable clocks for %s\n",
+				oh->name, __func__);
+		return ret;
+	}
+
+	/* sequence required to disable watchdog */
+	__raw_writel(0xAAAA, base + OMAP_WDT_SPR);
+	while (__raw_readl(base + OMAP_WDT_WPS) & 0x10)
+		cpu_relax();
+
+	__raw_writel(0x5555, base + OMAP_WDT_SPR);
+	while (__raw_readl(base + OMAP_WDT_WPS) & 0x10)
+		cpu_relax();
+
+	ret = omap_hwmod_idle(oh);
+	if (ret)
+		pr_err("%s: Could not disable clocks for %s\n",
+				oh->name, __func__);
+
+	return ret;
+}
+
diff --git a/arch/arm/mach-omap2/wd_timer.h b/arch/arm/mach-omap2/wd_timer.h
new file mode 100644
index 0000000..e0054a2
--- /dev/null
+++ b/arch/arm/mach-omap2/wd_timer.h
@@ -0,0 +1,17 @@
+/*
+ * OMAP2+ MPU WD_TIMER-specific function prototypes
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_WD_TIMER_H
+#define __ARCH_ARM_MACH_OMAP2_WD_TIMER_H
+
+#include <plat/omap_hwmod.h>
+
+extern int omap2_wd_timer_disable(struct omap_hwmod *oh);
+
+#endif


