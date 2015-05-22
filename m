From: Grygorii Strashko <grygorii.strashko@linaro.org>
Subject: [RFC/RFT PATCH v2 7/7] gpio: omap: ensure that runtime pm will disable unused gpio banks
Date: Fri, 22 May 2015 17:35:54 +0300
Message-ID: <1432305354-5968-8-git-send-email-grygorii.strashko@linaro.org>
References: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, tony@atomide.com
Cc: Javier Martinez Canillas <javier@dowhile0.org>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>
List-Id: linux-omap@vger.kernel.org

Now there are some points related to Runtime PM usage:
1) bank state doesn't need to be checked in places where
Rintime PM is used, bacause Runtime PM maintains its
own usage counter:
      if (!BANK_USED(bank))
               pm_runtime_get_sync(bank->dev);
so, it's safe to drop such checks.

2) Such implementation is racy, because check !BANK_USED(bank)
   is not protected, like:
 CPU0				CPU1
 gpio_request(bankX.A)
 ...
 gpio_free(bankX.A)		gpio_request(bankX.Y)

 and bankX can be unpowered in the middle of processing
 gpio_request(bankX.Y)

3) There is a call of pm_runtime_get_sync() in omap_gpio_irq_type(),
but no corresponding put. As result, GPIO devices could be
powered on forever if at least one GPIO was used as IRQ.
Hence, allow powering off GPIO banks by adding missed
pm_runtime_put(bank->dev) at the end of omap_gpio_irq_type().

As, part of this change update omap2_gpio_xxxx_idle() functions
to use pm_runtime_force_suspend()/pm_runtime_force_resume().

Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
Changes in v2:
 - omap2_gpio_xxxx_idle() functions switched to use 
   pm_runtime_force_suspend()/pm_runtime_force_resume() API.

v1:
    http://marc.info/?l=linux-gpio&m=142567003515626&w=2

 drivers/gpio/gpio-omap.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index f02b3fa..e26dc40 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -486,8 +486,7 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 		(type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
 		return -EINVAL;
 
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->dev);
+	pm_runtime_get_sync(bank->dev);
 
 	spin_lock_irqsave(&bank->lock, flags);
 	retval = omap_set_gpio_triggering(bank, offset, type);
@@ -500,11 +499,8 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
 		__irq_set_handler_locked(d->irq, handle_edge_irq);
 
-	return 0;
-
 error:
-	if (!BANK_USED(bank))
-		pm_runtime_put(bank->dev);
+	pm_runtime_put(bank->dev);
 	return retval;
 }
 
@@ -649,8 +645,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	 * If this is the first gpio_request for the bank,
 	 * enable the bank module.
 	 */
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->dev);
+	pm_runtime_get_sync(bank->dev);
 
 	spin_lock_irqsave(&bank->lock, flags);
 	omap_enable_gpio_module(bank, offset);
@@ -678,8 +673,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 	 * If this is the last gpio to be freed in the bank,
 	 * disable the bank module.
 	 */
-	if (!BANK_USED(bank))
-		pm_runtime_put(bank->dev);
+	pm_runtime_put(bank->dev);
 }
 
 /*
@@ -771,8 +765,7 @@ static unsigned int omap_gpio_irq_startup(struct irq_data *d)
 	unsigned long flags;
 	unsigned offset = d->hwirq;
 
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->dev);
+	pm_runtime_get_sync(bank->dev);
 
 	spin_lock_irqsave(&bank->lock, flags);
 
@@ -789,8 +782,7 @@ static unsigned int omap_gpio_irq_startup(struct irq_data *d)
 	return 0;
 err:
 	spin_unlock_irqrestore(&bank->lock, flags);
-	if (!BANK_USED(bank))
-		pm_runtime_put(bank->dev);
+	pm_runtime_put(bank->dev);
 	return -EINVAL;
 }
 
@@ -814,8 +806,7 @@ static void omap_gpio_irq_shutdown(struct irq_data *d)
 	 * If this is the last IRQ to be freed in the bank,
 	 * disable the bank module.
 	 */
-	if (!BANK_USED(bank))
-		pm_runtime_put(bank->dev);
+	pm_runtime_put(bank->dev);
 }
 
 static void omap_gpio_ack_irq(struct irq_data *d)
@@ -1419,12 +1410,12 @@ void omap2_gpio_prepare_for_idle(int pwr_mode)
 	struct gpio_bank *bank;
 
 	list_for_each_entry(bank, &omap_gpio_list, node) {
-		if (!BANK_USED(bank) || !bank->loses_context)
+		if (!bank->loses_context)
 			continue;
 
 		bank->power_mode = pwr_mode;
 
-		pm_runtime_put_sync_suspend(bank->dev);
+		pm_runtime_force_suspend(bank->dev);
 	}
 }
 
@@ -1433,10 +1424,10 @@ void omap2_gpio_resume_after_idle(void)
 	struct gpio_bank *bank;
 
 	list_for_each_entry(bank, &omap_gpio_list, node) {
-		if (!BANK_USED(bank) || !bank->loses_context)
+		if (!bank->loses_context)
 			continue;
 
-		pm_runtime_get_sync(bank->dev);
+		pm_runtime_force_resume(bank->dev);
 	}
 }
 
-- 
1.9.1

