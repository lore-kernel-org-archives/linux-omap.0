From: Francisco Alecrim <francisco.alecrim@indt.org.br>
Subject: [PATCH] i2c: Update twl4030's includes
Date: Sat, 29 Mar 2008 21:00:19 +0200
Message-ID: <1206817219-22322-1-git-send-email-francisco.alecrim@indt.org.br>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30112 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962AbYC2TIF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Mar 2008 15:08:05 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2TJ9kqp024154
	for <linux-omap@vger.kernel.org>; Sat, 29 Mar 2008 14:10:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Francisco Alecrim <francisco.alecrim@indt.org.br>

Update twl4030's includes. Headers now available under include/linux/i2c.

arch/arm/mach-omap2/board-2430sdp.c:41:34: error: asm/arch/twl4030-rtc.h: No such file or directory
drivers/video/omap/lcd_2430sdp.c:30:30: error: asm/arch/twl4030.h: No such file or directory

Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
---
 arch/arm/mach-omap2/board-2430sdp.c |    2 +-
 drivers/video/omap/lcd_2430sdp.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index c2d3c4d..5228d29 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -24,6 +24,7 @@
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
+#include <linux/i2c/twl4030-rtc.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -38,7 +39,6 @@
 #include <asm/arch/keypad.h>
 #include <asm/arch/gpmc.h>
 #include <asm/arch/mcspi.h>
-#include <asm/arch/twl4030-rtc.h>
 
 #include <asm/io.h>
 
diff --git a/drivers/video/omap/lcd_2430sdp.c b/drivers/video/omap/lcd_2430sdp.c
index 2464e85..8ba15dc 100644
--- a/drivers/video/omap/lcd_2430sdp.c
+++ b/drivers/video/omap/lcd_2430sdp.c
@@ -23,11 +23,11 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/i2c/twl4030.h>
 
 #include <asm/arch/gpio.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/omapfb.h>
-#include <asm/arch/twl4030.h>
 #include <asm/mach-types.h>
 
 #define SDP2430_LCD_PANEL_BACKLIGHT_GPIO	91
-- 
1.5.4.23.gef5b9

