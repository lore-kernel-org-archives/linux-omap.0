From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 02/22] twl4030-gpio: Remove default pullup enable/disable of GPIO
Date: Mon, 29 Sep 2008 16:14:19 +0300
Message-ID: <1222694079-16289-3-git-send-email-felipe.balbi@nokia.com>
References: <1222694079-16289-1-git-send-email-felipe.balbi@nokia.com>
 <1222694079-16289-2-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29669 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbYI2NPV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Sep 2008 09:15:21 -0400
In-Reply-To: <1222694079-16289-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>, Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>, Girish S G <girishsg@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>

One twl4030_request_gpio() should not tamper with the pullup
enabling/disabling of the rest of the GPIOs. So removing the default
pullup values written to REG_GPIOPUPDCTR1.

Signed-off-by: Girish S G <girishsg@ti.com>
Signed-off-by: Jagadeesh Bhaskar Pakaravoor <j-pakaravoor@ti.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-gpio.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-gpio.c b/drivers/i2c/chips/twl4030-gpio.c
index 4d89abc..b51bed0 100644
--- a/drivers/i2c/chips/twl4030-gpio.c
+++ b/drivers/i2c/chips/twl4030-gpio.c
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
1.6.0.2.307.gc427

