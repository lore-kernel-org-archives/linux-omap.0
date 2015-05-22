From: Grygorii Strashko <grygorii.strashko@linaro.org>
Subject: [PATCH 2/7] gpio: omap: fix error handling in omap_gpio_irq_type
Date: Fri, 22 May 2015 17:35:49 +0300
Message-ID: <1432305354-5968-3-git-send-email-grygorii.strashko@linaro.org>
References: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, tony@atomide.com
Cc: Javier Martinez Canillas <javier@dowhile0.org>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>
List-Id: linux-omap@vger.kernel.org

The GPIO bank will be kept powered in case if input parameters
are invalid or error occurred in omap_gpio_irq_type.

Hence, fix it by ensuring that GPIO bank will be unpowered
in case of errors and add additional check of value returned
from omap_set_gpio_triggering().

Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 drivers/gpio/gpio-omap.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index bb60cbc..f6cc638 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -488,9 +488,6 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 	unsigned long flags;
 	unsigned offset = d->hwirq;
 
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->dev);
-
 	if (type & ~IRQ_TYPE_SENSE_MASK)
 		return -EINVAL;
 
@@ -498,12 +495,18 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 		(type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
 		return -EINVAL;
 
+	if (!BANK_USED(bank))
+		pm_runtime_get_sync(bank->dev);
+
 	spin_lock_irqsave(&bank->lock, flags);
 	retval = omap_set_gpio_triggering(bank, offset, type);
+	if (retval)
+		goto error;
 	omap_gpio_init_irq(bank, offset);
 	if (!omap_gpio_is_input(bank, offset)) {
 		spin_unlock_irqrestore(&bank->lock, flags);
-		return -EINVAL;
+		retval = -EINVAL;
+		goto error;
 	}
 	spin_unlock_irqrestore(&bank->lock, flags);
 
@@ -512,6 +515,11 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
 		__irq_set_handler_locked(d->irq, handle_edge_irq);
 
+	return 0;
+
+error:
+	if (!BANK_USED(bank))
+		pm_runtime_put(bank->dev);
 	return retval;
 }
 
-- 
1.9.1

