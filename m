From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 2/7] I2C: TWL4030: Move all *_*.c to *-*.c
Date: Thu, 27 Mar 2008 19:16:02 +0200
Message-ID: <1206638167-23951-3-git-send-email-felipe.balbi@nokia.com>
References: <1206638167-23951-1-git-send-email-felipe.balbi@nokia.com>
 <1206638167-23951-2-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:43457 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754788AbYC0RRZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Mar 2008 13:17:25 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2RHHB2K026017
	for <linux-omap@vger.kernel.org>; Thu, 27 Mar 2008 19:17:22 +0200
In-Reply-To: <1206638167-23951-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Rename to use the name style.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/Makefile                         |    8 ++++----
 .../i2c/chips/{twl4030_core.c => twl4030-core.c}   |    0 
 .../i2c/chips/{twl4030_gpio.c => twl4030-gpio.c}   |    0 
 .../{twl4030_poweroff.c => twl4030-poweroff.c}     |    0 
 drivers/i2c/chips/{twl4030_usb.c => twl4030-usb.c} |    0 
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename drivers/i2c/chips/{twl4030_core.c => twl4030-core.c} (100%)
 rename drivers/i2c/chips/{twl4030_gpio.c => twl4030-gpio.c} (100%)
 rename drivers/i2c/chips/{twl4030_poweroff.c => twl4030-poweroff.c} (100%)
 rename drivers/i2c/chips/{twl4030_usb.c => twl4030-usb.c} (100%)

diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 939ef5c..255fbb1 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -22,10 +22,10 @@ obj-$(CONFIG_SENSORS_TLV320AIC23) += tlv320aic23.o
 obj-$(CONFIG_GPIOEXPANDER_OMAP)	+= gpio_expander_omap.o
 obj-$(CONFIG_MENELAUS)		+= menelaus.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
-obj-$(CONFIG_TWL4030_CORE)	+= twl4030_core.o
-obj-$(CONFIG_TWL4030_GPIO)	+= twl4030_gpio.o
-obj-$(CONFIG_TWL4030_USB)	+= twl4030_usb.o
-obj-$(CONFIG_TWL4030_POWEROFF)	+= twl4030_poweroff.o
+obj-$(CONFIG_TWL4030_CORE)	+= twl4030-core.o
+obj-$(CONFIG_TWL4030_GPIO)	+= twl4030-gpio.o
+obj-$(CONFIG_TWL4030_USB)	+= twl4030-usb.o
+obj-$(CONFIG_TWL4030_POWEROFF)	+= twl4030-poweroff.o
 obj-$(CONFIG_RTC_X1205_I2C)	+= x1205.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
diff --git a/drivers/i2c/chips/twl4030_core.c b/drivers/i2c/chips/twl4030-core.c
similarity index 100%
rename from drivers/i2c/chips/twl4030_core.c
rename to drivers/i2c/chips/twl4030-core.c
diff --git a/drivers/i2c/chips/twl4030_gpio.c b/drivers/i2c/chips/twl4030-gpio.c
similarity index 100%
rename from drivers/i2c/chips/twl4030_gpio.c
rename to drivers/i2c/chips/twl4030-gpio.c
diff --git a/drivers/i2c/chips/twl4030_poweroff.c b/drivers/i2c/chips/twl4030-poweroff.c
similarity index 100%
rename from drivers/i2c/chips/twl4030_poweroff.c
rename to drivers/i2c/chips/twl4030-poweroff.c
diff --git a/drivers/i2c/chips/twl4030_usb.c b/drivers/i2c/chips/twl4030-usb.c
similarity index 100%
rename from drivers/i2c/chips/twl4030_usb.c
rename to drivers/i2c/chips/twl4030-usb.c
-- 
1.5.5.rc1.12.g660b9

