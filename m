From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 9/9] omap3: pandora: board file updates for .33
Date: Tue, 08 Dec 2009 16:51:45 -0800
Message-ID: <20091209005145.5944.30731.stgit@localhost>
References: <20091209004630.5944.40334.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50039 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967045AbZLIAvk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 19:51:40 -0500
In-Reply-To: <20091209004630.5944.40334.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

From: Grazvydas Ignotas <notasas@gmail.com>

Pandora board file updates:
- change keycodes of game buttons
  it was decided not to use ABXY layout by the developers.
- drop i2c bus 3 speed to 100kHz
  this is needed for battery monitoring chip to work reliably.
- drop pandora_lcd platform_device
  the older DSS driver was never functional on l-o or mainline
  kernels due to missing panel driver, so remove unneeded
  pandora_lcd platform_device. This also removes last OMAP_TAG
  from the board file.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |   26 +++++---------------------
 1 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index c1cc99c..6f6c601 100644
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
 
@@ -368,23 +368,8 @@ static struct spi_board_info omap3pandora_spi_board_info[] __initdata = {
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
-static struct omap_board_config_kernel omap3pandora_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&omap3pandora_lcd_config },
-};
-
 static void __init omap3pandora_init_irq(void)
 {
-	omap_board_config = omap3pandora_config;
-	omap_board_config_size = ARRAY_SIZE(omap3pandora_config);
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
@@ -392,7 +377,6 @@ static void __init omap3pandora_init_irq(void)
 }
 
 static struct platform_device *omap3pandora_devices[] __initdata = {
-	&omap3pandora_lcd_device,
 	&pandora_leds_gpio,
 	&pandora_keys_gpio,
 };

