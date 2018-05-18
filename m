From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 1/6] ARM: OMAP1: ams-delta: add GPIO lookup tables
Date: Fri, 18 May 2018 23:09:49 +0200
Message-ID: <20180518210954.29044-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mark Brown <broonie@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Richard Weinberger <richard@nod.at>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Scope of the change is limited to GPIO pins used by board specific
device drivers which will be updated by follow-up patches of the
series. Those are some OMAP GPIO (gpio-0-15) and most of Amstrad Delta
latch2 GPIO bank pins. Remaining pins of those banks, as well as
Amstrad Delta latch1 pins, will be addressed later.

Assign a label ("latch2") to the bank, enumerate its pins and put that
information, together with OMAP GPIO bank pins, in GPIO lookup tables.
Assign lookup tables to devices as soon as those devices are registered
and their names can be obtained.

A step froward in:
- removal of hard-coded GPIO numbers from drivers,
- removal of board mach includes from drivers,
- switching to dynamically assigned GPIO numbers.

Created and compile tested agains linux-4.17-rc3

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 102 ++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 52e8e53ca154..4b78e73f8bf7 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -12,6 +12,7 @@
  * published by the Free Software Foundation.
  */
 #include <linux/gpio/driver.h>
+#include <linux/gpio/machine.h>
 #include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -202,7 +203,10 @@ static struct resource latch2_resources[] = {
 	},
 };
 
+#define LATCH2_LABEL	"latch2"
+
 static struct bgpio_pdata latch2_pdata = {
+	.label	= LATCH2_LABEL,
 	.base	= AMS_DELTA_LATCH2_GPIO_BASE,
 	.ngpio	= AMS_DELTA_LATCH2_NGPIO,
 };
@@ -217,6 +221,23 @@ static struct platform_device latch2_gpio_device = {
 	},
 };
 
+#define LATCH2_PIN_LCD_VBLEN		0
+#define LATCH2_PIN_LCD_NDISP		1
+#define LATCH2_PIN_NAND_NCE		2
+#define LATCH2_PIN_NAND_NRE		3
+#define LATCH2_PIN_NAND_NWP		4
+#define LATCH2_PIN_NAND_NWE		5
+#define LATCH2_PIN_NAND_ALE		6
+#define LATCH2_PIN_NAND_CLE		7
+#define LATCH2_PIN_KEYBRD_PWR		8
+#define LATCH2_PIN_KEYBRD_DATAOUT	9
+#define LATCH2_PIN_SCARD_RSTIN		10
+#define LATCH2_PIN_SCARD_CMDVCC		11
+#define LATCH2_PIN_MODEM_NRESET		12
+#define LATCH2_PIN_MODEM_CODEC		13
+#define LATCH2_PIN_HOOKFLASH1		14
+#define LATCH2_PIN_HOOKFLASH2		15
+
 static const struct gpio latch_gpios[] __initconst = {
 	{
 		.gpio	= LATCH1_GPIO_BASE + 6,
@@ -323,6 +344,22 @@ static struct platform_device ams_delta_nand_device = {
 	.resource	= ams_delta_nand_resources,
 };
 
+#define OMAP_GPIO_LABEL	"gpio-0-15"
+
+static struct gpiod_lookup_table ams_delta_nand_gpio_table = {
+	.table = {
+		GPIO_LOOKUP(OMAP_GPIO_LABEL, AMS_DELTA_GPIO_PIN_NAND_RB, "rdy",
+			    0),
+		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_NCE, "nce", 0),
+		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_NRE, "nre", 0),
+		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_NWP, "nwp", 0),
+		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_NWE, "nwe", 0),
+		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_ALE, "ale", 0),
+		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_CLE, "cle", 0),
+		{ },
+	},
+};
+
 static struct resource ams_delta_kp_resources[] = {
 	[0] = {
 		.start	= INT_KEYBOARD,
@@ -358,6 +395,14 @@ static struct platform_device ams_delta_lcd_device = {
 	.id	= -1,
 };
 
+static struct gpiod_lookup_table ams_delta_lcd_gpio_table = {
+	.table = {
+		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_LCD_VBLEN, "vblen", 0),
+		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_LCD_NDISP, "ndisp", 0),
+		{ },
+	},
+};
+
 static const struct gpio_led gpio_leds[] __initconst = {
 	{
 		.name		 = "camera",
@@ -449,11 +494,35 @@ static struct platform_device ams_delta_audio_device = {
 	.id     = -1,
 };
 
+static struct gpiod_lookup_table ams_delta_audio_gpio_table = {
+	.table = {
+		GPIO_LOOKUP(OMAP_GPIO_LABEL, AMS_DELTA_GPIO_PIN_HOOK_SWITCH,
+			    "hook_switch", 0),
+		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_MODEM_CODEC,
+			    "modem_codec", 0),
+		{ },
+	},
+};
+
 static struct platform_device cx20442_codec_device = {
 	.name   = "cx20442-codec",
 	.id     = -1,
 };
 
+static struct gpiod_lookup_table ams_delta_serio_gpio_table = {
+	.table = {
+		GPIO_LOOKUP(OMAP_GPIO_LABEL, AMS_DELTA_GPIO_PIN_KEYBRD_DATA,
+			    "data", 0),
+		GPIO_LOOKUP(OMAP_GPIO_LABEL, AMS_DELTA_GPIO_PIN_KEYBRD_CLK,
+			    "clock", 0),
+		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_KEYBRD_PWR,
+			    "power", 0),
+		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_KEYBRD_DATAOUT,
+			    "dataout", 0),
+		{ },
+	},
+};
+
 static struct platform_device *ams_delta_devices[] __initdata = {
 	&latch1_gpio_device,
 	&latch2_gpio_device,
@@ -468,6 +537,16 @@ static struct platform_device *late_devices[] __initdata = {
 	&cx20442_codec_device,
 };
 
+static struct gpiod_lookup_table *ams_delta_gpio_tables[] __initdata = {
+	&ams_delta_audio_gpio_table,
+	&ams_delta_serio_gpio_table,
+};
+
+static struct gpiod_lookup_table *late_gpio_tables[] __initdata = {
+	&ams_delta_lcd_gpio_table,
+	&ams_delta_nand_gpio_table,
+};
+
 static void __init ams_delta_init(void)
 {
 	/* mux pins for uarts */
@@ -500,6 +579,20 @@ static void __init ams_delta_init(void)
 	gpio_led_register_device(-1, &leds_pdata);
 	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
 
+	/*
+	 * As soon as devices have been registered, assign their dev_names
+	 * to respective GPIO lookup tables before they are added.
+	 */
+	ams_delta_audio_gpio_table.dev_id =
+			dev_name(&ams_delta_audio_device.dev);
+	/*
+	 * No device name is assigned to GPIO lookup table for serio device
+	 * as long as serio driver is not converted to platform device driver.
+	 */
+
+	gpiod_add_lookup_tables(ams_delta_gpio_tables,
+				ARRAY_SIZE(ams_delta_gpio_tables));
+
 	ams_delta_init_fiq();
 
 	omap_writew(omap_readw(ARM_RSTCT1) | 0x0004, ARM_RSTCT1);
@@ -570,6 +663,15 @@ static int __init late_init(void)
 
 	platform_add_devices(late_devices, ARRAY_SIZE(late_devices));
 
+	/*
+	 * As soon as devices have been registered, assign their dev_names
+	 * to respective GPIO lookup tables before they are added.
+	 */
+	ams_delta_lcd_gpio_table.dev_id = dev_name(&ams_delta_lcd_device.dev);
+	ams_delta_nand_gpio_table.dev_id = dev_name(&ams_delta_nand_device.dev);
+
+	gpiod_add_lookup_tables(late_gpio_tables, ARRAY_SIZE(late_gpio_tables));
+
 	err = platform_device_register(&modem_nreset_device);
 	if (err) {
 		pr_err("Couldn't register the modem regulator device\n");
-- 
2.16.1
