From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH 04/10] LED: Drop leds-ams-delta driver
Date: Sun, 11 Dec 2011 21:12:02 +0100
Message-ID: <1323634328-856-5-git-send-email-jkrzyszt__15054.0353650742$1323634581$gmane$org@tis.icnet.pl>
References: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1323634328-856-1-git-send-email-jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Richard Purdie <rpurdie@rpsys.net>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
List-Id: linux-omap@vger.kernel.org

This is no longer needed after the Amstrad Delta on-board LED devices
have been converted to leds-gpio compatible.

Created against linux-3.2-rc5.
Requires patch 3/10 "ARM: OMAP1: ams-delta: Supersede custom led device
by leds-gpio" for those LEDs to still work.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 drivers/leds/Kconfig          |    7 --
 drivers/leds/Makefile         |    1 -
 drivers/leds/leds-ams-delta.c |  137 -----------------------------------------
 3 files changed, 0 insertions(+), 145 deletions(-)
 delete mode 100644 drivers/leds/leds-ams-delta.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index ff203a4..3523746 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -74,13 +74,6 @@ config LEDS_S3C24XX
 	  This option enables support for LEDs connected to GPIO lines
 	  on Samsung S3C24XX series CPUs, such as the S3C2410 and S3C2440.
 
-config LEDS_AMS_DELTA
-	tristate "LED Support for the Amstrad Delta (E3)"
-	depends on LEDS_CLASS
-	depends on MACH_AMS_DELTA
-	help
-	  This option enables support for the LEDs on Amstrad Delta (E3).
-
 config LEDS_NET48XX
 	tristate "LED Support for Soekris net48xx series Error LED"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index e4f6bf5..f2b75b2 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -12,7 +12,6 @@ obj-$(CONFIG_LEDS_LOCOMO)		+= leds-locomo.o
 obj-$(CONFIG_LEDS_LM3530)		+= leds-lm3530.o
 obj-$(CONFIG_LEDS_MIKROTIK_RB532)	+= leds-rb532.o
 obj-$(CONFIG_LEDS_S3C24XX)		+= leds-s3c24xx.o
-obj-$(CONFIG_LEDS_AMS_DELTA)		+= leds-ams-delta.o
 obj-$(CONFIG_LEDS_NET48XX)		+= leds-net48xx.o
 obj-$(CONFIG_LEDS_NET5501)		+= leds-net5501.o
 obj-$(CONFIG_LEDS_WRAP)			+= leds-wrap.o
diff --git a/drivers/leds/leds-ams-delta.c b/drivers/leds/leds-ams-delta.c
deleted file mode 100644
index 8c00937..0000000
--- a/drivers/leds/leds-ams-delta.c
+++ /dev/null
@@ -1,137 +0,0 @@
-/*
- * LEDs driver for Amstrad Delta (E3)
- *
- * Copyright (C) 2006 Jonathan McDowell <noodles@earth.li>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/leds.h>
-#include <plat/board-ams-delta.h>
-
-/*
- * Our context
- */
-struct ams_delta_led {
-	struct led_classdev	cdev;
-	u8			bitmask;
-};
-
-static void ams_delta_led_set(struct led_classdev *led_cdev,
-		enum led_brightness value)
-{
-	struct ams_delta_led *led_dev =
-		container_of(led_cdev, struct ams_delta_led, cdev);
-
-	if (value)
-		ams_delta_latch1_write(led_dev->bitmask, led_dev->bitmask);
-	else
-		ams_delta_latch1_write(led_dev->bitmask, 0);
-}
-
-static struct ams_delta_led ams_delta_leds[] = {
-	{
-		.cdev		= {
-			.name		= "ams-delta::camera",
-			.brightness_set = ams_delta_led_set,
-		},
-		.bitmask	= AMS_DELTA_LATCH1_LED_CAMERA,
-	},
-	{
-		.cdev		= {
-			.name		= "ams-delta::advert",
-			.brightness_set = ams_delta_led_set,
-		},
-		.bitmask	= AMS_DELTA_LATCH1_LED_ADVERT,
-	},
-	{
-		.cdev		= {
-			.name		= "ams-delta::email",
-			.brightness_set = ams_delta_led_set,
-		},
-		.bitmask	= AMS_DELTA_LATCH1_LED_EMAIL,
-	},
-	{
-		.cdev		= {
-			.name		= "ams-delta::handsfree",
-			.brightness_set = ams_delta_led_set,
-		},
-		.bitmask	= AMS_DELTA_LATCH1_LED_HANDSFREE,
-	},
-	{
-		.cdev		= {
-			.name		= "ams-delta::voicemail",
-			.brightness_set = ams_delta_led_set,
-		},
-		.bitmask	= AMS_DELTA_LATCH1_LED_VOICEMAIL,
-	},
-	{
-		.cdev		= {
-			.name		= "ams-delta::voice",
-			.brightness_set = ams_delta_led_set,
-		},
-		.bitmask	= AMS_DELTA_LATCH1_LED_VOICE,
-	},
-};
-
-static int ams_delta_led_probe(struct platform_device *pdev)
-{
-	int i, ret;
-
-	for (i = 0; i < ARRAY_SIZE(ams_delta_leds); i++) {
-		ams_delta_leds[i].cdev.flags |= LED_CORE_SUSPENDRESUME;
-		ret = led_classdev_register(&pdev->dev,
-				&ams_delta_leds[i].cdev);
-		if (ret < 0)
-			goto fail;
-	}
-
-	return 0;
-fail:
-	while (--i >= 0)
-		led_classdev_unregister(&ams_delta_leds[i].cdev);
-	return ret;	
-}
-
-static int ams_delta_led_remove(struct platform_device *pdev)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(ams_delta_leds); i++)
-		led_classdev_unregister(&ams_delta_leds[i].cdev);
-
-	return 0;
-}
-
-static struct platform_driver ams_delta_led_driver = {
-	.probe		= ams_delta_led_probe,
-	.remove		= ams_delta_led_remove,
-	.driver		= {
-		.name = "ams-delta-led",
-		.owner = THIS_MODULE,
-	},
-};
-
-static int __init ams_delta_led_init(void)
-{
-	return platform_driver_register(&ams_delta_led_driver);
-}
-
-static void __exit ams_delta_led_exit(void)
-{
-	platform_driver_unregister(&ams_delta_led_driver);
-}
-
-module_init(ams_delta_led_init);
-module_exit(ams_delta_led_exit);
-
-MODULE_AUTHOR("Jonathan McDowell <noodles@earth.li>");
-MODULE_DESCRIPTION("Amstrad Delta LED driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:ams-delta-led");
-- 
1.7.3.4
