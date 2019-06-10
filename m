From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH-next 06/20] gpio: gpio-omap: move omap_gpio_request() and omap_gpio_free()
Date: Mon, 10 Jun 2019 20:10:49 +0300
Message-ID: <20190610171103.30903-7-grygorii.strashko@ti.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610171103.30903-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Move these two functions to live beside the rest of the gpio chip
implementation, rather than in the middle of the irq chip
implementation.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 64 ++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 04e3da55e39c..cc320d09d074 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -689,38 +689,6 @@ static int omap_gpio_wake_enable(struct irq_data *d, unsigned int enable)
 	return irq_set_irq_wake(bank->irq, enable);
 }
 
-static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
-{
-	struct gpio_bank *bank = gpiochip_get_data(chip);
-	unsigned long flags;
-
-	pm_runtime_get_sync(chip->parent);
-
-	raw_spin_lock_irqsave(&bank->lock, flags);
-	omap_enable_gpio_module(bank, offset);
-	bank->mod_usage |= BIT(offset);
-	raw_spin_unlock_irqrestore(&bank->lock, flags);
-
-	return 0;
-}
-
-static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
-{
-	struct gpio_bank *bank = gpiochip_get_data(chip);
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&bank->lock, flags);
-	bank->mod_usage &= ~(BIT(offset));
-	if (!LINE_USED(bank->irq_usage, offset)) {
-		omap_set_gpio_direction(bank, offset, 1);
-		omap_clear_gpio_debounce(bank, offset);
-	}
-	omap_disable_gpio_module(bank, offset);
-	raw_spin_unlock_irqrestore(&bank->lock, flags);
-
-	pm_runtime_put(chip->parent);
-}
-
 /*
  * We need to unmask the GPIO bank interrupt as soon as possible to
  * avoid missing GPIO interrupts for other lines in the bank.
@@ -951,6 +919,38 @@ static inline void omap_mpuio_init(struct gpio_bank *bank)
 
 /*---------------------------------------------------------------------*/
 
+static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
+{
+	struct gpio_bank *bank = gpiochip_get_data(chip);
+	unsigned long flags;
+
+	pm_runtime_get_sync(chip->parent);
+
+	raw_spin_lock_irqsave(&bank->lock, flags);
+	omap_enable_gpio_module(bank, offset);
+	bank->mod_usage |= BIT(offset);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
+
+	return 0;
+}
+
+static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
+{
+	struct gpio_bank *bank = gpiochip_get_data(chip);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&bank->lock, flags);
+	bank->mod_usage &= ~(BIT(offset));
+	if (!LINE_USED(bank->irq_usage, offset)) {
+		omap_set_gpio_direction(bank, offset, 1);
+		omap_clear_gpio_debounce(bank, offset);
+	}
+	omap_disable_gpio_module(bank, offset);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
+
+	pm_runtime_put(chip->parent);
+}
+
 static int omap_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank;
-- 
2.17.1
