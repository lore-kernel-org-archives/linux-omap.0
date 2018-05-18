From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 2/6] Input: ams_delta_serio: use GPIO lookup table
Date: Fri, 18 May 2018 23:09:50 +0200
Message-ID: <20180518210954.29044-2-jmkrzyszt@gmail.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180518210954.29044-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mark Brown <broonie@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Richard Weinberger <richard@nod.at>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Now as the Amstrad Delta board provides GPIO lookup tables, switch from
GPIO numbers to GPIO descriptors and use the table to locate required
GPIO pins.

Declare static variables for storing GPIO descriptors and replace
gpio_ functions with their gpiod_ equivalents.

Pin naming used by the driver should be followed while respective GPIO
lookup table is initialized by a board init code.

Created and tested against linux-4.17-rc3, on top of patch 1/6 "ARM:
OMAP1: ams-delta: add GPIO lookup tables"

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/input/serio/ams_delta_serio.c | 98 +++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 45 deletions(-)

diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index 3df501c3421b..dd1f8f118c08 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -20,14 +20,13 @@
  * However, when used with the E3 mailboard that producecs non-standard
  * scancodes, a custom key table must be prepared and loaded from userspace.
  */
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/irq.h>
 #include <linux/serio.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 
 #include <asm/mach-types.h>
-#include <mach/board-ams-delta.h>
 
 #include <mach/ams-delta-fiq.h>
 
@@ -36,6 +35,10 @@ MODULE_DESCRIPTION("AMS Delta (E3) keyboard port driver");
 MODULE_LICENSE("GPL");
 
 static struct serio *ams_delta_serio;
+static struct gpio_desc *gpiod_data;
+static struct gpio_desc *gpiod_clock;
+static struct gpio_desc *gpiod_power;
+static struct gpio_desc *gpiod_dataout;
 
 static int check_data(int data)
 {
@@ -92,7 +95,7 @@ static irqreturn_t ams_delta_serio_interrupt(int irq, void *dev_id)
 static int ams_delta_serio_open(struct serio *serio)
 {
 	/* enable keyboard */
-	gpio_set_value(AMS_DELTA_GPIO_PIN_KEYBRD_PWR, 1);
+	gpiod_set_value(gpiod_power, 1);
 
 	return 0;
 }
@@ -100,32 +103,9 @@ static int ams_delta_serio_open(struct serio *serio)
 static void ams_delta_serio_close(struct serio *serio)
 {
 	/* disable keyboard */
-	gpio_set_value(AMS_DELTA_GPIO_PIN_KEYBRD_PWR, 0);
+	gpiod_set_value(gpiod_power, 0);
 }
 
-static const struct gpio ams_delta_gpios[] __initconst_or_module = {
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_DATA,
-		.flags	= GPIOF_DIR_IN,
-		.label	= "serio-data",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_CLK,
-		.flags	= GPIOF_DIR_IN,
-		.label	= "serio-clock",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_PWR,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "serio-power",
-	},
-	{
-		.gpio	= AMS_DELTA_GPIO_PIN_KEYBRD_DATAOUT,
-		.flags	= GPIOF_OUT_INIT_LOW,
-		.label	= "serio-dataout",
-	},
-};
-
 static int __init ams_delta_serio_init(void)
 {
 	int err;
@@ -145,36 +125,62 @@ static int __init ams_delta_serio_init(void)
 	strlcpy(ams_delta_serio->phys, "GPIO/serio0",
 			sizeof(ams_delta_serio->phys));
 
-	err = gpio_request_array(ams_delta_gpios,
-				ARRAY_SIZE(ams_delta_gpios));
-	if (err) {
-		pr_err("ams_delta_serio: Couldn't request gpio pins\n");
+	gpiod_data = gpiod_get(NULL, "data", GPIOD_IN);
+	if (IS_ERR(gpiod_data)) {
+		err = PTR_ERR(gpiod_data);
+		pr_err("%s: 'data' GPIO request failed (%d)\n", __func__,
+		       err);
 		goto serio;
 	}
+	gpiod_clock = gpiod_get(NULL, "clock", GPIOD_IN);
+	if (IS_ERR(gpiod_clock)) {
+		err = PTR_ERR(gpiod_clock);
+		pr_err("%s: 'clock' GPIO request failed (%d)\n", __func__,
+		       err);
+		goto gpio_data;
+	}
+	gpiod_power = gpiod_get(NULL, "power", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_power)) {
+		err = PTR_ERR(gpiod_power);
+		pr_err("%s: 'power' GPIO request failed (%d)\n", __func__,
+		       err);
+		goto gpio_clock;
+	}
+	gpiod_dataout = gpiod_get(NULL, "dataout", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_dataout)) {
+		err = PTR_ERR(gpiod_dataout);
+		pr_err("%s: 'dataout' GPIO request failed (%d)\n",
+		       __func__, err);
+		goto gpio_power;
+	}
 
-	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
-			ams_delta_serio_interrupt, IRQ_TYPE_EDGE_RISING,
-			"ams-delta-serio", 0);
+	err = request_irq(gpiod_to_irq(gpiod_clock),
+			  ams_delta_serio_interrupt, IRQ_TYPE_EDGE_RISING,
+			  "ams-delta-serio", 0);
 	if (err < 0) {
-		pr_err("ams_delta_serio: couldn't request gpio interrupt %d\n",
-				gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK));
-		goto gpio;
+		pr_err("%s: 'clock' GPIO interrupt request failed (%d)\n",
+		       __func__, err);
+		goto gpio_dataout;
 	}
 	/*
 	 * Since GPIO register handling for keyboard clock pin is performed
 	 * at FIQ level, switch back from edge to simple interrupt handler
 	 * to avoid bad interaction.
 	 */
-	irq_set_handler(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
-			handle_simple_irq);
+	irq_set_handler(gpiod_to_irq(gpiod_clock), handle_simple_irq);
 
 	serio_register_port(ams_delta_serio);
 	dev_info(&ams_delta_serio->dev, "%s\n", ams_delta_serio->name);
 
 	return 0;
-gpio:
-	gpio_free_array(ams_delta_gpios,
-			ARRAY_SIZE(ams_delta_gpios));
+gpio_dataout:
+	gpiod_put(gpiod_dataout);
+gpio_power:
+	gpiod_put(gpiod_power);
+gpio_clock:
+	gpiod_put(gpiod_clock);
+gpio_data:
+	gpiod_put(gpiod_data);
 serio:
 	kfree(ams_delta_serio);
 	return err;
@@ -184,8 +190,10 @@ module_init(ams_delta_serio_init);
 static void __exit ams_delta_serio_exit(void)
 {
 	serio_unregister_port(ams_delta_serio);
-	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
-	gpio_free_array(ams_delta_gpios,
-			ARRAY_SIZE(ams_delta_gpios));
+	free_irq(gpiod_to_irq(gpiod_clock), 0);
+	gpiod_put(gpiod_dataout);
+	gpiod_put(gpiod_power);
+	gpiod_put(gpiod_clock);
+	gpiod_put(gpiod_data);
 }
 module_exit(ams_delta_serio_exit);
-- 
2.16.1
