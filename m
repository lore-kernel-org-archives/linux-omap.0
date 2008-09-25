From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 1/4] i2c: clean add_children a bit
Date: Thu, 25 Sep 2008 17:48:50 +0300
Message-ID: <1222354133-12919-2-git-send-email-felipe.balbi@nokia.com>
References: <1222354133-12919-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22060 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbYIYOt3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 10:49:29 -0400
In-Reply-To: <1222354133-12919-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

Clean up add_children a bit before adding more children
to twl4030-core.c

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-core.c |   58 ++++++++++++++++++++-----------------
 include/linux/i2c/twl4030.h      |    6 ++++
 2 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 47f65f8..bbffc40 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -639,34 +639,38 @@ static int add_children(struct twl4030_platform_data *pdata)
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
 
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 2434ad0..ff1dff4 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -145,4 +145,10 @@ int twl4030_free_gpio(int gpio);
 	static inline int twl4030charger_usb_en(int enable) { return 0; }
 #endif
 
+#if defined(CONFIG_RTC_DRV_TWL4030) || defined(CONFIG_RTC_DRV_TWL4030_MODULE)
+#define twl_has_rtc()	(1)
+#else
+#define twl_has_rtc()	(0)
+#endif
+
 #endif /* End of __TWL4030_H */
-- 
1.6.0.2.307.gc427

