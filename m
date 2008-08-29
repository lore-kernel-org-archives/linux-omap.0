From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc3-omap1] omap3 beagle: input button
Date: Fri, 29 Aug 2008 10:06:46 -0700
Message-ID: <200808291006.46659.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp121.sbc.mail.sp1.yahoo.com ([69.147.64.94]:21104 "HELO
	smtp121.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753362AbYH2RN2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Aug 2008 13:13:28 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Export Beagle's "user" button through the input framework so it's
accessible using normal mechanisms.  This uses BTN_EXTRA for lack
of a more obvious choice.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- beagle.orig/arch/arm/mach-omap2/board-omap3beagle.c	2008-08-27 21:19:00.000000000 -0700
+++ beagle/arch/arm/mach-omap2/board-omap3beagle.c	2008-08-27 21:19:12.000000000 -0700
@@ -20,6 +20,10 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/leds.h>
+#include <linux/gpio.h>
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
+
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
@@ -30,7 +34,6 @@
 #include <asm/mach/map.h>
 #include <asm/mach/flash.h>
 
-#include <mach/gpio.h>
 #include <mach/board.h>
 #include <mach/usb-musb.h>
 #include <mach/usb-ehci.h>
@@ -165,6 +168,28 @@ static struct platform_device leds_gpio 
 	},
 };
 
+static struct gpio_keys_button gpio_buttons[] = {
+	{
+		.code			= BTN_EXTRA,
+		.gpio			= 7,
+		.desc			= "user",
+		.wakeup			= 1,
+	},
+};
+
+static struct gpio_keys_platform_data gpio_key_info = {
+	.buttons	= gpio_buttons,
+	.nbuttons	= ARRAY_SIZE(gpio_buttons),
+};
+
+static struct platform_device keys_gpio = {
+	.name	= "gpio-keys",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &gpio_key_info,
+	},
+};
+
 static struct omap_board_config_kernel omap3_beagle_config[] __initdata = {
 	{ OMAP_TAG_UART,	&omap3_beagle_uart_config },
 	{ OMAP_TAG_MMC,		&omap3beagle_mmc_config },
@@ -177,6 +202,7 @@ static struct platform_device *omap3_bea
 	&omap3_beagle_twl4030rtc_device,
 #endif
 	&leds_gpio,
+	&keys_gpio,
 };
 
 void __init omap3beagle_flash_init(void)
