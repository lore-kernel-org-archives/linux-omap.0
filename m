From: Zumeng Chen <zumeng.chen@gmail.com>
Subject: [PATCH V2 5/5] Input: ads7846: set proper debounce time in driver level
Date: Wed, 13 Jun 2012 09:44:10 +0800
Message-ID: <1339551850-20827-6-git-send-email-zumeng.chen@gmail.com>
References: <zumeng.chen@gmail.com>
 <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:41319 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390Ab2FMBow (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jun 2012 21:44:52 -0400
In-Reply-To: <1339551850-20827-1-git-send-email-zumeng.chen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, jon-hunter@ti.com, grinberg@compulab.co.il, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, khasim@ti.com, ajay.gupta@ti.com, hvaibhav@ti.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

From: Zumeng Chen <zumeng.chen@windriver.com>

If we don't set proper debouce time for ads7846, then there are
flooded interrupt counters of ads7846 responding to one time
touch on screen, so the driver couldn't work well.

And since most OMAP3 series boards pass NULL pointer of board_pdata
to omap_ads7846_init, so it's more proper to set it in driver level
after having gpio_request done.

This patch has been validated on 3530evm.

Signed-off-by: Zumeng Chen <zumeng.chen@windriver.com>
Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
---
 drivers/input/touchscreen/ads7846.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index f02028e..459ff29 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -980,6 +980,10 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
 		}
 
 		ts->gpio_pendown = pdata->gpio_pendown;
+#ifdef CONFIG_ARCH_OMAP3
+		/* 310 means about 10 microsecond for omap3 */
+		gpio_set_debounce(pdata->gpio_pendown, 310);
+#endif
 
 	} else {
 		dev_err(&spi->dev, "no get_pendown_state nor gpio_pendown?\n");
-- 
1.7.5.4

