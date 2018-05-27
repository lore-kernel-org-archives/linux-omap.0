From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 2/2] ARM: OMAP1: ams-delta: assign LED GPIO numbers from descriptors
Date: Sun, 27 May 2018 15:55:48 +0200
Message-ID: <20180527135548.7904-2-jmkrzyszt@gmail.com>
References: <20180527135548.7904-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180527135548.7904-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Assign a label to latch1 GPIO device the LEDs hang off, enumerate its
pins for the purpose of indexing gpio_led table, remove hardcoded GPIO
numbers from that table replacing them with invalid GPIO numbers and
remove initialization of incompletely described LED device from
machine_init.

As soon as the latch1 GPIO device is registered, use its label to find
respective GPIO chip, identify each LED's GPIO descriptor by its pin
number and assign its gobal GPIO number to the gpio_led table.  Once
completed, register the LED device.

Created and tested against linux-v4.17-rc3.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 116 ++++++++++++++++++++++++++++------
 1 file changed, 98 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index cdba8decc532..d4b26352ddde 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -179,7 +179,10 @@ static struct resource latch1_resources[] = {
 	},
 };
 
+#define LATCH1_LABEL	"latch1"
+
 static struct bgpio_pdata latch1_pdata = {
+	.label	= LATCH1_LABEL,
 	.base	= LATCH1_GPIO_BASE,
 	.ngpio	= LATCH1_NGPIO,
 };
@@ -194,6 +197,15 @@ static struct platform_device latch1_gpio_device = {
 	},
 };
 
+#define LATCH1_PIN_LED_CAMERA		0
+#define LATCH1_PIN_LED_ADVERT		1
+#define LATCH1_PIN_LED_MAIL		2
+#define LATCH1_PIN_LED_HANDSFREE	3
+#define LATCH1_PIN_LED_VOICEMAIL	4
+#define LATCH1_PIN_LED_VOICE		5
+#define LATCH1_PIN_DOCKIT1		6
+#define LATCH1_PIN_DOCKIT2		7
+
 static struct resource latch2_resources[] = {
 	[0] = {
 		.name	= "dat",
@@ -398,38 +410,43 @@ static struct gpiod_lookup_table ams_delta_lcd_gpio_table = {
 	},
 };
 
-static const struct gpio_led gpio_leds[] __initconst = {
-	{
+/*
+ * Dynamically allocated GPIO numbers must be obtained fromm GPIO device
+ * before they can be put in the gpio_led table.  Before that happens,
+ * initialize the table with invalid GPIO numbers, not 0.
+ */
+static struct gpio_led gpio_leds[] __initdata = {
+	[LATCH1_PIN_LED_CAMERA] = {
 		.name		 = "camera",
-		.gpio		 = LATCH1_GPIO_BASE + 0,
+		.gpio		 = -EINVAL,
 		.default_state	 = LEDS_GPIO_DEFSTATE_OFF,
 #ifdef CONFIG_LEDS_TRIGGERS
 		.default_trigger = "ams_delta_camera",
 #endif
 	},
-	{
+	[LATCH1_PIN_LED_ADVERT] = {
 		.name		 = "advert",
-		.gpio		 = LATCH1_GPIO_BASE + 1,
+		.gpio		 = -EINVAL,
 		.default_state	 = LEDS_GPIO_DEFSTATE_OFF,
 	},
-	{
+	[LATCH1_PIN_LED_MAIL] = {
 		.name		 = "email",
-		.gpio		 = LATCH1_GPIO_BASE + 2,
+		.gpio		 = -EINVAL,
 		.default_state	 = LEDS_GPIO_DEFSTATE_OFF,
 	},
-	{
+	[LATCH1_PIN_LED_HANDSFREE] = {
 		.name		 = "handsfree",
-		.gpio		 = LATCH1_GPIO_BASE + 3,
+		.gpio		 = -EINVAL,
 		.default_state	 = LEDS_GPIO_DEFSTATE_OFF,
 	},
-	{
+	[LATCH1_PIN_LED_VOICEMAIL] = {
 		.name		 = "voicemail",
-		.gpio		 = LATCH1_GPIO_BASE + 4,
+		.gpio		 = -EINVAL,
 		.default_state	 = LEDS_GPIO_DEFSTATE_OFF,
 	},
-	{
+	[LATCH1_PIN_LED_VOICE] = {
 		.name		 = "voice",
-		.gpio		 = LATCH1_GPIO_BASE + 5,
+		.gpio		 = -EINVAL,
 		.default_state	 = LEDS_GPIO_DEFSTATE_OFF,
 	},
 };
@@ -542,6 +559,22 @@ static struct gpiod_lookup_table *late_gpio_tables[] __initdata = {
 	&ams_delta_nand_gpio_table,
 };
 
+/*
+ * Some drivers may not use GPIO lookup tables but need to be provided
+ * with GPIO numbers.  The same applies to GPIO based IRQ lines - some
+ * drivers may even not use GPIO layer but expect just IRQ numbers.
+ * We could either define GPIO lookup tables then use them on behalf
+ * of those devices, or we can use GPIO driver level methods for
+ * identification of GPIO and IRQ numbers. For the purpose of the latter,
+ * defina a helper function which identifies GPIO chips by their labels.
+ */
+static int gpiochip_match_by_label(struct gpio_chip *chip, void *data)
+{
+	char *label = data;
+
+	return !strcmp(label, chip->label);
+}
+
 static void __init ams_delta_init(void)
 {
 	/* mux pins for uarts */
@@ -571,7 +604,6 @@ static void __init ams_delta_init(void)
 	led_trigger_register_simple("ams_delta_camera",
 			&ams_delta_camera_led_trigger);
 #endif
-	gpio_led_register_device(-1, &leds_pdata);
 	platform_add_devices(ams_delta_devices, ARRAY_SIZE(ams_delta_devices));
 
 	/*
@@ -643,16 +675,68 @@ static struct platform_device ams_delta_modem_device = {
 	},
 };
 
+/*
+ * leds-gpio driver doesn't make use of GPIO lookup tables,
+ * it has to be provided with GPIO numbers over platform data
+ * if GPIO descriptor info can't be obtained from device tree.
+ * We could either define GPIO lookup tables and use them on behalf
+ * of the leds-gpio device, or we can use GPIO driver level methods
+ * for identification of GPIO numbers as long as we don't support
+ * device tree.  Let's do the latter.
+ */
+static void __init ams_delta_led_init(struct gpio_chip *chip)
+{
+	struct gpio_desc *gpiod;
+	int i;
+
+	for (i = LATCH1_PIN_LED_CAMERA; i < LATCH1_PIN_DOCKIT1; i++) {
+		gpiod = gpiochip_request_own_desc(chip, i, NULL);
+		if (IS_ERR(gpiod)) {
+			pr_warn("%s: %s GPIO %d request failed (%ld)\n",
+				__func__, LATCH1_LABEL, i, PTR_ERR(gpiod));
+			continue;
+		}
+
+		/* Assign GPIO numbers to LED device. */
+		gpio_leds[i].gpio = desc_to_gpio(gpiod);
+
+		gpiochip_free_own_desc(gpiod);
+	}
+
+	gpio_led_register_device(PLATFORM_DEVID_NONE, &leds_pdata);
+}
+
+/*
+ * The purpose of this function is to take care of assignment of GPIO numbers
+ * to platform devices which depend on GPIO lines provided by Amstrad Delta
+ * latch1 and/or latch2 GPIO devices but don't use GPIO lookup tables.
+ * The function may be called as soon as latch1/latch2 GPIO devices are
+ * initilized.  Since basic-mmio-gpio driver is not registered before
+ * device_initcall, this may happen at erliest during device_initcall_sync.
+ * Dependent devices shouldn't be registered before that, their
+ * registration may be performed from within this function or later.
+ */
 static int __init ams_delta_gpio_init(void)
 {
+	struct gpio_chip *chip;
 	int err;
 
+	if (!machine_is_ams_delta())
+		return -ENODEV;
+
+	chip = gpiochip_find(LATCH1_LABEL, gpiochip_match_by_label);
+	if (!chip)
+		pr_err("%s: latch1 GPIO chip not found\n", __func__);
+	else
+		ams_delta_led_init(chip);
+
 	err = gpio_request_array(latch_gpios, ARRAY_SIZE(latch_gpios));
 	if (err)
 		pr_err("Couldn't take over latch1/latch2 GPIO pins\n");
 
 	return err;
 }
+device_initcall_sync(ams_delta_gpio_init);
 
 static void __init ams_delta_late_devices(void)
 {
@@ -712,10 +796,6 @@ static int __init late_init(void)
 {
 	int err;
 
-	err = ams_delta_gpio_init();
-	if (err)
-		return err;
-
 	ams_delta_late_devices();
 
 	err = modem_nreset_init();
-- 
2.16.1
