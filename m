From: Joonyoung Shim <dofmind@gmail.com>
Subject: [PATCH] twl4030-gpio: Fix getting the value of the TWL4030 GPIO
	output pin
Date: Sat, 7 Feb 2009 15:13:35 +0900
Message-ID: <4e1455be0902062213o769a4d15ha0c892508839dbad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:57826 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbZBGGNg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Feb 2009 01:13:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

If TWL4030 GPIO pin is output, must read the value from REG_GPIODATAOUTx
register in twl4030_get_gpio_datainout().

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---

diff --git a/drivers/gpio/twl4030-gpio.c b/drivers/gpio/twl4030-gpio.c
index afad147..890518a 100644
--- a/drivers/gpio/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -183,7 +183,7 @@ static int twl4030_set_gpio_dataout(int gpio, int enable)
 	return gpio_twl4030_write(base, d_msk);
 }

-static int twl4030_get_gpio_datain(int gpio)
+static int twl4030_get_gpio_datainout(int gpio)
 {
 	u8 d_bnk = gpio >> 3;
 	u8 d_off = gpio & 0x7;
@@ -194,7 +194,17 @@ static int twl4030_get_gpio_datain(int gpio)
 		|| !(gpio_usage_count & BIT(gpio))))
 		return -EPERM;

-	base = REG_GPIODATAIN1 + d_bnk;
+	base = REG_GPIODATADIR1 + d_bnk;
+	ret = gpio_twl4030_read(base);
+	if (ret > 0)
+		ret = (ret >> d_off) & 0x1;
+	else
+		return ret;
+
+	if (ret)
+		base = REG_GPIODATAOUT1 + d_bnk;
+	else
+		base = REG_GPIODATAIN1 + d_bnk;
 	ret = gpio_twl4030_read(base);
 	if (ret > 0)
 		ret = (ret >> d_off) & 0x1;
