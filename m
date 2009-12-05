From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] omap: pandora: board file updates for .33
Date: Sat,  5 Dec 2009 20:44:08 +0200
Message-ID: <1260038648-23069-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:41830 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932861AbZLESoL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Dec 2009 13:44:11 -0500
Received: by bwz27 with SMTP id 27so2660444bwz.21
        for <linux-omap@vger.kernel.org>; Sat, 05 Dec 2009 10:44:16 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>

Pandora board file updates:
- change keycodes of game buttons
  it was decided not to use ABXY layout by the developers.
- drop i2c bus 3 speed to 100kHz
  this is needed for battery monitoring chip to work reliably.
- drop pandora_lcd platform_device
  the older DSS driver was never functional on l-o or mainline
  kernels due to missing panel driver, so remove unneeded
  pandora_lcd platform_device. This also removes last OMAP_TAG
  from the board file. LCD support will be added for DSS2 driver.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 I can split this if needed, but I thought single patch might
 be easier to handle.

 arch/arm/mach-omap2/board-omap3pandora.c |   21 +++++----------------
 1 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 2db5ba5..89a541d 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -98,10 +98,10 @@ static struct gpio_keys_button pandora_gpio_keys[] = {
 	GPIO_BUTTON_LOW(103,	KEY_DOWN,	"down"),
 	GPIO_BUTTON_LOW(96,	KEY_LEFT,	"left"),
 	GPIO_BUTTON_LOW(98,	KEY_RIGHT,	"right"),
-	GPIO_BUTTON_LOW(111,	BTN_A,		"a"),
-	GPIO_BUTTON_LOW(106,	BTN_B,		"b"),
-	GPIO_BUTTON_LOW(109,	BTN_X,		"x"),
-	GPIO_BUTTON_LOW(101,	BTN_Y,		"y"),
+	GPIO_BUTTON_LOW(109,	KEY_KP1,	"game 1"),
+	GPIO_BUTTON_LOW(111,	KEY_KP2,	"game 2"),
+	GPIO_BUTTON_LOW(106,	KEY_KP3,	"game 3"),
+	GPIO_BUTTON_LOW(101,	KEY_KP4,	"game 4"),
 	GPIO_BUTTON_LOW(102,	BTN_TL,		"l"),
 	GPIO_BUTTON_LOW(97,	BTN_TL2,	"l2"),
 	GPIO_BUTTON_LOW(105,	BTN_TR,		"r"),
@@ -315,7 +315,7 @@ static int __init omap3pandora_i2c_init(void)
 	omap_register_i2c_bus(1, 2600, omap3pandora_i2c_boardinfo,
 			ARRAY_SIZE(omap3pandora_i2c_boardinfo));
 	/* i2c2 pins are not connected */
-	omap_register_i2c_bus(3, 400, NULL, 0);
+	omap_register_i2c_bus(3, 100, NULL, 0);
 	return 0;
 }
 
@@ -368,17 +368,7 @@ static struct spi_board_info omap3pandora_spi_board_info[] __initdata = {
 	}
 };
 
-static struct platform_device omap3pandora_lcd_device = {
-	.name		= "pandora_lcd",
-	.id		= -1,
-};
-
-static struct omap_lcd_config omap3pandora_lcd_config __initdata = {
-	.ctrl_name	= "internal",
-};
-
 static struct omap_board_config_kernel omap3pandora_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&omap3pandora_lcd_config },
 };
 
 static void __init omap3pandora_init_irq(void)
@@ -392,7 +382,6 @@ static void __init omap3pandora_init_irq(void)
 }
 
 static struct platform_device *omap3pandora_devices[] __initdata = {
-	&omap3pandora_lcd_device,
 	&pandora_leds_gpio,
 	&pandora_keys_gpio,
 };
-- 
1.6.3.3

