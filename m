From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 04/21] ARM: OMAP: Complete LCD panel gpiolib conversion
Date: Wed, 29 Oct 2008 13:36:12 +0200
Message-ID: <1225280189-6559-5-git-send-email-jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59797 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273AbYJ2LhH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:37:07 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBac0Q016561
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 13:37:05 +0200
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/video/omap/lcd_2430sdp.c     |    6 +++---
 drivers/video/omap/lcd_omap2evm.c    |   14 +++++++-------
 drivers/video/omap/lcd_omap3beagle.c |    4 ++--
 drivers/video/omap/lcd_omap3evm.c    |   12 ++++++------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/video/omap/lcd_2430sdp.c b/drivers/video/omap/lcd_2430sdp.c
index d60e846..2763117 100644
--- a/drivers/video/omap/lcd_2430sdp.c
+++ b/drivers/video/omap/lcd_2430sdp.c
@@ -24,9 +24,9 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <linux/i2c/twl4030.h>
 
-#include <mach/gpio.h>
 #include <mach/mux.h>
 #include <mach/omapfb.h>
 #include <asm/mach-types.h>
@@ -65,8 +65,8 @@ static int sdp2430_panel_init(struct lcd_panel *panel,
 		backlight_gpio = SDP2430_LCD_PANEL_BACKLIGHT_GPIO;
 	}
 
-	omap_request_gpio(enable_gpio);			/* LCD panel */
-	omap_request_gpio(backlight_gpio);		/* LCD backlight */
+	gpio_request(enable_gpio, "LCD enable");	/* LCD panel */
+	gpio_request(backlight_gpio, "LCD bl");		/* LCD backlight */
 	gpio_direction_output(enable_gpio, 0);
 	gpio_direction_output(backlight_gpio, 0);
 
diff --git a/drivers/video/omap/lcd_omap2evm.c b/drivers/video/omap/lcd_omap2evm.c
index 424fbae..2fc46c2 100644
--- a/drivers/video/omap/lcd_omap2evm.c
+++ b/drivers/video/omap/lcd_omap2evm.c
@@ -23,9 +23,9 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/gpio.h>
 #include <linux/i2c/twl4030.h>
 
-#include <mach/gpio.h>
 #include <mach/mux.h>
 #include <mach/omapfb.h>
 #include <asm/mach-types.h>
@@ -50,12 +50,12 @@ static unsigned int bklight_level;
 static int omap2evm_panel_init(struct lcd_panel *panel,
 				struct omapfb_device *fbdev)
 {
-	omap_request_gpio(LCD_PANEL_ENABLE_GPIO);
-	omap_request_gpio(LCD_PANEL_LR);
-	omap_request_gpio(LCD_PANEL_UD);
-	omap_request_gpio(LCD_PANEL_INI);
-	omap_request_gpio(LCD_PANEL_QVGA);
-	omap_request_gpio(LCD_PANEL_RESB);
+	gpio_request(LCD_PANEL_ENABLE_GPIO, "LCD enable");
+	gpio_request(LCD_PANEL_LR, "LCD lr");
+	gpio_request(LCD_PANEL_UD, "LCD ud");
+	gpio_request(LCD_PANEL_INI, "LCD ini");
+	gpio_request(LCD_PANEL_QVGA, "LCD qvga");
+	gpio_request(LCD_PANEL_RESB, "LCD resb");
 
 	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 1);
 	gpio_direction_output(LCD_PANEL_RESB, 1);
diff --git a/drivers/video/omap/lcd_omap3beagle.c b/drivers/video/omap/lcd_omap3beagle.c
index 0c779e4..eae43e4 100644
--- a/drivers/video/omap/lcd_omap3beagle.c
+++ b/drivers/video/omap/lcd_omap3beagle.c
@@ -22,9 +22,9 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/gpio.h>
 #include <linux/i2c/twl4030.h>
 
-#include <mach/gpio.h>
 #include <mach/mux.h>
 #include <mach/omapfb.h>
 #include <asm/mach-types.h>
@@ -38,7 +38,7 @@
 static int omap3beagle_panel_init(struct lcd_panel *panel,
 				struct omapfb_device *fbdev)
 {
-	omap_request_gpio(LCD_PANEL_ENABLE_GPIO);
+	gpio_request(LCD_PANEL_ENABLE_GPIO, "LCD enable");
 	return 0;
 }
 
diff --git a/drivers/video/omap/lcd_omap3evm.c b/drivers/video/omap/lcd_omap3evm.c
index 90aa015..1c3d814 100644
--- a/drivers/video/omap/lcd_omap3evm.c
+++ b/drivers/video/omap/lcd_omap3evm.c
@@ -22,9 +22,9 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/gpio.h>
 #include <linux/i2c/twl4030.h>
 
-#include <mach/gpio.h>
 #include <mach/mux.h>
 #include <mach/omapfb.h>
 #include <asm/mach-types.h>
@@ -54,11 +54,11 @@ static unsigned int bklight_level;
 static int omap3evm_panel_init(struct lcd_panel *panel,
 				struct omapfb_device *fbdev)
 {
-	omap_request_gpio(LCD_PANEL_LR);
-	omap_request_gpio(LCD_PANEL_UD);
-	omap_request_gpio(LCD_PANEL_INI);
-	omap_request_gpio(LCD_PANEL_RESB);
-	omap_request_gpio(LCD_PANEL_QVGA);
+	gpio_request(LCD_PANEL_LR, "LCD lr");
+	gpio_request(LCD_PANEL_UD, "LCD ud");
+	gpio_request(LCD_PANEL_INI, "LCD ini");
+	gpio_request(LCD_PANEL_RESB, "LCD resb");
+	gpio_request(LCD_PANEL_QVGA, "LCD qvga");
 
 	gpio_direction_output(LCD_PANEL_RESB, 1);
 	gpio_direction_output(LCD_PANEL_INI, 1);
-- 
1.5.6.5

