From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 07/21] INPUT: TSC2005: Complete gpiolib conversion
Date: Wed, 29 Oct 2008 13:36:15 +0200
Message-ID: <1225280189-6559-8-git-send-email-jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59839 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308AbYJ2LhR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:37:17 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBb8ZB017044
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 13:37:15 +0200
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/input/touchscreen/tsc2005.c |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 38ac537..03c3a10 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -27,12 +27,9 @@
 #include <linux/input.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/spi/spi.h>
 
-#ifdef CONFIG_ARCH_OMAP
-#include <mach/gpio.h>
-#endif
-
 #include <linux/spi/tsc2005.h>
 
 /**
@@ -534,8 +531,7 @@ static int __devinit tsc2005_ts_init(struct tsc2005 *ts,
 	ts->dav_gpio = dav_gpio;
 	dev_dbg(&ts->spi->dev, "TSC2005: DAV GPIO = %d\n", dav_gpio);
 
-#ifdef CONFIG_ARCH_OMAP
-	r = omap_request_gpio(dav_gpio);
+	r = gpio_request(dav_gpio, "TSC2005 dav");
 	if (r < 0) {
 		dev_err(&ts->spi->dev, "unable to get DAV GPIO");
 		goto err1;
@@ -543,7 +539,7 @@ static int __devinit tsc2005_ts_init(struct tsc2005 *ts,
 	gpio_direction_input(dav_gpio);
 	ts->irq = gpio_to_irq(dav_gpio);
 	dev_dbg(&ts->spi->dev, "TSC2005: DAV IRQ = %d\n", ts->irq);
-#endif
+
 	init_timer(&ts->penup_timer);
 	setup_timer(&ts->penup_timer, tsc2005_ts_penup_timer_handler,
 			(unsigned long)ts);
@@ -612,9 +608,7 @@ err3:
 	tsc2005_stop_scan(ts);
 	input_free_device(idev);
 err2:
-#ifdef CONFIG_ARCH_OMAP
-	omap_free_gpio(dav_gpio);
-#endif
+	gpio_free(dav_gpio);
 err1:
 	return r;
 }
@@ -672,9 +666,7 @@ static int __devexit tsc2005_remove(struct spi_device *spi)
 	free_irq(ts->irq, ts);
 	input_unregister_device(ts->idev);
 
-#ifdef CONFIG_ARCH_OMAP
-	omap_free_gpio(ts->dav_gpio);
-#endif
+	gpio_free(ts->dav_gpio);
 	kfree(ts);
 
 	return 0;
-- 
1.5.6.5

