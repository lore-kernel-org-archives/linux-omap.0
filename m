From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 3/8] i2c: clean add_children a bit
Date: Fri, 26 Sep 2008 12:40:56 +0300
Message-ID: <1222422061-3940-4-git-send-email-felipe.balbi@nokia.com>
References: <1222422061-3940-1-git-send-email-felipe.balbi@nokia.com>
 <1222422061-3940-2-git-send-email-felipe.balbi@nokia.com>
 <1222422061-3940-3-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25453 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbYIZJl0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 05:41:26 -0400
In-Reply-To: <1222422061-3940-3-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

Clean up add_children a bit before adding more children
to twl4030-core.c

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/i2c/chips/twl4030-core.c |   63 +++++++++++++++++++++----------------
 1 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 47f65f8..75356c3 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -45,6 +45,11 @@
 
 #define DRIVER_NAME			"twl4030"
 
+#if defined(CONFIG_RTC_DRV_TWL4030) || defined(CONFIG_RTC_DRV_TWL4030_MODULE)
+#define twl_has_rtc()	(1)
+#else
+#define twl_has_rtc()	(0)
+#endif
 
 /* Primary Interrupt Handler on TWL4030 Registers */
 
@@ -639,34 +644,38 @@ static int add_children(struct twl4030_platform_data *pdata)
 	struct twl4030_client	*twl = NULL;
 	int			status = 0;
 
-#ifdef CONFIG_RTC_DRV_TWL4030
-	pdev = platform_device_alloc("twl4030_rtc", -1);
-	if (pdev) {
-		twl = &twl4030_modules[TWL4030_SLAVENUM_NUM3];
-		pdev->dev.parent = &twl->client->dev;
-		device_init_wakeup(&pdev->dev, 1);
-
-		/*
-		 * FIXME add the relevant IRQ resource, and make the
-		 * rtc driver use it instead of hard-wiring ...
-		 *
-		 * REVISIT platform_data here currently only supports
-		 * setting up the "msecure" line ... which actually
-		 * violates the "princple of least privilege", since
-		 * it's effectively always in "high trust" mode.
-		 *
-		 * For now, expect equivalent treatment at board init:
-		 * setting msecure high.  Eventually, Linux might
-		 * become more aware of those HW security concerns.
-		 */
-
-		status = platform_device_add(pdev);
-		if (status < 0)
-			platform_device_put(pdev);
-	} else
-		status = -ENOMEM;
-#endif
+	if (twl_has_rtc()) {
+		pdev = platform_device_alloc("twl4030_rtc", -1);
+		if (pdev) {
+			twl = &twl4030_modules[TWL4030_SLAVENUM_NUM3];
+			pdev->dev.parent = &twl->client->dev;
+			device_init_wakeup(&pdev->dev, 1);
+
+			/*
+			 * FIXME add the relevant IRQ resource, and make the
+			 * rtc driver use it instead of hard-wiring ...
+			 *
+			 * REVISIT platform_data here currently only supports
+			 * setting up the "msecure" line ... which actually
+			 * violates the "princple of least privilege", since
+			 * it's effectively always in "high trust" mode.
+			 *
+			 * For now, expect equivalent treatment at board init:
+			 * setting msecure high.  Eventually, Linux might
+			 * become more aware of those HW security concerns.
+			 */
+
+			status = platform_device_add(pdev);
+			if (status < 0)
+				platform_device_put(pdev);
+		} else {
+			status = -ENOMEM;
+			goto err;
+		}
+	}
 
+err:
+	pr_err("failed to add twl4030's children\n");
 	return status;
 }
 
-- 
1.6.0.2.307.gc427

