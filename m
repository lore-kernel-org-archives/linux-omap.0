From: <grygorii.strashko@linaro.org>
Subject: [RFC/RFT PATCH 2/2] gpio: omap: ensure that runtime pm will disable unused gpio banks
Date: Fri,  6 Mar 2015 21:26:57 +0200
Message-ID: <1425670017-19598-2-git-send-email-grygorii.strashko@linaro.org>
References: <1425670017-19598-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1425670017-19598-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, ssantosh@kernel.org, Javier Martinez Canillas <javier@dowhile0.org>, tony@atomide.com
Cc: Alexandre Courbot <gnurou@gmail.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@linaro.org>

Now there are two points related to Runtime PM usage:
1) bank state doesn't need to be checked in places where
Rintime PM is used, bacause Runtime PM maintains its
own usage counter:
      if (!BANK_USED(bank))
               pm_runtime_get_sync(bank->dev);
so, it's safe to drop such checks.

2) There is a call of pm_runtime_get_sync() in omap_gpio_irq_type(),
but no corresponding put. As result, GPIO devices could be
powered on forever if at least one GPIO was used as IRQ.
Hence, allow powering off GPIO banks by adding missed
pm_runtime_put(bank->dev) at the end of omap_gpio_irq_type().

Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 drivers/gpio/gpio-omap.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 2b2fc4b..b1176c5 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -497,8 +497,7 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 	unsigned long flags;
 	unsigned offset;
 
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->dev);
+	pm_runtime_get_sync(bank->dev);
 
 #ifdef CONFIG_ARCH_OMAP1
 	if (d->irq > IH_MPUIO_BASE)
@@ -530,6 +529,8 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
 		__irq_set_handler_locked(d->irq, handle_edge_irq);
 
+	pm_runtime_put(bank->dev);
+
 	return retval;
 }
 
@@ -680,8 +681,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	 * If this is the first gpio_request for the bank,
 	 * enable the bank module.
 	 */
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->dev);
+	pm_runtime_get_sync(bank->dev);
 
 	spin_lock_irqsave(&bank->lock, flags);
 	/* Set trigger to none. You need to enable the desired trigger with
@@ -713,8 +713,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 	 * If this is the last gpio to be freed in the bank,
 	 * disable the bank module.
 	 */
-	if (!BANK_USED(bank))
-		pm_runtime_put(bank->dev);
+	pm_runtime_put(bank->dev);
 }
 
 /*
@@ -807,8 +806,7 @@ static unsigned int omap_gpio_irq_startup(struct irq_data *d)
 	unsigned long flags;
 	unsigned offset = GPIO_INDEX(bank, gpio);
 
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->dev);
+	pm_runtime_get_sync(bank->dev);
 
 	spin_lock_irqsave(&bank->lock, flags);
 	omap_gpio_init_irq(bank, gpio, offset);
@@ -835,8 +833,7 @@ static void omap_gpio_irq_shutdown(struct irq_data *d)
 	 * If this is the last IRQ to be freed in the bank,
 	 * disable the bank module.
 	 */
-	if (!BANK_USED(bank))
-		pm_runtime_put(bank->dev);
+	pm_runtime_put(bank->dev);
 }
 
 static void omap_gpio_ack_irq(struct irq_data *d)
-- 
1.9.1

