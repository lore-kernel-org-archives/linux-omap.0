From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] watchdog: fix watchdog probe
Date: Tue, 21 Oct 2008 17:42:26 +0300
Message-ID: <1224600146-24301-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:65155 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbYJUOnR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Oct 2008 10:43:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Wim Van Sebroeck <wim@iguana.be>, Tony Lindgren <tony@atomide.com>

We need clks enabled to read/write watchdog registers.
After talking to the clks during probe, disable them until
/dev/watchdog is opened.

Also fix resource.end field.

Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/devices.c |    2 +-
 drivers/watchdog/omap_wdt.c  |   16 ++++++++++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index c22bd5f..5297db5 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -309,7 +309,7 @@ static void omap_init_wdt(void)
 	else
 		return;
 
-	wdt_resources[0].end = wdt_resources[0].start + 0x4f;
+	wdt_resources[0].end = wdt_resources[0].start + SZ_4K;
 
 	(void) platform_device_register(&omap_wdt_device);
 }
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 7bcbb7f..2c9988a 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -349,6 +349,14 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, wdev);
 
+	if (cpu_is_omap16xx())
+		clk_enable(wdev->armwdt_ck);	/* Enable the clock */
+
+	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+		clk_enable(wdev->mpu_wdt_ick);    /* Enable the interface clock */
+		clk_enable(wdev->mpu_wdt_fck);    /* Enable the functional clock */
+	}
+
 	omap_wdt_disable(wdev);
 	omap_wdt_adjust_timeout(timer_margin);
 
@@ -368,6 +376,14 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 	/* autogate OCP interface clock */
 	__raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
 
+	if (cpu_is_omap16xx())
+		clk_disable(wdev->armwdt_ck);	/* Disable the clock */
+
+	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+		clk_disable(wdev->mpu_wdt_ick);	/* Disable the clock */
+		clk_disable(wdev->mpu_wdt_fck);	/* Disable the clock */
+	}
+
 	omap_wdt_dev = pdev;
 
 	return 0;
-- 
1.6.0.2.307.gc427

