From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/1] gpio/omap: use gpiolib API to mark a GPIO used as an IRQ
Date: Wed, 16 Oct 2013 02:47:30 +0200
Message-ID: <1381884450-2358-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Lars Poeschel <larsi@wh2.tu-dresden.de>, Enric Balletbo i Serra <eballetbo@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

The OMAP GPIO driver keeps track about GPIO pins that are
used as IRQ lines for two reasons:

1) To prevent GPIO banks to be disabled while one of their
   GPIO pins are only used as an interrupt line.

2) To not allow another caller to set the GPIO pin as output.

Now gpiolib has an API to mark GPIO pins as used as IRQ lines
so the GPIO core only allows to set as output GPIO pins not
tied to an IRQ. So there is no need to have custom code for 2).

The IRQ usage still has to be maintained locally for 1) though.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/gpio/gpio-omap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 89675f8..f319c9f 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -514,6 +514,14 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 		return -EINVAL;
 	}
 
+	retval = gpio_lock_as_irq(&bank->chip, offset);
+	if (retval) {
+		dev_err(bank->dev, "unable to lock offset %d for IRQ\n",
+			offset);
+		spin_unlock_irqrestore(&bank->lock, flags);
+		return retval;
+	}
+
 	bank->irq_usage |= 1 << GPIO_INDEX(bank, gpio);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
@@ -797,6 +805,7 @@ static void gpio_irq_shutdown(struct irq_data *d)
 	unsigned offset = GPIO_INDEX(bank, gpio);
 
 	spin_lock_irqsave(&bank->lock, flags);
+	gpio_unlock_as_irq(&bank->chip, offset);
 	bank->irq_usage &= ~(1 << offset);
 	_disable_gpio_module(bank, offset);
 	_reset_gpio(bank, gpio);
@@ -957,22 +966,13 @@ static int gpio_output(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct gpio_bank *bank;
 	unsigned long flags;
-	int retval = 0;
 
 	bank = container_of(chip, struct gpio_bank, chip);
 	spin_lock_irqsave(&bank->lock, flags);
-
-	if (LINE_USED(bank->irq_usage, offset)) {
-			retval = -EINVAL;
-			goto exit;
-	}
-
 	bank->set_dataout(bank, offset, value);
 	_set_gpio_direction(bank, offset, 0);
-
-exit:
 	spin_unlock_irqrestore(&bank->lock, flags);
-	return retval;
+	return 0;
 }
 
 static int gpio_debounce(struct gpio_chip *chip, unsigned offset,
-- 
1.8.4.rc3

