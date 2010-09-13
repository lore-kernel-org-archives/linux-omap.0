From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [v4 5/6] OMAP2PLUS: WDT: use omap_device_build for device registration
Date: Mon, 13 Sep 2010 20:43:28 +0530
Message-ID: <1284390809-11519-6-git-send-email-charu@ti.com>
References: <1284390809-11519-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55545 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753089Ab0IMPNt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Sep 2010 11:13:49 -0400
In-Reply-To: <1284390809-11519-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, wim@iguana.be, linux-watchdog@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, linux-omap@vger.kernel.org, "Varadarajan, Charulatha" <charu@ti.com>

Use omap_device_build API instead of platform_device_register for
watchdog timer device registration.

For OMAP2PLUS chips, the device specific data defined in centralized
hwmod database will be used.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/devices.c |   64 ++++++++++++++++++++++++++++-------------
 1 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index d1920be..6885f4f 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/err.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -28,6 +29,8 @@
 #include <plat/menelaus.h>
 #include <plat/mcbsp.h>
 #include <plat/omap44xx.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 
 /*-------------------------------------------------------------------------*/
 
@@ -236,37 +239,58 @@ static inline void omap_init_uwire(void) {}
 
 #if	defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODULE)
 
-static struct resource wdt_resources[] = {
+struct omap_device_pm_latency omap2_wdt_latency[] = {
+	[0] = {
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+static void omap2_init_wdt(void)
+{
+	int id = -1;
+	struct omap_device *od;
+	struct omap_hwmod *oh;
+	char *oh_name = "wd_timer2";
+	char *name = "omap_wdt";
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
+		return;
+	}
+
+	od = omap_device_build(name, id, oh, NULL, 0,
+				omap2_wdt_latency,
+				ARRAY_SIZE(omap2_wdt_latency), 0);
+	WARN(IS_ERR(od), "Cant build omap_device for %s:%s.\n",
+				name, oh->name);
+	return;
+}
+
+static struct resource omap1_wdt_resources[] = {
 	{
+		.start		= 0xfffeb000,
+		.end		= 0xfffeb07F,
 		.flags		= IORESOURCE_MEM,
 	},
 };
 
-static struct platform_device omap_wdt_device = {
+static struct platform_device omap1_wdt_device = {
 	.name	   = "omap_wdt",
 	.id	     = -1,
-	.num_resources	= ARRAY_SIZE(wdt_resources),
-	.resource	= wdt_resources,
+	.num_resources	= ARRAY_SIZE(omap1_wdt_resources),
+	.resource	= omap1_wdt_resources,
 };
 
 static void omap_init_wdt(void)
 {
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
+	if (cpu_class_is_omap2())
+		omap2_init_wdt();
+	else if (cpu_is_omap16xx())
+		(void) platform_device_register(&omap1_wdt_device);
+	return;
 }
 #else
 static inline void omap_init_wdt(void) {}
-- 
1.7.0.4

