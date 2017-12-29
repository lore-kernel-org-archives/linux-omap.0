From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] gpio: omap: Give unique labels to each GPIO bank/chip
Date: Fri, 29 Dec 2017 13:28:12 +0100
Message-ID: <20171229122812.29743-1-linus.walleij@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

As we need to add GPIO lookup tables to the OMAP platforms, we
need to reference each GPIO chip with a unique label. Use the GPIO
base to name each chip, "gpio-0-31", "gpio-32-63" etc. Also fix
a small error on the error path of the probe() where the chip
would not be free()ed proberly under all circumstances.

Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-omap.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index e136d666f1e5..14fc3fb6f96e 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1059,6 +1059,7 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
 static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 {
 	static int gpio;
+	const char *label;
 	int irq_base = 0;
 	int ret;
 
@@ -1080,7 +1081,11 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 			bank->chip.parent = &omap_mpuio_device.dev;
 		bank->chip.base = OMAP_MPUIO(0);
 	} else {
-		bank->chip.label = "gpio";
+		label = devm_kasprintf(bank->chip.parent, GFP_KERNEL, "gpio-%d-%d",
+				       gpio, gpio + bank->width - 1);
+		if (!label)
+			return -ENOMEM;
+		bank->chip.label = label;
 		bank->chip.base = gpio;
 	}
 	bank->chip.ngpio = bank->width;
@@ -1104,7 +1109,8 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 					-1, 0, bank->width, 0);
 	if (irq_base < 0) {
 		dev_err(bank->chip.parent, "Couldn't allocate IRQ numbers\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_err_chip;
 	}
 #endif
 
@@ -1123,7 +1129,8 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 		dev_err(bank->chip.parent,
 			"Couldn't add irqchip to gpiochip %d\n", ret);
 		gpiochip_remove(&bank->chip);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto out_err_chip;
 	}
 
 	gpiochip_set_chained_irqchip(&bank->chip, irqc, bank->irq, NULL);
@@ -1132,8 +1139,12 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 			       omap_gpio_irq_handler,
 			       0, dev_name(bank->chip.parent), bank);
 	if (ret)
-		gpiochip_remove(&bank->chip);
+		goto out_err_chip;
+
+	return ret;
 
+out_err_chip:
+	gpiochip_remove(&bank->chip);
 	return ret;
 }
 
-- 
2.14.3

