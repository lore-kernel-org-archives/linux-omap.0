From: <grygorii.strashko@linaro.org>
Subject: [PATCH 4/8] gpio: omap: drop 'gpio' param from omap_gpio_init_irq()
Date: Thu, 19 Mar 2015 19:25:40 +0200
Message-ID: <1426785944-17255-5-git-send-email-grygorii.strashko@linaro.org>
References: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@linaro.org>

The 'gpio' parameter isn't needed any more as it
duplicates 'offset' parameter, so drop it.

Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 drivers/gpio/gpio-omap.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 2df693b..ff5d54d 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -479,14 +479,13 @@ static int omap_gpio_is_input(struct gpio_bank *bank, unsigned offset)
 	return readl_relaxed(reg) & BIT(offset);
 }
 
-static void omap_gpio_init_irq(struct gpio_bank *bank, unsigned gpio,
-			       unsigned offset)
+static void omap_gpio_init_irq(struct gpio_bank *bank, unsigned offset)
 {
 	if (!LINE_USED(bank->mod_usage, offset)) {
 		omap_enable_gpio_module(bank, offset);
 		omap_set_gpio_direction(bank, offset, 1);
 	}
-	bank->irq_usage |= BIT(GPIO_INDEX(bank, gpio));
+	bank->irq_usage |= BIT(offset);
 }
 
 static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
@@ -518,7 +517,7 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 	spin_lock_irqsave(&bank->lock, flags);
 	offset = GPIO_INDEX(bank, gpio);
 	retval = omap_set_gpio_triggering(bank, offset, type);
-	omap_gpio_init_irq(bank, gpio, offset);
+	omap_gpio_init_irq(bank, offset);
 	if (!omap_gpio_is_input(bank, offset)) {
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return -EINVAL;
@@ -803,15 +802,14 @@ exit:
 static unsigned int omap_gpio_irq_startup(struct irq_data *d)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
-	unsigned int gpio = omap_irq_to_gpio(bank, d->hwirq);
 	unsigned long flags;
-	unsigned offset = GPIO_INDEX(bank, gpio);
+	unsigned offset = d->hwirq;
 
 	if (!BANK_USED(bank))
 		pm_runtime_get_sync(bank->dev);
 
 	spin_lock_irqsave(&bank->lock, flags);
-	omap_gpio_init_irq(bank, gpio, offset);
+	omap_gpio_init_irq(bank, offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
 	omap_gpio_unmask_irq(d);
 
-- 
1.9.1

