From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 17/21] ARM: OMAP: Complete gpio-switch gpiolib conversion
Date: Wed, 29 Oct 2008 13:36:25 +0200
Message-ID: <1225280189-6559-18-git-send-email-jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59910 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328AbYJ2Lhf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:37:35 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBb8ZV017044
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 13:37:33 +0200
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/plat-omap/gpio-switch.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/gpio-switch.c b/arch/arm/plat-omap/gpio-switch.c
index f18f6df..2b5665d 100644
--- a/arch/arm/plat-omap/gpio-switch.c
+++ b/arch/arm/plat-omap/gpio-switch.c
@@ -19,8 +19,8 @@
 #include <linux/platform_device.h>
 #include <linux/timer.h>
 #include <linux/err.h>
+#include <linux/gpio.h>
 #include <mach/hardware.h>
-#include <mach/gpio.h>
 #include <mach/irqs.h>
 #include <mach/mux.h>
 #include <mach/board.h>
@@ -278,7 +278,7 @@ static int __init new_switch(struct gpio_switch *sw)
 	}
 	dev_set_drvdata(&sw->pdev.dev, sw);
 
-	r = omap_request_gpio(sw->gpio);
+	r = gpio_request(sw->gpio, sw->name);
 	if (r < 0) {
 		platform_device_unregister(&sw->pdev);
 		return r;
@@ -319,7 +319,7 @@ static int __init new_switch(struct gpio_switch *sw)
 		printk(KERN_ERR "gpio-switch: request_irq() failed "
 		       "for GPIO %d\n", sw->gpio);
 		platform_device_unregister(&sw->pdev);
-		omap_free_gpio(sw->gpio);
+		gpio_free(sw->gpio);
 		return r;
 	}
 
@@ -455,7 +455,7 @@ static void gpio_sw_cleanup(void)
 		device_remove_file(&sw->pdev.dev, &dev_attr_direction);
 
 		platform_device_unregister(&sw->pdev);
-		omap_free_gpio(sw->gpio);
+		gpio_free(sw->gpio);
 		old = sw;
 	}
 	kfree(old);
-- 
1.5.6.5

