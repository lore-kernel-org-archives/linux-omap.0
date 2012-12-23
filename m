From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] watchdog: omap_wdt: eliminate unused variable and a compiler warning
Date: Sun, 23 Dec 2012 22:03:36 +0200
Message-ID: <1356293017-29443-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:43710 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099Ab2LWUDs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Dec 2012 15:03:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

We forgot to delete this in the commit 4f4753d9 (watchdog: omap_wdt:
convert to devm_ functions), and as a result the following compilation
warning was introduced:

drivers/watchdog/omap_wdt.c: In function 'omap_wdt_remove':
drivers/watchdog/omap_wdt.c:299:19: warning: unused variable 'res' [-Wunused-variable]

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/watchdog/omap_wdt.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 34ed61e..b0e541d 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -296,7 +296,6 @@ static int omap_wdt_remove(struct platform_device *pdev)
 {
 	struct watchdog_device *wdog = platform_get_drvdata(pdev);
 	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
 	pm_runtime_disable(wdev->dev);
 	watchdog_unregister_device(wdog);
-- 
1.7.10.4

