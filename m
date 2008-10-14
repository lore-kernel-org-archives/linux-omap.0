From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 2/7] input: tsc2005: move to gpiolib
Date: Wed, 15 Oct 2008 00:39:52 +0300
Message-ID: <1224020397-2842-3-git-send-email-me@felipebalbi.com>
References: <1224020397-2842-1-git-send-email-me@felipebalbi.com>
 <1224020397-2842-2-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:47958 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbYJNVk3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Oct 2008 17:40:29 -0400
In-Reply-To: <1224020397-2842-2-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, David Brownell <david-b@pacbell.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Get rid of omap-specific gpio calls and switch over
to gpiolib.

Cc: David Brownell <david-b@pacbell.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/input/touchscreen/tsc2005.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 7fb107e..c9f8f5c 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -534,16 +534,14 @@ static int __devinit tsc2005_ts_init(struct tsc2005 *ts,
 	ts->dav_gpio = dav_gpio;
 	dev_dbg(&ts->spi->dev, "TSC2005: DAV GPIO = %d\n", dav_gpio);
 
-#ifdef CONFIG_ARCH_OMAP
-	r = omap_request_gpio(dav_gpio);
+	r = gpio_request(dav_gpio, "dav_gpio");
 	if (r < 0) {
 		dev_err(&ts->spi->dev, "unable to get DAV GPIO");
 		goto err1;
 	}
-	omap_set_gpio_direction(dav_gpio, 1);
+	gpio_direction_input(dav_gpio);
 	ts->irq = OMAP_GPIO_IRQ(dav_gpio);
 	dev_dbg(&ts->spi->dev, "TSC2005: DAV IRQ = %d\n", ts->irq);
-#endif
 	init_timer(&ts->penup_timer);
 	setup_timer(&ts->penup_timer, tsc2005_ts_penup_timer_handler,
 			(unsigned long)ts);
@@ -612,9 +610,7 @@ err3:
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
@@ -671,10 +667,7 @@ static int __devexit tsc2005_remove(struct spi_device *spi)
 
 	free_irq(ts->irq, ts);
 	input_unregister_device(ts->idev);
-
-#ifdef CONFIG_ARCH_OMAP
-	omap_free_gpio(ts->dav_gpio);
-#endif
+	gpio_free(ts->dav_gpio);
 	kfree(ts);
 
 	return 0;
-- 
1.6.0.2.307.gc427

