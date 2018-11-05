From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ARM: OMAP1: ams-delta: Provide GPIO lookup table for LED device
Date: Tue,  6 Nov 2018 00:23:49 +0100
Message-ID: <20181105232349.17351-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Linus Walleij <linus.walleij@linaro.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Global GPIO numbers no longer have to be passed to leds-gpio driver,
replace their assignment with a lookup table.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 95 ++++++++++-------------------------
 1 file changed, 26 insertions(+), 69 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index b8acc9912a58..19e0c071d675 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -371,15 +371,9 @@ static struct gpiod_lookup_table ams_delta_lcd_gpio_table = {
 	},
 };
 
-/*
- * Dynamically allocated GPIO numbers must be obtained fromm GPIO device
- * before they can be put in the gpio_led table.  Before that happens,
- * initialize the table with invalid GPIO numbers, not 0.
- */
 static struct gpio_led gpio_leds[] __initdata = {
 	[LATCH1_PIN_LED_CAMERA] = {
 		.name		 = "camera",
-		.gpio		 = -EINVAL,
 		.default_state	 = LEDS_GPIO_DEFSTATE_OFF,
 #ifdef CONFIG_LEDS_TRIGGERS
 		.default_trigger = "ams_delta_camera",
@@ -387,27 +381,22 @@ static struct gpio_led gpio_leds[] __initdata = {
 	},
 	[LATCH1_PIN_LED_ADVERT] = {
 		.name		 = "advert",
-		.gpio		 = -EINVAL,
 		.default_state	 = LEDS_GPIO_DEFSTATE_OFF,
 	},
 	[LATCH1_PIN_LED_MAIL] = {
 		.name		 = "email",
-		.gpio		 = -EINVAL,
 		.default_state	 = LEDS_GPIO_DEFSTATE_OFF,
 	},
 	[LATCH1_PIN_LED_HANDSFREE] = {
 		.name		 = "handsfree",
-		.gpio		 = -EINVAL,
 		.default_state	 = LEDS_GPIO_DEFSTATE_OFF,
 	},
 	[LATCH1_PIN_LED_VOICEMAIL] = {
 		.name		 = "voicemail",
-		.gpio		 = -EINVAL,
 		.default_state	 = LEDS_GPIO_DEFSTATE_OFF,
 	},
 	[LATCH1_PIN_LED_VOICE] = {
 		.name		 = "voice",
-		.gpio		 = -EINVAL,
 		.default_state	 = LEDS_GPIO_DEFSTATE_OFF,
 	},
 };
@@ -417,6 +406,24 @@ static const struct gpio_led_platform_data leds_pdata __initconst = {
 	.num_leds	= ARRAY_SIZE(gpio_leds),
 };
 
+static struct gpiod_lookup_table leds_gpio_table = {
+	.table = {
+		GPIO_LOOKUP_IDX(LATCH1_LABEL, LATCH1_PIN_LED_CAMERA, NULL,
+				LATCH1_PIN_LED_CAMERA, 0),
+		GPIO_LOOKUP_IDX(LATCH1_LABEL, LATCH1_PIN_LED_ADVERT, NULL,
+				LATCH1_PIN_LED_ADVERT, 0),
+		GPIO_LOOKUP_IDX(LATCH1_LABEL, LATCH1_PIN_LED_MAIL, NULL,
+				LATCH1_PIN_LED_MAIL, 0),
+		GPIO_LOOKUP_IDX(LATCH1_LABEL, LATCH1_PIN_LED_HANDSFREE, NULL,
+				LATCH1_PIN_LED_HANDSFREE, 0),
+		GPIO_LOOKUP_IDX(LATCH1_LABEL, LATCH1_PIN_LED_VOICEMAIL, NULL,
+				LATCH1_PIN_LED_VOICEMAIL, 0),
+		GPIO_LOOKUP_IDX(LATCH1_LABEL, LATCH1_PIN_LED_VOICE, NULL,
+				LATCH1_PIN_LED_VOICE, 0),
+		{ },
+	},
+};
+
 static struct i2c_board_info ams_delta_camera_board_info[] = {
 	{
 		I2C_BOARD_INFO("ov6650", 0x60),
@@ -677,6 +684,8 @@ static void __init ams_delta_latch2_init(void)
 
 static void __init ams_delta_init(void)
 {
+	struct platform_device *leds_pdev;
+
 	/* mux pins for uarts */
 	omap_cfg_reg(UART1_TX);
 	omap_cfg_reg(UART1_RTS);
@@ -740,6 +749,12 @@ static void __init ams_delta_init(void)
 	gpiod_add_lookup_tables(ams_delta_gpio_tables,
 				ARRAY_SIZE(ams_delta_gpio_tables));
 
+	leds_pdev = gpio_led_register_device(PLATFORM_DEVID_NONE, &leds_pdata);
+	if (!IS_ERR(leds_pdev)) {
+		leds_gpio_table.dev_id = dev_name(&leds_pdev->dev);
+		gpiod_add_lookup_table(&leds_gpio_table);
+	}
+
 	omap_writew(omap_readw(ARM_RSTCT1) | 0x0004, ARM_RSTCT1);
 
 	omapfb_set_lcd_config(&ams_delta_lcd_config);
@@ -793,64 +808,6 @@ static struct platform_device ams_delta_modem_device = {
 	},
 };
 
-/*
- * leds-gpio driver doesn't make use of GPIO lookup tables,
- * it has to be provided with GPIO numbers over platform data
- * if GPIO descriptor info can't be obtained from device tree.
- * We could either define GPIO lookup tables and use them on behalf
- * of the leds-gpio device, or we can use GPIO driver level methods
- * for identification of GPIO numbers as long as we don't support
- * device tree.  Let's do the latter.
- */
-static void __init ams_delta_led_init(struct gpio_chip *chip)
-{
-	struct gpio_desc *gpiod;
-	int i;
-
-	for (i = LATCH1_PIN_LED_CAMERA; i < LATCH1_PIN_DOCKIT1; i++) {
-		gpiod = gpiochip_request_own_desc(chip, i, NULL);
-		if (IS_ERR(gpiod)) {
-			pr_warn("%s: %s GPIO %d request failed (%ld)\n",
-				__func__, LATCH1_LABEL, i, PTR_ERR(gpiod));
-			continue;
-		}
-
-		/* Assign GPIO numbers to LED device. */
-		gpio_leds[i].gpio = desc_to_gpio(gpiod);
-
-		gpiochip_free_own_desc(gpiod);
-	}
-
-	gpio_led_register_device(PLATFORM_DEVID_NONE, &leds_pdata);
-}
-
-/*
- * The purpose of this function is to take care of assignment of GPIO numbers
- * to platform devices which depend on GPIO lines provided by Amstrad Delta
- * latch1 and/or latch2 GPIO devices but don't use GPIO lookup tables.
- * The function may be called as soon as latch1/latch2 GPIO devices are
- * initilized.  Since basic-mmio-gpio driver is not registered before
- * device_initcall, this may happen at erliest during device_initcall_sync.
- * Dependent devices shouldn't be registered before that, their
- * registration may be performed from within this function or later.
- */
-static int __init ams_delta_gpio_init(void)
-{
-	struct gpio_chip *chip;
-
-	if (!machine_is_ams_delta())
-		return -ENODEV;
-
-	chip = gpiochip_find(LATCH1_LABEL, gpiochip_match_by_label);
-	if (!chip)
-		pr_err("%s: latch1 GPIO chip not found\n", __func__);
-	else
-		ams_delta_led_init(chip);
-
-	return 0;
-}
-device_initcall_sync(ams_delta_gpio_init);
-
 static int __init modem_nreset_init(void)
 {
 	int err;
-- 
2.16.4
