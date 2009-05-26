From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RFC][PATCH] Add support for hook switch on ams-delta
Date: Tue, 26 May 2009 20:57:20 +0200
Message-ID: <200905262057.21890.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RuDHKJJO7NO0xZd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:43570 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755918AbZEZS55 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 May 2009 14:57:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-input@vger.kernel.org

--Boundary-00=_RuDHKJJO7NO0xZd
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This trivial patch adds gpio-keys compatible platform device definition to 
ams-delta board, that supports hook switch found on this videophone. It is 
derived from similiar definitions found in other boards code. The patch is 
based on linux-2.6.30-rc5. Any comments are welcome.

Cheers,
Janusz

--Boundary-00=_RuDHKJJO7NO0xZd
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ams-delta-hook-switch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ams-delta-hook-switch.patch"

diff -Npru a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
--- a/arch/arm/mach-omap1/board-ams-delta.c	2009-05-17 17:58:18.000000000 +0200
+++ b/arch/arm/mach-omap1/board-ams-delta.c	2009-05-17 16:22:59.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/input.h>
+#include <linux/gpio_keys.h>
 #include <linux/platform_device.h>
 
 #include <mach/hardware.h>
@@ -213,10 +214,35 @@ static struct platform_device ams_delta_
 	.id	= -1
 };
 
+static struct gpio_keys_button ams_delta_gpio_keys_buttons[] = {
+	[0] = {
+		.desc		= "hook_switch",
+		.type		= EV_SW,		/* or EV_KEY ? */
+		.code		= SW_HEADPHONE_INSERT,	/* or a new one ? */
+		.active_low	= 1,
+		.gpio		= AMS_DELTA_GPIO_PIN_HOOK_SWITCH,
+		.debounce_interval = 10,
+	},
+};
+
+static struct gpio_keys_platform_data ams_delta_gpio_keys = {
+	.buttons		= ams_delta_gpio_keys_buttons,
+	.nbuttons		= ARRAY_SIZE(ams_delta_gpio_keys_buttons),
+};
+
+static struct platform_device ams_delta_gpio_keys_device = {
+	.name			= "gpio-keys",
+	.id			= -1,
+	.dev			= {
+		.platform_data	= &ams_delta_gpio_keys,
+	},
+};
+
 static struct platform_device *ams_delta_devices[] __initdata = {
 	&ams_delta_kp_device,
 	&ams_delta_lcd_device,
 	&ams_delta_led_device,
+	&ams_delta_gpio_keys_device,
 };
 
 static void __init ams_delta_init(void)
@@ -233,6 +259,13 @@ static void __init ams_delta_init_irq(vo
 
 	omap_usb_init(&ams_delta_usb_config);
 	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
+
+	omap_cfg_reg(P20_1610_GPIO4); /* is this required? */
+
+	/* The hook switch state could be exposed over sysfs with gpio_export().
+	 * This should be done after the gpio-keys driver calls gpio_request(),
+	 * but I don't know how to do this from outside of the driver. */
+	/* gpio_export(AMS_DELTA_GPIO_PIN_HOOK_SWITCH, 0); */
 }
 
 static void __init ams_delta_map_io(void)

--Boundary-00=_RuDHKJJO7NO0xZd--
