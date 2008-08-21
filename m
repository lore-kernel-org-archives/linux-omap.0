From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] ARM: OMAP: Fix omap_wdt driver failure on 2420 when running multi-omap config
Date: Thu, 21 Aug 2008 11:20:10 +0300
Message-ID: <1219306810-12232-3-git-send-email-jarkko.nikula@nokia.com>
References: <1219306810-12232-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28921 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753097AbYHUIUo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 04:20:44 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7L8KX2e031779
	for <linux-omap@vger.kernel.org>; Thu, 21 Aug 2008 11:20:41 +0300
In-Reply-To: <1219306810-12232-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

omap_wdt driver will do unhandled fault on 2420 if support for 2430 is
compiled in since wrong base address is defined in that case. Assign
omap_wdt base address runtime depending on cpu type.
---
 arch/arm/plat-omap/devices.c |   30 +++++++++++++-----------------
 1 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index f22ccbb..3bd1da2 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -454,25 +454,8 @@ static inline void omap_init_uwire(void) {}
 
 #if	defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODULE)
 
-#if defined(CONFIG_ARCH_OMAP34XX)
-#define	OMAP_WDT_BASE		0x48314000
-#elif defined(CONFIG_ARCH_OMAP24XX)
-
-#ifdef CONFIG_ARCH_OMAP2430
-/* WDT2 */
-#define	OMAP_WDT_BASE		0x49016000
-#else
-#define	OMAP_WDT_BASE		0x48022000
-#endif
-
-#else
-#define	OMAP_WDT_BASE		0xfffeb000
-#endif
-
 static struct resource wdt_resources[] = {
 	{
-		.start		= OMAP_WDT_BASE,
-		.end		= OMAP_WDT_BASE + 0x4f,
 		.flags		= IORESOURCE_MEM,
 	},
 };
@@ -486,6 +469,19 @@ static struct platform_device omap_wdt_device = {
 
 static void omap_init_wdt(void)
 {
+	if (cpu_is_omap16xx())
+		wdt_resources[0].start = 0xfffeb000;
+	else if (cpu_is_omap2420())
+		wdt_resources[0].start = 0x48022000; /* WDT2 */
+	else if (cpu_is_omap2430())
+		wdt_resources[0].start = 0x49016000; /* WDT2 */
+	else if (cpu_is_omap343x())
+		wdt_resources[0].start = 0x48314000; /* WDT2 */
+	else
+		return;
+
+	wdt_resources[0].end = wdt_resources[0].start + 0x4f;
+
 	(void) platform_device_register(&omap_wdt_device);
 }
 #else
-- 
1.5.6.3

