From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 2/5] I2C: TWL4030: Kconfig and Makefile changes
Date: Thu,  3 Apr 2008 15:14:25 +0300
Message-ID: <1207224865-21527-2-git-send-email-felipe.balbi@nokia.com>
References: <1207224865-21527-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48006 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbYDCMPd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2008 08:15:33 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m33CHCwT001875
	for <linux-omap@vger.kernel.org>; Thu, 3 Apr 2008 07:17:43 -0500
In-Reply-To: <1207224865-21527-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Mikko Ylinen <mikko.k.ylinen@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Mikko Ylinen <mikko.k.ylinen@nokia.com>

Put madc driver into kbuild.

Signed-off-by: Mikko Ylinen <mikko.k.ylinen@nokia.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/Kconfig  |    4 ++++
 drivers/i2c/chips/Makefile |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/chips/Kconfig b/drivers/i2c/chips/Kconfig
index bfab098..bc7717f 100644
--- a/drivers/i2c/chips/Kconfig
+++ b/drivers/i2c/chips/Kconfig
@@ -128,6 +128,10 @@ config TWL4030_GPIO
 	bool "TWL4030 GPIO Driver"
 	depends on TWL4030_CORE
 
+config TWL4030_MADC
+	tristate "TWL4030 MADC Driver"
+	depends on TWL4030_CORE
+
 config TWL4030_USB
 	bool "TWL4030 USB Transceiver Driver"
 	depends on TWL4030_CORE
diff --git a/drivers/i2c/chips/Makefile b/drivers/i2c/chips/Makefile
index 255fbb1..6431675 100644
--- a/drivers/i2c/chips/Makefile
+++ b/drivers/i2c/chips/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_TWL4030_CORE)	+= twl4030-core.o
 obj-$(CONFIG_TWL4030_GPIO)	+= twl4030-gpio.o
 obj-$(CONFIG_TWL4030_USB)	+= twl4030-usb.o
 obj-$(CONFIG_TWL4030_POWEROFF)	+= twl4030-poweroff.o
+obj-$(CONFIG_TWL4030_MADC)	+= twl4030-madc.o
 obj-$(CONFIG_RTC_X1205_I2C)	+= x1205.o
 
 ifeq ($(CONFIG_I2C_DEBUG_CHIP),y)
-- 
1.5.5.rc2.25.g5fbd

