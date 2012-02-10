From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [PATCH v2] ARM: OMAP1: ams-delta: clean up init data section assignments
Date: Fri, 10 Feb 2012 17:48:43 +0100
Message-ID: <1328892523-20735-1-git-send-email-jkrzyszt@tis.icnet.pl>
References: <1580046.EEGIFOPvyy@vclass>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1580046.EEGIFOPvyy@vclass>
Sender: linux-input-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Igor Grinberg <grinberg@compulab.co.il>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Artem Bityutskiy <Artem.Bityutskiy@linux.intel.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
List-Id: linux-omap@vger.kernel.org

The main purpose of this patch is to fix several section mismatch
warnings from the board file and a few board specific drivers,
introduced with recent Amstrad Delta patch series, some of them rising
up only when building with CONFIG_MODULES not set.

While being at it, section tagging of all init data found in the board
file have been revised and hopefully corrected and/or optimized.

Created and tested on top of current linux-omap/omap1, commit
967809bd7faf71ddc29c8081e0f21db8b201a0f4.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
 arch/arm/mach-omap1/board-ams-delta.c |   18 +++++++++---------
 drivers/input/serio/ams_delta_serio.c |    2 +-
 drivers/mtd/nand/ams-delta.c          |    2 +-
 drivers/video/omap/lcd_ams_delta.c    |    2 +-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 87b1303..bfe6fd1 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -150,7 +150,7 @@ static struct map_desc ams_delta_io_desc[] __initdata = {
 	}
 };
 
-static struct omap_lcd_config ams_delta_lcd_config = {
+static struct omap_lcd_config ams_delta_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
@@ -167,7 +167,7 @@ static struct omap_board_config_kernel ams_delta_config[] __initdata = {
 #define LATCH1_GPIO_BASE	232
 #define LATCH1_NGPIO		8
 
-static struct resource latch1_resources[] __initconst = {
+static struct resource latch1_resources[] = {
 	[0] = {
 		.name	= "dat",
 		.start	= LATCH1_PHYS,
@@ -176,7 +176,7 @@ static struct resource latch1_resources[] __initconst = {
 	},
 };
 
-static struct bgpio_pdata latch1_pdata __initconst = {
+static struct bgpio_pdata latch1_pdata = {
 	.base	= LATCH1_GPIO_BASE,
 	.ngpio	= LATCH1_NGPIO,
 };
@@ -191,7 +191,7 @@ static struct platform_device latch1_gpio_device = {
 	},
 };
 
-static struct resource latch2_resources[] __initconst = {
+static struct resource latch2_resources[] = {
 	[0] = {
 		.name	= "dat",
 		.start	= LATCH2_PHYS,
@@ -200,7 +200,7 @@ static struct resource latch2_resources[] __initconst = {
 	},
 };
 
-static struct bgpio_pdata latch2_pdata __initconst = {
+static struct bgpio_pdata latch2_pdata = {
 	.base	= AMS_DELTA_LATCH2_GPIO_BASE,
 	.ngpio	= AMS_DELTA_LATCH2_NGPIO,
 };
@@ -215,7 +215,7 @@ static struct platform_device latch2_gpio_device = {
 	},
 };
 
-static struct gpio latch_gpios[] __initconst = {
+static const struct gpio latch_gpios[] __initconst = {
 	{
 		.gpio	= LATCH1_GPIO_BASE + 6,
 		.flags	= GPIOF_OUT_INIT_LOW,
@@ -322,7 +322,7 @@ static struct platform_device ams_delta_lcd_device = {
 	.id	= -1,
 };
 
-static struct gpio_led gpio_leds[] __initconst = {
+static const struct gpio_led gpio_leds[] __initconst = {
 	{
 		.name		 = "camera",
 		.gpio		 = LATCH1_GPIO_BASE + 0,
@@ -358,7 +358,7 @@ static struct gpio_led gpio_leds[] __initconst = {
 	},
 };
 
-static struct gpio_led_platform_data leds_pdata __initconst = {
+static const struct gpio_led_platform_data leds_pdata __initconst = {
 	.leds		= gpio_leds,
 	.num_leds	= ARRAY_SIZE(gpio_leds),
 };
@@ -415,7 +415,7 @@ static struct platform_device *ams_delta_devices[] __initdata = {
 	&ams_delta_camera_device,
 };
 
-static struct platform_device *late_devices[] __initconst = {
+static struct platform_device *late_devices[] __initdata = {
 	&ams_delta_nand_device,
 	&ams_delta_lcd_device,
 };
diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index 0571e2e..bd5b10e 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -103,7 +103,7 @@ static void ams_delta_serio_close(struct serio *serio)
 	gpio_set_value(AMS_DELTA_GPIO_PIN_KEYBRD_PWR, 0);
 }
 
-static struct gpio ams_delta_gpios[] __initconst_or_module = {
+static const struct gpio ams_delta_gpios[] __initconst_or_module = {
 	{
 		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_DATA,
 		.flags	= GPIOF_DIR_IN,
diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
index 85934dc..7341695 100644
--- a/drivers/mtd/nand/ams-delta.c
+++ b/drivers/mtd/nand/ams-delta.c
@@ -145,7 +145,7 @@ static int ams_delta_nand_ready(struct mtd_info *mtd)
 	return gpio_get_value(AMS_DELTA_GPIO_PIN_NAND_RB);
 }
 
-static struct gpio _mandatory_gpio[] __initconst_or_module = {
+static const struct gpio _mandatory_gpio[] = {
 	{
 		.gpio	= AMS_DELTA_GPIO_PIN_NAND_NCE,
 		.flags	= GPIOF_OUT_INIT_HIGH,
diff --git a/drivers/video/omap/lcd_ams_delta.c b/drivers/video/omap/lcd_ams_delta.c
index 0e71e28..d3a3113 100644
--- a/drivers/video/omap/lcd_ams_delta.c
+++ b/drivers/video/omap/lcd_ams_delta.c
@@ -99,7 +99,7 @@ static struct lcd_ops ams_delta_lcd_ops = {
 
 /* omapfb panel section */
 
-static struct gpio _gpios[] __initconst_or_module = {
+static const struct gpio _gpios[] = {
 	{
 		.gpio	= AMS_DELTA_GPIO_PIN_LCD_VBLEN,
 		.flags	= GPIOF_OUT_INIT_LOW,
-- 
1.7.3.4

