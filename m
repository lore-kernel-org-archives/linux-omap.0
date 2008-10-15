From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 2/7] input: tsc2005: move to gpiolib
Date: Wed, 15 Oct 2008 13:21:01 +0300
Message-ID: <20081015102101.GI28161@gandalf.research.nokia.com>
References: <1224020397-2842-1-git-send-email-me@felipebalbi.com> <1224020397-2842-2-git-send-email-me@felipebalbi.com> <1224020397-2842-3-git-send-email-me@felipebalbi.com> <200810141620.04834.david-b@pacbell.net>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:38314 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbYJOKVt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 06:21:49 -0400
Content-Disposition: inline
In-Reply-To: <200810141620.04834.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext David Brownell <david-b@pacbell.net>
Cc: Felipe Balbi <me@felipebalbi.com>, linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, Oct 14, 2008 at 04:20:04PM -0700, David Brownell wrote:
> That should be ts->irq = gpio_to_irq(dav_gpio) ...

New version below

========== cut here =========

>From 28368394029be3c8bbfa44c0d433bf06a64c2761 Mon Sep 17 00:00:00 2001
From: Felipe Balbi <felipe.balbi@nokia.com>
Date: Wed, 15 Oct 2008 00:39:52 +0300
Subject: [PATCH 2/7] input: tsc2005: move to gpiolib

Get rid of omap-specific gpio calls and switch over
to gpiolib.

Cc: David Brownell <david-b@pacbell.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/input/touchscreen/tsc2005.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 7fb107e..0c631d4 100644
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
-	ts->irq = OMAP_GPIO_IRQ(dav_gpio);
+	gpio_direction_input(dav_gpio);
+	ts->irq = gpio_to_irq(dav_gpio);
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


-- 
balbi
