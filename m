From: felipe.balbi@nokia.com
Subject: [RFC PATCH 35/37] cbus: retu-wdt: remove the platform_device
Date: Wed,  7 Apr 2010 19:04:26 +0300
Message-ID: <1270656268-7034-36-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58508 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932860Ab0DGQF2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:28 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G58f2004996
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:05:26 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

it now comes from retu.c, so use that.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/retu-wdt.c |   34 +---------------------------------
 1 files changed, 1 insertions(+), 33 deletions(-)

diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
index 380fae6..763b34f 100644
--- a/drivers/cbus/retu-wdt.c
+++ b/drivers/cbus/retu-wdt.c
@@ -32,7 +32,6 @@
 #include <linux/completion.h>
 #include <linux/errno.h>
 #include <linux/moduleparam.h>
-#include <linux/platform_device.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
 
@@ -48,7 +47,6 @@
 #define RETU_WDT_DEFAULT_TIMER 32
 #define RETU_WDT_MAX_TIMER 63
 
-static struct completion retu_wdt_completion;
 static DEFINE_MUTEX(retu_wdt_mutex);
 
 /* Current period of watchdog */
@@ -321,21 +319,8 @@ static int __devexit retu_wdt_remove(struct device *dev)
 	return 0;
 }
 
-static void retu_wdt_device_release(struct device *dev)
-{
-	complete(&retu_wdt_completion);
-}
-
-static struct platform_device retu_wdt_device = {
-	.name = "retu-watchdog",
-	.id = -1,
-	.dev = {
-		.release = retu_wdt_device_release,
-	},
-};
-
 static struct device_driver retu_wdt_driver = {
-	.name = "retu-watchdog",
+	.name = "retu-wdt",
 	.bus = &platform_bus_type,
 	.probe = retu_wdt_probe,
 	.remove = __devexit_p(retu_wdt_remove),
@@ -349,16 +334,10 @@ static int __init retu_wdt_init(void)
 	if (!ret)
 		return -ENODEV;
 
-	init_completion(&retu_wdt_completion);
-
 	ret = driver_register(&retu_wdt_driver);
 	if (ret)
 		return ret;
 
-	ret = platform_device_register(&retu_wdt_device);
-	if (ret)
-		goto exit1;
-
 	/* passed as module parameter? */
 	ret = retu_modify_counter(counter_param);
 	if (ret == -EINVAL) {
@@ -367,23 +346,12 @@ static int __init retu_wdt_init(void)
 		       "retu_wdt_init: Intializing to default value\n");
 	}
 
-	printk(KERN_INFO "Retu watchdog driver initialized\n");
-
 	return retu_wdt_ping();
-
-exit1:
-	driver_unregister(&retu_wdt_driver);
-	wait_for_completion(&retu_wdt_completion);
-
-	return ret;
 }
 
 static void __exit retu_wdt_exit(void)
 {
-	platform_device_unregister(&retu_wdt_device);
 	driver_unregister(&retu_wdt_driver);
-
-	wait_for_completion(&retu_wdt_completion);
 }
 
 module_init(retu_wdt_init);
-- 
1.7.0.rc0.33.g7c3932

