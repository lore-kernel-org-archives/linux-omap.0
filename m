From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH] [OMAP] HTCHERALD: MMC, I2C, HTCPLD, SPI, TSC2046
Date: Tue, 17 Aug 2010 21:35:46 -0700
Message-ID: <1282106146-7727-1-git-send-email-darkstar6262@gmail.com>
References: <1282106047-7619-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63232 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956Ab0HREgF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Aug 2010 00:36:05 -0400
Received: by iwn7 with SMTP id 7so214664iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 17 Aug 2010 21:36:04 -0700 (PDT)
In-Reply-To: <1282106047-7619-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Cory Maccarrone <darkstar6262@gmail.com>

This change adds in MMC and I2C support to the HTC Herald board, as well
as adding the HTCPLD driver for the PLD used on this phone.  It also
adds in the gpio-keys entries for the front directional keys and
selector and the cursor keys on the slide-out keyboard, and gpio-leds
support for the LEDs attached to the htcpld.

Additionally, SPI bus support (using the spi100k driver) and
touchscreen support (using the ads7846 driver) were added.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/mach-omap1/board-htcherald.c |  322 ++++++++++++++++++++++++++++++++-
 1 files changed, 316 insertions(+), 6 deletions(-)

This submission is a merging of the two patches:

    [OMAP] HTCHERALD: MMC, I2C, HTCPLD and related devices
    [OMAP] htcherald: SPI register config, TSC2046 touchscreen


diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 311899f..7ea75c1 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -30,6 +30,13 @@
 #include <linux/input.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/gpio_keys.h>
+#include <linux/i2c.h>
+#include <linux/i2c-gpio.h>
+#include <linux/htcpld.h>
+#include <linux/leds.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -39,6 +46,7 @@
 #include <plat/board.h>
 #include <plat/keypad.h>
 #include <plat/usb.h>
+#include <plat/mmc.h>
 
 #include <mach/irqs.h>
 
@@ -52,13 +60,123 @@
 #define       OMAP_LCDC_CTRL_LCD_EN           (1 << 0)
 #define       OMAP_LCDC_STAT_DONE             (1 << 0)
 
-static struct omap_lcd_config htcherald_lcd_config __initdata = {
-	.ctrl_name	= "internal",
-};
+/* GPIO definitions for the power button and keyboard slide switch */
+#define HTCHERALD_GPIO_POWER 139
+#define HTCHERALD_GPIO_SLIDE 174
+#define HTCHERALD_GIRQ_BTNS 141
 
-static struct omap_board_config_kernel htcherald_config[] __initdata = {
-	{ OMAP_TAG_LCD, &htcherald_lcd_config },
-};
+/* GPIO definitions for the touchscreen */
+#define HTCHERALD_GPIO_TS 76
+
+/* HTCPLD definitions */
+
+/*
+ * CPLD Logic
+ *
+ * Chip 3 - 0x03
+ *
+ * Function            7 6 5 4  3 2 1 0
+ * ------------------------------------
+ * DPAD light          x x x x  x x x 1
+ * SoundDev            x x x x  1 x x x
+ * Screen white        1 x x x  x x x x
+ * MMC power on        x x x x  x 1 x x
+ * Happy times (n)     0 x x x  x 1 x x
+ *
+ * Chip 4 - 0x04
+ *
+ * Function            7 6 5 4  3 2 1 0
+ * ------------------------------------
+ * Keyboard light      x x x x  x x x 1
+ * LCD Bright (4)      x x x x  x 1 1 x
+ * LCD Bright (3)      x x x x  x 0 1 x
+ * LCD Bright (2)      x x x x  x 1 0 x
+ * LCD Bright (1)      x x x x  x 0 0 x
+ * LCD Off             x x x x  0 x x x
+ * LCD image (fb)      1 x x x  x x x x
+ * LCD image (white)   0 x x x  x x x x
+ * Caps lock LED       x x 1 x  x x x x
+ *
+ * Chip 5 - 0x05
+ *
+ * Function            7 6 5 4  3 2 1 0
+ * ------------------------------------
+ * Red (solid)         x x x x  x 1 x x
+ * Red (flash)         x x x x  x x 1 x
+ * Green (GSM flash)   x x x x  1 x x x
+ * Green (GSM solid)   x x x 1  x x x x
+ * Green (wifi flash)  x x 1 x  x x x x
+ * Blue (bt flash)     x 1 x x  x x x x
+ * DPAD Int Enable     1 x x x  x x x 0
+ *
+ * (Combinations of the above can be made for different colors.)
+ * The direction pad interrupt enable must be set each time the
+ * interrupt is handled.
+ *
+ * Chip 6 - 0x06
+ *
+ * Function            7 6 5 4  3 2 1 0
+ * ------------------------------------
+ * Vibrator            x x x x  1 x x x
+ * Alt LED             x x x 1  x x x x
+ * Screen white        1 x x x  x x x x
+ * Screen white        x x 1 x  x x x x
+ * Screen white        x 0 x x  x x x x
+ * Enable kbd dpad     x x x x  x x 0 x
+ * Happy Times         0 1 0 x  x x 0 x
+ */
+
+/*
+ * HTCPLD GPIO lines start 16 after OMAP_MAX_GPIO_LINES to account
+ * for the 16 MPUIO lines.
+ */
+#define HTCPLD_GPIO_START_OFFSET	(OMAP_MAX_GPIO_LINES + 16)
+#define HTCPLD_IRQ(chip, offset)	(OMAP_IRQ_END + 8 * (chip) + (offset))
+#define HTCPLD_BASE(chip, offset)	\
+	(HTCPLD_GPIO_START_OFFSET + 8 * (chip) + (offset))
+
+#define HTCPLD_GPIO_LED_DPAD		HTCPLD_BASE(0, 0)
+#define HTCPLD_GPIO_LED_KBD		HTCPLD_BASE(1, 0)
+#define HTCPLD_GPIO_LED_CAPS		HTCPLD_BASE(1, 5)
+#define HTCPLD_GPIO_LED_RED_FLASH	HTCPLD_BASE(2, 1)
+#define HTCPLD_GPIO_LED_RED_SOLID	HTCPLD_BASE(2, 2)
+#define HTCPLD_GPIO_LED_GREEN_FLASH	HTCPLD_BASE(2, 3)
+#define HTCPLD_GPIO_LED_GREEN_SOLID	HTCPLD_BASE(2, 4)
+#define HTCPLD_GPIO_LED_WIFI		HTCPLD_BASE(2, 5)
+#define HTCPLD_GPIO_LED_BT		HTCPLD_BASE(2, 6)
+#define HTCPLD_GPIO_LED_VIBRATE		HTCPLD_BASE(3, 3)
+#define HTCPLD_GPIO_LED_ALT		HTCPLD_BASE(3, 4)
+
+#define HTCPLD_GPIO_RIGHT_KBD		HTCPLD_BASE(6, 7)
+#define HTCPLD_GPIO_UP_KBD		HTCPLD_BASE(6, 6)
+#define HTCPLD_GPIO_LEFT_KBD		HTCPLD_BASE(6, 5)
+#define HTCPLD_GPIO_DOWN_KBD		HTCPLD_BASE(6, 4)
+
+#define HTCPLD_GPIO_RIGHT_DPAD		HTCPLD_BASE(7, 7)
+#define HTCPLD_GPIO_UP_DPAD		HTCPLD_BASE(7, 6)
+#define HTCPLD_GPIO_LEFT_DPAD		HTCPLD_BASE(7, 5)
+#define HTCPLD_GPIO_DOWN_DPAD		HTCPLD_BASE(7, 4)
+#define HTCPLD_GPIO_ENTER_DPAD		HTCPLD_BASE(7, 3)
+
+/*
+ * The htcpld chip requires a gpio write to a specific line
+ * to re-enable interrupts after one has occurred.
+ */
+#define HTCPLD_GPIO_INT_RESET_HI	HTCPLD_BASE(2, 7)
+#define HTCPLD_GPIO_INT_RESET_LO	HTCPLD_BASE(2, 0)
+
+/* Chip 5 */
+#define HTCPLD_IRQ_RIGHT_KBD		HTCPLD_IRQ(0, 7)
+#define HTCPLD_IRQ_UP_KBD		HTCPLD_IRQ(0, 6)
+#define HTCPLD_IRQ_LEFT_KBD		HTCPLD_IRQ(0, 5)
+#define HTCPLD_IRQ_DOWN_KBD		HTCPLD_IRQ(0, 4)
+
+/* Chip 6 */
+#define HTCPLD_IRQ_RIGHT_DPAD		HTCPLD_IRQ(1, 7)
+#define HTCPLD_IRQ_UP_DPAD		HTCPLD_IRQ(1, 6)
+#define HTCPLD_IRQ_LEFT_DPAD		HTCPLD_IRQ(1, 5)
+#define HTCPLD_IRQ_DOWN_DPAD		HTCPLD_IRQ(1, 4)
+#define HTCPLD_IRQ_ENTER_DPAD		HTCPLD_IRQ(1, 3)
 
 /* Keyboard definition */
 
@@ -140,6 +258,129 @@ static struct platform_device kp_device = {
 	.resource	= kp_resources,
 };
 
+/* GPIO buttons for keyboard slide and power button */
+static struct gpio_keys_button herald_gpio_keys_table[] = {
+	{BTN_0,  HTCHERALD_GPIO_POWER, 1, "POWER", EV_KEY, 1, 20},
+	{SW_LID, HTCHERALD_GPIO_SLIDE, 0, "SLIDE", EV_SW,  1, 20},
+
+	{KEY_LEFT,  HTCPLD_GPIO_LEFT_KBD,  1, "LEFT",  EV_KEY, 1, 20},
+	{KEY_RIGHT, HTCPLD_GPIO_RIGHT_KBD, 1, "RIGHT", EV_KEY, 1, 20},
+	{KEY_UP,    HTCPLD_GPIO_UP_KBD,    1, "UP",    EV_KEY, 1, 20},
+	{KEY_DOWN,  HTCPLD_GPIO_DOWN_KBD,  1, "DOWN",  EV_KEY, 1, 20},
+
+	{KEY_LEFT,  HTCPLD_GPIO_LEFT_DPAD,   1, "DLEFT",  EV_KEY, 1, 20},
+	{KEY_RIGHT, HTCPLD_GPIO_RIGHT_DPAD,  1, "DRIGHT", EV_KEY, 1, 20},
+	{KEY_UP,    HTCPLD_GPIO_UP_DPAD,     1, "DUP",    EV_KEY, 1, 20},
+	{KEY_DOWN,  HTCPLD_GPIO_DOWN_DPAD,   1, "DDOWN",  EV_KEY, 1, 20},
+	{KEY_ENTER, HTCPLD_GPIO_ENTER_DPAD,  1, "DENTER", EV_KEY, 1, 20},
+};
+
+static struct gpio_keys_platform_data herald_gpio_keys_data = {
+	.buttons	= herald_gpio_keys_table,
+	.nbuttons	= ARRAY_SIZE(herald_gpio_keys_table),
+	.rep		= 1,
+};
+
+static struct platform_device herald_gpiokeys_device = {
+	.name      = "gpio-keys",
+	.id		= -1,
+	.dev = {
+		.platform_data = &herald_gpio_keys_data,
+	},
+};
+
+/* LEDs for the Herald.  These connect to the HTCPLD GPIO device. */
+static struct gpio_led gpio_leds[] = {
+	{"dpad",        NULL, HTCPLD_GPIO_LED_DPAD,        0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"kbd",         NULL, HTCPLD_GPIO_LED_KBD,         0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"vibrate",     NULL, HTCPLD_GPIO_LED_VIBRATE,     0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"green_solid", NULL, HTCPLD_GPIO_LED_GREEN_SOLID, 0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"green_flash", NULL, HTCPLD_GPIO_LED_GREEN_FLASH, 0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"red_solid",   "mmc0", HTCPLD_GPIO_LED_RED_SOLID, 0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"red_flash",   NULL, HTCPLD_GPIO_LED_RED_FLASH,   0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"wifi",        NULL, HTCPLD_GPIO_LED_WIFI,        0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"bt",          NULL, HTCPLD_GPIO_LED_BT,          0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"caps",        NULL, HTCPLD_GPIO_LED_CAPS,        0, 0, LEDS_GPIO_DEFSTATE_OFF},
+	{"alt",         NULL, HTCPLD_GPIO_LED_ALT,         0, 0, LEDS_GPIO_DEFSTATE_OFF},
+};
+
+static struct gpio_led_platform_data gpio_leds_data = {
+	.leds		= gpio_leds,
+	.num_leds	= ARRAY_SIZE(gpio_leds),
+};
+
+static struct platform_device gpio_leds_device = {
+	.name		= "leds-gpio",
+	.id		= 0,
+	.dev	= {
+		.platform_data	= &gpio_leds_data,
+	},
+};
+
+/* HTC PLD chips */
+
+static struct resource htcpld_resources[] = {
+	[0] = {
+		.start  = OMAP_GPIO_IRQ(HTCHERALD_GIRQ_BTNS),
+		.end    = OMAP_GPIO_IRQ(HTCHERALD_GIRQ_BTNS),
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+struct htcpld_chip_platform_data htcpld_chips[] = {
+	[0] = {
+		.addr		= 0x03,
+		.reset		= 0x04,
+		.num_gpios	= 8,
+		.gpio_out_base	= HTCPLD_BASE(0, 0),
+		.gpio_in_base	= HTCPLD_BASE(4, 0),
+	},
+	[1] = {
+		.addr		= 0x04,
+		.reset		= 0x8e,
+		.num_gpios	= 8,
+		.gpio_out_base	= HTCPLD_BASE(1, 0),
+		.gpio_in_base	= HTCPLD_BASE(5, 0),
+	},
+	[2] = {
+		.addr		= 0x05,
+		.reset		= 0x80,
+		.num_gpios	= 8,
+		.gpio_out_base	= HTCPLD_BASE(2, 0),
+		.gpio_in_base	= HTCPLD_BASE(6, 0),
+		.irq_base	= HTCPLD_IRQ(0, 0),
+		.num_irqs	= 8,
+	},
+	[3] = {
+		.addr		= 0x06,
+		.reset		= 0x40,
+		.num_gpios	= 8,
+		.gpio_out_base	= HTCPLD_BASE(3, 0),
+		.gpio_in_base	= HTCPLD_BASE(7, 0),
+		.irq_base	= HTCPLD_IRQ(1, 0),
+		.num_irqs	= 8,
+	},
+};
+
+struct htcpld_core_platform_data htcpld_pfdata = {
+	.int_reset_gpio_hi = HTCPLD_GPIO_INT_RESET_HI,
+	.int_reset_gpio_lo = HTCPLD_GPIO_INT_RESET_LO,
+	.i2c_adapter_id	   = 1,
+
+	.chip		   = htcpld_chips,
+	.num_chip	   = ARRAY_SIZE(htcpld_chips),
+};
+
+static struct platform_device htcpld_device = {
+	.name		= "i2c-htcpld",
+	.id		= -1,
+	.resource	= htcpld_resources,
+	.num_resources	= ARRAY_SIZE(htcpld_resources),
+	.dev	= {
+		.platform_data	= &htcpld_pfdata,
+	},
+};
+
 /* USB Device */
 static struct omap_usb_config htcherald_usb_config __initdata = {
 	.otg = 0,
@@ -150,14 +391,72 @@ static struct omap_usb_config htcherald_usb_config __initdata = {
 };
 
 /* LCD Device resources */
+static struct omap_lcd_config htcherald_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
+static struct omap_board_config_kernel htcherald_config[] __initdata = {
+	{ OMAP_TAG_LCD, &htcherald_lcd_config },
+};
+
 static struct platform_device lcd_device = {
 	.name           = "lcd_htcherald",
 	.id             = -1,
 };
 
+/* MMC Card */
+#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+static struct omap_mmc_platform_data htc_mmc1_data = {
+	.nr_slots                       = 1,
+	.switch_slot                    = NULL,
+	.slots[0]       = {
+		.ocr_mask               = MMC_VDD_28_29 | MMC_VDD_30_31 |
+					  MMC_VDD_32_33 | MMC_VDD_33_34,
+		.name                   = "mmcblk",
+		.nomux                  = 1,
+		.wires                  = 4,
+		.switch_pin             = -1,
+	},
+};
+
+static struct omap_mmc_platform_data *htc_mmc_data[1];
+#endif
+
+
+/* Platform devices for the Herald */
 static struct platform_device *devices[] __initdata = {
 	&kp_device,
 	&lcd_device,
+	&htcpld_device,
+	&gpio_leds_device,
+	&herald_gpiokeys_device,
+};
+
+/*
+ * Touchscreen
+ */
+static const struct ads7846_platform_data htcherald_ts_platform_data = {
+	.model			= 7846,
+	.keep_vref_on		= 1,
+	.x_plate_ohms		= 496,
+	.gpio_pendown		= HTCHERALD_GPIO_TS,
+	.pressure_max		= 100000,
+	.pressure_min		= 5000,
+	.x_min			= 528,
+	.x_max			= 3760,
+	.y_min			= 624,
+	.y_max			= 3760,
+};
+
+static struct spi_board_info __initdata htcherald_spi_board_info[] = {
+	{
+		.modalias		= "ads7846",
+		.platform_data		= &htcherald_ts_platform_data,
+		.irq			= OMAP_GPIO_IRQ(HTCHERALD_GPIO_TS),
+		.max_speed_hz		= 2500000,
+		.bus_num		= 2,
+		.chip_select		= 1,
+	}
 };
 
 /*
@@ -278,6 +577,7 @@ static void __init htcherald_init(void)
 {
 	printk(KERN_INFO "HTC Herald init.\n");
 
+	/* Do board initialization before we register all the devices */
 	omap_gpio_init();
 
 	omap_board_config = htcherald_config;
@@ -288,6 +588,16 @@ static void __init htcherald_init(void)
 
 	htcherald_usb_enable();
 	omap1_usb_init(&htcherald_usb_config);
+
+	spi_register_board_info(htcherald_spi_board_info,
+		ARRAY_SIZE(htcherald_spi_board_info));
+
+	omap_register_i2c_bus(1, 100, NULL, 0);
+
+#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
+	htc_mmc_data[0] = &htc_mmc1_data;
+	omap1_init_mmc(htc_mmc_data, 1);
+#endif
 }
 
 static void __init htcherald_init_irq(void)
-- 
1.7.0.4

