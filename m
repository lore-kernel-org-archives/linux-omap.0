From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2 07/10] ARM: OMAP1: ams-delta FIQ: Keep serio input GPIOs requested
Date: Fri, 22 Jun 2018 00:41:25 +0200
Message-ID: <20180621224128.17623-7-jmkrzyszt@gmail.com>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180621224128.17623-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180621224128.17623-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "David S . Miller " <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

>From the very beginning, input GPIO pins of ams-delta serio port have
been used by FIQ handler, not serio driver.

Don't request those pins from the ams-delta-serio driver any longer,
instead keep them requested and initialized by the FIQ initialization
routine which already requests them and releases while identifying GPIO
IRQs.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Changelog:
v2: rebased on v4.18-rc1, no conflicts

 arch/arm/mach-omap1/ams-delta-fiq.c   | 42 ++++++++++++++++++++++++++++++-----
 drivers/input/serio/ams_delta_serio.c | 30 ++-----------------------
 2 files changed, 39 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index 1d54a6177f14..5a6c59ac9b5f 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -45,6 +45,11 @@ static struct irq_chip *irq_chip;
 static struct irq_data *irq_data[16];
 static unsigned int irq_counter[16];
 
+static const char *pin_name[16] __initconst = {
+	[AMS_DELTA_GPIO_PIN_KEYBRD_DATA]	= "keybrd_data",
+	[AMS_DELTA_GPIO_PIN_KEYBRD_CLK]		= "keybrd_clk",
+};
+
 static irqreturn_t deferred_fiq(int irq, void *dev_id)
 {
 	struct irq_data *d;
@@ -80,7 +85,7 @@ static irqreturn_t deferred_fiq(int irq, void *dev_id)
 
 void __init ams_delta_init_fiq(struct gpio_chip *chip)
 {
-	struct gpio_desc *gpiod;
+	struct gpio_desc *gpiod, *data = NULL, *clk = NULL;
 	void *fiqhandler_start;
 	unsigned int fiqhandler_length;
 	struct pt_regs FIQ_regs;
@@ -96,7 +101,7 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(irq_data); i++) {
-		gpiod = gpiochip_request_own_desc(chip, i, NULL);
+		gpiod = gpiochip_request_own_desc(chip, i, pin_name[i]);
 		if (IS_ERR(gpiod)) {
 			pr_err("%s: failed to get GPIO pin %d (%ld)\n",
 			       __func__, i, PTR_ERR(gpiod));
@@ -105,8 +110,27 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip)
 		/* Store irq_data location for IRQ handler use */
 		irq_data[i] = irq_get_irq_data(gpiod_to_irq(gpiod));
 
-		gpiochip_free_own_desc(gpiod);
+		/*
+		 * FIQ handler takes full control over serio data and clk GPIO
+		 * pins.  Initiaize them and keep requested so nobody can
+		 * interfere.  Fail if any of those two couldn't be requested.
+		 */
+		switch (i) {
+		case AMS_DELTA_GPIO_PIN_KEYBRD_DATA:
+			data = gpiod;
+			gpiod_direction_input(data);
+			break;
+		case AMS_DELTA_GPIO_PIN_KEYBRD_CLK:
+			clk = gpiod;
+			gpiod_direction_input(clk);
+			break;
+		default:
+			gpiochip_free_own_desc(gpiod);
+			break;
+		}
 	}
+	if (!data || !clk)
+		goto out_gpio;
 
 	fiqhandler_start = &qwerty_fiqin_start;
 	fiqhandler_length = &qwerty_fiqin_end - &qwerty_fiqin_start;
@@ -117,7 +141,7 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip)
 	if (retval) {
 		pr_err("ams_delta_init_fiq(): couldn't claim FIQ, ret=%d\n",
 				retval);
-		return;
+		goto out_gpio;
 	}
 
 	retval = request_irq(INT_DEFERRED_FIQ, deferred_fiq,
@@ -125,7 +149,7 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip)
 	if (retval < 0) {
 		pr_err("Failed to get deferred_fiq IRQ, ret=%d\n", retval);
 		release_fiq(&fh);
-		return;
+		goto out_gpio;
 	}
 	/*
 	 * Since no set_type() method is provided by OMAP irq chip,
@@ -175,4 +199,12 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip)
 	offset = IRQ_ILR0_REG_OFFSET + (INT_GPIO_BANK1 - NR_IRQS_LEGACY) * 0x4;
 	val = omap_readl(OMAP_IH1_BASE + offset) | 1;
 	omap_writel(val, OMAP_IH1_BASE + offset);
+
+	return;
+
+out_gpio:
+	if (data)
+		gpiochip_free_own_desc(data);
+	if (clk)
+		gpiochip_free_own_desc(clk);
 }
diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index b955c6a72e99..7952a29f9540 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -110,19 +110,6 @@ static void ams_delta_serio_close(struct serio *serio)
 	regulator_disable(priv->vcc);
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
-};
-
 static int ams_delta_serio_init(struct platform_device *pdev)
 {
 	struct ams_delta_serio *priv;
@@ -133,13 +120,6 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	err = gpio_request_array(ams_delta_gpios,
-				ARRAY_SIZE(ams_delta_gpios));
-	if (err) {
-		dev_err(&pdev->dev, "Couldn't request gpio pins\n");
-		goto serio;
-	}
-
 	priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
 	if (IS_ERR(priv->vcc)) {
 		err = PTR_ERR(priv->vcc);
@@ -157,7 +137,7 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 		 */
 		if (err == -ENODEV)
 			err = -EPROBE_DEFER;
-		goto gpio;
+		return err;
 	}
 
 	err = request_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK),
@@ -165,7 +145,7 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 			DRIVER_NAME, priv);
 	if (err < 0) {
 		dev_err(&pdev->dev, "IRQ request failed (%d)\n", err);
-		goto gpio;
+		return err;
 	}
 	/*
 	 * Since GPIO register handling for keyboard clock pin is performed
@@ -201,10 +181,6 @@ static int ams_delta_serio_init(struct platform_device *pdev)
 
 irq:
 	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), priv);
-gpio:
-	gpio_free_array(ams_delta_gpios,
-			ARRAY_SIZE(ams_delta_gpios));
-serio:
 	return err;
 }
 
@@ -214,8 +190,6 @@ static int ams_delta_serio_exit(struct platform_device *pdev)
 
 	serio_unregister_port(priv->serio);
 	free_irq(gpio_to_irq(AMS_DELTA_GPIO_PIN_KEYBRD_CLK), 0);
-	gpio_free_array(ams_delta_gpios,
-			ARRAY_SIZE(ams_delta_gpios));
 
 	return 0;
 }
-- 
2.16.4
