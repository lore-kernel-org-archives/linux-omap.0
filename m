From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 3/3] Add twl4030 power platform device
Date: Tue,  7 Oct 2008 17:34:10 +0300
Message-ID: <1223390050-11499-4-git-send-email-peter.de-schrijver@nokia.com>
References: <1223390050-11499-1-git-send-email-peter.de-schrijver@nokia.com>
 <1223390050-11499-2-git-send-email-peter.de-schrijver@nokia.com>
 <1223390050-11499-3-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:18791 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbYJGOeW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 10:34:22 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m97EY9SK001099
	for <linux-omap@vger.kernel.org>; Tue, 7 Oct 2008 09:34:20 -0500
In-Reply-To: <1223390050-11499-3-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 drivers/i2c/chips/twl4030-core.c |   41 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 9debab4..42d9e4f 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -70,6 +70,12 @@
 #define twl_has_madc()	false
 #endif
 
+#ifdef CONFIG_TWL4030_POWER
+#define twl_has_power()        true
+#else
+#define twl_has_power()        false
+#endif
+
 #if defined(CONFIG_RTC_DRV_TWL4030) || defined(CONFIG_RTC_DRV_TWL4030_MODULE)
 #define twl_has_rtc()	true
 #else
@@ -838,6 +844,41 @@ static int add_children(struct twl4030_platform_data *pdata)
 		}
 	}
 
+	if (twl_has_power() && pdata->power) {
+		twl = &twl4030_modules[TWL4030_SLAVENUM_NUM3];
+
+		pdev = platform_device_alloc("twl4030_power", -1);
+		if (!pdev) {
+			pr_debug("%s: can't alloc power dev\n", DRIVER_NAME);
+			status = -ENOMEM;
+			goto err;
+		}
+
+		if (status == 0) {
+			pdev->dev.parent = &twl->client->dev;
+			status = platform_device_add_data(pdev, pdata->power,
+					sizeof(*pdata->power));
+			if (status < 0) {
+				platform_device_put(pdev);
+				dev_dbg(&twl->client->dev,
+					"can't add power data, %d\n",
+					status);
+				goto err;
+			}
+		}
+
+		if (status == 0)
+			status = platform_device_add(pdev);
+
+		if (status < 0) {
+			platform_device_put(pdev);
+			dev_dbg(&twl->client->dev,
+					"can't create power dev, %d\n",
+					status);
+			goto err;
+		}
+	}
+
 	if (twl_has_rtc()) {
 		twl = &twl4030_modules[TWL4030_SLAVENUM_NUM3];
 
-- 
1.5.6.3

