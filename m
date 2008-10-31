From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [OMAP tree][RFC 2.6.28-rc2-omap 9/9] LEDS: Switch leds-omap to use gpio_request/free calls
Date: Fri, 31 Oct 2008 14:18:57 +0200
Message-ID: <1225455537-14017-10-git-send-email-jarkko.nikula@nokia.com>
References: <1225455537-14017-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:62531 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbYJaMUI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 08:20:08 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9VCJwTJ002376
	for <linux-omap@vger.kernel.org>; Fri, 31 Oct 2008 14:20:05 +0200
In-Reply-To: <1225455537-14017-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/leds/leds-omap.c |   24 +++++++++++-------------
 1 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/leds/leds-omap.c b/drivers/leds/leds-omap.c
index 05776cd..e936403 100644
--- a/drivers/leds/leds-omap.c
+++ b/drivers/leds/leds-omap.c
@@ -14,8 +14,8 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/leds.h>
+#include <linux/gpio.h>
 
-#include <mach/gpio.h>
 #include <mach/hardware.h>
 #include <mach/led.h>
 
@@ -30,15 +30,6 @@ static void omap_set_led_gpio(struct led_classdev *led_cdev,
 	gpio_set_value(led_dev->gpio, value);
 }
 
-static void omap_configure_led_gpio(int gpio)
-{
-	if (omap_request_gpio(gpio) < 0) {
-		printk(KERN_ERR "Failed to request GPIO%d for LEDs\n", gpio);
-		return;
-	}
-	gpio_direction_output(gpio, 0);
-}
-
 static int omap_led_probe(struct platform_device *dev)
 {
 	struct omap_led_platform_data *pdata = dev->dev.platform_data;
@@ -46,7 +37,10 @@ static int omap_led_probe(struct platform_device *dev)
 	int i, ret = 0;
 
 	for (i = 0; ret >= 0 && i < pdata->nr_leds; i++) {
-		omap_configure_led_gpio(leds[i].gpio);
+		ret = gpio_request(leds[i].gpio, leds[i].cdev.name);
+		if (ret < 0)
+			break;
+		gpio_direction_output(leds[i].gpio, 0);
 		if (!leds[i].cdev.brightness_set)
 			leds[i].cdev.brightness_set = omap_set_led_gpio;
 
@@ -54,8 +48,10 @@ static int omap_led_probe(struct platform_device *dev)
 	}
 
 	if (ret < 0 && i > 1) {
-		for (i = i - 2; i >= 0; i--)
+		for (i = i - 2; i >= 0; i--) {
 			led_classdev_unregister(&leds[i].cdev);
+			gpio_free(leds[i].gpio);
+		}
 	}
 
 	return ret;
@@ -67,8 +63,10 @@ static int omap_led_remove(struct platform_device *dev)
 	struct omap_led_config *leds = pdata->leds;
 	int i;
 
-	for (i = 0; i < pdata->nr_leds; i++)
+	for (i = 0; i < pdata->nr_leds; i++) {
 		led_classdev_unregister(&leds[i].cdev);
+		gpio_free(leds[i].gpio);
+	}
 
 	return 0;
 }
-- 
1.5.6.5

