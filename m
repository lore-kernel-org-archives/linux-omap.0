From: <grygorii.strashko@linaro.org>
Subject: [PATCH 5/8] gpio: omap: convert gpio irq functions to use GPIO offset
Date: Thu, 19 Mar 2015 19:25:41 +0200
Message-ID: <1426785944-17255-6-git-send-email-grygorii.strashko@linaro.org>
References: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@linaro.org>

Convert GPIO IRQ functions to use GPIO offset instead of system
GPIO numbers. This allows to drop unneeded conversations between
system GPIO <-> GPIO offset which are done in many places and
many times.
It is safe to do now because:
- gpiolib always passes GPIO offset to GPIO controller
- OMAP GPIO driver converted to use IRQ domain, so
  struct irq_data->hwirq contains GPIO offset

This is preparation step before removing:
 #define GPIO_INDEX(bank, gpio)
 #define GPIO_BIT(bank, gpio)
 int omap_irq_to_gpio()

Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 drivers/gpio/gpio-omap.c | 64 +++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index ff5d54d..b39faa8 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -549,9 +549,10 @@ static void omap_clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	readl_relaxed(reg);
 }
 
-static inline void omap_clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
+static inline void omap_clear_gpio_irqstatus(struct gpio_bank *bank,
+					     unsigned offset)
 {
-	omap_clear_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
+	omap_clear_gpio_irqbank(bank, BIT(offset));
 }
 
 static u32 omap_get_gpio_irqbank_mask(struct gpio_bank *bank)
@@ -612,13 +613,13 @@ static void omap_disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	writel_relaxed(l, reg);
 }
 
-static inline void omap_set_gpio_irqenable(struct gpio_bank *bank, int gpio,
-					   int enable)
+static inline void omap_set_gpio_irqenable(struct gpio_bank *bank,
+					   unsigned offset, int enable)
 {
 	if (enable)
-		omap_enable_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
+		omap_enable_gpio_irqbank(bank, BIT(offset));
 	else
-		omap_disable_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
+		omap_disable_gpio_irqbank(bank, BIT(offset));
 }
 
 /*
@@ -629,14 +630,16 @@ static inline void omap_set_gpio_irqenable(struct gpio_bank *bank, int gpio,
  * enabled. When system is suspended, only selected GPIO interrupts need
  * to have wake-up enabled.
  */
-static int omap_set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
+static int omap_set_gpio_wakeup(struct gpio_bank *bank, unsigned offset,
+				int enable)
 {
-	u32 gpio_bit = GPIO_BIT(bank, gpio);
+	u32 gpio_bit = BIT(offset);
 	unsigned long flags;
 
 	if (bank->non_wakeup_gpios & gpio_bit) {
 		dev_err(bank->dev,
-			"Unable to modify wakeup on non-wakeup GPIO%d\n", gpio);
+			"Unable to modify wakeup on non-wakeup GPIO%d\n",
+			offset);
 		return -EINVAL;
 	}
 
@@ -652,22 +655,22 @@ static int omap_set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 	return 0;
 }
 
-static void omap_reset_gpio(struct gpio_bank *bank, int gpio)
+static void omap_reset_gpio(struct gpio_bank *bank, unsigned offset)
 {
-	omap_set_gpio_direction(bank, GPIO_INDEX(bank, gpio), 1);
-	omap_set_gpio_irqenable(bank, gpio, 0);
-	omap_clear_gpio_irqstatus(bank, gpio);
-	omap_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
-	omap_clear_gpio_debounce(bank, GPIO_INDEX(bank, gpio));
+	omap_set_gpio_direction(bank, offset, 1);
+	omap_set_gpio_irqenable(bank, offset, 0);
+	omap_clear_gpio_irqstatus(bank, offset);
+	omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
+	omap_clear_gpio_debounce(bank, offset);
 }
 
 /* Use disable_irq_wake() and enable_irq_wake() functions from drivers */
 static int omap_gpio_wake_enable(struct irq_data *d, unsigned int enable)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
-	unsigned int gpio = omap_irq_to_gpio(bank, d->hwirq);
+	unsigned offset = d->hwirq;
 
-	return omap_set_gpio_wakeup(bank, gpio, enable);
+	return omap_set_gpio_wakeup(bank, offset, enable);
 }
 
 static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
@@ -705,7 +708,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 	spin_lock_irqsave(&bank->lock, flags);
 	bank->mod_usage &= ~(BIT(offset));
 	omap_disable_gpio_module(bank, offset);
-	omap_reset_gpio(bank, bank->chip.base + offset);
+	omap_reset_gpio(bank, offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	/*
@@ -819,14 +822,13 @@ static unsigned int omap_gpio_irq_startup(struct irq_data *d)
 static void omap_gpio_irq_shutdown(struct irq_data *d)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
-	unsigned int gpio = omap_irq_to_gpio(bank, d->hwirq);
 	unsigned long flags;
-	unsigned offset = GPIO_INDEX(bank, gpio);
+	unsigned offset = d->hwirq;
 
 	spin_lock_irqsave(&bank->lock, flags);
 	bank->irq_usage &= ~(BIT(offset));
 	omap_disable_gpio_module(bank, offset);
-	omap_reset_gpio(bank, gpio);
+	omap_reset_gpio(bank, offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	/*
@@ -840,43 +842,43 @@ static void omap_gpio_irq_shutdown(struct irq_data *d)
 static void omap_gpio_ack_irq(struct irq_data *d)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
-	unsigned int gpio = omap_irq_to_gpio(bank, d->hwirq);
+	unsigned offset = d->hwirq;
 
-	omap_clear_gpio_irqstatus(bank, gpio);
+	omap_clear_gpio_irqstatus(bank, offset);
 }
 
 static void omap_gpio_mask_irq(struct irq_data *d)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
-	unsigned int gpio = omap_irq_to_gpio(bank, d->hwirq);
+	unsigned offset = d->hwirq;
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
-	omap_set_gpio_irqenable(bank, gpio, 0);
-	omap_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
+	omap_set_gpio_irqenable(bank, offset, 0);
+	omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
 static void omap_gpio_unmask_irq(struct irq_data *d)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
-	unsigned int gpio = omap_irq_to_gpio(bank, d->hwirq);
+	unsigned offset = d->hwirq;
 	unsigned int irq_mask = GPIO_BIT(bank, gpio);
 	u32 trigger = irqd_get_trigger_type(d);
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
 	if (trigger)
-		omap_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), trigger);
+		omap_set_gpio_triggering(bank, offset, trigger);
 
 	/* For level-triggered GPIOs, the clearing must be done after
 	 * the HW source is cleared, thus after the handler has run */
 	if (bank->level_mask & irq_mask) {
-		omap_set_gpio_irqenable(bank, gpio, 0);
-		omap_clear_gpio_irqstatus(bank, gpio);
+		omap_set_gpio_irqenable(bank, offset, 0);
+		omap_clear_gpio_irqstatus(bank, offset);
 	}
 
-	omap_set_gpio_irqenable(bank, gpio, 1);
+	omap_set_gpio_irqenable(bank, offset, 1);
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
-- 
1.9.1
