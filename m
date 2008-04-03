From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 2/3] I2C: TWL4030: Kconfig and Makefile changes
Date: Thu,  3 Apr 2008 16:44:23 +0300
Message-ID: <1207230264-4629-2-git-send-email-felipe.balbi@nokia.com>
References: <1207230264-4629-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:64488 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755395AbYDCNpn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2008 09:45:43 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m33DjLrl004358
	for <linux-omap@vger.kernel.org>; Thu, 3 Apr 2008 16:45:41 +0300
In-Reply-To: <1207230264-4629-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Kconfig and Makefile changes

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/Kconfig  |    4 ++++
 drivers/i2c/chips/Makefile |    3 ++-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index bc7717f..3730448 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -136,6 +136,10 @@ config TWL4030_USB
 	bool "TWL4030 USB Transceiver Driver"
 	depends on TWL4030_CORE
 
+config TWL4030_PWRBUTTON
+        bool "TWL4030 Power button Driver"
+	depends on TWL4030_CORE
+
 choice
 	prompt "Transceiver mode"
 	depends on TWL4030_USB
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 6431675..7c47fc4 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -22,10 +22,11 @@ obj-$(CONFIG_SENSORS_TLV320AIC23) += tlv320aic23.o
 obj-$(CONFIG_GPIOEXPANDER_OMAP)	+= gpio_expander_omap.o
 obj-$(CONFIG_MENELAUS)		+= menelaus.o
 obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
-obj-$(CONFIG_TWL4030_CORE)	+= twl4030-core.o
+obj-$(CONFIG_TWL4030_CORE)	+= twl4030-core.o twl4030-pwrirq.o
 obj-$(CONFIG_TWL4030_GPIO)	+= twl4030-gpio.o
 obj-$(CONFIG_TWL4030_USB)	+= twl4030-usb.o
 obj-$(CONFIG_TWL4030_POWEROFF)	+= twl4030-poweroff.o
+obj-$(CONFIG_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
 obj-$(CONFIG_TWL4030_MADC)	+= twl4030-madc.o
 obj-$(CONFIG_RTC_X1205_I2C)	+= x1205.o
 
-- 
1.5.5.rc2.25.g5fbd

