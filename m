From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 03/25] i2c: clean add_children a bit
Date: Tue, 30 Sep 2008 21:42:47 +0300
Message-ID: <1222800189-29737-4-git-send-email-me@felipebalbi.com>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com>
 <1222800189-29737-2-git-send-email-me@felipebalbi.com>
 <1222800189-29737-3-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51210 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192AbYI3Sn2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 14:43:28 -0400
In-Reply-To: <1222800189-29737-3-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Clean up add_children a bit before adding more children
to twl4030-core.c

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-core.c |   63 +++++++++++++++++++++----------------
 1 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 47f65f8..e55f49e 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -45,6 +45,11 @@
 
 #define DRIVER_NAME			"twl4030"
 
+#if defined(CONFIG_RTC_DRV_TWL4030) || defined(CONFIG_RTC_DRV_TWL4030_MODULE)
+#define twl_has_rtc()	true
+#else
+#define twl_has_rtc()	false
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
1.6.0.1.196.g01914

