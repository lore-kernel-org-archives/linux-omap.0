From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/12] ARM: OMAP1: Palm Tungsten E board clean-up
Date: Mon, 14 Jan 2008 17:00:21 -0800
Message-ID: <20080115010020.GI7515@atomide.com>
References: <1197957418-23913-4-git-send-email-tony@atomide.com>
	<1197957418-23913-5-git-send-email-tony@atomide.com>
	<1197957418-23913-6-git-send-email-tony@atomide.com>
	<1197957418-23913-7-git-send-email-tony@atomide.com>
	<1197957418-23913-8-git-send-email-tony@atomide.com>
	<1197957418-23913-9-git-send-email-tony@atomide.com>
	<1197957418-23913-10-git-send-email-tony@atomide.com>
	<1197957418-23913-11-git-send-email-tony@atomide.com>
	<1197957418-23913-12-git-send-email-tony@atomide.com>
	<20071231143519.GE31777@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="rz+pwK2yUstbofK6"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20071231143519.GE31777@flint.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Andrzej Zaborowski <balrog@zabor.org>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [071231 06:35]:
> On Mon, Dec 17, 2007 at 09:56:57PM -0800, Tony Lindgren wrote:
> > @@ -339,74 +341,33 @@ static struct spi_board_info palmte_spi_info[] __initdata = {
> >  	},
> >  };
> >  
> > -/* Periodically check for changes on important input pins */
> > -struct timer_list palmte_pin_timer;
> > -int prev_power, prev_headphones;
> > -
> > -static void palmte_pin_handler(unsigned long data) {
> > -	int power, headphones;
> > -
> > -	power = !omap_get_gpio_datain(PALMTE_DC_GPIO);
> > -	headphones = omap_get_gpio_datain(PALMTE_HEADPHONES_GPIO);
> > -
> > -	if (power && !prev_power)
> > -		printk(KERN_INFO "PM: cable connected\n");
> > -	else if (!power && prev_power)
> > -		printk(KERN_INFO "PM: cable disconnected\n");
> > -
> > -	if (headphones && !prev_headphones) {
> > +static void palmte_headphones_detect(void *data, int state) {
> 
> That should be:
> 
> static void palmte_headphones_detect(void *data, int state)
> {
> 

Here's the fixed patch.

Tony

--rz+pwK2yUstbofK6
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="0010-ARM-OMAP1-Palm-Tungsten-E-board-clean-up.patch"

>From 460cfbc5be6057ec82e952e5a8fce582009fbdbc Mon Sep 17 00:00:00 2001
From: Andrzej Zaborowski <balrog@zabor.org>
Date: Wed, 6 Dec 2006 17:13:51 -0800
Subject: [PATCH] ARM: OMAP1: Palm Tungsten E board clean-up

Mostly gpio clean-up.

Signed-off-by: Andrzej Zaborowski <balrog@zabor.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-palmte.c |   82 +++++++++--------------------------
 1 files changed, 21 insertions(+), 61 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap1/board-palmte.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap1/board-palmte.c	2008-01-14 16:08:13.000000000 -0800
+++ linux-omap-2.6/arch/arm/mach-omap1/board-palmte.c	2008-01-14 16:09:30.000000000 -0800
@@ -10,6 +10,8 @@
  * Maintainers : http://palmtelinux.sf.net
  *                palmtelinux-developpers@lists.sf.net
  *
+ * Copyright (c) 2006 Andrzej Zaborowski  <balrog@zabor.org>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -24,8 +26,8 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/tsc2102.h>
 #include <linux/interrupt.h>
+#include <linux/apm-emulation.h>
 
-#include <asm/apm.h>
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -51,11 +53,11 @@ static void __init omap_palmte_init_irq(
 	omap_gpio_init();
 }
 
-static int palmte_keymap[] = {
-	KEY(0, 0, KEY_F1),
-	KEY(0, 1, KEY_F2),
-	KEY(0, 2, KEY_F3),
-	KEY(0, 3, KEY_F4),
+static const int palmte_keymap[] = {
+	KEY(0, 0, KEY_F1),		/* Calendar */
+	KEY(0, 1, KEY_F2),		/* Contacts */
+	KEY(0, 2, KEY_F3),		/* Tasks List */
+	KEY(0, 3, KEY_F4),		/* Note Pad */
 	KEY(0, 4, KEY_POWER),
 	KEY(1, 0, KEY_LEFT),
 	KEY(1, 1, KEY_DOWN),
@@ -68,7 +70,7 @@ static int palmte_keymap[] = {
 static struct omap_kp_platform_data palmte_kp_data = {
 	.rows	= 8,
 	.cols	= 8,
-	.keymap = palmte_keymap,
+	.keymap = (int *) palmte_keymap,
 	.rep	= 1,
 	.delay	= 12,
 };
@@ -180,7 +182,7 @@ static struct platform_device palmte_ird
 	.resource	= palmte_irda_resources,
 };
 
-static struct platform_device *devices[] __initdata = {
+static struct platform_device *palmte_devices[] __initdata = {
 	&palmte_rom_device,
 	&palmte_kp_device,
 	&palmte_lcd_device,
@@ -273,7 +275,7 @@ static void palmte_get_power_status(stru
 		info->time = 0;
 	} else {
 		while (hi > lo + 1) {
-			mid = (hi + lo) >> 2;
+			mid = (hi + lo) >> 1;
 			if (batt <= palmte_battery_sample[mid])
 				lo = mid;
 			else
@@ -321,7 +323,7 @@ static struct tsc2102_config palmte_tsc2
 	.alsa_config	= &palmte_alsa_config,
 };
 
-static struct omap_board_config_kernel palmte_config[] = {
+static struct omap_board_config_kernel palmte_config[] __initdata = {
 	{ OMAP_TAG_USB,		&palmte_usb_config },
 	{ OMAP_TAG_MMC,		&palmte_mmc_config },
 	{ OMAP_TAG_LCD,		&palmte_lcd_config },
@@ -339,74 +341,34 @@ static struct spi_board_info palmte_spi_
 	},
 };
 
-/* Periodically check for changes on important input pins */
-struct timer_list palmte_pin_timer;
-int prev_power, prev_headphones;
-
-static void palmte_pin_handler(unsigned long data) {
-	int power, headphones;
-
-	power = !omap_get_gpio_datain(PALMTE_DC_GPIO);
-	headphones = omap_get_gpio_datain(PALMTE_HEADPHONES_GPIO);
-
-	if (power && !prev_power)
-		printk(KERN_INFO "PM: cable connected\n");
-	else if (!power && prev_power)
-		printk(KERN_INFO "PM: cable disconnected\n");
-
-	if (headphones && !prev_headphones) {
+static void palmte_headphones_detect(void *data, int state)
+{
+	if (state) {
 		/* Headphones connected, disable speaker */
 		omap_set_gpio_dataout(PALMTE_SPEAKER_GPIO, 0);
 		printk(KERN_INFO "PM: speaker off\n");
-	} else if (!headphones && prev_headphones) {
+	} else {
 		/* Headphones unplugged, re-enable speaker */
 		omap_set_gpio_dataout(PALMTE_SPEAKER_GPIO, 1);
 		printk(KERN_INFO "PM: speaker on\n");
 	}
-
-	prev_power = power;
-	prev_headphones = headphones;
-	mod_timer(&palmte_pin_timer, jiffies + msecs_to_jiffies(500));
 }
 
-static void __init palmte_gpio_setup(void)
+static void __init palmte_misc_gpio_setup(void)
 {
-	/* Set TSC2102 PINTDAV pin as input */
+	/* Set TSC2102 PINTDAV pin as input (used by TSC2102 driver) */
 	if (omap_request_gpio(PALMTE_PINTDAV_GPIO)) {
 		printk(KERN_ERR "Could not reserve PINTDAV GPIO!\n");
 		return;
 	}
 	omap_set_gpio_direction(PALMTE_PINTDAV_GPIO, 1);
 
-	/* Monitor cable-connected signals */
-	if (omap_request_gpio(PALMTE_DC_GPIO) ||
-			omap_request_gpio(PALMTE_USB_OR_DC_GPIO) ||
-			omap_request_gpio(PALMTE_USBDETECT_GPIO)) {
+	/* Set USB-or-DC-IN pin as input (unused) */
+	if (omap_request_gpio(PALMTE_USB_OR_DC_GPIO)) {
 		printk(KERN_ERR "Could not reserve cable signal GPIO!\n");
 		return;
 	}
-	omap_set_gpio_direction(PALMTE_DC_GPIO, 1);
 	omap_set_gpio_direction(PALMTE_USB_OR_DC_GPIO, 1);
-	omap_set_gpio_direction(PALMTE_USBDETECT_GPIO, 1);
-
-	/* Set speaker-enable pin as output */
-	if (omap_request_gpio(PALMTE_SPEAKER_GPIO)) {
-		printk(KERN_ERR "Could not reserve speaker GPIO!\n");
-		return;
-	}
-	omap_set_gpio_direction(PALMTE_SPEAKER_GPIO, 0);
-
-	/* Monitor the headphones-connected signal */
-	if (omap_request_gpio(PALMTE_HEADPHONES_GPIO)) {
-		printk(KERN_ERR "Could not reserve headphones signal GPIO!\n");
-		return;
-	}
-	omap_set_gpio_direction(PALMTE_HEADPHONES_GPIO, 1);
-
-	prev_power = omap_get_gpio_datain(PALMTE_DC_GPIO);
-	prev_headphones = !omap_get_gpio_datain(PALMTE_HEADPHONES_GPIO);
-	setup_timer(&palmte_pin_timer, palmte_pin_handler, 0);
-	palmte_pin_handler(0);
 }
 
 static void __init omap_palmte_init(void)
@@ -414,13 +376,12 @@ static void __init omap_palmte_init(void
 	omap_board_config = palmte_config;
 	omap_board_config_size = ARRAY_SIZE(palmte_config);
 
-	platform_add_devices(devices, ARRAY_SIZE(devices));
+	platform_add_devices(palmte_devices, ARRAY_SIZE(palmte_devices));
 
 	spi_register_board_info(palmte_spi_info, ARRAY_SIZE(palmte_spi_info));
-
+	palmte_misc_gpio_setup();
 	omap_serial_init();
 	omap_register_i2c_bus(1, 100, NULL, 0);
-	palmte_gpio_setup();
 }
 
 static void __init omap_palmte_map_io(void)

--rz+pwK2yUstbofK6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
--rz+pwK2yUstbofK6--
