From: "Pakaravoor, Jagadeesh" <j-pakaravoor@ti.com>
Subject: [PATCH] twl4030-gpio: Remove default pullup enable/disable of GPIO
Date: Thu, 25 Sep 2008 18:47:17 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB028BF72A8E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35753 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753099AbYIYNR2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 09:17:28 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Ghongadematt, Girish" <girishsg@ti.com>

From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

One twl4030_request_gpio() should not tamper with the pullup
enabling/disabling of the rest of the GPIOs. So removing the default
pullup values written to REG_GPIOPUPDCTR1.

Signed-off-by: Girish S G <girishsg@ti.com>
Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
---
Index: linux-omap-git/drivers/i2c/chips/twl4030-gpio.c
===================================================================
--- linux-omap-git.orig/drivers/i2c/chips/twl4030-gpio.c	2008-09-25 17:30:27.000000000 +0530
+++ linux-omap-git/drivers/i2c/chips/twl4030-gpio.c	2008-09-25 18:43:08.932257869 +0530
@@ -301,7 +301,6 @@ int twl4030_request_gpio(int gpio)
 	if (gpio_usage_count & (0x1 << gpio))
 		ret = -EBUSY;
 	else {
-		u8 clear_pull[6] = { 0, 0, 0, 0, 0, 0 };
 		/* First time usage? - switch on GPIO module */
 		if (!gpio_usage_count) {
 			ret =
@@ -311,10 +310,6 @@ int twl4030_request_gpio(int gpio)
 		}
 		if (!ret)
 			gpio_usage_count |= (0x1 << gpio);
-
-		ret =
-		twl4030_i2c_write(TWL4030_MODULE_GPIO, clear_pull,
-				REG_GPIOPUPDCTR1, 5);
 	}
 	up(&gpio_sem);
 	return ret;

--
With Regards,
Jagadeesh Bhaskar P
 
----------------------------
Some men see things as they are and say why - I dream things that never were and say why not.
- George Bernard Shaw
-------------------

