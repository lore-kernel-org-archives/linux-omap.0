From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 10/21] LEDS: Complete leds-omap gpiolib conversion and do some fixes
Date: Wed, 29 Oct 2008 13:36:18 +0200
Message-ID: <1225280189-6559-11-git-send-email-jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59841 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753318AbYJ2LhS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:37:18 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBb8bm017062
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 13:37:15 +0200
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/leds/leds-omap.c |   24 +++++++++++-------------
 1 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/leds/leds-omap.c b/drivers/leds/leds-omap.c
index 46b4232..cb89e17 100644
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
 
@@ -34,15 +34,6 @@ static void omap_set_led_gpio(struct led_classdev *led_cdev,
 		gpio_set_value(led_dev->gpio, 0);
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
@@ -50,7 +41,10 @@ static int omap_led_probe(struct platform_device *dev)
 	int i, ret = 0;
 
 	for (i = 0; ret >= 0 && i < pdata->nr_leds; i++) {
-		omap_configure_led_gpio(leds[i].gpio);
+		ret = gpio_request(leds[i].gpio, leds[i].cdev.name);
+		if (ret < 0)
+			break;
+		gpio_direction_output(leds[i].gpio, 0);
 		if (!leds[i].cdev.brightness_set)
 			leds[i].cdev.brightness_set = omap_set_led_gpio;
 
@@ -58,8 +52,10 @@ static int omap_led_probe(struct platform_device *dev)
 	}
 
 	if (ret < 0 && i > 1) {
-		for (i = i - 2; i >= 0; i--)
+		for (i = i - 2; i >= 0; i--) {
 			led_classdev_unregister(&leds[i].cdev);
+			gpio_free(leds[i].gpio);
+		}
 	}
 
 	return ret;
@@ -71,8 +67,10 @@ static int omap_led_remove(struct platform_device *dev)
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

