From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH] ARM: OMAP: Fix omap_wdt driver failure on 2420 when
 running multi-omap config
Date: Thu, 21 Aug 2008 12:32:38 +0300
Message-ID: <20080821123238.0d205e16.jarkko.nikula@nokia.com>
References: <1219306810-12232-1-git-send-email-jarkko.nikula@nokia.com>
	<1219306810-12232-3-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:24718 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbYHUJdL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Aug 2008 05:33:11 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m7L9WKq5028089
	for <linux-omap@vger.kernel.org>; Thu, 21 Aug 2008 04:33:08 -0500
Received: from kikka3 (esdhcp04165.research.nokia.com [172.21.41.65])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with SMTP id m7L9WgJ7024110
	for <linux-omap@vger.kernel.org>; Thu, 21 Aug 2008 12:32:43 +0300
In-Reply-To: <1219306810-12232-3-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off line was missing...

----------------------------->

omap_wdt driver will do unhandled fault on 2420 if support for 2430 is
compiled in since wrong base address is defined in that case. Assign
omap_wdt base address runtime depending on cpu type.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
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

