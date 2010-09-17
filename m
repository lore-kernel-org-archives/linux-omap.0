From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v6 6/7] OMAP2PLUS: WDT: use omap_device_build for device registration
Date: Fri, 17 Sep 2010 19:48:55 +0530
Message-ID: <1284733136-20952-7-git-send-email-charu@ti.com>
References: <1284733136-20952-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39137 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753653Ab0IQOTW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Sep 2010 10:19:22 -0400
In-Reply-To: <1284733136-20952-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, wim@iguana.be, linux-watchdog@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, linux-omap@vger.kernel.org, "Varadarajan, Charulatha" <charu@ti.com>

This patch splits omap_init_wdt() into separate omap_init_wdt()
functions under mach-omap1 and mach-omap2 and set them up with
subsys_initcall.

Also it uses  omap_device_build() API instead of
platform_device_register() for watchdog timer device registration
for OMAP2plus chips.

For OMAP2plus chips, the device specific data defined in centralized
hwmod database will be used.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/devices.c |   27 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/devices.c |   39 +++++++++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/devices.c  |   41 -----------------------------------------
 3 files changed, 66 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index aa07256..39447fa 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -232,3 +232,30 @@ static int __init omap1_init_devices(void)
 }
 arch_initcall(omap1_init_devices);
 
+#if defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODULE)
+
+static struct resource wdt_resources[] = {
+	{
+		.start		= 0xfffeb000,
+		.end		= 0xfffeb07F,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device omap_wdt_device = {
+	.name	   = "omap_wdt",
+	.id	     = -1,
+	.num_resources	= ARRAY_SIZE(wdt_resources),
+	.resource	= wdt_resources,
+};
+
+static int __init omap_init_wdt(void)
+{
+	if (!cpu_is_omap16xx())
+		return;
+
+	platform_device_register(&omap_wdt_device);
+	return;
+}
+subsys_initcall(omap_init_wdt);
+#endif
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 2dbb265..439bfb3 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/err.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -28,6 +29,8 @@
 #include <mach/gpio.h>
 #include <plat/mmc.h>
 #include <plat/dma.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 
 #include "mux.h"
 
@@ -859,3 +862,39 @@ static int __init omap2_init_devices(void)
 	return 0;
 }
 arch_initcall(omap2_init_devices);
+
+#if defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODULE)
+struct omap_device_pm_latency omap_wdt_latency[] = {
+	[0] = {
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+static int __init omap_init_wdt(void)
+{
+	int id = -1;
+	struct omap_device *od;
+	struct omap_hwmod *oh;
+	char *oh_name = "wd_timer2";
+	char *dev_name = "omap_wdt";
+
+	if (!cpu_class_is_omap2())
+		return 0;
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up wd_timer%d hwmod\n", id);
+		return -EINVAL;
+	}
+
+	od = omap_device_build(dev_name, id, oh, NULL, 0,
+				omap_wdt_latency,
+				ARRAY_SIZE(omap_wdt_latency), 0);
+	WARN(IS_ERR(od), "Cant build omap_device for %s:%s.\n",
+				dev_name, oh->name);
+	return 0;
+}
+subsys_initcall(omap_init_wdt);
+#endif
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index d1920be..8e88e0e 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -232,46 +232,6 @@ static void omap_init_uwire(void)
 static inline void omap_init_uwire(void) {}
 #endif
 
-/*-------------------------------------------------------------------------*/
-
-#if	defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODULE)
-
-static struct resource wdt_resources[] = {
-	{
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device omap_wdt_device = {
-	.name	   = "omap_wdt",
-	.id	     = -1,
-	.num_resources	= ARRAY_SIZE(wdt_resources),
-	.resource	= wdt_resources,
-};
-
-static void omap_init_wdt(void)
-{
-	if (cpu_is_omap16xx())
-		wdt_resources[0].start = 0xfffeb000;
-	else if (cpu_is_omap2420())
-		wdt_resources[0].start = 0x48022000; /* WDT2 */
-	else if (cpu_is_omap2430())
-		wdt_resources[0].start = 0x49016000; /* WDT2 */
-	else if (cpu_is_omap343x())
-		wdt_resources[0].start = 0x48314000; /* WDT2 */
-	else if (cpu_is_omap44xx())
-		wdt_resources[0].start = 0x4a314000;
-	else
-		return;
-
-	wdt_resources[0].end = wdt_resources[0].start + 0x4f;
-
-	(void) platform_device_register(&omap_wdt_device);
-}
-#else
-static inline void omap_init_wdt(void) {}
-#endif
-
 /*
  * This gets called after board-specific INIT_MACHINE, and initializes most
  * on-chip peripherals accessible on this board (except for few like USB):
@@ -300,7 +260,6 @@ static int __init omap_init_devices(void)
 	omap_init_rng();
 	omap_init_mcpdm();
 	omap_init_uwire();
-	omap_init_wdt();
 	return 0;
 }
 arch_initcall(omap_init_devices);
-- 
1.7.0.4

