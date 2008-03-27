From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 1/7] I2C: TWL4030: Move twl4030's headers under include/linux/i2c/
Date: Thu, 27 Mar 2008 19:16:01 +0200
Message-ID: <1206638167-23951-2-git-send-email-felipe.balbi@nokia.com>
References: <1206638167-23951-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40404 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756335AbYC0RSd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Mar 2008 13:18:33 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2RHKRlA018512
	for <linux-omap@vger.kernel.org>; Thu, 27 Mar 2008 12:20:36 -0500
In-Reply-To: <1206638167-23951-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Now that we have this directory we can use it.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-3430sdp.c                |    2 +-
 arch/arm/mach-omap2/board-sdp-hsmmc.c              |    2 +-
 drivers/i2c/chips/twl4030_core.c                   |    2 +-
 drivers/i2c/chips/twl4030_gpio.c                   |    2 +-
 drivers/i2c/chips/twl4030_poweroff.c               |    2 +-
 drivers/i2c/chips/twl4030_usb.c                    |    2 +-
 drivers/input/keyboard/omap-twl4030keypad.c        |    2 +-
 drivers/rtc/rtc-twl4030.c                          |    4 ++--
 .../{asm-arm/arch-omap => linux/i2c}/twl4030-rtc.h |    0 
 include/{asm-arm/arch-omap => linux/i2c}/twl4030.h |    0 
 10 files changed, 9 insertions(+), 9 deletions(-)
 rename include/{asm-arm/arch-omap => linux/i2c}/twl4030-rtc.h (100%)
 rename include/{asm-arm/arch-omap => linux/i2c}/twl4030.h (100%)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index f3a316f..1eb84a6 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -20,6 +20,7 @@
 #include <linux/workqueue.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/i2c/twl4030.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 
@@ -28,7 +29,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <asm/arch/twl4030.h>
 #include <asm/arch/mcspi.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/mux.h>
diff --git a/arch/arm/mach-omap2/board-sdp-hsmmc.c b/arch/arm/mach-omap2/board-sdp-hsmmc.c
index 7661a79..3ae5b20 100644
--- a/arch/arm/mach-omap2/board-sdp-hsmmc.c
+++ b/arch/arm/mach-omap2/board-sdp-hsmmc.c
@@ -13,8 +13,8 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/i2c/twl4030.h>
 #include <asm/hardware.h>
-#include <asm/arch/twl4030.h>
 #include <asm/arch/mmc.h>
 #include <asm/arch/board.h>
 #include <asm/io.h>
diff --git a/drivers/i2c/chips/twl4030_core.c b/drivers/i2c/chips/twl4030_core.c
index e733195..4f0f465 100644
--- a/drivers/i2c/chips/twl4030_core.c
+++ b/drivers/i2c/chips/twl4030_core.c
@@ -38,6 +38,7 @@
 #include <linux/kthread.h>
 
 #include <linux/i2c.h>
+#include <linux/i2c/twl4030.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -45,7 +46,6 @@
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 
-#include <asm/arch/twl4030.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/mux.h>
 
diff --git a/drivers/i2c/chips/twl4030_gpio.c b/drivers/i2c/chips/twl4030_gpio.c
index 9054cc9..a9f3b1d 100644
--- a/drivers/i2c/chips/twl4030_gpio.c
+++ b/drivers/i2c/chips/twl4030_gpio.c
@@ -36,9 +36,9 @@
 #include <linux/kthread.h>
 
 #include <linux/i2c.h>
+#include <linux/i2c/twl4030.h>
 #include <linux/slab.h>
 
-#include <asm/arch/twl4030.h>
 #include <asm/arch/irqs.h>
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
diff --git a/drivers/i2c/chips/twl4030_poweroff.c b/drivers/i2c/chips/twl4030_poweroff.c
index 7a176d9..dbe413a 100644
--- a/drivers/i2c/chips/twl4030_poweroff.c
+++ b/drivers/i2c/chips/twl4030_poweroff.c
@@ -23,7 +23,7 @@
 
 #include <linux/module.h>
 #include <linux/pm.h>
-#include <asm/arch/twl4030.h>
+#include <linux/i2c/twl4030.h>
 
 #define PWR_P1_SW_EVENTS	0x10
 #define PWR_DEVOFF	(1<<0)
diff --git a/drivers/i2c/chips/twl4030_usb.c b/drivers/i2c/chips/twl4030_usb.c
index b3365f6..cf86d3e 100644
--- a/drivers/i2c/chips/twl4030_usb.c
+++ b/drivers/i2c/chips/twl4030_usb.c
@@ -29,7 +29,7 @@
 #include <linux/interrupt.h>
 #include <linux/usb.h>
 
-#include <asm/arch/twl4030.h>
+#include <linux/i2c/twl4030.h>
 
 /* Register defines */
 
diff --git a/drivers/input/keyboard/omap-twl4030keypad.c b/drivers/input/keyboard/omap-twl4030keypad.c
index 4750dba..3bc3045 100644
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -33,9 +33,9 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/i2c.h>
+#include <linux/i2c/twl4030.h>
 #include <asm/irq.h>
 #include <asm/arch/keypad.h>
-#include <asm/arch/twl4030.h>
 #include "twl4030-keypad.h"
 
 #define OMAP_TWL4030KP_LOG_LEVEL	0
diff --git a/drivers/rtc/rtc-twl4030.c b/drivers/rtc/rtc-twl4030.c
index b50de5f..929a788 100644
--- a/drivers/rtc/rtc-twl4030.c
+++ b/drivers/rtc/rtc-twl4030.c
@@ -34,14 +34,14 @@
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
+#include <linux/i2c/twl4030.h>
+#include <linux/i2c/twl4030-rtc.h>
 
 #include <asm/io.h>
 #include <asm/mach/time.h>
 #include <asm/system.h>
 #include <asm/hardware.h>
 #include <asm/irq.h>
-#include <asm/arch/twl4030.h>
-#include <asm/arch/twl4030-rtc.h>
 
 #define ALL_TIME_REGS		6
 
diff --git a/include/asm-arm/arch-omap/twl4030-rtc.h b/include/linux/i2c/twl4030-rtc.h
similarity index 100%
rename from include/asm-arm/arch-omap/twl4030-rtc.h
rename to include/linux/i2c/twl4030-rtc.h
diff --git a/include/asm-arm/arch-omap/twl4030.h b/include/linux/i2c/twl4030.h
similarity index 100%
rename from include/asm-arm/arch-omap/twl4030.h
rename to include/linux/i2c/twl4030.h
-- 
1.5.5.rc1.12.g660b9

