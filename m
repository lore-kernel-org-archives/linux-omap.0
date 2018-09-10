From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] ARM: OMAP1: ams-delta: Don't request unused GPIOs
Date: Mon, 10 Sep 2018 21:50:08 +0200
Message-ID: <20180910195008.24127-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

GPIOs with no kernel drivers can still be used from user space, don't
request them from the board file.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/board-ams-delta.c | 40 +----------------------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index dd625ac3cd09..fee528dccc3e 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -250,39 +250,6 @@ static struct platform_device latch2_gpio_device = {
 #define LATCH2_PIN_HOOKFLASH1		14
 #define LATCH2_PIN_HOOKFLASH2		15
 
-static const struct gpio latch_gpios[] __initconst = {
-	{
-		.gpio	= LATCH1_GPIO_BASE + 6,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "dockit1",
-	},
-	{
-		.gpio	= LATCH1_GPIO_BASE + 7,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "dockit2",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_SCARD_RSTIN,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "scard_rstin",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_SCARD_CMDVCC,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "scard_cmdvcc",
-	},
-	{
-		.gpio	= AMS_DELTA_LATCH2_GPIO_BASE + 14,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "hookflash1",
-	},
-	{
-		.gpio	= AMS_DELTA_LATCH2_GPIO_BASE + 15,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "hookflash2",
-	},
-};
-
 static struct regulator_consumer_supply modem_nreset_consumers[] = {
 	REGULATOR_SUPPLY("RESET#", "serial8250.1"),
 	REGULATOR_SUPPLY("POR", "cx20442-codec"),
@@ -860,7 +827,6 @@ static void __init ams_delta_led_init(struct gpio_chip *chip)
 static int __init ams_delta_gpio_init(void)
 {
 	struct gpio_chip *chip;
-	int err;
 
 	if (!machine_is_ams_delta())
 		return -ENODEV;
@@ -871,11 +837,7 @@ static int __init ams_delta_gpio_init(void)
 	else
 		ams_delta_led_init(chip);
 
-	err = gpio_request_array(latch_gpios, ARRAY_SIZE(latch_gpios));
-	if (err)
-		pr_err("Couldn't take over latch1/latch2 GPIO pins\n");
-
-	return err;
+	return 0;
 }
 device_initcall_sync(ams_delta_gpio_init);
 
-- 
2.16.4
