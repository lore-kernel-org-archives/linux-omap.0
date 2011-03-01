From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] watchdog: twl4030_wdt: Watchdog device registration issue fix
Date: Wed,  2 Mar 2011 02:17:54 +0530
Message-ID: <1299012474-4993-1-git-send-email-j-keerthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53410 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757361Ab1CAUsE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 15:48:04 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-watchdog@vger.kernel.org, wim@iguana.be
Cc: linux-omap@vger.kernel.org, j-keerthy@ti.com

twl4030_wdt driver and omap_wdt driver are registering as misc_device name as
"watchdog" and the same minor number WATCHDOG_MINOR( value = 130).
There is a conflict since the name and minor were the same for
both the misc_device registered by omap_wdt.c as well as twl4030_wdt.c

The omap_wdt.c probe is getting called first. Hence it succeeds.
twl4030_wdt.c always failed on the minor number comparison check.
Now requesting for MISC_DYNAMIC_MINOR as the minor
number for twl4030_watchdog and renamed the device name as
"twl4030_watchdog".

Tested for basic boot up on OMAP4 Blaze and OMAP3630 SDP. OMAP3630 SDP
twl4030_wdt registration succeeds.2430SDP boot tested, watchdog registration
without errors.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/watchdog/twl4030_wdt.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index b5045ca..89bf78d 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -183,8 +183,8 @@ static int __devinit twl4030_wdt_probe(struct platform_device *pdev)
 	wdt->timer_margin	= 30;
 	wdt->miscdev.parent	= &pdev->dev;
 	wdt->miscdev.fops	= &twl4030_wdt_fops;
-	wdt->miscdev.minor	= WATCHDOG_MINOR;
-	wdt->miscdev.name	= "watchdog";
+	wdt->miscdev.minor      = MISC_DYNAMIC_MINOR;
+	wdt->miscdev.name       = "twl4030_watchdog";
 
 	platform_set_drvdata(pdev, wdt);
 
-- 
1.7.0.4

