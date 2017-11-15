From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] gpio: omap: initialize gpioirq chip as part of gpiochip_add_data
Date: Wed, 15 Nov 2017 12:36:33 -0600
Message-ID: <20171115183633.12382-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Hence, series from Thierry Reding [1] merged - the OMAP GPIO driver can be
switched to reuse new feature and just fill new struct gpio_irq_chip before
calling gpiochip_add_data() instead of using few separate gpioirq chip
APIs. gpiochip_add_data() will do the job and create and initialize gpioirq
chip

[1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1531592.html

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
Linus,

This for next, I assume.

 drivers/gpio/gpio-omap.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index ce27d6a..a6fe851 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1054,6 +1054,7 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
 
 static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 {
+	struct gpio_irq_chip *irq;
 	static int gpio;
 	int irq_base = 0;
 	int ret;
@@ -1081,16 +1082,6 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 	}
 	bank->chip.ngpio = bank->width;
 
-	ret = gpiochip_add_data(&bank->chip, bank);
-	if (ret) {
-		dev_err(bank->chip.parent,
-			"Could not register gpio chip %d\n", ret);
-		return ret;
-	}
-
-	if (!bank->is_mpuio)
-		gpio += bank->width;
-
 #ifdef CONFIG_ARCH_OMAP1
 	/*
 	 * REVISIT: Once we have OMAP1 supporting SPARSE_IRQ, we can drop
@@ -1111,25 +1102,30 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 			irqc->irq_set_wake = NULL;
 	}
 
-	ret = gpiochip_irqchip_add(&bank->chip, irqc,
-				   irq_base, handle_bad_irq,
-				   IRQ_TYPE_NONE);
+	irq = &bank->chip.irq;
+	irq->chip = irqc;
+	irq->handler = handle_bad_irq;
+	irq->default_type = IRQ_TYPE_NONE;
+	irq->num_parents = 1;
+	irq->parents = &bank->irq;
+	irq->first = irq_base;
 
+	ret = gpiochip_add_data(&bank->chip, bank);
 	if (ret) {
 		dev_err(bank->chip.parent,
-			"Couldn't add irqchip to gpiochip %d\n", ret);
-		gpiochip_remove(&bank->chip);
-		return -ENODEV;
+			"Could not register gpio chip %d\n", ret);
+		return ret;
 	}
 
-	gpiochip_set_chained_irqchip(&bank->chip, irqc, bank->irq, NULL);
-
 	ret = devm_request_irq(bank->chip.parent, bank->irq,
 			       omap_gpio_irq_handler,
 			       0, dev_name(bank->chip.parent), bank);
 	if (ret)
 		gpiochip_remove(&bank->chip);
 
+	if (!bank->is_mpuio)
+		gpio += bank->width;
+
 	return ret;
 }
 
-- 
2.10.5

