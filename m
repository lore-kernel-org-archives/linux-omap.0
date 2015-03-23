From: <grygorii.strashko@linaro.org>
Subject: [PATCH v2 7/8] gpio: omap: get rid of omap_irq_to_gpio()
Date: Mon, 23 Mar 2015 14:18:29 +0200
Message-ID: <1427113110-20813-8-git-send-email-grygorii.strashko@linaro.org>
References: <1427113110-20813-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427113110-20813-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@linaro.org>

Now OMAP GPIO driver prepared for omap_irq_to_gpio() removing.
Do it ;)

Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 drivers/gpio/gpio-omap.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index dd7934a..615e950 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -89,11 +89,6 @@ struct gpio_bank {
 
 static void omap_gpio_unmask_irq(struct irq_data *d);
 
-static int omap_irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
-{
-	return bank->chip.base + gpio_irq;
-}
-
 static inline struct gpio_bank *omap_irq_data_get_bank(struct irq_data *d)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
@@ -490,22 +485,21 @@ static void omap_gpio_init_irq(struct gpio_bank *bank, unsigned offset)
 static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
-	unsigned gpio = 0;
 	int retval;
 	unsigned long flags;
-	unsigned offset;
+	unsigned offset = d->hwirq;
 
 	if (!BANK_USED(bank))
 		pm_runtime_get_sync(bank->dev);
 
 #ifdef CONFIG_ARCH_OMAP1
-	if (d->irq > IH_MPUIO_BASE)
+	if (d->irq > IH_MPUIO_BASE) {
+		unsigned gpio = 0;
 		gpio = OMAP_MPUIO(d->irq - IH_MPUIO_BASE);
+		offset = GPIO_INDEX(bank, gpio);
+	}
 #endif
 
-	if (!gpio)
-		gpio = omap_irq_to_gpio(bank, d->hwirq);
-
 	if (type & ~IRQ_TYPE_SENSE_MASK)
 		return -EINVAL;
 
@@ -514,7 +508,6 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 		return -EINVAL;
 
 	spin_lock_irqsave(&bank->lock, flags);
-	offset = GPIO_INDEX(bank, gpio);
 	retval = omap_set_gpio_triggering(bank, offset, type);
 	omap_gpio_init_irq(bank, offset);
 	if (!omap_gpio_is_input(bank, offset)) {
-- 
1.9.1
